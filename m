Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285F3C13E9
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982702; cv=none; b=c2U6q9S4ylzVB/xBQsNWQmbnK4MwjkLi5Zq2tHYIzKD77dGqQ9Nf2oiMN8JPwgwDnsSibjQTOatZCvX6e9eRdXhewQdEF6H18JVWjN5e25lrKOVMZV9wCHluWz5oqcDl6BjlSHQl76MPOz0AoMb43kfvEMARQlVqrRGfuEhuru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982702; c=relaxed/simple;
	bh=A6yjzTdbHZqnguHBbm4vFsZKuEWYm2FWBIz+/7/XZos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H28/XKLf2noW1+XQoKsxZD8Xl7GDU9eH+/lMOEqXFyp6/mB0knI1eUX4ByFJM+NQvjMj5PKHNl6PpHesvVl3uilYzv+M9zOvDATvfClSxkqrQCzPR97bVfxH/zZxe9op0WQQgg6rTGPiNWxF0waSwjAvWbUPDDCrTwfv+OYJ0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haKPfA+B; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haKPfA+B"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ecf499af9so89495407b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982697; x=1789587497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yPGhSQERTfDV/m5o0iCkbt26gt+YkajcCjMPDdzinZQ=;
        b=haKPfA+BtZW94SFI+Mc7CoY26tfA31Wp5QtqY0UYBWPhzkPh1E2V0cd4fbgVwAmaaJ
         jnRPw1qvpl3iT8bAOoLgF8OQdmnc2C19I845ykkhuAdDpyz1em62QH/vDEWbLA3FSrw7
         8q7TG9BMjPXufDOnmjYBOvndFhpUPoLRzViWDT3G4Dod2vWX0Y0CuSqc3eBNdS8BX1Pc
         H6hQnDY1FbHlzParduuxujOMSltMtinkixo1r/UQ2Ur8fp216HAUeSTsXzjeo3iHnf1q
         DJPlS10ShEvzb4LlnnpyDbCwPIyrr+nsl42ckov2apuy19CFTIR4RV2InBIogsAFj+4A
         0ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982697; x=1789587497;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPGhSQERTfDV/m5o0iCkbt26gt+YkajcCjMPDdzinZQ=;
        b=diK9h7GfRcxLS3BJMx2DG9xFXd0Ty4HiPI0E68jTN8qWkav97oU4sEQA7bdH0gdFwq
         v8u/v8KJlGY54wu1FKbJKp9AIuSSIT0RYx407glfHynaLahZvfd43oX7SnjAk2Ovw/P0
         pIRZT/14aNCP1p4b/9jgmI+th7onyMXwhZg4gIDCy/Gu+M6KYeXUCMeguiRUU/aMjjOw
         /AC/L89kYSmmvWdYrPFSaVozaSm5s8zbkM6aP4RxqF5RfjRRvWYCriGDpPbxCXhpMrqh
         RWMAVvIAx2URffrTgQ/12tDtAxScQkBswQB9HC0ZDsTfkaf/qJuhpXEUfPO/GAfTuIKy
         //xQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwySxgBeG6XaW73IT4PlrUO51fJX99fDqHKPFKpWP/Vh5+WztDdGrsVWunJKvgcWxduDCbEqvQAioti0JEXUUxGk04ZkM=@vger.kernel.org
X-Gm-Message-State: AFuF++m/q6+4egCBCXD9sX8/rEdaHJ+2qGVK2MFZc3IbpQMUe/J/aZXi
	+EX+l6+vWAzKlP1FwR9UHrPilvOGuJB40fLL6diXqHlGkfVUicY97aBC
X-Gm-Gg: AYBFou1u1RDp4hHifh93S+k4oazT5biQgL29kO4a9Q6HgxYc3iNHbU0ayBQ1jOQaQZX
	6LgAMT8g8cHW5bj8XTy0u7hv3ZiJ/xFWdsl/yO9gM/VF/0MRq19T7QU7J/nnLEN4NVHsXwr8w5d
	RlPYOifI/a1v1GE1VtQcg8hXzo+BZYK9SMZ3TR2LbUn2YaAdLnHyvBo5UKwzT3Klt+DalhIxpZ4
	EXbaBT747wfm8zKymBdeYGJqSHqV9cK02F0lAvM5G4tUriJEvMcJRh+B+lW4uUWivqkPPmPSsnt
	ZkkhN3U4l7LqSPxyCsU4DH+mWbayGT/jziRxYPJPVSr+GWnXYPKjg38i2pW34bSpXHOStKRE71C
	4aMFgJPA31lbwglyPU6DmDieRgWDIpbLpwW5ETGBqnWSthXCiTxtimSfGJRUIbMZQUGXay+pSrH
	ErgBMTzwsSudBbt9BEt47CqOLaxoI5HfUEuEqYuyN8RBqXU96fT2A+Lbz5uSQ4Yg6HfRtEF2EiX
	wVPTo8Ny2OsNrfzi+vFKQHbhz4RQSfU
X-Received: by 2002:a05:690c:6513:b0:873:5c7b:c0fb with SMTP id 00721157ae682-8735c7bc1b0mr114372877b3.51.1788982696408;
        Wed, 09 Sep 2026 12:38:16 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:38:16 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 11/15] landlock: Factor the credential restriction out of landlock_restrict_self()
Date: Wed,  9 Sep 2026 15:37:14 -0400
Message-ID: <20260909193719.518517-12-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
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

Notes:
    v2->v3:
        - No change.

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

