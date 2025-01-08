Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B31A202C31
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351058; cv=none; b=s660R18t2IyOXAGx5HombKcThte6jpxz0nmpaUuWsOqq0Yqb5xdD9gQXc6by+VaQbEhmLB4rSUeP6m2Lwa4n7rLtkp4X93z9bnIgdaFymbfFVQJiprO1Jdc18mJo+f12cz+Zy/NztuMicCA/O2RntfrA8Dp1s5bYm92E/8zo2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351058; c=relaxed/simple;
	bh=3D9tz0m87YioFlYBEQRLghfdEDKfAu6INajLtJ2N8yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfxBWhotOWAwVYxtTi9QhjbQAdcYDDWj7gtoWxEE+sWY2VOxYCMIDjfSe7J1qIJKbWPpx9R9bTOQloG2ig4Ju75/km+Ezl+6y18s5CkJKYkq4DCfIH3cQFvpbiYhIu5Sv/T6eexiYEA7Zq04SutjlOLfc6v2Aacb5b0N2fiYlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pkMgChsI; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pkMgChsI"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfP4jltzF4p;
	Wed,  8 Jan 2025 16:44:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351053;
	bh=FaDGX16m1MPjYMA/9MOEmO4u1OscmSfHE6fmKBFPOHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkMgChsIpgwvn5ia0Roj/7suOnvN5ppi2wqHqMqx1k28ItUPWNuEVBmEmE7LVeyPe
	 UvmLrMmVNZy8RS3M6JFWjr87/DWIajDAO8DOYwbLbl/uBloEByhvHBn4hSyhBfA5sc
	 F19l2L8qu0bPzfRWl7F6O5PgvGJsz0ONl1mK4hqk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfN6yCVztns;
	Wed,  8 Jan 2025 16:44:12 +0100 (CET)
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
Subject: [PATCH v4 18/30] landlock: Control log events with LANDLOCK_RESTRICT_SELF_QUIET
Date: Wed,  8 Jan 2025 16:43:26 +0100
Message-ID: <20250108154338.1129069-19-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250108154338.1129069-19-mic@digikod.net
---

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
 security/landlock/audit.c                    |  3 +++
 security/landlock/domain.h                   |  1 +
 security/landlock/syscalls.c                 | 28 ++++++++++++++++----
 tools/testing/selftests/landlock/base_test.c |  2 +-
 6 files changed, 43 insertions(+), 7 deletions(-)

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
index 7a2183ac9add..cc01a0d663f3 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -422,6 +422,9 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 			get_hierarchy(domain, request->layer_plus_one - 1);
 	}
 
+	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
+		return;
+
 	/*
 	 * Consistently keeps track of the number of denied access requests
 	 * even if audit is currently disabled or if audit rules currently
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index e1129ab09a1b..7176043bd0ff 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -23,6 +23,7 @@
 enum landlock_log_status {
 	LANDLOCK_LOG_PENDING = 0,
 	LANDLOCK_LOG_RECORDED,
+	LANDLOCK_LOG_DISABLED,
 };
 
 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 4ed8e70c25ed..8bc14a561e51 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -27,6 +27,7 @@
 #include <uapi/linux/landlock.h>
 
 #include "cred.h"
+#include "domain.h"
 #include "fs.h"
 #include "limits.h"
 #include "net.h"
@@ -150,7 +151,14 @@ static const struct file_operations ruleset_fops = {
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
@@ -434,7 +442,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
  *
  * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
- * @flags: Must be 0.
+ * @flags: Supported value: %LANDLOCK_RESTRICT_SELF_QUIET.
  *
  * This system call enables to enforce a Landlock ruleset on the current
  * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
@@ -460,6 +468,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
 	int err;
+	bool is_quiet = false;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -472,9 +481,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
-	/* No flag for now. */
-	if (flags)
-		return -EINVAL;
+	if (flags) {
+		if (flags == LANDLOCK_RESTRICT_SELF_QUIET)
+			is_quiet = true;
+		else
+			return -EINVAL;
+	}
 
 	/* Gets and checks the ruleset. */
 	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
@@ -499,6 +511,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		goto out_put_creds;
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
2.47.1

