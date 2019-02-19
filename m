Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D81C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D60221738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfBSQbx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:31:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfBSQbx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:31:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C34080467;
        Tue, 19 Feb 2019 16:31:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0682719C58;
        Tue, 19 Feb 2019 16:31:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/43] ipc: Convert mqueue fs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:31:50 +0000
Message-ID: <155059391026.12449.668855607210599414.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Feb 2019 16:31:52 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Convert the mqueue filesystem to use the filesystem context stuff.

Notes:

 (1) The relevant ipc namespace is selected in when the context is
     initialised (and it defaults to the current task's ipc namespace).
     The caller can override this before calling vfs_get_tree().

 (2) Rather than simply calling kern_mount_data(), mq_init_ns() and
     mq_internal_mount() create a context, adjust it and then do the rest
     of the mount procedure.

 (3) The lazy mqueue mounting on creation of a new namespace is retained
     from a previous patch, but the avoidance of sget() if no superblock
     yet exists is reverted and the superblock is again keyed on the
     namespace pointer.

     Yes, there was a performance gain in not searching the superblock
     hash, but it's only paid once per ipc namespace - and only if someone
     uses mqueue within that namespace, so I'm not sure it's worth it,
     especially as calling sget() allows avoidance of recursion.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 ipc/mqueue.c    |   94 ++++++++++++++++++++++++++++++++++++++++++-------------
 ipc/namespace.c |    2 +
 2 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c595bed7bfcb..2a9a8be49f5b 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -18,6 +18,7 @@
 #include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/namei.h>
 #include <linux/sysctl.h>
 #include <linux/poll.h>
@@ -42,6 +43,10 @@
 #include <net/sock.h>
 #include "util.h"
 
+struct mqueue_fs_context {
+	struct ipc_namespace	*ipc_ns;
+};
+
 #define MQUEUE_MAGIC	0x19800202
 #define DIRENT_SIZE	20
 #define FILENT_SIZE	80
@@ -87,9 +92,11 @@ struct mqueue_inode_info {
 	unsigned long qsize; /* size of queue in memory (sum of all msgs) */
 };
 
+static struct file_system_type mqueue_fs_type;
 static const struct inode_operations mqueue_dir_inode_operations;
 static const struct file_operations mqueue_file_operations;
 static const struct super_operations mqueue_super_ops;
+static const struct fs_context_operations mqueue_fs_context_ops;
 static void remove_notification(struct mqueue_inode_info *info);
 
 static struct kmem_cache *mqueue_inode_cachep;
@@ -322,7 +329,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 	return ERR_PTR(ret);
 }
 
-static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
+static int mqueue_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
 	struct ipc_namespace *ns = sb->s_fs_info;
@@ -343,18 +350,56 @@ static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-static struct dentry *mqueue_mount(struct file_system_type *fs_type,
-			 int flags, const char *dev_name,
-			 void *data)
+static int mqueue_get_tree(struct fs_context *fc)
 {
-	struct ipc_namespace *ns;
-	if (flags & SB_KERNMOUNT) {
-		ns = data;
-		data = NULL;
-	} else {
-		ns = current->nsproxy->ipc_ns;
-	}
-	return mount_ns(fs_type, flags, data, ns, ns->user_ns, mqueue_fill_super);
+	struct mqueue_fs_context *ctx = fc->fs_private;
+
+	put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(ctx->ipc_ns->user_ns);
+	fc->s_fs_info = ctx->ipc_ns;
+	return vfs_get_super(fc, vfs_get_keyed_super, mqueue_fill_super);
+}
+
+static void mqueue_fs_context_free(struct fs_context *fc)
+{
+	struct mqueue_fs_context *ctx = fc->fs_private;
+
+	if (ctx->ipc_ns)
+		put_ipc_ns(ctx->ipc_ns);
+	kfree(ctx);
+}
+
+static int mqueue_init_fs_context(struct fs_context *fc)
+{
+	struct mqueue_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct mqueue_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->ipc_ns = get_ipc_ns(current->nsproxy->ipc_ns);
+	fc->fs_private = ctx;
+	fc->ops = &mqueue_fs_context_ops;
+	return 0;
+}
+
+static struct vfsmount *mq_create_mount(struct ipc_namespace *ns)
+{
+	struct mqueue_fs_context *ctx;
+	struct fs_context *fc;
+	struct vfsmount *mnt;
+
+	fc = fs_context_for_mount(&mqueue_fs_type, SB_KERNMOUNT);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	ctx = fc->fs_private;
+	put_ipc_ns(ctx->ipc_ns);
+	ctx->ipc_ns = get_ipc_ns(ns);
+
+	mnt = fc_mount(fc);
+	put_fs_context(fc);
+	return mnt;
 }
 
 static void init_once(void *foo)
@@ -1522,15 +1567,22 @@ static const struct super_operations mqueue_super_ops = {
 	.statfs = simple_statfs,
 };
 
+static const struct fs_context_operations mqueue_fs_context_ops = {
+	.free		= mqueue_fs_context_free,
+	.get_tree	= mqueue_get_tree,
+};
+
 static struct file_system_type mqueue_fs_type = {
-	.name = "mqueue",
-	.mount = mqueue_mount,
-	.kill_sb = kill_litter_super,
-	.fs_flags = FS_USERNS_MOUNT,
+	.name			= "mqueue",
+	.init_fs_context	= mqueue_init_fs_context,
+	.kill_sb		= kill_litter_super,
+	.fs_flags		= FS_USERNS_MOUNT,
 };
 
 int mq_init_ns(struct ipc_namespace *ns)
 {
+	struct vfsmount *m;
+
 	ns->mq_queues_count  = 0;
 	ns->mq_queues_max    = DFLT_QUEUESMAX;
 	ns->mq_msg_max       = DFLT_MSGMAX;
@@ -1538,12 +1590,10 @@ int mq_init_ns(struct ipc_namespace *ns)
 	ns->mq_msg_default   = DFLT_MSG;
 	ns->mq_msgsize_default  = DFLT_MSGSIZE;
 
-	ns->mq_mnt = kern_mount_data(&mqueue_fs_type, ns);
-	if (IS_ERR(ns->mq_mnt)) {
-		int err = PTR_ERR(ns->mq_mnt);
-		ns->mq_mnt = NULL;
-		return err;
-	}
+	m = mq_create_mount(ns);
+	if (IS_ERR(m))
+		return PTR_ERR(m);
+	ns->mq_mnt = m;
 	return 0;
 }
 
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 21607791d62c..b3ca1476ca51 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -42,7 +42,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 		goto fail;
 
 	err = -ENOMEM;
-	ns = kmalloc(sizeof(struct ipc_namespace), GFP_KERNEL);
+	ns = kzalloc(sizeof(struct ipc_namespace), GFP_KERNEL);
 	if (ns == NULL)
 		goto fail_dec;
 

