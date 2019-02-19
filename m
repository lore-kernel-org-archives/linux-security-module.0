Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5567C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3742147A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfBSRJW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:09:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfBSRJV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:09:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A449C0ABF42;
        Tue, 19 Feb 2019 17:09:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C54C611CD;
        Tue, 19 Feb 2019 17:09:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/10] vfs: syscall: Add fsconfig() for configuring and
 managing a context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 17:09:17 +0000
Message-ID: <155059615769.17079.1506747783214959507.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 19 Feb 2019 17:09:20 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a syscall for configuring a filesystem creation context and triggering
actions upon it, to be used in conjunction with fsopen, fspick and fsmount.

    long fsconfig(int fs_fd, unsigned int cmd, const char *key,
		  const void *value, int aux);

Where fs_fd indicates the context, cmd indicates the action to take, key
indicates the parameter name for parameter-setting actions and, if needed,
value points to a buffer containing the value and aux can give more
information for the value.

The following command IDs are proposed:

 (*) FSCONFIG_SET_FLAG: No value is specified.  The parameter must be
     boolean in nature.  The key may be prefixed with "no" to invert the
     setting. value must be NULL and aux must be 0.

 (*) FSCONFIG_SET_STRING: A string value is specified.  The parameter can
     be expecting boolean, integer, string or take a path.  A conversion to
     an appropriate type will be attempted (which may include looking up as
     a path).  value points to a NUL-terminated string and aux must be 0.

 (*) FSCONFIG_SET_BINARY: A binary blob is specified.  value points to
     the blob and aux indicates its size.  The parameter must be expecting
     a blob.

 (*) FSCONFIG_SET_PATH: A non-empty path is specified.  The parameter must
     be expecting a path object.  value points to a NUL-terminated string
     that is the path and aux is a file descriptor at which to start a
     relative lookup or AT_FDCWD.

 (*) FSCONFIG_SET_PATH_EMPTY: As fsconfig_set_path, but with AT_EMPTY_PATH
     implied.

 (*) FSCONFIG_SET_FD: An open file descriptor is specified.  value must
     be NULL and aux indicates the file descriptor.

 (*) FSCONFIG_CMD_CREATE: Trigger superblock creation.

 (*) FSCONFIG_CMD_RECONFIGURE: Trigger superblock reconfiguration.

For the "set" command IDs, the idea is that the file_system_type will point
to a list of parameters and the types of value that those parameters expect
to take.  The core code can then do the parse and argument conversion and
then give the LSM and FS a cooked option or array of options to use.

Source specification is also done the same way same way, using special keys
"source", "source1", "source2", etc..

[!] Note that, for the moment, the key and value are just glued back
together and handed to the filesystem.  Every filesystem that uses options
uses match_token() and co. to do this, and this will need to be changed -
but not all at once.

Example usage:

    fd = fsopen("ext4", FSOPEN_CLOEXEC);
    fsconfig(fd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);
    fsconfig(fd, fsconfig_set_path_empty, "journal_path", "", journal_fd);
    fsconfig(fd, fsconfig_set_fd, "journal_fd", "", journal_fd);
    fsconfig(fd, fsconfig_set_flag, "user_xattr", NULL, 0);
    fsconfig(fd, fsconfig_set_flag, "noacl", NULL, 0);
    fsconfig(fd, fsconfig_set_string, "sb", "1", 0);
    fsconfig(fd, fsconfig_set_string, "errors", "continue", 0);
    fsconfig(fd, fsconfig_set_string, "data", "journal", 0);
    fsconfig(fd, fsconfig_set_string, "context", "unconfined_u:...", 0);
    fsconfig(fd, fsconfig_cmd_create, NULL, NULL, 0);
    mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);

or:

    fd = fsopen("ext4", FSOPEN_CLOEXEC);
    fsconfig(fd, fsconfig_set_string, "source", "/dev/sda1", 0);
    fsconfig(fd, fsconfig_cmd_create, NULL, NULL, 0);
    mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);

or:

    fd = fsopen("afs", FSOPEN_CLOEXEC);
    fsconfig(fd, fsconfig_set_string, "source", "#grand.central.org:root.cell", 0);
    fsconfig(fd, fsconfig_cmd_create, NULL, NULL, 0);
    mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);

or:

    fd = fsopen("jffs2", FSOPEN_CLOEXEC);
    fsconfig(fd, fsconfig_set_string, "source", "mtd0", 0);
    fsconfig(fd, fsconfig_cmd_create, NULL, NULL, 0);
    mfd = fsmount(fd, FSMOUNT_CLOEXEC, MS_NOEXEC);

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-api@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/fs_context.c                        |   51 ++++++
 fs/fsopen.c                            |  265 ++++++++++++++++++++++++++++++++
 fs/internal.h                          |    3 
 include/linux/syscalls.h               |    2 
 include/uapi/linux/mount.h             |   14 ++
 7 files changed, 337 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 1647fefd2969..f9970310c126 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -401,3 +401,4 @@
 387	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
 388	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
 389	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
+390	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 235d33dbccb2..4185d36e03bb 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -346,6 +346,7 @@
 335	common	open_tree		__x64_sys_open_tree
 336	common	move_mount		__x64_sys_move_mount
 337	common	fsopen			__x64_sys_fsopen
+338	common	fsconfig		__x64_sys_fsconfig
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/fs_context.c b/fs/fs_context.c
index dcf3786f90f9..a47ccd5a4a78 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -721,3 +721,54 @@ int parse_monolithic_mount_data(struct fs_context *fc, void *data)
 
 	return monolithic_mount_data(fc, data);
 }
+
+/*
+ * Clean up a context after performing an action on it and put it into a state
+ * from where it can be used to reconfigure a superblock.
+ *
+ * Note that here we do only the parts that can't fail; the rest is in
+ * finish_clean_context() below and in between those fs_context is marked
+ * FS_CONTEXT_AWAITING_RECONF.  The reason for splitup is that after
+ * successful mount or remount we need to report success to userland.
+ * Trying to do full reinit (for the sake of possible subsequent remount)
+ * and failing to allocate memory would've put us into a nasty situation.
+ * So here we only discard the old state and reinitialization is left
+ * until we actually try to reconfigure.
+ */
+void vfs_clean_context(struct fs_context *fc)
+{
+	if (fc->need_free && fc->ops && fc->ops->free)
+		fc->ops->free(fc);
+	fc->need_free = false;
+	fc->fs_private = NULL;
+	fc->s_fs_info = NULL;
+	fc->sb_flags = 0;
+	security_free_mnt_opts(&fc->security);
+	kfree(fc->subtype);
+	fc->subtype = NULL;
+	kfree(fc->source);
+	fc->source = NULL;
+
+	fc->purpose = FS_CONTEXT_FOR_RECONFIGURE;
+	fc->phase = FS_CONTEXT_AWAITING_RECONF;
+}
+
+int finish_clean_context(struct fs_context *fc)
+{
+	int error;
+
+	if (fc->phase != FS_CONTEXT_AWAITING_RECONF)
+		return 0;
+
+	if (fc->fs_type->init_fs_context)
+		error = fc->fs_type->init_fs_context(fc);
+	else
+		error = legacy_init_fs_context(fc);
+	if (unlikely(error)) {
+		fc->phase = FS_CONTEXT_FAILED;
+		return error;
+	}
+	fc->need_free = true;
+	fc->phase = FS_CONTEXT_RECONF_PARAMS;
+	return 0;
+}
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 5fce6347de7a..65cc2f68f994 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -18,6 +19,7 @@
 #include <linux/namei.h>
 #include <linux/file.h>
 #include <uapi/linux/mount.h>
+#include "internal.h"
 #include "mount.h"
 
 /*
@@ -153,3 +155,266 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	put_fs_context(fc);
 	return ret;
 }
+
+/*
+ * Check the state and apply the configuration.  Note that this function is
+ * allowed to 'steal' the value by setting param->xxx to NULL before returning.
+ */
+static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
+			       struct fs_parameter *param)
+{
+	struct super_block *sb;
+	int ret;
+
+	ret = finish_clean_context(fc);
+	if (ret)
+		return ret;
+	switch (cmd) {
+	case FSCONFIG_CMD_CREATE:
+		if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
+			return -EBUSY;
+		fc->phase = FS_CONTEXT_CREATING;
+		ret = vfs_get_tree(fc);
+		if (ret)
+			break;
+		sb = fc->root->d_sb;
+		ret = security_sb_kern_mount(sb);
+		if (unlikely(ret)) {
+			fc_drop_locked(fc);
+			break;
+		}
+		up_write(&sb->s_umount);
+		fc->phase = FS_CONTEXT_AWAITING_MOUNT;
+		return 0;
+	case FSCONFIG_CMD_RECONFIGURE:
+		if (fc->phase != FS_CONTEXT_RECONF_PARAMS)
+			return -EBUSY;
+		fc->phase = FS_CONTEXT_RECONFIGURING;
+		sb = fc->root->d_sb;
+		if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
+			ret = -EPERM;
+			break;
+		}
+		down_write(&sb->s_umount);
+		ret = reconfigure_super(fc);
+		up_write(&sb->s_umount);
+		if (ret)
+			break;
+		vfs_clean_context(fc);
+		return 0;
+	default:
+		if (fc->phase != FS_CONTEXT_CREATE_PARAMS &&
+		    fc->phase != FS_CONTEXT_RECONF_PARAMS)
+			return -EBUSY;
+
+		return vfs_parse_fs_param(fc, param);
+	}
+	fc->phase = FS_CONTEXT_FAILED;
+	return ret;
+}
+
+/**
+ * sys_fsconfig - Set parameters and trigger actions on a context
+ * @fd: The filesystem context to act upon
+ * @cmd: The action to take
+ * @_key: Where appropriate, the parameter key to set
+ * @_value: Where appropriate, the parameter value to set
+ * @aux: Additional information for the value
+ *
+ * This system call is used to set parameters on a context, including
+ * superblock settings, data source and security labelling.
+ *
+ * Actions include triggering the creation of a superblock and the
+ * reconfiguration of the superblock attached to the specified context.
+ *
+ * When setting a parameter, @cmd indicates the type of value being proposed
+ * and @_key indicates the parameter to be altered.
+ *
+ * @_value and @aux are used to specify the value, should a value be required:
+ *
+ * (*) fsconfig_set_flag: No value is specified.  The parameter must be boolean
+ *     in nature.  The key may be prefixed with "no" to invert the
+ *     setting. @_value must be NULL and @aux must be 0.
+ *
+ * (*) fsconfig_set_string: A string value is specified.  The parameter can be
+ *     expecting boolean, integer, string or take a path.  A conversion to an
+ *     appropriate type will be attempted (which may include looking up as a
+ *     path).  @_value points to a NUL-terminated string and @aux must be 0.
+ *
+ * (*) fsconfig_set_binary: A binary blob is specified.  @_value points to the
+ *     blob and @aux indicates its size.  The parameter must be expecting a
+ *     blob.
+ *
+ * (*) fsconfig_set_path: A non-empty path is specified.  The parameter must be
+ *     expecting a path object.  @_value points to a NUL-terminated string that
+ *     is the path and @aux is a file descriptor at which to start a relative
+ *     lookup or AT_FDCWD.
+ *
+ * (*) fsconfig_set_path_empty: As fsconfig_set_path, but with AT_EMPTY_PATH
+ *     implied.
+ *
+ * (*) fsconfig_set_fd: An open file descriptor is specified.  @_value must be
+ *     NULL and @aux indicates the file descriptor.
+ */
+SYSCALL_DEFINE5(fsconfig,
+		int, fd,
+		unsigned int, cmd,
+		const char __user *, _key,
+		const void __user *, _value,
+		int, aux)
+{
+	struct fs_context *fc;
+	struct fd f;
+	int ret;
+
+	struct fs_parameter param = {
+		.type	= fs_value_is_undefined,
+	};
+
+	if (fd < 0)
+		return -EINVAL;
+
+	switch (cmd) {
+	case FSCONFIG_SET_FLAG:
+		if (!_key || _value || aux)
+			return -EINVAL;
+		break;
+	case FSCONFIG_SET_STRING:
+		if (!_key || !_value || aux)
+			return -EINVAL;
+		break;
+	case FSCONFIG_SET_BINARY:
+		if (!_key || !_value || aux <= 0 || aux > 1024 * 1024)
+			return -EINVAL;
+		break;
+	case FSCONFIG_SET_PATH:
+	case FSCONFIG_SET_PATH_EMPTY:
+		if (!_key || !_value || (aux != AT_FDCWD && aux < 0))
+			return -EINVAL;
+		break;
+	case FSCONFIG_SET_FD:
+		if (!_key || _value || aux < 0)
+			return -EINVAL;
+		break;
+	case FSCONFIG_CMD_CREATE:
+	case FSCONFIG_CMD_RECONFIGURE:
+		if (_key || _value || aux)
+			return -EINVAL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+	ret = -EINVAL;
+	if (f.file->f_op != &fscontext_fops)
+		goto out_f;
+
+	fc = f.file->private_data;
+	if (fc->ops == &legacy_fs_context_ops) {
+		switch (cmd) {
+		case FSCONFIG_SET_BINARY:
+		case FSCONFIG_SET_PATH:
+		case FSCONFIG_SET_PATH_EMPTY:
+		case FSCONFIG_SET_FD:
+			ret = -EOPNOTSUPP;
+			goto out_f;
+		}
+	}
+
+	if (_key) {
+		param.key = strndup_user(_key, 256);
+		if (IS_ERR(param.key)) {
+			ret = PTR_ERR(param.key);
+			goto out_f;
+		}
+	}
+
+	switch (cmd) {
+	case FSCONFIG_SET_FLAG:
+		param.type = fs_value_is_flag;
+		break;
+	case FSCONFIG_SET_STRING:
+		param.type = fs_value_is_string;
+		param.string = strndup_user(_value, 256);
+		if (IS_ERR(param.string)) {
+			ret = PTR_ERR(param.string);
+			goto out_key;
+		}
+		param.size = strlen(param.string);
+		break;
+	case FSCONFIG_SET_BINARY:
+		param.type = fs_value_is_blob;
+		param.size = aux;
+		param.blob = memdup_user_nul(_value, aux);
+		if (IS_ERR(param.blob)) {
+			ret = PTR_ERR(param.blob);
+			goto out_key;
+		}
+		break;
+	case FSCONFIG_SET_PATH:
+		param.type = fs_value_is_filename;
+		param.name = getname_flags(_value, 0, NULL);
+		if (IS_ERR(param.name)) {
+			ret = PTR_ERR(param.name);
+			goto out_key;
+		}
+		param.dirfd = aux;
+		param.size = strlen(param.name->name);
+		break;
+	case FSCONFIG_SET_PATH_EMPTY:
+		param.type = fs_value_is_filename_empty;
+		param.name = getname_flags(_value, LOOKUP_EMPTY, NULL);
+		if (IS_ERR(param.name)) {
+			ret = PTR_ERR(param.name);
+			goto out_key;
+		}
+		param.dirfd = aux;
+		param.size = strlen(param.name->name);
+		break;
+	case FSCONFIG_SET_FD:
+		param.type = fs_value_is_file;
+		ret = -EBADF;
+		param.file = fget(aux);
+		if (!param.file)
+			goto out_key;
+		break;
+	default:
+		break;
+	}
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret == 0) {
+		ret = vfs_fsconfig_locked(fc, cmd, &param);
+		mutex_unlock(&fc->uapi_mutex);
+	}
+
+	/* Clean up the our record of any value that we obtained from
+	 * userspace.  Note that the value may have been stolen by the LSM or
+	 * filesystem, in which case the value pointer will have been cleared.
+	 */
+	switch (cmd) {
+	case FSCONFIG_SET_STRING:
+	case FSCONFIG_SET_BINARY:
+		kfree(param.string);
+		break;
+	case FSCONFIG_SET_PATH:
+	case FSCONFIG_SET_PATH_EMPTY:
+		if (param.name)
+			putname(param.name);
+		break;
+	case FSCONFIG_SET_FD:
+		if (param.file)
+			fput(param.file);
+		break;
+	default:
+		break;
+	}
+out_key:
+	kfree(param.key);
+out_f:
+	fdput(f);
+	return ret;
+}
diff --git a/fs/internal.h b/fs/internal.h
index f3a027c44758..95cf7b0af21f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -55,8 +55,11 @@ extern void __init chrdev_init(void);
 /*
  * fs_context.c
  */
+extern const struct fs_context_operations legacy_fs_context_ops;
 extern int parse_monolithic_mount_data(struct fs_context *, void *);
 extern void fc_drop_locked(struct fs_context *);
+extern void vfs_clean_context(struct fs_context *fc);
+extern int finish_clean_context(struct fs_context *fc);
 
 /*
  * namei.c
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 22ed8a11ef55..2586faf20078 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -931,6 +931,8 @@ asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
 			       int to_dfd, const char __user *to_path,
 			       unsigned int ms_flags);
 asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags);
+asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
+			     const void __user *value, int aux);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 7570df43d08f..4b90ba9d1770 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -77,4 +77,18 @@
  */
 #define FSOPEN_CLOEXEC		0x00000001
 
+/*
+ * The type of fsconfig() call made.
+ */
+enum fsconfig_command {
+	FSCONFIG_SET_FLAG	= 0,	/* Set parameter, supplying no value */
+	FSCONFIG_SET_STRING	= 1,	/* Set parameter, supplying a string value */
+	FSCONFIG_SET_BINARY	= 2,	/* Set parameter, supplying a binary blob value */
+	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
+	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
+	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
+	FSCONFIG_CMD_CREATE	= 6,	/* Invoke superblock creation */
+	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
+};
+
 #endif /* _UAPI_LINUX_MOUNT_H */

