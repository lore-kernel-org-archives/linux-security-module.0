Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFDC382F2A
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486262; cv=none; b=sp490YFShKa56IY6zQDm7iWj7XPZWKfARemwhlaY74WCVxcuOwmiwrHmmsMToFRt6/t/rpH4VpxM0XY5+GIyfWsNNCBMF6qqkR9iyscX73rOuCpxZZTWJtJ5Nn1dSHCvkhlgd5Zbx5nP2L8y3HM8F04dW/Adp3mbH72q7dfcKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486262; c=relaxed/simple;
	bh=s/Dk9CptvcNlVVsgmsW0YTGJ3SXhUsiVmGzskcg4M70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpUbaQRzAPOgS93Ykgx/SMx0+zTyhkeDVRFewmt4MtxVGTt7nX6kcfIeIRmTKkeJ5jZb0fX1P34ozWlgkjwudHGsTJBay1nUiXKX8TwSKjLhVH9xQw808V0fwo/jjgYpzbz/R8pxuY8m8fQcq5dD5a7nP0W4zACMqG4Dcur9Qco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uHJ0Z6CG; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uHJ0Z6CG"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkL5MyQzwnV;
	Mon,  6 Apr 2026 16:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486250;
	bh=QQNmoNiDeAFSnkI6B8WCd6INkz20gs9/om446+zAPXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHJ0Z6CG9g1VfkaV3jv0kvrEZu/cmkuCj/rJpS75wwBkorstjtIh8l12T1eN0OhqZ
	 EDUhGjiFp51iTjTysgeDRgdZVkr7rBvqAnHFiqXLHcTaxuqbeZpRngnrW/Ej3ykJeY
	 JME5OnckX1xRM+f6BtkqQnqydoV0af/7N/RCvFUA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkL1LVqzhjJ;
	Mon,  6 Apr 2026 16:37:30 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 04/17] landlock: Split denial logging from audit into common framework
Date: Mon,  6 Apr 2026 16:37:02 +0200
Message-ID: <20260406143717.1815792-5-mic@digikod.net>
In-Reply-To: <20260406143717.1815792-1-mic@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Tracepoint emission requires the denial framework (layer identification,
request validation) without depending on CONFIG_AUDIT.  Separate the
denial logging infrastructure from the audit-specific code by
introducing a common log framework.

Create CONFIG_SECURITY_LANDLOCK_LOG, automatically selected when either
CONFIG_AUDIT or CONFIG_TRACEPOINTS is enabled.  The CONFIG_TRACEPOINTS
dependency is added proactively alongside the audit-to-log
generalization; a following commit adds the first tracepoint consumer.

Rename audit.c to log.c and create log.h with the request types and
struct landlock_request moved from audit.h.  Rename the
landlock_log_drop_domain() function to landlock_log_free_domain() to
match the landlock_free_domain tracepoint introduced in a following
commit.

The landlock_log_denial() declaration in log.h remains under
CONFIG_AUDIT in this patch; the guard is widened to
CONFIG_SECURITY_LANDLOCK_LOG in a following commit that adds the first
tracepoint consumer.

Move id.o from CONFIG_AUDIT to CONFIG_SECURITY_LANDLOCK_LOG so that
domain and ruleset IDs are available for tracing without audit support.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 security/landlock/Kconfig            |  5 ++
 security/landlock/Makefile           |  6 +-
 security/landlock/cred.h             |  8 ++-
 security/landlock/domain.c           |  6 +-
 security/landlock/domain.h           | 16 +++--
 security/landlock/fs.c               | 11 ++--
 security/landlock/{audit.c => log.c} | 88 +++++++++++++++++-----------
 security/landlock/{audit.h => log.h} | 12 ++--
 security/landlock/net.c              |  2 +-
 security/landlock/task.c             |  2 +-
 10 files changed, 96 insertions(+), 60 deletions(-)
 rename security/landlock/{audit.c => log.c} (95%)
 rename security/landlock/{audit.h => log.h} (86%)

diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
index 3f1493402052..7aeac29160e8 100644
--- a/security/landlock/Kconfig
+++ b/security/landlock/Kconfig
@@ -21,6 +21,11 @@ config SECURITY_LANDLOCK
 	  you should also prepend "landlock," to the content of CONFIG_LSM to
 	  enable Landlock at boot time.
 
+config SECURITY_LANDLOCK_LOG
+	bool
+	depends on SECURITY_LANDLOCK
+	default y if AUDIT || TRACEPOINTS
+
 config SECURITY_LANDLOCK_KUNIT_TEST
 	bool "KUnit tests for Landlock" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 23e13644916f..101440da7bcd 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -13,6 +13,6 @@ landlock-y := \
 
 landlock-$(CONFIG_INET) += net.o
 
-landlock-$(CONFIG_AUDIT) += \
-	id.o \
-	audit.o
+landlock-$(CONFIG_SECURITY_LANDLOCK_LOG) += \
+	log.o \
+	id.o
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index c42b0d3ecec8..38299db6efa2 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -36,13 +36,15 @@ struct landlock_cred_security {
 	 */
 	struct landlock_domain *domain;
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	/**
 	 * @domain_exec: Bitmask identifying the domain layers that were enforced by
 	 * the current task's executed file (i.e. no new execve(2) since
 	 * landlock_restrict_self(2)).
 	 */
 	u16 domain_exec;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+#ifdef CONFIG_AUDIT
 	/**
 	 * @log_subdomains_off: Set if the domain descendants's log_status should be
 	 * set to %LANDLOCK_LOG_DISABLED.  This is not a landlock_hierarchy
@@ -53,14 +55,14 @@ struct landlock_cred_security {
 #endif /* CONFIG_AUDIT */
 } __packed;
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 
 /* Makes sure all layer executions can be stored. */
 static_assert(BITS_PER_TYPE(typeof_member(struct landlock_cred_security,
 					  domain_exec)) >=
 	      LANDLOCK_MAX_NUM_LAYERS);
 
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 static inline struct landlock_cred_security *
 landlock_cred(const struct cred *cred)
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 317fd94d3ccd..0dfd53ae9dd7 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -451,7 +451,7 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
 	return no_free_ptr(new_dom);
 }
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 
 /**
  * get_current_exe - Get the current's executable path, if any
@@ -561,6 +561,10 @@ int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
 	return 0;
 }
 
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+
+#ifdef CONFIG_AUDIT
+
 static deny_masks_t
 get_layer_deny_mask(const access_mask_t all_existing_optional_access,
 		    const unsigned long access_bit, const size_t layer)
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index df11cb7d4f2b..56f54efb65d1 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -21,7 +21,7 @@
 #include <linux/workqueue.h>
 
 #include "access.h"
-#include "audit.h"
+#include "log.h"
 #include "ruleset.h"
 
 enum landlock_log_status {
@@ -87,7 +87,7 @@ struct landlock_hierarchy {
 	 */
 	refcount_t usage;
 
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	/**
 	 * @log_status: Whether this domain should be logged or not.  Because
 	 * concurrent log entries may be created at the same time, it is still
@@ -117,7 +117,7 @@ struct landlock_hierarchy {
 		 * %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON.  Set to false by default.
 		 */
 		log_new_exec : 1;
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 };
 
 #ifdef CONFIG_AUDIT
@@ -127,6 +127,10 @@ landlock_get_deny_masks(const access_mask_t all_existing_optional_access,
 			const access_mask_t optional_access,
 			const struct layer_access_masks *const masks);
 
+#endif /* CONFIG_AUDIT */
+
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+
 int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy);
 
 static inline void
@@ -139,7 +143,7 @@ landlock_free_hierarchy_details(struct landlock_hierarchy *const hierarchy)
 	kfree(hierarchy->details);
 }
 
-#else /* CONFIG_AUDIT */
+#else /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 static inline int
 landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
@@ -152,7 +156,7 @@ landlock_free_hierarchy_details(struct landlock_hierarchy *const hierarchy)
 {
 }
 
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 static inline void
 landlock_get_hierarchy(struct landlock_hierarchy *const hierarchy)
@@ -166,7 +170,7 @@ static inline void landlock_put_hierarchy(struct landlock_hierarchy *hierarchy)
 	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
 		const struct landlock_hierarchy *const freeme = hierarchy;
 
-		landlock_log_drop_domain(hierarchy);
+		landlock_log_free_domain(hierarchy);
 		landlock_free_hierarchy_details(hierarchy);
 		hierarchy = hierarchy->parent;
 		kfree(freeme);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 3ef453fc14a6..a0b4d0dd261f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -42,12 +42,12 @@
 #include <uapi/linux/landlock.h>
 
 #include "access.h"
-#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
 #include "fs.h"
 #include "limits.h"
+#include "log.h"
 #include "object.h"
 #include "ruleset.h"
 #include "setup.h"
@@ -918,10 +918,11 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 	path_put(&walker_path);
 
 	/*
-	 * Check CONFIG_AUDIT to enable elision of log_request_parent* and
-	 * associated caller's stack variables thanks to dead code elimination.
+	 * Check CONFIG_SECURITY_LANDLOCK_LOG to enable elision of
+	 * log_request_parent* and associated caller's stack variables thanks to
+	 * dead code elimination.
 	 */
-#ifdef CONFIG_AUDIT
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	if (!allowed_parent1 && log_request_parent1) {
 		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
 		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH;
@@ -937,7 +938,7 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 		log_request_parent2->access = access_masked_parent2;
 		log_request_parent2->layer_masks = layer_masks_parent2;
 	}
-#endif /* CONFIG_AUDIT */
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	return allowed_parent1 && allowed_parent2;
 }
diff --git a/security/landlock/audit.c b/security/landlock/log.c
similarity index 95%
rename from security/landlock/audit.c
rename to security/landlock/log.c
index 75438b3cc887..c9b506707af0 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/log.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Landlock - Audit helpers
+ * Landlock - Log helpers
  *
  * Copyright © 2023-2025 Microsoft Corporation
  */
@@ -13,12 +13,13 @@
 #include <uapi/linux/landlock.h>
 
 #include "access.h"
-#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
 #include "limits.h"
+#include "log.h"
 #include "ruleset.h"
+#ifdef CONFIG_AUDIT
 
 static const char *const fs_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = "fs.execute",
@@ -134,6 +135,45 @@ static void log_domain(struct landlock_hierarchy *const hierarchy)
 	WRITE_ONCE(hierarchy->log_status, LANDLOCK_LOG_RECORDED);
 }
 
+static void audit_denial(const struct landlock_cred_security *const subject,
+			 const struct landlock_request *const request,
+			 struct landlock_hierarchy *const youngest_denied,
+			 const size_t youngest_layer,
+			 const access_mask_t missing)
+{
+	struct audit_buffer *ab;
+
+	if (!audit_enabled)
+		return;
+
+	/* Checks if the current exec was restricting itself. */
+	if (subject->domain_exec & BIT(youngest_layer)) {
+		/* Ignores denials for the same execution. */
+		if (!youngest_denied->log_same_exec)
+			return;
+	} else {
+		/* Ignores denials after a new execution. */
+		if (!youngest_denied->log_new_exec)
+			return;
+	}
+
+	/* Uses consistent allocation flags wrt common_lsm_audit(). */
+	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
+			     AUDIT_LANDLOCK_ACCESS);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "domain=%llx blockers=", youngest_denied->id);
+	log_blockers(ab, request->type, missing);
+	audit_log_lsm_data(ab, &request->audit);
+	audit_log_end(ab);
+
+	/* Logs this domain the first time it shows in log. */
+	log_domain(youngest_denied);
+}
+
+#endif /* CONFIG_AUDIT */
+
 static struct landlock_hierarchy *
 get_hierarchy(const struct landlock_domain *const domain, const size_t layer)
 {
@@ -352,7 +392,7 @@ static bool is_valid_request(const struct landlock_request *const request)
 }
 
 /**
- * landlock_log_denial - Create audit records related to a denial
+ * landlock_log_denial - Log a denied access
  *
  * @subject: The Landlock subject's credential denying an action.
  * @request: Detail of the user space request.
@@ -360,7 +400,6 @@ static bool is_valid_request(const struct landlock_request *const request)
 void landlock_log_denial(const struct landlock_cred_security *const subject,
 			 const struct landlock_request *const request)
 {
-	struct audit_buffer *ab;
 	struct landlock_hierarchy *youngest_denied;
 	size_t youngest_layer;
 	access_mask_t missing;
@@ -403,37 +442,16 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	 */
 	atomic64_inc(&youngest_denied->num_denials);
 
-	if (!audit_enabled)
-		return;
-
-	/* Checks if the current exec was restricting itself. */
-	if (subject->domain_exec & BIT(youngest_layer)) {
-		/* Ignores denials for the same execution. */
-		if (!youngest_denied->log_same_exec)
-			return;
-	} else {
-		/* Ignores denials after a new execution. */
-		if (!youngest_denied->log_new_exec)
-			return;
-	}
-
-	/* Uses consistent allocation flags wrt common_lsm_audit(). */
-	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
-			     AUDIT_LANDLOCK_ACCESS);
-	if (!ab)
-		return;
-
-	audit_log_format(ab, "domain=%llx blockers=", youngest_denied->id);
-	log_blockers(ab, request->type, missing);
-	audit_log_lsm_data(ab, &request->audit);
-	audit_log_end(ab);
-
-	/* Logs this domain the first time it shows in log. */
-	log_domain(youngest_denied);
+#ifdef CONFIG_AUDIT
+	audit_denial(subject, request, youngest_denied, youngest_layer,
+		     missing);
+#endif /* CONFIG_AUDIT */
 }
 
+#ifdef CONFIG_AUDIT
+
 /**
- * landlock_log_drop_domain - Create an audit record on domain deallocation
+ * landlock_log_free_domain - Create an audit record on domain deallocation
  *
  * @hierarchy: The domain's hierarchy being deallocated.
  *
@@ -443,7 +461,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
  * Called in a work queue scheduled by landlock_put_domain_deferred() called by
  * hook_cred_free().
  */
-void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
+void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
 {
 	struct audit_buffer *ab;
 
@@ -471,6 +489,8 @@ void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
 	audit_log_end(ab);
 }
 
+#endif /* CONFIG_AUDIT */
+
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
 
 static struct kunit_case test_cases[] = {
@@ -483,7 +503,7 @@ static struct kunit_case test_cases[] = {
 };
 
 static struct kunit_suite test_suite = {
-	.name = "landlock_audit",
+	.name = "landlock_log",
 	.test_cases = test_cases,
 };
 
diff --git a/security/landlock/audit.h b/security/landlock/log.h
similarity index 86%
rename from security/landlock/audit.h
rename to security/landlock/log.h
index 50452a791656..4370fff86e45 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/log.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Landlock - Audit helpers
+ * Landlock - Log helpers
  *
  * Copyright © 2023-2025 Microsoft Corporation
  */
 
-#ifndef _SECURITY_LANDLOCK_AUDIT_H
-#define _SECURITY_LANDLOCK_AUDIT_H
+#ifndef _SECURITY_LANDLOCK_LOG_H
+#define _SECURITY_LANDLOCK_LOG_H
 
 #include <linux/audit.h>
 #include <linux/lsm_audit.h>
@@ -54,7 +54,7 @@ struct landlock_request {
 
 #ifdef CONFIG_AUDIT
 
-void landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy);
+void landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy);
 
 void landlock_log_denial(const struct landlock_cred_security *const subject,
 			 const struct landlock_request *const request);
@@ -62,7 +62,7 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 #else /* CONFIG_AUDIT */
 
 static inline void
-landlock_log_drop_domain(const struct landlock_hierarchy *const hierarchy)
+landlock_log_free_domain(const struct landlock_hierarchy *const hierarchy)
 {
 }
 
@@ -74,4 +74,4 @@ landlock_log_denial(const struct landlock_cred_security *const subject,
 
 #endif /* CONFIG_AUDIT */
 
-#endif /* _SECURITY_LANDLOCK_AUDIT_H */
+#endif /* _SECURITY_LANDLOCK_LOG_H */
diff --git a/security/landlock/net.c b/security/landlock/net.c
index de108b3277bc..63f1fe0ec876 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -12,11 +12,11 @@
 #include <linux/socket.h>
 #include <net/ipv6.h>
 
-#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
 #include "limits.h"
+#include "log.h"
 #include "net.h"
 #include "ruleset.h"
 
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 2e7ee62958b2..5bfbbe6107ce 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -20,11 +20,11 @@
 #include <net/af_unix.h>
 #include <net/sock.h>
 
-#include "audit.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
 #include "fs.h"
+#include "log.h"
 #include "ruleset.h"
 #include "setup.h"
 #include "task.h"
-- 
2.53.0

