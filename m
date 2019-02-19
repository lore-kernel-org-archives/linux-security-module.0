Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E238AC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB65921738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfBSQdI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:33:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfBSQdI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:33:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A1AF53F1;
        Tue, 19 Feb 2019 16:33:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFD9D10694E6;
        Tue, 19 Feb 2019 16:33:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 34/43] cgroup: store a reference to cgroup_ns into
 cgroup_fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:33:05 +0000
Message-ID: <155059398512.12449.12782242262840297952.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 19 Feb 2019 16:33:07 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

... and trim cgroup_do_mount() arguments (renaming it to cgroup_do_get_tree())

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup-internal.h |    4 ++--
 kernel/cgroup/cgroup-v1.c       |    8 +++-----
 kernel/cgroup/cgroup.c          |   17 ++++++++++++-----
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index f7fd54f2973f..37cf709b7a0e 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -42,6 +42,7 @@ extern void __init enable_debug_cgroup(void);
  */
 struct cgroup_fs_context {
 	struct cgroup_root	*root;
+	struct cgroup_namespace	*ns;
 	unsigned int	flags;			/* CGRP_ROOT_* flags */
 
 	/* cgroup1 bits */
@@ -212,8 +213,7 @@ void cgroup_free_root(struct cgroup_root *root);
 void init_cgroup_root(struct cgroup_fs_context *ctx);
 int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask);
 int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask);
-int cgroup_do_mount(struct fs_context *fc, unsigned long magic,
-			       struct cgroup_namespace *ns);
+int cgroup_do_get_tree(struct fs_context *fc);
 
 int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp);
 void cgroup_migrate_finish(struct cgroup_mgctx *mgctx);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 0d71fc98e73d..571ef3447426 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1145,7 +1145,6 @@ struct kernfs_syscall_ops cgroup1_kf_syscall_ops = {
  */
 static int cgroup1_root_to_use(struct fs_context *fc)
 {
-	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	struct cgroup_root *root;
 	struct cgroup_subsys *ss;
@@ -1217,7 +1216,7 @@ static int cgroup1_root_to_use(struct fs_context *fc)
 		return cg_invalf(fc, "cgroup1: No subsys list or none specified");
 
 	/* Hierarchies may only be created in the initial cgroup namespace. */
-	if (ns != &init_cgroup_ns)
+	if (ctx->ns != &init_cgroup_ns)
 		return -EPERM;
 
 	root = kzalloc(sizeof(*root), GFP_KERNEL);
@@ -1235,12 +1234,11 @@ static int cgroup1_root_to_use(struct fs_context *fc)
 
 int cgroup1_get_tree(struct fs_context *fc)
 {
-	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	int ret;
 
 	/* Check if the caller has permission to mount. */
-	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+	if (!ns_capable(ctx->ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
@@ -1252,7 +1250,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	mutex_unlock(&cgroup_mutex);
 
 	if (!ret)
-		ret = cgroup_do_mount(fc, CGROUP_SUPER_MAGIC, ns);
+		ret = cgroup_do_get_tree(fc);
 
 	if (!ret && percpu_ref_is_dying(&ctx->root->cgrp.self.refcnt)) {
 		struct super_block *sb = fc->root->d_sb;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 64360a46d4df..0c6bef234a7c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2036,13 +2036,17 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	return ret;
 }
 
-int cgroup_do_mount(struct fs_context *fc, unsigned long magic,
-		    struct cgroup_namespace *ns)
+int cgroup_do_get_tree(struct fs_context *fc)
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
 	bool new_sb = false;
+	unsigned long magic;
 	int ret = 0;
 
+	if (fc->fs_type == &cgroup2_fs_type)
+		magic = CGROUP2_SUPER_MAGIC;
+	else
+		magic = CGROUP_SUPER_MAGIC;
 	fc->root = kernfs_mount(fc->fs_type, fc->sb_flags, ctx->root->kf_root,
 				magic, &new_sb);
 	if (IS_ERR(fc->root))
@@ -2052,7 +2056,7 @@ int cgroup_do_mount(struct fs_context *fc, unsigned long magic,
 	 * In non-init cgroup namespace, instead of root cgroup's dentry,
 	 * we return the dentry corresponding to the cgroupns->root_cgrp.
 	 */
-	if (!ret && ns != &init_cgroup_ns) {
+	if (!ret && ctx->ns != &init_cgroup_ns) {
 		struct dentry *nsdentry;
 		struct super_block *sb = fc->root->d_sb;
 		struct cgroup *cgrp;
@@ -2060,7 +2064,7 @@ int cgroup_do_mount(struct fs_context *fc, unsigned long magic,
 		mutex_lock(&cgroup_mutex);
 		spin_lock_irq(&css_set_lock);
 
-		cgrp = cset_cgroup_from_root(ns->root_cset, ctx->root);
+		cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
 
 		spin_unlock_irq(&css_set_lock);
 		mutex_unlock(&cgroup_mutex);
@@ -2089,6 +2093,7 @@ static void cgroup_fs_context_free(struct fs_context *fc)
 
 	kfree(ctx->name);
 	kfree(ctx->release_agent);
+	put_cgroup_ns(ctx->ns);
 	kfree(ctx);
 }
 
@@ -2106,7 +2111,7 @@ static int cgroup_get_tree(struct fs_context *fc)
 	cgroup_get_live(&cgrp_dfl_root.cgrp);
 	ctx->root = &cgrp_dfl_root;
 
-	ret = cgroup_do_mount(fc, CGROUP2_SUPER_MAGIC, ns);
+	ret = cgroup_do_get_tree(fc);
 	if (!ret)
 		apply_cgroup_root_flags(ctx->flags);
 	return ret;
@@ -2144,6 +2149,8 @@ static int cgroup_init_fs_context(struct fs_context *fc)
 	if (!use_task_css_set_links)
 		cgroup_enable_task_cg_lists();
 
+	ctx->ns = current->nsproxy->cgroup_ns;
+	get_cgroup_ns(ctx->ns);
 	fc->fs_private = ctx;
 	if (fc->fs_type == &cgroup2_fs_type)
 		fc->ops = &cgroup_fs_context_ops;

