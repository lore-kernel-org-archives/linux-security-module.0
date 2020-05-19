Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF87FC433E2
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E5220715
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgESAe6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 May 2020 20:34:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37346 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgESAe5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 20:34:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqDf-0000Sk-R7; Mon, 18 May 2020 18:34:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqDe-0003VW-L7; Mon, 18 May 2020 18:34:55 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 18 May 2020 19:31:14 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqDe-0003VW-L7;;;mid=<87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18gTzpc5ZKgxRTyLbmfRdW+xc8Sy4jTNSc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Rename bprm->cap_elevated to bprm->active_secureexec and initialize it
in prepare_binprm instead of in cap_bprm_set_creds.  Initializing
bprm->active_secureexec in prepare_binprm allows multiple
implementations of security_bprm_repopulate_creds to play nicely with
each other.

Rename security_bprm_set_creds to security_bprm_reopulate_creds to
emphasize that this path recomputes part of bprm->cred.  This
recomputation avoids the time of check vs time of use problems that
are inherent in unix #! interpreters.

In short two renames and a move in the location of initializing
bprm->active_secureexec.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                     | 8 ++++----
 include/linux/binfmts.h       | 4 ++--
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/lsm_hooks.h     | 4 ++--
 include/linux/security.h      | 8 ++++----
 security/commoncap.c          | 9 ++++-----
 security/security.c           | 4 ++--
 7 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9e70da47f8d9..8e3b93d51d31 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1366,7 +1366,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * the final state of setuid/setgid/fscaps can be merged into the
 	 * secureexec flag.
 	 */
-	bprm->secureexec |= bprm->cap_elevated;
+	bprm->secureexec |= bprm->active_secureexec;
 
 	if (bprm->secureexec) {
 		/* Make sure parent cannot signal privileged process. */
@@ -1634,10 +1634,10 @@ int prepare_binprm(struct linux_binprm *bprm)
 	int retval;
 	loff_t pos = 0;
 
+	/* Recompute parts of bprm->cred based on bprm->file */
+	bprm->active_secureexec = 0;
 	bprm_fill_uid(bprm);
-
-	/* fill in binprm security blob */
-	retval = security_bprm_set_creds(bprm);
+	retval = security_bprm_repopulate_creds(bprm);
 	if (retval)
 		return retval;
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index d1217fcdedea..8605ab4a0f89 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -27,10 +27,10 @@ struct linux_binprm {
 	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
 		/*
-		 * True if most recent call to cap_bprm_set_creds
+		 * True if most recent call to security_bprm_set_creds
 		 * resulted in elevated privileges.
 		 */
-		cap_elevated:1,
+		active_secureexec:1,
 		/*
 		 * Set by bprm_creds_for_exec hook to indicate a
 		 * privilege-gaining exec has happened. Used to set
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index aab0695f41df..1e295ba12c0d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -50,7 +50,7 @@ LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
 LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
-LSM_HOOK(int, 0, bprm_set_creds, struct linux_binprm *bprm)
+LSM_HOOK(int, 0, bprm_repopulate_creds, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c719af37df20..d618ecc4d660 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -44,7 +44,7 @@
  *	request libc enable secure mode.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
- * @bprm_set_creds:
+ * @bprm_repopulate_creds:
  *	Assuming that the relevant bits of @bprm->cred->security have been
  *	previously set, examine @bprm->file and regenerate them.  This is
  *	so that the credentials derived from the interpreter the code is
@@ -53,7 +53,7 @@
  *	reopen script, and may end up opening something completely different.
  *	This hook may also optionally check permissions (e.g. for
  *	transitions between security domains).
- *	The hook must set @bprm->cap_elevated to 1 if AT_SECURE should be set to
+ *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
  *	request libc enable secure mode.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
diff --git a/include/linux/security.h b/include/linux/security.h
index 1bd7a6582775..d23f078eb589 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -140,7 +140,7 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 		      const kernel_cap_t *effective,
 		      const kernel_cap_t *inheritable,
 		      const kernel_cap_t *permitted);
-extern int cap_bprm_set_creds(struct linux_binprm *bprm);
+extern int cap_bprm_repopulate_creds(struct linux_binprm *bprm);
 extern int cap_inode_setxattr(struct dentry *dentry, const char *name,
 			      const void *value, size_t size, int flags);
 extern int cap_inode_removexattr(struct dentry *dentry, const char *name);
@@ -277,7 +277,7 @@ int security_syslog(int type);
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_bprm_creds_for_exec(struct linux_binprm *bprm);
-int security_bprm_set_creds(struct linux_binprm *bprm);
+int security_bprm_repopulate_creds(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
@@ -575,9 +575,9 @@ static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 	return 0;
 }
 
-static inline int security_bprm_set_creds(struct linux_binprm *bprm)
+static inline int security_bprm_repopulate_creds(struct linux_binprm *bprm)
 {
-	return cap_bprm_set_creds(bprm);
+	return cap_bprm_repopluate_creds(bprm);
 }
 
 static inline int security_bprm_check(struct linux_binprm *bprm)
diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..045b5b80ea40 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -797,14 +797,14 @@ static inline bool nonroot_raised_pE(struct cred *new, const struct cred *old,
 }
 
 /**
- * cap_bprm_set_creds - Set up the proposed credentials for execve().
+ * cap_bprm_repopulate_creds - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
  *
  * Set up the proposed credentials for a new execution context being
  * constructed by execve().  The proposed creds in @bprm->cred is altered,
  * which won't take effect immediately.  Returns 0 if successful, -ve on error.
  */
-int cap_bprm_set_creds(struct linux_binprm *bprm)
+int cap_bprm_repopulate_creds(struct linux_binprm *bprm)
 {
 	const struct cred *old = current_cred();
 	struct cred *new = bprm->cred;
@@ -884,12 +884,11 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 		return -EPERM;
 
 	/* Check for privilege-elevated exec. */
-	bprm->cap_elevated = 0;
 	if (is_setid ||
 	    (!__is_real(root_uid, new) &&
 	     (effective ||
 	      __cap_grew(permitted, ambient, new))))
-		bprm->cap_elevated = 1;
+		bprm->active_secureexec = 1;
 
 	return 0;
 }
@@ -1346,7 +1345,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, cap_ptrace_traceme),
 	LSM_HOOK_INIT(capget, cap_capget),
 	LSM_HOOK_INIT(capset, cap_capset),
-	LSM_HOOK_INIT(bprm_set_creds, cap_bprm_set_creds),
+	LSM_HOOK_INIT(bprm_repopulate_creds, cap_bprm_repopulate_creds),
 	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
 	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
 	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
diff --git a/security/security.c b/security/security.c
index 4ee76a729f73..b890b7e2a765 100644
--- a/security/security.c
+++ b/security/security.c
@@ -828,9 +828,9 @@ int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 	return call_int_hook(bprm_creds_for_exec, 0, bprm);
 }
 
-int security_bprm_set_creds(struct linux_binprm *bprm)
+int security_bprm_repopulate_creds(struct linux_binprm *bprm)
 {
-	return call_int_hook(bprm_set_creds, 0, bprm);
+	return call_int_hook(bprm_repopulate_creds, 0, bprm);
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
-- 
2.25.0

