Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1E3E314A
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906104; cv=none; b=pHeVeJozruUdMPbwubT4Ttu6XtoOHmaN+4nAObr8b2lcXXQ9xRMGffYhEzDZnAo5Y8I5salc15cMtClyRgfV/8+JZt/IHJPhkLOknrBFWScr0sLv5lmNBFlBndf4r6egfJvKAZEx/DrAAREiRZh21dukQgouqaU/xlclHJlpoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906104; c=relaxed/simple;
	bh=sgXeiTihkmj5/pxmg0w4ml7m+iWydlm6IaJbxxOWDS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ox//3fg6z0z6JtrLhuiwi7mVhbmFkcfEMqHBrnXdF6kwxgPmrpR4jsCOQEpKGol8CnzhVar55ntw+k5PHKRHwSO6N6Ag33PTwKnQdfMD+IWTnDCR35VewBMgseSo34vKQR5MnlGEbGvNdNV+eCACdIeJYtniMQ0GlkCRJkG5AHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=P6FauWFs; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="P6FauWFs"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gQd4C4PVhzYYg;
	Wed, 27 May 2026 20:11:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779905515;
	bh=RpjiMmAeuGQG882dkpFNOXnmvk8DnJh8kIt6OyVvTzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6FauWFsfoCiLjK+4OJw7BsDTY9JFWFQhFPDSUBdAGJd0X7+QqrpitPYnZG/awYzD
	 fizYkSL1v/dH5t74CuXUMCRo2eLsKW57ppCOhgB51pHLodlkH0Y1LlkWA0YSlClLht
	 ToDOMFkKGw8JS32YWx3rb2lg3U+w+6Wvhgt3I9Ig=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gQd4B4N2Wzw7S;
	Wed, 27 May 2026 20:11:54 +0200 (CEST)
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
Subject: [PATCH v2 9/9] landlock: Add documentation for capability and namespace restrictions
Date: Wed, 27 May 2026 20:11:22 +0200
Message-ID: <20260527181127.879771-10-mic@digikod.net>
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

Document the two new Landlock permission categories in the userspace API
guide, admin guide, and kernel security documentation.

The userspace API guide adds sections on capability restriction
(LANDLOCK_PERM_CAPABILITY_USE with LANDLOCK_RULE_CAPABILITY) and
namespace restriction (LANDLOCK_PERM_NAMESPACE_USE with
LANDLOCK_RULE_NAMESPACE, covering creation, entry, and fd-reference
acquisition), the backward-compatible degradation pattern for ABI < 10,
and the per-namespace-type capability requirements.

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

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-12-mic@digikod.net

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
 Documentation/security/landlock.rst        | 151 +++++++++++++-
 Documentation/userspace-api/landlock.rst   | 216 +++++++++++++++++++--
 3 files changed, 367 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 9923874e2156..58ac5ae2f5f3 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -6,7 +6,7 @@ Landlock: system-wide management
 ================================
 
 :Author: Mickaël Salaün
-:Date: January 2026
+:Date: May 2026
 
 Landlock can leverage the audit framework to log events.
 
@@ -59,14 +59,25 @@ AUDIT_LANDLOCK_ACCESS
         - scope.abstract_unix_socket - Abstract UNIX socket connection denied
         - scope.signal - Signal sending denied
 
+    **perm.*** - Permission restrictions (ABI 10+):
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
index c5186526e76f..2b6e4be42893 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: March 2026
+:Date: May 2026
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -129,6 +129,143 @@ The reasoning is:
   restrictions, because access within the same scope is already
   allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
 
+Composability with user namespaces
+----------------------------------
+
+Landlock domain-based scoping and the kernel's user namespace-based capability
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
+first (data, processes, or kernel-internal resources).  The operation set
+follows from the protected resource: which kernel paths grant access to it, and
+at which moment those paths can be gated.  Do not design a permission around
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
+Per-object access rights (``handled_access_*``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Per-object access rights control operations on a specific resource instance,
+identified in the rule key by a value drawn from an open-ended space: a file
+hierarchy referenced by ``parent_fd``, or a network port identified by its
+16-bit number.  Each ``handled_access_*`` field declares a set of access rights
+that the ruleset restricts.  The rule body declares which of the multiple
+distinct operations on that object instance are allowed (open, read, write,
+truncate; bind, connect).  New operations on an existing rule type extend the
+corresponding ``handled_access_*`` field (e.g. a new filesystem operation
+extends ``handled_access_fs``).  A new object type with multiple fine-grained
+operations would use a new ``handled_access_*`` field.
+
+Per-category permissions (``handled_perm``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Per-category permissions control the process's exercise of category members,
+where the category is a small kernel-defined enumeration (a Linux capability
+number ``CAP_*``, a namespace type ``CLONE_NEW*``).  Unlike per-object access
+rights, which restrict specific operations on a single resource instance,
+per-category permissions gate the prerequisite operation itself (exercising a
+capability, acquiring a namespace), so gating it transitively covers a broad set
+of downstream operations.  These category members are the LSM-level
+access-control objects (the entities the process is authorized against) even
+though they are enum values rather than externally-instantiated kernel data
+structures.  Per-category permissions apply where the controlled operation
+collapses to "may the process use this category member at all" (use a
+capability; acquire a namespace), so the rule body lists which category members
+the process may exercise; each ``LANDLOCK_PERM_*`` flag maps to its own rule
+type and covers every kernel path that exercises a member.  When a ruleset
+handles a permission, all uses of category members are denied unless explicitly
+allowed by a rule.  See Documentation/userspace-api/landlock.rst for the
+concrete syscall paths covered by each permission.
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
+  subsystem (e.g., when ``CAP_BPF`` was split from ``CAP_SYS_ADMIN``, the
+  kernel kept checking either capability, so a rule denying ``CAP_SYS_ADMIN``
+  continues to deny operations gated by ``CAP_SYS_ADMIN || CAP_BPF`` patterns).
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
 
@@ -150,6 +287,18 @@ Filesystem
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
index 45861fa75685..45548d1666fa 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -29,20 +29,29 @@ If Landlock is not currently supported, we need to
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
 
 Network rules (since ABI v4)
-    For these rules, the object is a TCP port,
-    and the related actions are defined with `network access rights`.
+    The rule key is a TCP port, and the actions it allows are defined with
+    `network access rights`.
+
+Capability rules (since ABI v10)
+    The rule body lists which members of the Linux capability category
+    the process may exercise; the action is defined with `permission
+    flags`.
+
+Namespace rules (since ABI v10)
+    The rule body lists which members of the namespace-type
+    category the process may use; the action is defined with `permission
+    flags`.
 
 Defining and enforcing a security policy
 ----------------------------------------
@@ -85,6 +94,9 @@ to be explicit about the denied-by-default access rights.
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
             LANDLOCK_SCOPE_SIGNAL,
+        .handled_perm =
+            LANDLOCK_PERM_CAPABILITY_USE |
+            LANDLOCK_PERM_NAMESPACE_USE,
     };
 
 Because we may not know which kernel version an application will be executed
@@ -132,6 +144,11 @@ version, and only use the available subset of access rights:
     case 6 ... 8:
         /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
         ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
+        __attribute__((fallthrough));
+    case 9:
+        /* Removes LANDLOCK_PERM_* for ABI < 10 */
+        ruleset_attr.handled_perm &= ~(LANDLOCK_PERM_NAMESPACE_USE |
+                                       LANDLOCK_PERM_CAPABILITY_USE);
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -202,6 +219,53 @@ number for a specific action: HTTPS connections.
         err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
                                 &net_port, 0);
 
+Capability and namespace rules use a different attribute layout:
+``allowed_perm`` identifies the permission category (a single
+``LANDLOCK_PERM_*`` flag) and a type-specific value field carries the bitmask to
+allow within it.  See `Capability and namespace restrictions`_ for the model.
+
+For capability access-control, we can add rules that allow specific
+capabilities.  For instance, to allow ``CAP_SYS_CHROOT`` (so the sandboxed
+process can call :manpage:`chroot(2)` inside a user namespace):
+
+.. code-block:: c
+
+    struct landlock_capability_attr cap_attr = {
+        .allowed_perm = LANDLOCK_PERM_CAPABILITY_USE,
+        .capabilities = (1ULL << CAP_SYS_CHROOT),
+    };
+
+    cap_attr.allowed_perm &= ruleset_attr.handled_perm;
+    if (cap_attr.allowed_perm)
+        err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+                                &cap_attr, 0);
+
+For namespace access-control, we can add rules that allow entering specific
+namespace types (creating them via :manpage:`unshare(2)` / :manpage:`clone(2)` /
+:manpage:`clone3(2)`, joining them via :manpage:`setns(2)`, or acquiring an fd
+reference via :manpage:`open_tree(2)` / :manpage:`fsmount(2)`).  For instance,
+to allow creating user namespaces (which grants all capabilities inside the new
+namespace):
+
+.. code-block:: c
+
+    struct landlock_namespace_attr ns_attr = {
+        .allowed_perm = LANDLOCK_PERM_NAMESPACE_USE,
+        .namespace_types = CLONE_NEWUSER,
+    };
+
+    ns_attr.allowed_perm &= ruleset_attr.handled_perm;
+    if (ns_attr.allowed_perm)
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
@@ -380,9 +444,115 @@ The operations which can be scoped are:
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
+``LANDLOCK_PERM_NAMESPACE_USE`` gates *acquisition* of namespace
+associations: creation via :manpage:`unshare(2)` / :manpage:`clone(2)`
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
+only one of the two leaves a kernel attack-surface widening path open.
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
+namespace into its current namespace, bypassing the policy.
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
+When combining ``CLONE_NEWUSER`` with other ``CLONE_NEW*`` flags in a single
+:manpage:`unshare(2)` call, the ``CAP_SYS_ADMIN`` check targets the newly
+created user namespace, which is handled by ``LANDLOCK_PERM_NAMESPACE_USE``
+independently from ``LANDLOCK_PERM_CAPABILITY_USE``.  Performing the user
+namespace creation and the additional namespace creation in two separate
+:manpage:`unshare(2)` calls requires a rule allowing ``CAP_SYS_ADMIN`` if the
+domain also handles ``LANDLOCK_PERM_CAPABILITY_USE``.
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
@@ -545,7 +715,7 @@ Access rights
 -------------
 
 .. kernel-doc:: include/uapi/linux/landlock.h
-    :identifiers: fs_access net_access scope
+    :identifiers: fs_access net_access scope perm
 
 Creating a new ruleset
 ----------------------
@@ -564,7 +734,8 @@ Extending a ruleset
 
 .. kernel-doc:: include/uapi/linux/landlock.h
     :identifiers: landlock_rule_type landlock_path_beneath_attr
-                  landlock_net_port_attr
+                  landlock_net_port_attr landlock_capability_attr
+                  landlock_namespace_attr
 
 Enforcing a ruleset
 -------------------
@@ -722,6 +893,23 @@ Starting with the Landlock ABI version 9, it is possible to restrict
 connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
 the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
 
+Capability restriction (ABI < 10)
+---------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to restrict
+:manpage:`capabilities(7)` with the new ``LANDLOCK_PERM_CAPABILITY_USE``
+permission flag and ``LANDLOCK_RULE_CAPABILITY`` rule type.
+
+Namespace restriction (ABI < 10)
+--------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to restrict namespace
+use across creation (:manpage:`unshare(2)`, :manpage:`clone(2)`,
+:manpage:`clone3(2)`), entry (:manpage:`setns(2)`), and fd-reference acquisition
+(:manpage:`open_tree(2)`, :manpage:`fsmount(2)`) with the new
+``LANDLOCK_PERM_NAMESPACE_USE`` permission flag and ``LANDLOCK_RULE_NAMESPACE``
+rule type.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.54.0

