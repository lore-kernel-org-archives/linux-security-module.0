Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41676C43217
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKBRMY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiKBRLx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:53 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BAF1B9C4
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:11:50 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HAtn7021880;
        Thu, 3 Nov 2022 02:10:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 03 Nov 2022 02:10:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HAnkG021849
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2022 02:10:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 05/10] CaitSith: Add LSM interface management file.
Date:   Thu,  3 Nov 2022 02:10:20 +0900
Message-Id: <20221102171025.126961-5-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This file is used for registering CaitSith module into the
security_hook_heads list. Further patches will not be interesting for
reviewers, for further patches are providing similar functions provided
by TOMOYO (but too different to share the code).

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/caitsith/lsm.c | 1358 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 1358 insertions(+)
 create mode 100644 security/caitsith/lsm.c

diff --git a/security/caitsith/lsm.c b/security/caitsith/lsm.c
new file mode 100644
index 000000000000..1a487b4021c6
--- /dev/null
+++ b/security/caitsith/lsm.c
@@ -0,0 +1,1358 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * lsm.c
+ *
+ * Copyright (C) 2010-2013  Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
+ *
+ * Version: 0.2.10   2021/06/06
+ */
+
+#include "caitsith.h"
+#include <linux/lsm_hooks.h>
+
+/* Prototype definition. */
+static int __cs_alloc_task_security(const struct task_struct *task);
+static void __cs_free_task_security(const struct task_struct *task);
+
+/* Dummy security context for avoiding NULL pointer dereference. */
+static struct cs_security cs_oom_security = {
+	.cs_domain_info = &cs_kernel_domain
+};
+
+/* Dummy security context for avoiding NULL pointer dereference. */
+static struct cs_security cs_default_security = {
+	.cs_domain_info = &cs_kernel_domain
+};
+
+/* List of "struct cs_security". */
+struct list_head cs_task_security_list[CS_MAX_TASK_SECURITY_HASH];
+/* Lock for protecting cs_task_security_list[]. */
+static DEFINE_SPINLOCK(cs_task_security_list_lock);
+
+/* Original hooks. */
+static union security_list_options original_cred_prepare;
+static union security_list_options original_task_alloc;
+static union security_list_options original_task_free;
+
+#if !defined(CONFIG_SECURITY_CAITSITH_DEBUG)
+#define cs_debug_trace(pos) do { } while (0)
+#else
+#define cs_debug_trace(pos)						\
+	do {								\
+		static bool done;					\
+		if (!done) {						\
+			pr_info("CAITSITH: Debug trace: " pos " of 2\n"); \
+			done = true;					\
+		}							\
+	} while (0)
+#endif
+
+/**
+ * cs_clear_execve - Release memory used by do_execve().
+ *
+ * @ret:      0 if do_execve() succeeded, negative value otherwise.
+ * @security: Pointer to "struct cs_security".
+ *
+ * Returns nothing.
+ */
+static void cs_clear_execve(int ret, struct cs_security *security)
+{
+	struct cs_request_info *r = security->r;
+
+	if (security == &cs_default_security || security == &cs_oom_security ||
+	    !r)
+		return;
+	security->r = NULL;
+	cs_finish_execve(ret, r);
+}
+
+/**
+ * cs_task_alloc_security - Allocate memory for new tasks.
+ *
+ * @p: Pointer to "struct task_struct".
+ * @clone_flags: Flags passed to clone().
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_task_alloc_security(struct task_struct *p,
+				   unsigned long clone_flags)
+{
+	int rc = __cs_alloc_task_security(p);
+
+	if (rc)
+		return rc;
+	if (original_task_alloc.task_alloc) {
+		rc = original_task_alloc.task_alloc(p, clone_flags);
+		if (rc)
+			__cs_free_task_security(p);
+	}
+	return rc;
+}
+
+/**
+ * cs_task_free_security - Release memory for "struct task_struct".
+ *
+ * @p: Pointer to "struct task_struct".
+ *
+ * Returns nothing.
+ */
+static void cs_task_free_security(struct task_struct *p)
+{
+	struct cs_security *ptr = cs_find_task_security(p);
+	struct cs_request_info *r = ptr->r;
+
+	if (original_task_free.task_free)
+		original_task_free.task_free(p);
+	/*
+	 * Since an LSM hook for reverting domain transition is missing,
+	 * cs_finish_execve() is not called if exited immediately after
+	 * execve() failed.
+	 */
+	if (r) {
+		cs_debug_trace("2");
+		kfree(r);
+		ptr->r = NULL;
+	}
+	__cs_free_task_security(p);
+}
+
+/**
+ * __cs_free_task_security - Release memory associated with "struct task_struct".
+ *
+ * @task: Pointer to "struct task_struct".
+ *
+ * Returns nothing.
+ */
+static void __cs_free_task_security(const struct task_struct *task)
+{
+	unsigned long flags;
+	struct cs_security *ptr = cs_find_task_security(task);
+
+	if (ptr == &cs_default_security || ptr == &cs_oom_security)
+		return;
+	spin_lock_irqsave(&cs_task_security_list_lock, flags);
+	list_del_rcu(&ptr->list);
+	spin_unlock_irqrestore(&cs_task_security_list_lock, flags);
+	kfree_rcu(ptr, rcu);
+}
+
+/**
+ * cs_cred_prepare - Allocate memory for new credentials.
+ *
+ * @new: Pointer to "struct cred".
+ * @old: Pointer to "struct cred".
+ * @gfp: Memory allocation flags.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_cred_prepare(struct cred *new, const struct cred *old,
+			   gfp_t gfp)
+{
+	/*
+	 * For checking whether reverting domain transition is needed or not.
+	 *
+	 * See cs_find_task_security() for reason.
+	 */
+	if (gfp == GFP_KERNEL)
+		cs_find_task_security(current);
+	if (original_cred_prepare.cred_prepare)
+		return original_cred_prepare.cred_prepare(new, old, gfp);
+	return 0;
+}
+
+/**
+ * cs_bprm_committing_creds - A hook which is called when do_execve() succeeded.
+ *
+ * @bprm: Pointer to "struct linux_binprm".
+ *
+ * Returns nothing.
+ */
+static void cs_bprm_committing_creds(struct linux_binprm *bprm)
+{
+	cs_clear_execve(0, cs_current_security());
+}
+
+#ifndef CONFIG_SECURITY_CAITSITH_OMIT_USERSPACE_LOADER
+
+/**
+ * cs_policy_loader_exists - Check whether /sbin/caitsith-init exists.
+ *
+ * Returns true if /sbin/caitsith-init exists, false otherwise.
+ */
+static _Bool cs_policy_loader_exists(void)
+{
+	struct path path;
+
+	if (kern_path(CONFIG_SECURITY_CAITSITH_POLICY_LOADER, LOOKUP_FOLLOW, &path)
+	    == 0) {
+		path_put(&path);
+		return 1;
+	}
+	pr_info("Not activating CaitSith as %s does not exist.\n",
+		CONFIG_SECURITY_CAITSITH_POLICY_LOADER);
+	return 0;
+}
+
+/**
+ * cs_load_policy - Run external policy loader to load policy.
+ *
+ * @filename: The program about to start.
+ *
+ * Returns nothing.
+ *
+ * This function checks whether @filename is /sbin/init, and if so
+ * invoke /sbin/caitsith-init and wait for the termination of
+ * /sbin/caitsith-init and then continues invocation of /sbin/init.
+ * /sbin/caitsith-init reads policy files in /etc/caitsith/ directory and
+ * writes to /sys/kernel/security/caitsith/ interfaces.
+ */
+static void cs_load_policy(const char *filename)
+{
+	static _Bool done;
+
+	if (done)
+		return;
+	if (strcmp(filename, CONFIG_SECURITY_CAITSITH_ACTIVATION_TRIGGER))
+		return;
+	if (!cs_policy_loader_exists())
+		return;
+	done = 1;
+	{
+		char *argv[2];
+		char *envp[3];
+
+		pr_info("Calling %s to load policy. Please wait.\n",
+			CONFIG_SECURITY_CAITSITH_POLICY_LOADER);
+		argv[0] = (char *) CONFIG_SECURITY_CAITSITH_POLICY_LOADER;
+		argv[1] = NULL;
+		envp[0] = "HOME=/";
+		envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+		envp[2] = NULL;
+		call_usermodehelper(argv[0], argv, envp, UMH_WAIT_PROC);
+	}
+	cs_check_profile();
+}
+
+#endif
+
+/**
+ * cs_bprm_check_security - Check permission for execve().
+ *
+ * @bprm: Pointer to "struct linux_binprm".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_bprm_check_security(struct linux_binprm *bprm)
+{
+	struct cs_security *security = cs_current_security();
+
+	if (security == &cs_default_security || security == &cs_oom_security)
+		return -ENOMEM;
+	if (security->r)
+		return 0;
+#ifndef CONFIG_SECURITY_CAITSITH_OMIT_USERSPACE_LOADER
+	if (!cs_policy_loaded)
+		cs_load_policy(bprm->filename);
+#endif
+	return cs_start_execve(bprm, &security->r);
+}
+
+/**
+ * cs_file_open - Check permission for open().
+ *
+ * @f:    Pointer to "struct file".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_file_open(struct file *f)
+{
+	return cs_open_permission(&f->f_path, f->f_flags);
+}
+
+#ifdef CONFIG_SECURITY_PATH
+
+/**
+ * cs_path_chown - Check permission for chown()/chgrp().
+ *
+ * @path:  Pointer to "struct path".
+ * @user:  User ID.
+ * @group: Group ID.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_chown(const struct path *path, kuid_t user, kgid_t group)
+{
+	return cs_chown_permission(path, user, group);
+}
+
+/**
+ * cs_path_chmod - Check permission for chmod().
+ *
+ * @path: Pointer to "struct path".
+ * @mode: Mode.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_chmod(const struct path *path, umode_t mode)
+{
+	return cs_chmod_permission(path, mode);
+}
+
+/**
+ * cs_path_chroot - Check permission for chroot().
+ *
+ * @path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_chroot(const struct path *path)
+{
+	return cs_chroot_permission(path);
+}
+
+/**
+ * cs_path_truncate - Check permission for truncate().
+ *
+ * @path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_truncate(const struct path *path)
+{
+	return cs_truncate_permission(path);
+}
+
+#else
+
+/**
+ * cs_inode_setattr - Check permission for chown()/chgrp()/chmod()/truncate().
+ *
+ * @dentry: Pointer to "struct dentry".
+ * @attr:   Pointer to "struct iattr".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	int rc = 0;
+	struct path path = { .mnt = NULL, .dentry = dentry };
+
+	if (attr->ia_valid & ATTR_UID)
+		rc = cs_chown_permission(&path, attr->ia_uid, INVALID_GID);
+	if (!rc && (attr->ia_valid & ATTR_GID))
+		rc = cs_chown_permission(&path, INVALID_UID, attr->ia_gid);
+	if (!rc && (attr->ia_valid & ATTR_MODE))
+		rc = cs_chmod_permission(&path, attr->ia_mode);
+	if (!rc && (attr->ia_valid & ATTR_SIZE))
+		rc = cs_truncate_permission(&path);
+	return rc;
+}
+
+#endif
+
+#ifdef CONFIG_SECURITY_CAITSITH_GETATTR
+
+/**
+ * cs_inode_getattr - Check permission for stat().
+ *
+ * @path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_getattr(const struct path *path)
+{
+	return cs_getattr_permission(path);
+}
+
+#endif
+
+#ifdef CONFIG_SECURITY_PATH
+
+/**
+ * cs_path_mknod - Check permission for mknod().
+ *
+ * @dir:    Pointer to "struct path".
+ * @dentry: Pointer to "struct dentry".
+ * @mode:   Create mode.
+ * @dev:    Device major/minor number.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_mknod(const struct path *dir, struct dentry *dentry,
+			 umode_t mode, unsigned int dev)
+{
+	struct path path = { .mnt = dir->mnt, .dentry = dentry };
+
+	return cs_mknod_permission(&path, mode, dev);
+}
+
+/**
+ * cs_path_mkdir - Check permission for mkdir().
+ *
+ * @dir:    Pointer to "struct path".
+ * @dentry: Pointer to "struct dentry".
+ * @mode:   Create mode.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_mkdir(const struct path *dir, struct dentry *dentry,
+			 umode_t mode)
+{
+	struct path path = { .mnt = dir->mnt, .dentry = dentry };
+
+	return cs_mkdir_permission(&path, mode);
+}
+
+/**
+ * cs_path_rmdir - Check permission for rmdir().
+ *
+ * @dir:    Pointer to "struct path".
+ * @dentry: Pointer to "struct dentry".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_rmdir(const struct path *dir, struct dentry *dentry)
+{
+	struct path path = { .mnt = dir->mnt, .dentry = dentry };
+
+	return cs_rmdir_permission(&path);
+}
+
+/**
+ * cs_path_unlink - Check permission for unlink().
+ *
+ * @dir:    Pointer to "struct path".
+ * @dentry: Pointer to "struct dentry".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_unlink(const struct path *dir, struct dentry *dentry)
+{
+	struct path path = { .mnt = dir->mnt, .dentry = dentry };
+
+	return cs_unlink_permission(&path);
+}
+
+/**
+ * cs_path_symlink - Check permission for symlink().
+ *
+ * @dir:      Pointer to "struct path".
+ * @dentry:   Pointer to "struct dentry".
+ * @old_name: Content of symbolic link.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_symlink(const struct path *dir, struct dentry *dentry,
+			   const char *old_name)
+{
+	struct path path = { .mnt = dir->mnt, .dentry = dentry };
+
+	return cs_symlink_permission(&path, old_name);
+}
+
+/**
+ * cs_path_rename - Check permission for rename().
+ *
+ * @old_dir:    Pointer to "struct path".
+ * @old_dentry: Pointer to "struct dentry".
+ * @new_dir:    Pointer to "struct path".
+ * @new_dentry: Pointer to "struct dentry".
+ * @flags:      Rename flags.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_rename(const struct path *old_dir,
+			  struct dentry *old_dentry,
+			  const struct path *new_dir,
+			  struct dentry *new_dentry,
+			  const unsigned int flags)
+{
+	struct path old = { .mnt = old_dir->mnt, .dentry = old_dentry };
+	struct path new = { .mnt = new_dir->mnt, .dentry = new_dentry };
+
+	if (flags & RENAME_EXCHANGE) {
+		const int err = cs_rename_permission(&new, &old);
+
+		if (err)
+			return err;
+	}
+	return cs_rename_permission(&old, &new);
+}
+
+/**
+ * cs_path_link - Check permission for link().
+ *
+ * @old_dentry: Pointer to "struct dentry".
+ * @new_dir:    Pointer to "struct path".
+ * @new_dentry: Pointer to "struct dentry".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_path_link(struct dentry *old_dentry, const struct path *new_dir,
+			struct dentry *new_dentry)
+{
+	struct path old = { .mnt = new_dir->mnt, .dentry = old_dentry };
+	struct path new = { .mnt = new_dir->mnt, .dentry = new_dentry };
+
+	return cs_link_permission(&old, &new);
+}
+
+#else
+
+/**
+ * cs_inode_mknod - Check permission for mknod().
+ *
+ * @dir:    Pointer to "struct inode".
+ * @dentry: Pointer to "struct dentry".
+ * @mode:   Create mode.
+ * @dev:    Device major/minor number.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_mknod(struct inode *dir, struct dentry *dentry,
+			  umode_t mode, dev_t dev)
+{
+	struct path path = { .mnt = NULL, .dentry = dentry };
+
+	return cs_mknod_permission(&path, mode, dev);
+}
+
+/**
+ * cs_inode_mkdir - Check permission for mkdir().
+ *
+ * @dir:    Pointer to "struct inode".
+ * @dentry: Pointer to "struct dentry".
+ * @mode:   Create mode.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_mkdir(struct inode *dir, struct dentry *dentry,
+			  umode_t mode)
+{
+	struct path path = { .mnt = NULL, .dentry = dentry };
+
+	return cs_mkdir_permission(&path, mode);
+}
+
+/**
+ * cs_inode_rmdir - Check permission for rmdir().
+ *
+ * @dir:    Pointer to "struct inode".
+ * @dentry: Pointer to "struct dentry".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct path path = { .mnt = NULL, .dentry = dentry };
+
+	return cs_rmdir_permission(&path);
+}
+
+/**
+ * cs_inode_unlink - Check permission for unlink().
+ *
+ * @dir:    Pointer to "struct inode".
+ * @dentry: Pointer to "struct dentry".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct path path = { .mnt = NULL, .dentry = dentry };
+
+	return cs_unlink_permission(&path);
+}
+
+/**
+ * cs_inode_symlink - Check permission for symlink().
+ *
+ * @dir:      Pointer to "struct inode".
+ * @dentry:   Pointer to "struct dentry".
+ * @old_name: Content of symbolic link.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_symlink(struct inode *dir, struct dentry *dentry,
+			    const char *old_name)
+{
+	struct path path = { .mnt = NULL, .dentry = dentry };
+
+	return cs_symlink_permission(&path, old_name);
+}
+
+/**
+ * cs_inode_rename - Check permission for rename().
+ *
+ * @old_dir:    Pointer to "struct inode".
+ * @old_dentry: Pointer to "struct dentry".
+ * @new_dir:    Pointer to "struct inode".
+ * @new_dentry: Pointer to "struct dentry".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
+			   struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct path old = { .mnt = NULL, .dentry = old_dentry };
+	struct path new = { .mnt = NULL, .dentry = new_dentry };
+
+	return cs_rename_permission(&old, &new);
+}
+
+/**
+ * cs_inode_link - Check permission for link().
+ *
+ * @old_dentry: Pointer to "struct dentry".
+ * @dir:        Pointer to "struct inode".
+ * @new_dentry: Pointer to "struct dentry".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_link(struct dentry *old_dentry, struct inode *dir,
+			 struct dentry *new_dentry)
+{
+	struct path old = { .mnt = NULL, .dentry = old_dentry };
+	struct path new = { .mnt = NULL, .dentry = new_dentry };
+
+	return cs_link_permission(&old, &new);
+}
+
+/**
+ * cs_inode_create - Check permission for creat().
+ *
+ * @dir:    Pointer to "struct inode".
+ * @dentry: Pointer to "struct dentry".
+ * @mode:   Create mode.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_inode_create(struct inode *dir, struct dentry *dentry,
+			   umode_t mode)
+{
+	struct path path = { .mnt = NULL, .dentry = dentry };
+
+	return cs_mknod_permission(&path, mode, 0);
+}
+
+#endif
+
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+
+#include <net/sock.h>
+
+/* Structure for remembering an accept()ed socket's status. */
+struct cs_socket_tag {
+	struct list_head list;
+	struct inode *inode;
+	int status;
+	struct rcu_head rcu;
+};
+
+/*
+ * List for managing accept()ed sockets.
+ * Since we don't need to keep an accept()ed socket into this list after
+ * once the permission was granted, the number of entries in this list is
+ * likely small. Therefore, we don't use hash tables.
+ */
+static LIST_HEAD(cs_accepted_socket_list);
+/* Lock for protecting cs_accepted_socket_list . */
+static DEFINE_SPINLOCK(cs_accepted_socket_list_lock);
+
+/**
+ * cs_update_socket_tag - Update tag associated with accept()ed sockets.
+ *
+ * @inode:  Pointer to "struct inode".
+ * @status: New status.
+ *
+ * Returns nothing.
+ *
+ * If @status == 0, memory for that socket will be released after RCU grace
+ * period.
+ */
+static void cs_update_socket_tag(struct inode *inode, int status)
+{
+	struct cs_socket_tag *ptr;
+	/*
+	 * Protect whole section because multiple threads may call this
+	 * function with same "sock" via cs_validate_socket().
+	 */
+	spin_lock(&cs_accepted_socket_list_lock);
+	rcu_read_lock();
+	list_for_each_entry_rcu(ptr, &cs_accepted_socket_list, list) {
+		if (ptr->inode != inode)
+			continue;
+		ptr->status = status;
+		if (status)
+			break;
+		list_del_rcu(&ptr->list);
+		kfree_rcu(ptr, rcu);
+		break;
+	}
+	rcu_read_unlock();
+	spin_unlock(&cs_accepted_socket_list_lock);
+}
+
+/**
+ * cs_validate_socket - Check post accept() permission if needed.
+ *
+ * @sock: Pointer to "struct socket".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_validate_socket(struct socket *sock)
+{
+	struct inode *inode = SOCK_INODE(sock);
+	struct cs_socket_tag *ptr;
+	int ret = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ptr, &cs_accepted_socket_list, list) {
+		if (ptr->inode != inode)
+			continue;
+		ret = ptr->status;
+		break;
+	}
+	rcu_read_unlock();
+	if (ret <= 0)
+		/*
+		 * This socket is not an accept()ed socket or this socket is
+		 * an accept()ed socket and post accept() permission is done.
+		 */
+		return ret;
+	/*
+	 * Check post accept() permission now.
+	 *
+	 * Strictly speaking, we need to pass both listen()ing socket and
+	 * accept()ed socket to __cs_socket_post_accept_permission().
+	 * But since socket's family and type are same for both sockets,
+	 * passing the accept()ed socket in place for the listen()ing socket
+	 * will work.
+	 */
+	ret = cs_socket_post_accept_permission(sock, sock);
+	/*
+	 * If permission was granted, we forget that this is an accept()ed
+	 * socket. Otherwise, we remember that this socket needs to return
+	 * error for subsequent socketcalls.
+	 */
+	cs_update_socket_tag(inode, ret);
+	return ret;
+}
+
+/**
+ * cs_socket_accept - Check permission for accept().
+ *
+ * @sock:    Pointer to "struct socket".
+ * @newsock: Pointer to "struct socket".
+ *
+ * Returns 0 on success, negative value otherwise.
+ *
+ * This hook is used for setting up environment for doing post accept()
+ * permission check. If dereferencing sock->ops->something() were ordered by
+ * rcu_dereference(), we could replace sock->ops with "a copy of original
+ * sock->ops with modified sock->ops->accept()" using rcu_assign_pointer()
+ * in order to do post accept() permission check before returning to userspace.
+ * If we make the copy in security_socket_post_create(), it would be possible
+ * to safely replace sock->ops here, but we don't do so because we don't want
+ * to allocate memory for sockets which do not call sock->ops->accept().
+ * Therefore, we do post accept() permission check upon next socket syscalls
+ * rather than between sock->ops->accept() and returning to userspace.
+ * This means that if a socket was close()d before calling some socket
+ * syscalls, post accept() permission check will not be done.
+ */
+static int cs_socket_accept(struct socket *sock, struct socket *newsock)
+{
+	struct cs_socket_tag *ptr;
+	const int rc = cs_validate_socket(sock);
+
+	if (rc < 0)
+		return rc;
+	ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+	/*
+	 * Subsequent LSM hooks will receive "newsock". Therefore, I mark
+	 * "newsock" as "an accept()ed socket but post accept() permission
+	 * check is not done yet" by allocating memory using inode of the
+	 * "newsock" as a search key.
+	 */
+	ptr->inode = SOCK_INODE(newsock);
+	ptr->status = 1; /* Check post accept() permission later. */
+	spin_lock(&cs_accepted_socket_list_lock);
+	list_add_tail_rcu(&ptr->list, &cs_accepted_socket_list);
+	spin_unlock(&cs_accepted_socket_list_lock);
+	return 0;
+}
+
+/**
+ * cs_socket_listen - Check permission for listen().
+ *
+ * @sock:    Pointer to "struct socket".
+ * @backlog: Backlog parameter.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_listen(struct socket *sock, int backlog)
+{
+	const int rc = cs_validate_socket(sock);
+
+	if (rc < 0)
+		return rc;
+	return cs_socket_listen_permission(sock);
+}
+
+/**
+ * cs_socket_connect - Check permission for connect().
+ *
+ * @sock:     Pointer to "struct socket".
+ * @addr:     Pointer to "struct sockaddr".
+ * @addr_len: Size of @addr.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_connect(struct socket *sock, struct sockaddr *addr,
+			     int addr_len)
+{
+	const int rc = cs_validate_socket(sock);
+
+	if (rc < 0)
+		return rc;
+	return cs_socket_connect_permission(sock, addr, addr_len);
+}
+
+/**
+ * cs_socket_bind - Check permission for bind().
+ *
+ * @sock:     Pointer to "struct socket".
+ * @addr:     Pointer to "struct sockaddr".
+ * @addr_len: Size of @addr.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_bind(struct socket *sock, struct sockaddr *addr,
+			  int addr_len)
+{
+	const int rc = cs_validate_socket(sock);
+
+	if (rc < 0)
+		return rc;
+	return cs_socket_bind_permission(sock, addr, addr_len);
+}
+
+/**
+ * cs_socket_sendmsg - Check permission for sendmsg().
+ *
+ * @sock: Pointer to "struct socket".
+ * @msg:  Pointer to "struct msghdr".
+ * @size: Size of message.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_sendmsg(struct socket *sock, struct msghdr *msg,
+			     int size)
+{
+	const int rc = cs_validate_socket(sock);
+
+	if (rc < 0)
+		return rc;
+	return cs_socket_sendmsg_permission(sock, msg, size);
+}
+
+/**
+ * cs_socket_recvmsg - Check permission for recvmsg().
+ *
+ * @sock:  Pointer to "struct socket".
+ * @msg:   Pointer to "struct msghdr".
+ * @size:  Size of message.
+ * @flags: Flags.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_recvmsg(struct socket *sock, struct msghdr *msg,
+			     int size, int flags)
+{
+	return cs_validate_socket(sock);
+}
+
+/**
+ * cs_socket_getsockname - Check permission for getsockname().
+ *
+ * @sock: Pointer to "struct socket".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_getsockname(struct socket *sock)
+{
+	return cs_validate_socket(sock);
+}
+
+/**
+ * cs_socket_getpeername - Check permission for getpeername().
+ *
+ * @sock: Pointer to "struct socket".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_getpeername(struct socket *sock)
+{
+	return cs_validate_socket(sock);
+}
+
+/**
+ * cs_socket_getsockopt - Check permission for getsockopt().
+ *
+ * @sock:    Pointer to "struct socket".
+ * @level:   Level.
+ * @optname: Option's name,
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_getsockopt(struct socket *sock, int level, int optname)
+{
+	return cs_validate_socket(sock);
+}
+
+/**
+ * cs_socket_setsockopt - Check permission for setsockopt().
+ *
+ * @sock:    Pointer to "struct socket".
+ * @level:   Level.
+ * @optname: Option's name,
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_setsockopt(struct socket *sock, int level, int optname)
+{
+	return cs_validate_socket(sock);
+}
+
+/**
+ * cs_socket_shutdown - Check permission for shutdown().
+ *
+ * @sock: Pointer to "struct socket".
+ * @how:  Shutdown mode.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_socket_shutdown(struct socket *sock, int how)
+{
+	return cs_validate_socket(sock);
+}
+
+#define SOCKFS_MAGIC 0x534F434B
+
+/**
+ * cs_inode_free_security - Release memory associated with an inode.
+ *
+ * @inode: Pointer to "struct inode".
+ *
+ * Returns nothing.
+ *
+ * We use this hook for releasing memory associated with an accept()ed socket.
+ */
+static void cs_inode_free_security(struct inode *inode)
+{
+	if (inode->i_sb && inode->i_sb->s_magic == SOCKFS_MAGIC)
+		cs_update_socket_tag(inode, 0);
+}
+
+#endif
+
+/**
+ * cs_sb_pivotroot - Check permission for pivot_root().
+ *
+ * @old_path: Pointer to "struct path".
+ * @new_path: Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_sb_pivotroot(const struct path *old_path,
+			   const struct path *new_path)
+{
+	return cs_pivot_root_permission(old_path, new_path);
+}
+
+/**
+ * cs_sb_mount - Check permission for mount().
+ *
+ * @dev_name:  Name of device file.
+ * @path:      Pointer to "struct path".
+ * @type:      Name of filesystem type. Maybe NULL.
+ * @flags:     Mount options.
+ * @data_page: Optional data. Maybe NULL.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_sb_mount(const char *dev_name, const struct path *path,
+		       const char *type, unsigned long flags, void *data_page)
+{
+	return cs_mount_permission(dev_name, path, type, flags, data_page);
+}
+
+/**
+ * cs_move_mount - Check permission for move_mount().
+ *
+ * @from_path: Pointer to "struct path".
+ * @to_path:   Pointer to "struct path".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_move_mount(const struct path *from_path,
+			 const struct path *to_path)
+{
+	return cs_move_mount_permission(from_path, to_path);
+}
+
+/**
+ * cs_sb_umount - Check permission for umount().
+ *
+ * @mnt:   Pointer to "struct vfsmount".
+ * @flags: Unmount flags.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_sb_umount(struct vfsmount *mnt, int flags)
+{
+	struct path path = { .mnt = mnt, .dentry = mnt->mnt_root };
+
+	return cs_umount_permission(&path, flags);
+}
+
+/**
+ * cs_file_fcntl - Check permission for fcntl().
+ *
+ * @file: Pointer to "struct file".
+ * @cmd:  Command number.
+ * @arg:  Value for @cmd.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_file_fcntl(struct file *file, unsigned int cmd,
+			 unsigned long arg)
+{
+	return cs_fcntl_permission(file, cmd, arg);
+}
+
+/**
+ * cs_file_ioctl - Check permission for ioctl().
+ *
+ * @filp: Pointer to "struct file".
+ * @cmd:  Command number.
+ * @arg:  Value for @cmd.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int cs_file_ioctl(struct file *filp, unsigned int cmd,
+			  unsigned long arg)
+{
+	return cs_ioctl_permission(filp, cmd, arg);
+}
+
+#define MY_HOOK_INIT LSM_HOOK_INIT
+
+static struct security_hook_list caitsith_hooks[] = {
+	/* Security context allocator. */
+	MY_HOOK_INIT(task_free, cs_task_free_security),
+	MY_HOOK_INIT(cred_prepare, cs_cred_prepare),
+	MY_HOOK_INIT(task_alloc, cs_task_alloc_security),
+	/* Security context updater for successful execve(). */
+	MY_HOOK_INIT(bprm_check_security, cs_bprm_check_security),
+	MY_HOOK_INIT(bprm_committing_creds, cs_bprm_committing_creds),
+	/* Various permission checker. */
+	MY_HOOK_INIT(file_open, cs_file_open),
+	MY_HOOK_INIT(file_fcntl, cs_file_fcntl),
+	MY_HOOK_INIT(file_ioctl, cs_file_ioctl),
+	MY_HOOK_INIT(sb_pivotroot, cs_sb_pivotroot),
+	MY_HOOK_INIT(sb_mount, cs_sb_mount),
+	MY_HOOK_INIT(move_mount, cs_move_mount),
+	MY_HOOK_INIT(sb_umount, cs_sb_umount),
+#ifdef CONFIG_SECURITY_PATH
+	MY_HOOK_INIT(path_mknod, cs_path_mknod),
+	MY_HOOK_INIT(path_mkdir, cs_path_mkdir),
+	MY_HOOK_INIT(path_rmdir, cs_path_rmdir),
+	MY_HOOK_INIT(path_unlink, cs_path_unlink),
+	MY_HOOK_INIT(path_symlink, cs_path_symlink),
+	MY_HOOK_INIT(path_rename, cs_path_rename),
+	MY_HOOK_INIT(path_link, cs_path_link),
+	MY_HOOK_INIT(path_truncate, cs_path_truncate),
+	MY_HOOK_INIT(path_chmod, cs_path_chmod),
+	MY_HOOK_INIT(path_chown, cs_path_chown),
+	MY_HOOK_INIT(path_chroot, cs_path_chroot),
+#else
+	MY_HOOK_INIT(inode_mknod, cs_inode_mknod),
+	MY_HOOK_INIT(inode_mkdir, cs_inode_mkdir),
+	MY_HOOK_INIT(inode_rmdir, cs_inode_rmdir),
+	MY_HOOK_INIT(inode_unlink, cs_inode_unlink),
+	MY_HOOK_INIT(inode_symlink, cs_inode_symlink),
+	MY_HOOK_INIT(inode_rename, cs_inode_rename),
+	MY_HOOK_INIT(inode_link, cs_inode_link),
+	MY_HOOK_INIT(inode_create, cs_inode_create),
+	MY_HOOK_INIT(inode_setattr, cs_inode_setattr),
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_GETATTR
+	MY_HOOK_INIT(inode_getattr, cs_inode_getattr),
+#endif
+#ifdef CONFIG_SECURITY_CAITSITH_NETWORK
+	MY_HOOK_INIT(socket_bind, cs_socket_bind),
+	MY_HOOK_INIT(socket_connect, cs_socket_connect),
+	MY_HOOK_INIT(socket_listen, cs_socket_listen),
+	MY_HOOK_INIT(socket_sendmsg, cs_socket_sendmsg),
+	MY_HOOK_INIT(socket_recvmsg, cs_socket_recvmsg),
+	MY_HOOK_INIT(socket_getsockname, cs_socket_getsockname),
+	MY_HOOK_INIT(socket_getpeername, cs_socket_getpeername),
+	MY_HOOK_INIT(socket_getsockopt, cs_socket_getsockopt),
+	MY_HOOK_INIT(socket_setsockopt, cs_socket_setsockopt),
+	MY_HOOK_INIT(socket_shutdown, cs_socket_shutdown),
+	MY_HOOK_INIT(socket_accept, cs_socket_accept),
+	MY_HOOK_INIT(inode_free_security, cs_inode_free_security),
+#endif
+};
+
+static inline void add_hook(struct security_hook_list *hook)
+{
+	hlist_add_tail_rcu(&hook->list, hook->head);
+}
+
+static void __init swap_hook(struct security_hook_list *hook,
+			     union security_list_options *original)
+{
+	struct hlist_head *list = hook->head;
+
+	if (hlist_empty(list)) {
+		add_hook(hook);
+	} else {
+		struct security_hook_list *shp =
+			hlist_entry(list->first, typeof(*shp), list);
+
+		while (shp->list.next)
+			shp = hlist_entry(shp->list.next, typeof(*shp), list);
+		*original = shp->hook;
+		/* Make sure that original callback is saved. */
+		smp_wmb();
+		shp->hook = hook->hook;
+	}
+}
+
+#if defined(CONFIG_STRICT_KERNEL_RWX) && !defined(CONFIG_SECURITY_WRITABLE_HOOKS)
+#include <linux/uaccess.h> /* copy_to_kernel_nofault() */
+#define NEED_TO_CHECK_HOOKS_ARE_WRITABLE
+
+#if defined(CONFIG_X86)
+#define MAX_RO_PAGES 1024
+static struct page *ro_pages[MAX_RO_PAGES] __initdata;
+static unsigned int ro_pages_len __initdata;
+
+static bool __init lsm_test_page_ro(void *addr)
+{
+	unsigned int i;
+	int unused;
+	struct page *page;
+
+	page = (struct page *) lookup_address((unsigned long) addr, &unused);
+	if (!page)
+		return false;
+	if (test_bit(_PAGE_BIT_RW, &(page->flags)))
+		return true;
+	for (i = 0; i < ro_pages_len; i++)
+		if (page == ro_pages[i])
+			return true;
+	if (ro_pages_len == MAX_RO_PAGES)
+		return false;
+	ro_pages[ro_pages_len++] = page;
+	return true;
+}
+
+static bool __init check_ro_pages(struct security_hook_heads *hooks)
+{
+	int i;
+	struct hlist_head *list = &hooks->capable;
+
+	if (!copy_to_kernel_nofault(list, list, sizeof(void *)))
+		return true;
+	for (i = 0; i < ARRAY_SIZE(caitsith_hooks); i++) {
+		struct hlist_head *head = caitsith_hooks[i].head;
+		struct security_hook_list *shp;
+
+		if (!lsm_test_page_ro(&head->first))
+			return false;
+		hlist_for_each_entry(shp, head, list)
+			if (!lsm_test_page_ro(&shp->list.next) ||
+			    !lsm_test_page_ro(&shp->list.pprev))
+				return false;
+	}
+	return true;
+}
+#else
+static bool __init check_ro_pages(struct security_hook_heads *hooks)
+{
+	struct hlist_head *list = &hooks->capable;
+
+	return !copy_to_kernel_nofault(list, list, sizeof(void *));
+}
+#endif
+#endif
+
+/**
+ * cs_init - Initialize this module.
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int __init cs_init(void)
+{
+	int idx;
+#if defined(NEED_TO_CHECK_HOOKS_ARE_WRITABLE)
+	if (!check_ro_pages(&security_hook_heads)) {
+		pr_info("Can't update security_hook_heads due to write protected. Retry with rodata=0 kernel command line option added.\n");
+		return -EINVAL;
+	}
+#endif
+	for (idx = 0; idx < CS_MAX_TASK_SECURITY_HASH; idx++)
+		INIT_LIST_HEAD(&cs_task_security_list[idx]);
+	cs_init_module();
+#if defined(NEED_TO_CHECK_HOOKS_ARE_WRITABLE) && defined(CONFIG_X86)
+	for (idx = 0; idx < ro_pages_len; idx++)
+		set_bit(_PAGE_BIT_RW, &(ro_pages[idx]->flags));
+#endif
+	swap_hook(&caitsith_hooks[0], &original_task_free);
+	swap_hook(&caitsith_hooks[1], &original_cred_prepare);
+	swap_hook(&caitsith_hooks[2], &original_task_alloc);
+	for (idx = 3; idx < ARRAY_SIZE(caitsith_hooks); idx++)
+		add_hook(&caitsith_hooks[idx]);
+#if defined(NEED_TO_CHECK_HOOKS_ARE_WRITABLE) && defined(CONFIG_X86)
+	for (idx = 0; idx < ro_pages_len; idx++)
+		clear_bit(_PAGE_BIT_RW, &(ro_pages[idx]->flags));
+#endif
+	return 0;
+}
+
+module_init(cs_init);
+MODULE_LICENSE("GPL");
+
+/**
+ * cs_used_by_cred - Check whether the given domain is in use or not.
+ *
+ * @domain: Pointer to "struct cs_domain_info".
+ *
+ * Returns true if @domain is in use, false otherwise.
+ *
+ * Caller holds rcu_read_lock().
+ */
+bool cs_used_by_cred(const struct cs_domain_info *domain)
+{
+	return false;
+}
+
+/**
+ * cs_add_task_security - Add "struct cs_security" to list.
+ *
+ * @ptr:  Pointer to "struct cs_security".
+ * @list: Pointer to "struct list_head".
+ *
+ * Returns nothing.
+ */
+static void cs_add_task_security(struct cs_security *ptr,
+				 struct list_head *list)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cs_task_security_list_lock, flags);
+	list_add_rcu(&ptr->list, list);
+	spin_unlock_irqrestore(&cs_task_security_list_lock, flags);
+}
+
+/**
+ * __cs_alloc_task_security - Allocate memory for new tasks.
+ *
+ * @task: Pointer to "struct task_struct".
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int __cs_alloc_task_security(const struct task_struct *task)
+{
+	struct cs_security *old_security = cs_current_security();
+	struct cs_security *new_security = kzalloc(sizeof(*new_security),
+						   GFP_KERNEL);
+	struct list_head *list = &cs_task_security_list
+		[hash_ptr((void *) task, CS_TASK_SECURITY_HASH_BITS)];
+
+	if (!new_security)
+		return -ENOMEM;
+	new_security->task = task;
+	new_security->cs_domain_info = old_security->cs_domain_info;
+	new_security->cs_flags = old_security->cs_flags;
+	cs_add_task_security(new_security, list);
+	return 0;
+}
+
+/**
+ * cs_find_task_security - Find "struct cs_security" for given task.
+ *
+ * @task: Pointer to "struct task_struct".
+ *
+ * Returns pointer to "struct cs_security" on success, &cs_oom_security on
+ * out of memory, &cs_default_security otherwise.
+ *
+ * If @task is current thread and "struct cs_security" for current thread was
+ * not found, I try to allocate it. But if allocation failed, current thread
+ * will be killed by SIGKILL. Note that if current->pid == 1, sending SIGKILL
+ * won't work.
+ */
+struct cs_security *cs_find_task_security(const struct task_struct *task)
+{
+	struct cs_security *ptr;
+	struct list_head *list = &cs_task_security_list
+		[hash_ptr((void *) task, CS_TASK_SECURITY_HASH_BITS)];
+	/* Make sure INIT_LIST_HEAD() in cs_mm_init() takes effect. */
+	while (!list->next)
+		smp_rmb();
+	rcu_read_lock();
+	list_for_each_entry_rcu(ptr, list, list) {
+		if (ptr->task != task)
+			continue;
+		rcu_read_unlock();
+		/*
+		 * Current thread needs to transit from old domain to new
+		 * domain before do_execve() succeeds in order to check
+		 * permission for interpreters and environment variables using
+		 * new domain's ACL rules. The domain transition has to be
+		 * visible from other CPU in order to allow interactive
+		 * enforcing mode. Also, the domain transition has to be
+		 * reverted if do_execve() failed. However, an LSM hook for
+		 * reverting domain transition is missing.
+		 *
+		 * security_prepare_creds() is called from prepare_creds() from
+		 * prepare_bprm_creds() from do_execve() before setting
+		 * current->in_execve flag, and current->in_execve flag is
+		 * cleared by the time next do_execve() request starts.
+		 * This means that we can emulate the missing LSM hook for
+		 * reverting domain transition, by calling this function from
+		 * security_prepare_creds().
+		 *
+		 * If current->in_execve is not set but ptr->cs_flags has
+		 * CS_TASK_IS_IN_EXECVE set, it indicates that do_execve()
+		 * has failed and reverting domain transition is needed.
+		 */
+		if (task == current &&
+		    (ptr->cs_flags & CS_TASK_IS_IN_EXECVE) &&
+		    !current->in_execve) {
+			cs_debug_trace("1");
+			cs_clear_execve(-1, ptr);
+		}
+		return ptr;
+	}
+	rcu_read_unlock();
+	if (task != current)
+		return &cs_default_security;
+	/* Use GFP_ATOMIC because caller may have called rcu_read_lock(). */
+	ptr = kzalloc(sizeof(*ptr), GFP_ATOMIC);
+	if (!ptr) {
+		pr_warn("Unable to allocate memory for pid=%u\n",
+			task->pid);
+		send_sig(SIGKILL, current, 0);
+		return &cs_oom_security;
+	}
+	*ptr = cs_default_security;
+	ptr->task = task;
+	cs_add_task_security(ptr, list);
+	return ptr;
+}
-- 
2.18.4

