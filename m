Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8815C05027
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjBQD1P (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjBQD0z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:55 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FC85383B
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:51 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id cr22so4268986qtb.10
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9Jg7qR5G+KXtCl0rMnjBlK/lKaP69unjCq62JNkbXU=;
        b=fZpwATO09en3y2VdftRdJyuUVg85t2FwTXlc4+JRttiTKoCiIsCGxSlqy0l/8mj9o7
         jmpq3u+xEPl7SSbRq6yod+3wtB3jEXEosJ3tZLn4Dz7SNyFoOnAb95KrtvOf5F7fUeDu
         9WLuDplQZJYNjSjBPxrVIYAMQvGLadlS1X+IEtf80OKi6rCEKgJDBtcD2oaM8CO/JubL
         67NL/liZozr1BVH16YGA/ngCnKdVUltgZXPFFTIfVpHe3Q+N+FTn5b1PODtg16oFfYh+
         c9vF8Hz8h2OI2IVpPF57BtCNo5NSO1qrTytv38KX2ggSudQ7UUI1Os35jtLyg3OVg5p6
         aEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9Jg7qR5G+KXtCl0rMnjBlK/lKaP69unjCq62JNkbXU=;
        b=i5aADde2b92xRCvds9s4LDBtHuK40zXXCFF5w+88LrJFwkAhKJAK9dPCD4d8j9hl2V
         EhMCytFRHoXXcncPgmmyo/2y3utzS8zksV//cYGCU7zZ94ocdYRSAm7nG9kAoixKSfXI
         JYLb2k/IAbUOeu98FH2pfU78fs7CUQEta1MC4dWQZ3BxasQDErEZX2ffPowSYCrDIrZV
         FwYQsaptuFX+8lR55QmadsX8SDzDrQy527TSWILrBe/IYl4+Nnl0VDC1A7DQeRVjhDw7
         K1dnZOtB38a2glk747T6cPbJe9lnaK9BL94h32yDPwIyeq5G2POm+/XEmzxU+n2nQqGE
         RWKA==
X-Gm-Message-State: AO0yUKXpZqvS4kE9/JndsyamM483xvyAj3I4rvjSZPUBIw7tyZivhLjj
        bRTvkXciXVn22VRopNMTsBVYfy7Y7H+fxfQ=
X-Google-Smtp-Source: AK7set8CWanF6siy1lGOPg5mT0k+XwK5UIAWoxDMX7M7UWNdDPA6/2zQeC442jKsop/YmMmr90FxKg==
X-Received: by 2002:ac8:570e:0:b0:3a8:20fd:7111 with SMTP id 14-20020ac8570e000000b003a820fd7111mr12598087qtw.39.1676604409005;
        Thu, 16 Feb 2023 19:26:49 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id k5-20020ac80205000000b003b86d3ca969sm381144qtg.51.2023.02.16.19.26.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:48 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 15/22] lsm: move the sysv hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:18 -0500
Message-Id: <20230217032625.678457-16-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h | 141 ----------------------------
 security/security.c       | 191 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 141 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2cfa56e3abc3..f6679fead627 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,147 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks affecting all System V IPC operations.
- *
- * @ipc_permission:
- *	Check permissions for access to IPC
- *	@ipcp contains the kernel IPC permission structure.
- *	@flag contains the desired (requested) permission set.
- *	Return 0 if permission is granted.
- * @ipc_getsecid:
- *	Get the secid associated with the ipc object.
- *	@ipcp contains the kernel IPC permission structure.
- *	@secid contains a pointer to the location where result will be saved.
- *	In case of failure, @secid will be set to zero.
- *
- * Security hooks for individual messages held in System V IPC message queues
- *
- * @msg_msg_alloc_security:
- *	Allocate and attach a security structure to the msg->security field.
- *	The security field is initialized to NULL when the structure is first
- *	created.
- *	@msg contains the message structure to be modified.
- *	Return 0 if operation was successful and permission is granted.
- * @msg_msg_free_security:
- *	Deallocate the security structure for this message.
- *	@msg contains the message structure to be modified.
- *
- * Security hooks for System V IPC Message Queues
- *
- * @msg_queue_alloc_security:
- *	Allocate and attach a security structure to the
- *	@perm->security field. The security field is initialized to
- *	NULL when the structure is first created.
- *	@perm contains the IPC permissions of the message queue.
- *	Return 0 if operation was successful and permission is granted.
- * @msg_queue_free_security:
- *	Deallocate security field @perm->security for the message queue.
- *	@perm contains the IPC permissions of the message queue.
- * @msg_queue_associate:
- *	Check permission when a message queue is requested through the
- *	msgget system call. This hook is only called when returning the
- *	message queue identifier for an existing message queue, not when a
- *	new message queue is created.
- *	@perm contains the IPC permissions of the message queue.
- *	@msqflg contains the operation control flags.
- *	Return 0 if permission is granted.
- * @msg_queue_msgctl:
- *	Check permission when a message control operation specified by @cmd
- *	is to be performed on the message queue with permissions @perm.
- *	The @perm may be NULL, e.g. for IPC_INFO or MSG_INFO.
- *	@perm contains the IPC permissions of the msg queue. May be NULL.
- *	@cmd contains the operation to be performed.
- *	Return 0 if permission is granted.
- * @msg_queue_msgsnd:
- *	Check permission before a message, @msg, is enqueued on the message
- *	queue with permissions @perm.
- *	@perm contains the IPC permissions of the message queue.
- *	@msg contains the message to be enqueued.
- *	@msqflg contains operational flags.
- *	Return 0 if permission is granted.
- * @msg_queue_msgrcv:
- *	Check permission before a message, @msg, is removed from the message
- *	queue. The @target task structure contains a pointer to the
- *	process that will be receiving the message (not equal to the current
- *	process when inline receives are being performed).
- *	@perm contains the IPC permissions of the message queue.
- *	@msg contains the message destination.
- *	@target contains the task structure for recipient process.
- *	@type contains the type of message requested.
- *	@mode contains the operational flags.
- *	Return 0 if permission is granted.
- *
- * Security hooks for System V Shared Memory Segments
- *
- * @shm_alloc_security:
- *	Allocate and attach a security structure to the @perm->security
- *	field. The security field is initialized to NULL when the structure is
- *	first created.
- *	@perm contains the IPC permissions of the shared memory structure.
- *	Return 0 if operation was successful and permission is granted.
- * @shm_free_security:
- *	Deallocate the security structure @perm->security for the memory segment.
- *	@perm contains the IPC permissions of the shared memory structure.
- * @shm_associate:
- *	Check permission when a shared memory region is requested through the
- *	shmget system call. This hook is only called when returning the shared
- *	memory region identifier for an existing region, not when a new shared
- *	memory region is created.
- *	@perm contains the IPC permissions of the shared memory structure.
- *	@shmflg contains the operation control flags.
- *	Return 0 if permission is granted.
- * @shm_shmctl:
- *	Check permission when a shared memory control operation specified by
- *	@cmd is to be performed on the shared memory region with permissions @perm.
- *	The @perm may be NULL, e.g. for IPC_INFO or SHM_INFO.
- *	@perm contains the IPC permissions of the shared memory structure.
- *	@cmd contains the operation to be performed.
- *	Return 0 if permission is granted.
- * @shm_shmat:
- *	Check permissions prior to allowing the shmat system call to attach the
- *	shared memory segment with permissions @perm to the data segment of the
- *	calling process. The attaching address is specified by @shmaddr.
- *	@perm contains the IPC permissions of the shared memory structure.
- *	@shmaddr contains the address to attach memory region to.
- *	@shmflg contains the operational flags.
- *	Return 0 if permission is granted.
- *
- * Security hooks for System V Semaphores
- *
- * @sem_alloc_security:
- *	Allocate and attach a security structure to the @perm->security
- *	field. The security field is initialized to NULL when the structure is
- *	first created.
- *	@perm contains the IPC permissions of the semaphore.
- *	Return 0 if operation was successful and permission is granted.
- * @sem_free_security:
- *	Deallocate security structure @perm->security for the semaphore.
- *	@perm contains the IPC permissions of the semaphore.
- * @sem_associate:
- *	Check permission when a semaphore is requested through the semget
- *	system call. This hook is only called when returning the semaphore
- *	identifier for an existing semaphore, not when a new one must be
- *	created.
- *	@perm contains the IPC permissions of the semaphore.
- *	@semflg contains the operation control flags.
- *	Return 0 if permission is granted.
- * @sem_semctl:
- *	Check permission when a semaphore operation specified by @cmd is to be
- *	performed on the semaphore. The @perm may be NULL, e.g. for
- *	IPC_INFO or SEM_INFO.
- *	@perm contains the IPC permissions of the semaphore. May be NULL.
- *	@cmd contains the operation to be performed.
- *	Return 0 if permission is granted.
- * @sem_semop:
- *	Check permissions before performing operations on members of the
- *	semaphore set. If the @alter flag is nonzero, the semaphore set
- *	may be modified.
- *	@perm contains the IPC permissions of the semaphore.
- *	@sops contains the operations to perform.
- *	@nsops contains the number of operations to perform.
- *	@alter contains the flag indicating whether changes are to be made.
- *	Return 0 if permission is granted.
- *
  * @binder_set_context_mgr:
  *	Check whether @mgr is allowed to be the binder context manager.
  *	@mgr contains the struct cred for the current binder process.
diff --git a/security/security.c b/security/security.c
index cc2294e094ec..e26903e4ff75 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3253,17 +3253,43 @@ int security_create_user_ns(const struct cred *cred)
 	return call_int_hook(userns_create, 0, cred);
 }
 
+/**
+ * security_ipc_permission() - Check if sysv ipc access is allowed
+ * @ipcp: ipc permission structure
+ * @flags: requested permissions
+ *
+ * Check permissions for access to IPC.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
+/**
+ * security_ipc_getsecid() - Get the sysv ipc object's secid
+ * @ipcp: ipc permission structure
+ * @secid: secid pointer
+ *
+ * Get the secid associated with the ipc object.  In case of failure, @secid
+ * will be set to zero.
+ */
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
 	*secid = 0;
 	call_void_hook(ipc_getsecid, ipcp, secid);
 }
 
+/**
+ * security_msg_msg_alloc() - Allocate a sysv ipc message LSM blob
+ * @msg: message structure
+ *
+ * Allocate and attach a security structure to the msg->security field.  The
+ * security field is initialized to NULL when the structure is first created.
+ *
+ * Return: Return 0 if operation was successful and permission is granted.
+ */
 int security_msg_msg_alloc(struct msg_msg *msg)
 {
 	int rc = lsm_msg_msg_alloc(msg);
@@ -3276,6 +3302,12 @@ int security_msg_msg_alloc(struct msg_msg *msg)
 	return rc;
 }
 
+/**
+ * security_msg_msg_free() - Free a sysv ipc message LSM blob
+ * @msg: message structure
+ *
+ * Deallocate the security structure for this message.
+ */
 void security_msg_msg_free(struct msg_msg *msg)
 {
 	call_void_hook(msg_msg_free_security, msg);
@@ -3283,6 +3315,15 @@ void security_msg_msg_free(struct msg_msg *msg)
 	msg->security = NULL;
 }
 
+/**
+ * security_msg_queue_alloc() - Allocate a sysv ipc msg queue LSM blob
+ * @msq: sysv ipc permission structure
+ *
+ * Allocate and attach a security structure to @msg. The security field is
+ * initialized to NULL when the structure is first created.
+ *
+ * Return: Returns 0 if operation was successful and permission is granted.
+ */
 int security_msg_queue_alloc(struct kern_ipc_perm *msq)
 {
 	int rc = lsm_ipc_alloc(msq);
@@ -3295,6 +3336,12 @@ int security_msg_queue_alloc(struct kern_ipc_perm *msq)
 	return rc;
 }
 
+/**
+ * security_msg_queue_free() - Free a sysv ipc msg queue LSM blob
+ * @msq: sysv ipc permission structure
+ *
+ * Deallocate security field @perm->security for the message queue.
+ */
 void security_msg_queue_free(struct kern_ipc_perm *msq)
 {
 	call_void_hook(msg_queue_free_security, msq);
@@ -3302,28 +3349,84 @@ void security_msg_queue_free(struct kern_ipc_perm *msq)
 	msq->security = NULL;
 }
 
+/**
+ * security_msg_queue_associate() - Check if a msg queue operation is allowed
+ * @msq: sysv ipc permission structure
+ * @msqflg: operation flags
+ *
+ * Check permission when a message queue is requested through the msgget system
+ * call. This hook is only called when returning the message queue identifier
+ * for an existing message queue, not when a new message queue is created.
+ *
+ * Return: Return 0 if permission is granted.
+ */
 int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 {
 	return call_int_hook(msg_queue_associate, 0, msq, msqflg);
 }
 
+/**
+ * security_msg_queue_msgctl() - Check if a msg queue operation is allowed
+ * @msq: sysv ipc permission structure
+ * @cmd: operation
+ *
+ * Check permission when a message control operation specified by @cmd is to be
+ * performed on the message queue with permissions.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 {
 	return call_int_hook(msg_queue_msgctl, 0, msq, cmd);
 }
 
+/**
+ * security_msg_queue_msgsnd() - Check if sending a sysv ipc message is allowed
+ * @msq: sysv ipc permission structure
+ * @msg: message
+ * @msqflg: operation flags
+ *
+ * Check permission before a message, @msg, is enqueued on the message queue
+ * with permissions specified in @msq.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
 			       struct msg_msg *msg, int msqflg)
 {
 	return call_int_hook(msg_queue_msgsnd, 0, msq, msg, msqflg);
 }
 
+/**
+ * security_msg_queue_msgrcv() - Check if receiving a sysv ipc msg is allowed
+ * @msq: sysv ipc permission structure
+ * @msg: message
+ * @target: target task
+ * @type: type of message requested
+ * @mode: operation flags
+ *
+ * Check permission before a message, @msg, is removed from the message	queue.
+ * The @target task structure contains a pointer to the process that will be
+ * receiving the message (not equal to the current process when inline receives
+ * are being performed).
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
 			       struct task_struct *target, long type, int mode)
 {
 	return call_int_hook(msg_queue_msgrcv, 0, msq, msg, target, type, mode);
 }
 
+/**
+ * security_shm_alloc() - Allocate a sysv shm LSM blob
+ * @shp: sysv ipc permission structure
+ *
+ * Allocate and attach a security structure to the @shp security field.  The
+ * security field is initialized to NULL when the structure is first created.
+ *
+ * Return: Returns 0 if operation was successful and permission is granted.
+ */
 int security_shm_alloc(struct kern_ipc_perm *shp)
 {
 	int rc = lsm_ipc_alloc(shp);
@@ -3336,6 +3439,12 @@ int security_shm_alloc(struct kern_ipc_perm *shp)
 	return rc;
 }
 
+/**
+ * security_shm_free() - Free a sysv shm LSM blob
+ * @shp: sysv ipc permission structure
+ *
+ * Deallocate the security structure @perm->security for the memory segment.
+ */
 void security_shm_free(struct kern_ipc_perm *shp)
 {
 	call_void_hook(shm_free_security, shp);
@@ -3343,21 +3452,64 @@ void security_shm_free(struct kern_ipc_perm *shp)
 	shp->security = NULL;
 }
 
+/**
+ * security_shm_associate() - Check if a sysv shm operation is allowed
+ * @shp: sysv ipc permission structure
+ * @shmflg: operation flags
+ *
+ * Check permission when a shared memory region is requested through the shmget
+ * system call. This hook is only called when returning the shared memory
+ * region identifier for an existing region, not when a new shared memory
+ * region is created.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 {
 	return call_int_hook(shm_associate, 0, shp, shmflg);
 }
 
+/**
+ * security_shm_shmctl() - Check if a sysv shm operation is allowed
+ * @shp: sysv ipc permission structure
+ * @cmd: operation
+ *
+ * Check permission when a shared memory control operation specified by @cmd is
+ * to be performed on the shared memory region with permissions in @shp.
+ *
+ * Return: Return 0 if permission is granted.
+ */
 int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 {
 	return call_int_hook(shm_shmctl, 0, shp, cmd);
 }
 
+/**
+ * security_shm_shmat() - Check if a sysv shm attach operation is allowed
+ * @shp: sysv ipc permission structure
+ * @shmaddr: address of memory region to attach
+ * @shmflg: operation flags
+ *
+ * Check permissions prior to allowing the shmat system call to attach the
+ * shared memory segment with permissions @shp to the data segment of the
+ * calling process. The attaching address is specified by @shmaddr.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmflg)
 {
 	return call_int_hook(shm_shmat, 0, shp, shmaddr, shmflg);
 }
 
+/**
+ * security_sem_alloc() - Allocate a sysv semaphore LSM blob
+ * @sma: sysv ipc permission structure
+ *
+ * Allocate and attach a security structure to the @sma security field. The
+ * security field is initialized to NULL when the structure is first created.
+ *
+ * Return: Returns 0 if operation was successful and permission is granted.
+ */
 int security_sem_alloc(struct kern_ipc_perm *sma)
 {
 	int rc = lsm_ipc_alloc(sma);
@@ -3370,6 +3522,12 @@ int security_sem_alloc(struct kern_ipc_perm *sma)
 	return rc;
 }
 
+/**
+ * security_sem_free() - Free a sysv semaphore LSM blob
+ * @sma: sysv ipc permission structure
+ *
+ * Deallocate security structure @sma->security for the semaphore.
+ */
 void security_sem_free(struct kern_ipc_perm *sma)
 {
 	call_void_hook(sem_free_security, sma);
@@ -3377,16 +3535,49 @@ void security_sem_free(struct kern_ipc_perm *sma)
 	sma->security = NULL;
 }
 
+/**
+ * security_sem_associate() - Check if a sysv semaphore operation is allowed
+ * @sma: sysv ipc permission structure
+ * @semflg: operation flags
+ *
+ * Check permission when a semaphore is requested through the semget system
+ * call. This hook is only called when returning the semaphore identifier for
+ * an existing semaphore, not when a new one must be created.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
 {
 	return call_int_hook(sem_associate, 0, sma, semflg);
 }
 
+/**
+ * security_sem_ctl() - Check if a sysv semaphore operation is allowed
+ * @sma: sysv ipc permission structure
+ * @cmd: operation
+ *
+ * Check permission when a semaphore operation specified by @cmd is to be
+ * performed on the semaphore.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sem_semctl(struct kern_ipc_perm *sma, int cmd)
 {
 	return call_int_hook(sem_semctl, 0, sma, cmd);
 }
 
+/**
+ * security_sem_semop() - Check if a sysv semaphore operation is allowed
+ * @sma: sysv ipc permission structure
+ * @sops: operations to perform
+ * @nsops: number of operations
+ * @alter: flag indicating changes will be made
+ *
+ * Check permissions before performing operations on members of the semaphore
+ * set. If the @alter flag is nonzero, the semaphore set may be modified.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter)
 {
-- 
2.39.2

