Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6076C10F00
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB242147A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfBSRIe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:08:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBSRIe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:08:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A56697D0CB;
        Tue, 19 Feb 2019 17:08:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2C0818669;
        Tue, 19 Feb 2019 17:08:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/10] vfs: syscall: Add open_tree(2) to reference or clone
 a mount
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 17:08:31 +0000
Message-ID: <155059611122.17079.12534811457233099094.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 17:08:33 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

open_tree(dfd, pathname, flags)

Returns an O_PATH-opened file descriptor or an error.
dfd and pathname specify the location to open, in usual
fashion (see e.g. fstatat(2)).  flags should be an OR of
some of the following:
	* AT_PATH_EMPTY, AT_NO_AUTOMOUNT, AT_SYMLINK_NOFOLLOW -
same meanings as usual
	* OPEN_TREE_CLOEXEC - make the resulting descriptor
close-on-exec
	* OPEN_TREE_CLONE or OPEN_TREE_CLONE | AT_RECURSIVE -
instead of opening the location in question, create a detached
mount tree matching the subtree rooted at location specified by
dfd/pathname.  With AT_RECURSIVE the entire subtree is cloned,
without it - only the part within in the mount containing the
location in question.  In other words, the same as mount --rbind
or mount --bind would've taken.  The detached tree will be
dissolved on the final close of obtained file.  Creation of such
detached trees requires the same capabilities as doing mount --bind.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-api@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/file_table.c                        |    9 +-
 fs/internal.h                          |    1 
 fs/namespace.c                         |  157 ++++++++++++++++++++++++++++----
 include/linux/fs.h                     |    7 +
 include/linux/syscalls.h               |    1 
 include/uapi/linux/fcntl.h             |    2 
 include/uapi/linux/mount.h             |    6 +
 9 files changed, 158 insertions(+), 27 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 3cf7b533b3d1..ea1b413afd47 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -398,3 +398,4 @@
 384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
+387	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..0545bed581dc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,7 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+335	common	open_tree		__x64_sys_open_tree
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/file_table.c b/fs/file_table.c
index 5679e7fcb6b0..10e0a3dcea4d 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -255,6 +255,7 @@ static void __fput(struct file *file)
 	struct dentry *dentry = file->f_path.dentry;
 	struct vfsmount *mnt = file->f_path.mnt;
 	struct inode *inode = file->f_inode;
+	fmode_t mode = file->f_mode;
 
 	if (unlikely(!(file->f_mode & FMODE_OPENED)))
 		goto out;
@@ -277,18 +278,20 @@ static void __fput(struct file *file)
 	if (file->f_op->release)
 		file->f_op->release(inode, file);
 	if (unlikely(S_ISCHR(inode->i_mode) && inode->i_cdev != NULL &&
-		     !(file->f_mode & FMODE_PATH))) {
+		     !(mode & FMODE_PATH))) {
 		cdev_put(inode->i_cdev);
 	}
 	fops_put(file->f_op);
 	put_pid(file->f_owner.pid);
-	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
+	if ((mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
 		i_readcount_dec(inode);
-	if (file->f_mode & FMODE_WRITER) {
+	if (mode & FMODE_WRITER) {
 		put_write_access(inode);
 		__mnt_drop_write(mnt);
 	}
 	dput(dentry);
+	if (unlikely(mode & FMODE_NEED_UNMOUNT))
+		dissolve_on_fput(mnt);
 	mntput(mnt);
 out:
 	file_free(file);
diff --git a/fs/internal.h b/fs/internal.h
index 6a8b71643af4..f3a027c44758 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -94,6 +94,7 @@ extern int __mnt_want_write_file(struct file *);
 extern void __mnt_drop_write(struct vfsmount *);
 extern void __mnt_drop_write_file(struct file *);
 
+extern void dissolve_on_fput(struct vfsmount *);
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index bb9b7db1c66c..112d46f26fc3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>		/* init_rootfs */
 #include <linux/fs_struct.h>	/* get_fs_root et.al. */
 #include <linux/fsnotify.h>	/* fsnotify_vfsmount_delete */
+#include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/proc_ns.h>
 #include <linux/magic.h>
@@ -1830,6 +1831,21 @@ struct vfsmount *collect_mounts(const struct path *path)
 	return &tree->mnt;
 }
 
+static void free_mnt_ns(struct mnt_namespace *);
+static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
+
+void dissolve_on_fput(struct vfsmount *mnt)
+{
+	struct mnt_namespace *ns;
+	namespace_lock();
+	lock_mount_hash();
+	ns = real_mount(mnt)->mnt_ns;
+	umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
+	unlock_mount_hash();
+	namespace_unlock();
+	free_mnt_ns(ns);
+}
+
 void drop_collected_mounts(struct vfsmount *mnt)
 {
 	namespace_lock();
@@ -2220,6 +2236,30 @@ static bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 	return false;
 }
 
+static struct mount *__do_loopback(struct path *old_path, int recurse)
+{
+	struct mount *mnt = ERR_PTR(-EINVAL), *old = real_mount(old_path->mnt);
+
+	if (IS_MNT_UNBINDABLE(old))
+		return mnt;
+
+	if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
+		return mnt;
+
+	if (!recurse && has_locked_children(old, old_path->dentry))
+		return mnt;
+
+	if (recurse)
+		mnt = copy_tree(old, old_path->dentry, CL_COPY_MNT_NS_FILE);
+	else
+		mnt = clone_mnt(old, old_path->dentry, 0);
+
+	if (!IS_ERR(mnt))
+		mnt->mnt.mnt_flags &= ~MNT_LOCKED;
+
+	return mnt;
+}
+
 /*
  * do loopback mount.
  */
@@ -2227,7 +2267,7 @@ static int do_loopback(struct path *path, const char *old_name,
 				int recurse)
 {
 	struct path old_path;
-	struct mount *mnt = NULL, *old, *parent;
+	struct mount *mnt = NULL, *parent;
 	struct mountpoint *mp;
 	int err;
 	if (!old_name || !*old_name)
@@ -2241,38 +2281,21 @@ static int do_loopback(struct path *path, const char *old_name,
 		goto out;
 
 	mp = lock_mount(path);
-	err = PTR_ERR(mp);
-	if (IS_ERR(mp))
+	if (IS_ERR(mp)) {
+		err = PTR_ERR(mp);
 		goto out;
+	}
 
-	old = real_mount(old_path.mnt);
 	parent = real_mount(path->mnt);
-
-	err = -EINVAL;
-	if (IS_MNT_UNBINDABLE(old))
-		goto out2;
-
 	if (!check_mnt(parent))
 		goto out2;
 
-	if (!check_mnt(old) && old_path.dentry->d_op != &ns_dentry_operations)
-		goto out2;
-
-	if (!recurse && has_locked_children(old, old_path.dentry))
-		goto out2;
-
-	if (recurse)
-		mnt = copy_tree(old, old_path.dentry, CL_COPY_MNT_NS_FILE);
-	else
-		mnt = clone_mnt(old, old_path.dentry, 0);
-
+	mnt = __do_loopback(&old_path, recurse);
 	if (IS_ERR(mnt)) {
 		err = PTR_ERR(mnt);
 		goto out2;
 	}
 
-	mnt->mnt.mnt_flags &= ~MNT_LOCKED;
-
 	err = graft_tree(mnt, parent, mp);
 	if (err) {
 		lock_mount_hash();
@@ -2286,6 +2309,96 @@ static int do_loopback(struct path *path, const char *old_name,
 	return err;
 }
 
+static struct file *open_detached_copy(struct path *path, bool recursive)
+{
+	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
+	struct mnt_namespace *ns = alloc_mnt_ns(user_ns, true);
+	struct mount *mnt, *p;
+	struct file *file;
+
+	if (IS_ERR(ns))
+		return ERR_CAST(ns);
+
+	namespace_lock();
+	mnt = __do_loopback(path, recursive);
+	if (IS_ERR(mnt)) {
+		namespace_unlock();
+		free_mnt_ns(ns);
+		return ERR_CAST(mnt);
+	}
+
+	lock_mount_hash();
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		p->mnt_ns = ns;
+		ns->mounts++;
+	}
+	ns->root = mnt;
+	list_add_tail(&ns->list, &mnt->mnt_list);
+	mntget(&mnt->mnt);
+	unlock_mount_hash();
+	namespace_unlock();
+
+	mntput(path->mnt);
+	path->mnt = &mnt->mnt;
+	file = dentry_open(path, O_PATH, current_cred());
+	if (IS_ERR(file))
+		dissolve_on_fput(path->mnt);
+	else
+		file->f_mode |= FMODE_NEED_UNMOUNT;
+	return file;
+}
+
+SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
+{
+	struct file *file;
+	struct path path;
+	int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
+	bool detached = flags & OPEN_TREE_CLONE;
+	int error;
+	int fd;
+
+	BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);
+
+	if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
+		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
+		      OPEN_TREE_CLOEXEC))
+		return -EINVAL;
+
+	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE)) == AT_RECURSIVE)
+		return -EINVAL;
+
+	if (flags & AT_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (flags & AT_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	if (detached && !may_mount())
+		return -EPERM;
+
+	fd = get_unused_fd_flags(flags & O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	error = user_path_at(dfd, filename, lookup_flags, &path);
+	if (unlikely(error)) {
+		file = ERR_PTR(error);
+	} else {
+		if (detached)
+			file = open_detached_copy(&path, flags & AT_RECURSIVE);
+		else
+			file = dentry_open(&path, O_PATH, current_cred());
+		path_put(&path);
+	}
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		return PTR_ERR(file);
+	}
+	fd_install(fd, file);
+	return fd;
+}
+
 /*
  * Don't allow locked mount flags to be cleared.
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3e85cb8e8c20..c4ef82689cab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -159,10 +159,13 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
 /* File is capable of returning -EAGAIN if I/O will block */
-#define FMODE_NOWAIT	((__force fmode_t)0x8000000)
+#define FMODE_NOWAIT		((__force fmode_t)0x8000000)
+
+/* File represents mount that needs unmounting */
+#define FMODE_NEED_UNMOUNT	((__force fmode_t)0x10000000)
 
 /* File does not contribute to nr_files count */
-#define FMODE_NOACCOUNT	((__force fmode_t)0x20000000)
+#define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 257cccba3062..07bca6796498 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -926,6 +926,7 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
 			 int flags, uint32_t sig);
+asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6448cdd9a350..594b85f7cb86 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -90,5 +90,7 @@
 #define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
 #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
 
+#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
+
 
 #endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 3f9ec42510b0..fd7ae2e7eccf 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -55,4 +55,10 @@
 #define MS_MGC_VAL 0xC0ED0000
 #define MS_MGC_MSK 0xffff0000
 
+/*
+ * open_tree() flags.
+ */
+#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
+#define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
+
 #endif /* _UAPI_LINUX_MOUNT_H */

