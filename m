Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A318C636D7
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjBQD0p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBQD0n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:43 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EA84BEAA
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:38 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id dh20so94532qvb.10
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olMUQaG/0koQNzEb+hpWmhmKmP418IR41Sg4/HQYqGc=;
        b=IMCWP9QBYhfuXRie6Csw05T3EBfTj/6/Kq4j5844TESuq/sFGJm7uncFyG/OdHSuw4
         CfbwIYjeUwYg11VdYsHS9tH/3jS/se4Q1u5l7Gc7zglfNUbAju6zUuhRplpQJZOihyQR
         GHTuH0LNCkqKBjgx84C7f9qEa6kET6eWKhxwdU2MnxWwaex0I39DUm28b0bA6PzLOnO2
         v4lNTnTBQFFJ8cbofB1j0kNFccS9jeNvhgpVsbxaZEjYnsZ7Eaw/Y6qWSWsoSTn1UwTu
         b+7+4RaYEQRHP8tvkuuqDkKkUrTPf5Py0emQ3A4bz2XQJ/IJTEngUzbzBW83njRM1UaP
         boUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olMUQaG/0koQNzEb+hpWmhmKmP418IR41Sg4/HQYqGc=;
        b=4lPcdGZ/psVG5bGiZAiXNy4ikVCYmVrJwYcQ7oUaqW2taYhR1qLTFZqke+UuiFqCbP
         ii5T7LttLPm66JmAPBuIlbBD0Msl09dwJNIE41188jYX+7XbkxZzJugFbhR2v9nkgO69
         Kj1ljkrTJO4+dzjwNr/r4+enzX3WRMIfA7YZlx+zj0jUWvORj70dMTWvzn3b2EDroeI7
         rdO5RtU8gKfvUyLcNSPQi+nc5Nl35CBHpGHzNbHxhPIeNuPmanppwm4cAqRon/r211O7
         HpQbngp8lzjd5eYZD86fxm+7gtezQYBV+1dL6hb9BAdaUd2zC5KKvy2t1N3ui+xi4RZp
         JXnw==
X-Gm-Message-State: AO0yUKVgGdKON2IPY7RMKWztHNy9IKjP+cq/xnDdx/SbXBobc6d90QNZ
        fN7jLfOvsXy2RF1TdF2THXgtAnsJ/symbCw=
X-Google-Smtp-Source: AK7set+56teXO4s2rEGgeDu+EqCXfb2IG4j17XFmVnNwYPUpKKxpzuCruRp3/KCDNSqwg7nMqZSkZg==
X-Received: by 2002:a05:6214:5186:b0:56e:aa8b:9103 with SMTP id kl6-20020a056214518600b0056eaa8b9103mr13470500qvb.52.1676604397018;
        Thu, 16 Feb 2023 19:26:37 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id t202-20020a37aad3000000b0073b79edf46csm2499764qke.83.2023.02.16.19.26.35
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:36 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 06/22] lsm: move the file hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:09 -0500
Message-Id: <20230217032625.678457-7-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch relocates the LSM hook function comments to the function
definitions, in keeping with the current kernel conventions.  This
should make the hook descriptions more easily discoverable and easier
to maintain.

While formatting changes have been done to better fit the kernel-doc
style, content changes have been kept to a minimum and limited to
text which was obviously incorrect and/or outdated.  It is expected
the future patches will improve the quality of the function header
comments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 104 --------------------------
 security/security.c       | 151 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 104 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c953f6c356f2..7c58683b9288 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,110 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for file operations
- *
- * @file_permission:
- *	Check file permissions before accessing an open file.  This hook is
- *	called by various operations that read or write files.  A security
- *	module can use this hook to perform additional checking on these
- *	operations, e.g.  to revalidate permissions on use to support privilege
- *	bracketing or policy changes.  Notice that this hook is used when the
- *	actual read/write operations are performed, whereas the
- *	inode_security_ops hook is called when a file is opened (as well as
- *	many other operations).
- *	Caveat:  Although this hook can be used to revalidate permissions for
- *	various system call operations that read or write files, it does not
- *	address the revalidation of permissions for memory-mapped files.
- *	Security modules must handle this separately if they need such
- *	revalidation.
- *	@file contains the file structure being accessed.
- *	@mask contains the requested permissions.
- *	Return 0 if permission is granted.
- * @file_alloc_security:
- *	Allocate and attach a security structure to the file->f_security field.
- *	The security field is initialized to NULL when the structure is first
- *	created.
- *	@file contains the file structure to secure.
- *	Return 0 if the hook is successful and permission is granted.
- * @file_free_security:
- *	Deallocate and free any security structures stored in file->f_security.
- *	@file contains the file structure being modified.
- * @file_ioctl:
- *	@file contains the file structure.
- *	@cmd contains the operation to perform.
- *	@arg contains the operational arguments.
- *	Check permission for an ioctl operation on @file.  Note that @arg
- *	sometimes represents a user space pointer; in other cases, it may be a
- *	simple integer value.  When @arg represents a user space pointer, it
- *	should never be used by the security module.
- *	Return 0 if permission is granted.
- * @mmap_addr:
- *	Check permissions for a mmap operation at @addr.
- *	@addr contains virtual address that will be used for the operation.
- *	Return 0 if permission is granted.
- * @mmap_file:
- *	Check permissions for a mmap operation.  The @file may be NULL, e.g.
- *	if mapping anonymous memory.
- *	@file contains the file structure for file to map (may be NULL).
- *	@reqprot contains the protection requested by the application.
- *	@prot contains the protection that will be applied by the kernel.
- *	@flags contains the operational flags.
- *	Return 0 if permission is granted.
- * @file_mprotect:
- *	Check permissions before changing memory access permissions.
- *	@vma contains the memory region to modify.
- *	@reqprot contains the protection requested by the application.
- *	@prot contains the protection that will be applied by the kernel.
- *	Return 0 if permission is granted.
- * @file_lock:
- *	Check permission before performing file locking operations.
- *	Note the hook mediates both flock and fcntl style locks.
- *	@file contains the file structure.
- *	@cmd contains the posix-translated lock operation to perform
- *	(e.g. F_RDLCK, F_WRLCK).
- *	Return 0 if permission is granted.
- * @file_fcntl:
- *	Check permission before allowing the file operation specified by @cmd
- *	from being performed on the file @file.  Note that @arg sometimes
- *	represents a user space pointer; in other cases, it may be a simple
- *	integer value.  When @arg represents a user space pointer, it should
- *	never be used by the security module.
- *	@file contains the file structure.
- *	@cmd contains the operation to be performed.
- *	@arg contains the operational arguments.
- *	Return 0 if permission is granted.
- * @file_set_fowner:
- *	Save owner security information (typically from current->security) in
- *	file->f_security for later use by the send_sigiotask hook.
- *	@file contains the file structure to update.
- *	Return 0 on success.
- * @file_send_sigiotask:
- *	Check permission for the file owner @fown to send SIGIO or SIGURG to the
- *	process @tsk.  Note that this hook is sometimes called from interrupt.
- *	Note that the fown_struct, @fown, is never outside the context of a
- *	struct file, so the file structure (and associated security information)
- *	can always be obtained: container_of(fown, struct file, f_owner)
- *	@tsk contains the structure of task receiving signal.
- *	@fown contains the file owner information.
- *	@sig is the signal that will be sent.  When 0, kernel sends SIGIO.
- *	Return 0 if permission is granted.
- * @file_receive:
- *	This hook allows security modules to control the ability of a process
- *	to receive an open file descriptor via socket IPC.
- *	@file contains the file structure being received.
- *	Return 0 if permission is granted.
- * @file_truncate:
- *	Check permission before truncating a file, i.e. using ftruncate.
- *	Note that truncation permission may also be checked based on the path,
- *	using the @path_truncate hook.
- *	@file contains the file structure for the file.
- *	Return 0 if permission is granted.
- * @file_open:
- *	Save open-time permission checking state for later use upon
- *	file_permission, and recheck access if anything has changed
- *	since inode_permission.
- *	Return 0 if permission is granted.
- *
  * Security hooks for task operations.
  *
  * @task_alloc:
diff --git a/security/security.c b/security/security.c
index aae94d3d531d..7c6ad5d5b3ef 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2360,6 +2360,25 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
 	return call_int_hook(kernfs_init_security, 0, kn_dir, kn);
 }
 
+/**
+ * security_file_permission() - Check file permissions
+ * @file: file
+ * @mask: requested permissions
+ *
+ * Check file permissions before accessing an open file.  This hook is called
+ * by various operations that read or write files.  A security module can use
+ * this hook to perform additional checking on these operations, e.g. to
+ * revalidate permissions on use to support privilege bracketing or policy
+ * changes.  Notice that this hook is used when the actual read/write
+ * operations are performed, whereas the inode_security_ops hook is called when
+ * a file is opened (as well as many other operations).  Although this hook can
+ * be used to revalidate permissions for various system call operations that
+ * read or write files, it does not address the revalidation of permissions for
+ * memory-mapped files.  Security modules must handle this separately if they
+ * need such revalidation.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
@@ -2371,6 +2390,15 @@ int security_file_permission(struct file *file, int mask)
 	return fsnotify_perm(file, mask);
 }
 
+/**
+ * security_file_alloc() - Allocate and init a file's LSM blob
+ * @file: the file
+ *
+ * Allocate and attach a security structure to the file->f_security field.  The
+ * security field is initialized to NULL when the structure is first created.
+ *
+ * Return: Return 0 if the hook is successful and permission is granted.
+ */
 int security_file_alloc(struct file *file)
 {
 	int rc = lsm_file_alloc(file);
@@ -2383,6 +2411,12 @@ int security_file_alloc(struct file *file)
 	return rc;
 }
 
+/**
+ * security_file_free() - Free a file's LSM blob
+ * @file: the file
+ *
+ * Deallocate and free any security structures stored in file->f_security.
+ */
 void security_file_free(struct file *file)
 {
 	void *blob;
@@ -2396,6 +2430,19 @@ void security_file_free(struct file *file)
 	}
 }
 
+/**
+ * security_file_ioctl() - Check if an ioctl is allowed
+ * @file: associated file
+ * @cmd: ioctl cmd
+ * @arg: ioctl arguments
+ *
+ * Check permission for an ioctl operation on @file.  Note that @arg sometimes
+ * represents a user space pointer; in other cases, it may be a simple integer
+ * value.  When @arg represents a user space pointer, it should never be used
+ * by the security module.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	return call_int_hook(file_ioctl, 0, file, cmd, arg);
@@ -2435,6 +2482,17 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 	return prot;
 }
 
+/**
+ * security_mmap_file() - Check if mmap'ing a file is allowed
+ * @file: file
+ * @prot: protection applied by the kernel
+ * @flags: flags
+ *
+ * Check permissions for a mmap operation.  The @file may be NULL, e.g. if
+ * mapping anonymous memory.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags)
 {
@@ -2446,11 +2504,29 @@ int security_mmap_file(struct file *file, unsigned long prot,
 	return ima_file_mmap(file, prot);
 }
 
+/**
+ * security_mmap_addr() - Check if mmap'ing an address is allowed
+ * @addr: address
+ *
+ * Check permissions for a mmap operation at @addr.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_mmap_addr(unsigned long addr)
 {
 	return call_int_hook(mmap_addr, 0, addr);
 }
 
+/**
+ * security_file_mprotect() - Check if changing memory protections is allowed
+ * @vma: memory region
+ * @reqprot: application requested protection
+ * @prog: protection applied by the kernel
+ *
+ * Check permissions before changing memory access permissions.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			    unsigned long prot)
 {
@@ -2462,32 +2538,97 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 	return ima_file_mprotect(vma, prot);
 }
 
+/**
+ * security_file_lock() - Check if a file lock is allowed
+ * @file: file
+ * @cmd: lock operation (e.g. F_RDLCK, F_WRLCK)
+ *
+ * Check permission before performing file locking operations.  Note the hook
+ * mediates both flock and fcntl style locks.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_file_lock(struct file *file, unsigned int cmd)
 {
 	return call_int_hook(file_lock, 0, file, cmd);
 }
 
+/**
+ * security_file_fcntl() - Check if fcntl() op is allowed
+ * @file: file
+ * @cmd: fnctl command
+ * @arg: command argument
+ *
+ * Check permission before allowing the file operation specified by @cmd from
+ * being performed on the file @file.  Note that @arg sometimes represents a
+ * user space pointer; in other cases, it may be a simple integer value.  When
+ * @arg represents a user space pointer, it should never be used by the
+ * security module.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	return call_int_hook(file_fcntl, 0, file, cmd, arg);
 }
 
+/**
+ * security_file_set_fowner() - Set the file owner info in the LSM blob
+ * @file: the file
+ *
+ * Save owner security information (typically from current->security) in
+ * file->f_security for later use by the send_sigiotask hook.
+ *
+ * Return: Returns 0 on success.
+ */
 void security_file_set_fowner(struct file *file)
 {
 	call_void_hook(file_set_fowner, file);
 }
 
+/**
+ * security_file_send_sigiotask() - Check if sending SIGIO/SIGURG is allowed
+ * @tsk: target task
+ * @fown: signal sender
+ * @sig: signal to be sent, SIGIO is sent if 0
+ *
+ * Check permission for the file owner @fown to send SIGIO or SIGURG to the
+ * process @tsk.  Note that this hook is sometimes called from interrupt.  Note
+ * that the fown_struct, @fown, is never outside the context of a struct file,
+ * so the file structure (and associated security information) can always be
+ * obtained: container_of(fown, struct file, f_owner).
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_file_send_sigiotask(struct task_struct *tsk,
 				  struct fown_struct *fown, int sig)
 {
 	return call_int_hook(file_send_sigiotask, 0, tsk, fown, sig);
 }
 
+/**
+ * security_file_receive() - Check is receiving a file via IPC is allowed
+ * @file: file being received
+ *
+ * This hook allows security modules to control the ability of a process to
+ * receive an open file descriptor via socket IPC.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_file_receive(struct file *file)
 {
 	return call_int_hook(file_receive, 0, file);
 }
 
+/**
+ * security_file_open() - Save open() time state for late use by the LSM
+ * @file:
+ *
+ * Save open-time permission checking state for later use upon file_permission,
+ * and recheck access if anything has changed since inode_permission.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_file_open(struct file *file)
 {
 	int ret;
@@ -2499,6 +2640,16 @@ int security_file_open(struct file *file)
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
+/**
+ * security_file_truncate() - Check if truncating a file is allowed
+ * @file: file
+ *
+ * Check permission before truncating a file, i.e. using ftruncate.  Note that
+ * truncation permission may also be checked based on the path, using the
+ * @path_truncate hook.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_file_truncate(struct file *file)
 {
 	return call_int_hook(file_truncate, 0, file);
-- 
2.39.2

