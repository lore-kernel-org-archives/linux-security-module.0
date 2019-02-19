Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D52AC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76ED21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfBSQdA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:33:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfBSQdA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:33:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E109E85363;
        Tue, 19 Feb 2019 16:32:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D665BA67;
        Tue, 19 Feb 2019 16:32:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 33/43] cgroup1_get_tree(): separate "get cgroup_root to use"
 into a separate helper
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:32:55 +0000
Message-ID: <155059397586.12449.13952181528654229603.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 19 Feb 2019 16:33:00 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup-v1.c |   87 ++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 05f05d773adf..0d71fc98e73d 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1135,7 +1135,15 @@ struct kernfs_syscall_ops cgroup1_kf_syscall_ops = {
 	.show_path		= cgroup_show_path,
 };
 
-int cgroup1_get_tree(struct fs_context *fc)
+/*
+ * The guts of cgroup1 mount - find or create cgroup_root to use.
+ * Called with cgroup_mutex held; returns 0 on success, -E... on
+ * error and positive - in case when the candidate is busy dying.
+ * On success it stashes a reference to cgroup_root into given
+ * cgroup_fs_context; that reference is *NOT* counting towards the
+ * cgroup_root refcount.
+ */
+static int cgroup1_root_to_use(struct fs_context *fc)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
@@ -1143,16 +1151,10 @@ int cgroup1_get_tree(struct fs_context *fc)
 	struct cgroup_subsys *ss;
 	int i, ret;
 
-	/* Check if the caller has permission to mount. */
-	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
-		return -EPERM;
-
-	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
-
 	/* First find the desired set of subsystems */
 	ret = check_cgroupfs_options(fc);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/*
 	 * Destruction of cgroup root is asynchronous, so subsystems may
@@ -1166,12 +1168,8 @@ int cgroup1_get_tree(struct fs_context *fc)
 		    ss->root == &cgrp_dfl_root)
 			continue;
 
-		if (!percpu_ref_tryget_live(&ss->root->cgrp.self.refcnt)) {
-			mutex_unlock(&cgroup_mutex);
-			msleep(10);
-			ret = restart_syscall();
-			goto out_free;
-		}
+		if (!percpu_ref_tryget_live(&ss->root->cgrp.self.refcnt))
+			return 1;	/* restart */
 		cgroup_put(&ss->root->cgrp);
 	}
 
@@ -1200,16 +1198,14 @@ int cgroup1_get_tree(struct fs_context *fc)
 		    (ctx->subsys_mask != root->subsys_mask)) {
 			if (!name_match)
 				continue;
-			ret = -EBUSY;
-			goto out_unlock;
+			return -EBUSY;
 		}
 
 		if (root->flags ^ ctx->flags)
 			pr_warn("new mount options do not match the existing superblock, will be ignored\n");
 
 		ctx->root = root;
-		ret = 0;
-		goto out_unlock;
+		return 0;
 	}
 
 	/*
@@ -1217,22 +1213,16 @@ int cgroup1_get_tree(struct fs_context *fc)
 	 * specification is allowed for already existing hierarchies but we
 	 * can't create new one without subsys specification.
 	 */
-	if (!ctx->subsys_mask && !ctx->none) {
-		ret = cg_invalf(fc, "cgroup1: No subsys list or none specified");
-		goto out_unlock;
-	}
+	if (!ctx->subsys_mask && !ctx->none)
+		return cg_invalf(fc, "cgroup1: No subsys list or none specified");
 
 	/* Hierarchies may only be created in the initial cgroup namespace. */
-	if (ns != &init_cgroup_ns) {
-		ret = -EPERM;
-		goto out_unlock;
-	}
+	if (ns != &init_cgroup_ns)
+		return -EPERM;
 
 	root = kzalloc(sizeof(*root), GFP_KERNEL);
-	if (!root) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!root)
+		return -ENOMEM;
 
 	ctx->root = root;
 	init_cgroup_root(ctx);
@@ -1240,23 +1230,38 @@ int cgroup1_get_tree(struct fs_context *fc)
 	ret = cgroup_setup_root(root, ctx->subsys_mask);
 	if (ret)
 		cgroup_free_root(root);
+	return ret;
+}
+
+int cgroup1_get_tree(struct fs_context *fc)
+{
+	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
+	int ret;
+
+	/* Check if the caller has permission to mount. */
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
+
+	ret = cgroup1_root_to_use(fc);
+	if (!ret && !percpu_ref_tryget_live(&ctx->root->cgrp.self.refcnt))
+		ret = 1;	/* restart */
 
-out_unlock:
-	if (!ret && !percpu_ref_tryget_live(&root->cgrp.self.refcnt)) {
-		mutex_unlock(&cgroup_mutex);
-		msleep(10);
-		return restart_syscall();
-	}
 	mutex_unlock(&cgroup_mutex);
-out_free:
-	if (ret)
-		return ret;
 
-	ret = cgroup_do_mount(fc, CGROUP_SUPER_MAGIC, ns);
-	if (!ret && percpu_ref_is_dying(&root->cgrp.self.refcnt)) {
+	if (!ret)
+		ret = cgroup_do_mount(fc, CGROUP_SUPER_MAGIC, ns);
+
+	if (!ret && percpu_ref_is_dying(&ctx->root->cgrp.self.refcnt)) {
 		struct super_block *sb = fc->root->d_sb;
 		dput(fc->root);
 		deactivate_locked_super(sb);
+		ret = 1;
+	}
+
+	if (unlikely(ret > 0)) {
 		msleep(10);
 		return restart_syscall();
 	}

