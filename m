Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06432C43217
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 23:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71C161267
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 23:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhKJXDJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhKJXDH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Nov 2021 18:03:07 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC8AC061766
        for <linux-security-module@vger.kernel.org>; Wed, 10 Nov 2021 15:00:19 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p8-20020a17090a748800b001a6cceee8afso1792872pjk.4
        for <linux-security-module@vger.kernel.org>; Wed, 10 Nov 2021 15:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=07lCYCrXmOCDgwBfKKbg/JIwuiSVnzpHyVRe2DbtM58=;
        b=jLqpFv222d5DoyPeW7MxOguTNTuh/GoMu3SZmUuP3/MjII7EgRpj0uOtIxFiNhek0O
         T7l0olL98gQWJxj3uI0u+v9LJkU9sFCZ/J03t34eSY+Srz/70s6WpYopnQu56CrVCj6X
         izhv3KDi5hYBw/JgzW/sEpwzirkRaOyfJXzWUOfKzxRtI41StJKc0rrxVKP164NF8xGM
         AQSuTMuq9xYemZ4+qWuLvyQOIqJwl6i2LBFC4uoJi2fUKvlqGxr2xHR64Ll24ylZ7bYX
         Paf8dG30eDadCS71TIwUXkMC9pJ9d4H7D+Gurt3wEHoV/DFKCQBKg7hA5YmT/qTgTt2q
         6FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=07lCYCrXmOCDgwBfKKbg/JIwuiSVnzpHyVRe2DbtM58=;
        b=OIhpc/88pOBTjt/BPU4eDEVM2iri1ATnpJ9anrhWpTHqf/SSTkyo5mHuWQEPdU9NBq
         9rK2HdpcTbuDMfZOck/c0l0xYlGkNFfUTV9RV4kQm8fHf8GPGMJuiTDSoQbLkEMMd9AU
         Rd/g/d/1SggeXo+NZjdSj1ztF/afD+fkVBgGbi5oa2fJQ5efZfMH/GxWgnai4yHVb1TY
         uzm/05xGBojyInC3sY3bLopVw6CsDCnmnArlCOKH8egCiDCR4JXN8WcE1Nl91iyIo88U
         ZzrWfhpP9THZnIxA9Rdfbe5agptE6KgUPe08JD/wVQyEYKfH/QJkVCKf/6KeEDfYhC9h
         LW+Q==
X-Gm-Message-State: AOAM532mrwc35ouMKTjlOAdoBMa+fpXsmefiLyZMi5lqmzXmS5yFsc6P
        Z6RVbI/mUWPX+LllEf7FGa2yVuhyNw==
X-Google-Smtp-Source: ABdhPJxQGtacM5WXUysgkptSMALySLouvhGPBDpKILERW2N3C9gp+eEywYbs3nJ7vwriFTn29s4SkBxjIA==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:4a73:99b6:9694:8c4d])
 (user=tkjos job=sendgmr) by 2002:a17:902:c086:b0:142:7169:1573 with SMTP id
 j6-20020a170902c08600b0014271691573mr2868761pld.13.1636585219115; Wed, 10 Nov
 2021 15:00:19 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:00:13 -0800
In-Reply-To: <20211110230013.3271596-1-tkjos@google.com>
Message-Id: <20211110230013.3271596-2-tkjos@google.com>
Mime-Version: 1.0
References: <20211110230013.3271596-1-tkjos@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 4.19 2/2] binder: use cred instead of task for selinux checks
From:   Todd Kjos <tkjos@google.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jannh@google.com,
        jeffv@google.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

commit 52f88693378a58094c538662ba652aff0253c4fe upstream.

Since binder was integrated with selinux, it has passed
'struct task_struct' associated with the binder_proc
to represent the source and target of transactions.
The conversion of task to SID was then done in the hook
implementations. It turns out that there are race conditions
which can result in an incorrect security context being used.

Fix by using the 'struct cred' saved during binder_open and pass
it to the selinux subsystem.

Cc: stable@vger.kernel.org # 5.14 (need backport for earlier stables)
Fixes: 79af73079d75 ("Add security hooks to binder and implement the hooks for SELinux.")
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Change-Id: Id7157515d2b08f11683aeb8ad9b8f1da075d34e7
---
 drivers/android/binder.c  | 12 ++++++------
 include/linux/lsm_hooks.h | 28 ++++++++++++++--------------
 include/linux/security.h  | 28 ++++++++++++++--------------
 security/security.c       | 14 +++++++-------
 security/selinux/hooks.c  | 36 +++++++++++++++---------------------
 5 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 58e497db26b4..83be89c8627b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2337,7 +2337,7 @@ static int binder_translate_binder(struct flat_binder_object *fp,
 		ret = -EINVAL;
 		goto done;
 	}
-	if (security_binder_transfer_binder(proc->tsk, target_proc->tsk)) {
+	if (security_binder_transfer_binder(proc->cred, target_proc->cred)) {
 		ret = -EPERM;
 		goto done;
 	}
@@ -2383,7 +2383,7 @@ static int binder_translate_handle(struct flat_binder_object *fp,
 				  proc->pid, thread->pid, fp->handle);
 		return -EINVAL;
 	}
-	if (security_binder_transfer_binder(proc->tsk, target_proc->tsk)) {
+	if (security_binder_transfer_binder(proc->cred, target_proc->cred)) {
 		ret = -EPERM;
 		goto done;
 	}
@@ -2467,7 +2467,7 @@ static int binder_translate_fd(int fd,
 		ret = -EBADF;
 		goto err_fget;
 	}
-	ret = security_binder_transfer_file(proc->tsk, target_proc->tsk, file);
+	ret = security_binder_transfer_file(proc->cred, target_proc->cred, file);
 	if (ret < 0) {
 		ret = -EPERM;
 		goto err_security;
@@ -2851,8 +2851,8 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error_line = __LINE__;
 			goto err_invalid_target_handle;
 		}
-		if (security_binder_transaction(proc->tsk,
-						target_proc->tsk) < 0) {
+		if (security_binder_transaction(proc->cred,
+						target_proc->cred) < 0) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = -EPERM;
 			return_error_line = __LINE__;
@@ -4549,7 +4549,7 @@ static int binder_ioctl_set_ctx_mgr(struct file *filp)
 		ret = -EBUSY;
 		goto out;
 	}
-	ret = security_binder_set_context_mgr(proc->tsk);
+	ret = security_binder_set_context_mgr(proc->cred);
 	if (ret < 0)
 		goto out;
 	if (uid_valid(context->binder_context_mgr_uid)) {
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3833c871fd45..e65dace667d3 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1211,22 +1211,22 @@
  *
  * @binder_set_context_mgr:
  *	Check whether @mgr is allowed to be the binder context manager.
- *	@mgr contains the task_struct for the task being registered.
+ *	@mgr contains the struct cred for the current binder process.
  *	Return 0 if permission is granted.
  * @binder_transaction:
  *	Check whether @from is allowed to invoke a binder transaction call
  *	to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
+ *	@from contains the struct cred for the sending process.
+ *	@to contains the struct cred for the receiving process.
  * @binder_transfer_binder:
  *	Check whether @from is allowed to transfer a binder reference to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
+ *	@from contains the struct cred for the sending process.
+ *	@to contains the struct cred for the receiving process.
  * @binder_transfer_file:
  *	Check whether @from is allowed to transfer @file to @to.
- *	@from contains the task_struct for the sending task.
+ *	@from contains the struct cred for the sending process.
  *	@file contains the struct file being transferred.
- *	@to contains the task_struct for the receiving task.
+ *	@to contains the struct cred for the receiving process.
  *
  * @ptrace_access_check:
  *	Check permission before allowing the current process to trace the
@@ -1428,13 +1428,13 @@
  *
  */
 union security_list_options {
-	int (*binder_set_context_mgr)(struct task_struct *mgr);
-	int (*binder_transaction)(struct task_struct *from,
-					struct task_struct *to);
-	int (*binder_transfer_binder)(struct task_struct *from,
-					struct task_struct *to);
-	int (*binder_transfer_file)(struct task_struct *from,
-					struct task_struct *to,
+	int (*binder_set_context_mgr)(const struct cred *mgr);
+	int (*binder_transaction)(const struct cred *from,
+					const struct cred *to);
+	int (*binder_transfer_binder)(const struct cred *from,
+					const struct cred *to);
+	int (*binder_transfer_file)(const struct cred *from,
+					const struct cred *to,
 					struct file *file);
 
 	int (*ptrace_access_check)(struct task_struct *child,
diff --git a/include/linux/security.h b/include/linux/security.h
index 454cc963d145..273877cf47bf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -219,13 +219,13 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
 extern int security_init(void);
 
 /* Security operations */
-int security_binder_set_context_mgr(struct task_struct *mgr);
-int security_binder_transaction(struct task_struct *from,
-				struct task_struct *to);
-int security_binder_transfer_binder(struct task_struct *from,
-				    struct task_struct *to);
-int security_binder_transfer_file(struct task_struct *from,
-				  struct task_struct *to, struct file *file);
+int security_binder_set_context_mgr(const struct cred *mgr);
+int security_binder_transaction(const struct cred *from,
+				const struct cred *to);
+int security_binder_transfer_binder(const struct cred *from,
+				    const struct cred *to);
+int security_binder_transfer_file(const struct cred *from,
+				  const struct cred *to, struct file *file);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(struct task_struct *target,
@@ -442,25 +442,25 @@ static inline int security_init(void)
 	return 0;
 }
 
-static inline int security_binder_set_context_mgr(struct task_struct *mgr)
+static inline int security_binder_set_context_mgr(const struct cred *mgr)
 {
 	return 0;
 }
 
-static inline int security_binder_transaction(struct task_struct *from,
-					      struct task_struct *to)
+static inline int security_binder_transaction(const struct cred *from,
+					      const struct cred *to)
 {
 	return 0;
 }
 
-static inline int security_binder_transfer_binder(struct task_struct *from,
-						  struct task_struct *to)
+static inline int security_binder_transfer_binder(const struct cred *from,
+						  const struct cred *to)
 {
 	return 0;
 }
 
-static inline int security_binder_transfer_file(struct task_struct *from,
-						struct task_struct *to,
+static inline int security_binder_transfer_file(const struct cred *from,
+						const struct cred *to,
 						struct file *file)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 9478444bf93f..fc1410550b79 100644
--- a/security/security.c
+++ b/security/security.c
@@ -232,25 +232,25 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
 
 /* Security operations */
 
-int security_binder_set_context_mgr(struct task_struct *mgr)
+int security_binder_set_context_mgr(const struct cred *mgr)
 {
 	return call_int_hook(binder_set_context_mgr, 0, mgr);
 }
 
-int security_binder_transaction(struct task_struct *from,
-				struct task_struct *to)
+int security_binder_transaction(const struct cred *from,
+				const struct cred *to)
 {
 	return call_int_hook(binder_transaction, 0, from, to);
 }
 
-int security_binder_transfer_binder(struct task_struct *from,
-				    struct task_struct *to)
+int security_binder_transfer_binder(const struct cred *from,
+				    const struct cred *to)
 {
 	return call_int_hook(binder_transfer_binder, 0, from, to);
 }
 
-int security_binder_transfer_file(struct task_struct *from,
-				  struct task_struct *to, struct file *file)
+int security_binder_transfer_file(const struct cred *from,
+				  const struct cred *to, struct file *file)
 {
 	return call_int_hook(binder_transfer_file, 0, from, to, file);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 08833bbb97aa..89dfdbb13129 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2218,22 +2218,19 @@ static inline u32 open_file_to_av(struct file *file)
 
 /* Hook functions begin here. */
 
-static int selinux_binder_set_context_mgr(struct task_struct *mgr)
+static int selinux_binder_set_context_mgr(const struct cred *mgr)
 {
-	u32 mysid = current_sid();
-	u32 mgrsid = task_sid(mgr);
-
 	return avc_has_perm(&selinux_state,
-			    mysid, mgrsid, SECCLASS_BINDER,
+			    current_sid(), cred_sid(mgr), SECCLASS_BINDER,
 			    BINDER__SET_CONTEXT_MGR, NULL);
 }
 
-static int selinux_binder_transaction(struct task_struct *from,
-				      struct task_struct *to)
+static int selinux_binder_transaction(const struct cred *from,
+				      const struct cred *to)
 {
 	u32 mysid = current_sid();
-	u32 fromsid = task_sid(from);
-	u32 tosid = task_sid(to);
+	u32 fromsid = cred_sid(from);
+	u32 tosid = cred_sid(to);
 	int rc;
 
 	if (mysid != fromsid) {
@@ -2244,27 +2241,24 @@ static int selinux_binder_transaction(struct task_struct *from,
 			return rc;
 	}
 
-	return avc_has_perm(&selinux_state,
-			    fromsid, tosid, SECCLASS_BINDER, BINDER__CALL,
-			    NULL);
+	return avc_has_perm(&selinux_state, fromsid, tosid,
+			    SECCLASS_BINDER, BINDER__CALL, NULL);
 }
 
-static int selinux_binder_transfer_binder(struct task_struct *from,
-					  struct task_struct *to)
+static int selinux_binder_transfer_binder(const struct cred *from,
+					  const struct cred *to)
 {
-	u32 fromsid = task_sid(from);
-	u32 tosid = task_sid(to);
-
 	return avc_has_perm(&selinux_state,
-			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
+			    cred_sid(from), cred_sid(to),
+			    SECCLASS_BINDER, BINDER__TRANSFER,
 			    NULL);
 }
 
-static int selinux_binder_transfer_file(struct task_struct *from,
-					struct task_struct *to,
+static int selinux_binder_transfer_file(const struct cred *from,
+					const struct cred *to,
 					struct file *file)
 {
-	u32 sid = task_sid(to);
+	u32 sid = cred_sid(to);
 	struct file_security_struct *fsec = file->f_security;
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
-- 
2.34.0.rc0.344.g81b53c2807-goog

