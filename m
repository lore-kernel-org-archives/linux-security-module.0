Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00746C10F00
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53D8217D9
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfBSQc2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:32:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfBSQcZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:32:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34FF38762E;
        Tue, 19 Feb 2019 16:32:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A993519C56;
        Tue, 19 Feb 2019 16:32:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 29/43] cgroup1: switch to option-by-option parsing
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:32:22 +0000
Message-ID: <155059394294.12449.7694352641084869686.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 19 Feb 2019 16:32:25 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

[dhowells should be the author - it's carved out of his patch]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup-internal.h |    3 -
 kernel/cgroup/cgroup-v1.c       |  192 ++++++++++++++++++++++-----------------
 kernel/cgroup/cgroup.c          |   20 +---
 3 files changed, 117 insertions(+), 98 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index e627ff193dba..a7b5a41f170c 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -257,14 +257,15 @@ extern const struct proc_ns_operations cgroupns_operations;
  */
 extern struct cftype cgroup1_base_files[];
 extern struct kernfs_syscall_ops cgroup1_kf_syscall_ops;
+extern const struct fs_parameter_description cgroup1_fs_parameters;
 
 int proc_cgroupstats_show(struct seq_file *m, void *v);
 bool cgroup1_ssid_disabled(int ssid);
 void cgroup1_pidlist_destroy_all(struct cgroup *cgrp);
 void cgroup1_release_agent(struct work_struct *work);
 void cgroup1_check_for_release(struct cgroup *cgrp);
+int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param);
 int cgroup1_get_tree(struct fs_context *fc);
-int parse_cgroup1_options(char *data, struct cgroup_fs_context *ctx);
 int cgroup1_reconfigure(struct fs_context *ctx);
 
 #endif /* __CGROUP_INTERNAL_H */
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 5c93643090e9..725e9f6fe80d 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -13,9 +13,12 @@
 #include <linux/delayacct.h>
 #include <linux/pid_namespace.h>
 #include <linux/cgroupstats.h>
+#include <linux/fs_parser.h>
 
 #include <trace/events/cgroup.h>
 
+#define cg_invalf(fc, fmt, ...) ({ pr_err(fmt, ## __VA_ARGS__); -EINVAL; })
+
 /*
  * pidlists linger the following amount before being destroyed.  The goal
  * is avoiding frequent destruction in the middle of consecutive read calls
@@ -906,94 +909,117 @@ static int cgroup1_show_options(struct seq_file *seq, struct kernfs_root *kf_roo
 	return 0;
 }
 
-int parse_cgroup1_options(char *data, struct cgroup_fs_context *ctx)
-{
-	char *token, *o = data;
-	struct cgroup_subsys *ss;
-	int i;
+enum cgroup1_param {
+	Opt_all,
+	Opt_clone_children,
+	Opt_cpuset_v2_mode,
+	Opt_name,
+	Opt_none,
+	Opt_noprefix,
+	Opt_release_agent,
+	Opt_xattr,
+};
 
-	while ((token = strsep(&o, ",")) != NULL) {
-		if (!*token)
-			return -EINVAL;
-		if (!strcmp(token, "none")) {
-			/* Explicitly have no subsystems */
-			ctx->none = true;
-			continue;
-		}
-		if (!strcmp(token, "all")) {
-			ctx->all_ss = true;
-			continue;
-		}
-		if (!strcmp(token, "noprefix")) {
-			ctx->flags |= CGRP_ROOT_NOPREFIX;
-			continue;
-		}
-		if (!strcmp(token, "clone_children")) {
-			ctx->cpuset_clone_children = true;
-			continue;
-		}
-		if (!strcmp(token, "cpuset_v2_mode")) {
-			ctx->flags |= CGRP_ROOT_CPUSET_V2_MODE;
-			continue;
-		}
-		if (!strcmp(token, "xattr")) {
-			ctx->flags |= CGRP_ROOT_XATTR;
-			continue;
-		}
-		if (!strncmp(token, "release_agent=", 14)) {
-			/* Specifying two release agents is forbidden */
-			if (ctx->release_agent)
-				return -EINVAL;
-			ctx->release_agent =
-				kstrndup(token + 14, PATH_MAX - 1, GFP_KERNEL);
-			if (!ctx->release_agent)
-				return -ENOMEM;
-			continue;
-		}
-		if (!strncmp(token, "name=", 5)) {
-			const char *name = token + 5;
-
-			/* blocked by boot param? */
-			if (cgroup_no_v1_named)
-				return -ENOENT;
-			/* Can't specify an empty name */
-			if (!strlen(name))
-				return -EINVAL;
-			/* Must match [\w.-]+ */
-			for (i = 0; i < strlen(name); i++) {
-				char c = name[i];
-				if (isalnum(c))
-					continue;
-				if ((c == '.') || (c == '-') || (c == '_'))
-					continue;
-				return -EINVAL;
-			}
-			/* Specifying two names is forbidden */
-			if (ctx->name)
-				return -EINVAL;
-			ctx->name = kstrndup(name,
-					      MAX_CGROUP_ROOT_NAMELEN - 1,
-					      GFP_KERNEL);
-			if (!ctx->name)
-				return -ENOMEM;
+static const struct fs_parameter_spec cgroup1_param_specs[] = {
+	fsparam_flag  ("all",		Opt_all),
+	fsparam_flag  ("clone_children", Opt_clone_children),
+	fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
+	fsparam_string("name",		Opt_name),
+	fsparam_flag  ("none",		Opt_none),
+	fsparam_flag  ("noprefix",	Opt_noprefix),
+	fsparam_string("release_agent",	Opt_release_agent),
+	fsparam_flag  ("xattr",		Opt_xattr),
+	{}
+};
 
-			continue;
-		}
+const struct fs_parameter_description cgroup1_fs_parameters = {
+	.name		= "cgroup1",
+	.specs		= cgroup1_param_specs,
+};
 
+int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+	struct cgroup_subsys *ss;
+	struct fs_parse_result result;
+	int opt, i;
+
+	opt = fs_parse(fc, &cgroup1_fs_parameters, param, &result);
+	if (opt == -ENOPARAM) {
+		if (strcmp(param->key, "source") == 0) {
+			fc->source = param->string;
+			param->string = NULL;
+			return 0;
+		}
 		for_each_subsys(ss, i) {
-			if (strcmp(token, ss->legacy_name))
+			if (strcmp(param->key, ss->legacy_name))
 				continue;
 			ctx->subsys_mask |= (1 << i);
-			break;
+			return 0;
 		}
-		if (i == CGROUP_SUBSYS_COUNT)
+		return cg_invalf(fc, "cgroup1: Unknown subsys name '%s'", param->key);
+	}
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_none:
+		/* Explicitly have no subsystems */
+		ctx->none = true;
+		break;
+	case Opt_all:
+		ctx->all_ss = true;
+		break;
+	case Opt_noprefix:
+		ctx->flags |= CGRP_ROOT_NOPREFIX;
+		break;
+	case Opt_clone_children:
+		ctx->cpuset_clone_children = true;
+		break;
+	case Opt_cpuset_v2_mode:
+		ctx->flags |= CGRP_ROOT_CPUSET_V2_MODE;
+		break;
+	case Opt_xattr:
+		ctx->flags |= CGRP_ROOT_XATTR;
+		break;
+	case Opt_release_agent:
+		/* Specifying two release agents is forbidden */
+		if (ctx->release_agent)
+			return cg_invalf(fc, "cgroup1: release_agent respecified");
+		ctx->release_agent = param->string;
+		param->string = NULL;
+		break;
+	case Opt_name:
+		/* blocked by boot param? */
+		if (cgroup_no_v1_named)
 			return -ENOENT;
+		/* Can't specify an empty name */
+		if (!param->size)
+			return cg_invalf(fc, "cgroup1: Empty name");
+		if (param->size > MAX_CGROUP_ROOT_NAMELEN - 1)
+			return cg_invalf(fc, "cgroup1: Name too long");
+		/* Must match [\w.-]+ */
+		for (i = 0; i < param->size; i++) {
+			char c = param->string[i];
+			if (isalnum(c))
+				continue;
+			if ((c == '.') || (c == '-') || (c == '_'))
+				continue;
+			return cg_invalf(fc, "cgroup1: Invalid name");
+		}
+		/* Specifying two names is forbidden */
+		if (ctx->name)
+			return cg_invalf(fc, "cgroup1: name respecified");
+		ctx->name = param->string;
+		param->string = NULL;
+		break;
 	}
 	return 0;
 }
 
-static int check_cgroupfs_options(struct cgroup_fs_context *ctx)
+static int check_cgroupfs_options(struct fs_context *fc)
 {
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	u16 mask = U16_MAX;
 	u16 enabled = 0;
 	struct cgroup_subsys *ss;
@@ -1018,7 +1044,7 @@ static int check_cgroupfs_options(struct cgroup_fs_context *ctx)
 	if (ctx->all_ss) {
 		/* Mutually exclusive option 'all' + subsystem name */
 		if (ctx->subsys_mask)
-			return -EINVAL;
+			return cg_invalf(fc, "cgroup1: subsys name conflicts with all");
 		/* 'all' => select all the subsystems */
 		ctx->subsys_mask = enabled;
 	}
@@ -1028,7 +1054,7 @@ static int check_cgroupfs_options(struct cgroup_fs_context *ctx)
 	 * empty hierarchies must have a name).
 	 */
 	if (!ctx->subsys_mask && !ctx->name)
-		return -EINVAL;
+		return cg_invalf(fc, "cgroup1: Need name or subsystem set");
 
 	/*
 	 * Option noprefix was introduced just for backward compatibility
@@ -1036,11 +1062,11 @@ static int check_cgroupfs_options(struct cgroup_fs_context *ctx)
 	 * the cpuset subsystem.
 	 */
 	if ((ctx->flags & CGRP_ROOT_NOPREFIX) && (ctx->subsys_mask & mask))
-		return -EINVAL;
+		return cg_invalf(fc, "cgroup1: noprefix used incorrectly");
 
 	/* Can't specify "none" and some subsystems */
 	if (ctx->subsys_mask && ctx->none)
-		return -EINVAL;
+		return cg_invalf(fc, "cgroup1: none used incorrectly");
 
 	return 0;
 }
@@ -1056,7 +1082,7 @@ int cgroup1_reconfigure(struct fs_context *fc)
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
 	/* See what subsystems are wanted */
-	ret = check_cgroupfs_options(ctx);
+	ret = check_cgroupfs_options(fc);
 	if (ret)
 		goto out_unlock;
 
@@ -1070,7 +1096,7 @@ int cgroup1_reconfigure(struct fs_context *fc)
 	/* Don't allow flags or name to change at remount */
 	if ((ctx->flags ^ root->flags) ||
 	    (ctx->name && strcmp(ctx->name, root->name))) {
-		pr_err("option or name mismatch, new: 0x%x \"%s\", old: 0x%x \"%s\"\n",
+		cg_invalf(fc, "option or name mismatch, new: 0x%x \"%s\", old: 0x%x \"%s\"",
 		       ctx->flags, ctx->name ?: "", root->flags, root->name);
 		ret = -EINVAL;
 		goto out_unlock;
@@ -1125,7 +1151,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
 	/* First find the desired set of subsystems */
-	ret = check_cgroupfs_options(ctx);
+	ret = check_cgroupfs_options(fc);
 	if (ret)
 		goto out_unlock;
 
@@ -1192,7 +1218,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	 * can't create new one without subsys specification.
 	 */
 	if (!ctx->subsys_mask && !ctx->none) {
-		ret = -EINVAL;
+		ret = cg_invalf(fc, "cgroup1: No subsys list or none specified");
 		goto out_unlock;
 	}
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 33da9eef3ef4..faba00caa197 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2083,15 +2083,6 @@ static int cgroup_parse_monolithic(struct fs_context *fc, void *data)
 	return parse_cgroup_root_flags(data, &ctx->flags);
 }
 
-static int cgroup1_parse_monolithic(struct fs_context *fc, void *data)
-{
-	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
-
-	if (data)
-		security_sb_eat_lsm_opts(data, &fc->security);
-	return parse_cgroup1_options(data, ctx);
-}
-
 static int cgroup_get_tree(struct fs_context *fc)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
@@ -2124,7 +2115,7 @@ static const struct fs_context_operations cgroup_fs_context_ops = {
 
 static const struct fs_context_operations cgroup1_fs_context_ops = {
 	.free		= cgroup_fs_context_free,
-	.parse_monolithic = cgroup1_parse_monolithic,
+	.parse_param	= cgroup1_parse_param,
 	.get_tree	= cgroup1_get_tree,
 	.reconfigure	= cgroup1_reconfigure,
 };
@@ -2175,10 +2166,11 @@ static void cgroup_kill_sb(struct super_block *sb)
 }
 
 struct file_system_type cgroup_fs_type = {
-	.name = "cgroup",
-	.init_fs_context = cgroup_init_fs_context,
-	.kill_sb = cgroup_kill_sb,
-	.fs_flags = FS_USERNS_MOUNT,
+	.name			= "cgroup",
+	.init_fs_context	= cgroup_init_fs_context,
+	.parameters		= &cgroup1_fs_parameters,
+	.kill_sb		= cgroup_kill_sb,
+	.fs_flags		= FS_USERNS_MOUNT,
 };
 
 static struct file_system_type cgroup2_fs_type = {

