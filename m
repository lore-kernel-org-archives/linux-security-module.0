Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899553803CC
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517994; cv=none; b=uBmYTxtNLqiJ87YZAjN4cIl/yYWEnPQRy+AHXhgE+Wd9X6rCuh3hS48b74mRVW+51tjOLoezjbqFMcfLp1jWggRxKW2fEyd86w3Bwr20Xy+ozhGneuC5EylJ0xTVklfJK89FnhUPwTIXASVZeyUAbKAOdKeJteD+66X8SUn4rsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517994; c=relaxed/simple;
	bh=hwPSRco/2H2KQ6ufqfhBZC5O32revoN3Q6k8vhwAik0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1IkQmR+jPrYGYNXL1jyOm59JQioNQ5dtl0fdjBzhhuTf8ERVANuliG+W9oRgioqrXBV0OEFCZfwQdHH0ky5G+f8pd7VkY6FbxlFWCrQzH3MSP2uGxPH8wWsGHV34E5uEoErJCmDmbgXVq3yUkzSO6EvVOuF1y/KBWXmIp1axoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8DXQQ/O; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8DXQQ/O"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-667b0ced2d3so276888d50.2
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783517989; x=1784122789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+84S2kWMbyF6Oc8cTybfyBuxsNSvzT1ZsqI1iyet6o8=;
        b=B8DXQQ/OOsKLq994aTAN9SktWLwqN5lIgPRh5ChVBIN5nR0vyXMA2OtDuYP+s7iMjC
         CbSvHpO9NmDynvQWg7nHsGJ7ZcGpTeCjmkPoMXiWm+UqCPrIG3HJw3DiUBNQV1RoXLuf
         UKRMNBeQADpc0UnOvuQ5uARy3cap1bKSrZzeyv3DkT0u8n1IG6CxfqFJcoeLIWK+6uxe
         1wlOon8tJzihz04ZSz7mmFYhL2KJb0gNDrFA/6lfGxLfF0Tj6h7lLJHO/qj6NIgP4aky
         5MVi46n9DvmMhOkfJXoSt1ANNzciQWgyzf8kDY3SDA/KYqFI+jGMLILue2vLj5+1n8v/
         OAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517989; x=1784122789;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+84S2kWMbyF6Oc8cTybfyBuxsNSvzT1ZsqI1iyet6o8=;
        b=FndDGHZtZRhD9OMvUp8zuSpmZripub1ZIup96UjKw4J6MCEVQrREIn0Yvka+LB6RYn
         ROjdJK2IUoySwFw9XlNiVvN/j0SlxwcxVRveaF6Mlj3YWNjt561TmLPj6524whDMUPlT
         Gchuot33e9swqUWMPFtHDp4tzsA8LkFXJB2pUUOssfc9Ziwzis+HIfyvU9Z9MneQPIhC
         KyDKax89UPdRZoXDuHx3kwooDm9O6i74yp3hvEFo0kbZkIWvute8AwYnSjKU8ODLlhQw
         RsX7OSBbhb3e+pHxG0sGYiVeJxrghifMjH+XmIkb+0rycQXA4vhQcJs7Rt7q3JkkRm0i
         fffA==
X-Forwarded-Encrypted: i=1; AHgh+RpPkwBADWLi37Cqh2Suk2Z5XFDrPWLyVhpF/UUGiAbf9t5kKB2e21XsxuCISo2EkcNy+9dyZan0m/+5HbAHZwHAxjIygro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZHQxYyVOHy3diuplV523Wei/pDfirTZZZHjjtTP+5HZfsLMF
	1+uMCKWeHWqvmulTVVEBsKXOmrdKNCdLudMSBQd2UKj4UiYrNs071E6T
X-Gm-Gg: AfdE7clROBeb5/h6WGxNSlj3T6vIfviHEn4OSuAHcEB3X1YmBxaOxBOrkCOnIpDGqT/
	Utdc1MWwvuNKFVVJ520FPV8yALfg8uFwsDT0vlutKttp0OBTRBV1pT19JLa/fDBtbDZd4vhr9Bt
	ZTLg5Ta43y3USxFbbG4CR2m9WzksMFyXMtL2con1WiN3lpCP6iwejSdoBwxddTta7+REazZpDYp
	ktXxV5FKe5UnCudMSQnbZvs+Qso7N/+xJM8QNSYTSEHaq3rBYHmaN0ctzfQG/a+6Ujty63gonqC
	Bmviv6BPu0yp9fiLo6vY6N6TDOXtHWcXRmGDYzanM3JKpMofGNxcBa4bf9mg8JbatWTe46XNWV1
	xpacB9cs6vcxNUMLKvJR6YnIEjeqHSe2tgvNjITRfOShGuHxpRPbYjzrwFS1wIW/kKvP9NlzngL
	uJDBcZBLjY2ZQS2TIw1wGrMxq3bt28csS5sCIy34eJEmiFdto=
X-Received: by 2002:a05:690e:1609:b0:667:9eb2:8ffd with SMTP id 956f58d0204a3-6679f25cc74mr1345745d50.90.1783517989315;
        Wed, 08 Jul 2026 06:39:49 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:717c:ccb8:c362:d995])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667877a2db1sm2087969d50.6.2026.07.08.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:39:49 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: mic@digikod.net,
	linux-security-module@vger.kernel.org
Cc: gnoack@google.com,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 1/3] landlock: Add LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Date: Wed,  8 Jul 2026 09:39:25 -0400
Message-ID: <20260708133928.852999-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708133928.852999-1-utilityemal77@gmail.com>
References: <20260708133928.852999-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a landlock_restrict_self(2) flag to stage no_new_privs so that it is
only set at the next execve(2) of the calling thread, past its point of
no return.  This makes it possible to prepare an execution environment
where the new program runs with no_new_privs, without changing the
behavior of the calling program, and without leaving no_new_privs set if
the execve(2) fails.

The staged bit lives in the Landlock credential blob and is installed by
a new bprm_committing_creds hook.  This flag does not relax the
no_new_privs/CAP_SYS_ADMIN requirement of landlock_restrict_self(2), and
may be used with a ruleset_fd of -1 to stage no_new_privs without
enforcing a ruleset.  Combined with LANDLOCK_RESTRICT_SELF_TSYNC, the
staged state is propagated to sibling threads like the rest of the
Landlock credential state, and each thread then sets no_new_privs at its
own next execve(2).

Because no_new_privs is only set once the credentials of the new program
have been computed, this flag does not change how the next execve(2)
itself computes credentials: set-user-ID, set-group-ID and file
capabilities are still honored for that execution.  The executed program
then runs with no_new_privs set, with its usual effect on subsequent
execve(2) calls.

Bump the Landlock ABI version to 11.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 include/uapi/linux/landlock.h | 36 ++++++++++++++++++++++-
 security/landlock/cred.c      | 22 ++++++++++++++
 security/landlock/cred.h      |  8 ++++++
 security/landlock/limits.h    |  2 +-
 security/landlock/syscalls.c  | 54 ++++++++++++++++++++++++++---------
 5 files changed, 107 insertions(+), 15 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 7ffe2ef127ee..8d5b41d94c4a 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -190,13 +190,47 @@ struct landlock_ruleset_attr {
  *     logging configurations on these threads.
  *
  *     If the calling thread is running with no_new_privs, this operation
- *     enables no_new_privs on the sibling threads as well.
+ *     enables no_new_privs on the sibling threads as well.  If the calling
+ *     thread has no_new_privs staged with
+ *     %LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC (whether by the same call or a
+ *     previous one), the staged state is propagated to the sibling threads as
+ *     well.
+ *
+ * The following flag stages no_new_privs so that it only takes effect at the
+ * next :manpage:`execve(2)` of the calling thread, rather than immediately.
+ * It does not relax the permission check performed by
+ * sys_landlock_restrict_self(): the calling thread must still be running with
+ * no_new_privs or hold %CAP_SYS_ADMIN in its namespace.
+ *
+ * %LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
+ *     Sets the no_new_privs attribute of the calling thread, but only at the
+ *     next :manpage:`execve(2)` and past its point of no return, so a failed
+ *     :manpage:`execve(2)` leaves the attribute unchanged.  Because
+ *     sys_landlock_restrict_self() already requires no_new_privs or
+ *     %CAP_SYS_ADMIN, this flag cannot be used to defer around that
+ *     requirement: when no_new_privs is already set it is effectively a
+ *     no-op, and otherwise the caller must hold %CAP_SYS_ADMIN.  This flag
+ *     may be used with a @ruleset_fd value of -1 to stage no_new_privs
+ *     without enforcing a ruleset.
+ *
+ *     This flag does not change how the next :manpage:`execve(2)` itself
+ *     computes credentials: set-user-ID, set-group-ID and file capabilities
+ *     are still honored for that execution.  The executed program then runs
+ *     with no_new_privs set, with its usual effect on subsequent
+ *     :manpage:`execve(2)` calls.
+ *
+ *     Staging is per-thread by default.  When combined with
+ *     %LANDLOCK_RESTRICT_SELF_TSYNC, the staged no_new_privs is propagated
+ *     to the sibling threads along with the rest of the Landlock
+ *     configuration, and each thread then sets no_new_privs at its own next
+ *     :manpage:`execve(2)`.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
 #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
 #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
 #define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
+#define LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC			(1U << 4)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index cc419de75cd6..31fa4f78adef 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -10,6 +10,7 @@
 #include <linux/binfmts.h>
 #include <linux/cred.h>
 #include <linux/lsm_hooks.h>
+#include <linux/sched.h>
 
 #include "common.h"
 #include "cred.h"
@@ -52,11 +53,32 @@ static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
 
 #endif /* CONFIG_AUDIT */
 
+/*
+ * Installs the no_new_privs attribute staged with
+ * LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC.
+ *
+ * This hook runs from begin_new_exec(), past the execution's point of no
+ * return: a binary that cannot be loaded (or any earlier failure) never reaches
+ * this point, so a failed execve(2) leaves the thread's no_new_privs attribute
+ * untouched.
+ */
+static void hook_bprm_committing_creds(const struct linux_binprm *const bprm)
+{
+	struct landlock_cred_security *const llcred = landlock_cred(bprm->cred);
+
+	if (llcred->set_nnp_on_exec) {
+		task_set_no_new_privs(current);
+		llcred->set_nnp_on_exec = 0;
+	}
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, hook_cred_transfer),
 	LSM_HOOK_INIT(cred_free, hook_cred_free),
 
+	LSM_HOOK_INIT(bprm_committing_creds, hook_bprm_committing_creds),
+
 #ifdef CONFIG_AUDIT
 	LSM_HOOK_INIT(bprm_creds_for_exec, hook_bprm_creds_for_exec),
 #endif /* CONFIG_AUDIT */
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index f287c56b5fd4..673206d3c3f3 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -35,6 +35,14 @@ struct landlock_cred_security {
 	 */
 	struct landlock_ruleset *domain;
 
+	/**
+	 * @set_nnp_on_exec: Set if %LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
+	 * requested that no_new_privs be enabled at the next execve(2).
+	 * Propagated to sibling threads by %LANDLOCK_RESTRICT_SELF_TSYNC like
+	 * the rest of this struct.  Consumed by hook_bprm_committing_creds().
+	 */
+	u8 set_nnp_on_exec : 1;
+
 #ifdef CONFIG_AUDIT
 	/**
 	 * @domain_exec: Bitmask identifying the domain layers that were enforced by
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 08d5f2f6d321..29c190d00540 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -34,7 +34,7 @@
 #define LANDLOCK_NUM_ACCESS_MAX \
 	MAX(MAX(LANDLOCK_NUM_ACCESS_FS, LANDLOCK_NUM_ACCESS_NET), LANDLOCK_NUM_SCOPE)
 
-#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
 /* clang-format on */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 36b02892c62f..daed1ea80455 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -169,7 +169,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 10;
+const int landlock_abi_version = 11;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -502,12 +502,21 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
  *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
  *         - %LANDLOCK_RESTRICT_SELF_TSYNC
+ *         - %LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
  *
  * This system call enforces a Landlock ruleset on the current thread.
  * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
  * namespace or is running with no_new_privs.  This avoids scenarios where
  * unprivileged tasks can affect the behavior of privileged children.
  *
+ * With %LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC, no_new_privs is not set
+ * immediately but staged to be set at the next execve(2), past its point of no
+ * return.  This flag does not relax the no_new_privs / %CAP_SYS_ADMIN
+ * requirement above.  Staging is per-thread by default; when combined with
+ * %LANDLOCK_RESTRICT_SELF_TSYNC, the staged no_new_privs is propagated to the
+ * sibling threads along with the rest of the Landlock credential state, and
+ * each thread then sets no_new_privs at its own next execve(2).
+ *
  * Return: 0 on success, or -errno on failure.  Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
@@ -526,6 +535,10 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		flags)
 {
+	/* Flags that do not require a ruleset_fd. */
+	const __u32 fd_optional_flags =
+		LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+		LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC;
 	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
@@ -538,6 +551,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	/*
 	 * Similar checks as for seccomp(2), except that an -EPERM may be
 	 * returned.
+	 *
+	 * This gate runs before any flag-specific handling, so
+	 * LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC cannot be used to defer around the
+	 * no_new_privs / CAP_SYS_ADMIN requirement.
 	 */
 	if (!task_no_new_privs(current) &&
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
@@ -555,14 +572,15 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	log_subdomains = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
 
 	/*
-	 * It is allowed to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with
-	 * -1 as ruleset_fd, optionally combined with
-	 * LANDLOCK_RESTRICT_SELF_TSYNC to propagate this configuration to all
-	 * threads.  No other flag must be set.
+	 * A ruleset is not required when only muting subdomain logs
+	 * (LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, optionally combined with
+	 * LANDLOCK_RESTRICT_SELF_TSYNC to propagate it to all threads) and/or
+	 * staging no_new_privs on exec (LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC).
+	 * Such calls may pass -1 as ruleset_fd.  Any other flag (or the absence
+	 * of these) requires a real ruleset.
 	 */
-	if (!(ruleset_fd == -1 &&
-	      (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC) ==
-		      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
+	if (!(ruleset_fd == -1 && (flags & fd_optional_flags) &&
+	      !(flags & ~(fd_optional_flags | LANDLOCK_RESTRICT_SELF_TSYNC)))) {
 		/* Gets and checks the ruleset. */
 		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
 		if (IS_ERR(ruleset))
@@ -583,11 +601,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 #endif /* CONFIG_AUDIT */
 
 	/*
-	 * The only case when a ruleset may not be set is if
-	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set (optionally with
-	 * LANDLOCK_RESTRICT_SELF_TSYNC) and ruleset_fd is -1.  We could
-	 * optimize this case by not calling commit_creds() if this flag was
-	 * already set, but it is not worth the complexity.
+	 * A ruleset may legitimately be absent here when only muting subdomain
+	 * logs (LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF, optionally with
+	 * LANDLOCK_RESTRICT_SELF_TSYNC) and/or staging no_new_privs on exec
+	 * (LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC) with ruleset_fd == -1.  We could
+	 * optimize some of these cases by not calling commit_creds(), but it is
+	 * not worth the complexity.
 	 */
 	if (ruleset) {
 		/*
@@ -618,6 +637,15 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 #endif /* CONFIG_AUDIT */
 	}
 
+	/*
+	 * Stages no_new_privs to be set at the next execve(2).  Because the bit
+	 * lives in new_cred, TSYNC below propagates it to the sibling threads
+	 * (whether it was staged by this call or a previous one), and each
+	 * thread then sets no_new_privs at its own next execve(2).
+	 */
+	if (flags & LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC)
+		new_llcred->set_nnp_on_exec = 1;
+
 	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
 		const int err = landlock_restrict_sibling_threads(
 			current_cred(), new_cred);
-- 
2.54.0

