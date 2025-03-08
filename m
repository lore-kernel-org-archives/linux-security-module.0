Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD232153D4
	for <linux-security-module@vger.kernel.org>; Sat,  8 Mar 2025 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459502; cv=none; b=fGtsRmSCSv0JvoVbBcLhL0Zi3EbREHEHcEbcPhEwA/92XD5gOQX20vOHW/qx+ab5oAY/R/kZp6859ZGd4sxZSprtAX+SlewhYlC4xXT+hM76PFtchBMEv8FafsxNbGATDY2VSKE8GUSQzPTK/tgMiKOaGraqXmcuoHuq/GCRAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459502; c=relaxed/simple;
	bh=k1m9iFSywrtIwR6hiRVlkDVU5un0WI0sVvyht2eqlcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESXAtItan502phD00U9Z1G528AZDSNqgDygJGmslaw7iWA5DwrPjI+97lttJXGL5px7qBum7aWuves14EMC2JsmC2DfyMuSLjtAh4AHzLoNUgb+Dc6uhDoAAODmKoa/yadlp3TAtCtVYP2O/F63ywjpj+/ll3RJbKlBLIHxHWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wT/LqKPN; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wT/LqKPN"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z9Bsj2hZrzQBn;
	Sat,  8 Mar 2025 19:44:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741459497;
	bh=/wKf0zE+F9KVAAzytvTvsyiRmpBYc4ELYRrZOq7vhPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wT/LqKPNwF4iJTaHMAbHK06j/fUpmi5d3cqXcn0rHKGRbBd0xtW+VV6BEyHa/hzGz
	 EWJ7Ny9X7YMTyY8HyKUrGr+LcIoMGzEC31aM6NQ4ZXQ0+GZXfCmDPXV7Jvgozz4NiK
	 JmWFNLVEEYiAET7FApmwT9OZP6i+Lp+dSRDYvAc8=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z9Bsh3bCDzqYW;
	Sat,  8 Mar 2025 19:44:56 +0100 (CET)
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
Subject: [PATCH v6 16/26] landlock: Add LANDLOCK_RESTRICT_SELF_LOG_*_EXEC_* flags
Date: Sat,  8 Mar 2025 19:44:12 +0100
Message-ID: <20250308184422.2159360-17-mic@digikod.net>
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

TODO: Add header copyrights

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
Link: https://lore.kernel.org/r/20250308184422.2159360-17-mic@digikod.net
---

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
 include/uapi/linux/landlock.h                | 21 ++++++++++++
 security/landlock/audit.c                    | 16 +++++++--
 security/landlock/domain.c                   |  2 ++
 security/landlock/domain.h                   | 11 +++++++
 security/landlock/limits.h                   |  4 +++
 security/landlock/syscalls.c                 | 34 +++++++++++++++++---
 tools/testing/selftests/landlock/base_test.c |  2 +-
 7 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index e1d2c27533b4..daa1bc4123c3 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -4,6 +4,7 @@
  *
  * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
  * Copyright © 2018-2020 ANSSI
+ * Copyright © 2021-2025 Microsoft Corporation
  */
 
 #ifndef _UAPI_LINUX_LANDLOCK_H
@@ -62,6 +63,26 @@ struct landlock_ruleset_attr {
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
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
index d0eafb946f31..01dc62ba7999 100644
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
 
 	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
 			     AUDIT_LANDLOCK_ACCESS);
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 6704e9283206..925b3c2f8d23 100644
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
index c1ab2fe1d441..567b86d48849 100644
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
index 15f7606066c8..a45cd58898d0 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -29,6 +29,10 @@
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
index 5129981fec8b..c9f4e213a6f4 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -28,6 +28,7 @@
 #include <uapi/linux/landlock.h>
 
 #include "cred.h"
+#include "domain.h"
 #include "fs.h"
 #include "limits.h"
 #include "net.h"
@@ -151,7 +152,14 @@ static const struct file_operations ruleset_fops = {
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
+#define LANDLOCK_ABI_VERSION 7
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -429,7 +437,10 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
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
@@ -439,7 +450,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - %EINVAL: @flags is not 0.
+ * - %EINVAL: @flags contains an unknown bit.
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor;
  * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
@@ -455,6 +466,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		*ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
+	bool log_same_exec, log_cross_exec;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -467,10 +479,15 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
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
@@ -493,6 +510,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
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
index 1bc16fde2e8a..fbd687691b3c 100644
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
2.48.1

