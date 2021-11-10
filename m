Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B56DC433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 22:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697F16108B
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 22:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhKJXCJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhKJXCI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Nov 2021 18:02:08 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C82C061766
        for <linux-security-module@vger.kernel.org>; Wed, 10 Nov 2021 14:59:20 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x14-20020a627c0e000000b0049473df362dso2755104pfc.12
        for <linux-security-module@vger.kernel.org>; Wed, 10 Nov 2021 14:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZgDOM+i90WE4O3BFqC5f63hTaAyTnVe3S5YYAG3WBZ4=;
        b=U170gt9DENtYr6XKMUjbh7h7Jkg1yvW3a6Ipr9g/hdTAoq4f+r0eT4+i552tii57L3
         a3I6rnDT1a2znu1Gs+i5NuBEYqOP7TqZZylO9ScWzGgfxy1dwumFnLqCDzdh9/XSf0KC
         EqPkYN92jqCUYvwKHwqmA2Yev/yX4eI4NoSiJPy3+Uu2VyCUPNi4/ogIbdi0JjSskswt
         QaC2tnk7Qi8n2ubdKqfe3IxHwQcXP0tNUlkDSaPLFjd5BWMTvISYshgRiDoai70u/1kx
         +EUyFHa3xz5MB9ZgTLjQo8AAlNIY8rcMPfSmiNQK/iJFanh82+/FX6p+hYzgAcREOS0b
         XkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZgDOM+i90WE4O3BFqC5f63hTaAyTnVe3S5YYAG3WBZ4=;
        b=vysI/P43/r6zodeSwcaC8ozMwRNWhaT1/nV343ybV0M0OZcX+PUYqqE187cf2jTq4k
         DZlc9Z1VOl3YIPu2CDgmhU0iLnxXsGeU0IIkcuC+YiF6zfDeX/qdxAiUiMd8ifyxwL2Y
         3Dw6FUpLmyfPEGgXpGvWXhEfwyV9hl+7xyKgh4ya0w/0eprIS8GO62b2zxoWcDduiPs8
         5ZdBGfavN2WrJHKsBOULclfJP1yJdoM+6GTZcJ7qdy1p6nFNPu6utYny4oZy1BlXduVY
         rmlShdsAKVQYr/KsI9qI6DP2phK++VefZVHwiMiOhOEXzhq5uIS0qmoLxL0AYPD6xmGn
         feXQ==
X-Gm-Message-State: AOAM530jw83YccQkjg82LfaKB/PKV7Svm0HQjN/oQhmNdrXNUMaSjSIT
        zz19LyRAFXROiHohga42qewvA9cV3w==
X-Google-Smtp-Source: ABdhPJzfuCH83XN6iBmfiOIO7F6cZY44c5qY5NITSyG34Z5izfNUoXwCzI3Y3i1unKQmG4p/bCFK6MvtiA==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:4a73:99b6:9694:8c4d])
 (user=tkjos job=sendgmr) by 2002:a17:902:ced1:b0:141:e15d:49e0 with SMTP id
 d17-20020a170902ced100b00141e15d49e0mr2866121plg.27.1636585160008; Wed, 10
 Nov 2021 14:59:20 -0800 (PST)
Date:   Wed, 10 Nov 2021 14:59:10 -0800
In-Reply-To: <20211110225910.3268106-1-tkjos@google.com>
Message-Id: <20211110225910.3268106-2-tkjos@google.com>
Mime-Version: 1.0
References: <20211110225910.3268106-1-tkjos@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 4.4 2/2] binder: use cred instead of task for selinux checks
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
 drivers/android/binder.c  | 18 +++++++++---------
 include/linux/lsm_hooks.h | 32 ++++++++++++++++----------------
 include/linux/security.h  | 28 ++++++++++++++--------------
 security/security.c       | 14 +++++++-------
 security/selinux/hooks.c  | 31 +++++++++++++------------------
 5 files changed, 59 insertions(+), 64 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 0b27238b42c7..f4454292f228 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1420,8 +1420,8 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error = BR_FAILED_REPLY;
 			goto err_invalid_target_handle;
 		}
-		if (security_binder_transaction(proc->tsk,
-						target_proc->tsk) < 0) {
+		if (security_binder_transaction(proc->cred,
+						target_proc->cred) < 0) {
 			return_error = BR_FAILED_REPLY;
 			goto err_invalid_target_handle;
 		}
@@ -1576,8 +1576,8 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error = BR_FAILED_REPLY;
 				goto err_binder_get_ref_for_node_failed;
 			}
-			if (security_binder_transfer_binder(proc->tsk,
-							    target_proc->tsk)) {
+			if (security_binder_transfer_binder(proc->cred,
+							    target_proc->cred)) {
 				return_error = BR_FAILED_REPLY;
 				goto err_binder_get_ref_for_node_failed;
 			}
@@ -1616,8 +1616,8 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error = BR_FAILED_REPLY;
 				goto err_binder_get_ref_failed;
 			}
-			if (security_binder_transfer_binder(proc->tsk,
-							    target_proc->tsk)) {
+			if (security_binder_transfer_binder(proc->cred,
+							    target_proc->cred)) {
 				return_error = BR_FAILED_REPLY;
 				goto err_binder_get_ref_failed;
 			}
@@ -1680,8 +1680,8 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error = BR_FAILED_REPLY;
 				goto err_fget_failed;
 			}
-			if (security_binder_transfer_file(proc->tsk,
-							  target_proc->tsk,
+			if (security_binder_transfer_file(proc->cred,
+							  target_proc->cred,
 							  file) < 0) {
 				fput(file);
 				return_error = BR_FAILED_REPLY;
@@ -2763,7 +2763,7 @@ static int binder_ioctl_set_ctx_mgr(struct file *filp)
 		ret = -EBUSY;
 		goto out;
 	}
-	ret = security_binder_set_context_mgr(proc->tsk);
+	ret = security_binder_set_context_mgr(proc->cred);
 	if (ret < 0)
 		goto out;
 	if (uid_valid(binder_context_mgr_uid)) {
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ec3a6bab29de..169f4be3ce56 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1121,22 +1121,22 @@
  *
  * @binder_set_context_mgr
  *	Check whether @mgr is allowed to be the binder context manager.
- *	@mgr contains the task_struct for the task being registered.
+ *	@mgr contains the struct cred for the current binder process.
  *	Return 0 if permission is granted.
  * @binder_transaction
  *	Check whether @from is allowed to invoke a binder transaction call
  *	to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
- * @binder_transfer_binder
+ *	@from contains the struct cred for the sending process.
+ *	@to contains the struct cred for the receiving process.
+ * @binder_transfer_binder:
  *	Check whether @from is allowed to transfer a binder reference to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
- * @binder_transfer_file
+ *	@from contains the struct cred for the sending process.
+ *	@to contains the struct cred for the receiving process.
+ * @binder_transfer_file:
  *	Check whether @from is allowed to transfer @file to @to.
- *	@from contains the task_struct for the sending task.
+ *	@from contains the struct cred for the sending process.
  *	@file contains the struct file being transferred.
- *	@to contains the task_struct for the receiving task.
+ *	@to contains the struct cred for the receiving process.
  *
  * @ptrace_access_check:
  *	Check permission before allowing the current process to trace the
@@ -1301,13 +1301,13 @@
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
index 2f4c1f7aa7db..846c6d44d6be 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -182,13 +182,13 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
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
@@ -378,25 +378,25 @@ static inline int security_init(void)
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
index 0dde287db5c5..b81a709ff331 100644
--- a/security/security.c
+++ b/security/security.c
@@ -130,25 +130,25 @@ int __init security_module_enable(const char *module)
 
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
index 055bf769408e..44f4495e3fbd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1974,21 +1974,18 @@ static inline u32 open_file_to_av(struct file *file)
 
 /* Hook functions begin here. */
 
-static int selinux_binder_set_context_mgr(struct task_struct *mgr)
+static int selinux_binder_set_context_mgr(const struct cred *mgr)
 {
-	u32 mysid = current_sid();
-	u32 mgrsid = task_sid(mgr);
-
-	return avc_has_perm(mysid, mgrsid, SECCLASS_BINDER,
+	return avc_has_perm(current_sid(), cred_sid(mgr), SECCLASS_BINDER,
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
@@ -2002,21 +1999,19 @@ static int selinux_binder_transaction(struct task_struct *from,
 			    NULL);
 }
 
-static int selinux_binder_transfer_binder(struct task_struct *from,
-					  struct task_struct *to)
+static int selinux_binder_transfer_binder(const struct cred *from,
+					  const struct cred *to)
 {
-	u32 fromsid = task_sid(from);
-	u32 tosid = task_sid(to);
-
-	return avc_has_perm(fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
+	return avc_has_perm(cred_sid(from), cred_sid(to),
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
 	struct inode *inode = d_backing_inode(file->f_path.dentry);
 	struct inode_security_struct *isec = inode->i_security;
-- 
2.34.0.rc0.344.g81b53c2807-goog

