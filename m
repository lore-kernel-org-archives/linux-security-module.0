Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB65443C21
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966478; cv=none; b=bNtYe2vyDGdRMZ6cy0FpN/PraL/iK0gbsC4etWG0prRn6E91YeTbYmmwRUChi/mReiMu01S6Ut9ymdgWEVQse/7RASSRZvkkLWcudi/U56h9DN9dhIr30ie+4+Yt8yfXG12sFN0vfCfVo5LqhqtaAeTp9QH0hcOl2etr/yhx5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966478; c=relaxed/simple;
	bh=nUbDMTZ6HXUAIH0JdBVjuRCza6Gp5Aka8aRQ9KyC+p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiPoh8r8aJueIz+tCRF3caG4Ta2djCkIUlgTdZ5XPafA6oN2IYEn4BNF3ZqUz1halC2uZ32cdfiFNh73hZn/mh613K1GTmcdB/QeL8Wi91pSta8dyYUO5nck2EyLGbVN4sA3G6qWA8/GDluJ8h2OoMBwl5sXN+vAcg5ShRNP6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=poSi5fGM; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="poSi5fGM"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j4PTV4nNszmg2;
	Wed, 14 Oct 2026 10:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791966462;
	bh=8vwir6YjFUOPe/s54OG9Kse8I2PtDPSDONeGSgNwNJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poSi5fGMGN/Cm6vulgOGw8kEp0veS3TUYEKRKi6yVBWg7HMs3yItx7V4TuP5kDMAt
	 XLDfi9lp6MN5FQ+WP+ry+RyHj/VdJ+ro9bYz279B/Z5fVvf15RVQlN+4DwHFPn9x+V
	 qfgrkqRPm4g54vgp3SKp1VB1pdHFdSmvgsLrg/hI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j4PTT0NWJzpXY;
	Wed, 14 Oct 2026 10:27:41 +0200 (CEST)
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
Subject: [PATCH v6 8/8] landlock: Add documentation for capability and namespace restrictions
Date: Wed, 14 Oct 2026 10:27:14 +0200
Message-ID: <20261014082718.1435842-9-mic@digikod.net>
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

Document the two new Landlock permission categories, introduced with ABI
12, in the userspace API guide, admin guide, trace-event guide, UAPI
comments, and kernel security documentation.

The kernel security documentation generalizes the existing per-object
access-rights framing into three restriction models (handled_access_*,
handled_permissions, scoped) and states criteria for choosing among
them, so future permission or scope additions have a documented place to
land.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v3:
https://patch.msgid.link/20260726161400.3010511-13-mic@digikod.net
- Document the new permissions as ABI 12.
- Name the documented audit blockers namespace.use and capability.use
  after their domains.
- Document handled_permissions, the four permission rule and denial
  events, effective no-ops, raw member values, namespace IDs, and
  audit-suppressed denials; add handled_permissions to the basic trace
  example.
- Describe the namespace creation and entry paths, and state that quiet
  denials stay trace-visible.
- Describe the quiet ruleset fields as suppressing audit records rather
  than logs, now that denials are also trace events.

Changes since v2:
https://patch.msgid.link/20260527181127.879771-10-mic@digikod.net
- Fix the CAP_BPF forward-compatibility example in
  Documentation/security/landlock.rst: rules allow-list, so describe a
  rule *allowing* CAP_SYS_ADMIN continuing to allow operations now
  gated by CAP_SYS_ADMIN || CAP_BPF (was worded as a rule "denying";
  suggested by Günther Noack).
- Drop the "category" jargon from the Capability rules and Namespace
  rules summaries in Documentation/userspace-api/landlock.rst and add
  capabilities(7) / namespaces(7) cross-references there, in the rule
  examples, and in the ABI restriction sections (suggested by Günther
  Noack).
- Reword LANDLOCK_PERM_NAMESPACE_USE as gating "acquisition of access
  to namespaces" (was "acquisition of namespace associations") and
  "allow using" (was "allow entering") specific namespace types, to
  match the _USE semantics covering creation, entry, and fd-reference
  (suggested by Günther Noack).
- Document the per-member audit quieting for the new permissions in the
  Capability and namespace restrictions section: the quiet_capabilities
  and quiet_namespace_types rule fields suppress the audit records of
  specific denied members (independently of the allowed members),
  require the permission to be handled, are member-granular, and should
  quiet only known-expected members, never a blanket set.
- Documentation/security/landlock.rst prose polish (suggested by
  Günther Noack):
  hyphenate "user-namespace-based"; reword the design-philosophy
  operation-set sentence; add an introductory paragraph to "Ruleset
  restriction models" (the ruleset denies by default, rules allow-list
  exceptions); split the per-object and per-category sections into
  shorter paragraphs and lead the per-category one with "Each
  LANDLOCK_PERM_* flag maps to its own rule type"; reframe the
  per-object new-operation/new-object-type text around object type
  (was "rule type") and tighten it.
- State the combined deny-by-default explicitly in
  Documentation/userspace-api/landlock.rst: when a domain handles both
  permissions, an operation is allowed only if each independently
  allows it (e.g. unshare(CLONE_NEWNET) needs both CLONE_NEWNET and
  CAP_SYS_ADMIN allowed).
- Note that the open_tree(OPEN_TREE_CLONE) / move_mount anonymous-mount
  bypass path requires CAP_SYS_ADMIN (typically obtained by first
  creating a user namespace).
- Add a concrete downstream-operations example to the per-category
  model in Documentation/security/landlock.rst (denying CAP_SYS_ADMIN
  blocks all admin operations such as mounts).
- Document that creating a non-user namespace always requires
  CAP_SYS_ADMIN, so when the domain handles LANDLOCK_PERM_CAPABILITY_USE
  a rule allowing CAP_SYS_ADMIN is needed even when CLONE_NEWUSER is
  combined in the same unshare() call; only user namespace creation
  needs no capability rule.

Changes since v1:
https://patch.msgid.link/20260312100444.2609563-12-mic@digikod.net

The userspace API and security guides were revamped to match the v2
permission model: the previous chokepoints/gateways prose is replaced
with the per-object (handled_access_*) versus per-category
(handled_perm) framing, and a new Design philosophy section in the
security guide states Landlock's principle (data, processes, kernel
resources).

- Rename namespace_inum to namespace_id in audit field documentation
  to match the renamed audit field.
- Rename LANDLOCK_PERM_NAMESPACE_ENTER references to
  LANDLOCK_PERM_NAMESPACE_USE (companion change to the introducing
  commit), and enumerate the seven kernel paths it gates in the
  userspace API guide (membership via unshare/clone/clone3/setns; fd
  reference via open_tree/fsmount).
- Clarify that LANDLOCK_PERM_NAMESPACE_USE gates *acquisition* of
  namespace associations only (namespaces the process is already a
  member of when the domain is enforced are implicitly allowed) and
  that LANDLOCK_PERM_CAPABILITY_USE gates every exercise of a
  capability after the domain is enforced, regardless of how the
  capability was obtained.
- Document the rationale for accepting (rather than rejecting)
  unknown category member values in rule bodies: rejection would tie
  Landlock policy semantics to the running kernel's category-member
  set, making cross-kernel policies brittle.  Acceptance is fail-safe
  in both directions and lets a policy activate as written when a
  value becomes real on a future kernel.
- Replace handled_perm = 0 with a per-bit mask in the userspace API
  guide's ABI compat fall-through, so future ABI extensions adding
  new LANDLOCK_PERM_* bits do not get stripped on the path that
  drops the v10 bits.
- Add a bridging sentence in the per-category permissions section
  of Documentation/security/landlock.rst contrasting per-category
  permissions with per-object access rights: per-category gates the
  prerequisite operation itself rather than restricting specific
  operations on a single resource instance (suggested by Günther
  Noack).
- Disambiguate the orthogonality invariant in
  Documentation/security/landlock.rst from the UAPI scoped field
  ("all new scoped features" -> "all Landlock access controls";
  suggested by Justin Suess).
- Add an introductory paragraph in
  Documentation/userspace-api/landlock.rst contrasting
  LANDLOCK_PERM_CAPABILITY_USE with PR_SET_NO_NEW_PRIVS: NNP is the
  broader mechanism that blocks privilege acquisition via execve(2),
  while CAPABILITY_USE restricts the exercise of capabilities the
  process already holds (including those gained via CLONE_NEWUSER,
  which NNP does not block); sandboxes typically set both
  (suggested by Justin Suess).
- Disambiguate "category": object-side uses "object type" / "resource
  kind"; "category" stays for the per-category permissions model.
---
 Documentation/admin-guide/LSM/landlock.rst |  46 ++--
 Documentation/security/landlock.rst        | 177 ++++++++++++++-
 Documentation/trace/events-landlock.rst    |  66 ++++--
 Documentation/userspace-api/landlock.rst   | 243 +++++++++++++++++++--
 include/trace/events/landlock.h            |  11 +-
 include/uapi/linux/landlock.h              |  17 +-
 6 files changed, 502 insertions(+), 58 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 2998552bb730..718e0d23ffb5 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -7,7 +7,7 @@ Landlock: system-wide management
 ================================
 
 :Author: Mickaël Salaün
-:Date: August 2026
+:Date: October 2026
 
 Landlock can leverage the audit framework to log events.
 
@@ -20,10 +20,12 @@ Audit
 Denied access requests are logged by default for a sandboxed program if `audit`
 is enabled.  This default behavior can be changed with the
 sys_landlock_restrict_self() flags (cf.
-Documentation/userspace-api/landlock.rst), or suppressed on a per-object
-basis by using ``LANDLOCK_ADD_RULE_QUIET`` (ABI 10+).  Landlock logs can
-also be masked thanks to audit rules.  Landlock can generate 2 audit
-record types.
+Documentation/userspace-api/landlock.rst), suppressed on a per-object
+basis by using ``LANDLOCK_ADD_RULE_QUIET`` (ABI 10+), or suppressed for
+specific capability or namespace members with the corresponding permission
+rule's ``quiet_*`` field (ABI 12+).  Quiet rules only suppress audit submission;
+they do not suppress denial trace events.  Landlock logs can also be masked
+thanks to audit rules.  Landlock can generate two audit record types.
 
 Record types
 ------------
@@ -65,14 +67,28 @@ AUDIT_LANDLOCK_ACCESS
         - scope.abstract_unix_socket - Abstract UNIX socket connection denied
         - scope.signal - Signal sending denied
 
+    **namespace.*** - Namespace restrictions (ABI 12+):
+        - namespace.use - Namespace use was denied (creation via
+          :manpage:`unshare(2)`, :manpage:`clone(2)`, :manpage:`clone3(2)`,
+          :manpage:`open_tree(2)`, or :manpage:`fsmount(2)`, or joining via
+          :manpage:`setns(2)`);
+          ``namespace_type`` indicates the type (hex ``CLONE_NEW*`` bitmask),
+          and ``namespace_id`` identifies the target namespace for
+          :manpage:`setns(2)` operations (zero for creation)
+
+    **capability.*** - Capability restrictions (ABI 12+):
+        - capability.use - Capability use was denied;
+          ``capability`` indicates the capability number
+
     Multiple blockers can appear in a single event (comma-separated) when
     multiple access rights are missing. For example, creating a regular file
     in a directory that lacks both ``make_reg`` and ``refer`` rights would show
     ``blockers=fs.make_reg,fs.refer``.
 
-    The object identification fields (path, dev, ino for filesystem; opid,
-    ocomm for signals) depend on the type of access being blocked and provide
-    context about what resource was involved in the denial.
+    The object identification fields depend on the type of access being blocked:
+    ``path``, ``dev``, ``ino`` for filesystem; ``opid``, ``ocomm`` for signals;
+    ``namespace_type`` and ``namespace_id`` for namespace operations;
+    ``capability`` for capability use.
 
 
 AUDIT_LANDLOCK_DOMAIN
@@ -178,8 +194,9 @@ If you get spammed with audit logs related to Landlock, this is either an
 attack attempt or a bug in the security policy.  We can put in place some
 filters to limit noise with two complementary ways:
 
-- with sys_landlock_restrict_self()'s flags, or
-  ``LANDLOCK_ADD_RULE_QUIET`` (ABI 10+) if we can fix the sandboxed
+- with sys_landlock_restrict_self()'s flags,
+  ``LANDLOCK_ADD_RULE_QUIET`` (ABI 10+), or the permission rules'
+  per-member ``quiet_*`` fields (ABI 12+) if we can fix the sandboxed
   programs,
 - or with audit rules (see :manpage:`auditctl(8)`).
 
@@ -243,8 +260,10 @@ with these exceptions:
 
 - **NOAUDIT hooks**: Some LSM hooks suppress logging for speculative
   permission probes (e.g., reading ``/proc/<pid>/status`` uses
-  ``PTRACE_MODE_NOAUDIT``).  When NOAUDIT is set, neither audit records
-  nor trace events are emitted, and the denial is not counted in
+  ``PTRACE_MODE_NOAUDIT``, and :manpage:`listxattr(2)` probes
+  ``CAP_SYS_ADMIN`` with ``CAP_OPT_NOAUDIT`` to decide whether to list
+  ``trusted.*`` extended attributes).  When NOAUDIT is set, neither audit
+  records nor trace events are emitted, and the denial is not counted in
   ``denials``.  The denial is still enforced.  This avoids performance
   overhead and noise from speculative probes that test permissions
   without performing an actual access.
@@ -269,7 +288,8 @@ Observability security considerations
 
 Both audit records and trace events expose information about all
 Landlock-sandboxed processes on the system, including filesystem paths
-being accessed, network ports, and process identities.  System
+being accessed, network ports, capability numbers, namespace types and IDs,
+and process identities.  System
 administrators must ensure that access to audit logs (controlled by the
 audit subsystem configuration) and to trace events (requiring
 ``CAP_SYS_ADMIN`` or ``CAP_BPF`` + ``CAP_PERFMON``) is restricted to
diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 2d6e1076484e..d81f1c2cd236 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -8,7 +8,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: August 2026
+:Date: October 2026
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -130,6 +130,166 @@ The reasoning is:
   restrictions, because access within the same scope is already
   allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
 
+Composability with user namespaces
+----------------------------------
+
+Landlock domain-based scoping and the kernel's user-namespace-based capability
+scoping enforce isolation over independent hierarchies.  Landlock checks domain
+ancestry; the kernel's ``ns_capable()`` checks user namespace ancestry.  These
+hierarchies are orthogonal: Landlock enforcement is deterministic with respect
+to its own configuration, regardless of namespace or capability state, and vice
+versa.  This orthogonality is a design invariant that must hold for all Landlock
+access controls.
+
+Design philosophy
+-----------------
+
+Landlock's goal is to restrict a sandboxed process's access to three kinds of
+resources: data (files, sockets, pipes), other processes (signals, ptrace), and
+kernel-internal resources whose use widens the kernel attack surface
+(capabilities, namespace types).  Each access right or permission gates one or
+more operations that grant such access; restricting the operations is how
+Landlock restricts the underlying access.
+
+When designing a new access control, identify the protected resource kind
+first (data, processes, or kernel-internal resources).  The operations to
+restrict follow from the protected resource, by identifying which kernel code
+paths grant access to the resource and at which place in the code the access to
+the resource can be gated.  Do not design a permission around
+"restrict the unshare(2) syscall" or similar mechanism-centric framings; design
+it around "restrict the process from acquiring access to namespace types" (the
+protected resource), letting the operation set follow.
+
+Ruleset restriction models
+--------------------------
+
+Landlock provides three restriction models that differ in how rules identify the
+resource being restricted.
+
+In general, the ``struct landlock_ruleset_attr`` specifies the operations to be
+denied by default under the enforced policy.  The *rules* added to the ruleset
+define the exceptions to these restrictions, allow-listing specific conditions
+under which these operations are still permitted.
+
+Per-object access rights (``handled_access_*``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Per-object access rights control operations on a specific resource instance,
+identified in the rule key by a value drawn from an open-ended space: a file
+hierarchy referenced by ``parent_fd``, or a network port identified by its
+16-bit number.
+
+Each ``handled_access_*`` field declares a set of access rights, operations
+which are to be denied by default once the ruleset is enforced.
+
+The rule body declares which of the multiple distinct operations on that object
+instance are allowed (open, read, write, truncate; bind, connect).
+
+Operations are grouped by object type in the respective ``handled_access_*``
+field: a new operation on an existing type extends that field, and a new object
+type gets its own ``handled_access_*`` field.
+
+Per-category permissions (``handled_permissions``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Per-category permissions control the process's exercise of category members,
+where the category is a small kernel-defined enumeration (a Linux capability
+number ``CAP_*``, a namespace type ``CLONE_NEW*``).  Unlike per-object access
+rights, which restrict specific operations on a single resource instance,
+per-category permissions gate the prerequisite operation itself (exercising a
+capability, acquiring access to a namespace), so gating it transitively covers a
+broad set of downstream operations (e.g. denying ``CAP_SYS_ADMIN`` blocks all
+admin operations such as mounts).
+
+These category members are the LSM-level access-control objects (the entities
+the process is authorized against) even though they are enum values rather than
+externally-instantiated kernel data structures.  Per-category permissions apply
+where the controlled operation collapses to "may the process use this category
+member at all" (use a capability; acquire access to a namespace), so the rule
+body lists which category members the process may exercise.
+
+Each ``LANDLOCK_PERMISSION_*`` flag maps to its own rule type and covers every
+kernel path that exercises a member.  When a ruleset handles a permission, all
+uses of category members are denied unless explicitly allowed by a rule.
+
+Logging of a denied member can be suppressed at the same granularity as the
+restriction itself: per rule and per member.  A rule names the members whose
+denial should not be audited; suppression only affects the audit record, never
+the denial or its trace event, which reports ``logged=0``.  Suppression only
+applies when the layer owning the rule is the one that denied the member.
+
+See Documentation/userspace-api/landlock.rst for the concrete syscall paths
+covered by each permission.
+
+The category enum is owned by the corresponding kernel subsystem (capabilities,
+namespaces, etc.).  Userspace policy authors query category member availability
+via the relevant non-Landlock interfaces:
+
+* For capabilities: ``<linux/capability.h>``,
+  ``/proc/sys/kernel/cap_last_cap``, ``prctl(PR_CAPBSET_READ)``.
+* For namespaces: ``<linux/sched.h>``, ``/proc/$$/ns/*``,
+  :manpage:`unshare(2)` runtime probe.
+
+The Landlock ABI version does not encode this availability; ABI versioning
+describes which Landlock features (rule types, access rights, scopes,
+permissions) the kernel implements, not which category members the kernel knows
+about.
+
+Forward compatibility for new category members follows a simple rule set:
+
+* New members in future kernels are automatically denied: rules whitelist
+  specific values, and a member not in any rule is denied.
+* Kernel-side compatibility for split categories is handled by the owning
+  subsystem (e.g., when ``CAP_BPF`` was split from ``CAP_SYS_ADMIN``, either
+  capability became sufficient for the affected operations, so a rule allowing
+  ``CAP_SYS_ADMIN`` continues to allow operations now gated by
+  ``CAP_SYS_ADMIN || CAP_BPF``).
+* Unknown values in the rule body are silently accepted rather than rejected.
+  Rejecting them would tie Landlock policy semantics to the running kernel's
+  category-member set: a rule built against future headers would fail to load
+  on older kernels, forcing policy authors to know each kernel's enumeration.
+  Acceptance is fail-safe in both directions: a rule referring to a value the
+  running kernel does not yet know has no effect (deny-by-default still applies
+  to that operation), and a rule written against future headers loads
+  identically across kernels so the same policy keeps the same restrictions.
+  When a value becomes real on a future kernel, the policy activates as written
+  by the author.
+* In contrast, unknown ``LANDLOCK_PERMISSION_*`` flags in
+  ``handled_permissions`` are rejected (``-EINVAL``), since Landlock owns that
+  bit space.
+
+Cross-domain scopes (``scoped``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Scopes restrict **cross-domain interactions** categorically, without rules.
+Setting a scope flag (e.g.  ``LANDLOCK_SCOPE_SIGNAL``) denies the operation to
+targets outside the Landlock domain or its children.  Like per-category
+permissions, scopes provide complete coverage of the controlled operation.
+
+Choosing a model for a new feature
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* If the new feature controls operations on resource objects supplied by the
+  sandbox author, extend or add a per-object access right
+  (``handled_access_*``).
+* If the new feature controls a per-category operation gated by an enum (a
+  Linux capability, a namespace type, a socket family, etc.), use a
+  per-category permission (``handled_permissions``).  When several such enums
+  could classify the operation, prefer the enum the originating subsystem
+  already uses for capability/access checks (e.g. ``CAP_*`` for ``capable()``
+  hooks, ``CLONE_NEW*`` for namespace hooks).
+* When an operation is gated by multiple kernel-defined enums (a classic
+  example being ``CAP_SYS_ADMIN`` plus a ``CLONE_NEW*`` flag for non-user
+  namespace creation), define one per-category permission per enum dimension.
+  Sandbox authors handle each dimension's permission in ``handled_permissions``
+  and add rules for each; the kernel enforces each dimension at its own LSM
+  hook.  ``LANDLOCK_PERMISSION_NAMESPACE_USE`` and
+  ``LANDLOCK_PERMISSION_CAPABILITY_USE`` follow this pattern.
+* If the new feature restricts a categorical cross-domain interaction with no
+  per-target granularity, use a cross-domain scope (``scoped``).
+* For all three models, confirm a single LSM hook (or small set of related
+  hooks) covers every kernel path that exercises the operation.
+
 Tests
 =====
 
@@ -151,6 +311,18 @@ Filesystem
 .. kernel-doc:: security/landlock/fs.h
     :identifiers:
 
+Namespace
+---------
+
+.. kernel-doc:: security/landlock/ns.h
+    :identifiers:
+
+Capability
+----------
+
+.. kernel-doc:: security/landlock/cap.h
+    :identifiers:
+
 Process credential
 ------------------
 
@@ -198,7 +370,8 @@ whether or not the kernel is built with audit support, so a
 tracepoints-only build reports the selection audit would make.  A quiet
 rule (``LANDLOCK_ADD_RULE_QUIET`` with the access in the ``quiet_*``
 fields of ``struct landlock_ruleset_attr``) suppresses logging by
-setting ``logged=0`` the same way.
+setting ``logged=0`` the same way, as do the per-member ``quiet_*``
+masks of capability and namespace rules.
 
 See Documentation/admin-guide/LSM/landlock.rst for audit record format,
 tracepoint usage, and filtering examples.
diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
index 304a8d06273e..9ccf2769a2d5 100644
--- a/Documentation/trace/events-landlock.rst
+++ b/Documentation/trace/events-landlock.rst
@@ -6,7 +6,7 @@ Landlock Trace Events
 =====================
 
 :Author: Mickaël Salaün
-:Date: September 2026
+:Date: October 2026
 
 Landlock emits trace events for sandbox lifecycle operations and access
 denials.  These events can be consumed by ftrace (for human-readable
@@ -35,6 +35,8 @@ Landlock trace events are organized in four categories:
 - ``landlock_add_rule_net_port``: a network port rule is added to a ruleset
 - ``landlock_create_domain``: a new domain is created from a ruleset
 - ``landlock_enforce_domain``: a domain is enforced on a thread
+- ``landlock_add_rule_namespace``: a namespace rule is added to a ruleset
+- ``landlock_add_rule_capability``: a capability rule is added to a ruleset
 
 **Denial events** are emitted when an access is denied:
 
@@ -44,6 +46,8 @@ Landlock trace events are organized in four categories:
 - ``landlock_deny_scope_signal``: signal delivery denied
 - ``landlock_deny_scope_abstract_unix_socket``: abstract unix socket
   access denied
+- ``landlock_deny_permission_namespace``: namespace use denied
+- ``landlock_deny_permission_capability``: capability use denied
 
 **Rule evaluation events** are emitted during rule matching:
 
@@ -84,7 +88,7 @@ Landlock, not from regular file permissions::
   $ LC_ALL=C LL_FS_RO=/usr:/lib:/lib64:/bin:/etc/ld.so.cache LL_FS_RW=/tmp \
       ./sandboxer cat /etc/passwd
   $ cat /sys/kernel/tracing/trace_pipe
-  cat-127 [...] landlock_create_ruleset: ruleset=195cc6b76.0 handled_fs=execute|write_file|read_file|read_dir|remove_dir|remove_file|make_char|make_dir|make_reg|make_sock|make_fifo|make_block|make_sym|refer|truncate|ioctl_dev|resolve_unix handled_net= scoped=
+  cat-127 [...] landlock_create_ruleset: ruleset=195cc6b76.0 handled_fs=execute|write_file|read_file|read_dir|remove_dir|remove_file|make_char|make_dir|make_reg|make_sock|make_fifo|make_block|make_sym|refer|truncate|ioctl_dev|resolve_unix handled_net= scoped= handled_permissions=
   cat-127 [...] landlock_create_domain: domain=195cc6b7c parent=0 ruleset=195cc6b76.6
   cat-127 [...] landlock_enforce_domain: domain=195cc6b7c complete=1 process_wide=1 no_new_privs=1
   cat-127 [...] landlock_deny_access_fs: domain=195cc6b7c same_exec=0 logged=0 blockers=read_file dev=0:17 ino=5901179 path=/etc/passwd
@@ -119,10 +123,13 @@ in some field formats:
   Audit uses string ``dev="<s_id>"``.  Numeric format is more precise
   for machine parsing.
 
-- **Denied access field**: The ``deny_access_fs`` and ``deny_access_net``
-  tracepoints use the ``blockers=`` field name (same as audit).  Both
-  render the blocked access rights as names: audit prefixes the category
-  and separates with commas (e.g., ``blockers=fs.read_file``), while the
+- **Blocker field**: Denial tracepoints that carry a blocker use the
+  ``blockers=`` field name (same as audit).  The ``deny_access_fs`` and
+  ``deny_access_net`` tracepoints render the blocked access rights, the
+  ``deny_permission_namespace`` and ``deny_permission_capability``
+  tracepoints render the blocked permission, and a ``change_topology``
+  denial renders its request type.  Audit prefixes the category and
+  separates with commas (e.g., ``blockers=fs.read_file``), while the
   tracepoints omit the category (carried by the event name) and separate
   with ``|`` (e.g., ``blockers=read_file``).  Scope and ptrace
   tracepoints omit ``blockers`` because the event name identifies the
@@ -160,10 +167,34 @@ Ruleset versioning
 ==================
 
 Syscall events include a ruleset version (``ruleset=<hex_id>.<version>``)
-that tracks the number of rules added to the ruleset.  The version is
-incremented on each ``landlock_add_rule()`` call and frozen at
-``landlock_restrict_self()`` time.  This enables trace consumers to
-correlate a domain with the exact set of rules it was created from.
+that tracks the number of successful add-rule calls on the ruleset.  The
+version is incremented on each successful ``landlock_add_rule()`` call and
+frozen at ``landlock_restrict_self()`` time.  Namespace and capability calls
+increment it even when their effective known masks are empty or already
+present, so the event stream preserves every successful call.  This enables
+trace consumers to correlate a domain with the exact rule history from which
+it was created.
+
+Permission rule and denial events
+=================================
+
+``landlock_create_ruleset`` reports handled permissions as symbolic names in
+``handled_permissions=``.  ``landlock_add_rule_namespace`` and
+``landlock_add_rule_capability`` report ``permissions=`` plus the effective
+known allowed and quiet member masks.  Capability masks and the raw
+``CLONE_NEW*`` namespace masks are printed in hexadecimal.  Unknown-only input
+therefore appears as zero while still advancing the ruleset version, and adding
+a member already present still emits an event.
+
+``landlock_deny_permission_namespace`` reports the denied raw
+``CLONE_NEW*`` value.  ``namespace_id`` is zero for namespace creation and is
+the exact target namespace ID for :manpage:`setns(2)`.
+``landlock_deny_permission_capability`` reports the denied ``CAP_*`` number.
+Like every denial event, both include the denying domain, ``same_exec``, and
+``logged``.
+
+Per-member quiet masks suppress audit submission but never these trace events,
+which report ``logged=0``.
 
 Domain enforcement
 ==================
@@ -290,8 +321,8 @@ per-domain state in BPF maps:
    ``domain=`` key (join to the ``create_domain`` recorded in step 1),
    building the per-domain thread set; filter ``complete==1`` for a
    one-event-per-operation summary.
-3. On ``landlock_deny_access_*``: look up the domain, decide whether
-   to count, alert, or ignore the denial based on custom policy.
+3. On ``landlock_deny_*``: look up the domain, decide whether to count,
+   alert, or ignore the denial based on custom policy.
 4. On ``landlock_free_domain``: clean up the per-domain state, log
    final statistics.
 
@@ -304,11 +335,12 @@ reconcile incomplete state.
 Audit filtering equivalence
 ===========================
 
-The ``logged`` field reflects the domain's log policy but not the global
-``audit_enabled`` toggle, so it does not change when audit is turned on
-or off.  When audit is enabled, ``logged==1`` selects the denials the
-domain submits to audit (audit-side rate-limiting and exclude rules may
-still drop some), so a stateless ftrace filter can select them::
+The ``logged`` field reflects the domain's log policy and per-request quiet
+selection, but not the global ``audit_enabled`` toggle, so it does not
+change when audit is turned on or off.  When audit is enabled, ``logged==1``
+selects the denials the domain submits to audit (audit-side rate-limiting and
+exclude rules may still drop some), so a stateless ftrace filter can select
+them::
 
     # Show only denials that audit would also log:
     echo 'logged==1' > \
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 84cb7bf6b3ed..3d45b956b640 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: August 2026
+:Date: October 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -29,21 +29,30 @@ If Landlock is not currently supported, we need to
 Landlock rules
 ==============
 
-A Landlock rule describes an action on an object which the process intends to
-perform.  A set of rules is aggregated in a ruleset, which can then restrict
-the thread enforcing it, and its future children.
+A Landlock rule describes the actions a process is allowed to perform on a
+specific resource.  A set of rules is aggregated in a ruleset, which can then
+restrict the thread enforcing it, and its future children.
 
-The two existing types of rules are:
+The existing types of rules are:
 
 Filesystem rules
-    For these rules, the object is a file hierarchy,
-    and the related filesystem actions are defined with
-    `filesystem access rights`.
+    The rule key is a file hierarchy, and the actions it allows are
+    defined with `filesystem access rights`.
 
 Network rules (since ABI v4 for TCP and v10 for UDP)
     For these rules, the object is a TCP or UDP port,
     and the related actions are defined with `network access rights`.
 
+Capability rules (since ABI v12)
+    The rule body lists which Linux capabilities (see
+    :manpage:`capabilities(7)`) the process may exercise; the action is
+    defined with `permission flags`.
+
+Namespace rules (since ABI v12)
+    The rule body lists which namespace types (see
+    :manpage:`namespaces(7)`) the process may use; the action is defined
+    with `permission flags`.
+
 Defining and enforcing a security policy
 ----------------------------------------
 
@@ -87,6 +96,9 @@ to be explicit about the denied-by-default access rights.
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
             LANDLOCK_SCOPE_SIGNAL,
+        .handled_permissions =
+            LANDLOCK_PERMISSION_NAMESPACE_USE |
+            LANDLOCK_PERMISSION_CAPABILITY_USE,
     };
 
 Because we may not know which kernel version an application will be executed
@@ -140,6 +152,13 @@ version, and only use the available subset of access rights:
         ruleset_attr.handled_access_net &=
             ~(LANDLOCK_ACCESS_NET_BIND_UDP |
               LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+        __attribute__((fallthrough));
+    case 10:
+    case 11:
+        /* Removes LANDLOCK_PERMISSION_* for ABI < 12 */
+        ruleset_attr.handled_permissions &=
+            ~(LANDLOCK_PERMISSION_NAMESPACE_USE |
+              LANDLOCK_PERMISSION_CAPABILITY_USE);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -242,6 +261,56 @@ the program explicitly called :manpage:`bind(2)` on port 0.
         err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
                                 &udp_bind, 0);
 
+Capability and namespace rules use a different attribute layout:
+``permissions`` identifies the permission category (a single
+``LANDLOCK_PERMISSION_*`` flag) and a type-specific value field carries the
+bitmask to allow within it.  See `Capability and namespace restrictions`_ for
+the model.
+
+For capability access-control, we can add rules that allow specific
+capabilities (see :manpage:`capabilities(7)` for the list of ``CAP_*``
+values).  For instance, to allow ``CAP_SYS_CHROOT`` (so the sandboxed
+process can call :manpage:`chroot(2)` inside a user namespace):
+
+.. code-block:: c
+
+    struct landlock_capability_attr cap_attr = {
+        .permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
+        .allowed_capabilities = (1ULL << CAP_SYS_CHROOT),
+    };
+
+    cap_attr.permissions &= ruleset_attr.handled_permissions;
+    if (cap_attr.permissions)
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+                                &cap_attr, 0);
+
+For namespace access-control, we can add rules that allow using specific
+namespace types (see :manpage:`namespaces(7)` for the list of ``CLONE_NEW*``
+values): creating them via :manpage:`unshare(2)` / :manpage:`clone(2)` /
+:manpage:`clone3(2)`, joining them via :manpage:`setns(2)`, or acquiring an fd
+reference via :manpage:`open_tree(2)` / :manpage:`fsmount(2)`.  For instance,
+to allow creating user namespaces (which grants all capabilities inside the new
+namespace):
+
+.. code-block:: c
+
+    struct landlock_namespace_attr ns_attr = {
+        .permissions = LANDLOCK_PERMISSION_NAMESPACE_USE,
+        .allowed_namespace_types = CLONE_NEWUSER,
+    };
+
+    ns_attr.permissions &= ruleset_attr.handled_permissions;
+    if (ns_attr.permissions)
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
+                                &ns_attr, 0);
+
+Together, these two rules allow an unprivileged process to create a user
+namespace and call :manpage:`chroot(2)` inside it, while denying all other
+capabilities and namespace types.  User namespace creation is the one operation
+that does not require ``CAP_SYS_ADMIN``, so no capability rule is needed for it.
+See `Capability and namespace restrictions`_ for details on capability
+requirements.
+
 When passing a non-zero ``flags`` argument to ``landlock_restrict_self()``, a
 similar backwards compatibility check is needed for the restrict flags
 (see sys_landlock_restrict_self() documentation for available flags):
@@ -442,9 +511,139 @@ The operations which can be scoped are:
     A :manpage:`sendto(2)` on a socket which was previously connected will not
     be restricted.  This works for both datagram and stream sockets.
 
-IPC scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.
-If an operation is scoped within a domain, no rules can be added to allow access
-to resources or processes outside of the scope.
+Scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.  If an
+operation is scoped within a domain, no rules can be added to allow access to
+resources or processes outside of the scope.
+
+Capability and namespace restrictions
+-------------------------------------
+
+``handled_permissions`` declares per-category permissions: each permission
+selects which members of a kernel-defined category (CAP_* capabilities,
+CLONE_NEW* namespace types) the process may use.  Unlike per-object access
+rights (``handled_access_*``) or cross-domain scopes (``scoped``), per-category
+permissions constrain the sandboxed process's own use of these enums; members
+not allowed by a rule are denied by default.
+
+``LANDLOCK_PERMISSION_NAMESPACE_USE`` gates *acquisition of access* to
+namespaces: creation via :manpage:`unshare(2)` / :manpage:`clone(2)`
+/ :manpage:`clone3(2)`, entry via :manpage:`setns(2)`, and fd-reference
+acquisition via :manpage:`open_tree(2)` / :manpage:`fsmount(2)`.  Namespaces
+the process is already a member of when the domain is enforced are implicitly
+allowed (the process could not continue running otherwise); rules describe
+which new namespace types the process may acquire.
+``LANDLOCK_PERMISSION_CAPABILITY_USE`` gates every exercise of a capability
+after the domain is enforced, regardless
+of how the capability was obtained (inherited credentials, ``CLONE_NEWUSER``
+grant, ``setuid``/file-cap-bearing :manpage:`execve(2)`, etc.).  Configuring
+both together restricts what privileges are available *and* the namespaces in
+which they take effect, which matters because user namespace creation has no
+capability check and grants all capabilities within the new namespace: gating
+only one of the two leaves a kernel attack-surface widening path open.  When a
+domain handles both permissions, an operation is allowed only if each
+independently allows it: :manpage:`unshare(2)` with ``CLONE_NEWNET`` then
+requires both a rule allowing ``CLONE_NEWNET`` and a rule allowing
+``CAP_SYS_ADMIN``.
+
+``LANDLOCK_PERMISSION_CAPABILITY_USE`` complements :manpage:`prctl(2)`
+``PR_SET_NO_NEW_PRIVS`` but does not replace it.  ``PR_SET_NO_NEW_PRIVS``
+prevents privilege *acquisition* via :manpage:`execve(2)` (setuid, file
+capability xattrs, privilege-elevating LSM transitions) and is a prerequisite
+for unprivileged Landlock self-sandboxing.
+``LANDLOCK_PERMISSION_CAPABILITY_USE`` restricts *exercise* of capabilities the
+process already holds, including those
+gained via ``CLONE_NEWUSER`` which ``PR_SET_NO_NEW_PRIVS`` does not block.
+Sandboxes typically set both.
+
+Rules are added with ``LANDLOCK_RULE_CAPABILITY`` and &struct
+landlock_capability_attr (each rule lists ``CAP_*`` values to allow), and with
+``LANDLOCK_RULE_NAMESPACE`` and &struct landlock_namespace_attr (each rule
+lists ``CLONE_NEW*`` flags to allow).  Landlock is purely restrictive: it can
+only deny what the traditional check would have allowed, never grant additional
+privileges.
+
+Denials of specific capabilities or namespace types can be excluded from audit
+logging per rule, by listing them in the ``quiet_capabilities`` or
+``quiet_namespace_types`` field of the rule (independently of the allowed
+members).  Quieting requires the permission to be handled, is member-granular,
+and only suppresses the audit record of a denial attributed to the rule's own
+layer; it never changes the denial itself or suppresses its trace event, which
+reports ``logged=0``.  Sandboxes should quiet only specific members known to be
+requested but expected to be denied (for example for compatibility with older
+callers), never a blanket set: a blanket set follows the running kernel's known
+members and would hide surprising or future denials from audit.
+
+Rule bodies silently accept values unknown to the current kernel (capabilities
+above ``CAP_LAST_CAP``, unrecognised ``CLONE_NEW*`` bits): they have no runtime
+effect, so a rule compiled against future kernel headers loads without error on
+older kernels.  Future kernels gain new members denied by default until a rule
+explicitly allows them.
+
+The single ``LANDLOCK_PERMISSION_NAMESPACE_USE`` bit gates every kernel path
+that grants the calling process access to a namespace of the controlled types,
+whether by becoming a member of the namespace or by holding a file descriptor
+that references it.  The covered syscall paths are:
+
+* :manpage:`unshare(2)` with ``CLONE_NEW*``: the caller becomes a member of a
+  newly-created namespace.
+* :manpage:`clone(2)` (or :manpage:`clone3(2)`) with ``CLONE_NEW*``: the
+  child becomes a member of a newly-created namespace.
+* :manpage:`setns(2)`: the caller becomes a member of an existing namespace
+  referenced by file descriptor.
+* :manpage:`open_tree(2)` with ``OPEN_TREE_NAMESPACE``: the caller obtains a
+  file descriptor referring to a newly-created mount namespace.
+* :manpage:`open_tree(2)` with ``OPEN_TREE_CLONE``: the caller obtains a file
+  descriptor referring to a newly-created anonymous mount namespace.
+* :manpage:`fsmount(2)` with ``FSMOUNT_NAMESPACE``: the caller obtains a file
+  descriptor referring to a newly-created mount namespace.
+* :manpage:`fsmount(2)` (default): the caller obtains a file descriptor
+  referring to a newly-created anonymous mount namespace.
+
+Anonymous mount namespaces (created by ``open_tree(OPEN_TREE_CLONE)`` and the
+default :manpage:`fsmount(2)`) are intentionally covered by the bit even though
+the calling process does not become a member of them.  Without this coverage, a
+sandboxed process could combine ``open_tree(OPEN_TREE_CLONE)`` with
+:manpage:`move_mount(2)` to graft mounts from a freshly-allocated mount
+namespace into its current namespace, bypassing a ``CLONE_NEWNS`` restriction
+(these mount operations require ``CAP_SYS_ADMIN``, which a sandboxed process
+typically obtains by first creating a user namespace).
+
+In practice, unprivileged processes first create a user namespace (which
+requires no capability and grants all capabilities within it), then use those
+capabilities to create other namespace types.  All non-user namespace types
+require ``CAP_SYS_ADMIN`` for both creation and :manpage:`setns(2)` entry; mount
+namespace entry additionally requires ``CAP_SYS_CHROOT``.  For
+:manpage:`setns(2)`, capabilities are checked relative to the target namespace,
+so a process in an ancestor user namespace naturally satisfies them; this
+includes joining user namespaces, which requires ``CAP_SYS_ADMIN``.  When
+``LANDLOCK_PERMISSION_CAPABILITY_USE`` is also handled, each of these
+capabilities must be explicitly allowed by a rule.
+
+Creating a non-user namespace always requires ``CAP_SYS_ADMIN``, and
+``LANDLOCK_PERMISSION_CAPABILITY_USE`` (when handled) gates that check
+regardless of which user namespace it targets.  This is true whether the
+namespace is created
+on its own, combined with ``CLONE_NEWUSER`` in a single :manpage:`unshare(2)`
+call, or in a separate :manpage:`unshare(2)` call after a user namespace: in
+all cases the kernel checks ``CAP_SYS_ADMIN`` against the owning user
+namespace, and Landlock denies it unless a rule allows
+``CAP_SYS_ADMIN``.  Combining ``CLONE_NEWUSER`` with another ``CLONE_NEW*``
+flag therefore does not avoid the capability check; only user namespace
+creation itself needs no capability rule.
+
+When creating child user namespaces, it is recommended to also create a
+dedicated Landlock domain with restrictions relevant to each namespace context.
+
+Note that ``LANDLOCK_PERMISSION_CAPABILITY_USE`` restricts the *use* of
+capabilities, not their presence in the process's credential.  Capability sets
+can change
+after a domain is enforced through user namespace entry or :manpage:`capset(2)`;
+privileged sandboxes that did not set ``PR_SET_NO_NEW_PRIVS`` may also gain
+capabilities through :manpage:`execve(2)` of binaries with file capabilities.
+In all cases, :manpage:`capget(2)` will report the credential's capability sets,
+but any denied capability will fail with ``EPERM`` when exercised.  Do not rely
+on :manpage:`capget(2)` to determine whether the policy permits a given
+capability; only the actual operation will return ``EPERM`` upon denial.
 
 Truncating files
 ----------------
@@ -610,7 +809,7 @@ Access rights
 -------------
 
 .. kernel-doc:: include/uapi/linux/landlock.h
-    :identifiers: fs_access net_access scope
+    :identifiers: fs_access net_access scope permission
 
 Creating a new ruleset
 ----------------------
@@ -629,7 +828,8 @@ Extending a ruleset
 
 .. kernel-doc:: include/uapi/linux/landlock.h
     :identifiers: landlock_rule_type landlock_path_beneath_attr
-                  landlock_net_port_attr
+                  landlock_net_port_attr landlock_capability_attr
+                  landlock_namespace_attr
 
 Enforcing a ruleset
 -------------------
@@ -834,6 +1034,23 @@ with ``LANDLOCK_RESTRICT_SELF_TSYNC``, no_new_privs is set on all threads
 of the process.  As explained in the tutorial above, leaving no_new_privs
 unset is risky even when Landlock does not require it.
 
+Capability (ABI < 12)
+---------------------
+
+Starting with the Landlock ABI version 12, it is possible to restrict
+:manpage:`capabilities(7)` with the new ``LANDLOCK_PERMISSION_CAPABILITY_USE``
+permission flag and ``LANDLOCK_RULE_CAPABILITY`` rule type.
+
+Namespace (ABI < 12)
+--------------------
+
+Starting with the Landlock ABI version 12, it is possible to restrict namespace
+use (see :manpage:`namespaces(7)`) across creation (:manpage:`unshare(2)`,
+:manpage:`clone(2)`, :manpage:`clone3(2)`), entry (:manpage:`setns(2)`), and
+fd-reference acquisition (:manpage:`open_tree(2)`, :manpage:`fsmount(2)`) with
+the new ``LANDLOCK_PERMISSION_NAMESPACE_USE`` permission flag and
+``LANDLOCK_RULE_NAMESPACE`` rule type.
+
 .. _kernel_support:
 
 Kernel support
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index 744ef55ec1de..4f19d1c04d74 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -278,11 +278,12 @@ static inline const char *__trace_landlock_print_layers(
  * Every denial event shares three fields.  domain is the ID of the
  * innermost domain that blocked the access.  same_exec tells whether the
  * current task is the same executable that entered that domain.  logged is
- * the domain's audit-logging decision for this denial (its log_status is
- * enabled and the per-execution flag selected by same_exec is set); a
- * stateless ftrace filter can select the denials the domain submits to
- * audit with logged==1, without reconstructing it from the per-execution
- * log flags.  Denial events order their shared fields as domain, same_exec,
+ * the complete audit-submission selection for this denial: the domain's
+ * log_status and per-execution flag, per-object or per-member quiet rules,
+ * and request-specific no-audit options.  This excludes global audit state
+ * and audit-side filters.  A stateless ftrace filter can select the denials
+ * the domain submits to audit with logged==1, without reconstructing those
+ * inputs.  Denial events order their shared fields as domain, same_exec,
  * and logged.  Access and permission denial events follow these with the
  * blockers verdict input, type-specific fields, and any variable-length field.
  *
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 3128e58d4b78..24510e5d8479 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -33,14 +33,14 @@
  * (and that they have tested with a kernel that supported them all).
  *
  * @quiet_access_fs and @quiet_access_net are bitmasks of actions for which a
- * denial by this layer will not trigger a log if the corresponding object (or
- * its children, for filesystem rules) is marked with the "quiet" bit via
- * %LANDLOCK_ADD_RULE_QUIET, even if logging would normally take place per
+ * denial by this layer will not trigger an audit record if the corresponding
+ * object (or its children, for filesystem rules) is marked with the "quiet" bit
+ * via %LANDLOCK_ADD_RULE_QUIET, even if logging would normally take place per
  * landlock_restrict_self() flags.  @quiet_scoped is similar, except that it
  * does not require marking any objects as quiet - if the ruleset is created
  * with any bits set in @quiet_scoped, then denial of such scoped resources will
- * not trigger any log.  These 3 fields are available since Landlock ABI version
- * 10.
+ * not trigger an audit record.  These three fields are available since Landlock
+ * ABI version 10.
  *
  * @quiet_access_fs, @quiet_access_net and @quiet_scoped must be a subset of
  * @handled_access_fs, @handled_access_net and @scoped respectively.
@@ -66,16 +66,17 @@ struct landlock_ruleset_attr {
 	__u64 scoped;
 	/**
 	 * @quiet_access_fs: Bitmask of filesystem actions which should not be
-	 * logged if per-object quiet flag is set.
+	 * submitted to audit if the per-object quiet flag is set.
 	 */
 	__u64 quiet_access_fs;
 	/**
 	 * @quiet_access_net: Bitmask of network actions which should not be
-	 * logged if per-object quiet flag is set.
+	 * submitted to audit if the per-object quiet flag is set.
 	 */
 	__u64 quiet_access_net;
 	/**
-	 * @quiet_scoped: Bitmask of scoped actions which should not be logged.
+	 * @quiet_scoped: Bitmask of scoped actions which should not be
+	 * submitted to audit.
 	 */
 	__u64 quiet_scoped;
 	/**
-- 
2.55.0

