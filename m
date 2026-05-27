Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2A4657C6
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905522; cv=none; b=CaKP6LJ/LN25laaTb8sV7jX3oc9bzpuquJEnOGy0kXZL7f5bbOiVxyvz3gPOBGAn/TgrNYllA2n67O5rUFvWNLJlboXngA1vHCtt3i4QeLBYB0l+ND5ueyreX9R4eEMiJ91YoAJcZZA8QaDXkeudK53FOBHxs7qs8wtxVKz+K2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905522; c=relaxed/simple;
	bh=y6SAehPm/H3WjJecGET9QioQEF5JQ/UG/SaKyL03HXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWRc39TZC3/vUvX7Zr5RQQvJ6jA/hbmugULF4QzsHonuvJ3FNJ2VleTac9Bck3a6WAHMM3ikD42RNGzeSCOF0DR1EzfXWVrrVNdOj97Yl0rLkcAZmcn9x5y9GaWJkcp/AMc7ATlROBRswzFDGU+7WHfh79sQdw4W1hcJjH9jsdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BGxkaRkI; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BGxkaRkI"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gQd436CwXzVtC;
	Wed, 27 May 2026 20:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779905507;
	bh=7H39fZPXJ+df6N9qb2OFNChyo9MpMsYxynVPhMPbj1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGxkaRkI7abjKHfAHxX+6eHZWSZ0laSM5AyIDRUeca0t+mohpvcgd/5DRFWDlLC2W
	 V5QNzDgFfdfzB4vw6jsR8Ek5pOKJvqLDA1W7FxQ91cH+svnBGNut3ilfPhZTUYhhZ8
	 YmXGCQ5/aAfdpoCm/Kmx29UDRNridqCD1FhqOS64=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gQd426kk3zJCX;
	Wed, 27 May 2026 20:11:46 +0200 (CEST)
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
Subject: [PATCH v2 4/9] landlock: Enforce namespace use restrictions
Date: Wed, 27 May 2026 20:11:17 +0200
Message-ID: <20260527181127.879771-5-mic@digikod.net>
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

Add Landlock enforcement for namespace use via the LSM namespace_init
and namespace_install hooks.  This lets a sandboxed process restrict
which namespace types it can acquire, using LANDLOCK_PERM_NAMESPACE_USE
and per-type rules.

Introduce the handled_perm field in struct landlock_ruleset_attr for
per-category permissions: each permission gates all uses of a
kernel-defined category (CLONE_NEW* for namespace types, CAP_* for
capabilities) and provides complete deny-by-default coverage of category
members.  Rule values reference constants from other kernel subsystems
(CLONE_NEW* for namespaces); unknown values are silently accepted
because the allow-list denies them by default.  See the "Ruleset
restriction models" section in the kernel documentation for the full
design rationale.

Depends on commit 935a04923ad2 ("nsproxy: Add FOR_EACH_NS_TYPE() X-macro
and CLONE_NS_ALL") for the FOR_EACH_NS_TYPE() macro used to enumerate
known namespace types and the CLONE_NS_ALL mask used to validate
namespace_types bitmasks.

Both hooks share check_ns_type(): if the namespace's CLONE_NEW* type is
not in the layer's allowed set, the operation is denied.  No domain
ancestry bypass, no namespace creator tracking, just a flat per-layer
allowed-types bitmask.

- hook_namespace_init() fires during unshare(CLONE_NEW*) and
  clone(CLONE_NEW*) via __ns_common_init().

- hook_namespace_install() fires during setns() via validate_ns().

Both record namespace_type and ns_id in the audit data; ns_id is zero at
allocation time and logged as such.

Add the perm_masks bitfield to struct layer_config (introduced by a
preceding commit) to store per-layer namespace type bitmasks; the name
parallels the sibling access_masks.  The 8-bit NS field maps to the 8
known namespace types via landlock_ns_type_to_bit(), keeping the storage
compact.  struct perm_masks is __packed __aligned(sizeof(u64)) to
guarantee consistent layout across architectures: on m68k, GCC packs
bitfields at byte granularity without __packed, so a u64 bitfield struct
can be smaller than sizeof(u64).

LANDLOCK_RULE_NAMESPACE uses struct landlock_namespace_attr with an
allowed_perm field (matching the pattern of allowed_access in existing
rule types) and a namespace_types bitmask of CLONE_NEW* flags.  Unknown
namespace type bits are silently accepted for forward compatibility;
they have no effect since the allow-list denies by default.  The
allowed_perm field reserves room for future sub-permissions within a
rule type without a UAPI break, and acts as a type discriminant at the
syscall boundary: rejecting mismatches with -EINVAL catches struct
misuse even when rule attribute structs share the same wire format.

User namespace creation does not require capabilities, so Landlock can
restrict it directly.  Non-user namespace types require CAP_SYS_ADMIN
before the Landlock check is reached; when both
LANDLOCK_PERM_NAMESPACE_USE and LANDLOCK_PERM_CAPABILITY_USE are
handled, both must allow the operation.

Five KUnit tests verify the landlock_ns_type_to_bit() and
landlock_ns_types_to_bits() conversion helpers.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Reviewed-by: Günther Noack <gnoack@google.com>
Reviewed-by: Tingmao Wang <m@maowtm.org>
Depends-on: 935a04923ad2 ("nsproxy: Add FOR_EACH_NS_TYPE() X-macro and CLONE_NS_ALL")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-6-mic@digikod.net
- Add __packed __aligned(sizeof(u64)) to struct perm_masks to fix
  static_assert failure on m68k, where GCC packs bitfields at byte
  granularity.
- Use ns_id instead of inum in namespace audit records.
- Add WARN_ON_ONCE guards for invalid perm_bit or request_value in
  landlock_perm_is_denied(), denying with the youngest layer on
  invalid input (suggested by Tingmao Wang).
- Fix double backtick in landlock_perm_is_denied() kernel-doc.
- Add Reviewed-by: Tingmao Wang.
- Mention commit 935a04923ad2 ("nsproxy: Add FOR_EACH_NS_TYPE()
  X-macro and CLONE_NS_ALL") as a dependency in the body and add
  Depends-on: trailer.
- Rename internal struct perm_rules to perm_masks to parallel the
  sibling access_masks in struct layer_config.
- Document the allowed_perm design rationale (extensibility for
  future sub-permissions, type discriminant safeguard).
- Rename LANDLOCK_PERM_NAMESPACE_ENTER to LANDLOCK_PERM_NAMESPACE_USE
  and audit blocker perm.namespace_enter to perm.namespace_use for
  semantic accuracy.  The verb _ENTER fits setns/unshare/clone
  (caller becomes namespace member) but misleads for open_tree and
  fsmount (caller holds an fd reference, does not enter).  _USE
  covers both cases and mirrors LANDLOCK_PERM_CAPABILITY_USE.
  Update the commit title accordingly.
- Replace "chokepoint"/"gateway" prose in @handled_perm kdoc and the
  Permission flags DOC block with the per-category framing.
- Expand the LANDLOCK_PERM_NAMESPACE_USE kdoc to enumerate creation
  (unshare/clone/clone3), joining (setns), and fd-reference
  (open_tree/fsmount) paths.
- Rewrite the commit body to drop chokepoint/gateway terminology in
  favour of per-category framing, matching the doc rewrite.
- Rename struct layer_rights to struct layer_config (companion
  change to the introducing commit).
- Surface the empty-check semantics in the
  landlock_namespace_attr.namespace_types kdoc: a rule that sets only
  bits unknown to the running kernel succeeds but has no runtime
  effect.
- Cascade the LSM hook rename namespace_alloc -> namespace_init
  (LSM_HOOK_INIT registration and local handler hook_namespace_alloc ->
  hook_namespace_init), companion change to the introducing commit.
- Rename the static helper landlock_check_ns_type() to check_ns_type():
  the landlock_ prefix is reserved for non-static symbols exported via
  headers; file-static helpers follow the prefix-free convention used
  in security/landlock/.
- Add Reviewed-by: Günther Noack.
---
 include/uapi/linux/landlock.h |  62 +++++++++++++-
 security/landlock/Makefile    |   3 +-
 security/landlock/access.h    |  40 ++++++++-
 security/landlock/audit.c     |   4 +
 security/landlock/audit.h     |   1 +
 security/landlock/cred.h      |  49 +++++++++++
 security/landlock/limits.h    |   7 ++
 security/landlock/ns.c        | 156 ++++++++++++++++++++++++++++++++++
 security/landlock/ns.h        |  73 ++++++++++++++++
 security/landlock/ruleset.c   |  11 +--
 security/landlock/ruleset.h   |  25 +++++-
 security/landlock/setup.c     |   2 +
 security/landlock/syscalls.c  |  68 ++++++++++++++-
 13 files changed, 484 insertions(+), 17 deletions(-)
 create mode 100644 security/landlock/ns.c
 create mode 100644 security/landlock/ns.h

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b147223efc97..233594482aa5 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -51,6 +51,15 @@ struct landlock_ruleset_attr {
 	 * resources (e.g. IPCs).
 	 */
 	__u64 scoped;
+	/**
+	 * @handled_perm: Bitmask of permissions (cf. `Permission flags`_) that
+	 * this ruleset handles.  Each permission controls a per-category
+	 * operation gated by an enum (CLONE_NEW* for namespace types, CAP_* for
+	 * capabilities); all uses of category members are denied unless
+	 * explicitly allowed by a rule.  See
+	 * Documentation/security/landlock.rst for the rationale.
+	 */
+	__u64 handled_perm;
 };
 
 /**
@@ -155,6 +164,10 @@ enum landlock_rule_type {
 	 * landlock_net_port_attr .
 	 */
 	LANDLOCK_RULE_NET_PORT,
+	/**
+	 * @LANDLOCK_RULE_NAMESPACE: Type of a &struct landlock_namespace_attr .
+	 */
+	LANDLOCK_RULE_NAMESPACE,
 };
 
 /**
@@ -208,6 +221,27 @@ struct landlock_net_port_attr {
 	__u64 port;
 };
 
+/**
+ * struct landlock_namespace_attr - Namespace type definition
+ *
+ * Argument of sys_landlock_add_rule() with %LANDLOCK_RULE_NAMESPACE.
+ */
+struct landlock_namespace_attr {
+	/**
+	 * @allowed_perm: Must be set to %LANDLOCK_PERM_NAMESPACE_USE.
+	 */
+	__u64 allowed_perm;
+	/**
+	 * @namespace_types: Bitmask of namespace types (``CLONE_NEW*`` flags)
+	 * to allow under this rule.  Must be non-zero (otherwise the call
+	 * returns ``-ENOMSG``); the non-zero check runs on the raw input before
+	 * unknown-bit masking, so a rule that sets only bits unknown to the
+	 * running kernel succeeds but has no runtime effect.  Unknown bits are
+	 * silently ignored for forward compatibility.
+	 */
+	__u64 namespace_types;
+};
+
 /**
  * DOC: fs_access
  *
@@ -431,6 +465,32 @@ struct landlock_net_port_attr {
 /* clang-format off */
 #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
 #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
-/* clang-format on*/
+/* clang-format on */
+
+/**
+ * DOC: perm
+ *
+ * Permission flags
+ * ~~~~~~~~~~~~~~~~
+ *
+ * These flags restrict per-category operations gated by enums (CLONE_NEW* for
+ * namespace types, CAP_* for capabilities).  Each flag covers every kernel path
+ * that exercises a member of the category.  Handled permissions that are not
+ * explicitly allowed by a rule are denied by default.  Rule values reference
+ * constants from other kernel subsystems; unknown values are silently accepted
+ * for forward compatibility since the allow-list denies them by default.  See
+ * Documentation/security/landlock.rst for design details.
+ *
+ * - %LANDLOCK_PERM_NAMESPACE_USE: Restrict the use of specific namespace
+ *   types -- creation (:manpage:`unshare(2)`, :manpage:`clone(2)`,
+ *   :manpage:`clone3(2)`), joining (:manpage:`setns(2)`), and acquiring an
+ *   fd reference (:manpage:`open_tree(2)`, :manpage:`fsmount(2)`).  A
+ *   process in a Landlock domain that handles this permission is denied
+ *   from using namespace types that are not explicitly allowed by a
+ *   %LANDLOCK_RULE_NAMESPACE rule.
+ */
+/* clang-format off */
+#define LANDLOCK_PERM_NAMESPACE_USE			(1ULL << 0)
+/* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index ffa7646d99f3..cacfba075dec 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -8,7 +8,8 @@ landlock-y := \
 	cred.o \
 	task.o \
 	fs.o \
-	tsync.o
+	tsync.o \
+	ns.o
 
 landlock-$(CONFIG_INET) += net.o
 
diff --git a/security/landlock/access.h b/security/landlock/access.h
index fba9babc8e45..42229eea6d7e 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -42,6 +42,8 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
 /* Makes sure all scoped rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
+/* Makes sure all permission types can be stored. */
+static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_PERM);
 /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
 static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
@@ -50,6 +52,7 @@ struct access_masks {
 	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
 	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
 	access_mask_t scope : LANDLOCK_NUM_SCOPE;
+	access_mask_t perm : LANDLOCK_NUM_PERM;
 } __packed __aligned(sizeof(u32));
 
 union access_masks_all {
@@ -61,14 +64,45 @@ union access_masks_all {
 static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
+/**
+ * struct perm_masks - Per-layer allowed bitmasks for permission types
+ *
+ * Compact bitfield struct holding the allowed bitmasks for permission types
+ * that use flat (non-tree) per-layer storage.  All fields share a single 64-bit
+ * storage unit.
+ */
+struct perm_masks {
+	/**
+	 * @ns: Allowed namespace types.  Each bit corresponds to a sequential
+	 * index assigned by the ``_LANDLOCK_NS_*`` enum (derived from
+	 * ``FOR_EACH_NS_TYPE``).  Bits are converted from ``CLONE_NEW*`` flags
+	 * at rule-add time via ``landlock_ns_types_to_bits()`` and at
+	 * enforcement time via ``landlock_ns_type_to_bit()``.
+	 */
+	u64 ns : LANDLOCK_NUM_PERM_NS;
+} __packed __aligned(sizeof(u64));
+
+static_assert(sizeof(struct perm_masks) == sizeof(u64));
+
 /**
  * struct layer_config - Per-layer access configuration
  *
- * Wraps the handled-access bitfields together with any additional per-layer
- * data (e.g. allowed bitmasks added by future patches).  This is the element
- * type of the &struct landlock_ruleset.layers FAM.
+ * Wraps the handled-access bitfields together with per-layer allowed bitmasks.
+ * This is the element type of the &struct landlock_ruleset.layers FAM.
+ *
+ * Unlike filesystem and network access rights, which are tracked per-object in
+ * red-black trees, namespace types use a flat bitmask because their keyspace is
+ * small and bounded (~8 namespace types).  A single rule adds to the allowed
+ * set via bitwise OR; at enforcement time each layer is checked directly (no
+ * tree lookup needed).
  */
 struct layer_config {
+	/**
+	 * @allowed: Per-layer allowed bitmasks for permission types.  Placed
+	 * before @handled to avoid an internal padding hole (8-byte perm_masks
+	 * followed by 4-byte access_masks).
+	 */
+	struct perm_masks allowed;
 	/**
 	 * @handled: Bitmask of access rights handled (i.e. restricted) by this
 	 * layer.
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 851647197a01..eca447ec281d 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -82,6 +82,10 @@ get_blocker(const enum landlock_request_type type,
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		WARN_ON_ONCE(access_bit != -1);
 		return "scope.signal";
+
+	case LANDLOCK_REQUEST_NAMESPACE:
+		WARN_ON_ONCE(access_bit != -1);
+		return "perm.namespace_use";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/audit.h b/security/landlock/audit.h
index 56778331b58c..e9e52fb628f5 100644
--- a/security/landlock/audit.h
+++ b/security/landlock/audit.h
@@ -21,6 +21,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_NET_ACCESS,
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
+	LANDLOCK_REQUEST_NAMESPACE,
 };
 
 /*
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index 3e2a7e88710e..0172345fa86f 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -153,6 +153,55 @@ landlock_get_applicable_subject(const struct cred *const cred,
 	return NULL;
 }
 
+/**
+ * landlock_perm_is_denied - Check if a permission bitmask request is denied
+ *
+ * @domain: The enforced domain.
+ * @perm_bit: The LANDLOCK_PERM_* flag to check.  Must have exactly one
+ *            bit set.
+ * @request_value: Compact bitmask to look for (e.g. result of
+ *                 `landlock_ns_type_to_bit(CLONE_NEWNET)`).  Must have
+ *                 exactly one bit set.
+ *
+ * Iterate from the youngest layer to the oldest.  For each layer that handles
+ * @perm_bit, check whether @request_value is present in the layer's allowed
+ * bitmask.  Return on the first (youngest) denying layer.
+ *
+ * Return: The youngest denying layer + 1, or 0 if allowed.
+ */
+static inline size_t
+landlock_perm_is_denied(const struct landlock_ruleset *const domain,
+			const access_mask_t perm_bit, const u64 request_value)
+{
+	ssize_t layer;
+
+	BUILD_BUG_ON(sizeof(perm_bit) > sizeof(u32));
+
+	if (WARN_ON_ONCE(hweight32(perm_bit) != 1) ||
+	    WARN_ON_ONCE(hweight64(request_value) != 1))
+		return domain->num_layers;
+
+	for (layer = domain->num_layers - 1; layer >= 0; layer--) {
+		u64 allowed;
+
+		if (!(domain->layers[layer].handled.perm & perm_bit))
+			continue;
+
+		switch (perm_bit) {
+		case LANDLOCK_PERM_NAMESPACE_USE:
+			allowed = domain->layers[layer].allowed.ns;
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return layer + 1;
+		}
+
+		if (!(allowed & request_value))
+			return layer + 1;
+	}
+	return 0;
+}
+
 __init void landlock_add_cred_hooks(void);
 
 #endif /* _SECURITY_LANDLOCK_CRED_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index a4d908b240a2..e51122668fd3 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -12,6 +12,7 @@
 
 #include <linux/bitops.h>
 #include <linux/limits.h>
+#include <linux/ns/ns_common_types.h>
 #include <uapi/linux/landlock.h>
 
 /* clang-format off */
@@ -31,6 +32,12 @@
 #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
 #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
 
+#define LANDLOCK_LAST_PERM		LANDLOCK_PERM_NAMESPACE_USE
+#define LANDLOCK_MASK_PERM		((LANDLOCK_LAST_PERM << 1) - 1)
+#define LANDLOCK_NUM_PERM		__const_hweight64(LANDLOCK_MASK_PERM)
+
+#define LANDLOCK_NUM_PERM_NS		__const_hweight64((u64)(CLONE_NS_ALL))
+
 #define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
diff --git a/security/landlock/ns.c b/security/landlock/ns.c
new file mode 100644
index 000000000000..147e992ecb3c
--- /dev/null
+++ b/security/landlock/ns.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - Namespace hooks
+ *
+ * Copyright © 2026 Cloudflare
+ */
+
+#include <linux/lsm_audit.h>
+#include <linux/lsm_hooks.h>
+#include <linux/ns/ns_common_types.h>
+#include <linux/ns_common.h>
+#include <linux/nsproxy.h>
+#include <uapi/linux/landlock.h>
+
+#include "audit.h"
+#include "cred.h"
+#include "limits.h"
+#include "ns.h"
+#include "ruleset.h"
+#include "setup.h"
+
+/* Ensures the audit ns_id field can hold ns_common.ns_id without truncation. */
+static_assert(sizeof(((struct common_audit_data *)NULL)->u.ns.ns_id) >=
+	      sizeof(((struct ns_common *)NULL)->ns_id));
+
+static const struct access_masks ns_perm = {
+	.perm = LANDLOCK_PERM_NAMESPACE_USE,
+};
+
+/**
+ * check_ns_type - Check namespace entry permission
+ *
+ * @ns: The namespace being allocated or installed.
+ *
+ * Shared check for namespace_init (creation via unshare(2) or clone(2)) and
+ * namespace_install (entry via setns(2)): denies when the namespace type is not
+ * in the domain's allowed set.  At allocation time @ns->ns_id is still zero and
+ * is logged as such.
+ *
+ * Return: 0 if allowed, -EPERM if denied.
+ */
+static int check_ns_type(struct ns_common *const ns)
+{
+	const struct landlock_cred_security *subject;
+	size_t denied_layer;
+
+	subject =
+		landlock_get_applicable_subject(current_cred(), ns_perm, NULL);
+	if (!subject)
+		return 0;
+
+	denied_layer = landlock_perm_is_denied(
+		subject->domain, LANDLOCK_PERM_NAMESPACE_USE,
+		landlock_ns_type_to_bit(ns->ns_type));
+	if (!denied_layer)
+		return 0;
+
+	landlock_log_denial(subject, &(struct landlock_request){
+					     .type = LANDLOCK_REQUEST_NAMESPACE,
+					     .audit.type = LSM_AUDIT_DATA_NS,
+					     .audit.u.ns.ns_type = ns->ns_type,
+					     .audit.u.ns.ns_id = ns->ns_id,
+					     .layer_plus_one = denied_layer,
+				     });
+	return -EPERM;
+}
+
+static int hook_namespace_init(struct ns_common *const ns)
+{
+	return check_ns_type(ns);
+}
+
+static int hook_namespace_install(const struct nsset *const nsset,
+				  struct ns_common *const ns)
+{
+	return check_ns_type(ns);
+}
+
+static struct security_hook_list landlock_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(namespace_init, hook_namespace_init),
+	LSM_HOOK_INIT(namespace_install, hook_namespace_install),
+};
+
+__init void landlock_add_ns_hooks(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			   &landlock_lsmid);
+}
+
+#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
+
+#include <kunit/test.h>
+
+/* clang-format off */
+#define _TEST_NS_BIT(struct_name, flag) \
+	do { \
+		const u64 bit = landlock_ns_type_to_bit(flag); \
+		KUNIT_EXPECT_NE(test, 0ULL, bit); \
+		KUNIT_EXPECT_EQ(test, 0ULL, seen & bit); \
+		seen |= bit; \
+	} while (0);
+/* clang-format on */
+
+static void test_ns_type_to_bit(struct kunit *const test)
+{
+	u64 seen = 0;
+
+	FOR_EACH_NS_TYPE(_TEST_NS_BIT)
+
+	KUNIT_EXPECT_EQ(test, GENMASK_ULL(LANDLOCK_NUM_PERM_NS - 1, 0), seen);
+}
+
+static void test_ns_type_to_bit_unknown(struct kunit *const test)
+{
+	KUNIT_EXPECT_EQ(test, 0ULL, landlock_ns_type_to_bit(CLONE_THREAD));
+}
+
+static void test_ns_types_to_bits_all(struct kunit *const test)
+{
+	KUNIT_EXPECT_EQ(test, GENMASK_ULL(LANDLOCK_NUM_PERM_NS - 1, 0),
+			landlock_ns_types_to_bits(CLONE_NS_ALL));
+}
+
+/* clang-format off */
+#define _TEST_NS_SINGLE(struct_name, flag) \
+	KUNIT_EXPECT_EQ(test, landlock_ns_type_to_bit(flag), \
+			landlock_ns_types_to_bits(flag));
+/* clang-format on */
+
+static void test_ns_types_to_bits_single(struct kunit *const test)
+{
+	FOR_EACH_NS_TYPE(_TEST_NS_SINGLE)
+}
+
+static void test_ns_types_to_bits_zero(struct kunit *const test)
+{
+	KUNIT_EXPECT_EQ(test, 0ULL, landlock_ns_types_to_bits(0));
+}
+
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE(test_ns_type_to_bit),
+	KUNIT_CASE(test_ns_type_to_bit_unknown),
+	KUNIT_CASE(test_ns_types_to_bits_all),
+	KUNIT_CASE(test_ns_types_to_bits_single),
+	KUNIT_CASE(test_ns_types_to_bits_zero),
+	{}
+};
+
+static struct kunit_suite test_suite = {
+	.name = "landlock_ns",
+	.test_cases = test_cases,
+};
+
+kunit_test_suite(test_suite);
+
+#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
diff --git a/security/landlock/ns.h b/security/landlock/ns.h
new file mode 100644
index 000000000000..cf1340202bf4
--- /dev/null
+++ b/security/landlock/ns.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Namespace hooks
+ *
+ * Copyright © 2026 Cloudflare
+ */
+
+#ifndef _SECURITY_LANDLOCK_NS_H
+#define _SECURITY_LANDLOCK_NS_H
+
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/compiler_attributes.h>
+#include <linux/ns/ns_common_types.h>
+#include <linux/types.h>
+
+#include "limits.h"
+
+/* _LANDLOCK_NS_CLONE_NEWCGROUP, */
+#define _LANDLOCK_NS_ENUM(struct_name, flag) _LANDLOCK_NS_##flag,
+
+/* _LANDLOCK_NS_CLONE_NEWCGROUP = 0, */
+enum {
+	FOR_EACH_NS_TYPE(_LANDLOCK_NS_ENUM) _LANDLOCK_NUM_NS_TYPES,
+};
+
+static_assert(_LANDLOCK_NUM_NS_TYPES == LANDLOCK_NUM_PERM_NS);
+
+/*
+ * case CLONE_NEWCGROUP:
+ *         return BIT_ULL(_LANDLOCK_NS_CLONE_NEWCGROUP);
+ */
+/* clang-format off */
+#define _LANDLOCK_NS_CASE(struct_name, flag) \
+	case flag: \
+		return BIT_ULL(_LANDLOCK_NS_##flag);
+/* clang-format on */
+
+static inline __attribute_const__ u64
+landlock_ns_type_to_bit(const unsigned long ns_type)
+{
+	switch (ns_type) {
+		FOR_EACH_NS_TYPE(_LANDLOCK_NS_CASE)
+	}
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+/*
+ * if (ns_types & CLONE_NEWCGROUP)
+ *         bits |= BIT_ULL(_LANDLOCK_NS_CLONE_NEWCGROUP);
+ */
+/* clang-format off */
+#define _LANDLOCK_NS_CONVERT(struct_name, flag) \
+	do { \
+		if (ns_types & (flag)) \
+			bits |= BIT_ULL(_LANDLOCK_NS_##flag); \
+	} while (0);
+/* clang-format on */
+
+static inline __attribute_const__ u64
+landlock_ns_types_to_bits(const u64 ns_types)
+{
+	u64 bits = 0;
+
+	WARN_ON_ONCE(ns_types & ~CLONE_NS_ALL);
+	FOR_EACH_NS_TYPE(_LANDLOCK_NS_CONVERT)
+	return bits;
+}
+
+__init void landlock_add_ns_hooks(void);
+
+#endif /* _SECURITY_LANDLOCK_NS_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 04219ec8bab3..5fe8cf9b0815 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -53,15 +53,14 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
 	return new_ruleset;
 }
 
-struct landlock_ruleset *
-landlock_create_ruleset(const access_mask_t fs_access_mask,
-			const access_mask_t net_access_mask,
-			const access_mask_t scope_mask)
+struct landlock_ruleset *landlock_create_ruleset(
+	const access_mask_t fs_access_mask, const access_mask_t net_access_mask,
+	const access_mask_t scope_mask, const access_mask_t perm_mask)
 {
 	struct landlock_ruleset *new_ruleset;
 
 	/* Informs about useless ruleset. */
-	if (!fs_access_mask && !net_access_mask && !scope_mask)
+	if (!fs_access_mask && !net_access_mask && !scope_mask && !perm_mask)
 		return ERR_PTR(-ENOMSG);
 	new_ruleset = create_ruleset(1);
 	if (IS_ERR(new_ruleset))
@@ -72,6 +71,8 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
 	if (scope_mask)
 		landlock_add_scope_mask(new_ruleset, scope_mask, 0);
+	if (perm_mask)
+		landlock_add_perm_mask(new_ruleset, perm_mask, 0);
 	return new_ruleset;
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 324df551987c..bf2b1019c11b 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -189,10 +189,9 @@ struct landlock_ruleset {
 	};
 };
 
-struct landlock_ruleset *
-landlock_create_ruleset(const access_mask_t access_mask_fs,
-			const access_mask_t access_mask_net,
-			const access_mask_t scope_mask);
+struct landlock_ruleset *landlock_create_ruleset(
+	const access_mask_t access_mask_fs, const access_mask_t access_mask_net,
+	const access_mask_t scope_mask, const access_mask_t perm_mask);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
@@ -302,6 +301,24 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
 	return ruleset->layers[layer_level].handled.scope;
 }
 
+static inline void
+landlock_add_perm_mask(struct landlock_ruleset *const ruleset,
+		       const access_mask_t perm_mask, const u16 layer_level)
+{
+	access_mask_t mask = perm_mask & LANDLOCK_MASK_PERM;
+
+	/* Should already be checked in sys_landlock_create_ruleset(). */
+	WARN_ON_ONCE(perm_mask != mask);
+	ruleset->layers[layer_level].handled.perm |= mask;
+}
+
+static inline access_mask_t
+landlock_get_perm_mask(const struct landlock_ruleset *const ruleset,
+		       const u16 layer_level)
+{
+	return ruleset->layers[layer_level].handled.perm;
+}
+
 bool landlock_unmask_layers(const struct landlock_rule *const rule,
 			    struct layer_access_masks *masks);
 
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 47dac1736f10..a7ed776b41b4 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -17,6 +17,7 @@
 #include "fs.h"
 #include "id.h"
 #include "net.h"
+#include "ns.h"
 #include "setup.h"
 #include "task.h"
 
@@ -68,6 +69,7 @@ static int __init landlock_init(void)
 	landlock_add_task_hooks();
 	landlock_add_fs_hooks();
 	landlock_add_net_hooks();
+	landlock_add_ns_hooks();
 	landlock_init_id();
 	landlock_initialized = true;
 	pr_info("Up and running.\n");
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 702b4ab6b733..b5bbeedc6825 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -20,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/limits.h>
 #include <linux/mount.h>
+#include <linux/ns/ns_common_types.h>
 #include <linux/path.h>
 #include <linux/sched.h>
 #include <linux/security.h>
@@ -34,6 +35,7 @@
 #include "fs.h"
 #include "limits.h"
 #include "net.h"
+#include "ns.h"
 #include "ruleset.h"
 #include "setup.h"
 #include "tsync.h"
@@ -95,7 +97,9 @@ static void build_check_abi(void)
 	struct landlock_ruleset_attr ruleset_attr;
 	struct landlock_path_beneath_attr path_beneath_attr;
 	struct landlock_net_port_attr net_port_attr;
+	struct landlock_namespace_attr namespace_attr;
 	size_t ruleset_size, path_beneath_size, net_port_size;
+	size_t namespace_size;
 
 	/*
 	 * For each user space ABI structures, first checks that there is no
@@ -105,8 +109,9 @@ static void build_check_abi(void)
 	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
 	ruleset_size += sizeof(ruleset_attr.handled_access_net);
 	ruleset_size += sizeof(ruleset_attr.scoped);
+	ruleset_size += sizeof(ruleset_attr.handled_perm);
 	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
-	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 32);
 
 	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
 	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
@@ -117,6 +122,11 @@ static void build_check_abi(void)
 	net_port_size += sizeof(net_port_attr.port);
 	BUILD_BUG_ON(sizeof(net_port_attr) != net_port_size);
 	BUILD_BUG_ON(sizeof(net_port_attr) != 16);
+
+	namespace_size = sizeof(namespace_attr.allowed_perm);
+	namespace_size += sizeof(namespace_attr.namespace_types);
+	BUILD_BUG_ON(sizeof(namespace_attr) != namespace_size);
+	BUILD_BUG_ON(sizeof(namespace_attr) != 16);
 }
 
 /* Ruleset handling */
@@ -249,10 +259,16 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	if ((ruleset_attr.scoped | LANDLOCK_MASK_SCOPE) != LANDLOCK_MASK_SCOPE)
 		return -EINVAL;
 
+	/* Checks permission content (and 32-bits cast). */
+	if ((ruleset_attr.handled_perm | LANDLOCK_MASK_PERM) !=
+	    LANDLOCK_MASK_PERM)
+		return -EINVAL;
+
 	/* Checks arguments and transforms to kernel struct. */
 	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
 					  ruleset_attr.handled_access_net,
-					  ruleset_attr.scoped);
+					  ruleset_attr.scoped,
+					  ruleset_attr.handled_perm);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
@@ -390,13 +406,57 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 					net_port_attr.allowed_access);
 }
 
+static int add_rule_namespace(struct landlock_ruleset *const ruleset,
+			      const void __user *const rule_attr)
+{
+	struct landlock_namespace_attr ns_attr;
+	int res;
+	access_mask_t mask;
+
+	/* Copies raw user space buffer. */
+	res = copy_from_user(&ns_attr, rule_attr, sizeof(ns_attr));
+	if (res)
+		return -EFAULT;
+
+	/* Informs about useless rule: empty allowed_perm. */
+	if (!ns_attr.allowed_perm)
+		return -ENOMSG;
+
+	/* The allowed_perm must match LANDLOCK_PERM_NAMESPACE_USE. */
+	if (ns_attr.allowed_perm != LANDLOCK_PERM_NAMESPACE_USE)
+		return -EINVAL;
+
+	/* Checks that allowed_perm matches the @ruleset constraints. */
+	mask = landlock_get_perm_mask(ruleset, 0);
+	if (!(mask & LANDLOCK_PERM_NAMESPACE_USE))
+		return -EINVAL;
+
+	/* Informs about useless rule: empty namespace_types. */
+	if (!ns_attr.namespace_types)
+		return -ENOMSG;
+
+	/*
+	 * Stores only the namespace types this kernel knows about.  Unknown
+	 * bits are silently accepted for forward compatibility: user space
+	 * compiled against newer headers can pass new CLONE_NEW* flags without
+	 * getting EINVAL on older kernels.  Unknown bits have no effect because
+	 * no hook checks them.
+	 */
+	mutex_lock(&ruleset->lock);
+	ruleset->layers[0].allowed.ns |= landlock_ns_types_to_bits(
+		ns_attr.namespace_types & CLONE_NS_ALL);
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
- *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
+ *             %LANDLOCK_RULE_PATH_BENEATH, %LANDLOCK_RULE_NET_PORT, or
+ *             %LANDLOCK_RULE_NAMESPACE.
  * @rule_attr: Pointer to a rule (matching the @rule_type).
  * @flags: Must be 0.
  *
@@ -446,6 +506,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		return add_rule_path_beneath(ruleset, rule_attr);
 	case LANDLOCK_RULE_NET_PORT:
 		return add_rule_net_port(ruleset, rule_attr);
+	case LANDLOCK_RULE_NAMESPACE:
+		return add_rule_namespace(ruleset, rule_attr);
 	default:
 		return -EINVAL;
 	}
-- 
2.54.0

