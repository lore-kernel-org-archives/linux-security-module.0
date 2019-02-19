Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3866C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C47521738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfBSQck (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:32:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbfBSQcj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:32:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C93B7D0D8;
        Tue, 19 Feb 2019 16:32:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A7FA101962A;
        Tue, 19 Feb 2019 16:32:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 31/43] cgroup: stash cgroup_root reference into
 cgroup_fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:32:37 +0000
Message-ID: <155059395755.12449.3860088067534823614.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 16:32:39 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Note that this reference is *NOT* contributing to refcount of
cgroup_root in question and is valid only until cgroup_do_mount()
returns.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup-internal.h |    3 ++-
 kernel/cgroup/cgroup-v1.c       |    4 +++-
 kernel/cgroup/cgroup.c          |    7 +++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index a7b5a41f170c..3c1613a7648c 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -41,6 +41,7 @@ extern void __init enable_debug_cgroup(void);
  * The cgroup filesystem superblock creation/mount context.
  */
 struct cgroup_fs_context {
+	struct cgroup_root	*root;
 	unsigned int	flags;			/* CGRP_ROOT_* flags */
 
 	/* cgroup1 bits */
@@ -208,7 +209,7 @@ int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,
 			  struct cgroup_namespace *ns);
 
 void cgroup_free_root(struct cgroup_root *root);
-void init_cgroup_root(struct cgroup_root *root, struct cgroup_fs_context *ctx);
+void init_cgroup_root(struct cgroup_fs_context *ctx);
 int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask);
 int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask);
 struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 725e9f6fe80d..45a198c63d6e 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1208,6 +1208,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 		if (root->flags ^ ctx->flags)
 			pr_warn("new mount options do not match the existing superblock, will be ignored\n");
 
+		ctx->root = root;
 		ret = 0;
 		goto out_unlock;
 	}
@@ -1234,7 +1235,8 @@ int cgroup1_get_tree(struct fs_context *fc)
 		goto out_unlock;
 	}
 
-	init_cgroup_root(root, ctx);
+	ctx->root = root;
+	init_cgroup_root(ctx);
 
 	ret = cgroup_setup_root(root, ctx->subsys_mask);
 	if (ret)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d0cddfbdf5cf..57f43f63363a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1915,8 +1915,9 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
 }
 
-void init_cgroup_root(struct cgroup_root *root, struct cgroup_fs_context *ctx)
+void init_cgroup_root(struct cgroup_fs_context *ctx)
 {
+	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
 
 	INIT_LIST_HEAD(&root->root_list);
@@ -2098,6 +2099,7 @@ static int cgroup_get_tree(struct fs_context *fc)
 
 	cgrp_dfl_visible = true;
 	cgroup_get_live(&cgrp_dfl_root.cgrp);
+	ctx->root = &cgrp_dfl_root;
 
 	root = cgroup_do_mount(&cgroup2_fs_type, fc->sb_flags, &cgrp_dfl_root,
 					 CGROUP2_SUPER_MAGIC, ns);
@@ -5374,7 +5376,8 @@ int __init cgroup_init_early(void)
 	struct cgroup_subsys *ss;
 	int i;
 
-	init_cgroup_root(&cgrp_dfl_root, &ctx);
+	ctx.root = &cgrp_dfl_root;
+	init_cgroup_root(&ctx);
 	cgrp_dfl_root.cgrp.self.flags |= CSS_NO_REF;
 
 	RCU_INIT_POINTER(init_task.cgroups, &init_css_set);

