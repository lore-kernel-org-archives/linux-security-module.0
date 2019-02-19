Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BC4C10F00
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AF32083E
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfBSRJ3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:09:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfBSRJ3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:09:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05A3623E6E7;
        Tue, 19 Feb 2019 17:09:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43BF7101E5B1;
        Tue, 19 Feb 2019 17:09:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/10] vfs: syscall: Add fsmount() to create a mount for a
 superblock
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 17:09:25 +0000
Message-ID: <155059616551.17079.6086553789074410155.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 19 Feb 2019 17:09:28 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Provide a system call by which a filesystem opened with fsopen() and
configured by a series of fsconfig() calls can have a detached mount object
created for it.  This mount object can then be attached to the VFS mount
hierarchy using move_mount() by passing the returned file descriptor as the
from directory fd.

The system call looks like:

	int mfd = fsmount(int fsfd, unsigned int flags,
			  unsigned int attr_flags);

where fsfd is the file descriptor returned by fsopen().  flags can be 0 or
FSMOUNT_CLOEXEC.  attr_flags is a bitwise-OR of the following flags:

	MOUNT_ATTR_RDONLY	Mount read-only
	MOUNT_ATTR_NOSUID	Ignore suid and sgid bits
	MOUNT_ATTR_NODEV	Disallow access to device special files
	MOUNT_ATTR_NOEXEC	Disallow program execution
	MOUNT_ATTR__ATIME	Setting on how atime should be updated
	MOUNT_ATTR_RELATIME	- Update atime relative to mtime/ctime
	MOUNT_ATTR_NOATIME	- Do not update access times
	MOUNT_ATTR_STRICTATIME	- Always perform atime updates
	MOUNT_ATTR_NODIRATIME	Do not update directory access times

In the event that fsmount() fails, it may be possible to get an error
message by calling read() on fsfd.  If no message is available, ENODATA
will be reported.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-api@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/namespace.c                         |  146 +++++++++++++++++++++++++++++++-
 include/linux/syscalls.h               |    1 
 include/uapi/linux/mount.h             |   18 ++++
 5 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index f9970310c126..c78b68256f8a 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -402,3 +402,4 @@
 388	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
 389	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
 390	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
+391	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 4185d36e03bb..d44ead5d4368 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -347,6 +347,7 @@
 336	common	move_mount		__x64_sys_move_mount
 337	common	fsopen			__x64_sys_fsopen
 338	common	fsconfig		__x64_sys_fsconfig
+339	common	fsmount			__x64_sys_fsmount
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/namespace.c b/fs/namespace.c
index 56423c60ac7e..43cbce0643ce 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3334,9 +3334,149 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 }
 
 /*
- * Move a mount from one place to another.
- * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be
- * used to copy a mount subtree.
+ * Create a kernel mount representation for a new, prepared superblock
+ * (specified by fs_fd) and attach to an open_tree-like file descriptor.
+ */
+SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
+		unsigned int, attr_flags)
+{
+	struct mnt_namespace *ns;
+	struct fs_context *fc;
+	struct file *file;
+	struct path newmount;
+	struct mount *mnt;
+	struct fd f;
+	unsigned int mnt_flags = 0;
+	long ret;
+
+	if (!may_mount())
+		return -EPERM;
+
+	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0)
+		return -EINVAL;
+
+	if (attr_flags & ~(MOUNT_ATTR_RDONLY |
+			   MOUNT_ATTR_NOSUID |
+			   MOUNT_ATTR_NODEV |
+			   MOUNT_ATTR_NOEXEC |
+			   MOUNT_ATTR__ATIME |
+			   MOUNT_ATTR_NODIRATIME))
+		return -EINVAL;
+
+	if (attr_flags & MOUNT_ATTR_RDONLY)
+		mnt_flags |= MNT_READONLY;
+	if (attr_flags & MOUNT_ATTR_NOSUID)
+		mnt_flags |= MNT_NOSUID;
+	if (attr_flags & MOUNT_ATTR_NODEV)
+		mnt_flags |= MNT_NODEV;
+	if (attr_flags & MOUNT_ATTR_NOEXEC)
+		mnt_flags |= MNT_NOEXEC;
+	if (attr_flags & MOUNT_ATTR_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
+
+	switch (attr_flags & MOUNT_ATTR__ATIME) {
+	case MOUNT_ATTR_STRICTATIME:
+		break;
+	case MOUNT_ATTR_NOATIME:
+		mnt_flags |= MNT_NOATIME;
+		break;
+	case MOUNT_ATTR_RELATIME:
+		mnt_flags |= MNT_RELATIME;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	f = fdget(fs_fd);
+	if (!f.file)
+		return -EBADF;
+
+	ret = -EINVAL;
+	if (f.file->f_op != &fscontext_fops)
+		goto err_fsfd;
+
+	fc = f.file->private_data;
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret < 0)
+		goto err_fsfd;
+
+	/* There must be a valid superblock or we can't mount it */
+	ret = -EINVAL;
+	if (!fc->root)
+		goto err_unlock;
+
+	ret = -EPERM;
+	if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
+		pr_warn("VFS: Mount too revealing\n");
+		goto err_unlock;
+	}
+
+	ret = -EBUSY;
+	if (fc->phase != FS_CONTEXT_AWAITING_MOUNT)
+		goto err_unlock;
+
+	ret = -EPERM;
+	if ((fc->sb_flags & SB_MANDLOCK) && !may_mandlock())
+		goto err_unlock;
+
+	newmount.mnt = vfs_create_mount(fc);
+	if (IS_ERR(newmount.mnt)) {
+		ret = PTR_ERR(newmount.mnt);
+		goto err_unlock;
+	}
+	newmount.dentry = dget(fc->root);
+	newmount.mnt->mnt_flags = mnt_flags;
+
+	/* We've done the mount bit - now move the file context into more or
+	 * less the same state as if we'd done an fspick().  We don't want to
+	 * do any memory allocation or anything like that at this point as we
+	 * don't want to have to handle any errors incurred.
+	 */
+	vfs_clean_context(fc);
+
+	ns = alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
+	if (IS_ERR(ns)) {
+		ret = PTR_ERR(ns);
+		goto err_path;
+	}
+	mnt = real_mount(newmount.mnt);
+	mnt->mnt_ns = ns;
+	ns->root = mnt;
+	ns->mounts = 1;
+	list_add(&mnt->mnt_list, &ns->list);
+
+	/* Attach to an apparent O_PATH fd with a note that we need to unmount
+	 * it, not just simply put it.
+	 */
+	file = dentry_open(&newmount, O_PATH, fc->cred);
+	if (IS_ERR(file)) {
+		dissolve_on_fput(newmount.mnt);
+		ret = PTR_ERR(file);
+		goto err_path;
+	}
+	file->f_mode |= FMODE_NEED_UNMOUNT;
+
+	ret = get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0);
+	if (ret >= 0)
+		fd_install(ret, file);
+	else
+		fput(file);
+
+err_path:
+	path_put(&newmount);
+err_unlock:
+	mutex_unlock(&fc->uapi_mutex);
+err_fsfd:
+	fdput(f);
+	return ret;
+}
+
+/*
+ * Move a mount from one place to another.  In combination with
+ * fsopen()/fsmount() this is used to install a new mount and in combination
+ * with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be used to copy
+ * a mount subtree.
  *
  * Note the flags value is a combination of MOVE_MOUNT_* flags.
  */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2586faf20078..a332a731a0e4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -933,6 +933,7 @@ asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
 asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags);
 asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
 			     const void __user *value, int aux);
+asmlinkage long sys_fsmount(int fs_fd, unsigned int flags, unsigned int ms_flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 4b90ba9d1770..3888d3b91dc5 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -91,4 +91,22 @@ enum fsconfig_command {
 	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
 };
 
+/*
+ * fsmount() flags.
+ */
+#define FSMOUNT_CLOEXEC		0x00000001
+
+/*
+ * Mount attributes.
+ */
+#define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
+#define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
+#define MOUNT_ATTR_NODEV	0x00000004 /* Disallow access to device special files */
+#define MOUNT_ATTR_NOEXEC	0x00000008 /* Disallow program execution */
+#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
+#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
+#define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
+#define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
+#define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
+
 #endif /* _UAPI_LINUX_MOUNT_H */

