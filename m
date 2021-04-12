Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456C4C433ED
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Apr 2021 00:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100AA61074
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Apr 2021 00:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhDLAz4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 11 Apr 2021 20:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbhDLAz4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 11 Apr 2021 20:55:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A118C061574;
        Sun, 11 Apr 2021 17:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=muzQgvMbWiB+qCG5peNj017kfJ/xeW6UXxHnnXZVDyw=; b=PylK84hPe591LzpDK0rrkdrjOs
        1kCuxFTs89VZlnv9gmoOia+RzDHJz57UjvhdidtJ/1BiNaHSLVcvBRkpVUl3VzR5HlZ0QzfsyTXsT
        dDwxFfp9nuhQYzFtVdYdHVpFl9PwEf8nXVk5IVszQ04v67GcnALz58OU5WvQrFm43sPJCEtBgyzbR
        WHi05GHUXTOSwuMPKYlUMnARjKqX/c3qp/KrHHqO52OsUSvfRlKdUoBMpGMkGk3SiTFD+ujUOY5vS
        2nAZbfQ2wo+fdT+7Q3gqOLFd+V5z3OA1xtOx1SviEmR9AqDm/dMulJ+LcDzAl4/gKEzW6IiZjo8KD
        kCZr7erA==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVkrU-003eYL-EO; Mon, 12 Apr 2021 00:55:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] security: commoncap: clean up kernel-doc comments
Date:   Sun, 11 Apr 2021 17:55:28 -0700
Message-Id: <20210412005528.3326-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix kernel-doc notation in commoncap.c.

Use correct (matching) function name in comments as in code.
Use correct function argument names in kernel-doc comments.
Use kernel-doc's "Return:" format for function return values.

Fixes these kernel-doc warnings:

../security/commoncap.c:1206: warning: expecting prototype for cap_task_ioprio(). Prototype was for cap_task_setioprio() instead
../security/commoncap.c:1219: warning: expecting prototype for cap_task_ioprio(). Prototype was for cap_task_setnice() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: James Morris <jmorris@namei.org>
Cc: linux-security-module@vger.kernel.org
---
 security/commoncap.c |   50 +++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 17 deletions(-)

--- linux-next-20210409.orig/security/commoncap.c
+++ linux-next-20210409/security/commoncap.c
@@ -50,7 +50,7 @@ static void warn_setuid_and_fcaps_mixed(
 /**
  * cap_capable - Determine whether a task has a particular effective capability
  * @cred: The credentials to use
- * @ns:  The user namespace in which we need the capability
+ * @targ_ns:  The user namespace in which we need the capability
  * @cap: The capability to check for
  * @opts: Bitmask of options defined in include/linux/security.h
  *
@@ -289,7 +289,7 @@ int cap_capset(struct cred *new,
  * affects the security markings on that inode, and if it is, should
  * inode_killpriv() be invoked or the change rejected.
  *
- * Returns 1 if security.capability has a value, meaning inode_killpriv()
+ * Return: 1 if security.capability has a value, meaning inode_killpriv()
  * is required, 0 otherwise, meaning inode_killpriv() is not required.
  */
 int cap_inode_need_killpriv(struct dentry *dentry)
@@ -315,7 +315,7 @@ int cap_inode_need_killpriv(struct dentr
  * permissions. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply passs init_user_ns.
  *
- * Returns 0 if successful, -ve on error.
+ * Return: 0 if successful, -ve on error.
  */
 int cap_inode_killpriv(struct user_namespace *mnt_userns, struct dentry *dentry)
 {
@@ -532,7 +532,7 @@ static bool validheader(size_t size, con
  * permissions. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply passs init_user_ns.
  *
- * If all is ok, we return the new size, on error return < 0.
+ * Return: On success, return the new size; on error, return < 0.
  */
 int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 		      const void **ivalue, size_t size)
@@ -881,7 +881,9 @@ static inline bool nonroot_raised_pE(str
  *
  * Set up the proposed credentials for a new execution context being
  * constructed by execve().  The proposed creds in @bprm->cred is altered,
- * which won't take effect immediately.  Returns 0 if successful, -ve on error.
+ * which won't take effect immediately.
+ *
+ * Return: 0 if successful, -ve on error.
  */
 int cap_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
 {
@@ -1117,7 +1119,9 @@ static inline void cap_emulate_setxuid(s
  * @flags: Indications of what has changed
  *
  * Fix up the results of setuid() call before the credential changes are
- * actually applied, returning 0 to grant the changes, -ve to deny them.
+ * actually applied.
+ *
+ * Return: 0 to grant the changes, -ve to deny them.
  */
 int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
 {
@@ -1187,7 +1191,9 @@ static int cap_safe_nice(struct task_str
  * @p: The task to affect
  *
  * Detemine if the requested scheduler policy change is permitted for the
- * specified task, returning 0 if permission is granted, -ve if denied.
+ * specified task.
+ *
+ * Return: 0 if permission is granted, -ve if denied.
  */
 int cap_task_setscheduler(struct task_struct *p)
 {
@@ -1195,12 +1201,14 @@ int cap_task_setscheduler(struct task_st
 }
 
 /**
- * cap_task_ioprio - Detemine if I/O priority change is permitted
+ * cap_task_setioprio - Detemine if I/O priority change is permitted
  * @p: The task to affect
  * @ioprio: The I/O priority to set
  *
  * Detemine if the requested I/O priority change is permitted for the specified
- * task, returning 0 if permission is granted, -ve if denied.
+ * task.
+ *
+ * Return: 0 if permission is granted, -ve if denied.
  */
 int cap_task_setioprio(struct task_struct *p, int ioprio)
 {
@@ -1208,12 +1216,14 @@ int cap_task_setioprio(struct task_struc
 }
 
 /**
- * cap_task_ioprio - Detemine if task priority change is permitted
+ * cap_task_setnice - Detemine if task priority change is permitted
  * @p: The task to affect
  * @nice: The nice value to set
  *
  * Detemine if the requested task priority change is permitted for the
- * specified task, returning 0 if permission is granted, -ve if denied.
+ * specified task.
+ *
+ * Return: 0 if permission is granted, -ve if denied.
  */
 int cap_task_setnice(struct task_struct *p, int nice)
 {
@@ -1243,12 +1253,15 @@ static int cap_prctl_drop(unsigned long
 /**
  * cap_task_prctl - Implement process control functions for this security module
  * @option: The process control function requested
- * @arg2, @arg3, @arg4, @arg5: The argument data for this function
+ * @arg2: The argument data for this function
+ * @arg3: The argument data for this function
+ * @arg4: The argument data for this function
+ * @arg5: The argument data for this function
  *
  * Allow process control functions (sys_prctl()) to alter capabilities; may
  * also deny access to other functions not otherwise implemented here.
  *
- * Returns 0 or +ve on success, -ENOSYS if this function is not implemented
+ * Return: 0 or +ve on success, -ENOSYS if this function is not implemented
  * here, other -ve on error.  If -ENOSYS is returned, sys_prctl() and other LSM
  * modules will consider performing the function.
  */
@@ -1383,7 +1396,9 @@ int cap_task_prctl(int option, unsigned
  * @pages: The size of the mapping
  *
  * Determine whether the allocation of a new virtual mapping by the current
- * task is permitted, returning 1 if permission is granted, 0 if not.
+ * task is permitted.
+ *
+ * Return: 1 if permission is granted, 0 if not.
  */
 int cap_vm_enough_memory(struct mm_struct *mm, long pages)
 {
@@ -1396,14 +1411,15 @@ int cap_vm_enough_memory(struct mm_struc
 	return cap_sys_admin;
 }
 
-/*
+/**
  * cap_mmap_addr - check if able to map given addr
  * @addr: address attempting to be mapped
  *
  * If the process is attempting to map memory below dac_mmap_min_addr they need
  * CAP_SYS_RAWIO.  The other parameters to this function are unused by the
- * capability security module.  Returns 0 if this mapping should be allowed
- * -EPERM if not.
+ * capability security module.
+ *
+ * Return: 0 if this mapping should be allowed or -EPERM if not.
  */
 int cap_mmap_addr(unsigned long addr)
 {
