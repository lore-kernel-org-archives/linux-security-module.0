Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD0346FB0
	for <linux-security-module@vger.kernel.org>; Wed,  8 Apr 2026 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668300; cv=none; b=TgnxpjDRYc5/1JBSZfPo1aW4Wu8UxeyM7PtDClzAFehk171dFdUYQHMTYor6Xgf7t7gfyvqSKsJsJw1lGG0uonJssUPCIuMMw/HxprSyjLGYixPxPVU0nH+ya8yZdmK5WCTRQwjbvJr7RAw+xohM4wBwF9AW+OKh/OubwhsUeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668300; c=relaxed/simple;
	bh=skTHfg5nopiPlA39+yQldHS0YW2EP7eSiDJo+l9/xQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyBGPYqdUBOr/huZCr73IuuqIoWWkOPBFYPeVtvmrGbYM6L/+Sm9qyz0+K67+tM7atHC5ygUVZjgpt1SyyDqhqWjB8cdrljH2zaLK3+znyDfFBZ3zvxf+nHm+eyfxPPXEeFPErRHYr++nX/3XR4chRS5RpIYJT/geKbhVn2jUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfiL7iWA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfiL7iWA"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7a2b6adbfa6so1581417b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 08 Apr 2026 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775668297; x=1776273097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/8rwKhb/x/3zExFoHaPVXkH6YxE9ylkF1qlsN1QT9k=;
        b=NfiL7iWABBYC684D4DiCzXjKdpSKu/4ng2g2wgycuNom0EORiSUL+2rHIZVINKkwu7
         wBeG7VC9OCkN5glXS+8HWG/60PJdneGSF/NDCDwjMfrjPyER1vYS/RlPiu0ycYSp/TRc
         Ak81q9i1oEgp1zduAPJVx7a0CRflUsR01sLMX3Ulc3Rz1L6kckmIVYbRvxsurBKNhgFZ
         qXppVPv7aZkhxsD6Rp6KShC7Vmw0DLSQygD4vf8fo5jNa1xCn2FEJMDjAXk3yAvawEeA
         T58rT4u+9egl0i/A5COlWS4YvSFSYOsf416sIuXfAWCmqffkzYlcaP9B4WzwKo/ijadY
         2pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668297; x=1776273097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/8rwKhb/x/3zExFoHaPVXkH6YxE9ylkF1qlsN1QT9k=;
        b=DSStH2fiPWNemUkfa/30u0EIAAClFfW907+/5B7CN+Qy+ZfYfOxzbiebkxHap5SVY4
         XOuS/4sZwqYhWNWnxwbTptKcsMy+7mrO/Wi3MJEK2hfQh5yJjumkS9cmWj9cp9r+7Oo2
         CkpfmRR4eoJ3WqacK9T62icq2Z+ipBUtfzBAK/M2kOq9JFCKGaPDQPnyiMwORv3U+8o1
         42KHiBljab83jfDZze3bqC6iyrcuGA1KNryOhLv8722T3MOs38td+h7XeX6LqR5qzMNc
         +j7b0tfLt0Jq0nI0/LKCbPSaVzXi4Dwacw7mOKgWkTjxqmGc8m58sY8sxcndi0PPf+EA
         zLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp0pGPLpVNNC8OCf/yJx+LAUhz0TRQbqmvg74F0E5RZl88wc9eBBnNZ2uGuxt3lAqWrqIKoCwrQOoQSIzV8Jb+co2QQWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5T7S7UicTzGLcG0DnNK4lSr/UOPhVlCAQ0JvP/LxfSC2WgG/V
	nEXNDbLdQly24gVWMESwJZU6SE/k3XIdu1ahhhOcHJwjo5P2YNvFBeuJ
X-Gm-Gg: AeBDiev7E55BNMpAZSnGuJ164N6/5CRtG1h//PC+YshX1397gQGvGYztpv2n1ibZErP
	Dv0zCqgOPt3vzaSZx8hd/X+0+YKbfpqE9zXJydOxCrBRLeI3E5nB3+h8ilHrsDAM5F4CrZEg0z+
	j9lWdEQh5nMX1aQk/nQ6FWWpzU3BX+wiYHm2njf26f8ZN38vpvZcxchSJ3BaIJM9qSIoQSPRy53
	lT1oxTrJKlxu3vtGPJklnTy0oX1iXNkELNG+8+6uo3/fahME7cucVskHKjU5+2kNmHWzdDyxvBr
	cbx1GX/lJl4WW+8AdIBherPTwsWTYzDeBg/LyNsSx3xd242LWjWlTSZgxLBP9o3ZCYLHPg8Y73k
	R3obDMOFDrwSDrxvBpnkVBTsB1jOBvQGtjBr1O+EtSvHulXFOP8a45rEXgrhQpTO8AaGHAJ2A5w
	ODAEfxi56pOWWcIsADoSOUeu1g5WYEeY0WPBMX62MbgrySmpOL54zC9uNptL5jSsLX891xlOOG
X-Received: by 2002:a05:690c:63c2:b0:79b:d1d9:daac with SMTP id 00721157ae682-7a4d8cad324mr216124687b3.38.1775668297224;
        Wed, 08 Apr 2026 10:11:37 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:4f39:118b:d212:714e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e22b926sm91175117b3.5.2026.04.08.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:11:36 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: mic@digikod.net
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	fred@cloudflare.com,
	gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	john.fastabend@gmail.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	martin.lau@linux.dev,
	paul@paul-moore.com,
	Justin Suess <utilityemal77@gmail.com>
Subject: Re: [RFC PATCH 00/20] BPF interface for applying Landlock rulesets
Date: Wed,  8 Apr 2026 13:10:28 -0400
Message-ID: <20260408171030.4083129-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408.ong9Eshe0omu@digikod.net>
References: <20260408.ong9Eshe0omu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Add a flag LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, which executes
task_set_no_new_privs on the current credentials, but only if
the process lacks the CAP_SYS_ADMIN capability.

While this operation is redundant for code running from userspace
(indeed callers may achieve the same logic by calling
prctl w/ PR_SET_NO_NEW_PRIVS), this flag enables callers without access
to the syscall abi (defined in subsequent patches) to restrict processes
from gaining additional capabilities. This is important to ensure that
consumers can meet the task_no_new_privs || CAP_SYS_ADMIN invariant
enforced by Landlock without having syscall access.

This is done by hooking bprm_committing_creds along with a
landlock_cred_security flag to indicate that the next execution should
task_set_no_new_privs if the process doesn't possess CAP_SYS_ADMIN. This
is done to ensure that task_set_no_new_privs is being done past the
point of no return.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

On Wed, Apr 08, 2026 at 02:00:00 -0000, Mickaël Salaün wrote:
> > Points of Feedback
> > ===
> > 
> > First, the new set_nnp_on_point_of_no_return field in struct linux_binprm.
> > This field was needed to request that task_set_no_new_privs be set during an
> > execution, but only after the execution has proceeded beyond the point of no
> > return. I couldn't find a way to express this semantic without adding a new
> > bitfield to struct linux_binprm and a conditional in fs/exec.c. Please see
> > patch 2.

> What about using security_bprm_committing_creds()?

Good idea. Definitely cleaner.

Something like this? Then dropping the "execve: Add set_nnp_on_point_of_no_return"
commit.

This adds a bitfield to the landlock_cred_security struct to indicate that the flag
should be set on the next exec(s).

 include/uapi/linux/landlock.h | 14 ++++++++++++++
 security/landlock/cred.c      | 13 +++++++++++++
 security/landlock/cred.h      |  7 +++++++
 security/landlock/limits.h    |  2 +-
 security/landlock/ruleset.c   | 15 ++++++++++++---
 security/landlock/syscalls.c  |  5 +++++
 6 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f88fa1f68b77..edd9d9a7f60e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -129,12 +129,26 @@ struct landlock_ruleset_attr {
  *
  *     If the calling thread is running with no_new_privs, this operation
  *     enables no_new_privs on the sibling threads as well.
+ *
+ * %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
+ *    Sets no_new_privs on the calling thread before applying the Landlock domain.
+ *    This flag is useful for convenience as well as for applying a ruleset from
+ *    an outside context (e.g BPF). This flag only has an effect on when both
+ *    no_new_privs isn't already set and the caller doesn't possess CAP_SYS_ADMIN.
+ *
+ *    This flag has slightly different behavior when used from BPF. Instead of
+ *    setting no_new_privs on the current task, it sets a flag on the bprm so that
+ *    no_new_privs is set on the task at exec point-of-no-return. This guarantees
+ *    that the current execution is unaffected, and may escalate as usual until the
+ *    next exec, but the resulting task cannot gain more privileges through later
+ *    exec transitions.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
 #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
 #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
 #define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
+#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS			(1U << 4)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 0cb3edde4d18..bcc9b716916f 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -43,6 +43,18 @@ static void hook_cred_free(struct cred *const cred)
 		landlock_put_ruleset_deferred(dom);
 }
 
+static void hook_bprm_committing_creds(const struct linux_binprm *bprm)
+{
+	struct landlock_cred_security *const llcred = landlock_cred(bprm->cred);
+
+	if (llcred->set_nnp_on_committing_creds &&
+	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)) {
+		task_set_no_new_privs(current);
+		/* Don't need to set it again for subsequent execution. */
+		llcred->set_nnp_on_committing_creds = false;
+	}
+}
+
 #ifdef CONFIG_AUDIT
 
 static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
@@ -55,6 +67,7 @@ static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
 #endif /* CONFIG_AUDIT */
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(bprm_committing_creds, hook_bprm_committing_creds),
 	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, hook_cred_transfer),
 	LSM_HOOK_INIT(cred_free, hook_cred_free),
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index c10a06727eb1..7ec6dd12ebc3 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -49,6 +49,13 @@ struct landlock_cred_security {
 	 * not require a current domain.
 	 */
 	u8 log_subdomains_off : 1;
+	/**
+	 * @set_nnp_on_committing_creds: Set if the domain should set NO_NEW_PRIVS on the
+	 * execution past the point of no return in security_bprm_committing_creds().
+	 * This is not a hierarchy configuration because the nnp state is inherited by
+	 * exec and doesn't need further configuration.
+	 */
+	u8 set_nnp_on_committing_creds : 1;
 #endif /* CONFIG_AUDIT */
 } __packed;
 
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index eb584f47288d..d298086a4180 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -31,7 +31,7 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
-#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
 /* clang-format on */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 1d6fa74f2a52..ad0bd5994ec5 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -121,11 +121,13 @@ int landlock_restrict_cred_precheck(const __u32 flags,
 
 	/*
 	 * Similar checks as for seccomp(2), except that an -EPERM may be
-	 * returned.
+	 * returned, or no_new_privs may be set by the caller via
+	 * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.
 	 */
 	if (!task_no_new_privs(current) &&
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)) {
-		return -EPERM;
+		if (!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS))
+			return -EPERM;
 	}
 
 	if (flags & ~LANDLOCK_MASK_RESTRICT_SELF)
@@ -140,7 +142,7 @@ int landlock_restrict_cred(struct cred *const cred,
 {
 	struct landlock_cred_security *new_llcred;
 	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
-		prev_log_subdomains;
+		prev_log_subdomains, set_nnp_on_committing_creds;
 
 	/*
 	 * It is allowed to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF without
@@ -157,6 +159,12 @@ int landlock_restrict_cred(struct cred *const cred,
 	log_new_exec = !!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
 	/* Translates "off" flag to boolean. */
 	log_subdomains = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
+	/*
+	 * Translates "on" flag to boolean. This flag is not inherited by exec,
+	 * but the resulting nnp state is.
+	 */
+	set_nnp_on_committing_creds =
+		!!(flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS);
 
 	new_llcred = landlock_cred(cred);
 
@@ -165,6 +173,7 @@ int landlock_restrict_cred(struct cred *const cred,
 	new_llcred->log_subdomains_off = !prev_log_subdomains ||
 					 !log_subdomains;
 #endif /* CONFIG_AUDIT */
+	new_llcred->set_nnp_on_committing_creds = set_nnp_on_committing_creds;
 
 	/*
 	 * The only case when a ruleset may not be set is if
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index c6c7be7698a2..f3520c764360 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -397,6 +397,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  *         - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
  *         - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
  *         - %LANDLOCK_RESTRICT_SELF_TSYNC
+ *         - %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
  *
  * This system call enforces a Landlock ruleset on the current thread.
  * Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
@@ -450,6 +451,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	if (!new_cred)
 		return -ENOMEM;
 
+	if (flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS &&
+	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
+		task_set_no_new_privs(current);
+
 	err = landlock_restrict_cred(new_cred, ruleset, flags);
 	if (err) {
 		abort_creds(new_cred);
-- 
2.53.0

