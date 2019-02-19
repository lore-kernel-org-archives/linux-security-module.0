Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023C2C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF6421738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfBSQ3T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:29:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbfBSQ3S (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:29:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29DF87266F;
        Tue, 19 Feb 2019 16:29:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90DC117131;
        Tue, 19 Feb 2019 16:29:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/43] vfs: Introduce fs_context,
 switch vfs_kern_mount() to it.
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:29:14 +0000
Message-ID: <155059375435.12449.6188847556322464304.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 19 Feb 2019 16:29:18 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Introduce a filesystem context concept to be used during superblock
creation for mount and superblock reconfiguration for remount.  This is
allocated at the beginning of the mount procedure and into it is placed:

 (1) Filesystem type.

 (2) Namespaces.

 (3) Source/Device names (there may be multiple).

 (4) Superblock flags (SB_*).

 (5) Security details.

 (6) Filesystem-specific data, as set by the mount options.

Accessor functions are then provided to set up a context, parameterise it
from monolithic mount data (the data page passed to mount(2)) and tear it
down again.

A legacy wrapper is provided that implements what will be the basic
operations, wrapping access to filesystems that aren't yet aware of the
fs_context.

Finally, vfs_kern_mount() is changed to make use of the fs_context and
mount_fs() is replaced by vfs_get_tree(), called from vfs_kern_mount().
[AV -- add missing kstrdup()]
[AV -- put_cred() can be unconditional - fc->cred can't be NULL]
[AV -- take legacy_validate() contents into legacy_parse_monolithic()]
[AV -- merge KERNEL_MOUNT and USER_MOUNT]
[AV -- don't unlock superblock on success return from vfs_get_tree()]
[AV -- kill 'reference' argument of init_fs_context()]

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/Makefile                |    3 -
 fs/fs_context.c            |  182 ++++++++++++++++++++++++++++++++++++++++++++
 fs/internal.h              |    9 ++
 fs/namespace.c             |   46 ++++++++---
 fs/super.c                 |   50 ++++++------
 include/linux/fs_context.h |   64 +++++++++++++++
 6 files changed, 310 insertions(+), 44 deletions(-)
 create mode 100644 fs/fs_context.c
 create mode 100644 include/linux/fs_context.h

diff --git a/fs/Makefile b/fs/Makefile
index 293733f61594..5563cf34f7c2 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -12,7 +12,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
-		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o
+		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
+		fs_context.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/fs_context.c b/fs/fs_context.c
new file mode 100644
index 000000000000..4294091b689d
--- /dev/null
+++ b/fs/fs_context.c
@@ -0,0 +1,182 @@
+/* Provide a way to create a superblock configuration context within the kernel
+ * that allows a superblock to be set up prior to mounting.
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/fs_context.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/nsproxy.h>
+#include <linux/slab.h>
+#include <linux/magic.h>
+#include <linux/security.h>
+#include <linux/mnt_namespace.h>
+#include <linux/pid_namespace.h>
+#include <linux/user_namespace.h>
+#include <net/net_namespace.h>
+#include "mount.h"
+#include "internal.h"
+
+struct legacy_fs_context {
+	char			*legacy_data;	/* Data page for legacy filesystems */
+	size_t			data_size;
+};
+
+static int legacy_init_fs_context(struct fs_context *fc);
+
+/**
+ * alloc_fs_context - Create a filesystem context.
+ * @fs_type: The filesystem type.
+ * @reference: The dentry from which this one derives (or NULL)
+ * @sb_flags: Filesystem/superblock flags (SB_*)
+ * @sb_flags_mask: Applicable members of @sb_flags
+ * @purpose: The purpose that this configuration shall be used for.
+ *
+ * Open a filesystem and create a mount context.  The mount context is
+ * initialised with the supplied flags and, if a submount/automount from
+ * another superblock (referred to by @reference) is supplied, may have
+ * parameters such as namespaces copied across from that superblock.
+ */
+static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
+				      struct dentry *reference,
+				      unsigned int sb_flags,
+				      unsigned int sb_flags_mask,
+				      enum fs_context_purpose purpose)
+{
+	struct fs_context *fc;
+	int ret = -ENOMEM;
+
+	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
+	if (!fc)
+		return ERR_PTR(-ENOMEM);
+
+	fc->purpose	= purpose;
+	fc->sb_flags	= sb_flags;
+	fc->sb_flags_mask = sb_flags_mask;
+	fc->fs_type	= get_filesystem(fs_type);
+	fc->cred	= get_current_cred();
+	fc->net_ns	= get_net(current->nsproxy->net_ns);
+
+	switch (purpose) {
+	case FS_CONTEXT_FOR_MOUNT:
+		fc->user_ns = get_user_ns(fc->cred->user_ns);
+		break;
+	}
+
+	ret = legacy_init_fs_context(fc);
+	if (ret < 0)
+		goto err_fc;
+	fc->need_free = true;
+	return fc;
+
+err_fc:
+	put_fs_context(fc);
+	return ERR_PTR(ret);
+}
+
+struct fs_context *fs_context_for_mount(struct file_system_type *fs_type,
+					unsigned int sb_flags)
+{
+	return alloc_fs_context(fs_type, NULL, sb_flags, 0,
+					FS_CONTEXT_FOR_MOUNT);
+}
+EXPORT_SYMBOL(fs_context_for_mount);
+
+static void legacy_fs_context_free(struct fs_context *fc);
+/**
+ * put_fs_context - Dispose of a superblock configuration context.
+ * @fc: The context to dispose of.
+ */
+void put_fs_context(struct fs_context *fc)
+{
+	struct super_block *sb;
+
+	if (fc->root) {
+		sb = fc->root->d_sb;
+		dput(fc->root);
+		fc->root = NULL;
+		deactivate_super(sb);
+	}
+
+	if (fc->need_free)
+		legacy_fs_context_free(fc);
+
+	security_free_mnt_opts(&fc->security);
+	if (fc->net_ns)
+		put_net(fc->net_ns);
+	put_user_ns(fc->user_ns);
+	put_cred(fc->cred);
+	kfree(fc->subtype);
+	put_filesystem(fc->fs_type);
+	kfree(fc->source);
+	kfree(fc);
+}
+EXPORT_SYMBOL(put_fs_context);
+
+/*
+ * Free the config for a filesystem that doesn't support fs_context.
+ */
+static void legacy_fs_context_free(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+/*
+ * Add monolithic mount data.
+ */
+static int legacy_parse_monolithic(struct fs_context *fc, void *data)
+{
+	struct legacy_fs_context *ctx = fc->fs_private;
+	ctx->legacy_data = data;
+	if (!ctx->legacy_data)
+		return 0;
+	if (fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)
+		return 0;
+	return security_sb_eat_lsm_opts(ctx->legacy_data, &fc->security);
+}
+
+/*
+ * Get a mountable root with the legacy mount command.
+ */
+int legacy_get_tree(struct fs_context *fc)
+{
+	struct legacy_fs_context *ctx = fc->fs_private;
+	struct super_block *sb;
+	struct dentry *root;
+
+	root = fc->fs_type->mount(fc->fs_type, fc->sb_flags,
+				      fc->source, ctx->legacy_data);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	sb = root->d_sb;
+	BUG_ON(!sb);
+
+	fc->root = root;
+	return 0;
+}
+
+/*
+ * Initialise a legacy context for a filesystem that doesn't support
+ * fs_context.
+ */
+static int legacy_init_fs_context(struct fs_context *fc)
+{
+	fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
+	if (!fc->fs_private)
+		return -ENOMEM;
+	return 0;
+}
+
+int parse_monolithic_mount_data(struct fs_context *fc, void *data)
+{
+	return legacy_parse_monolithic(fc, data);
+}
diff --git a/fs/internal.h b/fs/internal.h
index d410186bc369..f85c3212d25d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -17,6 +17,7 @@ struct linux_binprm;
 struct path;
 struct mount;
 struct shrink_control;
+struct fs_context;
 
 /*
  * block_dev.c
@@ -51,6 +52,12 @@ int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
  */
 extern void __init chrdev_init(void);
 
+/*
+ * fs_context.c
+ */
+extern int legacy_get_tree(struct fs_context *fc);
+extern int parse_monolithic_mount_data(struct fs_context *, void *);
+
 /*
  * namei.c
  */
@@ -101,8 +108,6 @@ extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
  */
 extern int do_remount_sb(struct super_block *, int, void *, int);
 extern bool trylock_super(struct super_block *sb);
-extern struct dentry *mount_fs(struct file_system_type *,
-			       int, const char *, void *);
 extern struct super_block *user_get_super(dev_t);
 
 /*
diff --git a/fs/namespace.c b/fs/namespace.c
index f0b8a8ca08df..3f2fd7a34733 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -27,6 +27,7 @@
 #include <linux/task_work.h>
 #include <linux/sched/task.h>
 #include <uapi/linux/mount.h>
+#include <linux/fs_context.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -940,36 +941,53 @@ static struct mount *skip_mnt_tree(struct mount *p)
 	return p;
 }
 
-struct vfsmount *
-vfs_kern_mount(struct file_system_type *type, int flags, const char *name, void *data)
+struct vfsmount *vfs_kern_mount(struct file_system_type *type,
+				int flags, const char *name,
+				void *data)
 {
+	struct fs_context *fc;
 	struct mount *mnt;
-	struct dentry *root;
+	int ret = 0;
 
 	if (!type)
 		return ERR_PTR(-ENODEV);
 
+	fc = fs_context_for_mount(type, flags);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	if (name) {
+		fc->source = kstrdup(name, GFP_KERNEL);
+		if (!fc->source)
+			ret = -ENOMEM;
+	}
+	if (!ret)
+		ret = parse_monolithic_mount_data(fc, data);
+	if (!ret)
+		ret = vfs_get_tree(fc);
+	if (ret) {
+		put_fs_context(fc);
+		return ERR_PTR(ret);
+	}
+	up_write(&fc->root->d_sb->s_umount);
 	mnt = alloc_vfsmnt(name);
-	if (!mnt)
+	if (!mnt) {
+		put_fs_context(fc);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	if (flags & SB_KERNMOUNT)
 		mnt->mnt.mnt_flags = MNT_INTERNAL;
 
-	root = mount_fs(type, flags, name, data);
-	if (IS_ERR(root)) {
-		mnt_free_id(mnt);
-		free_vfsmnt(mnt);
-		return ERR_CAST(root);
-	}
-
-	mnt->mnt.mnt_root = root;
-	mnt->mnt.mnt_sb = root->d_sb;
+	atomic_inc(&fc->root->d_sb->s_active);
+	mnt->mnt.mnt_root = dget(fc->root);
+	mnt->mnt.mnt_sb = fc->root->d_sb;
 	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
 	mnt->mnt_parent = mnt;
 	lock_mount_hash();
-	list_add_tail(&mnt->mnt_instance, &root->d_sb->s_mounts);
+	list_add_tail(&mnt->mnt_instance, &fc->root->d_sb->s_mounts);
 	unlock_mount_hash();
+	put_fs_context(fc);
 	return &mnt->mnt;
 }
 EXPORT_SYMBOL_GPL(vfs_kern_mount);
diff --git a/fs/super.c b/fs/super.c
index 48e25eba8465..fc3887277ad1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -35,6 +35,7 @@
 #include <linux/fsnotify.h>
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
+#include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -1241,27 +1242,24 @@ struct dentry *mount_single(struct file_system_type *fs_type,
 }
 EXPORT_SYMBOL(mount_single);
 
-struct dentry *
-mount_fs(struct file_system_type *type, int flags, const char *name, void *data)
+/**
+ * vfs_get_tree - Get the mountable root
+ * @fc: The superblock configuration context.
+ *
+ * The filesystem is invoked to get or create a superblock which can then later
+ * be used for mounting.  The filesystem places a pointer to the root to be
+ * used for mounting in @fc->root.
+ */
+int vfs_get_tree(struct fs_context *fc)
 {
-	struct dentry *root;
 	struct super_block *sb;
-	int error = -ENOMEM;
-	void *sec_opts = NULL;
+	int error;
 
-	if (data && !(type->fs_flags & FS_BINARY_MOUNTDATA)) {
-		error = security_sb_eat_lsm_opts(data, &sec_opts);
-		if (error)
-			return ERR_PTR(error);
-	}
+	error = legacy_get_tree(fc);
+	if (error < 0)
+		return error;
 
-	root = type->mount(type, flags, name, data);
-	if (IS_ERR(root)) {
-		error = PTR_ERR(root);
-		goto out_free_secdata;
-	}
-	sb = root->d_sb;
-	BUG_ON(!sb);
+	sb = fc->root->d_sb;
 	WARN_ON(!sb->s_bdi);
 
 	/*
@@ -1273,11 +1271,11 @@ mount_fs(struct file_system_type *type, int flags, const char *name, void *data)
 	smp_wmb();
 	sb->s_flags |= SB_BORN;
 
-	error = security_sb_set_mnt_opts(sb, sec_opts, 0, NULL);
+	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
 	if (error)
 		goto out_sb;
 
-	if (!(flags & (MS_KERNMOUNT|MS_SUBMOUNT))) {
+	if (!(fc->sb_flags & (MS_KERNMOUNT|MS_SUBMOUNT))) {
 		error = security_sb_kern_mount(sb);
 		if (error)
 			goto out_sb;
@@ -1290,18 +1288,16 @@ mount_fs(struct file_system_type *type, int flags, const char *name, void *data)
 	 * violate this rule.
 	 */
 	WARN((sb->s_maxbytes < 0), "%s set sb->s_maxbytes to "
-		"negative value (%lld)\n", type->name, sb->s_maxbytes);
+		"negative value (%lld)\n", fc->fs_type->name, sb->s_maxbytes);
 
-	up_write(&sb->s_umount);
-	security_free_mnt_opts(&sec_opts);
-	return root;
+	return 0;
 out_sb:
-	dput(root);
+	dput(fc->root);
+	fc->root = NULL;
 	deactivate_locked_super(sb);
-out_free_secdata:
-	security_free_mnt_opts(&sec_opts);
-	return ERR_PTR(error);
+	return error;
 }
+EXPORT_SYMBOL(vfs_get_tree);
 
 /*
  * Setup private BDI for given superblock. It gets automatically cleaned up
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
new file mode 100644
index 000000000000..9805514444c9
--- /dev/null
+++ b/include/linux/fs_context.h
@@ -0,0 +1,64 @@
+/* Filesystem superblock creation and reconfiguration context.
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_FS_CONTEXT_H
+#define _LINUX_FS_CONTEXT_H
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/security.h>
+
+struct cred;
+struct dentry;
+struct file_operations;
+struct file_system_type;
+struct net;
+struct user_namespace;
+
+enum fs_context_purpose {
+	FS_CONTEXT_FOR_MOUNT,		/* New superblock for explicit mount */
+};
+
+/*
+ * Filesystem context for holding the parameters used in the creation or
+ * reconfiguration of a superblock.
+ *
+ * Superblock creation fills in ->root whereas reconfiguration begins with this
+ * already set.
+ *
+ * See Documentation/filesystems/mounting.txt
+ */
+struct fs_context {
+	struct file_system_type	*fs_type;
+	void			*fs_private;	/* The filesystem's context */
+	struct dentry		*root;		/* The root and superblock */
+	struct user_namespace	*user_ns;	/* The user namespace for this mount */
+	struct net		*net_ns;	/* The network namespace for this mount */
+	const struct cred	*cred;		/* The mounter's credentials */
+	const char		*source;	/* The source name (eg. dev path) */
+	const char		*subtype;	/* The subtype to set on the superblock */
+	void			*security;	/* Linux S&M options */
+	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
+	unsigned int		sb_flags_mask;	/* Superblock flags that were changed */
+	enum fs_context_purpose	purpose:8;
+	bool			need_free:1;	/* Need to call ops->free() */
+};
+
+/*
+ * fs_context manipulation functions.
+ */
+extern struct fs_context *fs_context_for_mount(struct file_system_type *fs_type,
+						unsigned int sb_flags);
+
+extern int vfs_get_tree(struct fs_context *fc);
+extern void put_fs_context(struct fs_context *fc);
+
+#endif /* _LINUX_FS_CONTEXT_H */

