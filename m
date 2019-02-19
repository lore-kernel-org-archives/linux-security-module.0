Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2375C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDCF21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfBSQcv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:32:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfBSQcv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:32:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0A59C04B956;
        Tue, 19 Feb 2019 16:32:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 622131710E;
        Tue, 19 Feb 2019 16:32:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 32/43] cgroup_do_mount(): massage calling conventions
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:32:44 +0000
Message-ID: <155059396486.12449.1117812894043256835.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 19 Feb 2019 16:32:50 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

pass it fs_context instead of fs_type/flags/root triple, have
it return int instead of dentry and make it deal with setting
fc->root.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup-internal.h |    3 +--
 kernel/cgroup/cgroup-v1.c       |   17 ++++-----------
 kernel/cgroup/cgroup.c          |   45 ++++++++++++++++++++-------------------
 3 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 3c1613a7648c..f7fd54f2973f 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -212,8 +212,7 @@ void cgroup_free_root(struct cgroup_root *root);
 void init_cgroup_root(struct cgroup_fs_context *ctx);
 int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask);
 int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask);
-struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
-			       struct cgroup_root *root, unsigned long magic,
+int cgroup_do_mount(struct fs_context *fc, unsigned long magic,
 			       struct cgroup_namespace *ns);
 
 int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 45a198c63d6e..05f05d773adf 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1141,7 +1141,6 @@ int cgroup1_get_tree(struct fs_context *fc)
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	struct cgroup_root *root;
 	struct cgroup_subsys *ss;
-	struct dentry *dentry;
 	int i, ret;
 
 	/* Check if the caller has permission to mount. */
@@ -1253,21 +1252,15 @@ int cgroup1_get_tree(struct fs_context *fc)
 	if (ret)
 		return ret;
 
-	dentry = cgroup_do_mount(&cgroup_fs_type, fc->sb_flags, root,
-				 CGROUP_SUPER_MAGIC, ns);
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
-
-	if (percpu_ref_is_dying(&root->cgrp.self.refcnt)) {
-		struct super_block *sb = dentry->d_sb;
-		dput(dentry);
+	ret = cgroup_do_mount(fc, CGROUP_SUPER_MAGIC, ns);
+	if (!ret && percpu_ref_is_dying(&root->cgrp.self.refcnt)) {
+		struct super_block *sb = fc->root->d_sb;
+		dput(fc->root);
 		deactivate_locked_super(sb);
 		msleep(10);
 		return restart_syscall();
 	}
-
-	fc->root = dentry;
-	return 0;
+	return ret;
 }
 
 static int __init cgroup1_wq_init(void)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 57f43f63363a..64360a46d4df 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2036,43 +2036,48 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	return ret;
 }
 
-struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
-			       struct cgroup_root *root, unsigned long magic,
-			       struct cgroup_namespace *ns)
+int cgroup_do_mount(struct fs_context *fc, unsigned long magic,
+		    struct cgroup_namespace *ns)
 {
-	struct dentry *dentry;
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	bool new_sb = false;
+	int ret = 0;
 
-	dentry = kernfs_mount(fs_type, flags, root->kf_root, magic, &new_sb);
+	fc->root = kernfs_mount(fc->fs_type, fc->sb_flags, ctx->root->kf_root,
+				magic, &new_sb);
+	if (IS_ERR(fc->root))
+		ret = PTR_ERR(fc->root);
 
 	/*
 	 * In non-init cgroup namespace, instead of root cgroup's dentry,
 	 * we return the dentry corresponding to the cgroupns->root_cgrp.
 	 */
-	if (!IS_ERR(dentry) && ns != &init_cgroup_ns) {
+	if (!ret && ns != &init_cgroup_ns) {
 		struct dentry *nsdentry;
-		struct super_block *sb = dentry->d_sb;
+		struct super_block *sb = fc->root->d_sb;
 		struct cgroup *cgrp;
 
 		mutex_lock(&cgroup_mutex);
 		spin_lock_irq(&css_set_lock);
 
-		cgrp = cset_cgroup_from_root(ns->root_cset, root);
+		cgrp = cset_cgroup_from_root(ns->root_cset, ctx->root);
 
 		spin_unlock_irq(&css_set_lock);
 		mutex_unlock(&cgroup_mutex);
 
 		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
-		dput(dentry);
-		if (IS_ERR(nsdentry))
+		dput(fc->root);
+		fc->root = nsdentry;
+		if (IS_ERR(nsdentry)) {
+			ret = PTR_ERR(nsdentry);
 			deactivate_locked_super(sb);
-		dentry = nsdentry;
+		}
 	}
 
 	if (!new_sb)
-		cgroup_put(&root->cgrp);
+		cgroup_put(&ctx->root->cgrp);
 
-	return dentry;
+	return ret;
 }
 
 /*
@@ -2091,7 +2096,7 @@ static int cgroup_get_tree(struct fs_context *fc)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
-	struct dentry *root;
+	int ret;
 
 	/* Check if the caller has permission to mount. */
 	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
@@ -2101,14 +2106,10 @@ static int cgroup_get_tree(struct fs_context *fc)
 	cgroup_get_live(&cgrp_dfl_root.cgrp);
 	ctx->root = &cgrp_dfl_root;
 
-	root = cgroup_do_mount(&cgroup2_fs_type, fc->sb_flags, &cgrp_dfl_root,
-					 CGROUP2_SUPER_MAGIC, ns);
-	if (IS_ERR(root))
-		return PTR_ERR(root);
-
-	apply_cgroup_root_flags(ctx->flags);
-	fc->root = root;
-	return 0;
+	ret = cgroup_do_mount(fc, CGROUP2_SUPER_MAGIC, ns);
+	if (!ret)
+		apply_cgroup_root_flags(ctx->flags);
+	return ret;
 }
 
 static const struct fs_context_operations cgroup_fs_context_ops = {

