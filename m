Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC1C4360F
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9483C2147A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfBSRIm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:08:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfBSRIm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:08:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42292C04BD35;
        Tue, 19 Feb 2019 17:08:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96E2C37DE;
        Tue, 19 Feb 2019 17:08:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts around
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 17:08:38 +0000
Message-ID: <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 19 Feb 2019 17:08:41 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a move_mount() system call that will move a mount from one place to
another and, in the next commit, allow to attach an unattached mount tree.

The new system call looks like the following:

	int move_mount(int from_dfd, const char *from_path,
		       int to_dfd, const char *to_path,
		       unsigned int flags);

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-api@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/namespace.c                         |  126 ++++++++++++++++++++++++--------
 include/linux/lsm_hooks.h              |    6 ++
 include/linux/security.h               |    7 ++
 include/linux/syscalls.h               |    3 +
 include/uapi/linux/mount.h             |   11 +++
 security/security.c                    |    5 +
 8 files changed, 129 insertions(+), 31 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ea1b413afd47..76d092b7d1b0 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -399,3 +399,4 @@
 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
 387	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
+388	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 0545bed581dc..37ba4e65eee6 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -344,6 +344,7 @@
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
 335	common	open_tree		__x64_sys_open_tree
+336	common	move_mount		__x64_sys_move_mount
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/namespace.c b/fs/namespace.c
index 112d46f26fc3..f10122028a11 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2537,72 +2537,81 @@ static inline int tree_contains_unbindable(struct mount *mnt)
 	return 0;
 }
 
-static int do_move_mount(struct path *path, const char *old_name)
+static int do_move_mount(struct path *old_path, struct path *new_path)
 {
-	struct path old_path, parent_path;
+	struct path parent_path = {.mnt = NULL, .dentry = NULL};
 	struct mount *p;
 	struct mount *old;
 	struct mountpoint *mp;
 	int err;
-	if (!old_name || !*old_name)
-		return -EINVAL;
-	err = kern_path(old_name, LOOKUP_FOLLOW, &old_path);
-	if (err)
-		return err;
 
-	mp = lock_mount(path);
-	err = PTR_ERR(mp);
+	mp = lock_mount(new_path);
 	if (IS_ERR(mp))
-		goto out;
+		return PTR_ERR(mp);
 
-	old = real_mount(old_path.mnt);
-	p = real_mount(path->mnt);
+	old = real_mount(old_path->mnt);
+	p = real_mount(new_path->mnt);
 
 	err = -EINVAL;
 	if (!check_mnt(p) || !check_mnt(old))
-		goto out1;
+		goto out;
 
-	if (old->mnt.mnt_flags & MNT_LOCKED)
-		goto out1;
+	if (!mnt_has_parent(old))
+		goto out;
 
-	err = -EINVAL;
-	if (old_path.dentry != old_path.mnt->mnt_root)
-		goto out1;
+	if (old->mnt.mnt_flags & MNT_LOCKED)
+		goto out;
 
-	if (!mnt_has_parent(old))
-		goto out1;
+	if (old_path->dentry != old_path->mnt->mnt_root)
+		goto out;
 
-	if (d_is_dir(path->dentry) !=
-	      d_is_dir(old_path.dentry))
-		goto out1;
+	if (d_is_dir(new_path->dentry) !=
+	    d_is_dir(old_path->dentry))
+		goto out;
 	/*
 	 * Don't move a mount residing in a shared parent.
 	 */
 	if (IS_MNT_SHARED(old->mnt_parent))
-		goto out1;
+		goto out;
 	/*
 	 * Don't move a mount tree containing unbindable mounts to a destination
 	 * mount which is shared.
 	 */
 	if (IS_MNT_SHARED(p) && tree_contains_unbindable(old))
-		goto out1;
+		goto out;
 	err = -ELOOP;
 	for (; mnt_has_parent(p); p = p->mnt_parent)
 		if (p == old)
-			goto out1;
+			goto out;
 
-	err = attach_recursive_mnt(old, real_mount(path->mnt), mp, &parent_path);
+	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
+				   &parent_path);
 	if (err)
-		goto out1;
+		goto out;
 
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old->mnt_expire);
-out1:
-	unlock_mount(mp);
 out:
+	unlock_mount(mp);
 	if (!err)
 		path_put(&parent_path);
+	return err;
+}
+
+static int do_move_mount_old(struct path *path, const char *old_name)
+{
+	struct path old_path;
+	int err;
+
+	if (!old_name || !*old_name)
+		return -EINVAL;
+
+	err = kern_path(old_name, LOOKUP_FOLLOW, &old_path);
+	if (err)
+		return err;
+
+	err = do_move_mount(&old_path, path);
 	path_put(&old_path);
 	return err;
 }
@@ -3050,7 +3059,7 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
 		retval = do_change_type(&path, flags);
 	else if (flags & MS_MOVE)
-		retval = do_move_mount(&path, dev_name);
+		retval = do_move_mount_old(&path, dev_name);
 	else
 		retval = do_new_mount(&path, type_page, sb_flags, mnt_flags,
 				      dev_name, data_page);
@@ -3278,6 +3287,61 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	return ksys_mount(dev_name, dir_name, type, flags, data);
 }
 
+/*
+ * Move a mount from one place to another.
+ *
+ * Note the flags value is a combination of MOVE_MOUNT_* flags.
+ */
+SYSCALL_DEFINE5(move_mount,
+		int, from_dfd, const char *, from_pathname,
+		int, to_dfd, const char *, to_pathname,
+		unsigned int, flags)
+{
+	struct path from_path, to_path;
+	unsigned int lflags;
+	int ret = 0;
+
+	if (!may_mount())
+		return -EPERM;
+
+	if (flags & ~MOVE_MOUNT__MASK)
+		return -EINVAL;
+
+	/* If someone gives a pathname, they aren't permitted to move
+	 * from an fd that requires unmount as we can't get at the flag
+	 * to clear it afterwards.
+	 */
+	lflags = 0;
+	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
+	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	lflags |= LOOKUP_EMPTY;
+
+	ret = user_path_at(from_dfd, from_pathname, lflags, &from_path);
+	if (ret < 0)
+		return ret;
+
+	lflags = 0;
+	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
+	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	lflags |= LOOKUP_EMPTY;
+
+	ret = user_path_at(to_dfd, to_pathname, lflags, &to_path);
+	if (ret < 0)
+		goto out_from;
+
+	ret = security_move_mount(&from_path, &to_path);
+	if (ret < 0)
+		goto out_to;
+
+	ret = do_move_mount(&from_path, &to_path);
+
+out_to:
+	path_put(&to_path);
+out_from:
+	path_put(&from_path);
+	return ret;
+}
+
 /*
  * Return true if path is reachable from root
  *
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 356e78fe90a8..89892a031ecf 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -160,6 +160,10 @@
  *	Parse a string of security data filling in the opts structure
  *	@options string containing all mount options known by the LSM
  *	@opts binary data structure usable by the LSM
+ * @move_mount:
+ *	Check permission before a mount is moved.
+ *	@from_path indicates the mount that is going to be moved.
+ *	@to_path indicates the mountpoint that will be mounted upon.
  * @dentry_init_security:
  *	Compute a context for a dentry as the inode is not yet available
  *	since NFSv4 has no label backed by an EA anyway.
@@ -1500,6 +1504,7 @@ union security_list_options {
 					unsigned long *set_kern_flags);
 	int (*sb_add_mnt_opt)(const char *option, const char *val, int len,
 			      void **mnt_opts);
+	int (*move_mount)(const struct path *from_path, const struct path *to_path);
 	int (*dentry_init_security)(struct dentry *dentry, int mode,
 					const struct qstr *name, void **ctx,
 					u32 *ctxlen);
@@ -1835,6 +1840,7 @@ struct security_hook_heads {
 	struct hlist_head sb_set_mnt_opts;
 	struct hlist_head sb_clone_mnt_opts;
 	struct hlist_head sb_add_mnt_opt;
+	struct hlist_head move_mount;
 	struct hlist_head dentry_init_security;
 	struct hlist_head dentry_create_files_as;
 #ifdef CONFIG_SECURITY_PATH
diff --git a/include/linux/security.h b/include/linux/security.h
index f28a1ebfd78e..edc48e61c8b4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -247,6 +247,7 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				unsigned long *set_kern_flags);
 int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
+int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name, void **ctx,
 					u32 *ctxlen);
@@ -609,6 +610,12 @@ static inline int security_add_mnt_opt(const char *option, const char *val,
 	return 0;
 }
 
+static inline int security_move_mount(const struct path *from_path,
+				      const struct path *to_path)
+{
+	return 0;
+}
+
 static inline int security_inode_alloc(struct inode *inode)
 {
 	return 0;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 07bca6796498..13289cdf6b52 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -927,6 +927,9 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
 			 int flags, uint32_t sig);
 asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
+asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
+			       int to_dfd, const char __user *to_path,
+			       unsigned int ms_flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index fd7ae2e7eccf..3634e065836c 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -61,4 +61,15 @@
 #define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
+/*
+ * move_mount() flags.
+ */
+#define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */
+#define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
+#define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
+#define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
+#define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
+#define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
+#define MOVE_MOUNT__MASK		0x00000077
+
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/security/security.c b/security/security.c
index 5759339319dc..6fe31b31dc74 100644
--- a/security/security.c
+++ b/security/security.c
@@ -476,6 +476,11 @@ int security_add_mnt_opt(const char *option, const char *val, int len,
 }
 EXPORT_SYMBOL(security_add_mnt_opt);
 
+int security_move_mount(const struct path *from_path, const struct path *to_path)
+{
+	return call_int_hook(move_mount, 0, from_path, to_path);
+}
+
 int security_inode_alloc(struct inode *inode)
 {
 	inode->i_security = NULL;

