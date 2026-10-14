Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EC387596
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966468; cv=none; b=JB00UfZx/Cqvk8oJZUo6ELEd/VdHdboM55qEAbCxvrryeFWGBOYEyz3Aw+LKBrA2rqAKiR5X2OqYaSBPddaMyUcOxBp+HVvIzbdIStGw8bSvg1Ie0/zLnb0GsDGYOZQkbD8Fm5iICeq9+E+jMsG3qiwpk05oJf2QcGHInLXXUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966468; c=relaxed/simple;
	bh=gcNmqHzrFNZQCkW+BKuVXtatF6RNg8TUSJvW+E8iy2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrY9NS4gsgxPVKJRutTBscfav1Kr2gfDjmzku0in7TBP/MgoXgqKP33Tk/3T7sY91LJ/LV4DR4SnJfYIlVACWRvC2KJ1yeOw2KSTKTZ+FYEgss99JOCTv8wfP5h0SnmWrFwgjMJFBNowQ21ux/muZc6JDmW/tMivrK8upJL7XYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=V8QJ1uJU; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="V8QJ1uJU"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j4PTJ28MqzlV3;
	Wed, 14 Oct 2026 10:27:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791966452;
	bh=ZmwWBiUksuKsZXOx4hvoyvjeo71F1c3YVKhPx3dMvUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8QJ1uJUJkAn867oFu/7UbX6kargeWeDyICJopY6n4IuRlvqhfAd6BwR0WBw8n9cq
	 SPu83cjMK0evBDmLcfrZmFoOH64tvSCd9XitZYVgZURT++WZmCmBC+Hp/AOGSjyC7X
	 mhdSO1d1f6fMXkhQoPu9PwFV/VDtdXKYsBkfFeaA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j4PTG6N8Dz71j;
	Wed, 14 Oct 2026 10:27:30 +0200 (CEST)
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
Subject: [PATCH v6 3/8] landlock: Enforce namespace use restrictions
Date: Wed, 14 Oct 2026 10:27:09 +0200
Message-ID: <20261014082718.1435842-4-mic@digikod.net>
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

Add Landlock enforcement for namespace use through the LSM
namespace_init and namespace_install hooks.  This lets a sandboxed
process restrict which namespace types it can create, join, or acquire a
file descriptor for, using LANDLOCK_PERMISSION_NAMESPACE_USE and
per-type rules.

Introduce the handled_permissions field in struct landlock_ruleset_attr:
each permission gates every use of a kernel-defined category (CLONE_NEW*
namespace types, CAP_* capabilities) with complete deny-by-default
coverage, so unknown member values need no validation, being denied
until a rule allows them.  This UAPI extension advances the Landlock ABI
from 11 to 12.

There is no domain-ancestry bypass and no namespace-creator tracking,
only a flat per-layer allowed-types bitmask: hook_namespace_init()
covers creation through clone(2), unshare(2), open_tree(2) and
fsmount(2), and hook_namespace_install() covers setns(2).  Each
permission hook maps its member mask explicitly in the shared permission
walker, which warns and denies if a future caller omits that mapping.
These categorical denials return -EPERM, matching Landlock's scope and
mount-topology denials rather than its object-access -EACCES convention.

struct permission_masks is forced to eight bytes with __packed and
__aligned because it must eventually hold both the eight namespace types
and all capabilities, and because m68k GCC otherwise packs its u64
bitfields at byte granularity, making the structure smaller than
sizeof(u64).  Carrying it grows struct layer_config from 4 to 16 bytes,
so the largest 16-entry domain FAM grows from 64 to 256 bytes.

The permissions selector keeps the rule attribute self-describing:

- User space can mask it against handled_permissions, as it masks
  allowed_access against handled_access_fs, so a program built against
  newer headers still adds the rules an older kernel supports.

- It tells apart two attributes that share the same three-u64 layout.
  Unknown member bits are ignored, so without it a mismatched rule type
  would apply a capability mask as namespace types.

- It leaves room for a rule to carry several permissions, or for another
  rule type to key the same permission differently.

The rule also carries a quiet_namespace_types bitmask that suppresses
audit submission for denied members without granting them.  A sandbox
knowingly running a caller that probes a type it will never be granted
would otherwise flood the audit log and drown the surprising denials
that matter.  Quiet is per-member rather than a coarse per-category
ruleset bit, so a sandbox can silence CLONE_NEWNET while still auditing
CLONE_NEWUTS; making it the complement of the allowed set would be
broad, could not audit a member that is neither allowed nor explicitly
quieted, and would auto-hide members added by future kernels.  It is a
per-rule bitmask rather than the LANDLOCK_ADD_RULE_QUIET flag and the
ruleset quiet_access_* masks, which suit the unbounded rb-tree objects
of filesystem and network rules, so that flag is rejected here.  Only
the youngest denying layer's quiet mask decides, so a parent cannot
silence a denial made by a deeper layer.

Trace the handled permission mask, every successful namespace rule, and
namespace denials.  Successful effective no-ops advance the version, and
quiet denials remain trace-visible with logged=0.  The denial event
takes the blockers argument of the filesystem and network events and
records the same blockers_type and blockers_access fields, so one filter
expression spans the mask-bearing denial events.  Handled and rule
permission masks may contain permissions from multiple domains in one
field, so their names are domain-qualified, such as namespace.use.  A
blocker is already interpreted in the domain supplied by the audit
prefix or denial event, so it retains the bare action name use, matching
existing access blockers such as read_file.

User namespace creation does not require capabilities, so Landlock can
restrict it directly.  Non-user namespace types require CAP_SYS_ADMIN
before the Landlock check is reached; when the capability permission
added by the next commit is also handled, both must allow the operation.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v5:
https://patch.msgid.link/20261007100255.1333386-4-mic@digikod.net
- Correct the shared denial field ordering documentation to distinguish
  access and permission events carrying blockers from ptrace and scope
  events.

Changes since v3:
https://patch.msgid.link/20260726161400.3010511-8-mic@digikod.net
- Adapt to the merged namespace/audit prerequisites and the
  ruleset/domain split, snapshotting the allowed and quiet masks under
  the source ruleset lock.
- Suppress and assert the expected warnings in the invalid-input KUnit
  tests.
- Map namespace types with a lookup table, and drop __attribute_const__
  from the conversion helpers, which warn on invalid input.
- Advance the Landlock ABI to 12.
- Spell out perm as permission in the UAPI constant and members, the
  internal masks and helpers, and the trace fields, and name the audit
  blocker namespace.use after its domain instead of perm.namespace_use.
- Justify the permissions selector by what it does today: user space can
  mask it against handled_permissions, and it tells apart two attributes
  that share one layout, whose unknown member bits are ignored.
- Trace handled permissions, successful namespace rules, and denials.
  Successful effective no-ops advance the version, while quiet denials
  remain trace-visible with logged=0.
- Tell programs to omit empty rules.
- Complete the permission-rule errors and explain fail-closed dispatch
  and the -EPERM convention.
- Drop Reviewed-by: Tingmao Wang: this version folds the namespace trace
  events and ABI 12 into this patch, which her v3 review did not cover;
  a fresh review is welcome.

Changes since v2:
https://patch.msgid.link/20260527181127.879771-5-mic@digikod.net
- Rename the namespace rule attribute fields (allowed_perm to perm,
  namespace_types to allowed_namespace_types) and add a
  quiet_namespace_types bitmask that suppresses the audit records of
  specific denied namespace types, together with the shared per-layer
  quiet member mask read in landlock_log_denial(); the rule attribute
  grows from 16 to 24 bytes.
- Copy the accumulated quiet_perm mask into the domain hierarchy in
  merge_ruleset(), under the ruleset merge lock and atomically with the
  allowed mask (no separate lock).
- Dropped Reviewed-by: Günther Noack and Tingmao Wang, as this version
  adds the quiet member mask described above, which their v1 review did
  not cover.  Fresh review welcome.

Changes since v1:
https://patch.msgid.link/20260312100444.2609563-6-mic@digikod.net
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
 include/linux/landlock.h                      |  26 +-
 include/trace/events/landlock.h               | 133 +++++++++-
 include/uapi/linux/landlock.h                 |  73 ++++++
 security/landlock/Makefile                    |   3 +-
 security/landlock/access.h                    |  29 ++-
 security/landlock/audit.c                     |  28 +-
 security/landlock/domain.c                    |   1 +
 security/landlock/domain.h                    |  61 +++++
 security/landlock/limits.h                    |   7 +
 security/landlock/log.c                       |  37 ++-
 security/landlock/log.h                       |   9 +-
 security/landlock/ns.c                        | 241 ++++++++++++++++++
 security/landlock/ns.h                        |  18 ++
 security/landlock/ruleset.c                   |  21 +-
 security/landlock/ruleset.h                   |  24 +-
 security/landlock/setup.c                     |   2 +
 security/landlock/syscalls.c                  | 114 ++++++++-
 security/landlock/trace.c                     |  15 +-
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 tools/testing/selftests/landlock/trace.h      |   3 +-
 tools/testing/selftests/landlock/trace_test.c |   8 +-
 21 files changed, 801 insertions(+), 54 deletions(-)
 create mode 100644 security/landlock/ns.c
 create mode 100644 security/landlock/ns.h

diff --git a/include/linux/landlock.h b/include/linux/landlock.h
index 004cbd0b9298..d288e3b6756f 100644
--- a/include/linux/landlock.h
+++ b/include/linux/landlock.h
@@ -13,14 +13,16 @@
 #include <uapi/linux/landlock.h>
 
 /*
- * Access-right and scope names, shared between the audit records (get_blocker()
- * in security/landlock/audit.c) and the trace events
+ * Access-right, scope, and permission names, shared between the audit records
+ * (get_blocker() in security/landlock/audit.c) and the trace events
  * (include/trace/events/landlock.h).  A consumer defines
  * _LANDLOCK_NAME_ENTRY(mask, name) before expanding a list and undefines it
  * afterwards: audit maps each entry to a "[bit] = name" slot for O(1) lookup,
  * the trace events map it to a __print_flags() { mask, name } pair.  The bit
  * value lives only in the LANDLOCK_* UAPI constant each entry references.
- * Names are unprefixed; audit prepends the "fs."/"net."/"scope." category.
+ * Access-right and scope names are unprefixed; audit prepends the
+ * "fs."/"net."/"scope." category.  Permission entries carry an action and a
+ * domain for the qualified and bare views below.
  */
 #define _LANDLOCK_ACCESS_FS_NAMES \
 	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_FS_EXECUTE, "execute"), \
@@ -53,4 +55,22 @@
 			     "abstract_unix_socket"), \
 	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_SIGNAL, "signal")
 
+#define _LANDLOCK_PERMISSION_NAMESPACE_NAME "namespace"
+
+#define _LANDLOCK_PERMISSION_LIST(entry) \
+	entry(LANDLOCK_PERMISSION_NAMESPACE_USE, "use", \
+	      _LANDLOCK_PERMISSION_NAMESPACE_NAME)
+
+#define _LANDLOCK_PERMISSION_QUALIFIED_ENTRY(mask, action, domain) \
+	_LANDLOCK_NAME_ENTRY(mask, domain "." action)
+
+#define _LANDLOCK_PERMISSION_BARE_ENTRY(mask, action, ...) \
+	_LANDLOCK_NAME_ENTRY(mask, action)
+
+#define _LANDLOCK_PERMISSION_NAMES \
+	_LANDLOCK_PERMISSION_LIST(_LANDLOCK_PERMISSION_QUALIFIED_ENTRY)
+
+#define _LANDLOCK_PERMISSION_BLOCKER_NAMES \
+	_LANDLOCK_PERMISSION_LIST(_LANDLOCK_PERMISSION_BARE_ENTRY)
+
 #endif /* _LINUX_LANDLOCK_H */
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 215d08c1e03d..c5a051ede8d9 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -36,6 +36,7 @@ static_assert(sizeof(access_mask_t) <= sizeof(u64));
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_ACCESS);
 TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NET_ACCESS);
+TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE);
 
 #ifdef CREATE_TRACE_POINTS
 
@@ -280,9 +281,9 @@ static inline const char *__trace_landlock_print_layers(
  * enabled and the per-execution flag selected by same_exec is set); a
  * stateless ftrace filter can select the denials the domain submits to
  * audit with logged==1, without reconstructing it from the per-execution
- * log flags.  Denial events order their fields as domain, same_exec,
- * logged, then blockers (deny_access events only), then the type-specific
- * object fields, then any variable-length field.
+ * log flags.  Denial events order their shared fields as domain, same_exec,
+ * and logged.  Access and permission denial events follow these with the
+ * blockers verdict input, type-specific fields, and any variable-length field.
  *
  * Relational referents
  * ~~~~~~~~~~~~~~~~~~~~~
@@ -302,9 +303,9 @@ static inline const char *__trace_landlock_print_layers(
  * Blocker fields
  * ~~~~~~~~~~~~~~
  *
- * The filesystem and network blocker arguments identify the request type
- * and carry its final missing access subset when applicable.  The type
- * determines how to interpret the access value.
+ * Blocker arguments identify the request type and carry its final missing
+ * access subset when applicable.  The type determines how to interpret the
+ * access value.
  */
 
 /*
@@ -343,11 +344,12 @@ TRACE_EVENT(landlock_create_ruleset,
 	TP_ARGS(ruleset),
 
 	TP_STRUCT__entry(
-		__field(	u64,		ruleset_id	)
-		__field(	u64,		ruleset_version	)
-		__field(	access_mask_t,	handled_fs	)
-		__field(	access_mask_t,	handled_net	)
-		__field(	access_mask_t,	scoped		)
+		__field(	u64,		ruleset_id		)
+		__field(	u64,		ruleset_version		)
+		__field(	access_mask_t,	handled_fs		)
+		__field(	access_mask_t,	handled_net		)
+		__field(	access_mask_t,	scoped			)
+		__field(	access_mask_t,	handled_permissions	)
 	),
 
 	TP_fast_assign(
@@ -356,13 +358,17 @@ TRACE_EVENT(landlock_create_ruleset,
 		__entry->handled_fs	= ruleset->layer.handled.fs;
 		__entry->handled_net	= ruleset->layer.handled.net;
 		__entry->scoped		= ruleset->layer.handled.scope;
+		__entry->handled_permissions =
+			ruleset->layer.handled.permissions;
 	),
 
-	TP_printk("ruleset=%llx.%llu handled_fs=%s handled_net=%s scoped=%s",
+	TP_printk("ruleset=%llx.%llu handled_fs=%s handled_net=%s scoped=%s handled_permissions=%s",
 		__entry->ruleset_id, __entry->ruleset_version,
 		__print_flags(__entry->handled_fs, "|", _LANDLOCK_ACCESS_FS_NAMES),
 		__print_flags(__entry->handled_net, "|", _LANDLOCK_ACCESS_NET_NAMES),
-		__print_flags(__entry->scoped, "|", _LANDLOCK_SCOPE_NAMES))
+		__print_flags(__entry->scoped, "|", _LANDLOCK_SCOPE_NAMES),
+		__print_flags(__entry->handled_permissions, "|",
+			      _LANDLOCK_PERMISSION_NAMES))
 );
 
 /**
@@ -496,6 +502,56 @@ TRACE_EVENT(landlock_add_rule_net_port,
 		__entry->port)
 );
 
+/**
+ * landlock_add_rule_namespace - Namespace rule added to a ruleset
+ *
+ * @ruleset: Source ruleset (never NULL).
+ * @flags: Complete validated landlock_add_rule_flags value supplied by this
+ *         successful call, not the rule's accumulated quiet state.
+ * @permissions: Validated permission mask from the rule attribute.
+ * @allowed_namespace_types: Effective known namespace types allowed by this
+ *                           call, using CLONE_NEW* values.
+ * @quiet_namespace_types: Effective known namespace types quieted by this
+ *                         call, using CLONE_NEW* values.
+ *
+ * Emitted by sys_landlock_add_rule() under the modified ruleset's lock, so
+ * the reported ruleset is a stable snapshot that no concurrent writer can
+ * change.
+ */
+TRACE_EVENT(landlock_add_rule_namespace,
+
+	TP_PROTO(const struct landlock_ruleset *ruleset, u32 flags,
+		 u64 permissions, u64 allowed_namespace_types,
+		 u64 quiet_namespace_types),
+
+	TP_ARGS(ruleset, flags, permissions, allowed_namespace_types,
+		quiet_namespace_types),
+
+	TP_STRUCT__entry(
+		__field(	u64,		ruleset_id		)
+		__field(	u64,		ruleset_version		)
+		__field(	access_mask_t,	permissions		)
+		__field(	u64,		allowed_namespace_types	)
+		__field(	u64,		quiet_namespace_types	)
+	),
+
+	TP_fast_assign(
+		lockdep_assert_held(&ruleset->lock);
+		__entry->ruleset_id		= ruleset->id;
+		__entry->ruleset_version	= ruleset->version;
+		__entry->permissions		= permissions;
+		__entry->allowed_namespace_types = allowed_namespace_types;
+		__entry->quiet_namespace_types	= quiet_namespace_types;
+	),
+
+	TP_printk("ruleset=%llx.%llu permissions=%s allowed_namespace_types=0x%llx quiet_namespace_types=0x%llx",
+		__entry->ruleset_id, __entry->ruleset_version,
+		__print_flags(__entry->permissions, "|",
+			      _LANDLOCK_PERMISSION_NAMES),
+		__entry->allowed_namespace_types,
+		__entry->quiet_namespace_types)
+);
+
 /**
  * landlock_create_domain - New domain created
  *
@@ -873,6 +929,57 @@ TRACE_EVENT(landlock_deny_access_net,
 		  __entry->port)
 );
 
+/**
+ * landlock_deny_permission_namespace - Namespace use denied
+ *
+ * @hierarchy: Denying domain's hierarchy node (never NULL); its id is the
+ *             domain field.
+ * @same_exec: Whether the current task entered the denying domain itself.
+ * @logged: Whether this denial was selected for audit logging.
+ * @blockers: Request type and final missing permission subset (never NULL).
+ * @namespace_type: CLONE_NEW* namespace type that was denied.
+ * @namespace_id: Namespace ID, or 0 when creation was denied.
+ *
+ * Emitted when a Landlock domain denies namespace use.
+ */
+TRACE_EVENT(landlock_deny_permission_namespace,
+
+	TP_PROTO(const struct landlock_hierarchy *hierarchy, bool same_exec,
+		 bool logged, const struct landlock_blockers *blockers,
+		 u32 namespace_type, u64 namespace_id),
+
+	TP_ARGS(hierarchy, same_exec, logged, blockers, namespace_type,
+		namespace_id),
+
+	TP_STRUCT__entry(
+		__field(	u64,		domain_id	)
+		__field(	bool,		same_exec	)
+		__field(	bool,		logged		)
+		__field(	enum landlock_request_type, blockers_type	)
+		__field(	access_mask_t,	blockers_access	)
+		__field(	u32,		namespace_type	)
+		__field(	u64,		namespace_id	)
+	),
+
+	TP_fast_assign(
+		__entry->domain_id	= hierarchy->id;
+		__entry->same_exec	= same_exec;
+		__entry->logged		= logged;
+		__entry->blockers_type	= blockers->type;
+		__entry->blockers_access = blockers->access;
+		__entry->namespace_type	= namespace_type;
+		__entry->namespace_id	= namespace_id;
+	),
+
+	TP_printk("domain=%llx same_exec=%d logged=%d blockers=%s namespace_type=0x%x namespace_id=%llu",
+		__entry->domain_id, __entry->same_exec, __entry->logged,
+		__entry->blockers_type == LANDLOCK_REQUEST_NAMESPACE ?
+			__print_flags(__entry->blockers_access, "|",
+				      _LANDLOCK_PERMISSION_BLOCKER_NAMES) :
+			"unknown",
+		__entry->namespace_type, __entry->namespace_id)
+);
+
 /**
  * landlock_deny_ptrace - Ptrace access denied by a Landlock domain
  *
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index cceda3b3b961..bb8ec589ddac 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -78,6 +78,11 @@ struct landlock_ruleset_attr {
 	 * @quiet_scoped: Bitmask of scoped actions which should not be logged.
 	 */
 	__u64 quiet_scoped;
+	/**
+	 * @handled_permissions: Bitmask of handled permissions (cf. `Permission
+	 * flags`_).
+	 */
+	__u64 handled_permissions;
 };
 
 /**
@@ -228,6 +233,10 @@ enum landlock_rule_type {
 	 * landlock_net_port_attr .
 	 */
 	LANDLOCK_RULE_NET_PORT,
+	/**
+	 * @LANDLOCK_RULE_NAMESPACE: Type of a &struct landlock_namespace_attr .
+	 */
+	LANDLOCK_RULE_NAMESPACE,
 };
 
 /**
@@ -281,6 +290,41 @@ struct landlock_net_port_attr {
 	__u64 port;
 };
 
+/**
+ * struct landlock_namespace_attr - Namespace type definition
+ *
+ * Argument of sys_landlock_add_rule() with %LANDLOCK_RULE_NAMESPACE.
+ */
+struct landlock_namespace_attr {
+	/**
+	 * @permissions: Must be set to %LANDLOCK_PERMISSION_NAMESPACE_USE.
+	 */
+	__u64 permissions;
+	/**
+	 * @allowed_namespace_types: Bitmask of namespace types (``CLONE_NEW*``
+	 * flags) to allow under this rule.  Unknown bits are silently ignored
+	 * for forward compatibility.
+	 */
+	__u64 allowed_namespace_types;
+	/**
+	 * @quiet_namespace_types: Bitmask of namespace types (``CLONE_NEW*``
+	 * flags) whose denial by this layer should not be submitted to audit,
+	 * even when landlock_restrict_self() enables audit logging.  Only audit
+	 * records attributed to this layer are suppressed; denial tracepoints
+	 * still fire (see `Permission flags`_).  Bits also set in
+	 * @allowed_namespace_types have no effect, since an allowed type is
+	 * never denied.  Unknown bits are silently ignored.
+	 *
+	 * At least one of @allowed_namespace_types or @quiet_namespace_types
+	 * must be non-zero, otherwise the call returns ``-ENOMSG``.  The
+	 * non-zero check runs on the raw input before unknown-bit masking, so a
+	 * rule that sets only bits unknown to the running kernel succeeds but
+	 * has no runtime effect.  Programs should omit this rule when they
+	 * neither allow nor quiet a namespace type.
+	 */
+	__u64 quiet_namespace_types;
+};
+
 /**
  * DOC: fs_access
  *
@@ -507,4 +551,33 @@ struct landlock_net_port_attr {
 #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
 /* clang-format on*/
 
+/**
+ * DOC: permission
+ *
+ * Permission flags
+ * ~~~~~~~~~~~~~~~~
+ *
+ * These flags restrict the use of members of a category, each member being
+ * identified by a constant from another kernel subsystem (e.g. CLONE_NEW*
+ * namespace types, CAP_* capabilities).  A flag covers every kernel path that
+ * uses a member of its category, and members that no rule explicitly allows are
+ * denied.  Values unknown to the running kernel are silently accepted for
+ * forward compatibility and stay denied by default.  See
+ * Documentation/security/landlock.rst for design details.
+ *
+ * When a ruleset handles multiple permissions whose operations overlap (e.g. a
+ * non-user namespace needs both its namespace type and CAP_SYS_ADMIN), the
+ * operation is allowed only if each handled permission independently allows it.
+ * See Documentation/userspace-api/landlock.rst.
+ *
+ * - %LANDLOCK_PERMISSION_NAMESPACE_USE: Restrict the use of specific namespace
+ *   types: creation (:manpage:`unshare(2)`, :manpage:`clone(2)`,
+ *   :manpage:`clone3(2)`), joining (:manpage:`setns(2)`), and acquiring an fd
+ *   reference (:manpage:`open_tree(2)`, :manpage:`fsmount(2)`).  A process in a
+ *   Landlock domain that handles this permission is denied from using namespace
+ *   types that are not explicitly allowed by a %LANDLOCK_RULE_NAMESPACE rule.
+ *   Support added in Landlock ABI version 12.
+ */
+#define LANDLOCK_PERMISSION_NAMESPACE_USE			(1ULL << 0)
+
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index 2711f4876939..e88ca842c782 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -9,7 +9,8 @@ landlock-y := \
 	task.o \
 	fs.o \
 	tsync.o \
-	domain.o
+	domain.o \
+	ns.o
 
 landlock-$(CONFIG_INET) += net.o
 
diff --git a/security/landlock/access.h b/security/landlock/access.h
index 1b1dede27925..e3dbaa29a29f 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -42,14 +42,17 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
 /* Makes sure all scoped rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
+/* Makes sure all permissions can be stored. */
+static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_PERMISSION);
 /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
 static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
-/* Access masks (bitfields only). */
+/* Access and permission masks (bitfields only). */
 struct access_masks {
 	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
 	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
 	access_mask_t scope : LANDLOCK_NUM_SCOPE;
+	access_mask_t permissions : LANDLOCK_NUM_PERMISSION;
 } __packed __aligned(sizeof(u32));
 
 union access_masks_all {
@@ -61,16 +64,34 @@ union access_masks_all {
 static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
 	      sizeof(typeof_member(union access_masks_all, all)));
 
+/**
+ * struct permission_masks - Per-permission member bitmasks
+ */
+struct permission_masks {
+	/**
+	 * @ns_types: Namespace type member mask, indexed in FOR_EACH_NS_TYPE()
+	 * order.
+	 */
+	u64 ns_types : LANDLOCK_NUM_NAMESPACE_TYPE;
+} __packed __aligned(sizeof(u64));
+
+static_assert(sizeof(struct permission_masks) == sizeof(u64));
+
 /**
  * struct layer_config - Per-layer access configuration
  *
  * A ruleset stores one mutable layer and a domain stores a flexible array of
- * immutable layers.
+ * immutable layers.  Unlike filesystem and network access rights, namespace
+ * types use a flat bitmask because their keyspace is small and bounded.
  */
 struct layer_config {
 	/**
-	 * @handled: Bitmask of access rights handled (i.e. restricted) by this
-	 * layer.
+	 * @allowed: Members allowed by each handled permission.
+	 */
+	struct permission_masks allowed;
+	/**
+	 * @handled: Bitmask of access rights and permissions handled (i.e.
+	 * restricted) by this layer.
 	 */
 	struct access_masks handled;
 };
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index e02963834e48..5386f1411ba6 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -21,10 +21,10 @@
 #include "log.h"
 
 /*
- * Access-right and scope names are built from the lists shared with the trace
- * events (see <linux/landlock.h>).  The designated initializer places each name
- * at its bit index, so the lookup stays O(1) and does not depend on the entry
- * order.  log_blockers() adds the "fs."/"net."/"scope." category prefix.
+ * Access-right, scope, and permission names are built from the lists shared
+ * with the trace events (see <linux/landlock.h>).  The designated initializer
+ * places each name at its bit index, so the lookup stays O(1) and does not
+ * depend on the entry order.  log_blockers() adds the related category prefix.
  */
 #define _LANDLOCK_NAME_ENTRY(mask, name) [BIT_INDEX(mask)] = name
 
@@ -40,6 +40,12 @@ static const char *const scope_strings[] = { _LANDLOCK_SCOPE_NAMES };
 
 static_assert(ARRAY_SIZE(scope_strings) == LANDLOCK_NUM_SCOPE);
 
+static const char *const permission_strings[] = {
+	_LANDLOCK_PERMISSION_BLOCKER_NAMES
+};
+
+static_assert(ARRAY_SIZE(permission_strings) == LANDLOCK_NUM_PERMISSION);
+
 #undef _LANDLOCK_NAME_ENTRY
 
 static __attribute_const__ const char *
@@ -73,6 +79,11 @@ get_blocker(const enum landlock_request_type type,
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		WARN_ON_ONCE(access_bit != -1);
 		return scope_strings[BIT_INDEX(LANDLOCK_SCOPE_SIGNAL)];
+
+	case LANDLOCK_REQUEST_NAMESPACE:
+		if (WARN_ON_ONCE(access_bit >= ARRAY_SIZE(permission_strings)))
+			return "unknown";
+		return permission_strings[access_bit];
 	}
 
 	WARN_ON_ONCE(1);
@@ -82,8 +93,8 @@ get_blocker(const enum landlock_request_type type,
 /*
  * Returns the audit category prefix prepended to the unprefixed blocker name
  * returned by get_blocker() (filesystem and network access rights,
- * change_topology, and scopes).  The ptrace blocker is standalone and carries
- * its full name in get_blocker(), so it uses no prefix.
+ * change_topology, scopes, and permissions).  The ptrace blocker is standalone:
+ * its full name comes from get_blocker(), so it uses no prefix.
  */
 static __attribute_const__ const char *
 blocker_prefix(const enum landlock_request_type type)
@@ -102,6 +113,9 @@ blocker_prefix(const enum landlock_request_type type)
 	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
 		return "scope.";
+
+	case LANDLOCK_REQUEST_NAMESPACE:
+		return _LANDLOCK_PERMISSION_NAMESPACE_NAME ".";
 	}
 
 	WARN_ON_ONCE(1);
@@ -163,7 +177,7 @@ static void log_domain(struct landlock_hierarchy *const hierarchy)
  *
  * @request: Detail of the user space request.
  * @youngest_denied: The youngest hierarchy node that denied the access.
- * @missing: The set of denied access rights.
+ * @missing: The set of denied access rights or permissions.
  * @logged: Whether the denial is selected for logging, as computed by
  *          landlock_log_denial() (domain policy and quiet rules).
  *
diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index 636abcd75aff..4c0b1f0e1db5 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -480,6 +480,7 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
 
 #ifdef CONFIG_SECURITY_LANDLOCK_LOG
 	new_dom->hierarchy->quiet_access = ruleset->quiet_access;
+	new_dom->hierarchy->quiet_permission = ruleset->quiet_permission;
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 
 	return no_free_ptr(new_dom);
diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 9d110a89611e..d9e7b96aa639 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -134,6 +134,11 @@ struct landlock_hierarchy {
 	 * logged) if the related object is marked as quiet.
 	 */
 	struct access_masks quiet_access;
+	/**
+	 * @quiet_permission: Per-member quiet bitmasks for permission types in
+	 * this layer.
+	 */
+	struct permission_masks quiet_permission;
 #endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 };
 
@@ -328,4 +333,60 @@ static inline void landlock_get_domain(struct landlock_domain *const domain)
 		refcount_inc(&domain->usage);
 }
 
+/**
+ * landlock_permission_is_denied - Check if a permission request is denied
+ *
+ * @domain: The enforced domain.
+ * @permission_bit: The LANDLOCK_PERMISSION_* flag to check.  Must have
+ *                  exactly one bit set.
+ * @request_value: Compact bitmask to look for (e.g. the result of
+ *                 landlock_ns_type_to_bit()).  Must have exactly one bit set.
+ *
+ * Iterate from the youngest layer to the oldest.  For each layer that handles
+ * @permission_bit, check whether @request_value is present in the layer's
+ * allowed bitmask.  Return on the first (youngest) denying layer.
+ *
+ * Return: The youngest denying layer + 1, or 0 if allowed.
+ */
+static inline size_t
+landlock_permission_is_denied(const struct landlock_domain *const domain,
+			      const access_mask_t permission_bit,
+			      const u64 request_value)
+{
+	ssize_t layer;
+
+	BUILD_BUG_ON(sizeof(permission_bit) > sizeof(u32));
+
+	if (WARN_ON_ONCE(hweight32(permission_bit) != 1) ||
+	    WARN_ON_ONCE(hweight64(request_value) != 1))
+		return domain->num_layers;
+
+	for (layer = domain->num_layers - 1; layer >= 0; layer--) {
+		u64 allowed;
+
+		if (!(domain->layers[layer].handled.permissions &
+		      permission_bit))
+			continue;
+
+		/*
+		 * Current callers pass only permission types with an explicit
+		 * case below.  The default catches a new caller missing its
+		 * member mask.
+		 */
+		switch (permission_bit) {
+		case LANDLOCK_PERMISSION_NAMESPACE_USE:
+			allowed = domain->layers[layer].allowed.ns_types;
+			break;
+		default:
+			WARN_ONCE(1, "Unknown permission %u\n",
+				  (unsigned int)permission_bit);
+			return layer + 1;
+		}
+
+		if (!(allowed & request_value))
+			return layer + 1;
+	}
+	return 0;
+}
+
 #endif /* _SECURITY_LANDLOCK_DOMAIN_H */
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 1a7c5fb8f6fd..767d57799f60 100644
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
 
+#define LANDLOCK_LAST_PERMISSION	LANDLOCK_PERMISSION_NAMESPACE_USE
+#define LANDLOCK_MASK_PERMISSION	((LANDLOCK_LAST_PERMISSION << 1) - 1)
+#define LANDLOCK_NUM_PERMISSION		__const_hweight64(LANDLOCK_MASK_PERMISSION)
+
+#define LANDLOCK_NUM_NAMESPACE_TYPE	__const_hweight64((u64)CLONE_NS_ALL)
+
 #define LANDLOCK_NUM_ACCESS_MAX \
 	MAX(MAX(LANDLOCK_NUM_ACCESS_FS, LANDLOCK_NUM_ACCESS_NET), LANDLOCK_NUM_SCOPE)
 
diff --git a/security/landlock/log.c b/security/landlock/log.c
index 3f9ae1bacb23..8cb1dfd0d4ae 100644
--- a/security/landlock/log.c
+++ b/security/landlock/log.c
@@ -17,6 +17,7 @@
 #include "domain.h"
 #include "limits.h"
 #include "log.h"
+#include "ns.h"
 #include "ruleset.h"
 #include "trace.h"
 
@@ -382,6 +383,31 @@ static bool is_valid_request(const struct landlock_request *const request)
 	if (WARN_ON_ONCE(!(!!request->layer_plus_one ^ !!request->access)))
 		return false;
 
+	if (WARN_ON_ONCE(request->access && request->permission))
+		return false;
+
+	switch (request->type) {
+	case LANDLOCK_REQUEST_NAMESPACE:
+		if (WARN_ON_ONCE(request->permission !=
+				 LANDLOCK_PERMISSION_NAMESPACE_USE) ||
+		    WARN_ON_ONCE(request->audit.type != LSM_AUDIT_DATA_NS))
+			return false;
+		break;
+	case LANDLOCK_REQUEST_PTRACE:
+	case LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY:
+	case LANDLOCK_REQUEST_FS_ACCESS:
+	case LANDLOCK_REQUEST_NET_ACCESS:
+	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
+	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
+		if (WARN_ON_ONCE(request->permission))
+			return false;
+		break;
+	default:
+		WARN_ONCE(1, "Unknown Landlock request type %d\n",
+			  request->type);
+		return false;
+	}
+
 	if (request->access) {
 		if (WARN_ON_ONCE(!(!!request->layer_masks ^
 				   !!request->all_existing_optional_access)))
@@ -442,8 +468,8 @@ is_denial_quieted(const struct landlock_request *const request,
 	}
 
 	/*
-	 * Either the object is not quiet, or this is a scope request.  We check
-	 * request->type to distinguish between the two cases.
+	 * Per-object quieting did not apply.  Check request->type for scope and
+	 * permission quieting; ptrace and topology requests are never quiet.
 	 */
 	switch (request->type) {
 	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
@@ -452,6 +478,9 @@ is_denial_quieted(const struct landlock_request *const request,
 	case LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET:
 		return !!(youngest_denied->quiet_access.scope &
 			  LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	case LANDLOCK_REQUEST_NAMESPACE:
+		return !!(youngest_denied->quiet_permission.ns_types &
+			  landlock_ns_type_to_bit(request->audit.u.ns.ns_type));
 	/*
 	 * Leave LANDLOCK_REQUEST_PTRACE and LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY
 	 * unhandled for now - they are never quiet.
@@ -508,8 +537,8 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
 	if (!is_valid_request(request))
 		return;
 
-	missing = request->access;
-	if (missing) {
+	missing = request->access ? request->access : request->permission;
+	if (request->access) {
 		/* Gets the nearest domain that denies the request. */
 		if (request->layer_masks) {
 			youngest_layer = get_denied_layer(subject->domain,
diff --git a/security/landlock/log.h b/security/landlock/log.h
index faa30e26e42a..a12956cac40e 100644
--- a/security/landlock/log.h
+++ b/security/landlock/log.h
@@ -25,9 +25,11 @@ enum landlock_request_type {
 	LANDLOCK_REQUEST_NET_ACCESS,
 	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
 	LANDLOCK_REQUEST_SCOPE_SIGNAL,
+	LANDLOCK_REQUEST_NAMESPACE,
 };
 
 struct landlock_blockers {
+	/* Blocking access rights or permissions, as selected by @type. */
 	access_mask_t access;
 	enum landlock_request_type type;
 };
@@ -58,8 +60,13 @@ struct landlock_signal_trace {
  * CONFIG_SECURITY_LANDLOCK_LOG is not set.
  */
 struct landlock_request {
-	/* Mandatory fields. */
+	/* Mandatory request type. */
 	enum landlock_request_type type;
+
+	/* Required field for permission requests. */
+	access_mask_t permission;
+
+	/* Mandatory audit context. */
 	struct common_audit_data audit;
 
 	/**
diff --git a/security/landlock/ns.c b/security/landlock/ns.c
new file mode 100644
index 000000000000..cd44c927f83a
--- /dev/null
+++ b/security/landlock/ns.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - Namespace hooks
+ *
+ * Copyright © 2026 Cloudflare, Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/lsm_audit.h>
+#include <linux/lsm_hooks.h>
+#include <linux/ns/ns_common_types.h>
+#include <linux/ns_common.h>
+#include <linux/nsproxy.h>
+#include <uapi/linux/landlock.h>
+
+#include "cred.h"
+#include "domain.h"
+#include "limits.h"
+#include "log.h"
+#include "ns.h"
+#include "ruleset.h"
+#include "setup.h"
+
+#define _LANDLOCK_NS_TYPE(type, flag) flag,
+
+static const u32 landlock_namespace_types[] = {
+	/* clang-format off */
+	FOR_EACH_NS_TYPE(_LANDLOCK_NS_TYPE)
+	/* clang-format on */
+};
+
+#undef _LANDLOCK_NS_TYPE
+
+static_assert(ARRAY_SIZE(landlock_namespace_types) ==
+	      LANDLOCK_NUM_NAMESPACE_TYPE);
+
+/* Ensures the audit ns_id field can hold ns_common.ns_id without truncation. */
+static_assert(sizeof(((struct common_audit_data *)NULL)->u.ns.ns_id) >=
+	      sizeof(((struct ns_common *)NULL)->ns_id));
+
+/**
+ * landlock_ns_type_to_bit - Convert a namespace type to a compact bitmask
+ *
+ * @ns_type: Namespace type (``CLONE_NEW*``).
+ *
+ * Return: The compact bit for @ns_type, or 0 if @ns_type is invalid (with a
+ * warning).
+ */
+u64 landlock_ns_type_to_bit(const u32 ns_type)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(landlock_namespace_types); i++) {
+		if (landlock_namespace_types[i] == ns_type)
+			return BIT_ULL(i);
+	}
+
+	WARN_ONCE(1, "Unknown namespace type 0x%x\n", ns_type);
+	return 0;
+}
+
+/**
+ * landlock_ns_types_to_bits - Convert namespace types to a compact bitmask
+ *
+ * @ns_types: Bitmask of namespace types (``CLONE_NEW*``).
+ *
+ * Return: The compact bits for all known @ns_types.  Warns if unknown bits are
+ * present (callers must pre-mask user input).
+ */
+u64 landlock_ns_types_to_bits(const u64 ns_types)
+{
+	u64 bits = 0;
+	size_t i;
+
+	/* Callers pre-mask (CLONE_NS_ALL); the WARN guards future callers. */
+	WARN_ON_ONCE(ns_types & ~(u64)CLONE_NS_ALL);
+	for (i = 0; i < ARRAY_SIZE(landlock_namespace_types); i++) {
+		if (ns_types & landlock_namespace_types[i])
+			bits |= BIT_ULL(i);
+	}
+	return bits;
+}
+
+static const struct access_masks ns_permission = {
+	.permissions = LANDLOCK_PERMISSION_NAMESPACE_USE,
+};
+
+/**
+ * check_ns_type - Check namespace use permission
+ *
+ * @ns: The namespace being allocated or installed.
+ *
+ * Shared check for namespace_init (creation via clone(2), unshare(2),
+ * open_tree(2), or fsmount(2)) and namespace_install (use via setns(2)): denies
+ * when the namespace type is not in the domain's allowed set.  At allocation
+ * time @ns->ns_id is still zero and is logged as such.
+ *
+ * Return: 0 if allowed, -EPERM if denied.
+ */
+static int check_ns_type(struct ns_common *const ns)
+{
+	const struct landlock_cred_security *subject;
+	size_t denied_layer;
+
+	subject = landlock_get_applicable_subject(current_cred(), ns_permission,
+						  NULL);
+	if (!subject)
+		return 0;
+
+	denied_layer = landlock_permission_is_denied(
+		subject->domain, LANDLOCK_PERMISSION_NAMESPACE_USE,
+		landlock_ns_type_to_bit(ns->ns_type));
+	if (!denied_layer)
+		return 0;
+
+	landlock_log_denial(subject,
+			    &(struct landlock_request){
+				    .type = LANDLOCK_REQUEST_NAMESPACE,
+				    .audit.type = LSM_AUDIT_DATA_NS,
+				    .permission =
+					    LANDLOCK_PERMISSION_NAMESPACE_USE,
+				    .audit.u.ns.ns_type = ns->ns_type,
+				    .audit.u.ns.ns_id = ns->ns_id,
+				    .layer_plus_one = denied_layer,
+			    });
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
+static void test_ns_type_to_bit(struct kunit *const test)
+{
+	u64 seen = 0;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(landlock_namespace_types); i++) {
+		const u64 bit =
+			landlock_ns_type_to_bit(landlock_namespace_types[i]);
+
+		KUNIT_EXPECT_NE(test, 0ULL, bit);
+		KUNIT_EXPECT_EQ(test, 0ULL, seen & bit);
+		seen |= bit;
+	}
+
+	KUNIT_EXPECT_EQ(test, GENMASK_ULL(LANDLOCK_NUM_NAMESPACE_TYPE - 1, 0),
+			seen);
+}
+
+static void test_ns_type_to_bit_unknown(struct kunit *const test)
+{
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	/* clang-format off */
+	kunit_warning_suppress(test) {
+		/* clang-format on */
+		KUNIT_EXPECT_EQ(test, 0ULL,
+				landlock_ns_type_to_bit(CLONE_THREAD));
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+static void test_ns_types_to_bits_all(struct kunit *const test)
+{
+	KUNIT_EXPECT_EQ(test, GENMASK_ULL(LANDLOCK_NUM_NAMESPACE_TYPE - 1, 0),
+			landlock_ns_types_to_bits(CLONE_NS_ALL));
+}
+
+static void test_ns_types_to_bits_single(struct kunit *const test)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(landlock_namespace_types); i++)
+		KUNIT_EXPECT_EQ(
+			test,
+			landlock_ns_type_to_bit(landlock_namespace_types[i]),
+			landlock_ns_types_to_bits(landlock_namespace_types[i]));
+}
+
+static void test_ns_types_to_bits_unknown(struct kunit *const test)
+{
+	if (!IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	/* clang-format off */
+	kunit_warning_suppress(test) {
+		/* clang-format on */
+		KUNIT_EXPECT_EQ(test, 0ULL,
+				landlock_ns_types_to_bits(CLONE_THREAD));
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
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
+	KUNIT_CASE(test_ns_types_to_bits_unknown),
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
index 000000000000..46d3bd17479d
--- /dev/null
+++ b/security/landlock/ns.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - Namespace hooks
+ *
+ * Copyright © 2026 Cloudflare, Inc.
+ */
+
+#ifndef _SECURITY_LANDLOCK_NS_H
+#define _SECURITY_LANDLOCK_NS_H
+
+#include <linux/types.h>
+
+u64 landlock_ns_type_to_bit(u32 ns_type);
+u64 landlock_ns_types_to_bits(u64 ns_types);
+
+__init void landlock_add_ns_hooks(void);
+
+#endif /* _SECURITY_LANDLOCK_NS_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index edf9396deac6..11776b138a56 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -31,15 +31,15 @@
 
 #include <trace/events/landlock.h>
 
-struct landlock_ruleset *
-landlock_create_ruleset(const access_mask_t fs_access_mask,
-			const access_mask_t net_access_mask,
-			const access_mask_t scope_mask)
+struct landlock_ruleset *landlock_create_ruleset(
+	const access_mask_t fs_access_mask, const access_mask_t net_access_mask,
+	const access_mask_t scope_mask, const access_mask_t permission_mask)
 {
 	struct landlock_ruleset *new_ruleset;
 
 	/* Informs about useless ruleset. */
-	if (!fs_access_mask && !net_access_mask && !scope_mask)
+	if (!fs_access_mask && !net_access_mask && !scope_mask &&
+	    !permission_mask)
 		return ERR_PTR(-ENOMSG);
 
 	new_ruleset = kzalloc_obj(*new_ruleset, GFP_KERNEL_ACCOUNT);
@@ -66,6 +66,7 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 		WARN_ON_ONCE(fs_access_mask != mask);
 		new_ruleset->layer.handled.fs |= mask;
 	}
+
 	if (net_access_mask) {
 		const access_mask_t mask = net_access_mask &
 					   LANDLOCK_MASK_ACCESS_NET;
@@ -73,12 +74,22 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
 		WARN_ON_ONCE(net_access_mask != mask);
 		new_ruleset->layer.handled.net |= mask;
 	}
+
 	if (scope_mask) {
 		const access_mask_t mask = scope_mask & LANDLOCK_MASK_SCOPE;
 
 		WARN_ON_ONCE(scope_mask != mask);
 		new_ruleset->layer.handled.scope |= mask;
 	}
+
+	if (permission_mask) {
+		const access_mask_t mask = permission_mask &
+					   LANDLOCK_MASK_PERMISSION;
+
+		WARN_ON_ONCE(permission_mask != mask);
+		new_ruleset->layer.handled.permissions |= mask;
+	}
+
 	return new_ruleset;
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 424055a7af86..3a38d7079dc2 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -184,19 +184,27 @@ struct landlock_ruleset {
 	/**
 	 * @quiet_access: Stores the quiet flags for an unmerged ruleset.  For a
 	 * merged domain, this is stored in each layer's struct
-	 * landlock_hierarchy instead.
+	 * landlock_hierarchy instead.  Its permissions member is unused because
+	 * permission quieting is per member rather than per permission.
 	 */
 	struct access_masks quiet_access;
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	/**
+	 * @quiet_permission: Per-member quiet bitmasks for permission types in
+	 * this ruleset.  A denied member whose bit is set here is not submitted
+	 * to audit when this layer denies it.
+	 */
+	struct permission_masks quiet_permission;
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
 	/**
 	 * @layer: Access configuration for this ruleset's single mutable layer.
 	 */
 	struct layer_config layer;
 };
 
-struct landlock_ruleset *
-landlock_create_ruleset(const access_mask_t access_mask_fs,
-			const access_mask_t access_mask_net,
-			const access_mask_t scope_mask);
+struct landlock_ruleset *landlock_create_ruleset(
+	const access_mask_t access_mask_fs, const access_mask_t access_mask_net,
+	const access_mask_t scope_mask, const access_mask_t permission_mask);
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 
@@ -247,4 +255,10 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
+static inline access_mask_t
+landlock_get_permission_mask(const struct landlock_ruleset *const ruleset)
+{
+	return ruleset->layer.handled.permissions;
+}
+
 #endif /* _SECURITY_LANDLOCK_RULESET_H */
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
index ec616d198184..c37edcc478bc 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -20,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/limits.h>
 #include <linux/mount.h>
+#include <linux/ns/ns_common_types.h>
 #include <linux/path.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
@@ -35,6 +36,7 @@
 #include "fs.h"
 #include "limits.h"
 #include "net.h"
+#include "ns.h"
 #include "ruleset.h"
 #include "setup.h"
 #include "tsync.h"
@@ -98,7 +100,9 @@ static void build_check_abi(void)
 	struct landlock_ruleset_attr ruleset_attr;
 	struct landlock_path_beneath_attr path_beneath_attr;
 	struct landlock_net_port_attr net_port_attr;
+	struct landlock_namespace_attr namespace_attr;
 	size_t ruleset_size, path_beneath_size, net_port_size;
+	size_t namespace_size;
 
 	/*
 	 * For each user space ABI structures, first checks that there is no
@@ -111,8 +115,9 @@ static void build_check_abi(void)
 	ruleset_size += sizeof(ruleset_attr.quiet_access_fs);
 	ruleset_size += sizeof(ruleset_attr.quiet_access_net);
 	ruleset_size += sizeof(ruleset_attr.quiet_scoped);
+	ruleset_size += sizeof(ruleset_attr.handled_permissions);
 	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
-	BUILD_BUG_ON(sizeof(ruleset_attr) != 48);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 56);
 
 	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
 	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
@@ -123,6 +128,12 @@ static void build_check_abi(void)
 	net_port_size += sizeof(net_port_attr.port);
 	BUILD_BUG_ON(sizeof(net_port_attr) != net_port_size);
 	BUILD_BUG_ON(sizeof(net_port_attr) != 16);
+
+	namespace_size = sizeof(namespace_attr.permissions);
+	namespace_size += sizeof(namespace_attr.allowed_namespace_types);
+	namespace_size += sizeof(namespace_attr.quiet_namespace_types);
+	BUILD_BUG_ON(sizeof(namespace_attr) != namespace_size);
+	BUILD_BUG_ON(sizeof(namespace_attr) != 24);
 }
 
 /* Ruleset handling */
@@ -172,7 +183,7 @@ static const struct file_operations ruleset_fops = {
  * If the change involves a fix that requires userspace awareness, also update
  * the errata documentation in Documentation/userspace-api/landlock.rst .
  */
-const int landlock_abi_version = 11;
+const int landlock_abi_version = 12;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
@@ -197,14 +208,13 @@ const int landlock_abi_version = 11;
  * returned errors are:
  *
  * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
- * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small
- *   @size;
+ * - %EINVAL: unknown @flags, access, scope, or permission, or too small @size;
  * - %EINVAL: quiet_access_fs, quiet_access_net, or quiet_scoped is not a
  *   subset of the corresponding handled_access_fs, handled_access_net, or
  *   scoped;
  * - %E2BIG: @attr or @size inconsistencies;
  * - %EFAULT: @attr or @size inconsistencies;
- * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
+ * - %ENOMSG: all handled access, scope, and permission fields are empty.
  *
  * .. kernel-doc:: include/uapi/linux/landlock.h
  *     :identifiers: landlock_create_ruleset_flags
@@ -273,10 +283,16 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
 	    ruleset_attr.scoped)
 		return -EINVAL;
 
+	/* Checks permission content (and 32-bits cast). */
+	if ((ruleset_attr.handled_permissions | LANDLOCK_MASK_PERMISSION) !=
+	    LANDLOCK_MASK_PERMISSION)
+		return -EINVAL;
+
 	/* Checks arguments and transforms to kernel struct. */
 	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
 					  ruleset_attr.handled_access_net,
-					  ruleset_attr.scoped);
+					  ruleset_attr.scoped,
+					  ruleset_attr.handled_permissions);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
@@ -435,13 +451,90 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
 					net_port_attr.allowed_access, flags);
 }
 
+static int add_rule_namespace(struct landlock_ruleset *const ruleset,
+			      const void __user *const rule_attr,
+			      const u32 flags)
+{
+	struct landlock_namespace_attr ns_attr;
+	access_mask_t mask;
+	u64 allowed_types, quiet_types;
+	int ret;
+
+	/*
+	 * Namespace rules support no add-rule flags.  In particular,
+	 * LANDLOCK_ADD_RULE_QUIET is filesystem/network only.
+	 */
+	if (flags)
+		return -EINVAL;
+
+	/* Copies raw user space buffer. */
+	ret = copy_from_user(&ns_attr, rule_attr, sizeof(ns_attr));
+	if (ret)
+		return -EFAULT;
+
+	/* Informs about useless rule: empty permissions. */
+	if (!ns_attr.permissions)
+		return -ENOMSG;
+
+	/*
+	 * The permissions selector must match
+	 * LANDLOCK_PERMISSION_NAMESPACE_USE.  The valid set is a single bit
+	 * today, so this is an exact match now; the check broadens to a subset
+	 * test once another supported permission is added.
+	 */
+	if (ns_attr.permissions != LANDLOCK_PERMISSION_NAMESPACE_USE)
+		return -EINVAL;
+
+	/*
+	 * Checks that permissions match the ruleset constraints.  This also
+	 * makes quieting require the category to be handled.
+	 */
+	mask = landlock_get_permission_mask(ruleset);
+	if (!(mask & LANDLOCK_PERMISSION_NAMESPACE_USE))
+		return -EINVAL;
+
+	/*
+	 * Informs about useless rule: neither allows nor quiets anything.  A
+	 * quiet-only rule (empty allowed set) is legal.
+	 */
+	if (!ns_attr.allowed_namespace_types && !ns_attr.quiet_namespace_types)
+		return -ENOMSG;
+
+	/*
+	 * Stores only the namespace types this kernel knows about.  Unknown
+	 * bits are silently accepted for forward compatibility: user space
+	 * compiled against newer headers can pass new CLONE_NEW* flags without
+	 * getting EINVAL on older kernels.  Unknown bits have no effect because
+	 * no hook checks them.  The quiet bitmask suppresses logging of denials
+	 * attributed to this layer; see landlock_log_denial().
+	 */
+	allowed_types = ns_attr.allowed_namespace_types & CLONE_NS_ALL;
+	quiet_types = ns_attr.quiet_namespace_types & CLONE_NS_ALL;
+
+	mutex_lock(&ruleset->lock);
+	ruleset->layer.allowed.ns_types |=
+		landlock_ns_types_to_bits(allowed_types);
+#ifdef CONFIG_SECURITY_LANDLOCK_LOG
+	ruleset->quiet_permission.ns_types |=
+		landlock_ns_types_to_bits(quiet_types);
+#endif /* CONFIG_SECURITY_LANDLOCK_LOG */
+#ifdef CONFIG_TRACEPOINTS
+	ruleset->version++;
+#endif /* CONFIG_TRACEPOINTS */
+	trace_landlock_add_rule_namespace(ruleset, flags, ns_attr.permissions,
+					  allowed_types, quiet_types);
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
  * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
  *
@@ -458,11 +551,16 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
  *   &landlock_path_beneath_attr.allowed_access or
  *   &landlock_net_port_attr.allowed_access is not a subset of the ruleset
  *   handled accesses)
+ * - %EINVAL: A nonzero &landlock_namespace_attr.permissions is not
+ *   %LANDLOCK_PERMISSION_NAMESPACE_USE or is not handled by the ruleset;
  * - %EINVAL: &landlock_net_port_attr.port is greater than 65535;
  * - %EINVAL: LANDLOCK_ADD_RULE_QUIET is passed but the ruleset has no
  *   quiet access bits set for the corresponding rule type.
  * - %ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access is
  *   0) and no flags;
+ * - %ENOMSG: &landlock_namespace_attr.permissions is 0, or both
+ *   &landlock_namespace_attr.allowed_namespace_types and
+ *   &landlock_namespace_attr.quiet_namespace_types are 0;
  * - %EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
  *   member of @rule_attr is not a file descriptor as expected;
  * - %EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
@@ -495,6 +593,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		return add_rule_path_beneath(ruleset, rule_attr, flags);
 	case LANDLOCK_RULE_NET_PORT:
 		return add_rule_net_port(ruleset, rule_attr, flags);
+	case LANDLOCK_RULE_NAMESPACE:
+		return add_rule_namespace(ruleset, rule_attr, flags);
 	default:
 		return -EINVAL;
 	}
diff --git a/security/landlock/trace.c b/security/landlock/trace.c
index 225dbf37bab0..300afcc82220 100644
--- a/security/landlock/trace.c
+++ b/security/landlock/trace.c
@@ -62,7 +62,7 @@ void landlock_trace_free_domain(const struct landlock_hierarchy *const hierarchy
  *
  * @request: Detail of the user space request.
  * @youngest_denied: The youngest hierarchy node that denied the access.
- * @missing: The final missing access subset, when applicable.
+ * @missing: The final missing access or permission subset, when applicable.
  * @same_exec: Whether the policy subject is the same executable that called
  *             landlock_restrict_self() for the denying domain, as computed
  *             by landlock_log_denial().
@@ -81,6 +81,19 @@ void landlock_trace_denial(
 	const access_mask_t missing, const bool same_exec, const bool logged)
 {
 	switch (request->type) {
+	case LANDLOCK_REQUEST_NAMESPACE:
+		if (trace_landlock_deny_permission_namespace_enabled()) {
+			const struct landlock_blockers blockers = {
+				.access = missing,
+				.type = request->type,
+			};
+
+			trace_landlock_deny_permission_namespace(
+				youngest_denied, same_exec, logged, &blockers,
+				request->audit.u.ns.ns_type,
+				request->audit.u.ns.ns_id);
+		}
+		break;
 	case LANDLOCK_REQUEST_FS_ACCESS:
 	case LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY:
 		if (trace_landlock_deny_access_fs_enabled()) {
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index d20ab8f0862c..58fe322d8637 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(12, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/trace.h b/tools/testing/selftests/landlock/trace.h
index 2ec863362173..fe2d1a0d8de3 100644
--- a/tools/testing/selftests/landlock/trace.h
+++ b/tools/testing/selftests/landlock/trace.h
@@ -101,7 +101,8 @@
 	"ruleset=[0-9a-f]\\+\\.[0-9]\\+ " \
 	"handled_fs=[a-z_|]* "            \
 	"handled_net=[a-z_|]* "           \
-	"scoped=[a-z_|]*$"
+	"scoped=[a-z_|]* "                \
+	"handled_permissions=[a-z._|]*$"
 
 #define REGEX_CREATE_DOMAIN(task)  \
 	TRACE_PREFIX(task)         \
diff --git a/tools/testing/selftests/landlock/trace_test.c b/tools/testing/selftests/landlock/trace_test.c
index f9b293a9dd56..cb49ce8dbeda 100644
--- a/tools/testing/selftests/landlock/trace_test.c
+++ b/tools/testing/selftests/landlock/trace_test.c
@@ -148,7 +148,7 @@ TEST_F(trace, no_trace_when_disabled)
 
 /*
  * Verifies that landlock_create_ruleset emits a trace event with the correct
- * handled access masks.
+ * handled access and permission masks.
  */
 TEST_F(trace, create_ruleset)
 {
@@ -186,6 +186,12 @@ TEST_F(trace, create_ruleset)
 					"handled_net", field, sizeof(field)));
 	EXPECT_STREQ("bind_tcp", field);
 
+	/* Verify that no permission is handled. */
+	EXPECT_EQ(0, tracefs_extract_field(
+			     buf, REGEX_CREATE_RULESET(TRACE_TASK),
+			     "handled_permissions", field, sizeof(field)));
+	EXPECT_STREQ("", field);
+
 	/* Verify version is 0 at creation (no rules added yet). */
 	EXPECT_EQ(0,
 		  tracefs_extract_field(buf, REGEX_CREATE_RULESET(TRACE_TASK),
-- 
2.55.0

