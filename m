Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA284A5EC3
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966474; cv=none; b=PfeLN1Yih/eSxQkdrz0g/o9A+w8tEWViladLNHqbbZ1yCMAyjkJpfdWgUJoVcAM086UnavLlq1/01uNppTkRWU+hBv6vP+oJZb2OjYv5VnKsNGI4olj9y4I9Thhn3V/84St6eeBpAmi54azj3MiFJ5LJyP1Y4X/ikqzS/YhZwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966474; c=relaxed/simple;
	bh=EcB1oSM3QW7XMtG4DOECU7AHm1TsVwnwYoZmh2DsKGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdbVPnPoFgUP4TnqTYF23OT0SkMqPgX+6IcvRTZKpyGJf0/w6GJOIHyha08aZr02gNNzbaCbDRbQuGtcn0Q293fY6z0Ihcm6aYTSVjtBZRF06hxqy8cydripg6iCKG2SLSIoLdWjOfMaECK+3TvaaK+y7thsj3VRjt4bVg4LVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PeNAYGwx; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PeNAYGwx"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j4PTL46CpznJh;
	Wed, 14 Oct 2026 10:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791966454;
	bh=7znZI0riFyyT2GyavjMspa1Xqe3EncQ+BIXvYofMVwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PeNAYGwxBHQMOCKJ36Qt3TEX26Z6C3nqgjhOGE5UDv7xVosm4HFnvK2FK55C+MylR
	 8Mww+8f8w8R3L9uZt3XOGAjB8EmimKdZoM3bXK1oCRpJcL6pjUwNuzzhvoATwavLK6
	 6x9ghyrCAlR+FFkGcvb4nOPi4QWMNsGL78SFOpfg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j4PTJ6wBGzqNj;
	Wed, 14 Oct 2026 10:27:32 +0200 (CEST)
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
Subject: [PATCH v6 4/8] landlock: Enforce capability restrictions
Date: Wed, 14 Oct 2026 10:27:10 +0200
Message-ID: <20261014082718.1435842-5-mic@digikod.net>
In-Reply-To: <20261014082718.1435842-1-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
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
exercise, using LANDLOCK_PERMISSION_CAPABILITY_USE and per-capability
rules.

The check is a flat per-layer allowed-capabilities test, with no
domain-ancestry bypass, no cross-namespace discriminant, and no
dependency on the target user namespace.  These categorical denials
return -EPERM, like the namespace permission introduced by the previous
commit, and they mirror its per-capability allowed and quiet masks, so
LANDLOCK_ADD_RULE_QUIET stays rejected for this rule type.  Successful
capability rules and denials are traced as the previous commit
describes.

Enforce only at capability exercise time rather than modifying the
credential's capability sets.  Modifying them would give capget(2) an
accurate view of usable capabilities, but no LSM other than commoncap
does so; Landlock follows that convention.  A sandboxed process inside a
user namespace therefore sees all capabilities via capget(2) but
receives -EPERM when attempting to use one that is denied.

An earlier design bypassed this hook for namespace management through a
domain-ancestry comparison with the namespace creator's stored Landlock
domain.  That made a Landlock decision depend on kernel namespace state,
and the ns != cred->user_ns heuristic did not accurately identify
namespace-management operations.  The flat, namespace-agnostic check
instead enforces capability and namespace restrictions independently;
creating a non-user namespace requires an allowed CAP_SYS_ADMIN even
when combined with CLONE_NEWUSER in one unshare().

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v5:
https://patch.msgid.link/20261007100255.1333386-5-mic@digikod.net
- Keep invalid-input KUnit coverage while dropping assertions about
  architecture-specific WARN_ON_ONCE() suppression counts (reported by
  Mark Brown):
  https://patch.msgid.link/asmHRyx_uDkK-tJs@sirena.co.uk

Changes since v3:
https://patch.msgid.link/20260726161400.3010511-9-mic@digikod.net
- Adapt the capability mask to the ruleset/domain split.
- Spell out perm as permission in the UAPI constant and members, the
  internal masks and helpers, and the trace fields, and name the audit
  blocker capability.use after its domain instead of
  perm.capability_use.
- Suppress and assert the expected warnings in the invalid-input KUnit
  tests.
- Drop __attribute_const__ from the conversion helpers, which warn on
  invalid input.
- Trace successful capability rules and denials.  Successful effective
  no-ops advance the version, while quiet denials remain trace-visible
  with logged=0.
- Tell programs to omit empty rules, complete the rule errors, and
  explain target-user-namespace independence and the -EPERM convention.
- Drop Reviewed-by: Tingmao Wang: this version folds the capability
  trace events into this patch, which her v3 review did not cover; a
  fresh review is welcome.

Changes since v2:
https://patch.msgid.link/20260527181127.879771-6-mic@digikod.net
- Rename the capability rule attribute fields (allowed_perm to perm,
  capabilities to allowed_capabilities) and add a quiet_capabilities
  bitmask that suppresses the audit records of specific denied
  capabilities, consuming the shared per-layer quiet member mask in
  landlock_log_denial(); the rule attribute grows from 16 to 24 bytes.
- Dropped Reviewed-by: Günther Noack and Tingmao Wang, as this version
  adds the quiet member mask described above, which their v1 review did
  not cover.  Fresh review welcome.

Changes since v1:
https://patch.msgid.link/20260312100444.2609563-7-mic@digikod.net
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
 include/linux/landlock.h        |   5 +-
 include/trace/events/landlock.h |  96 +++++++++++++++++++
 include/uapi/linux/landlock.h   |  49 ++++++++++
 security/landlock/Makefile      |   3 +-
 security/landlock/access.h      |  10 +-
 security/landlock/audit.c       |   4 +
 security/landlock/cap.c         | 159 ++++++++++++++++++++++++++++++++
 security/landlock/cap.h         |  48 ++++++++++
 security/landlock/domain.h      |   3 +
 security/landlock/limits.h      |   4 +-
 security/landlock/log.c         |  10 ++
 security/landlock/log.h         |   1 +
 security/landlock/setup.c       |   2 +
 security/landlock/syscalls.c    |  95 ++++++++++++++++++-
 security/landlock/trace.c       |  12 +++
 15 files changed, 494 insertions(+), 7 deletions(-)
 create mode 100644 security/landlock/cap.c
 create mode 100644 security/landlock/cap.h

diff --git a/include/linux/landlock.h b/include/linux/landlock.h
index d288e3b6756f..0ee4880988ba 100644
--- a/include/linux/landlock.h
+++ b/include/linux/landlock.h
@@ -56,10 +56,13 @@
 	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_SIGNAL, "signal")
 
 #define _LANDLOCK_PERMISSION_NAMESPACE_NAME "namespace"
+#define _LANDLOCK_PERMISSION_CAPABILITY_NAME "capability"
 
 #define _LANDLOCK_PERMISSION_LIST(entry) \
 	entry(LANDLOCK_PERMISSION_NAMESPACE_USE, "use", \
-	      _LANDLOCK_PERMISSION_NAMESPACE_NAME)
+	      _LANDLOCK_PERMISSION_NAMESPACE_NAME), \
+	entry(LANDLOCK_PERMISSION_CAPABILITY_USE, "use", \
+	      _LANDLOCK_PERMISSION_CAPABILITY_NAME)
 
 #define _LANDLOCK_PERMISSION_QUALIFIED_ENTRY(mask, action, domain) \
 	_LANDLOCK_NAME_ENTRY(mask, domain "." action)
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index c5a051ede8d9..744ef55ec1de 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -37,6 +37,7 @@ TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_ACCESS);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NET_ACCESS);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE);
+TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_CAPABILITY);
 
 #ifdef CREATE_TRACE_POINTS
 
@@ -552,6 +553,53 @@ TRACE_EVENT(landlock_add_rule_namespace,
 		__entry->quiet_namespace_types)
 );
 
+/**
+ * landlock_add_rule_capability - Capability rule added to a ruleset
+ *
+ * @ruleset: Source ruleset (never NULL).
+ * @flags: Complete validated landlock_add_rule_flags value supplied by this
+ *         successful call, not the rule's accumulated quiet state.
+ * @permissions: Validated permission mask from the rule attribute.
+ * @allowed_capabilities: Effective known capabilities allowed by this call.
+ * @quiet_capabilities: Effective known capabilities quieted by this call.
+ *
+ * Emitted by sys_landlock_add_rule() under the modified ruleset's lock, so
+ * the reported ruleset is a stable snapshot that no concurrent writer can
+ * change.
+ */
+TRACE_EVENT(landlock_add_rule_capability,
+
+	TP_PROTO(const struct landlock_ruleset *ruleset, u32 flags,
+		 u64 permissions, u64 allowed_capabilities,
+		 u64 quiet_capabilities),
+
+	TP_ARGS(ruleset, flags, permissions, allowed_capabilities,
+		quiet_capabilities),
+
+	TP_STRUCT__entry(
+		__field(	u64,		ruleset_id		)
+		__field(	u64,		ruleset_version		)
+		__field(	access_mask_t,	permissions		)
+		__field(	u64,		allowed_capabilities	)
+		__field(	u64,		quiet_capabilities	)
+	),
+
+	TP_fast_assign(
+		lockdep_assert_held(&ruleset->lock);
+		__entry->ruleset_id		= ruleset->id;
+		__entry->ruleset_version	= ruleset->version;
+		__entry->permissions		= permissions;
+		__entry->allowed_capabilities	= allowed_capabilities;
+		__entry->quiet_capabilities	= quiet_capabilities;
+	),
+
+	TP_printk("ruleset=%llx.%llu permissions=%s allowed_capabilities=0x%llx quiet_capabilities=0x%llx",
+		__entry->ruleset_id, __entry->ruleset_version,
+		__print_flags(__entry->permissions, "|",
+			      _LANDLOCK_PERMISSION_NAMES),
+		__entry->allowed_capabilities, __entry->quiet_capabilities)
+);
+
 /**
  * landlock_create_domain - New domain created
  *
@@ -980,6 +1028,54 @@ TRACE_EVENT(landlock_deny_permission_namespace,
 		__entry->namespace_type, __entry->namespace_id)
 );
 
+/**
+ * landlock_deny_permission_capability - Capability use denied
+ *
+ * @hierarchy: Denying domain's hierarchy node (never NULL); its id is the
+ *             domain field.
+ * @same_exec: Whether the current task entered the denying domain itself.
+ * @logged: Whether this denial was selected for audit logging.
+ * @blockers: Request type and final missing permission subset (never NULL).
+ * @capability: CAP_* number that was denied.
+ *
+ * Emitted when a Landlock domain denies capability use, except for checks
+ * made with CAP_OPT_NOAUDIT, which are denied without emitting this event.
+ */
+TRACE_EVENT(landlock_deny_permission_capability,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 bool logged, const struct landlock_blockers *blockers,
+		 int capability),
+
+	TP_ARGS(hierarchy, same_exec, logged, blockers, capability),
+
+	TP_STRUCT__entry(
+		__field(	u64,		domain_id	)
+		__field(	bool,		same_exec	)
+		__field(	bool,		logged		)
+		__field(	enum landlock_request_type, blockers_type	)
+		__field(	access_mask_t,	blockers_access	)
+		__field(	int,		capability	)
+	),
+
+	TP_fast_assign(
+		__entry->domain_id	= hierarchy->id;
+		__entry->same_exec	= same_exec;
+		__entry->logged		= logged;
+		__entry->blockers_type	= blockers->type;
+		__entry->blockers_access = blockers->access;
+		__entry->capability	= capability;
+	),
+
+	TP_printk("domain=%llx same_exec=%d logged=%d blockers=%s capability=%d",
+		__entry->domain_id, __entry->same_exec, __entry->logged,
+		__entry->blockers_type == LANDLOCK_REQUEST_CAPABILITY ?
+			__print_flags(__entry->blockers_access, "|",
+				      _LANDLOCK_PERMISSION_BLOCKER_NAMES) :
+			"unknown",
+		__entry->capability)
+);
+
 /**
  * landlock_deny_ptrace - Ptrace access denied by a Landlock domain
  *
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index bb8ec589ddac..3128e58d4b78 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -237,6 +237,11 @@ enum landlock_rule_type {
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
@@ -325,6 +330,42 @@ struct landlock_namespace_attr {
 	__u64 quiet_namespace_types;
 };
 
+/**
+ * struct landlock_capability_attr - Capability definition
+ *
+ * Argument of sys_landlock_add_rule() with %LANDLOCK_RULE_CAPABILITY.
+ */
+struct landlock_capability_attr {
+	/**
+	 * @permissions: Must be set to %LANDLOCK_PERMISSION_CAPABILITY_USE.
+	 */
+	__u64 permissions;
+	/**
+	 * @allowed_capabilities: Bitmask of capabilities (``1ULL << CAP_*``) to
+	 * allow under this rule.  Bits above ``CAP_LAST_CAP`` are silently
+	 * ignored for forward compatibility.
+	 */
+	__u64 allowed_capabilities;
+	/**
+	 * @quiet_capabilities: Bitmask of capabilities (``1ULL << CAP_*``)
+	 * whose denial by this layer should not be submitted to audit, even if
+	 * audit logging would normally take place per landlock_restrict_self()
+	 * flags.  Only audit records attributed to this layer are suppressed;
+	 * denial tracepoints still fire (see `Permission flags`_).  Bits also
+	 * set in @allowed_capabilities have no effect, since an allowed
+	 * capability is never denied.  Bits above ``CAP_LAST_CAP`` are silently
+	 * ignored.
+	 *
+	 * At least one of @allowed_capabilities or @quiet_capabilities must be
+	 * non-zero, otherwise the call returns ``-ENOMSG``.  The non-zero check
+	 * runs on the raw input before unknown-bit masking, so a rule that sets
+	 * only bits unknown to the running kernel (above ``CAP_LAST_CAP``)
+	 * succeeds but has no runtime effect.  Programs should omit this rule
+	 * when they neither allow nor quiet a capability.
+	 */
+	__u64 quiet_capabilities;
+};
+
 /**
  * DOC: fs_access
  *
@@ -577,7 +618,15 @@ struct landlock_namespace_attr {
  *   Landlock domain that handles this permission is denied from using namespace
  *   types that are not explicitly allowed by a %LANDLOCK_RULE_NAMESPACE rule.
  *   Support added in Landlock ABI version 12.
+ * - %LANDLOCK_PERMISSION_CAPABILITY_USE: Restrict the use of specific Linux
+ *   capabilities.  A process in a Landlock domain that handles this permission
+ *   is denied from exercising capabilities that are not explicitly allowed by a
+ *   %LANDLOCK_RULE_CAPABILITY rule.  This hook is purely restrictive: it can
+ *   deny capabilities that the kernel would otherwise grant, but it can never
+ *   grant capabilities that the kernel already denied.  Support added in
+ *   Landlock ABI version 12.
  */
 #define LANDLOCK_PERMISSION_NAMESPACE_USE			(1ULL << 0)
+#define LANDLOCK_PERMISSION_CAPABILITY_USE			(1ULL << 1)
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index e88ca842c782..97cf668db165 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -10,7 +10,8 @@ landlock-y := \
 	fs.o \
 	tsync.o \
 	domain.o \
-	ns.o
+	ns.o \
+	cap.o
 
 landlock-$(CONFIG_INET) += net.o
 
diff --git a/security/landlock/access.h b/security/landlock/access.h
index e3dbaa29a29f..f9eaa2f53686 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -73,16 +73,24 @@ struct permission_masks {
 	 * order.
 	 */
 	u64 ns_types : LANDLOCK_NUM_NAMESPACE_TYPE;
+	/**
+	 * @caps: Capability member mask, indexed by CAP_* values.
+	 */
+	u64 caps : LANDLOCK_NUM_CAPABILITY;
 } __packed __aligned(sizeof(u64));
 
 static_assert(sizeof(struct permission_masks) == sizeof(u64));
+/* All permission_masks bitfields must fit in a single u64. */
+static_assert(LANDLOCK_NUM_CAPABILITY + LANDLOCK_NUM_NAMESPACE_TYPE <=
+	      BITS_PER_TYPE(u64));
 
 /**
  * struct layer_config - Per-layer access configuration
  *
  * A ruleset stores one mutable layer and a domain stores a flexible array of
  * immutable layers.  Unlike filesystem and network access rights, namespace
- * types use a flat bitmask because their keyspace is small and bounded.
+ * types and capabilities use flat bitmasks because their keyspaces are small
+ * and bounded.
  */
 struct layer_config {
 	/**
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index 5386f1411ba6..be49ef47b4ea 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -81,6 +81,7 @@ get_blocker(const enum landlock_request_type type,
 		return scope_strings[BIT_INDEX(LANDLOCK_SCOPE_SIGNAL)];
 
 	case LANDLOCK_REQUEST_NAMESPACE:
+	case LANDLOCK_REQUEST_CAPABILITY:
 		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(permission_strings)))
 			return "unknown";
 		return permission_strings[access_bit];
@@ -116,6 +117,9 @@ blocker_prefix(const enum landlock_request_type type)
 
 	case LANDLOCK_REQUEST_NAMESPACE:
 		return _LANDLOCK_PERMISSION_NAMESPACE_NAME ".";
+
+	case LANDLOCK_REQUEST_CAPABILITY:
+		return _LANDLOCK_PERMISSION_CAPABILITY_NAME ".";
 	}
 
 	WARN_ON_ONCE(1);
diff --git a/security/landlock/cap.c b/security/landlock/cap.c
new file mode 100644
index 000000000000..b4f491b09baa
--- /dev/null
+++ b/security/landlock/cap.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - Capability hooks
+ *
+ * Copyright © 2026 Cloudflare, Inc.
+ */
+
+#include <linux/capability.h>
+#include <linux/cred.h>
+#include <linux/lsm_audit.h>
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/landlock.h>
+
+#include "cap.h"
+#include "cred.h"
+#include "domain.h"
+#include "limits.h"
+#include "log.h"
+#include "ruleset.h"
+#include "setup.h"
+
+static const struct access_masks cap_permission = {
+	.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
+};
+
+/**
+ * hook_capable - Deny capability use for Landlock-sandboxed processes
+ *
+ * @cred: Credentials being checked.
+ * @ns: Target user namespace (intentionally ignored; policy depends on the
+ *      acting credentials and @cap, not namespace ownership).
+ * @cap: Capability number (CAP_*).
+ * @opts: Capability check options.  CAP_OPT_NOAUDIT skips the denial record:
+ *        no audit record, no trace event, and no denial count.
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
+	subject = landlock_get_applicable_subject(cred, cap_permission, NULL);
+	if (!subject)
+		return 0;
+
+	denied_layer = landlock_permission_is_denied(
+		subject->domain, LANDLOCK_PERMISSION_CAPABILITY_USE,
+		landlock_cap_to_bit(cap));
+	if (!denied_layer)
+		return 0;
+
+	if (!(opts & CAP_OPT_NOAUDIT))
+		landlock_log_denial(
+			subject,
+			&(struct landlock_request){
+				.type = LANDLOCK_REQUEST_CAPABILITY,
+				.audit.type = LSM_AUDIT_DATA_CAP,
+				.audit.u.cap = cap,
+				.permission =
+					LANDLOCK_PERMISSION_CAPABILITY_USE,
+				.layer_plus_one = denied_layer,
+			});
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
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	/* clang-format off */
+	kunit_warning_suppress(test) {
+		/* clang-format on */
+		KUNIT_EXPECT_EQ(test, 0ULL, landlock_cap_to_bit(-1));
+		KUNIT_EXPECT_EQ(test, 0ULL,
+				landlock_cap_to_bit(CAP_LAST_CAP + 1));
+	}
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
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	/* clang-format off */
+	kunit_warning_suppress(test) {
+		/* clang-format on */
+		KUNIT_EXPECT_EQ(
+			test, 0ULL,
+			landlock_caps_to_bits(BIT_ULL(CAP_LAST_CAP + 1)));
+	}
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
index 000000000000..11208cbf15d2
--- /dev/null
+++ b/security/landlock/cap.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Capability hooks
+ *
+ * Copyright © 2026 Cloudflare, Inc.
+ */
+
+#ifndef _SECURITY_LANDLOCK_CAP_H
+#define _SECURITY_LANDLOCK_CAP_H
+
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/capability.h>
+#include <linux/types.h>
+
+/**
+ * landlock_cap_to_bit - Convert a capability number to a compact bitmask
+ *
+ * @cap: Capability number (CAP_*).
+ *
+ * Return: BIT_ULL(@cap), or 0 if @cap is invalid (with a WARN).
+ */
+static inline u64 landlock_cap_to_bit(const int cap)
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
+static inline u64 landlock_caps_to_bits(const u64 capabilities)
+{
+	/* Callers pre-mask (CAP_VALID_MASK); the WARN guards future callers. */
+	WARN_ON_ONCE(capabilities & ~CAP_VALID_MASK);
+	return capabilities & CAP_VALID_MASK;
+}
+
+__init void landlock_add_cap_hooks(void);
+
+#endif /* _SECURITY_LANDLOCK_CAP_H */
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index d9e7b96aa639..935e18b12b3c 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -377,6 +377,9 @@ landlock_permission_is_denied(const struct landlock_domain *const domain,
 		case LANDLOCK_PERMISSION_NAMESPACE_USE:
 			allowed = domain->layers[layer].allowed.ns_types;
 			break;
+		case LANDLOCK_PERMISSION_CAPABILITY_USE:
+			allowed = domain->layers[layer].allowed.caps;
+			break;
 		default:
 			WARN_ONCE(1, "Unknown permission %u\n",
 				  (unsigned int)permission_bit);
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 767d57799f60..ddd300e10689 100644
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
 
-#define LANDLOCK_LAST_PERMISSION	LANDLOCK_PERMISSION_NAMESPACE_USE
+#define LANDLOCK_LAST_PERMISSION	LANDLOCK_PERMISSION_CAPABILITY_USE
 #define LANDLOCK_MASK_PERMISSION	((LANDLOCK_LAST_PERMISSION << 1) - 1)
 #define LANDLOCK_NUM_PERMISSION		__const_hweight64(LANDLOCK_MASK_PERMISSION)
 
 #define LANDLOCK_NUM_NAMESPACE_TYPE	__const_hweight64((u64)CLONE_NS_ALL)
+#define LANDLOCK_NUM_CAPABILITY		(CAP_LAST_CAP + 1)
 
 #define LANDLOCK_NUM_ACCESS_MAX \
 	MAX(MAX(LANDLOCK_NUM_ACCESS_FS, LANDLOCK_NUM_ACCESS_NET), LANDLOCK_NUM_SCOPE)
diff --git a/security/landlock/log.c b/security/landlock/log.c
index 8cb1dfd0d4ae..43efbb95725c 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -12,6 +12,7 @@
 
 #include "access.h"
 #include "audit.h"
+#include "cap.h"
 #include "common.h"
 #include "cred.h"
 #include "domain.h"
@@ -393,6 +394,12 @@ static bool is_valid_request(const struct landlock_request *const request)
 		    WARN_ON_ONCE(request->audit.type != LSM_AUDIT_DATA_NS))
 			return false;
 		break;
+	case LANDLOCK_REQUEST_CAPABILITY:
+		if (WARN_ON_ONCE(request->permission !=
+				 LANDLOCK_PERMISSION_CAPABILITY_USE) ||
+		    WARN_ON_ONCE(request->audit.type != LSM_AUDIT_DATA_CAP))
+			return false;
+		break;
 	case LANDLOCK_REQUEST_PTRACE:
 	case LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY:
 	case LANDLOCK_REQUEST_FS_ACCESS:
@@ -481,6 +488,9 @@ is_denial_quieted(const struct landlock_request *const request,
 	case LANDLOCK_REQUEST_NAMESPACE:
 		return !!(youngest_denied->quiet_permission.ns_types &
 			  landlock_ns_type_to_bit(request->audit.u.ns.ns_type));
+	case LANDLOCK_REQUEST_CAPABILITY:
+		return !!(youngest_denied->quiet_permission.caps &
+			  landlock_cap_to_bit(request->audit.u.cap));
 	/*
 	 * Leave LANDLOCK_REQUEST_PTRACE and LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY
 	 * unhandled for now - they are never quiet.
diff --git a/security/landlock/log.h b/security/landlock/log.h
index a12956cac40e..596feeeb7aa6 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -26,6 +26,7 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
 	LANDLOCK_REQUEST_NAMESPACE,
+	LANDLOCK_REQUEST_CAPABILITY,
 };
 
 struct landlock_blockers {
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
index c37edcc478bc..fb5af318b69b 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -31,6 +31,7 @@
 #include <linux/uaccess.h>
 #include <uapi/linux/landlock.h>
 
+#include "cap.h"
 #include "cred.h"
 #include "domain.h"
 #include "fs.h"
@@ -101,8 +102,9 @@ static void build_check_abi(void)
 	struct landlock_path_beneath_attr path_beneath_attr;
 	struct landlock_net_port_attr net_port_attr;
 	struct landlock_namespace_attr namespace_attr;
+	struct landlock_capability_attr capability_attr;
 	size_t ruleset_size, path_beneath_size, net_port_size;
-	size_t namespace_size;
+	size_t namespace_size, capability_size;
 
 	/*
 	 * For each user space ABI structures, first checks that there is no
@@ -134,6 +136,12 @@ static void build_check_abi(void)
 	namespace_size += sizeof(namespace_attr.quiet_namespace_types);
 	BUILD_BUG_ON(sizeof(namespace_attr) != namespace_size);
 	BUILD_BUG_ON(sizeof(namespace_attr) != 24);
+
+	capability_size = sizeof(capability_attr.permissions);
+	capability_size += sizeof(capability_attr.allowed_capabilities);
+	capability_size += sizeof(capability_attr.quiet_capabilities);
+	BUILD_BUG_ON(sizeof(capability_attr) != capability_size);
+	BUILD_BUG_ON(sizeof(capability_attr) != 24);
 }
 
 /* Ruleset handling */
@@ -527,14 +535,88 @@ static int add_rule_namespace(struct landlock_ruleset *const ruleset,
 	return 0;
 }
 
+static int add_rule_capability(struct landlock_ruleset *const ruleset,
+			       const void __user *const rule_attr,
+			       const u32 flags)
+{
+	struct landlock_capability_attr cap_attr;
+	access_mask_t mask;
+	u64 allowed_caps, quiet_caps;
+	int ret;
+
+	/*
+	 * Capability rules support no add-rule flags.  In particular,
+	 * LANDLOCK_ADD_RULE_QUIET is filesystem/network only.
+	 */
+	if (flags)
+		return -EINVAL;
+
+	/* Copies raw user space buffer. */
+	ret = copy_from_user(&cap_attr, rule_attr, sizeof(cap_attr));
+	if (ret)
+		return -EFAULT;
+
+	/* Informs about useless rule: empty permissions. */
+	if (!cap_attr.permissions)
+		return -ENOMSG;
+
+	/*
+	 * The permissions selector must match
+	 * LANDLOCK_PERMISSION_CAPABILITY_USE.  The valid set is a single bit
+	 * today, so this is an exact match now; the check broadens to a subset
+	 * test once another supported permission is added.
+	 */
+	if (cap_attr.permissions != LANDLOCK_PERMISSION_CAPABILITY_USE)
+		return -EINVAL;
+
+	/*
+	 * Checks that permissions match the ruleset constraints.  This also
+	 * makes quieting require the category to be handled.
+	 */
+	mask = landlock_get_permission_mask(ruleset);
+	if (!(mask & LANDLOCK_PERMISSION_CAPABILITY_USE))
+		return -EINVAL;
+
+	/*
+	 * Informs about useless rule: neither allows nor quiets anything.  A
+	 * quiet-only rule (empty allowed set) is legal.
+	 */
+	if (!cap_attr.allowed_capabilities && !cap_attr.quiet_capabilities)
+		return -ENOMSG;
+
+	/*
+	 * Stores only the capabilities this kernel knows about.  Unknown bits
+	 * are silently accepted for forward compatibility: user space compiled
+	 * against newer headers can pass new CAP_* bits without getting EINVAL
+	 * on older kernels.  Unknown bits have no effect because no hook checks
+	 * them.  The quiet bitmask suppresses logging of denials attributed to
+	 * this layer; see landlock_log_denial().
+	 */
+	allowed_caps = cap_attr.allowed_capabilities & CAP_VALID_MASK;
+	quiet_caps = cap_attr.quiet_capabilities & CAP_VALID_MASK;
+
+	mutex_lock(&ruleset->lock);
+	ruleset->layer.allowed.caps |= landlock_caps_to_bits(allowed_caps);
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	ruleset->quiet_permission.caps |= landlock_caps_to_bits(quiet_caps);
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+#ifdef CONFIG_TRACEPOINTS
+	ruleset->version++;
+#endif /* CONFIG_TRACEPOINTS */
+	trace_landlock_add_rule_capability(ruleset, flags, cap_attr.permissions,
+					   allowed_caps, quiet_caps);
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
  * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
  *
@@ -553,6 +635,8 @@ static int add_rule_namespace(struct landlock_ruleset *const ruleset,
  *   handled accesses)
  * - %EINVAL: A nonzero &landlock_namespace_attr.permissions is not
  *   %LANDLOCK_PERMISSION_NAMESPACE_USE or is not handled by the ruleset;
+ * - %EINVAL: A nonzero &landlock_capability_attr.permissions is not
+ *   %LANDLOCK_PERMISSION_CAPABILITY_USE or is not handled by the ruleset;
  * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
  * - %EINVAL: LANDLOCK_ADD_RULE_QUIET is passed but the ruleset has no
  *   quiet access bits set for the corresponding rule type.
@@ -561,6 +645,9 @@ static int add_rule_namespace(struct landlock_ruleset *const ruleset,
  * - %ENOMSG: &landlock_namespace_attr.permissions is 0, or both
  *   &landlock_namespace_attr.allowed_namespace_types and
  *   &landlock_namespace_attr.quiet_namespace_types are 0;
+ * - %ENOMSG: &landlock_capability_attr.permissions is 0, or both
+ *   &landlock_capability_attr.allowed_capabilities and
+ *   &landlock_capability_attr.quiet_capabilities are 0;
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
  *   member of @rule_attr is not a file descriptor as expected;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
@@ -595,6 +682,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		return add_rule_net_port(ruleset, rule_attr, flags);
 	case LANDLOCK_RULE_NAMESPACE:
 		return add_rule_namespace(ruleset, rule_attr, flags);
+	case LANDLOCK_RULE_CAPABILITY:
+		return add_rule_capability(ruleset, rule_attr, flags);
 	default:
 		return -EINVAL;
 	}
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 300afcc82220..995c6b948e16 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -94,6 +94,18 @@ void landlock_trace_denial(
 				request->audit.u.ns.ns_id);
 		}
 		break;
+	case LANDLOCK_REQUEST_CAPABILITY:
+		if (trace_landlock_deny_permission_capability_enabled()) {
+			const struct landlock_blockers blockers = {
+				.access = missing,
+				.type = request->type,
+			};
+
+			trace_landlock_deny_permission_capability(
+				youngest_denied, same_exec, logged, &blockers,
+				request->audit.u.cap);
+		}
+		break;
 	case LANDLOCK_REQUEST_FS_ACCESS:
 	case LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY:
 		if (trace_landlock_deny_access_fs_enabled()) {
-- 
2.55.0

