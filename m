Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D43C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E47E21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfBSQ30 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:29:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfBSQ30 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:29:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E09510F84;
        Tue, 19 Feb 2019 16:29:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33D77648B9;
        Tue, 19 Feb 2019 16:29:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/43] new helpers: vfs_create_mount(), fc_mount()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:29:23 +0000
Message-ID: <155059376340.12449.11080415395465474975.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Feb 2019 16:29:25 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Create a new helper, vfs_create_mount(), that creates a detached vfsmount
object from an fs_context that has a superblock attached to it.

Almost all uses will be paired with immediately preceding vfs_get_tree();
add a helper for such combination.

Switch vfs_kern_mount() to use this.

NOTE: mild behaviour change; passing NULL as 'device name' to
something like procfs will change /proc/*/mountstats - "device none"
instead on "no device".  That is consistent with /proc/mounts et.al.

[do'h - EXPORT_SYMBOL_GPL slipped in by mistake; removed]
[AV -- remove confused comment from vfs_create_mount()]
[AV -- removed the second argument]

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/namespace.c        |   76 ++++++++++++++++++++++++++++++++++---------------
 include/linux/mount.h |    3 ++
 2 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3f2fd7a34733..156771f5745a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -941,12 +941,59 @@ static struct mount *skip_mnt_tree(struct mount *p)
 	return p;
 }
 
+/**
+ * vfs_create_mount - Create a mount for a configured superblock
+ * @fc: The configuration context with the superblock attached
+ *
+ * Create a mount to an already configured superblock.  If necessary, the
+ * caller should invoke vfs_get_tree() before calling this.
+ *
+ * Note that this does not attach the mount to anything.
+ */
+struct vfsmount *vfs_create_mount(struct fs_context *fc)
+{
+	struct mount *mnt;
+
+	if (!fc->root)
+		return ERR_PTR(-EINVAL);
+
+	mnt = alloc_vfsmnt(fc->source ?: "none");
+	if (!mnt)
+		return ERR_PTR(-ENOMEM);
+
+	if (fc->sb_flags & SB_KERNMOUNT)
+		mnt->mnt.mnt_flags = MNT_INTERNAL;
+
+	atomic_inc(&fc->root->d_sb->s_active);
+	mnt->mnt.mnt_sb		= fc->root->d_sb;
+	mnt->mnt.mnt_root	= dget(fc->root);
+	mnt->mnt_mountpoint	= mnt->mnt.mnt_root;
+	mnt->mnt_parent		= mnt;
+
+	lock_mount_hash();
+	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
+	unlock_mount_hash();
+	return &mnt->mnt;
+}
+EXPORT_SYMBOL(vfs_create_mount);
+
+struct vfsmount *fc_mount(struct fs_context *fc)
+{
+	int err = vfs_get_tree(fc);
+	if (!err) {
+		up_write(&fc->root->d_sb->s_umount);
+		return vfs_create_mount(fc);
+	}
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL(fc_mount);
+
 struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				int flags, const char *name,
 				void *data)
 {
 	struct fs_context *fc;
-	struct mount *mnt;
+	struct vfsmount *mnt;
 	int ret = 0;
 
 	if (!type)
@@ -964,31 +1011,12 @@ struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 	if (!ret)
 		ret = parse_monolithic_mount_data(fc, data);
 	if (!ret)
-		ret = vfs_get_tree(fc);
-	if (ret) {
-		put_fs_context(fc);
-		return ERR_PTR(ret);
-	}
-	up_write(&fc->root->d_sb->s_umount);
-	mnt = alloc_vfsmnt(name);
-	if (!mnt) {
-		put_fs_context(fc);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	if (flags & SB_KERNMOUNT)
-		mnt->mnt.mnt_flags = MNT_INTERNAL;
+		mnt = fc_mount(fc);
+	else
+		mnt = ERR_PTR(ret);
 
-	atomic_inc(&fc->root->d_sb->s_active);
-	mnt->mnt.mnt_root = dget(fc->root);
-	mnt->mnt.mnt_sb = fc->root->d_sb;
-	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
-	mnt->mnt_parent = mnt;
-	lock_mount_hash();
-	list_add_tail(&mnt->mnt_instance, &fc->root->d_sb->s_mounts);
-	unlock_mount_hash();
 	put_fs_context(fc);
-	return &mnt->mnt;
+	return mnt;
 }
 EXPORT_SYMBOL_GPL(vfs_kern_mount);
 
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 037eed52164b..9197ddbf35fb 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -21,6 +21,7 @@ struct super_block;
 struct vfsmount;
 struct dentry;
 struct mnt_namespace;
+struct fs_context;
 
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
@@ -88,6 +89,8 @@ struct path;
 extern struct vfsmount *clone_private_mount(const struct path *path);
 
 struct file_system_type;
+extern struct vfsmount *fc_mount(struct fs_context *fc);
+extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
 extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				      int flags, const char *name,
 				      void *data);

