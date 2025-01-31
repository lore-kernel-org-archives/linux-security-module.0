Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7F1F427D
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341118; cv=none; b=sqOcu1PvMoLZnayH6sTvlNKy3uoJEMtD/n7lCLwV9ofeOZ8q9A6DwHnDxu3R+LGnLiys//O3YyAfOckhGBT7LGwBrhmAHmvXdKRQ+Gz+w+EvPpeEHsIOKXxtP/T+vGWI/bq41VKucfd5iV+JFOPV2f9wkC4d5qKyuBns6k2a11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341118; c=relaxed/simple;
	bh=+fs19RxHDY9BcPZaT/XWEnJNwOv9Ua5qt6WhBFmKl4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBpiZn/iDwNhKuiPPftfvcwSxPbUoAlNAhoAmuxyFSGLewo8MCBoqYQfEK4X4+5+9Zj6ebV6YYPzka5JE++xzKSLbF6oYFmQLA33RUIqR6ECPXcpiOhXVFuJ7fHrShFIUOSyV1cJIXyFFnRRmcU0bSwlST2CwgQbaf+6oTcKHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CYgXw5ju; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CYgXw5ju"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl1cg62sJz8pY;
	Fri, 31 Jan 2025 17:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738341107;
	bh=oGikm6VLwWrg3neWSB4X0njEV2kkEM+uqBJC5CDHF0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYgXw5ju33kO13Y+DggkiP5NpHMGoL9UkeIVur6ud7qSULo83mN7kpcgmhLcwaGZY
	 6gSvYJ9ysw3eH0k6vRQKAe7SrBRlI4F5ct1oXOijnOjkaBbqQOeBps4MqUMSXkH7y8
	 IbO1ZqwScS1DJBuaFG3zG+rbv+zdku0mz5xb+fSA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl1cf5kplzZJX;
	Fri, 31 Jan 2025 17:31:46 +0100 (CET)
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
Subject: [PATCH v5 17/24] landlock: Add LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
Date: Fri, 31 Jan 2025 17:30:52 +0100
Message-ID: <20250131163059.1139617-18-mic@digikod.net>
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

Add LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS for the case of sandboxer
tools, init systems, or runtime containers launching programs sandboxing
themselves in an inconsistent way.  Setting this flag should only
depends on runtime configuration (i.e. not hardcoded).

We don't create a new ruleset's option because this should not be part
of the security policy: only the task that enforces the policy (not the
one that create it) knows if itself or its children may request denied
actions.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250131163059.1139617-18-mic@digikod.net
---

Using "mute" instead of "quiet" might be more appropriate.

Changes since v4:
- New patch.
---
 include/uapi/linux/landlock.h | 11 +++++++++++
 security/landlock/domain.c    |  1 +
 security/landlock/domain.h    |  5 +++++
 security/landlock/limits.h    |  2 +-
 security/landlock/syscalls.c  | 14 +++++++++++---
 5 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b7f78abd6ddd..d810fd9e17c6 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -71,9 +71,20 @@ struct landlock_ruleset_attr {
  *   service manager).  Because programs sandboxing themselves should fix any
  *   denied access, they should not set this flag to be aware of potential
  *   issues reported by system's logs (i.e. audit).
+ * - %LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS: Do not create any log related
+ *   to the enforced restrictions coming from descendant domains.  This should
+ *   only be set according to a runtime configuration (i.e. not hardcoded) by
+ *   programs launching other unknown or untrusted programs that may create
+ *   their own Landlock domains and spam logs.  The main use case is for
+ *   container runtimes to enable users to mute buggy sandboxed programs for a
+ *   specific container image.  Other use cases include sandboxer tools and
+ *   init systems.  Unlike %LANDLOCK_RESTRICT_SELF_QUIET,
+ *   %LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS does not impact the requested
+ *   restriction but only the potential descendant domains.
  */
 /* clang-format off */
 #define LANDLOCK_RESTRICT_SELF_QUIET			(1U << 0)
+#define LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS		(1U << 1)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 6704e9283206..eff7c774bf06 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -127,6 +127,7 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 	hierarchy->details = details;
 	hierarchy->id = landlock_get_id_range(1);
 	hierarchy->log_status = LANDLOCK_LOG_PENDING;
+	hierarchy->quiet_subdomains = false;
 	atomic64_set(&hierarchy->num_denials, 0);
 	return 0;
 }
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 25be0a18da1f..8979cf00f8be 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -104,6 +104,11 @@ struct landlock_hierarchy {
 	 * @details: Information about the related domain.
 	 */
 	const struct landlock_details *details;
+	/**
+	 * @quiet_subdomains: Set if the domain descendants's log_status
+	 * should be set to %LANDLOCK_LOG_DISABLED.
+	 */
+	u32 quiet_subdomains : 1;
 #endif /* CONFIG_AUDIT */
 };
 
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 2a5e9f3ee750..48aa75c98665 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -30,7 +30,7 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
-#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_QUIET
+#define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
 /* clang-format on */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 5c6abcd6d604..f44f4f884499 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -440,6 +440,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
  * @flags: Supported values:
  *
  * - %LANDLOCK_RESTRICT_SELF_QUIET
+ * - %LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS
  *
  * This system call enables to enforce a Landlock ruleset on the current
  * thread.  Enforcing a ruleset requires that the task has %CAP_SYS_ADMIN in its
@@ -465,7 +466,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		*ruleset __free(landlock_put_ruleset) = NULL;
 	struct cred *new_cred;
 	struct landlock_cred_security *new_llcred;
-	bool is_quiet;
+	bool is_quiet, is_quiet_subdomains,
+		__maybe_unused inherits_quiet_subdomains;
 
 	if (!is_initialized())
 		return -EOPNOTSUPP;
@@ -483,6 +485,8 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		return -EINVAL;
 
 	is_quiet = !!(flags & LANDLOCK_RESTRICT_SELF_QUIET);
+	is_quiet_subdomains =
+		!!(flags & LANDLOCK_RESTRICT_SELF_QUIET_SUBDOMAINS);
 
 	/* Gets and checks the ruleset. */
 	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
@@ -506,11 +510,15 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		return PTR_ERR(new_dom);
 	}
 
-	if (is_quiet) {
 #ifdef CONFIG_AUDIT
+	inherits_quiet_subdomains =
+		new_llcred->domain &&
+		new_llcred->domain->hierarchy->quiet_subdomains;
+	new_dom->hierarchy->quiet_subdomains = is_quiet_subdomains ||
+					       inherits_quiet_subdomains;
+	if (is_quiet || inherits_quiet_subdomains)
 		new_dom->hierarchy->log_status = LANDLOCK_LOG_DISABLED;
 #endif /* CONFIG_AUDIT */
-	}
 
 	/* Replaces the old (prepared) domain. */
 	landlock_put_ruleset(new_llcred->domain);
-- 
2.48.1

