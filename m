Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B30C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B4521738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfBSQcI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:32:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfBSQcH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:32:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 393C518B24A;
        Tue, 19 Feb 2019 16:32:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA5DF61B63;
        Tue, 19 Feb 2019 16:32:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 27/43] cgroup: fold cgroup1_mount() into cgroup1_get_tree()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:32:04 +0000
Message-ID: <155059392478.12449.4711912735370818757.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 19 Feb 2019 16:32:07 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup-internal.h |    4 +---
 kernel/cgroup/cgroup-v1.c       |   26 +++++++++++++++++---------
 kernel/cgroup/cgroup.c          |   19 -------------------
 3 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index a89cb0ba7a68..37836d598ff8 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -265,9 +265,7 @@ bool cgroup1_ssid_disabled(int ssid);
 void cgroup1_pidlist_destroy_all(struct cgroup *cgrp);
 void cgroup1_release_agent(struct work_struct *work);
 void cgroup1_check_for_release(struct cgroup *cgrp);
-struct dentry *cgroup1_mount(struct file_system_type *fs_type, int flags,
-			     void *data, unsigned long magic,
-			     struct cgroup_namespace *ns);
+int cgroup1_get_tree(struct fs_context *fc);
 int cgroup1_reconfigure(struct fs_context *ctx);
 
 #endif /* __CGROUP_INTERNAL_H */
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index e377e19dd3e6..7ae3810dcbdf 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1113,20 +1113,24 @@ struct kernfs_syscall_ops cgroup1_kf_syscall_ops = {
 	.show_path		= cgroup_show_path,
 };
 
-struct dentry *cgroup1_mount(struct file_system_type *fs_type, int flags,
-			     void *data, unsigned long magic,
-			     struct cgroup_namespace *ns)
+int cgroup1_get_tree(struct fs_context *fc)
 {
+	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
+	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	struct cgroup_sb_opts opts;
 	struct cgroup_root *root;
 	struct cgroup_subsys *ss;
 	struct dentry *dentry;
 	int i, ret;
 
+	/* Check if the caller has permission to mount. */
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
 	/* First find the desired set of subsystems */
-	ret = parse_cgroupfs_options(data, &opts);
+	ret = parse_cgroupfs_options(ctx->data, &opts);
 	if (ret)
 		goto out_unlock;
 
@@ -1228,19 +1232,23 @@ struct dentry *cgroup1_mount(struct file_system_type *fs_type, int flags,
 	kfree(opts.name);
 
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	dentry = cgroup_do_mount(&cgroup_fs_type, flags, root,
+	dentry = cgroup_do_mount(&cgroup_fs_type, fc->sb_flags, root,
 				 CGROUP_SUPER_MAGIC, ns);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
 
-	if (!IS_ERR(dentry) && percpu_ref_is_dying(&root->cgrp.self.refcnt)) {
+	if (percpu_ref_is_dying(&root->cgrp.self.refcnt)) {
 		struct super_block *sb = dentry->d_sb;
 		dput(dentry);
 		deactivate_locked_super(sb);
 		msleep(10);
-		dentry = ERR_PTR(restart_syscall());
+		return restart_syscall();
 	}
-	return dentry;
+
+	fc->root = dentry;
+	return 0;
 }
 
 static int __init cgroup1_wq_init(void)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7f7db5f967e3..0652f74064a2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2117,25 +2117,6 @@ static int cgroup_get_tree(struct fs_context *fc)
 	return 0;
 }
 
-static int cgroup1_get_tree(struct fs_context *fc)
-{
-	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
-	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
-	struct dentry *root;
-
-	/* Check if the caller has permission to mount. */
-	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
-		return -EPERM;
-
-	root = cgroup1_mount(&cgroup_fs_type, fc->sb_flags, ctx->data,
-				       CGROUP_SUPER_MAGIC, ns);
-	if (IS_ERR(root))
-		return PTR_ERR(root);
-
-	fc->root = root;
-	return 0;
-}
-
 static const struct fs_context_operations cgroup_fs_context_ops = {
 	.free		= cgroup_fs_context_free,
 	.parse_monolithic = cgroup_parse_monolithic,

