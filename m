Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95B30FC0F
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464485; cv=none; b=pA9PjPYGtf5BTHfzae6EiIGJQdpC7N/pAfp2QwNoN+Ne+F25ig7ySVnP0ThKWpVZ7qDkpsv4Uyd2y+sw64S8Q8WHupNNfFIrb8nZa9Dnlctmd4Gk67RSydyJUHCBzNzCwDhohNG+cr/O/QHb+/IriHvRQujQG3G4SPrERz5VSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464485; c=relaxed/simple;
	bh=hSZLKL0ZVoziVn/VT3sa2EnQmfS/hzy/t7GIiq3s3qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhlDJ/sbve3jmSdIwzJEO90JOOqK8MO9imiiguLSsMUPsLF3F36KnfS0oV2WOspifcc2a56hcyGEKNk/Za3vcaS80AI1UhYfao209rshji2opUm30uemxYhJrIUqs26h1tYRH4lLvKZ45DWRHOAMyW/qVrFMxWtATyCK3Ve114U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCwehxwB; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCwehxwB"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ee6b2da98so6396867b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464479; x=1786069279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E2YkARLK1UgWLJ9tWM7nw633P6+MEg0nLyubK9WrMGQ=;
        b=tCwehxwBLIHgjxxfM6yc4pjzd1rq0AXJiGjPuVUSlWyBflvaTTC7auBbDvx923wlyK
         veTQMTUQoC4H53boA8dqeEXPoFIVUB99l7m36evM9C5nGR219Oufphlx4x9WSTIpIWr/
         NPN+ysMXrqzilCg9KGznlzL0V0ORK3GmOQYgfMWgpYbBt9fQvGQQc8SyShjzKjEOMKkd
         bxWI9yYXVjRSj/vP49tiX/iUYVIF2vpToe+GWR39d4EI+iH31FQkTMDeZpGBjtgdyGEZ
         RHZrc/YZb7KL3UXK5olXxEX2nBM0hfliXOL8V6NZQvaCbUiyQu90codQ4D/nqkhTmw9O
         HTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464479; x=1786069279;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2YkARLK1UgWLJ9tWM7nw633P6+MEg0nLyubK9WrMGQ=;
        b=fNVSTiZVY2jmNTsp3A4+syn2HBikeEpNfVHS7gvrCTmxHbMSr5B9uhTVSZQrwOMki4
         GPWuUHlRUSIoeR0RUaOkRlevjQupAPid4p39A0iLMPhbIFA2qSZshhYjOCXiPxvvfelG
         E6Fy7ZhNlvk3xgpKSS+LkRo//YG/iYqBHN+Dai97VU+5NNu172ERFiN79vM1GfqbAYun
         avzHe1Zs5DWlkXxRQmA5Owxgi3BoJqyEnq8xobjTBSwmxiu23p612Y9fWS6kGfuZcyvi
         ZiuoUpkjXgZqF9hflJAkq1bIDqbnTtVfVrT12ltpqViUwVXzC/lU7t4gUPLZoF+UBaDs
         XVaA==
X-Forwarded-Encrypted: i=1; AHgh+RqaeuBWJYtdO2eBgQNd/PMVFO61KDj9Wx+QfVa5n+erNdXPdqj4gawArBJmG2CpOtl/S4U/C6TD4rW+xnjp7K8w9rkiv40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGabgHzYYRAmOWpSzbwKL4sLpLcxO2y3IAGBL5s7WTQOX6QfU
	8GWTeJ6OLMJBvmniYJ4dpVDdOvpBErVt+v+j15zXrUirokJtYPYJF1fS
X-Gm-Gg: AR+sD12TgIZIHQGi8BPtWCmbUZM3OcXUr90s05yK22JeYcq2HLc3oVl1XWwn95xs3nw
	1MN8VBbUcw84vUnbUY8wy581HAs/HWkWbgoiamKNYpT/tBBvf0G7x1DuFgt+4tAWg80vg5uWWJi
	9g9cK7FQ2nmqvhpzSY1pbEg9Saz5ba35dtjG91ivUvfBBtR9/hrj7A7/XyvsEMWIcf1Hedk0Gmq
	UGv8Xk0YvjPsOx+n9zu5RS0pfCYsw6Re4LluTXb8n/RaW9G3rnjJKGPutnPRG7Z/rp2nF/bvpEb
	5KXYCe/p5ZckifI9CZS6/jNTfBW+432GxR3s+tJ9Ciczbhv6hfG4v1WyXBBx4wo+QK15ky0ch2h
	zWTbjIa2mFGhccEL6GYAyKYT3BmHikvGvvtH1oSN/kKzP8+TkOg1HuLOMZY/yuVAW4eTBRLRaFd
	/ypvENXdqW40kF7hZn2G9RjWLLN72MXypKdPw26PmS/U8X6GhhMlrOVnL6OoHmkUN9FzqYHNYB1
	/eU9DHuOSB7l7lJAl8Qbw==
X-Received: by 2002:a05:690c:660e:b0:80d:78bd:7a37 with SMTP id 00721157ae682-81fcbaff9ebmr585657b3.49.1785464479517;
        Thu, 30 Jul 2026 19:21:19 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:19 -0700 (PDT)
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
Subject: [PATCH bpf-next 05/13] landlock: Factor the credential restriction out of landlock_restrict_self()
Date: Thu, 30 Jul 2026 22:20:38 -0400
Message-ID: <20260731022047.189137-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
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
      credentials' domain, and configure the new domain's audit log
      state, producing a struct landlock_restriction: the complete
      new state that the enforcement gives to a credential.

  landlock_apply_restriction() - enforce a computed restriction on
      credentials exclusively owned by the caller.  This step cannot
      fail, so a caller may run it past its last point of failure.

The syscall behaves exactly as before: prepare and apply run back to
back on the prepared credentials.  The no_new_privs/CAP_SYS_ADMIN
precheck, the flag mask check, and the TSYNC handling are syscall
policy and stay in place.

The point of the split is that application is decoupled from
computation: a following commit restricts an execution from a BPF
kfunc by staging a prepared restriction in the binprm credentials and
applying it at the exec point of no return.  With the flag
translation, domain merge, and audit log configuration in one shared
place.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/cred.c     | 100 +++++++++++++++++++++++++++++++++++
 security/landlock/cred.h     |  33 ++++++++++++
 security/landlock/syscalls.c |  61 +++++----------------
 3 files changed, 147 insertions(+), 47 deletions(-)

diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index cc419de75cd6..13b3952c31c5 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -8,14 +8,114 @@
  */
 
 #include <linux/binfmts.h>
+#include <linux/bits.h>
 #include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/lsm_hooks.h>
+#include <uapi/linux/landlock.h>
 
 #include "common.h"
 #include "cred.h"
+#include "domain.h"
 #include "ruleset.h"
 #include "setup.h"
 
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
+#ifdef CONFIG_AUDIT
+	/* Translates "off" and "on" flags to booleans. */
+	const bool log_same_exec =
+		!(flags & LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF);
+	const bool log_new_exec =
+		!!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
+	const bool log_subdomains =
+		!(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
+	const bool prev_log_subdomains = !llcred->log_subdomains_off;
+#endif /* CONFIG_AUDIT */
+
+	*restriction = (struct landlock_restriction){};
+
+#ifdef CONFIG_AUDIT
+	restriction->log_subdomains_off = !prev_log_subdomains ||
+					  !log_subdomains;
+#endif /* CONFIG_AUDIT */
+
+	if (!ruleset)
+		return 0;
+
+	restriction->domain = landlock_merge_ruleset(llcred->domain, ruleset);
+	if (IS_ERR(restriction->domain)) {
+		const int err = PTR_ERR(restriction->domain);
+
+		restriction->domain = NULL;
+		return err;
+	}
+
+#ifdef CONFIG_AUDIT
+	restriction->domain->hierarchy->log_same_exec = log_same_exec;
+	restriction->domain->hierarchy->log_new_exec = log_new_exec;
+	if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
+		restriction->domain->hierarchy->log_status =
+			LANDLOCK_LOG_DISABLED;
+#endif /* CONFIG_AUDIT */
+
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
+#ifdef CONFIG_AUDIT
+	llcred->log_subdomains_off = restriction->log_subdomains_off;
+#endif /* CONFIG_AUDIT */
+
+	if (!restriction->domain)
+		return;
+
+	/* Replaces the old domain. */
+	landlock_put_ruleset(llcred->domain);
+	llcred->domain = restriction->domain;
+	restriction->domain = NULL;
+
+#ifdef CONFIG_AUDIT
+	llcred->domain_exec |= BIT(llcred->domain->num_layers - 1);
+#endif /* CONFIG_AUDIT */
+}
+
 static void hook_cred_transfer(struct cred *const new,
 			       const struct cred *const old)
 {
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index f287c56b5fd4..1d5039b46ce7 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -20,6 +20,31 @@
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
+	struct landlock_ruleset *domain;
+#ifdef CONFIG_AUDIT
+	/**
+	 * @log_subdomains_off: New value of the credentials'
+	 * @landlock_cred_security.log_subdomains_off.
+	 */
+	u8 log_subdomains_off : 1;
+#endif /* CONFIG_AUDIT */
+};
+
 /**
  * struct landlock_cred_security - Credential security blob
  *
@@ -153,6 +178,14 @@ landlock_get_applicable_subject(const struct cred *const cred,
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
index 9af2407274b2..899601af7c4e 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -528,9 +528,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 {
 	struct landlock_ruleset *ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
-	struct landlock_cred_security *new_llcred;
-	bool __maybe_unused log_same_exec, log_new_exec, log_subdomains,
-		prev_log_subdomains;
+	struct landlock_restriction restriction;
+	int err;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -547,13 +546,6 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	    LANDLOCK_MASK_RESTRICT_SELF)
 		return -EINVAL;
 
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
@@ -575,53 +567,28 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	if (!new_cred)
 		return -ENOMEM;
 
-	new_llcred = landlock_cred(new_cred);
-
-#ifdef CONFIG_AUDIT
-	prev_log_subdomains = !new_llcred->log_subdomains_off;
-	new_llcred->log_subdomains_off = !prev_log_subdomains ||
-					 !log_subdomains;
-#endif /* CONFIG_AUDIT */
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
-		struct landlock_ruleset *const new_dom =
-			landlock_merge_ruleset(new_llcred->domain, ruleset);
-		if (IS_ERR(new_dom)) {
-			abort_creds(new_cred);
-			return PTR_ERR(new_dom);
-		}
-
-#ifdef CONFIG_AUDIT
-		new_dom->hierarchy->log_same_exec = log_same_exec;
-		new_dom->hierarchy->log_new_exec = log_new_exec;
-		if ((!log_same_exec && !log_new_exec) || !prev_log_subdomains)
-			new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
-#endif /* CONFIG_AUDIT */
-
-		/* Replaces the old (prepared) domain. */
-		landlock_put_ruleset(new_llcred->domain);
-		new_llcred->domain = new_dom;
-
-#ifdef CONFIG_AUDIT
-		new_llcred->domain_exec |= BIT(new_dom->num_layers - 1);
-#endif /* CONFIG_AUDIT */
+	err = landlock_prepare_restriction(landlock_cred(new_cred), ruleset,
+					   flags, &restriction);
+	if (err) {
+		abort_creds(new_cred);
+		return err;
 	}
 
+	landlock_apply_restriction(landlock_cred(new_cred), &restriction);
+
 	if (flags & LANDLOCK_RESTRICT_SELF_TSYNC) {
-		const int err = landlock_restrict_sibling_threads(
-			current_cred(), new_cred);
+		err = landlock_restrict_sibling_threads(current_cred(),
+							new_cred);
 		if (err) {
 			abort_creds(new_cred);
 			return err;
-- 
2.54.0

