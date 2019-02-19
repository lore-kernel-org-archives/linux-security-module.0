Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C56C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3018821738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfBSQcA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:32:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfBSQcA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:32:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 945D08635;
        Tue, 19 Feb 2019 16:31:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB035D6AA;
        Tue, 19 Feb 2019 16:31:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 26/43] cgroup: start switching to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:31:57 +0000
Message-ID: <155059391757.12449.10589286664392696344.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 19 Feb 2019 16:31:59 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Unfortunately, cgroup is tangled into kernfs infrastructure.
To avoid converting all kernfs-based filesystems at once,
we need to untangle the remount part of things, instead of
having it go through kernfs_sop_remount_fs().  Fortunately,
it's not hard to do.

This commit just gets cgroup/cgroup1 to use fs_context to
deliver options on mount and remount paths.  Parsing those
is going to be done in the next commits; for now we do
pretty much what legacy case does.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup-internal.h |   14 ++++
 kernel/cgroup/cgroup-v1.c       |    9 +--
 kernel/cgroup/cgroup.c          |  134 ++++++++++++++++++++++++++++-----------
 3 files changed, 116 insertions(+), 41 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c9a35f09e4b9..a89cb0ba7a68 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -7,6 +7,7 @@
 #include <linux/workqueue.h>
 #include <linux/list.h>
 #include <linux/refcount.h>
+#include <linux/fs_context.h>
 
 #define TRACE_CGROUP_PATH_LEN 1024
 extern spinlock_t trace_cgroup_path_lock;
@@ -36,6 +37,18 @@ extern void __init enable_debug_cgroup(void);
 		}							\
 	} while (0)
 
+/*
+ * The cgroup filesystem superblock creation/mount context.
+ */
+struct cgroup_fs_context {
+	char *data;
+};
+
+static inline struct cgroup_fs_context *cgroup_fc2context(struct fs_context *fc)
+{
+	return fc->fs_private;
+}
+
 /*
  * A cgroup can be associated with multiple css_sets as different tasks may
  * belong to different cgroups on different hierarchies.  In the other
@@ -255,5 +268,6 @@ void cgroup1_check_for_release(struct cgroup *cgrp);
 struct dentry *cgroup1_mount(struct file_system_type *fs_type, int flags,
 			     void *data, unsigned long magic,
 			     struct cgroup_namespace *ns);
+int cgroup1_reconfigure(struct fs_context *ctx);
 
 #endif /* __CGROUP_INTERNAL_H */
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index f94a7229974e..e377e19dd3e6 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1046,17 +1046,19 @@ static int parse_cgroupfs_options(char *data, struct cgroup_sb_opts *opts)
 	return 0;
 }
 
-static int cgroup1_remount(struct kernfs_root *kf_root, int *flags, char *data)
+int cgroup1_reconfigure(struct fs_context *fc)
 {
-	int ret = 0;
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+	struct kernfs_root *kf_root = kernfs_root_from_sb(fc->root->d_sb);
 	struct cgroup_root *root = cgroup_root_from_kf(kf_root);
+	int ret = 0;
 	struct cgroup_sb_opts opts;
 	u16 added_mask, removed_mask;
 
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
 	/* See what subsystems are wanted */
-	ret = parse_cgroupfs_options(data, &opts);
+	ret = parse_cgroupfs_options(ctx->data, &opts);
 	if (ret)
 		goto out_unlock;
 
@@ -1106,7 +1108,6 @@ static int cgroup1_remount(struct kernfs_root *kf_root, int *flags, char *data)
 struct kernfs_syscall_ops cgroup1_kf_syscall_ops = {
 	.rename			= cgroup1_rename,
 	.show_options		= cgroup1_show_options,
-	.remount_fs		= cgroup1_remount,
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
 	.show_path		= cgroup_show_path,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7fd9f22e406d..7f7db5f967e3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1811,12 +1811,13 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
 	return 0;
 }
 
-static int cgroup_remount(struct kernfs_root *kf_root, int *flags, char *data)
+static int cgroup_reconfigure(struct fs_context *fc)
 {
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	unsigned int root_flags;
 	int ret;
 
-	ret = parse_cgroup_root_flags(data, &root_flags);
+	ret = parse_cgroup_root_flags(ctx->data, &root_flags);
 	if (ret)
 		return ret;
 
@@ -2067,21 +2068,98 @@ struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
 	return dentry;
 }
 
-static struct dentry *cgroup_mount(struct file_system_type *fs_type,
-			 int flags, const char *unused_dev_name,
-			 void *data)
+/*
+ * Destroy a cgroup filesystem context.
+ */
+static void cgroup_fs_context_free(struct fs_context *fc)
+{
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+
+	kfree(ctx);
+}
+
+static int cgroup_parse_monolithic(struct fs_context *fc, void *data)
+{
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+
+	ctx->data = data;
+	if (ctx->data)
+		security_sb_eat_lsm_opts(ctx->data, &fc->security);
+	return 0;
+}
+
+static int cgroup_get_tree(struct fs_context *fc)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
-	struct dentry *dentry;
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+	unsigned int root_flags;
+	struct dentry *root;
 	int ret;
 
-	get_cgroup_ns(ns);
+	/* Check if the caller has permission to mount. */
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	ret = parse_cgroup_root_flags(ctx->data, &root_flags);
+	if (ret)
+		return ret;
+
+	cgrp_dfl_visible = true;
+	cgroup_get_live(&cgrp_dfl_root.cgrp);
+
+	root = cgroup_do_mount(&cgroup2_fs_type, fc->sb_flags, &cgrp_dfl_root,
+					 CGROUP2_SUPER_MAGIC, ns);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	apply_cgroup_root_flags(root_flags);
+	fc->root = root;
+	return 0;
+}
+
+static int cgroup1_get_tree(struct fs_context *fc)
+{
+	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+	struct dentry *root;
 
 	/* Check if the caller has permission to mount. */
-	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN)) {
-		put_cgroup_ns(ns);
-		return ERR_PTR(-EPERM);
-	}
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	root = cgroup1_mount(&cgroup_fs_type, fc->sb_flags, ctx->data,
+				       CGROUP_SUPER_MAGIC, ns);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	fc->root = root;
+	return 0;
+}
+
+static const struct fs_context_operations cgroup_fs_context_ops = {
+	.free		= cgroup_fs_context_free,
+	.parse_monolithic = cgroup_parse_monolithic,
+	.get_tree	= cgroup_get_tree,
+	.reconfigure	= cgroup_reconfigure,
+};
+
+static const struct fs_context_operations cgroup1_fs_context_ops = {
+	.free		= cgroup_fs_context_free,
+	.parse_monolithic = cgroup_parse_monolithic,
+	.get_tree	= cgroup1_get_tree,
+	.reconfigure	= cgroup1_reconfigure,
+};
+
+/*
+ * Initialise the cgroup filesystem creation/reconfiguration context.
+ */
+static int cgroup_init_fs_context(struct fs_context *fc)
+{
+	struct cgroup_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct cgroup_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
 
 	/*
 	 * The first time anyone tries to mount a cgroup, enable the list
@@ -2090,29 +2168,12 @@ static struct dentry *cgroup_mount(struct file_system_type *fs_type,
 	if (!use_task_css_set_links)
 		cgroup_enable_task_cg_lists();
 
-	if (fs_type == &cgroup2_fs_type) {
-		unsigned int root_flags;
-
-		ret = parse_cgroup_root_flags(data, &root_flags);
-		if (ret) {
-			put_cgroup_ns(ns);
-			return ERR_PTR(ret);
-		}
-
-		cgrp_dfl_visible = true;
-		cgroup_get_live(&cgrp_dfl_root.cgrp);
-
-		dentry = cgroup_do_mount(&cgroup2_fs_type, flags, &cgrp_dfl_root,
-					 CGROUP2_SUPER_MAGIC, ns);
-		if (!IS_ERR(dentry))
-			apply_cgroup_root_flags(root_flags);
-	} else {
-		dentry = cgroup1_mount(&cgroup_fs_type, flags, data,
-				       CGROUP_SUPER_MAGIC, ns);
-	}
-
-	put_cgroup_ns(ns);
-	return dentry;
+	fc->fs_private = ctx;
+	if (fc->fs_type == &cgroup2_fs_type)
+		fc->ops = &cgroup_fs_context_ops;
+	else
+		fc->ops = &cgroup1_fs_context_ops;
+	return 0;
 }
 
 static void cgroup_kill_sb(struct super_block *sb)
@@ -2136,14 +2197,14 @@ static void cgroup_kill_sb(struct super_block *sb)
 
 struct file_system_type cgroup_fs_type = {
 	.name = "cgroup",
-	.mount = cgroup_mount,
+	.init_fs_context = cgroup_init_fs_context,
 	.kill_sb = cgroup_kill_sb,
 	.fs_flags = FS_USERNS_MOUNT,
 };
 
 static struct file_system_type cgroup2_fs_type = {
 	.name = "cgroup2",
-	.mount = cgroup_mount,
+	.init_fs_context = cgroup_init_fs_context,
 	.kill_sb = cgroup_kill_sb,
 	.fs_flags = FS_USERNS_MOUNT,
 };
@@ -5268,7 +5329,6 @@ int cgroup_rmdir(struct kernfs_node *kn)
 
 static struct kernfs_syscall_ops cgroup_kf_syscall_ops = {
 	.show_options		= cgroup_show_options,
-	.remount_fs		= cgroup_remount,
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
 	.show_path		= cgroup_show_path,

