Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D393EC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AB421738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfBSQaN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:30:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbfBSQaN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:30:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F3347518D;
        Tue, 19 Feb 2019 16:30:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C39AC60C1D;
        Tue, 19 Feb 2019 16:30:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/43] introduce fs_context methods
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:30:09 +0000
Message-ID: <155059380992.12449.10913805628701754409.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Feb 2019 16:30:12 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/fs_context.c            |   28 ++++++++++++++++++++++------
 fs/internal.h              |    2 --
 fs/super.c                 |   36 ++++++++++++++++++++++++++++--------
 include/linux/fs.h         |    2 ++
 include/linux/fs_context.h |   13 +++++++++++++
 5 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 2bd652b6e848..825d1b2c8807 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -51,6 +51,7 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 				      unsigned int sb_flags_mask,
 				      enum fs_context_purpose purpose)
 {
+	int (*init_fs_context)(struct fs_context *);
 	struct fs_context *fc;
 	int ret = -ENOMEM;
 
@@ -81,7 +82,12 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 		break;
 	}
 
-	ret = legacy_init_fs_context(fc);
+	/* TODO: Make all filesystems support this unconditionally */
+	init_fs_context = fc->fs_type->init_fs_context;
+	if (!init_fs_context)
+		init_fs_context = legacy_init_fs_context;
+
+	ret = init_fs_context(fc);
 	if (ret < 0)
 		goto err_fc;
 	fc->need_free = true;
@@ -141,8 +147,8 @@ void put_fs_context(struct fs_context *fc)
 		deactivate_super(sb);
 	}
 
-	if (fc->need_free)
-		legacy_fs_context_free(fc);
+	if (fc->need_free && fc->ops && fc->ops->free)
+		fc->ops->free(fc);
 
 	security_free_mnt_opts(&fc->security);
 	put_net(fc->net_ns);
@@ -180,7 +186,7 @@ static int legacy_parse_monolithic(struct fs_context *fc, void *data)
 /*
  * Get a mountable root with the legacy mount command.
  */
-int legacy_get_tree(struct fs_context *fc)
+static int legacy_get_tree(struct fs_context *fc)
 {
 	struct legacy_fs_context *ctx = fc->fs_private;
 	struct super_block *sb;
@@ -201,7 +207,7 @@ int legacy_get_tree(struct fs_context *fc)
 /*
  * Handle remount.
  */
-int legacy_reconfigure(struct fs_context *fc)
+static int legacy_reconfigure(struct fs_context *fc)
 {
 	struct legacy_fs_context *ctx = fc->fs_private;
 	struct super_block *sb = fc->root->d_sb;
@@ -213,6 +219,13 @@ int legacy_reconfigure(struct fs_context *fc)
 				    ctx ? ctx->legacy_data : NULL);
 }
 
+const struct fs_context_operations legacy_fs_context_ops = {
+	.free			= legacy_fs_context_free,
+	.parse_monolithic	= legacy_parse_monolithic,
+	.get_tree		= legacy_get_tree,
+	.reconfigure		= legacy_reconfigure,
+};
+
 /*
  * Initialise a legacy context for a filesystem that doesn't support
  * fs_context.
@@ -222,10 +235,13 @@ static int legacy_init_fs_context(struct fs_context *fc)
 	fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
 	if (!fc->fs_private)
 		return -ENOMEM;
+	fc->ops = &legacy_fs_context_ops;
 	return 0;
 }
 
 int parse_monolithic_mount_data(struct fs_context *fc, void *data)
 {
-	return legacy_parse_monolithic(fc, data);
+	int (*monolithic_mount_data)(struct fs_context *, void *);
+	monolithic_mount_data = fc->ops->parse_monolithic;
+	return monolithic_mount_data(fc, data);
 }
diff --git a/fs/internal.h b/fs/internal.h
index 016a5b8dd305..8f8d07cc433f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -55,8 +55,6 @@ extern void __init chrdev_init(void);
 /*
  * fs_context.c
  */
-extern int legacy_get_tree(struct fs_context *fc);
-extern int legacy_reconfigure(struct fs_context *fc);
 extern int parse_monolithic_mount_data(struct fs_context *, void *);
 extern void fc_drop_locked(struct fs_context *);
 
diff --git a/fs/super.c b/fs/super.c
index 50553233dd15..76b3181c782d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -894,13 +894,15 @@ int reconfigure_super(struct fs_context *fc)
 		}
 	}
 
-	retval = legacy_reconfigure(fc);
-	if (retval) {
-		if (!force)
-			goto cancel_readonly;
-		/* If forced remount, go ahead despite any errors */
-		WARN(1, "forced remount of a %s fs returned %i\n",
-		     sb->s_type->name, retval);
+	if (fc->ops->reconfigure) {
+		retval = fc->ops->reconfigure(fc);
+		if (retval) {
+			if (!force)
+				goto cancel_readonly;
+			/* If forced remount, go ahead despite any errors */
+			WARN(1, "forced remount of a %s fs returned %i\n",
+			     sb->s_type->name, retval);
+		}
 	}
 
 	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
@@ -1294,10 +1296,28 @@ int vfs_get_tree(struct fs_context *fc)
 	struct super_block *sb;
 	int error;
 
-	error = legacy_get_tree(fc);
+	if (fc->fs_type->fs_flags & FS_REQUIRES_DEV && !fc->source)
+		return -ENOENT;
+
+	if (fc->root)
+		return -EBUSY;
+
+	/* Get the mountable root in fc->root, with a ref on the root and a ref
+	 * on the superblock.
+	 */
+	error = fc->ops->get_tree(fc);
 	if (error < 0)
 		return error;
 
+	if (!fc->root) {
+		pr_err("Filesystem %s get_tree() didn't set fc->root\n",
+		       fc->fs_type->name);
+		/* We don't know what the locking state of the superblock is -
+		 * if there is a superblock.
+		 */
+		BUG();
+	}
+
 	sb = fc->root->d_sb;
 	WARN_ON(!sb->s_bdi);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c65d02c5c512..8d578a9e1e8c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -61,6 +61,7 @@ struct workqueue_struct;
 struct iov_iter;
 struct fscrypt_info;
 struct fscrypt_operations;
+struct fs_context;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -2173,6 +2174,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+	int (*init_fs_context)(struct fs_context *);
 	struct dentry *(*mount) (struct file_system_type *, int,
 		       const char *, void *);
 	void (*kill_sb) (struct super_block *);
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 7feb018c7a9e..087c12954360 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -20,8 +20,13 @@ struct cred;
 struct dentry;
 struct file_operations;
 struct file_system_type;
+struct mnt_namespace;
 struct net;
+struct pid_namespace;
+struct super_block;
 struct user_namespace;
+struct vfsmount;
+struct path;
 
 enum fs_context_purpose {
 	FS_CONTEXT_FOR_MOUNT,		/* New superblock for explicit mount */
@@ -39,6 +44,7 @@ enum fs_context_purpose {
  * See Documentation/filesystems/mounting.txt
  */
 struct fs_context {
+	const struct fs_context_operations *ops;
 	struct file_system_type	*fs_type;
 	void			*fs_private;	/* The filesystem's context */
 	struct dentry		*root;		/* The root and superblock */
@@ -54,6 +60,13 @@ struct fs_context {
 	bool			need_free:1;	/* Need to call ops->free() */
 };
 
+struct fs_context_operations {
+	void (*free)(struct fs_context *fc);
+	int (*parse_monolithic)(struct fs_context *fc, void *data);
+	int (*get_tree)(struct fs_context *fc);
+	int (*reconfigure)(struct fs_context *fc);
+};
+
 /*
  * fs_context manipulation functions.
  */

