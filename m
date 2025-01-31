Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3251F3D5F
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341109; cv=none; b=AwZsSe15bfh01+UT0cdxaGwtJ6LD8Xx6vmPxb7JssvyAhdNIEqXUuYiKhp3pWRTuRP3KYx72J46r4A9xR92kR/RKwV5hPRuz88Z4x3J6Rf+uvJMbd+vXzi0o9iCx98munU2CB57yK+XisfCVDezDN8djFNQrJg7h46H3jIzkO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341109; c=relaxed/simple;
	bh=DEngdT+oSlgMgmeVptwuASw+ZjMciboRCfxdOUykQog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6ZnyACpo2qzuYmXuIt+vYBXnQTOqHWQiTuZzOv8CsO1h2ORHGBG7WT3gdLy3mWR49QkGY/YLA/Z82zAd0uyIRze2ulkZSJZhvq25tT5O/UyjLW/aL759LNMYog4xj6r3n8vpv1EAQ4Eomi4nA92vq9CEOdhg+38eSKgmNgBfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OIMaQjOc; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OIMaQjOc"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cd4KBczTlw;
	Fri, 31 Jan 2025 17:31:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341105;
	bh=wY+JFy+zIck/+pZrBCbx1eC1JqFZBqAeKV4mq6vuFYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIMaQjOcyrA6jac2Zp6E6trjQbaR+UCjAEbBSzfNj1sWS0Fv413aWaPFaJHSv+TSO
	 lZd4ibOjI4rQjRKbCHINZZuL4abuWevOnTodkmzv/koisJwDdF+quwqMmkfcHo9zW/
	 1g5MzGQBIcZR5xmVusO9eKr/JXqEngX41vg4mPbw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1cc5j9kzg27;
	Fri, 31 Jan 2025 17:31:44 +0100 (CET)
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
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 16/24] landlock: Add LANDLOCK_RESTRICT_SELF_QUIET
Date: Fri, 31 Jan 2025 17:30:51 +0100
Message-ID: <20250131163059.1139617-17-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-1-mic@digikod.net>
References: <20250131163059.1139617-1-mic@digikod.net>
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

To disable any log for a specific Landlock domain, add a
LANDLOCK_RESTRICT_SELF_QUIET optional flag to the
landlock_restrict_self() system call.

Because this flag is set for a specific Landlock domain, it makes it
possible to selectively mask some access requests that would be logged
by a parent domain, which might be handy for unprivileged processes to
limit logs.  However, system administrators should still use the audit
filtering mechanism.

There is intentionally no audit nor sysctl configuration to re-enable
these quiet domains.  This is delegated to the user space program.

Increment the Landlock ABI version to reflect this interface change.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Closes: https://github.com/landlock-lsm/linux/issues/3
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-17-mic@digikod.net
---

Using "mute" instead of "quiet" might be more appropriate.

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
 Documentation/userspace-api/landlock.rst     |  2 +-
 include/uapi/linux/landlock.h                | 14 ++++++++++
 security/landlock/audit.c                    |  3 ++
 security/landlock/domain.h                   |  1 +
 security/landlock/limits.h                   |  4 +++
 security/landlock/syscalls.c                 | 29 ++++++++++++++++----
 tools/testing/selftests/landlock/base_test.c |  2 +-
 7 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index d639c61cb472..a7c1ebef2c79 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: October 2024
+:Date: January 2025
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 33745642f787..b7f78abd6ddd 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -62,6 +62,20 @@ struct landlock_ruleset_attr {
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
 /* clang-format on */
 
+/*
+ * sys_landlock_restrict_self() flags:
+ *
+ * - %LANDLOCK_RESTRICT_SELF_QUIET: Do not create any log related to the
+ *   enforced restrictions.  This should only be set by tools launching unknown
+ *   or untrusted programs (e.g. a sandbox tool, container runtime, system
+ *   service manager).  Because programs sandboxing themselves should fix any
+ *   denied access, they should not set this flag to be aware of potential
+ *   issues reported by system's logs (i.e. audit).
+ */
+/* clang-format off */
+#define LANDLOCK_RESTRICT_SELF_QUIET			(1U << 0)
+/* clang-format on */
+
 /**
  * enum landlock_rule_type - Landlock rule type
  *
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index fc4d1dfb5c25..beebe45a47e6 100644
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
 	 * even if audit is currently disabled, if audit rules currently
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index c1ab2fe1d441..25be0a18da1f 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -24,6 +24,7 @@
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
 	LANDLOCK_LOG_RECORDED,
+	LANDLOCK_LOG_DISABLED,
 };
 
 /**
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 15f7606066c8..2a5e9f3ee750 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -29,6 +29,10 @@
 #define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPE_SIGNAL
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
+
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_QUIET
+#define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
+
 /* clang-format on */
 
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 5129981fec8b..5c6abcd6d604 100644
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
@@ -429,7 +437,9 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
  *
  * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
- * @flags: Must be 0.
+ * @flags: Supported values:
+ *
+ * - %LANDLOCK_RESTRICT_SELF_QUIET
  *
  * This system call enables to enforce a Landlock ruleset on the current
  * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
@@ -439,7 +449,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * Possible returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - %EINVAL: @flags is not 0.
+ * - %EINVAL: @flags contains an unknown bit.
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor;
  * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
@@ -455,6 +465,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		*ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
+	bool is_quiet;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -467,10 +478,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
-	/* No flag for now. */
-	if (flags)
+	if ((flags | LANDLOCK_MASK_RESTRICT_SELF) !=
+	    LANDLOCK_MASK_RESTRICT_SELF)
 		return -EINVAL;
 
+	is_quiet = !!(flags & LANDLOCK_RESTRICT_SELF_QUIET);
+
 	/* Gets and checks the ruleset. */
 	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
 	if (IS_ERR(ruleset))
@@ -493,6 +506,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		return PTR_ERR(new_dom);
 	}
 
+	if (is_quiet) {
+#ifdef CONFIG_AUDIT
+		new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
+#endif /* CONFIG_AUDIT */
+	}
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

