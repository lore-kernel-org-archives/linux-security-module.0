Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE21F429E
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341119; cv=none; b=R9OEF0k/ydIba6uRLkk3YrwuibxawNKf0D3MrlbEqdPX0C6fTMSzaN7sIgM8zr8RB7s1jGUp1Bpko0nAV48uaSTyrEHXVLNYZqk9t/6EOokcPJFtNDAixu+IByfinCW+PcSimsA5pSzRZlNj0mM5fYcn6SjwpHHofeSeOKCBPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341119; c=relaxed/simple;
	bh=mv5Gdjad35VV3KqWsOcXEsadzPSqjeh/dQd2NSERL6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzsqM8lOCWW6b4Q2UiOUq8FQDEz7mVFa4OB1WrWy95zKnF7cS+Zwe7wX0YsNL2AWwTu1xW0GzZLFd//XsO4Ln6iliovAfyRSoC86i6RA7Wq1HqFZVfshgWrjN80JT32ROLoo4enYwXKrws2Ch1wr9Xx11TDBacyDaS20jMYNGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PjeQfXhd; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PjeQfXhd"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cj6MvVz8mq;
	Fri, 31 Jan 2025 17:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341109;
	bh=pokLVnEiSKyEkwT9mkFC0PnPjpd14C+MYdH57DSzthQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjeQfXhdOL+ZG3tvuq9i9lc/jmglWjT9ClIUeDCBKos7gc36EpfYHNy4ebq0TxNPt
	 axVRhGGlIYt9EmqDcpkxmVH8IkDqBMpBKcr4WDdI+or6CP1WqmeiGGB8a3CdVjP7h0
	 +kbQWygAsA8jR1ll2cl64+14hu8DFvnzjLBeFEqM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1cj091nzYHg;
	Fri, 31 Jan 2025 17:31:49 +0100 (CET)
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
Subject: [PATCH v5 18/24] landlock: Add LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC
Date: Fri, 31 Jan 2025 17:30:53 +0100
Message-ID: <20250131163059.1139617-19-mic@digikod.net>
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

Log denied access for processes resulting from an execve(2), which is
not the case by default.

The rationale is that a program should know its own behavior, but not
necessarily the behavior of other programs.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-19-mic@digikod.net
---

Changes since v4:
- New patch to replace the now-removed Landlock-specific audit rule
  types.
---
 include/uapi/linux/landlock.h |  6 ++++++
 security/landlock/audit.c     |  3 ++-
 security/landlock/domain.c    |  1 +
 security/landlock/domain.h    |  8 +++++++-
 security/landlock/limits.h    |  2 +-
 security/landlock/syscalls.c  | 10 +++++++++-
 6 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index d810fd9e17c6..65a9340b9c0e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -81,10 +81,16 @@ struct landlock_ruleset_attr {
  *   init systems.  Unlike %LANDLOCK_RESTRICT_SELF_QUIET,
  *   %LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS does not impact the requested
  *   restriction but only the potential descendant domains.
+ * - %LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC: Explicitly ask to continue logging
+ *   denied access requests even after an :manpage:`execve(2)` call.  This flag
+ *   should only be set if all the programs than can legitimately be executed
+ *   will not try to request a denied access (which could spam audit logs).
+ *   This flag is incompatible with %LANDLOCK_RESTRICT_SELF_QUIET.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_QUIET			(1U << 0)
 #define LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS		(1U << 1)
+#define LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC		(1U << 2)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index beebe45a47e6..6e1de850a5b4 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -434,7 +434,8 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	atomic64_inc(&youngest_denied->num_denials);
 
 	/* Ignores denials after an execution. */
-	if (!(subject->domain_exec & (1 << youngest_layer)))
+	if (!(subject->domain_exec & (1 << youngest_layer)) &&
+	    !youngest_denied->log_cross_exec)
 		return;
 
 	if (!unlikely(audit_context() && audit_enabled))
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index eff7c774bf06..49ccb0f72e53 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -128,6 +128,7 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 	hierarchy->id = landlock_get_id_range(1);
 	hierarchy->log_status = LANDLOCK_LOG_PENDING;
 	hierarchy->quiet_subdomains = false;
+	hierarchy->log_cross_exec = false;
 	atomic64_set(&hierarchy->num_denials, 0);
 	return 0;
 }
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 8979cf00f8be..06b213aa7579 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -108,7 +108,13 @@ struct landlock_hierarchy {
 	 * @quiet_subdomains: Set if the domain descendants's log_status
 	 * should be set to %LANDLOCK_LOG_DISABLED.
 	 */
-	u32 quiet_subdomains : 1;
+	u32 quiet_subdomains : 1,
+		/**
+		 * @log_cross_exec: Set if the domain is configured with
+		 * %LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC to log denials across
+		 * child executions.
+		 */
+		log_cross_exec : 1;
 #endif /* CONFIG_AUDIT */
 };
 
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 48aa75c98665..d9b70d9259c0 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -30,7 +30,7 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
-#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
 /* clang-format on */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index f44f4f884499..5709a53c4a09 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -441,6 +441,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  *
  * - %LANDLOCK_RESTRICT_SELF_QUIET
  * - %LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
+ * - %LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC
  *
  * This system call enables to enforce a Landlock ruleset on the current
  * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
@@ -451,6 +452,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - %EINVAL: @flags contains an unknown bit.
+ * - %EINVAL: @flags contains %LANDLOCK_RESTRICT_SELF_QUIET and
+ *   %LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC, which are incompatible.
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor;
  * - %EPERM: @ruleset_fd has no read access to the underlying ruleset, or the
@@ -467,7 +470,7 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
 	bool is_quiet, is_quiet_subdomains,
-		__maybe_unused inherits_quiet_subdomains;
+		__maybe_unused inherits_quiet_subdomains, is_log_cross_exec;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -487,6 +490,9 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	is_quiet = !!(flags & LANDLOCK_RESTRICT_SELF_QUIET);
 	is_quiet_subdomains =
 		!!(flags & LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS);
+	is_log_cross_exec = !!(flags & LANDLOCK_RESTRICT_SELF_LOG_CROSS_EXEC);
+	if (is_quiet && is_log_cross_exec)
+		return -EINVAL;
 
 	/* Gets and checks the ruleset. */
 	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
@@ -518,6 +524,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 					       inherits_quiet_subdomains;
 	if (is_quiet || inherits_quiet_subdomains)
 		new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
+
+	new_dom->hierarchy->log_cross_exec = is_log_cross_exec;
 #endif /* CONFIG_AUDIT */
 
 	/* Replaces the old (prepared) domain. */
-- 
2.48.1

