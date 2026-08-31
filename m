Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26F501F33
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188441; cv=none; b=kEqKridlYhkBpwPxUENQW81nfhNKimUSShl+6g9NSsS+GIL7rX24QNF/2NlpEvp2TxHxrNGdUqr1MW5xCLWONbc5avRXL6dRI6a6o/eBjpRg9o6CaF1hrVa4QRg3PeH6XwInarkqW0DBxpul4W31DXJrMYOo/JxmRDSwNPLbtp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188441; c=relaxed/simple;
	bh=ggkEpSln1XdPPecX8WAdnU8H+3V7doqITlU0A4IOYnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duNtokKTtgTmBMH6E7HxVHmILaAz28Fo6cWdzxcm0RDS6nmEYOBTWwoPYQFIbpJ6OI84gPG+kl548ULyBxEVu7J2L24V6sEmCwyxFKFAMditcLzkaQIE5/fpkrEeNFNyT4TxwOSiQRS1077rGvz8Nml0ljlF+Rd4b3Fk0kYE3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI24Qmr0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI24Qmr0"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8623b1e7cb2so15379727b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188438; x=1788793238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=37FOvEpP7fLV8sjizV5fXkE6iW+/lc3VdHmJ4Pl4zDM=;
        b=UI24Qmr0MqRMEId55/e92OIki1tl1Ph/j+/e3n+ddHRxgQkE2omW2F1lsaIqhLh+E9
         OXwtZGEpZBaFPnPycAiiXYOBGqJrkLyXSSnF51KjgFbElAUOO5VuolDwJ8EZga1v06vM
         oTJn9kWD8CZdABOJXfr2qHq9GAovuGVTdPX7/DmRWuf1STU9E2LAGbDsAZFIzShEnjgi
         tkKJ/b+oOM96HSn6/DsytPNTd5uipQxBzq+P5fK/+X7a9kYPmO880RPnsNKrRIrvU+QY
         FqnaK/jDqXpyUGI9HvtW6vTdka0aUYWbwmKnT4jymogMvlMJbQjJFTULGO3qEkhL93Vs
         RtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188438; x=1788793238;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37FOvEpP7fLV8sjizV5fXkE6iW+/lc3VdHmJ4Pl4zDM=;
        b=nZ6QG2kVmzXPFtjfdqmJkbQJ4KdfHwxK2WbEPNJGcXVt8iVrna0DAhm3y/BE7YWdVO
         hi8oAV9WzfK0/u6jhj5+0qzsG6xrc7IpUtVMvkfRO4JCJ/PcmxYfsBbrJGI2W+pj/t+7
         +JFfdhTJHf8w+7vtcxYpEMNfGIQSZSJJP3EZjoAa1KRQW92bSIa4B5IqaJ7N4csFsjYe
         l6Pf0f8WIVV4z5d3AZsmVOtU+bNoJ+zJCVH7ObO5d8ekO30j5fQpW1Q/37zfu828KRNH
         j7nQsIQ0GczhU6S/v+YShFvl47aB5h2PDztyuousfFvXKPs9is57HnokjaoOG3+WgBGx
         aD4Q==
X-Forwarded-Encrypted: i=1; AKwUvByv2B57TlZpLlRIleeeJw/38OnL+m9W2BGLPmUO36cKegG2VkabiLqAedv6NqjI+xj0U9lwxgGvt5UFVKOwFjI2eMI1Y3w=@vger.kernel.org
X-Gm-Message-State: AFuF++nzIpppyMFHbNFBMS6GRVlL06FCC/vUbgaPgi1UfXVuoWhuAtXd
	2+oQnoim1vM/llLfk1oYqbNLCh/haiwO+ya19B2VbJLAiOtmrgZ3c+68
X-Gm-Gg: AYBFou3wcilNDKhDl8ySZfHOjFPnHmVoEeH9NG/GLcpKt06WNwCQv/N99AMYdUQLzfx
	I2IvRNESdKU9OmKHkEhZgAIEhMH3li3rIUHFBjy2MOREw46oNrF9bZPF0pg+xEjlTx0VRE9IDJs
	treIsLpGSsQ8ggHys1GAiW8SvscDtQhq6l2mRo+tbd8ea5kbk8ymbmt+f/ufcyRS08MfXMpjVGx
	hmciLEV/G2y1KpUDZHGD22jBnkoM3dxmBZjU2RKuJWrx0jylPD2y5T3jrysDaH64Uk1xfAlBvTL
	17Zxrkw/ptliOuCah08x6h3cndss8DHpqpdK74jomSNR8bD9OC/vX9mLf/m7Z0z76nFYd7Cj2bz
	dTXOMqtbw0ARnvPjcv1lTVT+xwCm7Gzm2TjXwPZ6mF16v3zfhOMkgy8gv0D/M7z5rnlyXEvQtHi
	FJHn3EDtqZtYfE1tQHS56GRbtxT6SalFxJ9pULoJlM9HzTCK8wYikIi1HlLwVr1RdrCM78+y6Kk
	BlDAnxaVbW57yZBtNyfM4c=
X-Received: by 2002:a05:690c:6311:b0:862:cd8e:78fb with SMTP id 00721157ae682-862cd8e9648mr42595017b3.2.1788188433555;
        Mon, 31 Aug 2026 08:00:33 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:33 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 11/15] landlock: Factor the credential restriction out of landlock_restrict_self()
Date: Mon, 31 Aug 2026 10:58:53 -0400
Message-ID: <20260831145858.3869191-12-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Split the core of landlock_restrict_self() into two credential
helpers:

  landlock_prepare_restriction() - translate the
      landlock_restrict_self(2) flags, merge the ruleset with the
      credentials' domain, and configure the new domain's log state,
      producing a struct landlock_restriction: the complete new state
      that the enforcement gives to a credential.

  landlock_apply_restriction() - enforce a computed restriction on
      credentials exclusively owned by the caller.  This step cannot
      fail, so a caller may run it past its last point of failure.

The merge runs under @ruleset->lock and the landlock_create_domain
trace event is emitted before the lock is released, exactly as in the
syscall before this change: the event still observes the ruleset
snapshot that was merged, and it still fires before any thread-sync
wait.  Committing the hierarchy out of LANDLOCK_LOG_UNCOMMITTED moves
along with it, so every domain computed by
landlock_prepare_restriction() has its create/free trace events
balanced, whether or not it ends up enforced.

The syscall behaves exactly as before: prepare and apply run back to
back on the prepared credentials.  The no_new_privs/CAP_SYS_ADMIN
precheck, the flag mask check, the TSYNC handling, and the
landlock_enforce_domain trace event are syscall policy and stay in
place.

The point of the split is that application is decoupled from
computation: a following commit restricts an execution from a BPF
kfunc by staging a prepared restriction in the binprm credentials and
applying it at the exec point of no return, with the flag
translation, domain merge, and log configuration in one shared place.

The restriction records the flags it was computed with instead of
translating them into per-flag fields: consumers read the staged
flags at application time, so a future flag that must be honored at
enforcement travels with the restriction automatically, with no
per-flag plumbing in the callers.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/cred.c     | 132 +++++++++++++++++++++++++++++++++++
 security/landlock/cred.h     |  31 ++++++++
 security/landlock/syscalls.c |  96 ++++---------------------
 3 files changed, 178 insertions(+), 81 deletions(-)

diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 03449c26247e..f02706f12c7d 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -8,14 +8,146 @@
  */
 
 #include <linux/binfmts.h>
+#include <linux/bits.h>
 #include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/lsm_hooks.h>
+#include <linux/mutex.h>
+#include <uapi/linux/landlock.h>
 
 #include "common.h"
 #include "cred.h"
+#include "domain.h"
 #include "ruleset.h"
 #include "setup.h"
 
+#include <trace/events/landlock.h>
+
+/**
+ * landlock_prepare_restriction - Compute a credential restriction
+ *
+ * @llcred: Landlock credentials to restrict: provides the parent domain and
+ *          the previous log configuration.  Not modified.
+ * @ruleset: Ruleset to enforce, or NULL for a log-configuration-only change.
+ * @flags: landlock_restrict_self(2) flags.  The caller is responsible for
+ *         validating them against the set of flags it supports.
+ * @restriction: Computed restriction.  On success, holds a reference on
+ *               @restriction->domain (if any), which
+ *               landlock_apply_restriction() transfers to the restricted
+ *               credentials.
+ *
+ * The restriction builds on @llcred's current state: the caller must apply
+ * it to (or stage it for) these same credentials.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int landlock_prepare_restriction(
+	const struct landlock_cred_security *const llcred,
+	struct landlock_ruleset *const ruleset, const u32 flags,
+	struct landlock_restriction *const restriction)
+{
+	struct landlock_domain *new_dom;
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	/* Translates "off" and "on" flags to booleans. */
+	const bool log_same_exec =
+		!(flags & LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF);
+	const bool log_new_exec =
+		!!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
+	const bool prev_log_subdomains = !llcred->log_subdomains_off;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+
+	*restriction = (struct landlock_restriction){
+		.flags = flags,
+	};
+
+	if (!ruleset)
+		return 0;
+
+	mutex_lock(&ruleset->lock);
+	new_dom = landlock_merge_ruleset(llcred->domain, ruleset);
+	if (IS_ERR(new_dom)) {
+		mutex_unlock(&ruleset->lock);
+		return PTR_ERR(new_dom);
+	}
+	/*
+	 * Emits the domain-creation event while @ruleset->lock is still
+	 * held, right after the merge, so an eBPF program attached to
+	 * the tracepoint reads the exact ruleset that was merged into
+	 * the domain: a consistent snapshot that a concurrent
+	 * landlock_add_rule() (which holds the same lock) cannot
+	 * modify.
+	 *
+	 * This must not be delayed past the return of this function.
+	 * Holding @ruleset->lock across
+	 * landlock_restrict_sibling_threads() would hang: a sibling
+	 * thread blocked in landlock_add_rule() on the same
+	 * @ruleset->lock cannot run the task_work that thread-sync
+	 * waits for (the lock wait is uninterruptible).  Emitting here
+	 * keeps the lock off the thread-sync path.
+	 *
+	 * The trade-off is that the event fires for a domain that may
+	 * never be enforced: a later (rare) thread-sync failure or an
+	 * aborted execution drops it.  Those paths free the domain,
+	 * which emits the matching free_domain event so the create/free
+	 * pair stays balanced.
+	 */
+	trace_landlock_create_domain(new_dom, ruleset);
+	mutex_unlock(&ruleset->lock);
+
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	new_dom->hierarchy->log_same_exec = log_same_exec;
+	new_dom->hierarchy->log_new_exec = log_new_exec;
+	/*
+	 * The creation event fired above, so move the domain out of
+	 * LANDLOCK_LOG_UNCOMMITTED: its free_domain event must fire
+	 * too, even if the domain is dropped before being enforced.
+	 * Audit logging may still be disabled (DISABLED); tracing
+	 * observes it anyway.
+	 */
+	if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
+		new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
+	else
+		new_dom->hierarchy->log_status = LANDLOCK_LOG_PENDING;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+
+	restriction->domain = new_dom;
+	return 0;
+}
+
+/**
+ * landlock_apply_restriction - Enforce a computed restriction on credentials
+ *
+ * @llcred: Landlock credentials to restrict, exclusively owned by the caller
+ *          (prepared and not yet committed).
+ * @restriction: Restriction computed by landlock_prepare_restriction()
+ *               against the same credential state; its domain reference is
+ *               transferred to @llcred.
+ *
+ * Cannot fail, so that a caller may apply a restriction past its last point
+ * of failure, e.g. an exec point of no return.
+ */
+void landlock_apply_restriction(struct landlock_cred_security *const llcred,
+				struct landlock_restriction *const restriction)
+{
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	if (restriction->flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)
+		llcred->log_subdomains_off = true;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+
+	if (!restriction->domain)
+		return;
+
+	/* Replaces the old domain. */
+	landlock_put_domain(llcred->domain);
+	llcred->domain = restriction->domain;
+	restriction->domain = NULL;
+
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	llcred->domain_exec |= BIT(llcred->domain->num_layers - 1);
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+}
+
 static void hook_cred_transfer(struct cred *const new,
 			       const struct cred *const old)
 {
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index a5ff9957949a..88fa97fc3bd2 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -21,6 +21,29 @@
 #include "ruleset.h"
 #include "setup.h"
 
+/**
+ * struct landlock_restriction - Computed credential restriction
+ *
+ * The result of landlock_prepare_restriction(): the new state that
+ * enforcing a ruleset with a set of landlock_restrict_self(2) flags
+ * gives to a credential, decoupled from its application.  It is
+ * enforced with landlock_apply_restriction(), either right away
+ * (landlock_restrict_self(2)) or after a staging period (restriction
+ * of an execution).
+ */
+struct landlock_restriction {
+	/**
+	 * @domain: New domain to enforce, owning a reference.  NULL if the
+	 * restriction only carries a log configuration change.
+	 */
+	struct landlock_domain *domain;
+	/**
+	 * @flags: landlock_restrict_self(2) flags the restriction was
+	 * computed with, validated by the caller.
+	 */
+	u32 flags;
+};
+
 /**
  * struct landlock_cred_security - Credential security blob
  *
@@ -152,6 +175,14 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	return NULL;
 }
 
+int landlock_prepare_restriction(
+	const struct landlock_cred_security *const llcred,
+	struct landlock_ruleset *const ruleset, const u32 flags,
+	struct landlock_restriction *const restriction);
+
+void landlock_apply_restriction(struct landlock_cred_security *const llcred,
+				struct landlock_restriction *const restriction);
+
 __init void landlock_add_cred_hooks(void);
 
 #endif /* _SECURITY_LANDLOCK_CRED_H */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index cb294a3582ae..9451376ccf50 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -9,7 +9,6 @@
 
 #include <asm/current.h>
 #include <linux/anon_inodes.h>
-#include <linux/bitops.h>
 #include <linux/build_bug.h>
 #include <linux/capability.h>
 #include <linux/cleanup.h>
@@ -31,7 +30,6 @@
 #include <uapi/linux/landlock.h>
 
 #include "cred.h"
-#include "domain.h"
 #include "fs.h"
 #include "limits.h"
 #include "net.h"
@@ -546,10 +544,9 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
 	struct landlock_domain *new_dom = NULL;
 	struct cred *new_cred;
-	struct landlock_cred_security *new_llcred;
+	struct landlock_restriction restriction;
 	bool process_wide;
-	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
-		prev_log_subdomains;
+	int err;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -568,13 +565,6 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
-	/* Translates "off" flag to boolean. */
-	log_same_exec = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF);
-	/* Translates "on" flag to boolean. */
-	log_new_exec = !!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
-	/* Translates "off" flag to boolean. */
-	log_subdomains = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
-
 	/*
 	 * It is allowed to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with
 	 * -1 as ruleset_fd, optionally combined with
@@ -596,85 +586,29 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	if (!new_cred)
 		return -ENOMEM;
 
-	new_llcred = landlock_cred(new_cred);
-
-#ifdef CONFIG_SECURITY_LANDLOCK_LOG
-	prev_log_subdomains = !new_llcred->log_subdomains_off;
-	new_llcred->log_subdomains_off = !prev_log_subdomains ||
-					 !log_subdomains;
-#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
-
 	/*
 	 * The only case when a ruleset may not be set is if
 	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set (optionally with
 	 * LANDLOCK_RESTRICT_SELF_TSYNC) and ruleset_fd is -1.  We could
 	 * optimize this case by not calling commit_creds() if this flag was
 	 * already set, but it is not worth the complexity.
+	 *
+	 * There is no possible race condition while copying and manipulating
+	 * the current credentials because they are dedicated per thread.
 	 */
-	if (ruleset) {
-		/*
-		 * There is no possible race condition while copying and
-		 * manipulating the current credentials because they are
-		 * dedicated per thread.
-		 */
-		mutex_lock(&ruleset->lock);
-		new_dom = landlock_merge_ruleset(new_llcred->domain, ruleset);
-		if (IS_ERR(new_dom)) {
-			mutex_unlock(&ruleset->lock);
-			abort_creds(new_cred);
-			return PTR_ERR(new_dom);
-		}
-		/*
-		 * Emits the domain-creation event while @ruleset->lock is still
-		 * held, right after the merge, so an eBPF program attached to
-		 * the tracepoint reads the exact ruleset that was merged into
-		 * the domain: a consistent snapshot that a concurrent
-		 * landlock_add_rule() (which holds the same lock) cannot
-		 * modify.
-		 *
-		 * This must come before the thread-sync wait below.  Holding
-		 * @ruleset->lock across landlock_restrict_sibling_threads()
-		 * would hang: a sibling thread blocked in landlock_add_rule()
-		 * on the same @ruleset->lock cannot run the task_work that
-		 * thread-sync waits for (the lock wait is uninterruptible).
-		 * Emitting here keeps the lock off the thread-sync path.
-		 *
-		 * The trade-off is that the event fires for a domain that a
-		 * later (rare) thread-sync failure aborts.  That path emits the
-		 * matching free_domain event so the create/free pair stays
-		 * balanced (see the thread-sync error path below).
-		 */
-		trace_landlock_create_domain(new_dom, ruleset);
-		mutex_unlock(&ruleset->lock);
-
-#ifdef CONFIG_SECURITY_LANDLOCK_LOG
-		new_dom->hierarchy->log_same_exec = log_same_exec;
-		new_dom->hierarchy->log_new_exec = log_new_exec;
-		/*
-		 * The creation event fired above, so move the domain out of
-		 * LANDLOCK_LOG_UNCOMMITTED: its free_domain event must fire
-		 * too, even if a thread-sync failure aborts it below.  Audit
-		 * logging may still be disabled (DISABLED); tracing observes it
-		 * anyway.
-		 */
-		if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
-			new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
-		else
-			new_dom->hierarchy->log_status = LANDLOCK_LOG_PENDING;
-#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
-
-		/* Replaces the old (prepared) domain. */
-		landlock_put_domain(new_llcred->domain);
-		new_llcred->domain = new_dom;
-
-#ifdef CONFIG_SECURITY_LANDLOCK_LOG
-		new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
-#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+	err = landlock_prepare_restriction(landlock_cred(new_cred), ruleset,
+					   flags, &restriction);
+	if (err) {
+		abort_creds(new_cred);
+		return err;
 	}
 
+	new_dom = restriction.domain;
+	landlock_apply_restriction(landlock_cred(new_cred), &restriction);
+
 	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
-		const int err = landlock_restrict_sibling_threads(
-			current_cred(), new_cred, flags);
+		err = landlock_restrict_sibling_threads(current_cred(), new_cred,
+							flags);
 		if (err) {
 			/*
 			 * Thread-sync failed (rare), so the new domain is
-- 
2.55.0

