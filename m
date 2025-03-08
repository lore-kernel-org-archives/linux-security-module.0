Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875781F9F5C
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459503; cv=none; b=qjmF6qWHOMFZ5HA3J7L9dziHft9G6plXlhDrrC8LtfUKDVDt1UZKchpnuoIL91hhBEWJ0gfXz9BAYD5vmj4dqRzrDf9S9MkJeQ5gHXTxBCTf4nhxe7oFAnj6IXj038vz9CP803tEongsVhAojgKJ6fnxEXp851auD4wNWGtMYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459503; c=relaxed/simple;
	bh=HY7qIKjBEs880v4uRMbaQluwbi4wIxUTYH16MjpJy7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fT6BSIn4VS30YSJdhNEsXhtULQw0FeRNHC028U4ODIh9aJmASyjWcNSJhMx7A+q26lse70MZqRqrPY+9/seymaHMOUPsSseRcv6P1x84TNIgLd+LKOmN5p8IweLXf036ordtvsiFJqmjk7nX/PNHMEw1HWwa+ddRzcm6VX/zbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nFFZP+XT; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nFFZP+XT"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsk6QmqzQXN;
	Sat,  8 Mar 2025 19:44:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459498;
	bh=3viWkOI4qofVLlRfSbI1uxTIdc+LKxgzLDCR2tOktw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFFZP+XTehK97wbq/uScO1/+nU78acHZl61bgIRWx1dnVw32hQ4FFQeWqrN7nvZ4k
	 QB/CQnkoPRL0segtfQ/vTpvD3erNzTDdP+GX3Z58OswEu76bAW1bOSJVw1MxdDslPW
	 oL+RKssDyLU2PrKzw5enqai/efLNpMPD2/n6OAog=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsk11LQzhLM;
	Sat,  8 Mar 2025 19:44:58 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 17/26] landlock: Add LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
Date: Sat,  8 Mar 2025 19:44:13 +0100
Message-ID: <20250308184422.2159360-18-mic@digikod.net>
In-Reply-To: <20250308184422.2159360-1-mic@digikod.net>
References: <20250308184422.2159360-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF for the case of sandboxer
tools, init systems, or runtime containers launching programs sandboxing
themselves in an inconsistent way.  Setting this flag should only
depends on runtime configuration (i.e. not hardcoded).

We don't create a new ruleset's option because this should not be part
of the security policy: only the task that enforces the policy (not the
one that create it) knows if itself or its children may request denied
actions.

This is the first and only flag that can be set without actually
restricting the caller (i.e. without providing a ruleset).

Extend struct landlock_cred_security with a u8 log_subdomains_off.
struct landlock_file_security is still 16 bytes.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Closes: https://github.com/landlock-lsm/linux/issues/3
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250308184422.2159360-18-mic@digikod.net
---

Changes since v5:
- Rename LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS to
  LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF.  As for
  LANDLOCK_RESTRICT_SELF_LOG_OFF, this makes more sense.
- Store the log_subdomains bit in landlock_cred instead of
  landlock_hirerarchy because it is not directly related to the current
  domain.
- Make it possible to set this flag without actually restricting the
  calling task, and update the related documentation.

Changes since v4:
- New patch.
---
 include/uapi/linux/landlock.h | 12 ++++++++++
 security/landlock/cred.h      |  7 ++++++
 security/landlock/limits.h    |  2 +-
 security/landlock/syscalls.c  | 41 ++++++++++++++++++++++++++++++-----
 4 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index daa1bc4123c3..66f6328583e4 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -77,10 +77,22 @@ struct landlock_ruleset_attr {
  *   This flag should only be set if all the programs than can legitimately be
  *   executed will not try to request a denied access (which could spam audit
  *   logs).
+ * - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF: Do not create any log related
+ *   to the enforced restrictions coming from future nested domains created by
+ *   the caller or its descendants.  This should only be set according to a
+ *   runtime configuration (i.e. not hardcoded) by programs launching other
+ *   unknown or untrusted programs that may create their own Landlock domains
+ *   and spam logs.  The main use case is for container runtimes to enable users
+ *   to mute buggy sandboxed programs for a specific container image.  Other use
+ *   cases include sandboxer tools and init systems.  Unlike
+ *   %LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF,
+ *   %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF does not impact the requested
+ *   restriction (if any) but only the future nested domains.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
 #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
+#define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index cf38caf77adc..3194a46022f9 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -39,6 +39,13 @@ struct landlock_cred_security {
 	 * landlock_restrict_self(2)).
 	 */
 	u16 domain_exec;
+	/**
+	 * @log_subdomains_off: Set if the domain descendants's log_status should be
+	 * set to %LANDLOCK_LOG_DISABLED.  This is not a landlock_hierarchy
+	 * configuration because it applies to future descendant domains and it does
+	 * not require a current domain.
+	 */
+	u8 log_subdomains_off : 1;
 #endif /* CONFIG_AUDIT */
 } __packed;
 
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index a45cd58898d0..5c0dbf1beb48 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -30,7 +30,7 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
-#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
 /* clang-format on */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index c9f4e213a6f4..e38b22075ca1 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -441,12 +441,16 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  *
  * - %LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF
  * - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
+ * - %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
  *
  * This system call enables to enforce a Landlock ruleset on the current
  * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
  * namespace or is running with no_new_privs.  This avoids scenarios where
  * unprivileged tasks can affect the behavior of privileged children.
  *
+ * It is allowed to only pass the %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF
+ * flag with a @ruleset_fd value of -1.
+ *
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
@@ -466,7 +470,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		*ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
-	bool log_same_exec, log_cross_exec;
+	bool log_same_exec, log_cross_exec, log_subdomains,
+		__maybe_unused prev_log_subdomains;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -487,11 +492,20 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	log_same_exec = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF);
 	/* Translates "on" flag to boolean. */
 	log_cross_exec = !!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
+	/* Translates "off" flag to boolean. */
+	log_subdomains = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);
 
-	/* Gets and checks the ruleset. */
-	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
-	if (IS_ERR(ruleset))
-		return PTR_ERR(ruleset);
+	/*
+	 * It is allowed to set %LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with -1
+	 * as @ruleset_fd, but no other flag must be set.
+	 */
+	if (!(ruleset_fd == -1 &&
+	      flags == LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
+		/* Gets and checks the ruleset. */
+		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
+		if (IS_ERR(ruleset))
+			return PTR_ERR(ruleset);
+	}
 
 	/* Prepares new credentials. */
 	new_cred = prepare_creds();
@@ -500,6 +514,21 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 
 	new_llcred = landlock_cred(new_cred);
 
+#ifdef CONFIG_AUDIT
+	prev_log_subdomains = !new_llcred->log_subdomains_off;
+	new_llcred->log_subdomains_off = !prev_log_subdomains ||
+					 !log_subdomains;
+#endif /* CONFIG_AUDIT */
+
+	/*
+	 * The only case when a ruleset may not be set is if
+	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set and ruleset_fd is -1.
+	 * We could optimize this case by not calling commit_creds() if this flag
+	 * was already set, but it is not worth the complexity.
+	 */
+	if (!ruleset)
+		return commit_creds(new_cred);
+
 	/*
 	 * There is no possible race condition while copying and manipulating
 	 * the current credentials because they are dedicated per thread.
@@ -513,7 +542,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 #ifdef CONFIG_AUDIT
 	new_dom->hierarchy->log_same_exec = log_same_exec;
 	new_dom->hierarchy->log_cross_exec = log_cross_exec;
-	if (!log_same_exec && !log_cross_exec)
+	if ((!log_same_exec && !log_cross_exec) || !prev_log_subdomains)
 		new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
 #endif /* CONFIG_AUDIT */
 
-- 
2.48.1

