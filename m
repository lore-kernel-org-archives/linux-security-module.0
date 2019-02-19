Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10DDC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8721421738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfBSQcU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:32:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfBSQcU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:32:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3861AB40B;
        Tue, 19 Feb 2019 16:32:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61F1F5D970;
        Tue, 19 Feb 2019 16:32:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/43] cgroup: take options parsing into ->parse_monolithic()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:32:13 +0000
Message-ID: <155059393356.12449.12233243314907537336.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Feb 2019 16:32:17 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Store the results in cgroup_fs_context.  There's a nasty twist caused
by the enabling/disabling subsystems - we can't do the checks sensitive
to that until cgroup_mutex gets grabbed.  Frankly, these checks are
complete bullshit (e.g. all,none combination is accepted if all subsystems
are disabled; so's cpusets,none and all,cpusets when cpusets is disabled,
etc.), but touching that would be a userland-visible behaviour change ;-/

So we do parsing in ->parse_monolithic() and have the consistency checks
done in check_cgroupfs_options(), with the latter called (on already parsed
options) from cgroup1_get_tree() and cgroup1_reconfigure().

Freeing the strdup'ed strings is done from fs_context destructor, which
somewhat simplifies the life for cgroup1_{get_tree,reconfigure}().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup-internal.h |   23 +++---
 kernel/cgroup/cgroup-v1.c       |  143 ++++++++++++++++++---------------------
 kernel/cgroup/cgroup.c          |   54 +++++++--------
 3 files changed, 104 insertions(+), 116 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 37836d598ff8..e627ff193dba 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -41,7 +41,15 @@ extern void __init enable_debug_cgroup(void);
  * The cgroup filesystem superblock creation/mount context.
  */
 struct cgroup_fs_context {
-	char *data;
+	unsigned int	flags;			/* CGRP_ROOT_* flags */
+
+	/* cgroup1 bits */
+	bool		cpuset_clone_children;
+	bool		none;			/* User explicitly requested empty subsystem */
+	bool		all_ss;			/* Seen 'all' option */
+	u16		subsys_mask;		/* Selected subsystems */
+	char		*name;			/* Hierarchy name */
+	char		*release_agent;		/* Path for release notifications */
 };
 
 static inline struct cgroup_fs_context *cgroup_fc2context(struct fs_context *fc)
@@ -130,16 +138,6 @@ struct cgroup_mgctx {
 #define DEFINE_CGROUP_MGCTX(name)						\
 	struct cgroup_mgctx name = CGROUP_MGCTX_INIT(name)
 
-struct cgroup_sb_opts {
-	u16 subsys_mask;
-	unsigned int flags;
-	char *release_agent;
-	bool cpuset_clone_children;
-	char *name;
-	/* User explicitly requested empty subsystem */
-	bool none;
-};
-
 extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 extern struct cgroup_subsys *cgroup_subsys[];
@@ -210,7 +208,7 @@ int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,
 			  struct cgroup_namespace *ns);
 
 void cgroup_free_root(struct cgroup_root *root);
-void init_cgroup_root(struct cgroup_root *root, struct cgroup_sb_opts *opts);
+void init_cgroup_root(struct cgroup_root *root, struct cgroup_fs_context *ctx);
 int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask);
 int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask);
 struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
@@ -266,6 +264,7 @@ void cgroup1_pidlist_destroy_all(struct cgroup *cgrp);
 void cgroup1_release_agent(struct work_struct *work);
 void cgroup1_check_for_release(struct cgroup *cgrp);
 int cgroup1_get_tree(struct fs_context *fc);
+int parse_cgroup1_options(char *data, struct cgroup_fs_context *ctx);
 int cgroup1_reconfigure(struct fs_context *ctx);
 
 #endif /* __CGROUP_INTERNAL_H */
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 7ae3810dcbdf..5c93643090e9 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -906,61 +906,47 @@ static int cgroup1_show_options(struct seq_file *seq, struct kernfs_root *kf_roo
 	return 0;
 }
 
-static int parse_cgroupfs_options(char *data, struct cgroup_sb_opts *opts)
+int parse_cgroup1_options(char *data, struct cgroup_fs_context *ctx)
 {
 	char *token, *o = data;
-	bool all_ss = false, one_ss = false;
-	u16 mask = U16_MAX;
 	struct cgroup_subsys *ss;
-	int nr_opts = 0;
 	int i;
 
-#ifdef CONFIG_CPUSETS
-	mask = ~((u16)1 << cpuset_cgrp_id);
-#endif
-
-	memset(opts, 0, sizeof(*opts));
-
 	while ((token = strsep(&o, ",")) != NULL) {
-		nr_opts++;
-
 		if (!*token)
 			return -EINVAL;
 		if (!strcmp(token, "none")) {
 			/* Explicitly have no subsystems */
-			opts->none = true;
+			ctx->none = true;
 			continue;
 		}
 		if (!strcmp(token, "all")) {
-			/* Mutually exclusive option 'all' + subsystem name */
-			if (one_ss)
-				return -EINVAL;
-			all_ss = true;
+			ctx->all_ss = true;
 			continue;
 		}
 		if (!strcmp(token, "noprefix")) {
-			opts->flags |= CGRP_ROOT_NOPREFIX;
+			ctx->flags |= CGRP_ROOT_NOPREFIX;
 			continue;
 		}
 		if (!strcmp(token, "clone_children")) {
-			opts->cpuset_clone_children = true;
+			ctx->cpuset_clone_children = true;
 			continue;
 		}
 		if (!strcmp(token, "cpuset_v2_mode")) {
-			opts->flags |= CGRP_ROOT_CPUSET_V2_MODE;
+			ctx->flags |= CGRP_ROOT_CPUSET_V2_MODE;
 			continue;
 		}
 		if (!strcmp(token, "xattr")) {
-			opts->flags |= CGRP_ROOT_XATTR;
+			ctx->flags |= CGRP_ROOT_XATTR;
 			continue;
 		}
 		if (!strncmp(token, "release_agent=", 14)) {
 			/* Specifying two release agents is forbidden */
-			if (opts->release_agent)
+			if (ctx->release_agent)
 				return -EINVAL;
-			opts->release_agent =
+			ctx->release_agent =
 				kstrndup(token + 14, PATH_MAX - 1, GFP_KERNEL);
-			if (!opts->release_agent)
+			if (!ctx->release_agent)
 				return -ENOMEM;
 			continue;
 		}
@@ -983,12 +969,12 @@ static int parse_cgroupfs_options(char *data, struct cgroup_sb_opts *opts)
 				return -EINVAL;
 			}
 			/* Specifying two names is forbidden */
-			if (opts->name)
+			if (ctx->name)
 				return -EINVAL;
-			opts->name = kstrndup(name,
+			ctx->name = kstrndup(name,
 					      MAX_CGROUP_ROOT_NAMELEN - 1,
 					      GFP_KERNEL);
-			if (!opts->name)
+			if (!ctx->name)
 				return -ENOMEM;
 
 			continue;
@@ -997,38 +983,51 @@ static int parse_cgroupfs_options(char *data, struct cgroup_sb_opts *opts)
 		for_each_subsys(ss, i) {
 			if (strcmp(token, ss->legacy_name))
 				continue;
-			if (!cgroup_ssid_enabled(i))
-				continue;
-			if (cgroup1_ssid_disabled(i))
-				continue;
-
-			/* Mutually exclusive option 'all' + subsystem name */
-			if (all_ss)
-				return -EINVAL;
-			opts->subsys_mask |= (1 << i);
-			one_ss = true;
-
+			ctx->subsys_mask |= (1 << i);
 			break;
 		}
 		if (i == CGROUP_SUBSYS_COUNT)
 			return -ENOENT;
 	}
+	return 0;
+}
+
+static int check_cgroupfs_options(struct cgroup_fs_context *ctx)
+{
+	u16 mask = U16_MAX;
+	u16 enabled = 0;
+	struct cgroup_subsys *ss;
+	int i;
+
+#ifdef CONFIG_CPUSETS
+	mask = ~((u16)1 << cpuset_cgrp_id);
+#endif
+	for_each_subsys(ss, i)
+		if (cgroup_ssid_enabled(i) && !cgroup1_ssid_disabled(i))
+			enabled |= 1 << i;
+
+	ctx->subsys_mask &= enabled;
 
 	/*
-	 * If the 'all' option was specified select all the subsystems,
-	 * otherwise if 'none', 'name=' and a subsystem name options were
-	 * not specified, let's default to 'all'
+	 * In absense of 'none', 'name=' or subsystem name options,
+	 * let's default to 'all'.
 	 */
-	if (all_ss || (!one_ss && !opts->none && !opts->name))
-		for_each_subsys(ss, i)
-			if (cgroup_ssid_enabled(i) && !cgroup1_ssid_disabled(i))
-				opts->subsys_mask |= (1 << i);
+	if (!ctx->subsys_mask && !ctx->none && !ctx->name)
+		ctx->all_ss = true;
+
+	if (ctx->all_ss) {
+		/* Mutually exclusive option 'all' + subsystem name */
+		if (ctx->subsys_mask)
+			return -EINVAL;
+		/* 'all' => select all the subsystems */
+		ctx->subsys_mask = enabled;
+	}
 
 	/*
 	 * We either have to specify by name or by subsystems. (So all
 	 * empty hierarchies must have a name).
 	 */
-	if (!opts->subsys_mask && !opts->name)
+	if (!ctx->subsys_mask && !ctx->name)
 		return -EINVAL;
 
 	/*
@@ -1036,11 +1035,11 @@ static int parse_cgroupfs_options(char *data, struct cgroup_sb_opts *opts)
 	 * with the old cpuset, so we allow noprefix only if mounting just
 	 * the cpuset subsystem.
 	 */
-	if ((opts->flags & CGRP_ROOT_NOPREFIX) && (opts->subsys_mask & mask))
+	if ((ctx->flags & CGRP_ROOT_NOPREFIX) && (ctx->subsys_mask & mask))
 		return -EINVAL;
 
 	/* Can't specify "none" and some subsystems */
-	if (opts->subsys_mask && opts->none)
+	if (ctx->subsys_mask && ctx->none)
 		return -EINVAL;
 
 	return 0;
@@ -1052,28 +1051,27 @@ int cgroup1_reconfigure(struct fs_context *fc)
 	struct kernfs_root *kf_root = kernfs_root_from_sb(fc->root->d_sb);
 	struct cgroup_root *root = cgroup_root_from_kf(kf_root);
 	int ret = 0;
-	struct cgroup_sb_opts opts;
 	u16 added_mask, removed_mask;
 
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
 	/* See what subsystems are wanted */
-	ret = parse_cgroupfs_options(ctx->data, &opts);
+	ret = check_cgroupfs_options(ctx);
 	if (ret)
 		goto out_unlock;
 
-	if (opts.subsys_mask != root->subsys_mask || opts.release_agent)
+	if (ctx->subsys_mask != root->subsys_mask || ctx->release_agent)
 		pr_warn("option changes via remount are deprecated (pid=%d comm=%s)\n",
 			task_tgid_nr(current), current->comm);
 
-	added_mask = opts.subsys_mask & ~root->subsys_mask;
-	removed_mask = root->subsys_mask & ~opts.subsys_mask;
+	added_mask = ctx->subsys_mask & ~root->subsys_mask;
+	removed_mask = root->subsys_mask & ~ctx->subsys_mask;
 
 	/* Don't allow flags or name to change at remount */
-	if ((opts.flags ^ root->flags) ||
-	    (opts.name && strcmp(opts.name, root->name))) {
+	if ((ctx->flags ^ root->flags) ||
+	    (ctx->name && strcmp(ctx->name, root->name))) {
 		pr_err("option or name mismatch, new: 0x%x \"%s\", old: 0x%x \"%s\"\n",
-		       opts.flags, opts.name ?: "", root->flags, root->name);
+		       ctx->flags, ctx->name ?: "", root->flags, root->name);
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -1090,17 +1088,15 @@ int cgroup1_reconfigure(struct fs_context *fc)
 
 	WARN_ON(rebind_subsystems(&cgrp_dfl_root, removed_mask));
 
-	if (opts.release_agent) {
+	if (ctx->release_agent) {
 		spin_lock(&release_agent_path_lock);
-		strcpy(root->release_agent_path, opts.release_agent);
+		strcpy(root->release_agent_path, ctx->release_agent);
 		spin_unlock(&release_agent_path_lock);
 	}
 
 	trace_cgroup_remount(root);
 
  out_unlock:
-	kfree(opts.release_agent);
-	kfree(opts.name);
 	mutex_unlock(&cgroup_mutex);
 	return ret;
 }
@@ -1117,7 +1113,6 @@ int cgroup1_get_tree(struct fs_context *fc)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
-	struct cgroup_sb_opts opts;
 	struct cgroup_root *root;
 	struct cgroup_subsys *ss;
 	struct dentry *dentry;
@@ -1130,7 +1125,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
 	/* First find the desired set of subsystems */
-	ret = parse_cgroupfs_options(ctx->data, &opts);
+	ret = check_cgroupfs_options(ctx);
 	if (ret)
 		goto out_unlock;
 
@@ -1142,7 +1137,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	 * starting.  Testing ref liveliness is good enough.
 	 */
 	for_each_subsys(ss, i) {
-		if (!(opts.subsys_mask & (1 << i)) ||
+		if (!(ctx->subsys_mask & (1 << i)) ||
 		    ss->root == &cgrp_dfl_root)
 			continue;
 
@@ -1166,8 +1161,8 @@ int cgroup1_get_tree(struct fs_context *fc)
 		 * name matches but sybsys_mask doesn't, we should fail.
 		 * Remember whether name matched.
 		 */
-		if (opts.name) {
-			if (strcmp(opts.name, root->name))
+		if (ctx->name) {
+			if (strcmp(ctx->name, root->name))
 				continue;
 			name_match = true;
 		}
@@ -1176,15 +1171,15 @@ int cgroup1_get_tree(struct fs_context *fc)
 		 * If we asked for subsystems (or explicitly for no
 		 * subsystems) then they must match.
 		 */
-		if ((opts.subsys_mask || opts.none) &&
-		    (opts.subsys_mask != root->subsys_mask)) {
+		if ((ctx->subsys_mask || ctx->none) &&
+		    (ctx->subsys_mask != root->subsys_mask)) {
 			if (!name_match)
 				continue;
 			ret = -EBUSY;
 			goto out_unlock;
 		}
 
-		if (root->flags ^ opts.flags)
+		if (root->flags ^ ctx->flags)
 			pr_warn("new mount options do not match the existing superblock, will be ignored\n");
 
 		ret = 0;
@@ -1196,7 +1191,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	 * specification is allowed for already existing hierarchies but we
 	 * can't create new one without subsys specification.
 	 */
-	if (!opts.subsys_mask && !opts.none) {
+	if (!ctx->subsys_mask && !ctx->none) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -1213,9 +1208,9 @@ int cgroup1_get_tree(struct fs_context *fc)
 		goto out_unlock;
 	}
 
-	init_cgroup_root(root, &opts);
+	init_cgroup_root(root, ctx);
 
-	ret = cgroup_setup_root(root, opts.subsys_mask);
+	ret = cgroup_setup_root(root, ctx->subsys_mask);
 	if (ret)
 		cgroup_free_root(root);
 
@@ -1223,14 +1218,10 @@ int cgroup1_get_tree(struct fs_context *fc)
 	if (!ret && !percpu_ref_tryget_live(&root->cgrp.self.refcnt)) {
 		mutex_unlock(&cgroup_mutex);
 		msleep(10);
-		ret = restart_syscall();
-		goto out_free;
+		return restart_syscall();
 	}
 	mutex_unlock(&cgroup_mutex);
 out_free:
-	kfree(opts.release_agent);
-	kfree(opts.name);
-
 	if (ret)
 		return ret;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 0652f74064a2..33da9eef3ef4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1814,14 +1814,8 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
 static int cgroup_reconfigure(struct fs_context *fc)
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
-	unsigned int root_flags;
-	int ret;
-
-	ret = parse_cgroup_root_flags(ctx->data, &root_flags);
-	if (ret)
-		return ret;
 
-	apply_cgroup_root_flags(root_flags);
+	apply_cgroup_root_flags(ctx->flags);
 	return 0;
 }
 
@@ -1909,7 +1903,7 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
 }
 
-void init_cgroup_root(struct cgroup_root *root, struct cgroup_sb_opts *opts)
+void init_cgroup_root(struct cgroup_root *root, struct cgroup_fs_context *ctx)
 {
 	struct cgroup *cgrp = &root->cgrp;
 
@@ -1919,12 +1913,12 @@ void init_cgroup_root(struct cgroup_root *root, struct cgroup_sb_opts *opts)
 	init_cgroup_housekeeping(cgrp);
 	idr_init(&root->cgroup_idr);
 
-	root->flags = opts->flags;
-	if (opts->release_agent)
-		strscpy(root->release_agent_path, opts->release_agent, PATH_MAX);
-	if (opts->name)
-		strscpy(root->name, opts->name, MAX_CGROUP_ROOT_NAMELEN);
-	if (opts->cpuset_clone_children)
+	root->flags = ctx->flags;
+	if (ctx->release_agent)
+		strscpy(root->release_agent_path, ctx->release_agent, PATH_MAX);
+	if (ctx->name)
+		strscpy(root->name, ctx->name, MAX_CGROUP_ROOT_NAMELEN);
+	if (ctx->cpuset_clone_children)
 		set_bit(CGRP_CPUSET_CLONE_CHILDREN, &root->cgrp.flags);
 }
 
@@ -2075,6 +2069,8 @@ static void cgroup_fs_context_free(struct fs_context *fc)
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 
+	kfree(ctx->name);
+	kfree(ctx->release_agent);
 	kfree(ctx);
 }
 
@@ -2082,28 +2078,30 @@ static int cgroup_parse_monolithic(struct fs_context *fc, void *data)
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 
-	ctx->data = data;
-	if (ctx->data)
-		security_sb_eat_lsm_opts(ctx->data, &fc->security);
-	return 0;
+	if (data)
+		security_sb_eat_lsm_opts(data, &fc->security);
+	return parse_cgroup_root_flags(data, &ctx->flags);
+}
+
+static int cgroup1_parse_monolithic(struct fs_context *fc, void *data)
+{
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+
+	if (data)
+		security_sb_eat_lsm_opts(data, &fc->security);
+	return parse_cgroup1_options(data, ctx);
 }
 
 static int cgroup_get_tree(struct fs_context *fc)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
-	unsigned int root_flags;
 	struct dentry *root;
-	int ret;
 
 	/* Check if the caller has permission to mount. */
 	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ret = parse_cgroup_root_flags(ctx->data, &root_flags);
-	if (ret)
-		return ret;
-
 	cgrp_dfl_visible = true;
 	cgroup_get_live(&cgrp_dfl_root.cgrp);
 
@@ -2112,7 +2110,7 @@ static int cgroup_get_tree(struct fs_context *fc)
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 
-	apply_cgroup_root_flags(root_flags);
+	apply_cgroup_root_flags(ctx->flags);
 	fc->root = root;
 	return 0;
 }
@@ -2126,7 +2124,7 @@ static const struct fs_context_operations cgroup_fs_context_ops = {
 
 static const struct fs_context_operations cgroup1_fs_context_ops = {
 	.free		= cgroup_fs_context_free,
-	.parse_monolithic = cgroup_parse_monolithic,
+	.parse_monolithic = cgroup1_parse_monolithic,
 	.get_tree	= cgroup1_get_tree,
 	.reconfigure	= cgroup1_reconfigure,
 };
@@ -5376,11 +5374,11 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
  */
 int __init cgroup_init_early(void)
 {
-	static struct cgroup_sb_opts __initdata opts;
+	static struct cgroup_fs_context __initdata ctx;
 	struct cgroup_subsys *ss;
 	int i;
 
-	init_cgroup_root(&cgrp_dfl_root, &opts);
+	init_cgroup_root(&cgrp_dfl_root, &ctx);
 	cgrp_dfl_root.cgrp.self.flags |= CSS_NO_REF;
 
 	RCU_INIT_POINTER(init_task.cgroups, &init_css_set);

