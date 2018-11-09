Return-Path: <SRS0=fuo0=NU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3226C43441
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 23:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5298120827
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 23:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lZhFVqyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5298120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeKJJEK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:04:10 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:35640 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbeKJJEK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 10 Nov 2018 04:04:10 -0500
Received: by mail-it1-f200.google.com with SMTP id n135-v6so5278312ita.0
        for <linux-security-module@vger.kernel.org>; Fri, 09 Nov 2018 15:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L7gmRUGgp0cJTpiI4/XwGXSmtw8FCQMkqEbhqTDmVQc=;
        b=lZhFVqyCEkeUBKiEjTkRHZAEy+V7GvYZiiv0HFCvIes5HwBqiFS/n/1roGIFF+P1ef
         ebkOMNmAU8vt2DhK1uPcdJvvbOMfT7mzDgsfKzq5RSy3JGicbRyxEW5B7Q+mc47Ss9G8
         b1PLwwCQtjWUd/pYJ8yXh2MNJqSZ/g09916e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L7gmRUGgp0cJTpiI4/XwGXSmtw8FCQMkqEbhqTDmVQc=;
        b=hJSk94/l0kiV6hIUEbHlRKI3BQ5D9VcygN+Cqx1bMeeT+apvhF6/+H1TcFsyPhB+Y6
         oJnUzcQdzD91YqdfoviKfVnJzlwmBqHXLIDLQVh9VaX84MOTInF7KSWuj2Zii2BdhZGl
         YA52+hNNjqUqLNrlCDr2sLM6EJ/QG+ntctqpsJxH+PtuczOPmkb7lYnZi5NM5fcyEm+c
         xUCXTHJKtfEcy6lepFQ3X3DSbo9MHgVj/Tir9vpKZgozb0EaUuBOILpiLT4N3UTdlk8d
         moe9oAdzZ2RtbvnWoI+EvYwNndTrSskGzZhTPZpVaonYN0J1aWnV9QXa+VAaxk+2OMsH
         yiZQ==
X-Gm-Message-State: AGRZ1gIKqgHmNqkqhyVqLzsbz7SHkBgVZrzPpJWiDbUNNzAHlyYLfPGy
        OhikXw6vicsDZILiO0rF0p4tgR8M88BX5qAn
X-Google-Smtp-Source: AJdET5cq4wMDIZTh5Z05tV8IZNFJE6fjKjZ5CGx0XnALOTPivokkv9v80MfkIaz+ZMiRRM3lV8DPoKoCoQdhZGxZ
X-Received: by 2002:a24:9ec3:: with SMTP id p186-v6mr3401393itd.11.1541805683522;
 Fri, 09 Nov 2018 15:21:23 -0800 (PST)
Date:   Fri,  9 Nov 2018 15:21:19 -0800
In-Reply-To: <CAJ-EccPiKPR-ZB+V=tTyAB3Gru2n_Pt4PFxEQf_3y_4c8g+TLg@mail.gmail.com>
Message-Id: <20181109232119.244869-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <CAJ-EccPiKPR-ZB+V=tTyAB3Gru2n_Pt4PFxEQf_3y_4c8g+TLg@mail.gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH] LSM: generalize flag passing to security_capable
From:   mortonm@chromium.org
To:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

This patch provides a general mechanism for passing flags to the
security_capable LSM hook. It replaces the specific 'audit' flag that is
used to tell security_capable whether it should log an audit message for
the given capability check. The reason for generalizing this flag
passing is so we can add an additional flag that signifies whether
security_capable is being called by a setid syscall (which is needed by
the proposed SafeSetID LSM). This generalization could also support
passing down the inode for CAP_DAC_OVERRIDE/READ_SEARCH checks so that
authorization could happen on a per-file basis for specific files rather
than all or nothing.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---

NOTE: Unlike the other patches in this thread, I haven't tested this one
yet besides making sure it compiles. Sending it out as an RFC and follow
up to earlier discussion.

 include/linux/lsm_hooks.h     |  8 ++++---
 include/linux/security.h      | 35 ++++++++++++++++++++----------
 kernel/capability.c           | 41 +++++++++++++++++++++++++++--------
 kernel/seccomp.c              |  7 ++++--
 security/apparmor/lsm.c       |  4 ++--
 security/commoncap.c          | 27 ++++++++++++++++-------
 security/safesetid/lsm.c      |  2 +-
 security/security.c           | 14 +++++-------
 security/selinux/hooks.c      | 13 ++++++-----
 security/smack/smack_access.c |  5 ++++-
 10 files changed, 104 insertions(+), 52 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8f1131c8dd54..69632ca425fa 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1266,7 +1266,7 @@
  *	@cred contains the credentials to use.
  *	@ns contains the user namespace we want the capability in
  *	@cap contains the capability <include/linux/capability.h>.
- *	@audit contains whether to write an audit message or not
+ *	@opts contains options for the capable check <include/linux/security.h>
  *	Return 0 if the capability is granted for @tsk.
  * @syslog:
  *	Check permission before accessing the kernel message ring or changing
@@ -1442,8 +1442,10 @@ union security_list_options {
 			const kernel_cap_t *effective,
 			const kernel_cap_t *inheritable,
 			const kernel_cap_t *permitted);
-	int (*capable)(const struct cred *cred, struct user_namespace *ns,
-			int cap, int audit);
+	int (*capable)(const struct cred *cred,
+			struct user_namespace *ns,
+			int cap,
+			struct security_capable_opts *opts);
 	int (*quotactl)(int cmds, int type, int id, struct super_block *sb);
 	int (*quota_on)(struct dentry *dentry);
 	int (*syslog)(int type);
diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..8db2aeb21c91 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -58,6 +58,13 @@ struct mm_struct;
 #define SECURITY_CAP_NOAUDIT 0
 #define SECURITY_CAP_AUDIT 1
 
+struct security_capable_opts {
+	/* If capable should audit the security request */
+	bool log_audit_message;
+	/* If capable is being called from a setid syscall */
+	bool in_setid;
+};
+
 /* LSM Agnostic defines for sb_set_mnt_opts */
 #define SECURITY_LSM_NATIVE_LABELS	1
 
@@ -72,7 +79,7 @@ enum lsm_event {
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
-		       int cap, int audit);
+		       int cap, struct security_capable_opts *opts);
 extern int cap_settime(const struct timespec64 *ts, const struct timezone *tz);
 extern int cap_ptrace_access_check(struct task_struct *child, unsigned int mode);
 extern int cap_ptrace_traceme(struct task_struct *parent);
@@ -159,6 +166,13 @@ extern int mmap_min_addr_handler(struct ctl_table *table, int write,
 typedef int (*initxattrs) (struct inode *inode,
 			   const struct xattr *xattr_array, void *fs_data);
 
+/* init a security_capable_opts struct with default values */
+static inline void init_security_capable_opts(struct security_capable_opts* opts)
+{
+	opts->log_audit_message = true;
+	opts->in_setid = false;
+}
+
 #ifdef CONFIG_SECURITY
 
 struct security_mnt_opts {
@@ -212,10 +226,10 @@ int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *effective,
 		    const kernel_cap_t *inheritable,
 		    const kernel_cap_t *permitted);
-int security_capable(const struct cred *cred, struct user_namespace *ns,
-			int cap);
-int security_capable_noaudit(const struct cred *cred, struct user_namespace *ns,
-			     int cap);
+int security_capable(const struct cred *cred,
+			struct user_namespace *ns,
+			int cap,
+			struct security_capable_opts *opts);
 int security_quotactl(int cmds, int type, int id, struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
@@ -470,14 +484,11 @@ static inline int security_capset(struct cred *new,
 }
 
 static inline int security_capable(const struct cred *cred,
-				   struct user_namespace *ns, int cap)
+				   struct user_namespace *ns,
+				   int cap,
+				   struct security_capable_opts *opts)
 {
-	return cap_capable(cred, ns, cap, SECURITY_CAP_AUDIT);
-}
-
-static inline int security_capable_noaudit(const struct cred *cred,
-					   struct user_namespace *ns, int cap) {
-	return cap_capable(cred, ns, cap, SECURITY_CAP_NOAUDIT);
+	return cap_capable(cred, ns, cap, opts);
 }
 
 static inline int security_quotactl(int cmds, int type, int id,
diff --git a/kernel/capability.c b/kernel/capability.c
index 1e1c0236f55b..d8ff27e6e7c4 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -297,9 +297,12 @@ bool has_ns_capability(struct task_struct *t,
 		       struct user_namespace *ns, int cap)
 {
 	int ret;
+	struct security_capable_opts opts;
+
+	init_security_capable_opts(&opts);
 
 	rcu_read_lock();
-	ret = security_capable(__task_cred(t), ns, cap);
+	ret = security_capable(__task_cred(t), ns, cap, &opts);
 	rcu_read_unlock();
 
 	return (ret == 0);
@@ -338,9 +341,13 @@ bool has_ns_capability_noaudit(struct task_struct *t,
 			       struct user_namespace *ns, int cap)
 {
 	int ret;
+	struct security_capable_opts opts;
+
+	init_security_capable_opts(&opts);
+	opts.log_audit_message = false;
 
 	rcu_read_lock();
-	ret = security_capable_noaudit(__task_cred(t), ns, cap);
+	ret = security_capable(__task_cred(t), ns, cap, &opts);
 	rcu_read_unlock();
 
 	return (ret == 0);
@@ -363,7 +370,9 @@ bool has_capability_noaudit(struct task_struct *t, int cap)
 	return has_ns_capability_noaudit(t, &init_user_ns, cap);
 }
 
-static bool ns_capable_common(struct user_namespace *ns, int cap, bool audit)
+static bool ns_capable_common(struct user_namespace *ns,
+			      int cap,
+			      struct security_capable_opts *opts)
 {
 	int capable;
 
@@ -372,8 +381,7 @@ static bool ns_capable_common(struct user_namespace *ns, int cap, bool audit)
 		BUG();
 	}
 
-	capable = audit ? security_capable(current_cred(), ns, cap) :
-			  security_capable_noaudit(current_cred(), ns, cap);
+	capable = security_capable(current_cred(), ns, cap, opts);
 	if (capable == 0) {
 		current->flags |= PF_SUPERPRIV;
 		return true;
@@ -394,7 +402,10 @@ static bool ns_capable_common(struct user_namespace *ns, int cap, bool audit)
  */
 bool ns_capable(struct user_namespace *ns, int cap)
 {
-	return ns_capable_common(ns, cap, true);
+	struct security_capable_opts opts;
+
+	init_security_capable_opts(&opts);
+	return ns_capable_common(ns, cap, &opts);
 }
 EXPORT_SYMBOL(ns_capable);
 
@@ -412,7 +423,11 @@ EXPORT_SYMBOL(ns_capable);
  */
 bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 {
-	return ns_capable_common(ns, cap, false);
+	struct security_capable_opts opts;
+
+	init_security_capable_opts(&opts);
+	opts.log_audit_message = false;
+	return ns_capable_common(ns, cap, &opts);
 }
 EXPORT_SYMBOL(ns_capable_noaudit);
 
@@ -448,10 +463,13 @@ EXPORT_SYMBOL(capable);
 bool file_ns_capable(const struct file *file, struct user_namespace *ns,
 		     int cap)
 {
+	struct security_capable_opts opts;
+
 	if (WARN_ON_ONCE(!cap_valid(cap)))
 		return false;
 
-	if (security_capable(file->f_cred, ns, cap) == 0)
+	init_security_capable_opts(&opts);
+	if (security_capable(file->f_cred, ns, cap, &opts) == 0)
 		return true;
 
 	return false;
@@ -500,10 +518,15 @@ bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns)
 {
 	int ret = 0;  /* An absent tracer adds no restrictions */
 	const struct cred *cred;
+	struct security_capable_opts opts;
+
+	init_security_capable_opts(&opts);
+	opts.log_audit_message = false;
+
 	rcu_read_lock();
 	cred = rcu_dereference(tsk->ptracer_cred);
 	if (cred)
-		ret = security_capable_noaudit(cred, ns, CAP_SYS_PTRACE);
+		ret = security_capable(cred, ns, CAP_SYS_PTRACE, &opts);
 	rcu_read_unlock();
 	return (ret == 0);
 }
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index fd023ac24e10..4b3c543a3cc1 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -370,12 +370,15 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 	struct seccomp_filter *sfilter;
 	int ret;
 	const bool save_orig = IS_ENABLED(CONFIG_CHECKPOINT_RESTORE);
+	struct security_capable_opts opts;
 
 	if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
 		return ERR_PTR(-EINVAL);
 
 	BUG_ON(INT_MAX / fprog->len < sizeof(struct sock_filter));
 
+	init_security_capable_opts(&opts);
+	opts.log_audit_message = false;
 	/*
 	 * Installing a seccomp filter requires that the task has
 	 * CAP_SYS_ADMIN in its namespace or be running with no_new_privs.
@@ -383,8 +386,8 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 	 * behavior of privileged children.
 	 */
 	if (!task_no_new_privs(current) &&
-	    security_capable_noaudit(current_cred(), current_user_ns(),
-				     CAP_SYS_ADMIN) != 0)
+	    security_capable(current_cred(), current_user_ns(),
+				     CAP_SYS_ADMIN, &opts) != 0)
 		return ERR_PTR(-EACCES);
 
 	/* Allocate a new seccomp_filter */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 74f17376202b..040dcdcce9a7 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -174,14 +174,14 @@ static int apparmor_capget(struct task_struct *target, kernel_cap_t *effective,
 }
 
 static int apparmor_capable(const struct cred *cred, struct user_namespace *ns,
-			    int cap, int audit)
+			    int cap, struct security_capable_opts *opts)
 {
 	struct aa_label *label;
 	int error = 0;
 
 	label = aa_get_newest_cred_label(cred);
 	if (!unconfined(label))
-		error = aa_capable(label, cap, audit);
+		error = aa_capable(label, cap, opts->log_audit_message);
 	aa_put_label(label);
 
 	return error;
diff --git a/security/commoncap.c b/security/commoncap.c
index f4c33abd9959..a66ad899b0d7 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -69,7 +69,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
  * kernel's capable() and has_capability() returns 1 for this case.
  */
 int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
-		int cap, int audit)
+		int cap, struct security_capable_opts *opts)
 {
 	struct user_namespace *ns = targ_ns;
 
@@ -223,12 +223,14 @@ int cap_capget(struct task_struct *target, kernel_cap_t *effective,
  */
 static inline int cap_inh_is_capped(void)
 {
+	struct security_capable_opts opts;
 
+	init_security_capable_opts(&opts);
 	/* they are so limited unless the current task has the CAP_SETPCAP
 	 * capability
 	 */
 	if (cap_capable(current_cred(), current_cred()->user_ns,
-			CAP_SETPCAP, SECURITY_CAP_AUDIT) == 0)
+			CAP_SETPCAP, &opts) == 0)
 		return 0;
 	return 1;
 }
@@ -1177,6 +1179,7 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 {
 	const struct cred *old = current_cred();
 	struct cred *new;
+	struct security_capable_opts opts;
 
 	switch (option) {
 	case PR_CAPBSET_READ:
@@ -1207,13 +1210,15 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 	 * capability-based-privilege environment.
 	 */
 	case PR_SET_SECUREBITS:
+		init_security_capable_opts(&opts);
 		if ((((old->securebits & SECURE_ALL_LOCKS) >> 1)
 		     & (old->securebits ^ arg2))			/*[1]*/
 		    || ((old->securebits & SECURE_ALL_LOCKS & ~arg2))	/*[2]*/
 		    || (arg2 & ~(SECURE_ALL_LOCKS | SECURE_ALL_BITS))	/*[3]*/
 		    || (cap_capable(current_cred(),
-				    current_cred()->user_ns, CAP_SETPCAP,
-				    SECURITY_CAP_AUDIT) != 0)		/*[4]*/
+				    current_cred()->user_ns,
+				    CAP_SETPCAP,
+				    &opts) != 0)			/*[4]*/
 			/*
 			 * [1] no changing of bits that are locked
 			 * [2] no unlocking of locks
@@ -1307,10 +1312,14 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 int cap_vm_enough_memory(struct mm_struct *mm, long pages)
 {
 	int cap_sys_admin = 0;
+	struct security_capable_opts opts;
 
-	if (cap_capable(current_cred(), &init_user_ns, CAP_SYS_ADMIN,
-			SECURITY_CAP_NOAUDIT) == 0)
+	init_security_capable_opts(&opts);
+	opts.log_audit_message = false;
+
+	if (cap_capable(current_cred(), &init_user_ns, CAP_SYS_ADMIN, &opts) == 0)
 		cap_sys_admin = 1;
+
 	return cap_sys_admin;
 }
 
@@ -1326,10 +1335,12 @@ int cap_vm_enough_memory(struct mm_struct *mm, long pages)
 int cap_mmap_addr(unsigned long addr)
 {
 	int ret = 0;
+	struct security_capable_opts opts;
 
+	init_security_capable_opts(&opts);
 	if (addr < dac_mmap_min_addr) {
-		ret = cap_capable(current_cred(), &init_user_ns, CAP_SYS_RAWIO,
-				  SECURITY_CAP_AUDIT);
+		ret = cap_capable(current_cred(), &init_user_ns,
+						CAP_SYS_RAWIO, &opts);
 		/* set PF_SUPERPRIV if it turns out we allow the low mmap */
 		if (ret == 0)
 			current->flags |= PF_SUPERPRIV;
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 32040f8db7ce..6ad109658697 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -146,7 +146,7 @@ static bool setuid_syscall(int num)
 static int safesetid_security_capable(const struct cred *cred,
 				      struct user_namespace *ns,
 				      int cap,
-				      int audit)
+				      struct security_capable_opts *opts)
 {
 	/* The current->mm check will fail if this is a kernel thread. */
 	if (cap == CAP_SETUID &&
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..526dae29fd37 100644
--- a/security/security.c
+++ b/security/security.c
@@ -278,16 +278,12 @@ int security_capset(struct cred *new, const struct cred *old,
 				effective, inheritable, permitted);
 }
 
-int security_capable(const struct cred *cred, struct user_namespace *ns,
-		     int cap)
+int security_capable(const struct cred *cred,
+		     struct user_namespace *ns,
+		     int cap,
+		     struct security_capable_opts *opts)
 {
-	return call_int_hook(capable, 0, cred, ns, cap, SECURITY_CAP_AUDIT);
-}
-
-int security_capable_noaudit(const struct cred *cred, struct user_namespace *ns,
-			     int cap)
-{
-	return call_int_hook(capable, 0, cred, ns, cap, SECURITY_CAP_NOAUDIT);
+	return call_int_hook(capable, 0, cred, ns, cap, opts);
 }
 
 int security_quotactl(int cmds, int type, int id, struct super_block *sb)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2b5ee5fbd652..ed409cd70822 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2313,9 +2313,10 @@ static int selinux_capset(struct cred *new, const struct cred *old,
  */
 
 static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
-			   int cap, int audit)
+			   int cap, struct security_capable_opts *opts)
 {
-	return cred_has_capability(cred, cap, audit, ns == &init_user_ns);
+	return cred_has_capability(cred, cap, opts->log_audit_message,
+							ns == &init_user_ns);
 }
 
 static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
@@ -3242,11 +3243,13 @@ static int selinux_inode_getattr(const struct path *path)
 static bool has_cap_mac_admin(bool audit)
 {
 	const struct cred *cred = current_cred();
-	int cap_audit = audit ? SECURITY_CAP_AUDIT : SECURITY_CAP_NOAUDIT;
+	struct security_capable_opts opts;
 
-	if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, cap_audit))
+	init_security_capable_opts(&opts);
+	opts.log_audit_message = audit ? true : false;
+	if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, &opts))
 		return false;
-	if (cred_has_capability(cred, CAP_MAC_ADMIN, cap_audit, true))
+	if (cred_has_capability(cred, CAP_MAC_ADMIN, opts.log_audit_message, true))
 		return false;
 	return true;
 }
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 9a4c0ad46518..eca364b697d7 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -639,8 +639,11 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
 	struct smack_known *skp = tsp->smk_task;
 	struct smack_known_list_elem *sklep;
 	int rc;
+	struct security_capable_opts opts;
 
-	rc = cap_capable(cred, &init_user_ns, cap, SECURITY_CAP_AUDIT);
+	init_security_capable_opts(&opts);
+
+	rc = cap_capable(cred, &init_user_ns, cap, &opts);
 	if (rc)
 		return false;
 
-- 
2.19.1.930.g4563a0d9d0-goog

