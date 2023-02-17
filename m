Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C195DC636D7
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjBQD0v (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBQD0n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:43 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D34FC84
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:40 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s22so58250qtw.11
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CYG6j1o9XadyRCPnBNGXiQnGgZ0+DbRCkB/tk97a0I=;
        b=ZpT1pBjXTb5hD+EIibIkSNN16WGpLlWRdHG52gB5ZLUt3T0AOLbmWcun/fiYfhrewR
         krjkM3HrJSO7fPJHrF9N0ppsqLYeeX8xAdHK6hQD/okgHzaz6HindXV959MlGhKO5YN+
         cD6z4JvZngU/V1tBX9DRQ28+y1IERSFsfsK9TPEHNxryeTEROhu4mseP86JYaLkodjIE
         N3+vs4vzyysRwuD0IUyyOx4eMoPX3VocI3udY/tHFSRJiENHdHVyAdSGzLxwvxd8IHER
         bsKzzKe0Z/8LDDgRl05K7ftkOaC/aiS5cteCuFTshqh7az92Dc2Q9pRNubTysO3DtY6p
         46UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CYG6j1o9XadyRCPnBNGXiQnGgZ0+DbRCkB/tk97a0I=;
        b=X32jIdID22CrXtPP4jS3dF/+477i8dYrUAVl2ytK/EtJaPJQ+fxzLigBBhp2Ods/VD
         sjVnu5ePmP+01jw0htOlOlnyGZ1OY+LeUrQ7ec4051+zX9Lf1eLEUZNao1GhjvPV9PjI
         8C4idxtyGWQYSYZG9OKZ9xa8K8MkN0bII47Irfru4+bvSDxcC9ZRrS2MFpBDnPftg0Zd
         SFrKzJYzV12rL1Nvuwt43JwbaG8nRSnAMGMXYR5WaG4/5LPn2tymn73DKlc/UnbbHiVj
         NeAoZ77GC4FTwmM0HyS/pKtMpAKchzznrAR+c4oqgXM9KnZLzUwLZ0DKZBqbXEXqeql0
         EyFA==
X-Gm-Message-State: AO0yUKUGMLVDDY5qj+jWEV6QgS35FBBwT7tdkfW8zkSCd+8v62eB1r7v
        Rf1HT0G4SX7HrELprm+A9lCFurLTJ8BTjzg=
X-Google-Smtp-Source: AK7set91i253y3zt99Bfv+lRtTVmuG0piDxndcUPNgws3H92Z+W4Z4cnnW7HXHuCkQnifXtbtZGrJw==
X-Received: by 2002:a05:622a:6:b0:3b6:2c3b:8c00 with SMTP id x6-20020a05622a000600b003b62c3b8c00mr14024654qtw.66.1676604398574;
        Thu, 16 Feb 2023 19:26:38 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id 13-20020ac8564d000000b003afbf704c7csm1334826qtt.24.2023.02.16.19.26.37
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:37 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 07/22] lsm: move the task hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:10 -0500
Message-Id: <20230217032625.678457-8-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h | 210 ------------------------
 security/security.c       | 334 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 334 insertions(+), 210 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7c58683b9288..5578a13729bd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,216 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for task operations.
- *
- * @task_alloc:
- *	@task task being allocated.
- *	@clone_flags contains the flags indicating what should be shared.
- *	Handle allocation of task-related resources.
- *	Returns a zero on success, negative values on failure.
- * @task_free:
- *	@task task about to be freed.
- *	Handle release of task-related resources. (Note that this can be called
- *	from interrupt context.)
- * @cred_alloc_blank:
- *	@cred points to the credentials.
- *	@gfp indicates the atomicity of any memory allocations.
- *	Only allocate sufficient memory and attach to @cred such that
- *	cred_transfer() will not get ENOMEM.
- *	Return 0 on success, negative values on failure.
- * @cred_free:
- *	@cred points to the credentials.
- *	Deallocate and clear the cred->security field in a set of credentials.
- * @cred_prepare:
- *	@new points to the new credentials.
- *	@old points to the original credentials.
- *	@gfp indicates the atomicity of any memory allocations.
- *	Prepare a new set of credentials by copying the data from the old set.
- *	Return 0 on success, negative values on failure.
- * @cred_transfer:
- *	@new points to the new credentials.
- *	@old points to the original credentials.
- *	Transfer data from original creds to new creds
- * @cred_getsecid:
- *	Retrieve the security identifier of the cred structure @c
- *	@c contains the credentials, secid will be placed into @secid.
- *	In case of failure, @secid will be set to zero.
- * @kernel_act_as:
- *	Set the credentials for a kernel service to act as (subjective context).
- *	@new points to the credentials to be modified.
- *	@secid specifies the security ID to be set.
- *	The current task must be the one that nominated @secid.
- *	Return 0 if successful.
- * @kernel_create_files_as:
- *	Set the file creation context in a set of credentials to be the same as
- *	the objective context of the specified inode.
- *	@new points to the credentials to be modified.
- *	@inode points to the inode to use as a reference.
- *	The current task must be the one that nominated @inode.
- *	Return 0 if successful.
- * @kernel_module_request:
- *	Ability to trigger the kernel to automatically upcall to userspace for
- *	userspace to load a kernel module with the given name.
- *	@kmod_name name of the module requested by the kernel.
- *	Return 0 if successful.
- * @kernel_load_data:
- *	Load data provided by userspace.
- *	@id kernel load data identifier.
- *	@contents if a subsequent @kernel_post_load_data will be called.
- *	Return 0 if permission is granted.
- * @kernel_post_load_data:
- *	Load data provided by a non-file source (usually userspace buffer).
- *	@buf pointer to buffer containing the data contents.
- *	@size length of the data contents.
- *	@id kernel load data identifier.
- *	@description a text description of what was loaded, @id-specific.
- *	Return 0 if permission is granted.
- *	This must be paired with a prior @kernel_load_data call that had
- *	@contents set to true.
- * @kernel_read_file:
- *	Read a file specified by userspace.
- *	@file contains the file structure pointing to the file being read
- *	by the kernel.
- *	@id kernel read file identifier.
- *	@contents if a subsequent @kernel_post_read_file will be called.
- *	Return 0 if permission is granted.
- * @kernel_post_read_file:
- *	Read a file specified by userspace.
- *	@file contains the file structure pointing to the file being read
- *	by the kernel.
- *	@buf pointer to buffer containing the file contents.
- *	@size length of the file contents.
- *	@id kernel read file identifier.
- *	This must be paired with a prior @kernel_read_file call that had
- *	@contents set to true.
- *	Return 0 if permission is granted.
- * @task_fix_setuid:
- *	Update the module's state after setting one or more of the user
- *	identity attributes of the current process.  The @flags parameter
- *	indicates which of the set*uid system calls invoked this hook.  If
- *	@new is the set of credentials that will be installed.  Modifications
- *	should be made to this rather than to @current->cred.
- *	@old is the set of credentials that are being replaced.
- *	@flags contains one of the LSM_SETID_* values.
- *	Return 0 on success.
- * @task_fix_setgid:
- *	Update the module's state after setting one or more of the group
- *	identity attributes of the current process.  The @flags parameter
- *	indicates which of the set*gid system calls invoked this hook.
- *	@new is the set of credentials that will be installed.  Modifications
- *	should be made to this rather than to @current->cred.
- *	@old is the set of credentials that are being replaced.
- *	@flags contains one of the LSM_SETID_* values.
- *	Return 0 on success.
- * @task_fix_setgroups:
- *	Update the module's state after setting the supplementary group
- *	identity attributes of the current process.
- *	@new is the set of credentials that will be installed.  Modifications
- *	should be made to this rather than to @current->cred.
- *	@old is the set of credentials that are being replaced.
- *	Return 0 on success.
- * @task_setpgid:
- *	Check permission before setting the process group identifier of the
- *	process @p to @pgid.
- *	@p contains the task_struct for process being modified.
- *	@pgid contains the new pgid.
- *	Return 0 if permission is granted.
- * @task_getpgid:
- *	Check permission before getting the process group identifier of the
- *	process @p.
- *	@p contains the task_struct for the process.
- *	Return 0 if permission is granted.
- * @task_getsid:
- *	Check permission before getting the session identifier of the process
- *	@p.
- *	@p contains the task_struct for the process.
- *	Return 0 if permission is granted.
- * @current_getsecid_subj:
- *	Retrieve the subjective security identifier of the current task and
- *	return it in @secid.
- *	In case of failure, @secid will be set to zero.
- * @task_getsecid_obj:
- *	Retrieve the objective security identifier of the task_struct in @p
- *	and return it in @secid.
- *	In case of failure, @secid will be set to zero.
- *
- * @task_setnice:
- *	Check permission before setting the nice value of @p to @nice.
- *	@p contains the task_struct of process.
- *	@nice contains the new nice value.
- *	Return 0 if permission is granted.
- * @task_setioprio:
- *	Check permission before setting the ioprio value of @p to @ioprio.
- *	@p contains the task_struct of process.
- *	@ioprio contains the new ioprio value.
- *	Return 0 if permission is granted.
- * @task_getioprio:
- *	Check permission before getting the ioprio value of @p.
- *	@p contains the task_struct of process.
- *	Return 0 if permission is granted.
- * @task_prlimit:
- *	Check permission before getting and/or setting the resource limits of
- *	another task.
- *	@cred points to the cred structure for the current task.
- *	@tcred points to the cred structure for the target task.
- *	@flags contains the LSM_PRLIMIT_* flag bits indicating whether the
- *	resource limits are being read, modified, or both.
- *	Return 0 if permission is granted.
- * @task_setrlimit:
- *	Check permission before setting the resource limits of process @p
- *	for @resource to @new_rlim.  The old resource limit values can
- *	be examined by dereferencing (p->signal->rlim + resource).
- *	@p points to the task_struct for the target task's group leader.
- *	@resource contains the resource whose limit is being set.
- *	@new_rlim contains the new limits for @resource.
- *	Return 0 if permission is granted.
- * @task_setscheduler:
- *	Check permission before setting scheduling policy and/or parameters of
- *	process @p.
- *	@p contains the task_struct for process.
- *	Return 0 if permission is granted.
- * @task_getscheduler:
- *	Check permission before obtaining scheduling information for process
- *	@p.
- *	@p contains the task_struct for process.
- *	Return 0 if permission is granted.
- * @task_movememory:
- *	Check permission before moving memory owned by process @p.
- *	@p contains the task_struct for process.
- *	Return 0 if permission is granted.
- * @task_kill:
- *	Check permission before sending signal @sig to @p.  @info can be NULL,
- *	the constant 1, or a pointer to a kernel_siginfo structure.  If @info is 1 or
- *	SI_FROMKERNEL(info) is true, then the signal should be viewed as coming
- *	from the kernel and should typically be permitted.
- *	SIGIO signals are handled separately by the send_sigiotask hook in
- *	file_security_ops.
- *	@p contains the task_struct for process.
- *	@info contains the signal information.
- *	@sig contains the signal value.
- *	@cred contains the cred of the process where the signal originated, or
- *	NULL if the current task is the originator.
- *	Return 0 if permission is granted.
- * @task_prctl:
- *	Check permission before performing a process control operation on the
- *	current process.
- *	@option contains the operation.
- *	@arg2 contains a argument.
- *	@arg3 contains a argument.
- *	@arg4 contains a argument.
- *	@arg5 contains a argument.
- *	Return -ENOSYS if no-one wanted to handle this op, any other value to
- *	cause prctl() to return immediately with that value.
- * @task_to_inode:
- *	Set the security attributes for an inode based on an associated task's
- *	security attributes, e.g. for /proc/pid inodes.
- *	@p contains the task_struct for the task.
- *	@inode contains the inode structure for the inode.
- * @userns_create:
- *	Check permission prior to creating a new user namespace.
- *	@cred points to prepared creds.
- *	Return 0 if successful, otherwise < 0 error code.
- *
  * Security hooks for Netlink messaging.
  *
  * @netlink_send:
diff --git a/security/security.c b/security/security.c
index 7c6ad5d5b3ef..b43000cda9ff 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2655,6 +2655,15 @@ int security_file_truncate(struct file *file)
 	return call_int_hook(file_truncate, 0, file);
 }
 
+/**
+ * security_task_alloc() - Allocate a task's LSM blob
+ * @task: the task
+ * @clone_flags: flags indicating what is being shared
+ *
+ * Handle allocation of task-related resources.
+ *
+ * Return: Returns a zero on success, negative values on failure.
+ */
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
 	int rc = lsm_task_alloc(task);
@@ -2667,6 +2676,13 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 	return rc;
 }
 
+/**
+ * security_task_free() - Free a task's LSM blob and related resources
+ * @task: task
+ *
+ * Handle release of task-related resources.  Note that this can be called from
+ * interrupt context.
+ */
 void security_task_free(struct task_struct *task)
 {
 	call_void_hook(task_free, task);
@@ -2675,6 +2691,16 @@ void security_task_free(struct task_struct *task)
 	task->security = NULL;
 }
 
+/**
+ * security_cred_alloc_blank() - Allocate the min memory to allow cred_transfer
+ * @cred: credentials
+ * @gfp: gfp flags
+ *
+ * Only allocate sufficient memory and attach to @cred such that
+ * cred_transfer() will not get ENOMEM.
+ *
+ * Return: Returns 0 on success, negative values on failure.
+ */
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(cred, gfp);
@@ -2688,6 +2714,12 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	return rc;
 }
 
+/**
+ * security_cred_free() - Free the cred's LSM blob and associated resources
+ * @cred: credentials
+ *
+ * Deallocate and clear the cred->security field in a set of credentials.
+ */
 void security_cred_free(struct cred *cred)
 {
 	/*
@@ -2703,6 +2735,16 @@ void security_cred_free(struct cred *cred)
 	cred->security = NULL;
 }
 
+/**
+ * security_prepare_creds() - Prepare a new set of credentials
+ * @new: new credentials
+ * @old: original credentials
+ * @gfp: gfp flags
+ *
+ * Prepare a new set of credentials by copying the data from the old set.
+ *
+ * Return: Returns 0 on success, negative values on failure.
+ */
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(new, gfp);
@@ -2716,11 +2758,26 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 	return rc;
 }
 
+/**
+ * security_transfer_creds() - Transfer creds
+ * @new: target credentials
+ * @old: original credentials
+ *
+ * Transfer data from original creds to new creds.
+ */
 void security_transfer_creds(struct cred *new, const struct cred *old)
 {
 	call_void_hook(cred_transfer, new, old);
 }
 
+/**
+ * security_cred_getsecid() - Get the secid from a set of credentials
+ * @c: credentials
+ * @secid: secid value
+ *
+ * Retrieve the security identifier of the cred structure @c.  In case of
+ * failure, @secid will be set to zero.
+ */
 void security_cred_getsecid(const struct cred *c, u32 *secid)
 {
 	*secid = 0;
@@ -2728,16 +2785,46 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
+/**
+ * security_kernel_act_as() - Set the kernel credentials to act as secid
+ * @new: credentials
+ * @secid: secid
+ *
+ * Set the credentials for a kernel service to act as (subjective context).
+ * The current task must be the one that nominated @secid.
+ *
+ * Return: Returns 0 if successful.
+ */
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
 	return call_int_hook(kernel_act_as, 0, new, secid);
 }
 
+/**
+ * security_kernel_create_files_as() - Set file creation context using an inode
+ * @new: target credentials
+ * @inode: reference inode
+ *
+ * Set the file creation context in a set of credentials to be the same as the
+ * objective context of the specified inode.  The current task must be the one
+ * that nominated @inode.
+ *
+ * Return: Returns 0 if successful.
+ */
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	return call_int_hook(kernel_create_files_as, 0, new, inode);
 }
 
+/**
+ * security_kernel_module_request() - Check is loading a module is allowed
+ * @kmod_name: module name
+ *
+ * Ability to trigger the kernel to automatically upcall to userspace for
+ * userspace to load a kernel module with the given name.
+ *
+ * Return: Returns 0 if successful.
+ */
 int security_kernel_module_request(char *kmod_name)
 {
 	int ret;
@@ -2748,6 +2835,16 @@ int security_kernel_module_request(char *kmod_name)
 	return integrity_kernel_module_request(kmod_name);
 }
 
+/**
+ * security_kernel_read_file() - Read a file specified by userspace
+ * @file: file
+ * @id: file identifier
+ * @contents: trust if security_kernel_post_read_file() will be called
+ *
+ * Read a file specified by userspace.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 			      bool contents)
 {
@@ -2760,6 +2857,19 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
+/**
+ * security_kernel_post_read_file() - Read a file specified by userspace
+ * @file: file
+ * @buf: file contents
+ * @size: size of file contents
+ * @id: file identifier
+ *
+ * Read a file specified by userspace.  This must be paired with a prior call
+ * to security_kernel_read_file() call that indicated this hook would also be
+ * called, see security_kernel_read_file() for more information.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
 {
@@ -2772,6 +2882,15 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
+/**
+ * security_kernel_load_data() - Load data provided by userspace
+ * @id: data identifier
+ * @contents: true if security_kernel_post_load_data() will be called
+ *
+ * Load data provided by userspace.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int ret;
@@ -2783,6 +2902,20 @@ int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
 }
 EXPORT_SYMBOL_GPL(security_kernel_load_data);
 
+/**
+ * security_kernel_post_load_data() - Load userspace data from a non-file source
+ * @buf: data
+ * @size: size of data
+ * @id: data identifier
+ * @description: text description of data, specific to the id value
+ *
+ * Load data provided by a non-file source (usually userspace buffer).  This
+ * must be paired with a prior security_kernel_load_data() call that indicated
+ * this hook would also be called, see security_kernel_load_data() for more
+ * information.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_kernel_post_load_data(char *buf, loff_t size,
 				   enum kernel_load_data_id id,
 				   char *description)
@@ -2797,38 +2930,112 @@ int security_kernel_post_load_data(char *buf, loff_t size,
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
 
+/**
+ * security_task_fix_setuid() - Update LSM with new user id attributes
+ * @new: updated credentials
+ * @old: credentials being replaced
+ * @flags: LSM_SETID_* flag values
+ *
+ * Update the module's state after setting one or more of the user identity
+ * attributes of the current process.  The @flags parameter indicates which of
+ * the set*uid system calls invoked this hook.  If @new is the set of
+ * credentials that will be installed.  Modifications should be made to this
+ * rather than to @current->cred.
+ *
+ * Return: Returns 0 on success.
+ */
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
 	return call_int_hook(task_fix_setuid, 0, new, old, flags);
 }
 
+/**
+ * security_task_fix_setgid() - Update LSM with new group id attributes
+ * @new: updated credentials
+ * @old: credentials being replaced
+ * @flags: LSM_SETID_* flag value
+ *
+ * Update the module's state after setting one or more of the group identity
+ * attributes of the current process.  The @flags parameter indicates which of
+ * the set*gid system calls invoked this hook.  @new is the set of credentials
+ * that will be installed.  Modifications should be made to this rather than to
+ * @current->cred.
+ *
+ * Return: Returns 0 on success.
+ */
 int security_task_fix_setgid(struct cred *new, const struct cred *old,
 				 int flags)
 {
 	return call_int_hook(task_fix_setgid, 0, new, old, flags);
 }
 
+/**
+ * security_task_fix_setgroups() - Update LSM with new supplementary groups
+ * @new: updated credentials
+ * @old: credentials being replaced
+ *
+ * Update the module's state after setting the supplementary group identity
+ * attributes of the current process.  @new is the set of credentials that will
+ * be installed.  Modifications should be made to this rather than to
+ * @current->cred.
+ *
+ * Return: Returns 0 on success.
+ */
 int security_task_fix_setgroups(struct cred *new, const struct cred *old)
 {
 	return call_int_hook(task_fix_setgroups, 0, new, old);
 }
 
+/**
+ * security_task_setpgid() - Check if setting the pgid is allowed
+ * @p: task being modified
+ * @pgid: new pgid
+ *
+ * Check permission before setting the process group identifier of the process
+ * @p to @pgid.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return call_int_hook(task_setpgid, 0, p, pgid);
 }
 
+/**
+ * security_task_getpgid() - Check if getting the pgid is allowed
+ * @p: task
+ *
+ * Check permission before getting the process group identifier of the process
+ * @p.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_getpgid(struct task_struct *p)
 {
 	return call_int_hook(task_getpgid, 0, p);
 }
 
+/**
+ * security_task_getsid() - Check if getting the session id is allowed
+ * @p: task
+ *
+ * Check permission before getting the session identifier of the process @p.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_getsid(struct task_struct *p)
 {
 	return call_int_hook(task_getsid, 0, p);
 }
 
+/**
+ * security_current_getsecid_subj() - Get the current task's subjective secid
+ * @secid: secid value
+ *
+ * Retrieve the subjective security identifier of the current task and return
+ * it in @secid.  In case of failure, @secid will be set to zero.
+ */
 void security_current_getsecid_subj(u32 *secid)
 {
 	*secid = 0;
@@ -2836,6 +3043,14 @@ void security_current_getsecid_subj(u32 *secid)
 }
 EXPORT_SYMBOL(security_current_getsecid_subj);
 
+/**
+ * security_task_getsecid_obj() - Get a task's objective secid
+ * @p: target task
+ * @secid: secid value
+ *
+ * Retrieve the objective security identifier of the task_struct in @p and
+ * return it in @secid. In case of failure, @secid will be set to zero.
+ */
 void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
 {
 	*secid = 0;
@@ -2843,54 +3058,157 @@ void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
 }
 EXPORT_SYMBOL(security_task_getsecid_obj);
 
+/**
+ * security_task_setnice() - Check if setting a task's nice value is allowed
+ * @p: target task
+ * @nice: nice value
+ *
+ * Check permission before setting the nice value of @p to @nice.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_setnice(struct task_struct *p, int nice)
 {
 	return call_int_hook(task_setnice, 0, p, nice);
 }
 
+/**
+ * security_task_setioprio() - Check if setting a task's ioprio is allowed
+ * @p: target task
+ * @ioprio: ioprio value
+ *
+ * Check permission before setting the ioprio value of @p to @ioprio.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_setioprio(struct task_struct *p, int ioprio)
 {
 	return call_int_hook(task_setioprio, 0, p, ioprio);
 }
 
+/**
+ * security_task_getioprio() - Check if getting a task's ioprio is allowed
+ * @p: task
+ *
+ * Check permission before getting the ioprio value of @p.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_getioprio(struct task_struct *p)
 {
 	return call_int_hook(task_getioprio, 0, p);
 }
 
+/**
+ * security_task_prlimit() - Check if get/setting resources limits is allowed
+ * @cred: current task credentials
+ * @tcred: target task credentials
+ * @flags: LSM_PRLIMIT_* flag bits indicating a get/set/both
+ *
+ * Check permission before getting and/or setting the resource limits of
+ * another task.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
 			  unsigned int flags)
 {
 	return call_int_hook(task_prlimit, 0, cred, tcred, flags);
 }
 
+/**
+ * security_task_setrlimit() - Check if setting a new rlimit value is allowed
+ * @p: target task's group leader
+ * @resource: resource whose limit is being set
+ * @new_rlim: new resource limit
+ *
+ * Check permission before setting the resource limits of process @p for
+ * @resource to @new_rlim.  The old resource limit values can be examined by
+ * dereferencing (p->signal->rlim + resource).
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_setrlimit(struct task_struct *p, unsigned int resource,
 		struct rlimit *new_rlim)
 {
 	return call_int_hook(task_setrlimit, 0, p, resource, new_rlim);
 }
 
+/**
+ * security_task_setscheduler() - Check if setting sched policy/param is allowed
+ * @p: target task
+ *
+ * Check permission before setting scheduling policy and/or parameters of
+ * process @p.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_setscheduler(struct task_struct *p)
 {
 	return call_int_hook(task_setscheduler, 0, p);
 }
 
+/**
+ * security_task_getscheduler() - Check if getting scheduling info is allowed
+ * @p: target task
+ *
+ * Check permission before obtaining scheduling information for process @p.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_getscheduler(struct task_struct *p)
 {
 	return call_int_hook(task_getscheduler, 0, p);
 }
 
+/**
+ * security_task_movememory() - Check if moving memory is allowed
+ * @p: task
+ *
+ * Check permission before moving memory owned by process @p.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_movememory(struct task_struct *p)
 {
 	return call_int_hook(task_movememory, 0, p);
 }
 
+/**
+ * security_task_kill() - Check if sending a signal is allowed
+ * @p: target process
+ * @info: signal information
+ * @sig: signal value
+ * @cred: credentials of the signal sender, NULL if @current
+ *
+ * Check permission before sending signal @sig to @p.  @info can be NULL, the
+ * constant 1, or a pointer to a kernel_siginfo structure.  If @info is 1 or
+ * SI_FROMKERNEL(info) is true, then the signal should be viewed as coming from
+ * the kernel and should typically be permitted.  SIGIO signals are handled
+ * separately by the send_sigiotask hook in file_security_ops.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 			int sig, const struct cred *cred)
 {
 	return call_int_hook(task_kill, 0, p, info, sig, cred);
 }
 
+/**
+ * security_task_prctl() - Check if a prctl op is allowed
+ * @option: operation
+ * @arg2: argument
+ * @arg3: argument
+ * @arg4: argument
+ * @arg5: argument
+ *
+ * Check permission before performing a process control operation on the
+ * current process.
+ *
+ * Return: Return -ENOSYS if no-one wanted to handle this op, any other value
+ *         to cause prctl() to return immediately with that value.
+ */
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
@@ -2909,11 +3227,27 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 	return rc;
 }
 
+/**
+ * security_task_to_inode() - Set the security attributes of a task's inode
+ * @p: task
+ * @inode: inode
+ *
+ * Set the security attributes for an inode based on an associated task's
+ * security attributes, e.g. for /proc/pid inodes.
+ */
 void security_task_to_inode(struct task_struct *p, struct inode *inode)
 {
 	call_void_hook(task_to_inode, p, inode);
 }
 
+/**
+ * security_create_user_ns() - Check if creating a new userns is allowed
+ * @cred: prepared creds
+ *
+ * Check permission prior to creating a new user namespace.
+ *
+ * Return: Returns 0 if successful, otherwise < 0 error code.
+ */
 int security_create_user_ns(const struct cred *cred)
 {
 	return call_int_hook(userns_create, 0, cred);
-- 
2.39.2

