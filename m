Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80E22CBE8
	for <linux-security-module@vger.kernel.org>; Thu, 20 Mar 2025 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497676; cv=none; b=UWsUE5lLINE61V6nv/KA3NDJNJWBbYWxjQ0x0vZps3ktemWcws51Tilh6VA8fndh1mhRWKgxxNTRxGBiq+9TLUs62TgzpZQDxniGTkkmrwGhg0OIMkmxUE1RJNRbLiWThohgzFT7CngIsBorH7PiBN31VpPXASM/zytphQhsyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497676; c=relaxed/simple;
	bh=nsuN8rDnZIYlqdHbThiTl+EjD+3RY9dDvwLDv1uQGoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFLIU80Tz/N04Z402aXBKL8FuKvBdRtWxliYoSbT330yHXibaLAy9Zg72Ygq4PQsX8rBvt+zxMCrdFeb0G4s1EeAnn9XjIVbBbX8oAaLMFtLcY2jAib1WjrRCrY+1QmS43RWgudPrb5+v0WEFWpiLhiY1b4PhGgFVjN3QVOR9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jv7rJCeO; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jv7rJCeO"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpb4yyBzw61;
	Thu, 20 Mar 2025 20:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497671;
	bh=5vY36iKFrk8QlgsVaSjsiLJoUKFp66Vb74FMmqZVYUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jv7rJCeOPV1kob9OF5h+grXCCv2y38nRCOtjWbpVRVrNgNzwJTqUUdK/zmX//3o/j
	 N9QfcwjPTZKeJaG5OXUEJMJVv7qoA/wyfxbzyzCdIOMdngRB0QkSND/P5ox8LJPNLn
	 N3sJ3oadzSVxyjKXQdmRlVXUoQfu0S2NTIaG0xCU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpZ4VnVzF2s;
	Thu, 20 Mar 2025 20:07:50 +0100 (CET)
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
	Matthieu Buffet <matthieu@buffet.re>,
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
Subject: [PATCH v7 17/28] landlock: Add LANDLOCK_RESTRICT_SELF_LOG_*_EXEC_* flags
Date: Thu, 20 Mar 2025 20:07:06 +0100
Message-ID: <20250320190717.2287696-18-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Most of the time we want to log denied access because they should not
happen and such information helps diagnose issues.  However, when
sandboxing processes that we know will try to access denied resources
(e.g. unknown, bogus, or malicious binary), we might want to not log
related access requests that might fill up logs.

By default, denied requests are logged until the task call execve(2).

If the LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF flag is set, denied
requests will not be logged for the same executed file.

If the LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON flag is set, denied
requests from after an execve(2) call will be logged.

The rationale is that a program should know its own behavior, but not
necessarily the behavior of other programs.

Because LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF is set for a specific
Landlock domain, it makes it possible to selectively mask some access
requests that would be logged by a parent domain, which might be handy
for unprivileged processes to limit logs.  However, system
administrators should still use the audit filtering mechanism.  There is
intentionally no audit nor sysctl configuration to re-enable these logs.
This is delegated to the user space program.

Increment the Landlock ABI version to reflect this interface change.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v6:
- Replace the LANDLOCK_ABI_VERSION value with the new
  landlock_abi_version variable.
- Update headers.

Changes since v5:
- Rename LANDLOCK_RESTRICT_SELF_QUIET to
  LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF, and adjust
  landlock_log_denial() accordingly.  This better reflects what is the
  impact of this flag, especially wrt the following
  LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON, and makes both flags
  compatible and complementary.
- Rename LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC to
  LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON to be more consistent with
  other flags.
- Change flag values.
- Squash the LOG_SAME_EXEC_OFF and the LOG_NEW_EXEC_ON patches to get
  a more consistent patch.

Changes since v4:
- Rebase on top of the scoped guard patches.

Changes since v3:
- Rename LANDLOCK_RESTRICT_SELF_LOGLESS to LANDLOCK_RESTRICT_SELF_QUIET.
  "quiet" is already used by kernel's cmdline to disable most log
  messages, so this name makes sense for Landlock.
- Improve the LANDLOCK_ABI_VERSION comment.

Changes since v2:
- Update ABI version test.
---
 include/uapi/linux/landlock.h                | 21 +++++++++++
 security/landlock/audit.c                    | 16 ++++++--
 security/landlock/domain.c                   |  2 +
 security/landlock/domain.h                   | 11 ++++++
 security/landlock/limits.h                   |  7 +++-
 security/landlock/syscalls.c                 | 39 ++++++++++++++++----
 tools/testing/selftests/landlock/base_test.c |  2 +-
 7 files changed, 85 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 8806a132d7b8..56b0094ef792 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -4,6 +4,7 @@
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2021-2025 Microsoft Corporation
  */
 
 #ifndef _UAPI_LINUX_LANDLOCK_H
@@ -64,6 +65,26 @@ struct landlock_ruleset_attr {
 #define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
 /* clang-format on */
 
+/*
+ * sys_landlock_restrict_self() flags:
+ *
+ * - %LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF: Do not create any log related to the
+ *   enforced restrictions.  This should only be set by tools launching unknown
+ *   or untrusted programs (e.g. a sandbox tool, container runtime, system
+ *   service manager).  Because programs sandboxing themselves should fix any
+ *   denied access, they should not set this flag to be aware of potential
+ *   issues reported by system's logs (i.e. audit).
+ * - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON: Explicitly ask to continue
+ *   logging denied access requests even after an :manpage:`execve(2)` call.
+ *   This flag should only be set if all the programs than can legitimately be
+ *   executed will not try to request a denied access (which could spam audit
+ *   logs).
+ */
+/* clang-format off */
+#define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
+#define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
+/* clang-format on */
+
 /**
  * enum landlock_rule_type - Landlock rule type
  *
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 2dcc55ad451c..7ababc314236 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -422,6 +422,9 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 			get_hierarchy(subject->domain, youngest_layer);
 	}
 
+	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
+		return;
+
 	/*
 	 * Consistently keeps track of the number of denied access requests
 	 * even if audit is currently disabled, or if audit rules currently
@@ -433,9 +436,16 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	if (!audit_enabled)
 		return;
 
-	/* Ignores denials after an execution. */
-	if (!(subject->domain_exec & (1 << youngest_layer)))
-		return;
+	/* Checks if the current exec was restricting itself. */
+	if (subject->domain_exec & (1 << youngest_layer)) {
+		/* Ignores denials for the same execution. */
+		if (!youngest_denied->log_same_exec)
+			return;
+	} else {
+		/* Ignores denials after a new execution. */
+		if (!youngest_denied->log_cross_exec)
+			return;
+	}
 
 	/* Uses consistent allocation flags wrt common_lsm_audit(). */
 	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index f61fa5ae8e56..9a601fcbe1e2 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -127,6 +127,8 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 	hierarchy->details = details;
 	hierarchy->id = landlock_get_id_range(1);
 	hierarchy->log_status = LANDLOCK_LOG_PENDING;
+	hierarchy->log_same_exec = true;
+	hierarchy->log_cross_exec = false;
 	atomic64_set(&hierarchy->num_denials, 0);
 	return 0;
 }
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 96642dd87b33..57d4f8e41c97 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -24,6 +24,7 @@
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
 	LANDLOCK_LOG_RECORDED,
+	LANDLOCK_LOG_DISABLED,
 };
 
 /**
@@ -103,6 +104,16 @@ struct landlock_hierarchy {
 	 * @details: Information about the related domain.
 	 */
 	const struct landlock_details *details;
+	/**
+	 * @log_same_exec: Set if the domain is *not* configured with
+	 * %LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF.  Set to true by default.
+	 */
+	u32 log_same_exec : 1,
+		/**
+		 * @log_cross_exec: Set if the domain is configured with
+		 * %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON.  Set to false by default.
+		 */
+		log_cross_exec : 1;
 #endif /* CONFIG_AUDIT */
 };
 
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 15f7606066c8..404e880cccf9 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -1,9 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Landlock LSM - Limits for different components
+ * Landlock - Limits for different components
  *
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2021-2025 Microsoft Corporation
  */
 
 #ifndef _SECURITY_LANDLOCK_LIMITS_H
@@ -29,6 +30,10 @@
 #define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SIGNAL
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
+
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
+#define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
+
 /* clang-format on */
 
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index b7b268f43a3b..5c49a6ef14e4 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Landlock LSM - System call implementations and user space interfaces
+ * Landlock - System call implementations and user space interfaces
  *
  * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2021-2025 Microsoft Corporation
  */
 
 #include <asm/current.h>
@@ -28,6 +29,7 @@
 #include <uapi/linux/landlock.h>
 
 #include "cred.h"
+#include "domain.h"
 #include "fs.h"
 #include "limits.h"
 #include "net.h"
@@ -151,7 +153,14 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 6
+/*
+ * The Landlock ABI version should be incremented for each new Landlock-related
+ * user space visible change (e.g. Landlock syscalls).  This version should
+ * only be incremented once per Linux release, and the date in
+ * Documentation/userspace-api/landlock.rst should be updated to reflect the
+ * UAPI change.
+ */
+const int landlock_abi_version = 7;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -247,8 +256,6 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	return ruleset_fd;
 }
 
-const int landlock_abi_version = LANDLOCK_ABI_VERSION;
-
 /*
  * Returns an owned ruleset from a FD. It is thus needed to call
  * landlock_put_ruleset() on the return value.
@@ -443,7 +450,10 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
  *
  * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
- * @flags: Must be 0.
+ * @flags: Supported values:
+ *
+ * - %LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF
+ * - %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
  *
  * This system call enables to enforce a Landlock ruleset on the current
  * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
@@ -453,7 +463,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - %EINVAL: @flags is not 0.
+ * - %EINVAL: @flags contains an unknown bit.
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor;
  * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
@@ -469,6 +479,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		*ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
+	bool log_same_exec, log_cross_exec;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -481,10 +492,15 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
-	/* No flag for now. */
-	if (flags)
+	if ((flags | LANDLOCK_MASK_RESTRICT_SELF) !=
+	    LANDLOCK_MASK_RESTRICT_SELF)
 		return -EINVAL;
 
+	/* Translates "off" flag to boolean. */
+	log_same_exec = !(flags & LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF);
+	/* Translates "on" flag to boolean. */
+	log_cross_exec = !!(flags & LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON);
+
 	/* Gets and checks the ruleset. */
 	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
 	if (IS_ERR(ruleset))
@@ -507,6 +523,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		return PTR_ERR(new_dom);
 	}
 
+#ifdef CONFIG_AUDIT
+	new_dom->hierarchy->log_same_exec = log_same_exec;
+	new_dom->hierarchy->log_cross_exec = log_cross_exec;
+	if (!log_same_exec && !log_cross_exec)
+		new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
+#endif /* CONFIG_AUDIT */
+
 	/* Replaces the old (prepared) domain. */
 	landlock_put_ruleset(new_llcred->domain);
 	new_llcred->domain = new_dom;
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index c0abadd0bbbe..7dc431a0e18e 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(6, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
-- 
2.49.0

