Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A593CF69C
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082507; cv=none; b=iDffzSF1TVEgiWVcehNy4JUiPNZLbYMCbBi5uJgwl0AjXAPJN3tf562+4TCT5cs/fNIc70HwgPi96OV0PIZpoKrbtiXRmO1P4zbRRVjRpTo8CxTh6OviXu2ZRglEe1f2AZTlTGgI+8mrrTPvPxkPV2/VmXT1q5a4zEvpPl5UHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082507; c=relaxed/simple;
	bh=4oMJSddZ2EmnmNqizDOt80wDOwv+8LEugiCaapKU/JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DthKC/w48R2wQridU3XAhMFDlmQZxMETulm5r06ZS4wq9VW9YS+/Ol4ZRbKd0pTE+6RwPJa++mfzXTSSjxTW0jKfVHS3A9dyA3ceNMkr1CU8WGV5Bb38Mepc7r+OHNNaYmdXfMtCxQeo85GEUaH3rczITPPla+g0Ofx7rCM9wFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zXXw5Zab; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zXXw5Zab"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h7Rd407KKzcNW;
	Sun, 26 Jul 2026 18:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785082471;
	bh=MxjSVwm5Sna6GMUa5pEOCodZW/qxY068uPxoBe2zkp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zXXw5ZabG+aRhvE80a3BNBVPbMcyjPB1G1J0ZHwWySI0Qheghf6mGUIFvTHkJzIJu
	 fUGBTgviJ2Xmh2IDo14azEuvGQHuBLIbFqOI5ODkkvlhzWKOhhzV2ccsmdkmsH3f8x
	 EIZCbL+jqhqHW6UDPlQ4Xc72y2OTGa9oAg2NOVm4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h7Rd30lB5zpSK;
	Sun, 26 Jul 2026 18:14:31 +0200 (CEST)
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
Subject: [PATCH v3 12/12] landlock: Add documentation for capability and namespace restrictions
Date: Sun, 26 Jul 2026 18:13:57 +0200
Message-ID: <20260726161400.3010511-13-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-1-mic@digikod.net>
References: <20260726161400.3010511-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Document the two new Landlock permission categories in the userspace API
guide, admin guide, and kernel security documentation.

The userspace API guide adds sections on capability restriction
(LANDLOCK_PERM_CAPABILITY_USE with LANDLOCK_RULE_CAPABILITY) and
namespace restriction (LANDLOCK_PERM_NAMESPACE_USE with
LANDLOCK_RULE_NAMESPACE, covering creation, entry, and fd-reference
acquisition), the backward-compatible degradation pattern for Landlock
ABI < 11, and the per-namespace-type capability requirements.

The admin guide adds the new perm.namespace_use and perm.capability_use
audit blocker names with their object identification fields
(namespace_type, namespace_id, capability).

The kernel security documentation adds a "Ruleset restriction models"
section defining the three models (handled_access_*, handled_perm,
scoped), their coverage and compatibility properties, and the criteria
for choosing between them for future features.  It also documents
composability with user namespaces and adds kernel-doc references for
the new capability and namespace headers.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

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
 Documentation/admin-guide/LSM/landlock.rst |  19 +-
 Documentation/security/landlock.rst        | 173 ++++++++++++++-
 Documentation/userspace-api/landlock.rst   | 236 +++++++++++++++++++--
 3 files changed, 410 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 314052bbeb0a..8d3b20a72f20 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -6,7 +6,7 @@ Landlock: system-wide management
 ================================
 
 :Author: Mickaël Salaün
-:Date: June 2026
+:Date: July 2026
 
 Landlock can leverage the audit framework to log events.
 
@@ -63,14 +63,25 @@ AUDIT_LANDLOCK_ACCESS
         - scope.abstract_unix_socket - Abstract UNIX socket connection denied
         - scope.signal - Signal sending denied
 
+    **perm.*** - Permission restrictions (ABI 11+):
+        - perm.namespace_use - Namespace entry was denied (creation via
+          :manpage:`unshare(2)` / :manpage:`clone(2)` or joining via
+          :manpage:`setns(2)`);
+          ``namespace_type`` indicates the type (hex CLONE_NEW* bitmask),
+          ``namespace_id`` identifies the target namespace for
+          :manpage:`setns(2)` operations
+        - perm.capability_use - Capability use was denied;
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
diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index c5186526e76f..18f14652c20c 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: March 2026
+:Date: July 2026
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -129,6 +129,165 @@ The reasoning is:
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
+Per-category permissions (``handled_perm``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+Each ``LANDLOCK_PERM_*`` flag maps to its own rule type and covers every kernel
+path that exercises a member.  When a ruleset handles a permission, all uses of
+category members are denied unless explicitly allowed by a rule.
+
+Logging of a denied member can be suppressed at the same granularity as the
+restriction itself: per rule and per member.  A rule names the members whose
+denial should not be audited; suppression only affects the audit record, never
+the denial, and only applies when the layer owning the rule is the one that
+denied the member.
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
+* In contrast, unknown ``LANDLOCK_PERM_*`` flags in ``handled_perm`` are
+  rejected (``-EINVAL``), since Landlock owns that bit space.
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
+  per-category permission (``handled_perm``).  When several such enums could
+  classify the operation, prefer the enum the originating subsystem already
+  uses for capability/access checks (e.g. ``CAP_*`` for ``capable()`` hooks,
+  ``CLONE_NEW*`` for namespace hooks).
+* When an operation is gated by multiple kernel-defined enums (a classic
+  example being ``CAP_SYS_ADMIN`` plus a ``CLONE_NEW*`` flag for non-user
+  namespace creation), define one per-category permission per enum dimension.
+  Sandbox authors handle each dimension's permission in ``handled_perm`` and
+  add rules for each; the kernel enforces each dimension at its own LSM hook.
+  ``LANDLOCK_PERM_NAMESPACE_USE`` and ``LANDLOCK_PERM_CAPABILITY_USE`` follow
+  this pattern.
+* If the new feature restricts a categorical cross-domain interaction with no
+  per-target granularity, use a cross-domain scope (``scoped``).
+* For all three models, confirm a single LSM hook (or small set of related
+  hooks) covers every kernel path that exercises the operation.
+
 Tests
 =====
 
@@ -150,6 +309,18 @@ Filesystem
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
 
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 5a63d4476c1c..652f55e8cd8c 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: June 2026
+:Date: July 2026
 
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
 
+Capability rules (since ABI v11)
+    The rule body lists which Linux capabilities (see
+    :manpage:`capabilities(7)`) the process may exercise; the action is
+    defined with `permission flags`.
+
+Namespace rules (since ABI v11)
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
+        .handled_perm =
+            LANDLOCK_PERM_CAPABILITY_USE |
+            LANDLOCK_PERM_NAMESPACE_USE,
     };
 
 Because we may not know which kernel version an application will be executed
@@ -140,6 +152,11 @@ version, and only use the available subset of access rights:
         ruleset_attr.handled_access_net &=
             ~(LANDLOCK_ACCESS_NET_BIND_UDP |
               LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
+        __attribute__((fallthrough));
+    case 10:
+        /* Removes LANDLOCK_PERM_* for ABI < 11 */
+        ruleset_attr.handled_perm &= ~(LANDLOCK_PERM_NAMESPACE_USE |
+                                       LANDLOCK_PERM_CAPABILITY_USE);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -242,6 +259,55 @@ the program explicitly called :manpage:`bind(2)` on port 0.
         err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
                                 &udp_bind, 0);
 
+Capability and namespace rules use a different attribute layout:
+``perm`` identifies the permission category (a single
+``LANDLOCK_PERM_*`` flag) and a type-specific value field carries the bitmask to
+allow within it.  See `Capability and namespace restrictions`_ for the model.
+
+For capability access-control, we can add rules that allow specific
+capabilities (see :manpage:`capabilities(7)` for the list of ``CAP_*``
+values).  For instance, to allow ``CAP_SYS_CHROOT`` (so the sandboxed
+process can call :manpage:`chroot(2)` inside a user namespace):
+
+.. code-block:: c
+
+    struct landlock_capability_attr cap_attr = {
+        .perm = LANDLOCK_PERM_CAPABILITY_USE,
+        .allowed_capabilities = (1ULL << CAP_SYS_CHROOT),
+    };
+
+    cap_attr.perm &= ruleset_attr.handled_perm;
+    if (cap_attr.perm)
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
+        .perm = LANDLOCK_PERM_NAMESPACE_USE,
+        .allowed_namespace_types = CLONE_NEWUSER,
+    };
+
+    ns_attr.perm &= ruleset_attr.handled_perm;
+    if (ns_attr.perm)
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
@@ -420,9 +486,135 @@ The operations which can be scoped are:
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
+``handled_perm`` declares per-category permissions: each permission selects
+which members of a kernel-defined category (CAP_* capabilities, CLONE_NEW*
+namespace types) the process may use.  Unlike per-object access rights
+(``handled_access_*``) or cross-domain scopes (``scoped``), per-category
+permissions constrain the sandboxed process's own use of these enums; members
+not allowed by a rule are denied by default.
+
+``LANDLOCK_PERM_NAMESPACE_USE`` gates *acquisition of access* to
+namespaces: creation via :manpage:`unshare(2)` / :manpage:`clone(2)`
+/ :manpage:`clone3(2)`, entry via :manpage:`setns(2)`, and fd-reference
+acquisition via :manpage:`open_tree(2)` / :manpage:`fsmount(2)`.  Namespaces
+the process is already a member of when the domain is enforced are implicitly
+allowed (the process could not continue running otherwise); rules describe which
+new namespace types the process may acquire.  ``LANDLOCK_PERM_CAPABILITY_USE``
+gates every exercise of a capability after the domain is enforced, regardless
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
+``LANDLOCK_PERM_CAPABILITY_USE`` complements :manpage:`prctl(2)`
+``PR_SET_NO_NEW_PRIVS`` but does not replace it.  ``PR_SET_NO_NEW_PRIVS``
+prevents privilege *acquisition* via :manpage:`execve(2)` (setuid, file
+capability xattrs, privilege-elevating LSM transitions) and is a prerequisite
+for unprivileged Landlock self-sandboxing.  ``LANDLOCK_PERM_CAPABILITY_USE``
+restricts *exercise* of capabilities the process already holds, including those
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
+layer; it never changes the denial itself.  Sandboxes should quiet only
+specific members known to be requested but expected to be denied (for example
+for compatibility with older callers), never a blanket set: a blanket set
+follows the running kernel's known members and would hide surprising or future
+denials.
+
+Rule bodies silently accept values unknown to the current kernel (capabilities
+above ``CAP_LAST_CAP``, unrecognised ``CLONE_NEW*`` bits): they have no runtime
+effect, so a rule compiled against future kernel headers loads without error on
+older kernels.  Future kernels gain new members denied by default until a rule
+explicitly allows them.
+
+The single ``LANDLOCK_PERM_NAMESPACE_USE`` bit gates every kernel path that
+grants the calling process access to a namespace of the controlled types,
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
+``LANDLOCK_PERM_CAPABILITY_USE`` is also handled, each of these capabilities
+must be explicitly allowed by a rule.
+
+Creating a non-user namespace always requires ``CAP_SYS_ADMIN``, and
+``LANDLOCK_PERM_CAPABILITY_USE`` (when handled) gates that check regardless of
+which user namespace it targets.  This is true whether the namespace is created
+on its own, combined with ``CLONE_NEWUSER`` in a single :manpage:`unshare(2)`
+call, or in a separate :manpage:`unshare(2)` call after a user namespace: in
+all cases the kernel checks ``CAP_SYS_ADMIN`` against the owning user
+namespace, and Landlock's capability hook denies it unless a rule allows
+``CAP_SYS_ADMIN``.  Combining ``CLONE_NEWUSER`` with another ``CLONE_NEW*``
+flag therefore does not avoid the capability check; only user namespace
+creation itself needs no capability rule.
+
+When creating child user namespaces, it is recommended to also create a
+dedicated Landlock domain with restrictions relevant to each namespace context.
+
+Note that ``LANDLOCK_PERM_CAPABILITY_USE`` restricts the *use* of capabilities,
+not their presence in the process's credential.  Capability sets can change
+after a domain is enforced through user namespace entry or :manpage:`capset(2)`;
+privileged sandboxes that did not set ``PR_SET_NO_NEW_PRIVS`` may also gain
+capabilities through :manpage:`execve(2)` of binaries with file capabilities.
+In all cases, :manpage:`capget(2)` will report the credential's capability sets,
+but any denied capability will fail with ``EPERM`` when exercised.  Do not rely
+on :manpage:`capget(2)` to determine whether the policy permits a given
+capability; only the actual operation will return ``EPERM`` upon denial.
 
 Truncating files
 ----------------
@@ -585,7 +777,7 @@ Access rights
 -------------
 
 .. kernel-doc:: include/uapi/linux/landlock.h
-    :identifiers: fs_access net_access scope
+    :identifiers: fs_access net_access scope perm
 
 Creating a new ruleset
 ----------------------
@@ -604,7 +796,8 @@ Extending a ruleset
 
 .. kernel-doc:: include/uapi/linux/landlock.h
     :identifiers: landlock_rule_type landlock_path_beneath_attr
-                  landlock_net_port_attr
+                  landlock_net_port_attr landlock_capability_attr
+                  landlock_namespace_attr
 
 Enforcing a ruleset
 -------------------
@@ -789,6 +982,23 @@ when at least one sys_landlock_add_rule() call is made for it with the
 ``LANDLOCK_ADD_RULE_QUIET`` flag, additional add-rule calls for the same
 object without this flag do not clear it.
 
+Capability (ABI < 11)
+---------------------
+
+Starting with the Landlock ABI version 11, it is possible to restrict
+:manpage:`capabilities(7)` with the new ``LANDLOCK_PERM_CAPABILITY_USE``
+permission flag and ``LANDLOCK_RULE_CAPABILITY`` rule type.
+
+Namespace (ABI < 11)
+--------------------
+
+Starting with the Landlock ABI version 11, it is possible to restrict namespace
+use (see :manpage:`namespaces(7)`) across creation (:manpage:`unshare(2)`,
+:manpage:`clone(2)`, :manpage:`clone3(2)`), entry (:manpage:`setns(2)`), and
+fd-reference acquisition (:manpage:`open_tree(2)`, :manpage:`fsmount(2)`) with
+the new ``LANDLOCK_PERM_NAMESPACE_USE`` permission flag and
+``LANDLOCK_RULE_NAMESPACE`` rule type.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.54.0

