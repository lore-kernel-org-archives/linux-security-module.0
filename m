Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA41DFDBB
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286071; cv=none; b=qB11UGr7K4ssOrqGGIXkAwekLyT5PqcBAJpXhZj5WH/N3s6P1JkiKSbiqH7f03ZaeEs+/fvzYagOecEAQPaaT/fUs7AYgAGN+HadvVWy8pkztZI8STdVsF5OVnQS+wJMIfG7Zn/96PUwEpVYGRCwbr1Xc4oC0/lBsXbGtJETBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286071; c=relaxed/simple;
	bh=9vkpqOXOOas8sOVHBkBZnkbCiu2ImKo+E65/I4xkif4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0ljp5Hm7gtnNj3LmVQ9N7WGHekQWuS5MbEdBnyfGO7JWNiNFeeKZA++I1+K8NJdy7iaY2PLkN47nRFfaAO7XK0OrCsuHRF4dvasV8STf9vQGJdm+ImeTzy62FlI6yhN8PNLtvAURAvSGh++b5HuBOMw5srjiv81dkZXVIRXuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VuCBceqR; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VuCBceqR"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKb1rhczdGx;
	Fri, 22 Nov 2024 15:34:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286067;
	bh=eDiO7RWLuAlP8xysyN4lIXeckZHgELRnTxejsb+EFS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuCBceqRWuVn5tQNWDbuCjiMxnDmO3rKpO6s2MuPH5UKgu1hA0ZyNO5dbAf3guC2l
	 H4eWKSlzuLCCdQvxPssDfT4UMYJZ0v0Wp0J4vNZN3oIwQktiZlYWxjCaDXns6uYACS
	 9fw4GVSEipotp4GhP1xEpyS/YaFtqDhZBCcnIhsg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKZ4jwqznDC;
	Fri, 22 Nov 2024 15:34:26 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
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
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 19/23] landlock: Control log events with LANDLOCK_RESTRICT_SELF_LOGLESS
Date: Fri, 22 Nov 2024 15:33:49 +0100
Message-ID: <20241122143353.59367-20-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
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
LANDLOCK_RESTRICT_SELF_LOGLESS optional flag to the
landlock_restrict_self() system call.

Because this flag is set for a specific Landlock domain, it makes it
possible to selectively mask some access requests that would be logged
by a parent domain, which might be handy for unprivileged processes to
limit logs.  However, system administrators should still use the audit
filtering mechanism.

There is intentionally no audit nor sysctl configuration to re-enable
these logless domains.  This is delegated to the user space program.

Increment the Landlock ABI version to reflect this interface change.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Closes: https://github.com/landlock-lsm/linux/issues/3
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-20-mic@digikod.net
---

Changes since v2:
- Update ABI version test.
---
 Documentation/userspace-api/landlock.rst     |  2 +-
 include/uapi/linux/landlock.h                | 14 +++++++++++
 security/landlock/audit.c                    | 13 ++++++----
 security/landlock/domain.h                   |  1 +
 security/landlock/syscalls.c                 | 25 ++++++++++++++++----
 tools/testing/selftests/landlock/base_test.c |  2 +-
 6 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index d639c61cb472..bd0696e2ea41 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: October 2024
+:Date: November 2024
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 33745642f787..3b31d373ef74 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -62,6 +62,20 @@ struct landlock_ruleset_attr {
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
 /* clang-format on */
 
+/*
+ * sys_landlock_restrict_self() flags:
+ *
+ * - %LANDLOCK_RESTRICT_SELF_LOGLESS: Do not create any log related to the
+ *   enforced restrictions.  This should only be set by tools launching unknown
+ *   or untrusted programs (e.g. a sandbox tool, container runtime, system
+ *   service manager).  Because programs sandboxing themselves should fix any
+ *   denied access, they should not set this flag to be aware of potential
+ *   issues reported by system's logs (i.e. audit).
+ */
+/* clang-format off */
+#define LANDLOCK_RESTRICT_SELF_LOGLESS			(1U << 0)
+/* clang-format on */
+
 /**
  * enum landlock_rule_type - Landlock rule type
  *
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 7e4acc746cd6..d299baedd4e4 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -404,11 +404,6 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 	if (!audit_enabled)
 		return;
 
-	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
-			     AUDIT_LANDLOCK_DENY);
-	if (!ab)
-		return;
-
 	missing = request->access;
 	if (missing) {
 		size_t youngest_layer;
@@ -429,6 +424,14 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
 			get_hierarchy(domain, request->layer_plus_one - 1);
 	}
 
+	if (READ_ONCE(youngest_denied->log_status) == LANDLOCK_LOG_DISABLED)
+		return;
+
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_LANDLOCK_DENY);
+	if (!ab)
+		return;
+
 	audit_log_format(ab, "domain=%llx blockers=", youngest_denied->id);
 	log_blockers(ab, request->type, missing);
 	audit_log_lsm_data(ab, &request->audit);
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index ffc8b1bb58be..fe4b2de734d2 100644
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
index 335067e36feb..48c26ed8c099 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -151,7 +151,12 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 6
+/*
+ * The Landlock ABI version should be incremented for each new Landlock-related
+ * user space visible change (e.g. Landlock syscalls).  Only increment this
+ * version once per Linux release.
+ */
+#define LANDLOCK_ABI_VERSION 7
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -452,7 +457,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * sys_landlock_restrict_self - Enforce a ruleset on the calling thread
  *
  * @ruleset_fd: File descriptor tied to the ruleset to merge with the target.
- * @flags: Must be 0.
+ * @flags: Supported value: %LANDLOCK_RESTRICT_SELF_LOGLESS.
  *
  * This system call enables to enforce a Landlock ruleset on the current
  * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
@@ -478,6 +483,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
 	int err;
+	bool is_logless = false;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -490,9 +496,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
-	/* No flag for now. */
-	if (flags)
-		return -EINVAL;
+	if (flags) {
+		if (flags == LANDLOCK_RESTRICT_SELF_LOGLESS)
+			is_logless = true;
+		else
+			return -EINVAL;
+	}
 
 	/* Gets and checks the ruleset. */
 	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
@@ -517,6 +526,12 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		goto out_put_creds;
 	}
 
+	if (is_logless) {
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
2.47.0

