Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186A1C2301
	for <linux-security-module@vger.kernel.org>; Tue, 22 Oct 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613447; cv=none; b=WwhgRIPM8x4nmWfkUJjM+Essry7FVe14VfPE/uyxOweUeao0SMLeGbNDD5OAoIWHuIpBgDyOuY4QiTJSG4vu708ie8HDklpanogM7Kjuhs0FTZZUCQS37pyYckXWATsXb/powCIpPY8yVu8WiLCalPOVu1TzWAM1hyXANVB+yb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613447; c=relaxed/simple;
	bh=kZv6/PhbP7J5pxayWAbXtkpzTHCgWjbVAn3a0JLUYh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVtazp0J2ju5vHntU0TcObY0r+K8r0JRl/k1ro2DNeAKSSJy8zRAW/qtsIX5g4jPseWI9cHt+qTSl4Qy48cmRtkW5/AKKFOuySjHOEl6v25Y8IMHBZ/gVDxX+W9sXl8hBzvwWGOei8PBAmElTxcEuq7eieBMKMeFO8DR1+7yHkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LUmlfbTo; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LUmlfbTo"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXxwt506Jz1BWm;
	Tue, 22 Oct 2024 18:10:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729613438;
	bh=3Ve6yuPT5FwORVe2zeYvy54uPJqtXG32ke83iyO8jcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUmlfbTo2grw9nX/t2dsQYzcviD+2TyFUuzcDqdASyu6vIZVhlAM5Ju1N5WudaSFe
	 MD59m4YToB0gEFIIsojq5z2GPVeHYIU3fZfuREneW9KtPLMRre3V+G7rutNg4UXZQV
	 gIU0RPDR3UvCA+rjpAH52nx28mGOy26ODe3AoORY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXxws6v0Sz6Tk;
	Tue, 22 Oct 2024 18:10:37 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v2 14/14] landlock: Control log events with LANDLOCK_RESTRICT_SELF_LOGLESS
Date: Tue, 22 Oct 2024 18:10:09 +0200
Message-ID: <20241022161009.982584-15-mic@digikod.net>
In-Reply-To: <20241022161009.982584-1-mic@digikod.net>
References: <20241022161009.982584-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20241022161009.982584-15-mic@digikod.net
---

We could export and use audit_filter() to avoid computing the youngest
denied layer, but I'm not sure it's worth it.

We need to patch the samples/landlock/sandboxer to use
LANDLOCK_RESTRICT_SELF_LOGLESS because it is a sandboxer, but at the
same time it is useful to test this patch series without this flag.
---
 include/uapi/linux/landlock.h | 14 ++++++++++++++
 security/landlock/audit.c     | 13 ++++++++-----
 security/landlock/domain.h    |  1 +
 security/landlock/syscalls.c  | 25 ++++++++++++++++++++-----
 4 files changed, 43 insertions(+), 10 deletions(-)

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
index b551812b8bc9..9235590997d7 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -401,11 +401,6 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
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
@@ -426,6 +421,14 @@ void landlock_log_denial(const struct landlock_ruleset *const domain,
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
 	audit_log_format(ab, "domain=%llu blockers=", youngest_denied->id);
 	log_blockers(ab, request->type, missing);
 	audit_log_lsm_data(ab, &request->audit);
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 1374497d9a9b..765d5689fbb0 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -22,6 +22,7 @@
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
-- 
2.47.0

