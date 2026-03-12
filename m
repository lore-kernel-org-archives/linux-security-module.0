Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0103BF668
	for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309927; cv=none; b=eryuzvU96j2yKGDQGTYneUl+I/xHpQrFFDPvO103MGwt+L8chT3zKlQZ0/q8oCFNjUDrO01L2QX3FFE/e4Y8Psdtl1ikoHv4UEQqeSmVZAYHXu/mU8j8D5UYWvqGtaNLzUDITPpsEi4voNpuePSL/pmjY86Rj84FAsNt57fE/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309927; c=relaxed/simple;
	bh=KcDB0tmiXfODk++DTH/HQI0UBiMFz2fXJ13bIuAdIaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wf5uIxnUOo7U4o30pcW1RqLIesPZajFztvr5pKM0BLHi98JuYKG0BdJ6g0LiZpGmoRh8uYLIIzPmhyqf/PWY59n7x3ZgXTAx19y2TvM/QvxDKf0649lOA+bThI8kuKcXN4htzMHECypelZbrbauMd2zQCihh8+pTqoc1ffWvPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LbDYjr3J; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LbDYjr3J"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fWjsv3NKXz19sK;
	Thu, 12 Mar 2026 11:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773309923;
	bh=WKXPZHKVm9QTYHBll0VFcVaBYcf+UJk9msOBYP0WwaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LbDYjr3Jrc9My/P7d/sws6tWaVMWRIgLUQy0pz3p4g8u7/EqYlPCzs2iGJILpzyws
	 aYAZ7C61ZBBnVGoBYcpMnh0eWPI9YK1LSeNEg0pnoxKDdksDvObDrtvSc/C9100RvF
	 pVRFQA8mMAc0tTkLqKLj3KL8pshj+cJtRp+NscMY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fWjst5rdFzwCp;
	Thu, 12 Mar 2026 11:05:22 +0100 (CET)
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
Subject: [RFC PATCH v1 11/11] landlock: Add documentation for capability and namespace restrictions
Date: Thu, 12 Mar 2026 11:04:44 +0100
Message-ID: <20260312100444.2609563-12-mic@digikod.net>
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

Document the two new Landlock permission categories in the userspace
API guide, admin guide, and kernel security documentation.

The userspace API guide adds sections on capability restriction
(LANDLOCK_PERM_CAPABILITY_USE with LANDLOCK_RULE_CAPABILITY), namespace
restriction (LANDLOCK_PERM_NAMESPACE_ENTER with LANDLOCK_RULE_NAMESPACE
covering creation via unshare/clone and entry via setns), and the
backward-compatible degradation pattern for ABI < 9.  A table documents
the per-namespace-type capability requirements for both creation and
entry.

The admin guide adds the new perm.namespace_enter and
perm.capability_use audit blocker names with their object identification
fields (namespace_type, namespace_inum, capability).

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
 Documentation/admin-guide/LSM/landlock.rst |  19 ++-
 Documentation/security/landlock.rst        |  80 ++++++++++-
 Documentation/userspace-api/landlock.rst   | 156 ++++++++++++++++++++-
 3 files changed, 245 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
index 9923874e2156..99c6a599ce9e 100644
--- a/Documentation/admin-guide/LSM/landlock.rst
+++ b/Documentation/admin-guide/LSM/landlock.rst
@@ -6,7 +6,7 @@ Landlock: system-wide management
 ================================
 
 :Author: Mickaël Salaün
-:Date: January 2026
+:Date: March 2026
 
 Landlock can leverage the audit framework to log events.
 
@@ -59,14 +59,25 @@ AUDIT_LANDLOCK_ACCESS
         - scope.abstract_unix_socket - Abstract UNIX socket connection denied
         - scope.signal - Signal sending denied
 
+    **perm.*** - Permission restrictions (ABI 9+):
+        - perm.namespace_enter - Namespace entry was denied (creation via
+          :manpage:`unshare(2)` / :manpage:`clone(2)` or joining via
+          :manpage:`setns(2)`);
+          ``namespace_type`` indicates the type (hex CLONE_NEW* bitmask),
+          ``namespace_inum`` identifies the target namespace for
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
+    ``namespace_type`` and ``namespace_inum`` for namespace operations;
+    ``capability`` for capability use.
 
 
 AUDIT_LANDLOCK_DOMAIN
diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 3e4d4d04cfae..cd3d640ca5c9 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -7,7 +7,7 @@ Landlock LSM: kernel documentation
 ==================================
 
 :Author: Mickaël Salaün
-:Date: September 2025
+:Date: March 2026
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -89,6 +89,72 @@ this is required to keep access controls consistent over the whole system, and
 this avoids unattended bypasses through file descriptor passing (i.e. confused
 deputy attack).
 
+Composability with user namespaces
+----------------------------------
+
+Landlock domain-based scoping and the kernel's user namespace-based capability
+scoping enforce isolation over independent hierarchies.  Landlock checks domain
+ancestry; the kernel's ``ns_capable()`` checks user namespace ancestry.  These
+hierarchies are orthogonal: Landlock enforcement is deterministic with respect
+to its own configuration, regardless of namespace or capability state, and vice
+versa.  This orthogonality is a design invariant that must hold for all new
+scoped features.
+
+Ruleset restriction models
+--------------------------
+
+Landlock provides three restriction models, each with different coverage
+and compatibility properties.
+
+Access rights (``handled_access_*``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Access rights control **enumerated operations on kernel objects**
+identified by a rule key (a file hierarchy or a network port).  Each
+``handled_access_*`` field declares a set of access rights that the
+ruleset restricts.  Multiple access rights share a single rule type.
+Operations for which no access right exists yet remain uncontrolled;
+new rights are added incrementally across ABI versions.
+
+Permissions (``handled_perm``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Permissions control **broad operations enforced at single kernel
+chokepoints**, achieving complete deny-by-default coverage.  Each
+``LANDLOCK_PERM_*`` flag maps to its own rule type.  When a ruleset
+handles a permission, all instances of that operation are denied unless
+explicitly allowed by a rule.  New kernel values (new ``CAP_*``
+capabilities, new ``CLONE_NEW*`` namespace types) are automatically
+denied without any Landlock update.
+
+Each permission flag names a single gateway operation whose control
+transitively covers an open-ended set of downstream operations: for
+example, exercising a capability enables privileged operations across
+many subsystems; entering a namespace enables gaining capabilities in a
+new context.
+
+Permission rules identify what to allow using constants defined by other
+kernel subsystems (``CAP_*``, ``CLONE_NEW*``).  Unknown values are
+silently ignored because deny-by-default ensures they are denied anyway.
+In contrast, unknown ``LANDLOCK_PERM_*`` flags in ``handled_perm`` are
+rejected (``-EINVAL``), since Landlock owns that namespace.
+
+Scopes (``scoped``)
+~~~~~~~~~~~~~~~~~~~~
+
+Scopes restrict **cross-domain interactions** categorically, without
+rules.  Setting a scope flag (e.g. ``LANDLOCK_SCOPE_SIGNAL``) denies the
+operation to targets outside the Landlock domain or its children.  Like
+permissions, scopes provide complete coverage of the controlled
+operation.
+
+When adding new Landlock features, new operations on existing rule types
+extend the corresponding ``handled_access_*`` field (e.g. a new
+filesystem operation extends ``handled_access_fs``).  A new object
+category with multiple fine-grained operations would use a new
+``handled_access_*`` field.  New rule types that control a single
+chokepoint operation use ``handled_perm``.
+
 Tests
 =====
 
@@ -110,6 +176,18 @@ Filesystem
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
index 13134bccdd39..238d30a18162 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: January 2026
+:Date: March 2026
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -33,7 +33,7 @@ A Landlock rule describes an action on an object which the process intends to
 perform.  A set of rules is aggregated in a ruleset, which can then restrict
 the thread enforcing it, and its future children.
 
-The two existing types of rules are:
+The existing types of rules are:
 
 Filesystem rules
     For these rules, the object is a file hierarchy,
@@ -44,6 +44,14 @@ Network rules (since ABI v4)
     For these rules, the object is a TCP port,
     and the related actions are defined with `network access rights`.
 
+Capability rules (since ABI v9)
+    For these rules, the object is a set of Linux capabilities,
+    and the related actions are defined with `permission flags`.
+
+Namespace rules (since ABI v9)
+    For these rules, the object is a set of namespace types,
+    and the related actions are defined with `permission flags`.
+
 Defining and enforcing a security policy
 ----------------------------------------
 
@@ -84,6 +92,9 @@ to be explicit about the denied-by-default access rights.
         .scoped =
             LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
             LANDLOCK_SCOPE_SIGNAL,
+        .handled_perm =
+            LANDLOCK_PERM_CAPABILITY_USE |
+            LANDLOCK_PERM_NAMESPACE_ENTER,
     };
 
 Because we may not know which kernel version an application will be executed
@@ -127,6 +138,12 @@ version, and only use the available subset of access rights:
         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
                                  LANDLOCK_SCOPE_SIGNAL);
+        __attribute__((fallthrough));
+    case 6:
+    case 7:
+    case 8:
+        /* Removes permission support for ABI < 9 */
+        ruleset_attr.handled_perm = 0;
     }
 
 This enables the creation of an inclusive ruleset that will contain our rules.
@@ -191,6 +208,42 @@ number for a specific action: HTTPS connections.
     err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
                             &net_port, 0);
 
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
+    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
+                            &cap_attr, 0);
+
+For namespace access-control, we can add rules that allow entering specific
+namespace types (creating them via :manpage:`unshare(2)` / :manpage:`clone(2)`
+or joining them via :manpage:`setns(2)`).  For instance, to allow creating user
+namespaces (which grants all capabilities inside the new namespace):
+
+.. code-block:: c
+
+    struct landlock_namespace_attr ns_attr = {
+        .allowed_perm = LANDLOCK_PERM_NAMESPACE_ENTER,
+        .namespace_types = CLONE_NEWUSER,
+    };
+
+    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
+                            &ns_attr, 0);
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
@@ -354,10 +407,87 @@ The operations which can be scoped are:
     A :manpage:`sendto(2)` on a socket which was previously connected will not
     be restricted.  This works for both datagram and stream sockets.
 
-IPC scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.
+Scoping does not support exceptions via :manpage:`landlock_add_rule(2)`.
 If an operation is scoped within a domain, no rules can be added to allow access
 to resources or processes outside of the scope.
 
+Capability and namespace restrictions
+-------------------------------------
+
+See Documentation/security/landlock.rst for the design rationale behind
+the permission model (``handled_perm``) and how it differs from access
+rights (``handled_access_*``) and scopes (``scoped``).
+When a process creates a user namespace, the kernel grants all capabilities
+within that namespace.  While these capabilities cannot directly bypass Landlock
+restrictions (Landlock enforces access controls independently of capability
+checks), they open kernel code paths that are normally unreachable to
+unprivileged users and may contain exploitable bugs.
+
+Landlock provides two complementary permissions to address this.
+``LANDLOCK_PERM_CAPABILITY_USE`` restricts which capabilities a process can use,
+even when it holds them.  ``LANDLOCK_PERM_NAMESPACE_ENTER`` restricts which
+namespace types a process can create (via :manpage:`unshare(2)` or
+:manpage:`clone(2)`) or join (via :manpage:`setns(2)`).  After creating a user
+namespace, the granted capabilities are scoped to namespaces owned by that user
+namespace or its descendants; to exercise a capability such as
+``CAP_NET_ADMIN``, the process must create a namespace of the corresponding type
+(e.g., a network namespace).  Configuring both permissions together provides
+full coverage: ``LANDLOCK_PERM_CAPABILITY_USE`` restricts which capabilities are
+available, while ``LANDLOCK_PERM_NAMESPACE_ENTER`` restricts the namespaces in
+which they can be used.
+
+When a Landlock domain handles ``LANDLOCK_PERM_CAPABILITY_USE``, all Linux
+:manpage:`capabilities(7)` are denied by default unless a rule explicitly allows
+them.  This is purely restrictive: Landlock can only deny capabilities that the
+traditional capability mechanism would have allowed, never grant additional ones.
+Rules are added with ``LANDLOCK_RULE_CAPABILITY`` using a
+&struct landlock_capability_attr.  Each rule specifies a set of ``CAP_*`` values
+(as a bitmask) to allow.  Capabilities above ``CAP_LAST_CAP`` are silently
+accepted but have no effect since the kernel never checks them; this means new
+capabilities introduced by future kernels are automatically denied.
+
+When a Landlock domain handles ``LANDLOCK_PERM_NAMESPACE_ENTER``, namespace
+creation and entry are denied by default unless a rule explicitly allows them.
+Rules are added with ``LANDLOCK_RULE_NAMESPACE`` using a
+&struct landlock_namespace_attr.  Each rule specifies a set of ``CLONE_NEW*``
+flags to allow.
+
+In practice, unprivileged processes first create a user namespace (which requires
+no capability and grants all capabilities within it), then use those capabilities
+to create other namespace types.  All non-user namespace types require
+``CAP_SYS_ADMIN`` for both creation and :manpage:`setns(2)` entry; mount
+namespace entry additionally requires ``CAP_SYS_CHROOT``.  For
+:manpage:`setns(2)`, capabilities are checked relative to the target namespace,
+so a process in an ancestor user namespace naturally satisfies them; this
+includes joining user namespaces, which requires ``CAP_SYS_ADMIN``.  When
+``LANDLOCK_PERM_CAPABILITY_USE`` is also handled, each of these capabilities
+must be explicitly allowed by a rule.
+
+When combining ``CLONE_NEWUSER`` with other ``CLONE_NEW*`` flags in a single
+:manpage:`unshare(2)` call, the ``CAP_SYS_ADMIN`` check targets the newly
+created user namespace, which is handled by ``LANDLOCK_PERM_NAMESPACE_ENTER``
+independently from ``LANDLOCK_PERM_CAPABILITY_USE``.  Performing the user
+namespace creation and the additional namespace creation in two separate
+:manpage:`unshare(2)` calls requires a rule allowing ``CAP_SYS_ADMIN`` if the
+domain also handles ``LANDLOCK_PERM_CAPABILITY_USE``.
+
+More generally, Landlock domains and user namespaces form independent
+hierarchies: Landlock domains restrict what actions are allowed (each stacked
+layer narrows the permitted set), while user namespaces restrict where
+capabilities take effect (only within the process's own namespace and its
+descendants).  Landlock access controls are fully determined by the domain
+configuration, regardless of the process's position in the user namespace
+hierarchy.  When creating child user namespaces, it is recommended to also
+create a dedicated Landlock domain with restrictions relevant to each namespace
+context.
+
+Note that ``LANDLOCK_PERM_CAPABILITY_USE`` restricts the *use* of capabilities,
+not their presence in the process's credential.  Capability sets can change
+after a domain is enforced through user namespace entry, :manpage:`execve(2)` of
+binaries with file capabilities, or :manpage:`capset(2)`.  In all cases,
+:manpage:`capget(2)` will report the credential's capability sets, but any
+denied capability will fail with ``EPERM`` when exercised.
+
 Truncating files
 ----------------
 
@@ -515,7 +645,7 @@ Access rights
 -------------
 
 .. kernel-doc:: include/uapi/linux/landlock.h
-    :identifiers: fs_access net_access scope
+    :identifiers: fs_access net_access scope perm
 
 Creating a new ruleset
 ----------------------
@@ -534,7 +664,8 @@ Extending a ruleset
 
 .. kernel-doc:: include/uapi/linux/landlock.h
     :identifiers: landlock_rule_type landlock_path_beneath_attr
-                  landlock_net_port_attr
+                  landlock_net_port_attr landlock_capability_attr
+                  landlock_namespace_attr
 
 Enforcing a ruleset
 -------------------
@@ -685,6 +816,21 @@ enforce Landlock rulesets across all threads of the calling process
 using the ``LANDLOCK_RESTRICT_SELF_TSYNC`` flag passed to
 sys_landlock_restrict_self().
 
+Capability restriction (ABI < 9)
+--------------------------------
+
+Starting with the Landlock ABI version 9, it is possible to restrict
+:manpage:`capabilities(7)` with the new ``LANDLOCK_PERM_CAPABILITY_USE``
+permission flag and ``LANDLOCK_RULE_CAPABILITY`` rule type.
+
+Namespace restriction (ABI < 9)
+-------------------------------
+
+Starting with the Landlock ABI version 9, it is possible to restrict
+namespace creation (:manpage:`unshare(2)`, :manpage:`clone(2)`) and entry
+(:manpage:`setns(2)`) with the new ``LANDLOCK_PERM_NAMESPACE_ENTER`` permission
+flag and ``LANDLOCK_RULE_NAMESPACE`` rule type.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.53.0

