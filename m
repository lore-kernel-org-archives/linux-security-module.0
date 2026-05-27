Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2623C552F
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906112; cv=none; b=schD8QotWRHEDK2qy5vjjpHtfeCgIjOutSA3e6nILzWrypsjXCc4FagpJ1XRvbpfVoRnE+iNbtHq4go/+Cr9Qh63s7O3Al3KuZ8RZLWKgaYnobnwwjgWOaAkllG3SJl+vLAO2dbjmJi4Jccp347Uoq+W+SxrDWTELfnCUYTTctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906112; c=relaxed/simple;
	bh=69nelvqBs9xl3XU3ey+d++mh8hWR3aUOzxld/bX/ywQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpKCa0Yqsdy7psi8smgqn7UQGglHqksVetkD4MCw4/B1sZY7HygYVZ2y+jshOpxBoPCgxOctSLaYqkF27Mwl2KwHcate7HRCL7N+bgSamQsnCpEp1egjsjmQZLtH0VKD6aOSlK6FWgUXWShrcaBPhLvGyZaqfihty2ReG20hamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1oi8iM7x; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1oi8iM7x"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gQd4528kTzYH4;
	Wed, 27 May 2026 20:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779905509;
	bh=TGICSQ0W8VYMSHSqymUjNSPyMy0evYHr1yPIbEeCnZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1oi8iM7xOmi9qW4JKktzdPVFZAmcpbDTzksQ2QNWulQwJnRRi2hS8E0Pz2CS2kESr
	 wR1lgQI8mHyXfOrulvBqXOdWEVkXsoTTCuP6Js4QUfJytB9Onvzo9ZURMx5NnawNvO
	 wPfJ66vihjiaaaYwWAXaQYqvrvf9AhsKwDvvPFDw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gQd443K25zGcK;
	Wed, 27 May 2026 20:11:48 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 5/9] landlock: Enforce capability restrictions
Date: Wed, 27 May 2026 20:11:18 +0200
Message-ID: <20260527181127.879771-6-mic@digikod.net>
In-Reply-To: <20260527181127.879771-1-mic@digikod.net>
References: <20260527181127.879771-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add Landlock enforcement for capability use via the LSM capable hook.
This lets a sandboxed process restrict which Linux capabilities it can
exercise, using LANDLOCK_PERM_CAPABILITY_USE and per-capability rules.

The capable hook is purely restrictive: commoncap is registered with
LSM_ORDER_FIRST so cap_capable() always runs first, which means Landlock
can deny capabilities that commoncap would allow but never grant
capabilities that commoncap denied.

Add hook_capable() that uses landlock_perm_is_denied() to perform a pure
bitmask check: if the capability is not in the layer's allowed set, the
check is denied.  No domain ancestry bypass, no cross-namespace
discriminant, just a flat per-layer allowed-caps bitmask, matching the
same pattern used by LANDLOCK_PERM_NAMESPACE_USE.

Adding the 41-bit capability bitfield to struct perm_masks brings it to
49 out of 64 bits used (41 caps + 8 namespace types, 15 bits padding),
keeping struct layer_config at 16 bytes (8 bytes perm_masks + 4 bytes
access_masks + 4 bytes tail padding) and the layers[] array at 256 bytes
maximum.  The caps bitfield is placed first in struct perm_masks (before
the ns bitfield) because capabilities use a direct BIT_ULL(cap) mapping
that benefits from starting at bit 0 of the storage unit.  An explicit
static_assert documents the LANDLOCK_NUM_PERM_CAP + LANDLOCK_NUM_PERM_NS
<= BITS_PER_TYPE(u64) invariant alongside the existing sizeof guard.

Non-user namespace operations require both LANDLOCK_PERM_NAMESPACE_USE
(type allowed) and LANDLOCK_PERM_CAPABILITY_USE (CAP_SYS_ADMIN allowed)
when both permissions are handled.  This follows naturally from the
kernel calling capable(CAP_SYS_ADMIN) before namespace operations: both
hooks fire independently and audit logs identify which permission was
denied.

The enforcement is purely at exercise time via the capable hook, not by
modifying the credential's capability sets.  Stripping denied
capabilities would give processes an accurate capget(2) view of their
usable capabilities, but no LSM other than commoncap modifies capability
sets; Landlock follows this convention and restricts use without
altering what the process holds.  A sandboxed process inside a user
namespace will see all capabilities via capget(2) but will receive
-EPERM when attempting to use any denied capability.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Reviewed-by: Günther Noack <gnoack@google.com>
Reviewed-by: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-7-mic@digikod.net
- Add Reviewed-by: Tingmao Wang.
- Rename internal struct perm_rules to perm_masks (companion change
  to the preceding commit).
- Rename LANDLOCK_PERM_NAMESPACE_ENTER references to
  LANDLOCK_PERM_NAMESPACE_USE (companion change to the introducing
  commit).
- Rename struct layer_rights to struct layer_config (companion
  change to the introducing commit).
- Clarify in the commit body and hook_capable() kdoc that commoncap
  (not Landlock) is registered with LSM_ORDER_FIRST.
- Surface the empty-check semantics in the
  landlock_capability_attr.capabilities kdoc: a rule that sets only
  bits unknown to the running kernel (above CAP_LAST_CAP) succeeds
  but has no runtime effect.
- Add explicit static_assert that LANDLOCK_NUM_PERM_CAP +
  LANDLOCK_NUM_PERM_NS fits in a u64, complementing the existing
  implicit sizeof guard on struct perm_masks.
- Add Reviewed-by: Günther Noack.
---
 include/uapi/linux/landlock.h |  35 +++++++++
 security/landlock/Makefile    |   3 +-
 security/landlock/access.h    |  18 ++++-
 security/landlock/audit.c     |   4 +
 security/landlock/audit.h     |   1 +
 security/landlock/cap.c       | 141 ++++++++++++++++++++++++++++++++++
 security/landlock/cap.h       |  49 ++++++++++++
 security/landlock/cred.h      |   3 +
 security/landlock/limits.h    |   4 +-
 security/landlock/setup.c     |   2 +
 security/landlock/syscalls.c  |  58 +++++++++++++-
 11 files changed, 309 insertions(+), 9 deletions(-)
 create mode 100644 security/landlock/cap.c
 create mode 100644 security/landlock/cap.h

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 233594482aa5..93fea9f0c5e2 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -168,6 +168,11 @@ enum landlock_rule_type {
 	 * @LANDLOCK_RULE_NAMESPACE: Type of a &struct landlock_namespace_attr .
 	 */
 	LANDLOCK_RULE_NAMESPACE,
+	/**
+	 * @LANDLOCK_RULE_CAPABILITY: Type of a &struct
+	 * landlock_capability_attr .
+	 */
+	LANDLOCK_RULE_CAPABILITY,
 };
 
 /**
@@ -242,6 +247,28 @@ struct landlock_namespace_attr {
 	__u64 namespace_types;
 };
 
+/**
+ * struct landlock_capability_attr - Capability definition
+ *
+ * Argument of sys_landlock_add_rule() with %LANDLOCK_RULE_CAPABILITY.
+ */
+struct landlock_capability_attr {
+	/**
+	 * @allowed_perm: Must be set to %LANDLOCK_PERM_CAPABILITY_USE.
+	 */
+	__u64 allowed_perm;
+	/**
+	 * @capabilities: Bitmask of capabilities (``1ULL << CAP_*``) to allow
+	 * under this rule.  Must be non-zero (otherwise the call returns
+	 * ``-ENOMSG``); the non-zero check runs on the raw input before
+	 * unknown-bit masking, so a rule that sets only bits unknown to the
+	 * running kernel (above ``CAP_LAST_CAP``) succeeds but has no runtime
+	 * effect.  Bits above ``CAP_LAST_CAP`` are silently ignored for forward
+	 * compatibility.
+	 */
+	__u64 capabilities;
+};
+
 /**
  * DOC: fs_access
  *
@@ -488,9 +515,17 @@ struct landlock_namespace_attr {
  *   process in a Landlock domain that handles this permission is denied
  *   from using namespace types that are not explicitly allowed by a
  *   %LANDLOCK_RULE_NAMESPACE rule.
+ * - %LANDLOCK_PERM_CAPABILITY_USE: Restrict the use of specific Linux
+ *   capabilities.  A process in a Landlock domain that handles this
+ *   permission is denied from exercising capabilities that are not
+ *   explicitly allowed by a %LANDLOCK_RULE_CAPABILITY rule.  This hook
+ *   is purely restrictive: it can deny capabilities that the kernel
+ *   would otherwise grant, but it can never grant capabilities that the
+ *   kernel already denied.
  */
 /* clang-format off */
 #define LANDLOCK_PERM_NAMESPACE_USE			(1ULL << 0)
+#define LANDLOCK_PERM_CAPABILITY_USE			(1ULL << 1)
 /* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index cacfba075dec..1927b81fea93 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -9,7 +9,8 @@ landlock-y := \
 	task.o \
 	fs.o \
 	tsync.o \
-	ns.o
+	ns.o \
+	cap.o
 
 landlock-$(CONFIG_INET) += net.o
 
diff --git a/security/landlock/access.h b/security/landlock/access.h
index 42229eea6d7e..28c40f8ad5b5 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -72,6 +72,13 @@ static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
  * storage unit.
  */
 struct perm_masks {
+	/**
+	 * @caps: Allowed capabilities.  Each bit corresponds to a ``CAP_*``
+	 * value (e.g. ``CAP_NET_RAW`` = bit 13).  Bits are stored directly
+	 * (sequential mapping) and masked with ``CAP_VALID_MASK`` at rule-add
+	 * time.
+	 */
+	u64 caps : LANDLOCK_NUM_PERM_CAP;
 	/**
 	 * @ns: Allowed namespace types.  Each bit corresponds to a sequential
 	 * index assigned by the ``_LANDLOCK_NS_*`` enum (derived from
@@ -83,6 +90,9 @@ struct perm_masks {
 } __packed __aligned(sizeof(u64));
 
 static_assert(sizeof(struct perm_masks) == sizeof(u64));
+/* All perm_masks bitfields must fit in a single u64. */
+static_assert(LANDLOCK_NUM_PERM_CAP + LANDLOCK_NUM_PERM_NS <=
+	      BITS_PER_TYPE(u64));
 
 /**
  * struct layer_config - Per-layer access configuration
@@ -91,10 +101,10 @@ static_assert(sizeof(struct perm_masks) == sizeof(u64));
  * This is the element type of the &struct landlock_ruleset.layers FAM.
  *
  * Unlike filesystem and network access rights, which are tracked per-object in
- * red-black trees, namespace types use a flat bitmask because their keyspace is
- * small and bounded (~8 namespace types).  A single rule adds to the allowed
- * set via bitwise OR; at enforcement time each layer is checked directly (no
- * tree lookup needed).
+ * red-black trees, namespace types and capabilities use flat bitmasks because
+ * their keyspaces are small and bounded (~8 namespace types, 41 capabilities).
+ * A single rule adds to the allowed set via bitwise OR; at enforcement time
+ * each layer is checked directly (no tree lookup needed).
  */
 struct layer_config {
 	/**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index eca447ec281d..e7926d464981 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -86,6 +86,10 @@ get_blocker(const enum landlock_request_type type,
 	case LANDLOCK_REQUEST_NAMESPACE:
 		WARN_ON_ONCE(access_bit != -1);
 		return "perm.namespace_use";
+
+	case LANDLOCK_REQUEST_CAPABILITY:
+		WARN_ON_ONCE(access_bit != -1);
+		return "perm.capability_use";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index e9e52fb628f5..fe5d701ea45d 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -22,6 +22,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
 	LANDLOCK_REQUEST_NAMESPACE,
+	LANDLOCK_REQUEST_CAPABILITY,
 };
 
 /*
diff --git a/security/landlock/cap.c b/security/landlock/cap.c
new file mode 100644
index 000000000000..d54bd32297b7
--- /dev/null
+++ b/security/landlock/cap.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - Capability hooks
+ *
+ * Copyright © 2026 Cloudflare
+ */
+
+#include <linux/capability.h>
+#include <linux/cred.h>
+#include <linux/lsm_audit.h>
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/landlock.h>
+
+#include "audit.h"
+#include "cap.h"
+#include "cred.h"
+#include "limits.h"
+#include "ruleset.h"
+#include "setup.h"
+
+static const struct access_masks cap_perm = {
+	.perm = LANDLOCK_PERM_CAPABILITY_USE,
+};
+
+/**
+ * hook_capable - Deny capability use for Landlock-sandboxed processes
+ *
+ * @cred: Credentials being checked.
+ * @ns: User namespace for the capability check.
+ * @cap: Capability number (CAP_*).
+ * @opts: Capability check options.  CAP_OPT_NOAUDIT suppresses audit logging.
+ *
+ * Pure bitmask check: denies the capability if it is not in the layer's allowed
+ * set.  This hook is purely restrictive: commoncap is registered with
+ * LSM_ORDER_FIRST so cap_capable() always runs first, which means Landlock can
+ * deny capabilities that commoncap would allow, but never grant capabilities
+ * that commoncap denied.
+ *
+ * Return: 0 if allowed, -EPERM if capability use is denied.
+ */
+static int hook_capable(const struct cred *cred, struct user_namespace *ns,
+			int cap, unsigned int opts)
+{
+	const struct landlock_cred_security *subject;
+	size_t denied_layer;
+
+	subject = landlock_get_applicable_subject(cred, cap_perm, NULL);
+	if (!subject)
+		return 0;
+
+	denied_layer = landlock_perm_is_denied(subject->domain,
+					       LANDLOCK_PERM_CAPABILITY_USE,
+					       landlock_cap_to_bit(cap));
+	if (!denied_layer)
+		return 0;
+
+	/*
+	 * Respects CAP_OPT_NOAUDIT to suppress audit records for capability
+	 * probes (e.g., ns_capable_noaudit(), has_capability_noaudit()).
+	 */
+	if (!(opts & CAP_OPT_NOAUDIT))
+		landlock_log_denial(subject,
+				    &(struct landlock_request){
+					    .type = LANDLOCK_REQUEST_CAPABILITY,
+					    .audit.type = LSM_AUDIT_DATA_CAP,
+					    .audit.u.cap = cap,
+					    .layer_plus_one = denied_layer,
+				    });
+
+	return -EPERM;
+}
+
+static struct security_hook_list landlock_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(capable, hook_capable),
+};
+
+__init void landlock_add_cap_hooks(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			   &landlock_lsmid);
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+#include <kunit/test.h>
+
+static void test_cap_to_bit(struct kunit *const test)
+{
+	KUNIT_EXPECT_EQ(test, BIT_ULL(0), landlock_cap_to_bit(0));
+	KUNIT_EXPECT_EQ(test, BIT_ULL(CAP_NET_RAW),
+			landlock_cap_to_bit(CAP_NET_RAW));
+	KUNIT_EXPECT_EQ(test, BIT_ULL(CAP_SYS_ADMIN),
+			landlock_cap_to_bit(CAP_SYS_ADMIN));
+	KUNIT_EXPECT_EQ(test, BIT_ULL(CAP_LAST_CAP),
+			landlock_cap_to_bit(CAP_LAST_CAP));
+}
+
+static void test_cap_to_bit_invalid(struct kunit *const test)
+{
+	KUNIT_EXPECT_EQ(test, 0ULL, landlock_cap_to_bit(-1));
+	KUNIT_EXPECT_EQ(test, 0ULL, landlock_cap_to_bit(CAP_LAST_CAP + 1));
+}
+
+static void test_caps_to_bits_valid(struct kunit *const test)
+{
+	KUNIT_EXPECT_EQ(test, (u64)CAP_VALID_MASK,
+			landlock_caps_to_bits(CAP_VALID_MASK));
+	KUNIT_EXPECT_EQ(test, BIT_ULL(CAP_NET_RAW),
+			landlock_caps_to_bits(BIT_ULL(CAP_NET_RAW)));
+}
+
+static void test_caps_to_bits_unknown(struct kunit *const test)
+{
+	KUNIT_EXPECT_EQ(test, 0ULL,
+			landlock_caps_to_bits(BIT_ULL(CAP_LAST_CAP + 1)));
+}
+
+static void test_caps_to_bits_zero(struct kunit *const test)
+{
+	KUNIT_EXPECT_EQ(test, 0ULL, landlock_caps_to_bits(0));
+}
+
+static struct kunit_case test_cases[] = {
+	/* clang-format off */
+	KUNIT_CASE(test_cap_to_bit),
+	KUNIT_CASE(test_cap_to_bit_invalid),
+	KUNIT_CASE(test_caps_to_bits_valid),
+	KUNIT_CASE(test_caps_to_bits_unknown),
+	KUNIT_CASE(test_caps_to_bits_zero),
+	{}
+	/* clang-format on */
+};
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_cap",
+	.test_cases = test_cases,
+};
+
+kunit_test_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
diff --git a/security/landlock/cap.h b/security/landlock/cap.h
new file mode 100644
index 000000000000..67ac3d0c3ad3
--- /dev/null
+++ b/security/landlock/cap.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Capability hooks
+ *
+ * Copyright © 2026 Cloudflare
+ */
+
+#ifndef _SECURITY_LANDLOCK_CAP_H
+#define _SECURITY_LANDLOCK_CAP_H
+
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/capability.h>
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+
+/**
+ * landlock_cap_to_bit - Convert a capability number to a compact bitmask
+ *
+ * @cap: Capability number (CAP_*).
+ *
+ * Return: BIT_ULL(@cap), or 0 if @cap is invalid (with a WARN).
+ */
+static inline __attribute_const__ u64 landlock_cap_to_bit(const int cap)
+{
+	if (WARN_ON_ONCE(!cap_valid(cap)))
+		return 0;
+
+	return BIT_ULL(cap);
+}
+
+/**
+ * landlock_caps_to_bits - Validate and mask a capability bitmask
+ *
+ * @capabilities: Bitmask of capabilities (e.g. from user space).
+ *
+ * Return: @capabilities masked to known capabilities.  Warns if unknown bits
+ * are present (callers must pre-mask for user input).
+ */
+static inline __attribute_const__ u64
+landlock_caps_to_bits(const u64 capabilities)
+{
+	WARN_ON_ONCE(capabilities & ~CAP_VALID_MASK);
+	return capabilities & CAP_VALID_MASK;
+}
+
+__init void landlock_add_cap_hooks(void);
+
+#endif /* _SECURITY_LANDLOCK_CAP_H */
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index 0172345fa86f..d04323a5eb05 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -191,6 +191,9 @@ landlock_perm_is_denied(const struct landlock_ruleset *const domain,
 		case LANDLOCK_PERM_NAMESPACE_USE:
 			allowed = domain->layers[layer].allowed.ns;
 			break;
+		case LANDLOCK_PERM_CAPABILITY_USE:
+			allowed = domain->layers[layer].allowed.caps;
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			return layer + 1;
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index e51122668fd3..01b0b693d0fb 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -11,6 +11,7 @@
 #define _SECURITY_LANDLOCK_LIMITS_H
 
 #include <linux/bitops.h>
+#include <linux/capability.h>
 #include <linux/limits.h>
 #include <linux/ns/ns_common_types.h>
 #include <uapi/linux/landlock.h>
@@ -32,11 +33,12 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
-#define LANDLOCK_LAST_PERM		LANDLOCK_PERM_NAMESPACE_USE
+#define LANDLOCK_LAST_PERM		LANDLOCK_PERM_CAPABILITY_USE
 #define LANDLOCK_MASK_PERM		((LANDLOCK_LAST_PERM << 1) - 1)
 #define LANDLOCK_NUM_PERM		__const_hweight64(LANDLOCK_MASK_PERM)
 
 #define LANDLOCK_NUM_PERM_NS		__const_hweight64((u64)(CLONE_NS_ALL))
+#define LANDLOCK_NUM_PERM_CAP		(CAP_LAST_CAP + 1)
 
 #define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index a7ed776b41b4..971419d663bb 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -11,6 +11,7 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+#include "cap.h"
 #include "common.h"
 #include "cred.h"
 #include "errata.h"
@@ -70,6 +71,7 @@ static int __init landlock_init(void)
 	landlock_add_fs_hooks();
 	landlock_add_net_hooks();
 	landlock_add_ns_hooks();
+	landlock_add_cap_hooks();
 	landlock_init_id();
 	landlock_initialized = true;
 	pr_info("Up and running.\n");
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index b5bbeedc6825..6e99cda3d511 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 #include <uapi/linux/landlock.h>
 
+#include "cap.h"
 #include "cred.h"
 #include "domain.h"
 #include "fs.h"
@@ -98,8 +99,9 @@ static void build_check_abi(void)
 	struct landlock_path_beneath_attr path_beneath_attr;
 	struct landlock_net_port_attr net_port_attr;
 	struct landlock_namespace_attr namespace_attr;
+	struct landlock_capability_attr capability_attr;
 	size_t ruleset_size, path_beneath_size, net_port_size;
-	size_t namespace_size;
+	size_t namespace_size, capability_size;
 
 	/*
 	 * For each user space ABI structures, first checks that there is no
@@ -127,6 +129,11 @@ static void build_check_abi(void)
 	namespace_size += sizeof(namespace_attr.namespace_types);
 	BUILD_BUG_ON(sizeof(namespace_attr) != namespace_size);
 	BUILD_BUG_ON(sizeof(namespace_attr) != 16);
+
+	capability_size = sizeof(capability_attr.allowed_perm);
+	capability_size += sizeof(capability_attr.capabilities);
+	BUILD_BUG_ON(sizeof(capability_attr) != capability_size);
+	BUILD_BUG_ON(sizeof(capability_attr) != 16);
 }
 
 /* Ruleset handling */
@@ -449,14 +456,57 @@ static int add_rule_namespace(struct landlock_ruleset *const ruleset,
 	return 0;
 }
 
+static int add_rule_capability(struct landlock_ruleset *const ruleset,
+			       const void __user *const rule_attr)
+{
+	struct landlock_capability_attr cap_attr;
+	int res;
+	access_mask_t mask;
+
+	/* Copies raw user space buffer. */
+	res = copy_from_user(&cap_attr, rule_attr, sizeof(cap_attr));
+	if (res)
+		return -EFAULT;
+
+	/* Informs about useless rule: empty allowed_perm. */
+	if (!cap_attr.allowed_perm)
+		return -ENOMSG;
+
+	/* The allowed_perm must match LANDLOCK_PERM_CAPABILITY_USE. */
+	if (cap_attr.allowed_perm != LANDLOCK_PERM_CAPABILITY_USE)
+		return -EINVAL;
+
+	/* Checks that allowed_perm matches the @ruleset constraints. */
+	mask = landlock_get_perm_mask(ruleset, 0);
+	if (!(mask & LANDLOCK_PERM_CAPABILITY_USE))
+		return -EINVAL;
+
+	/* Informs about useless rule: empty capabilities. */
+	if (!cap_attr.capabilities)
+		return -ENOMSG;
+
+	/*
+	 * Stores only the capabilities this kernel knows about.  Unknown bits
+	 * are silently accepted for forward compatibility: user space compiled
+	 * against newer headers can pass new CAP_* bits without getting EINVAL
+	 * on older kernels.  Unknown bits have no effect because no hook checks
+	 * them.
+	 */
+	mutex_lock(&ruleset->lock);
+	ruleset->layers[0].allowed.caps |=
+		landlock_caps_to_bits(cap_attr.capabilities & CAP_VALID_MASK);
+	mutex_unlock(&ruleset->lock);
+	return 0;
+}
+
 /**
  * sys_landlock_add_rule - Add a new rule to a ruleset
  *
  * @ruleset_fd: File descriptor tied to the ruleset that should be extended
  *		with the new rule.
  * @rule_type: Identify the structure type pointed to by @rule_attr:
- *             %LANDLOCK_RULE_PATH_BENEATH, %LANDLOCK_RULE_NET_PORT, or
- *             %LANDLOCK_RULE_NAMESPACE.
+ *             %LANDLOCK_RULE_PATH_BENEATH, %LANDLOCK_RULE_NET_PORT,
+ *             %LANDLOCK_RULE_NAMESPACE, or %LANDLOCK_RULE_CAPABILITY.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
  * @flags: Must be 0.
  *
@@ -508,6 +558,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		return add_rule_net_port(ruleset, rule_attr);
 	case LANDLOCK_RULE_NAMESPACE:
 		return add_rule_namespace(ruleset, rule_attr);
+	case LANDLOCK_RULE_CAPABILITY:
+		return add_rule_capability(ruleset, rule_attr);
 	default:
 		return -EINVAL;
 	}
-- 
2.54.0

