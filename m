Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36C3B5833
	for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310486; cv=none; b=s7An8R8LhyPJZ1OMwoFgppzTXeyOZCMoTZ2MhTODOfT8th+OrRblNaKwiJIAT2HLbmh4SLfiuA1uq9BnjIgpH+KyTWfs5cCFcBr8C1EEgmPdItWbLNva3TVp7+jAVR1BTLjKBvh+oZwPPK/K1N7EJN7z7/M2mOd73VQ3MwkMlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310486; c=relaxed/simple;
	bh=SZhr6EkEdi4nJlRHNXcYGAF/KDnpNZXC6fG4YwBCNj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3t5uMcydJGoWDdrAiGflbLrP/0utm/R0WvfgcrriHliNqKHnKjWMzxnohrbtMjgHJz2QmHuoV+km164uAuVVPLwuBNI/uI/UOwipZxKqE/vB23qF7qaEoc2mQtq07m2h09wo9NWeheCto9I+5SK9RD7EhO49wieeQJraQQlzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dk7TVQys; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dk7TVQys"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fWjsm3G3qzB98;
	Thu, 12 Mar 2026 11:05:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773309916;
	bh=RyM3fOjZ2E9hDyjrGtvii5q6YbgiepGquJ5pTciMM7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dk7TVQys2ODJ0WI8NBmpfE5XrC6XEIoBNxQVw8VgCN3eAHqL+yiMHDq86J2+XwJM/
	 1wnE0GISXB7KekzIlONfjJp8OtkHF+P75i+fCcVLiVJs+VxDoXuV8JoPdMRTznWjyC
	 nkkuovNLXFM4h0BOYXY2CnX7AFzn9fxwOA7vDniM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fWjsl6HVqzB6Y;
	Thu, 12 Mar 2026 11:05:15 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
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
Subject: [RFC PATCH v1 06/11] landlock: Enforce capability restrictions
Date: Thu, 12 Mar 2026 11:04:39 +0100
Message-ID: <20260312100444.2609563-7-mic@digikod.net>
In-Reply-To: <20260312100444.2609563-1-mic@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
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

The capable hook is purely restrictive: it runs after cap_capable()
(LSM_ORDER_FIRST), so it can deny capabilities that commoncap would
allow, but it can never grant capabilities that commoncap denied.

Add hook_capable() that uses landlock_perm_is_denied() to perform a pure
bitmask check: if the capability is not in the layer's allowed set, the
check is denied.  No domain ancestry bypass, no cross-namespace
discriminant, just a flat per-layer allowed-caps bitmask, matching the
same pattern used by LANDLOCK_PERM_NAMESPACE_ENTER.

Adding the 41-bit capability bitfield to struct perm_rules brings it to
49 out of 64 bits used (41 caps + 8 namespace types, 15 bits padding),
keeping struct layer_rights at 16 bytes (8 bytes perm_rules + 4 bytes
access_masks + 4 bytes tail padding) and the layers[] array at 256 bytes
maximum.  The caps bitfield is placed first in struct perm_rules (before
the ns bitfield) because capabilities use a direct BIT_ULL(cap) mapping
that benefits from starting at bit 0 of the storage unit.

Non-user namespace operations require both LANDLOCK_PERM_NAMESPACE_ENTER
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
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/uapi/linux/landlock.h |  31 ++++++++
 security/landlock/Makefile    |   1 +
 security/landlock/access.h    |  15 +++-
 security/landlock/audit.c     |   4 +
 security/landlock/audit.h     |   1 +
 security/landlock/cap.c       | 142 ++++++++++++++++++++++++++++++++++
 security/landlock/cap.h       |  49 ++++++++++++
 security/landlock/cred.h      |   3 +
 security/landlock/limits.h    |   4 +-
 security/landlock/setup.c     |   2 +
 security/landlock/syscalls.c  |  58 +++++++++++++-
 11 files changed, 302 insertions(+), 8 deletions(-)
 create mode 100644 security/landlock/cap.c
 create mode 100644 security/landlock/cap.h

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b76e656241df..0e73be459d47 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -166,6 +166,11 @@ enum landlock_rule_type {
 	 * landlock_namespace_attr .
 	 */
 	LANDLOCK_RULE_NAMESPACE,
+	/**
+	 * @LANDLOCK_RULE_CAPABILITY: Type of a &struct
+	 * landlock_capability_attr .
+	 */
+	LANDLOCK_RULE_CAPABILITY,
 };
 
 /**
@@ -237,6 +242,24 @@ struct landlock_namespace_attr {
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
+	 * @capabilities: Bitmask of capabilities (``1ULL << CAP_*``) that
+	 * should be allowed for use under this rule.  Bits above
+	 * ``CAP_LAST_CAP`` are silently ignored for forward compatibility.
+	 */
+	__u64 capabilities;
+};
+
 /**
  * DOC: fs_access
  *
@@ -432,9 +455,17 @@ struct landlock_namespace_attr {
  *   Landlock domain that handles this permission is denied from entering
  *   namespace types that are not explicitly allowed by a
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
 #define LANDLOCK_PERM_NAMESPACE_ENTER			(1ULL << 0)
+#define LANDLOCK_PERM_CAPABILITY_USE			(1ULL << 1)
 /* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 734aed4ac1bf..63311d556f93 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -9,6 +9,7 @@ landlock-y := \
 	task.o \
 	fs.o \
 	ns.o \
+	cap.o \
 	tsync.o
 
 landlock-$(CONFIG_INET) += net.o
diff --git a/security/landlock/access.h b/security/landlock/access.h
index 9c67987a77ae..65227b3064db 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -72,6 +72,13 @@ static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
  * a single 64-bit storage unit.
  */
 struct perm_rules {
+	/**
+	 * @caps: Allowed capabilities.  Each bit corresponds to a
+	 * ``CAP_*`` value (e.g. ``CAP_NET_RAW`` = bit 13).  Bits are
+	 * stored directly (sequential mapping) and masked with
+	 * ``CAP_VALID_MASK`` at rule-add time.
+	 */
+	u64 caps : LANDLOCK_NUM_PERM_CAP;
 	/**
 	 * @ns: Allowed namespace types.  Each bit corresponds to a
 	 * sequential index assigned by the ``_LANDLOCK_NS_*`` enum
@@ -93,10 +100,10 @@ static_assert(sizeof(struct perm_rules) == sizeof(u64));
  * landlock_ruleset.layers FAM.
  *
  * Unlike filesystem and network access rights, which are tracked per-object
- * in red-black trees, namespace types use a flat bitmask because their
- * keyspace is small and bounded (~8 namespace types).  A single rule adds
- * to the allowed set via bitwise OR; at enforcement time each layer is
- * checked directly (no tree lookup needed).
+ * in red-black trees, namespace types and capabilities use flat bitmasks
+ * because their keyspaces are small and bounded (~8 namespace types, 41
+ * capabilities).  A single rule adds to the allowed set via bitwise OR; at
+ * enforcement time each layer is checked directly (no tree lookup needed).
  */
 struct layer_rights {
 	/**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 46a635893914..24b7800ec479 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -82,6 +82,10 @@ get_blocker(const enum landlock_request_type type,
 	case LANDLOCK_REQUEST_NAMESPACE:
 		WARN_ON_ONCE(access_bit != -1);
 		return "perm.namespace_enter";
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
index 000000000000..536e579f63a9
--- /dev/null
+++ b/security/landlock/cap.c
@@ -0,0 +1,142 @@
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
+ * Pure bitmask check: denies the capability if it is not in the layer's
+ * allowed set.  This hook is purely restrictive: it runs after
+ * cap_capable() (LSM_ORDER_FIRST), so it can deny capabilities that
+ * commoncap would allow, but it can never grant capabilities that
+ * commoncap denied.
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
+	 * Respects CAP_OPT_NOAUDIT to suppress audit records for
+	 * capability probes (e.g., ns_capable_noaudit(),
+	 * has_capability_noaudit()).
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
index 000000000000..334b6974fb95
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
+ * Return: @capabilities masked to known capabilities.  Warns if unknown
+ * bits are present (callers must pre-mask for user input).
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
index 68067ff53ead..257197facbae 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -184,6 +184,9 @@ landlock_perm_is_denied(const struct landlock_ruleset *const domain,
 		case LANDLOCK_PERM_NAMESPACE_ENTER:
 			allowed = domain->layers[layer].allowed.ns;
 			break;
+		case LANDLOCK_PERM_CAPABILITY_USE:
+			allowed = domain->layers[layer].allowed.caps;
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			return layer + 1;
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index e361b653fcf5..43e832c0deb0 100644
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
 
-#define LANDLOCK_LAST_PERM		LANDLOCK_PERM_NAMESPACE_ENTER
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
index 152d952e98f6..38a4bf92781a 100644
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
+	 * Stores only the capabilities this kernel knows about.
+	 * Unknown bits are silently accepted for forward compatibility:
+	 * user space compiled against newer headers can pass new
+	 * CAP_* bits without getting EINVAL on older kernels.
+	 * Unknown bits have no effect because no hook checks them.
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
2.53.0

