Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D031EB5C2
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783458238; cv=none; b=kwBmJQL/cyuyxOGjONsBULJHGDcTFn/whiZRrriT9twOq3AbzycIH+jotk8yKJgZSfkGlaDd5VF6xirDsTLINYnrMsr85QCONqh/3O/Yz1J99YVNoc1tH6cMbsoCtYfSLdEoafgd66udfji57u24/1+8b1H4ENcXv/tL8ZBXHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783458238; c=relaxed/simple;
	bh=/GHpxg3W+Y+wDuZarAwpGoKa11LGRJ3hlJslECjAe6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTsAQ1Y+hEecSza2Og0seuF8HKuWjgxY2ZGWDwkcGCpg/0UrpyV7L+KNlszMJcjbNWnzbib9I9mn0YOpKPt/ZzfniL87nmOSbIR7efOp2chri1zdh3EaBa0S0JcTmPKhsQ3yz8T8bzwwOuGkFYmfXQ78DiOSz5UMXelF31iKtPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ow7P/xsx; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ow7P/xsx"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvtxc14CQzvFb;
	Tue,  7 Jul 2026 23:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783458227;
	bh=4GlmezGiWpjbnBrVzUXeI1Az5mqfgsxKWYQjcaKFZsU=;
	h=From:To:Cc:Subject:Date:From;
	b=ow7P/xsxsBUAbYrpfoUFT8t/JBZMyWwxj7gO8e22BYSmGmp+bGM3z88Iaqz/FBve2
	 0Kq/MKcfQZEd4TzA4rqXkzi8wgMh8IxzlNDSbtJhwS7ye1XXIerBxAGji1CCd9VQ0J
	 a/nDQWyWTCzUg4gnkNoSUWHDkDcGzjMh7sM7usOs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gvtxY0P2zzHJ0;
	Tue,  7 Jul 2026 23:03:44 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jann Horn <jannh@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Paul Moore <paul@paul-moore.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Tingmao Wang <m@maowtm.org>,
	Ubisectech Sirius <bugreport@ubisectech.com>,
	Willy Tarreau <w@1wt.eu>,
	Yuxian Mao <maoyuxian@cqsoftware.com.cn>,
	kernel-team@cloudflare.com,
	landlock@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1] landlock: Document the threat model
Date: Tue,  7 Jul 2026 23:03:33 +0200
Message-ID: <20260707210336.2060040-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Landlock's threat model has been defined since its initial submission
[1] but is scattered across cover letters, commit messages, and
mailing-list threads.  A security reporter has no single place to decide
whether a behavior is a Landlock bug, leading to recurring invalid
reports, for example treating io_uring's creation-time credentials,
which are inherited from the sandboxed subject, as a bypass.

Add a self-sufficient "Threat model" section as the first section of the
Landlock security documentation.  Read alongside the general kernel
threat model, it consolidates that scattered knowledge and lets a
reporter classify an issue without maintainer intervention: is this a
Landlock security bug, and if so, what is its blast radius?

The section defines Landlock's guarantees (unprivileged self-sandboxing
and per-domain confinement), its trust model (union-when-building versus
intersection-when-transitioning), the per-right semantic contract, and
the criteria that distinguish security bugs (under-enforcement) from
compatibility bugs (over-enforcement), best-effort limitations, and
out-of-scope behaviors.  It explains what makes a bypass narrow or
broad, and which interactions are intentionally out of scope: privileged
actions, same-domain and same-process-thread interactions, actions a
user space service performs on the caller's behalf, resources passed
into the sandbox from outside, information disclosure, denial of
service, and syscall-argument filtering.

Retitle the document to reflect this: it documents Landlock's security
design (threat model, guiding principles, design choices), and its title
now follows the focus-based pattern of the other Landlock documents.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Yuxian Mao <maoyuxian@cqsoftware.com.cn>
Link: https://lore.kernel.org/r/20210422154123.13086-1-mic@digikod.net [1]
Closes: https://github.com/landlock-lsm/linux/issues/64
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Documentation/security/landlock.rst | 303 +++++++++++++++++++++++++++-
 1 file changed, 299 insertions(+), 4 deletions(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index c5186526e76f..fae13145af5d 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -1,13 +1,14 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
 .. Copyright © 2019-2020 ANSSI
+.. Copyright © 2026 Cloudflare, Inc.
 
-==================================
-Landlock LSM: kernel documentation
-==================================
+=========================
+Landlock: Security design
+=========================
 
 :Author: Mickaël Salaün
-:Date: March 2026
+:Date: July 2026
 
 Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
 harden a whole system, this feature should be available to any process,
@@ -28,6 +29,300 @@ constraints can be added.
 User space documentation can be found here:
 Documentation/userspace-api/landlock.rst.
 
+Threat model
+============
+
+Landlock lets any process, even an unprivileged one, restrict itself.  Its
+threat model therefore treats a sandboxed process as potentially malicious. The
+adversary is a sandboxed process that tries to perform an action its own policy
+should deny.  A Landlock security bug is when it succeeds.  This complements
+Documentation/process/threat-model.rst.
+
+What Landlock protects
+----------------------
+
+A Landlock *domain* is a ruleset (a set of rules), or a stack of them, enforced
+on a task (a thread), attached to its credentials and inherited across
+:manpage:`fork(2)` and :manpage:`execve(2)`.  A sandboxed *subject* (a task
+restricted by a domain) is confined in the *actions* it may perform, such as
+accessing files, binding or connecting to network ports, or sending signals.  A
+ruleset declares the *handled* actions it restricts, in one of two shapes:
+access rights and *scopes* that the running kernel supports.
+
+An access right allows specific accesses to a target named by a rule.  Currently
+a target is a file descriptor, which designates one kernel object: the inode it
+references, or for a directory the file hierarchy beneath it.  It can instead be
+a network port, a value matching any socket using it rather than a specific
+object.  Any access a handled right covers but does not explicitly allow is
+denied.
+
+A scope instead restricts crossing out of the domain hierarchy, denying outgoing
+interaction with processes or IPC peers that are neither in the subject's domain
+nor in a domain nested under it (e.g. sending signals or connecting to abstract
+UNIX sockets).
+
+Beyond these two declared shapes, a domain also carries restrictions Landlock
+imposes implicitly, which a policy does not select.  It may :manpage:`ptrace(2)`
+only a target confined by its own domain or by a domain nested under it
+(necessarily more restricted); tracing a less restricted, unrelated, or
+unsandboxed target is denied regardless of the policy.  A domain restricting the
+filesystem also denies changes to the filesystem topology and, by default,
+reparenting a file to a different directory, so inode-based rules cannot be
+bypassed by relocating a file (see `Limitations are not security bugs`_).
+Actions that are neither handled nor implicitly restricted are left to the
+system's other access controls; likewise, semantics that live only in user
+space, such as a service's own handling of the requests it receives, are beyond
+a kernel mechanism's reach.  Landlock's coverage (the set of restrictable
+actions) grows over time, extended without changing the meaning of existing
+rights.
+
+Landlock also supports observability: each domain has an identifier that is
+unique and not reused for the system's lifetime and increases by a random step,
+which hides the exact next value but not the underlying monotonic progression,
+so the identifier is an observability aid, not a confidentiality boundary.
+Denied actions can be logged through audit, but this per-domain configuration is
+not a security boundary.  Landlock access records describe denials, never
+allowed accesses, and a nested layer's denial is attributed to that layer, not
+bypassing an outer one (see :ref:`admin-guide/LSM/landlock:Audit`).
+
+Composition and trust boundaries
+--------------------------------
+
+Building a ruleset combines rights as a *union*: its rules come from a single
+trusted author, so each rule grants the accesses it describes.
+
+Enforcing a ruleset on a thread (a domain transition) combines constraints as an
+*intersection*: the stacked layers do not trust each other, so a thread's own
+transition can only ever remove access.  A thread cannot un-sandbox itself or
+regain an access a previous layer (or an inherited parent sandbox) denied. A
+thread may enforce a ruleset on all threads of its process at once, replacing
+the siblings' Landlock configuration.  This is not a relaxation across a
+security boundary, since threads share an address space and are not a security
+boundary (see `What is not a Landlock security bug`_).  Landlock's restrictions
+therefore stay attached to the thread for its lifetime, aside from such
+whole-process synchronization.
+
+Each access right has a precise and fixed semantic
+--------------------------------------------------
+
+An access right or scope controls exactly the operations its semantic defines,
+no more and no less.  A semantic is defined by an operation's effect, not by the
+syscall or code path used to reach it, including an indirect, deferred, or
+kernel-mediated effect the subject arranges.  Every path that produces a covered
+effect is in scope, so missing one is under-enforcement.  For example, the TCP
+rights control TCP ``bind`` and ``connect`` only, on any path (including an
+implicit connect performed while sending data), but they do not apply to MPTCP
+or SCTP, even when those use TCP internally.  A scope likewise covers the
+cross-domain interaction however it is produced: ``LANDLOCK_SCOPE_SIGNAL``
+covers a signal the subject arranges the kernel to deliver (e.g. ``SIGIO`` via
+:manpage:`fcntl(2)` ``F_SETOWN``), not only a direct :manpage:`kill(2)`.
+
+Each right is checked at its own enforcement point against the current domain,
+and Landlock does not retroactively revoke access already tied to an explicitly
+referenced kernel object (e.g. a file descriptor or io_uring instance).  A file
+descriptor obtained before enforcement is thus not covered afterward.  This is
+not under-enforcement but the intended capability-model behavior: a program can
+open its dependencies before restricting itself, or use only what a broker
+passes it while being unable to obtain those resources directly.
+
+This semantic is a permanent interface contract: it does not change, and the set
+of rights a policy targets does not grow on its own (new rights are opt-in; see
+:ref:`userspace-api/landlock:Compatibility`).  A kernel update only makes
+*enforcement* converge toward the semantic, in either direction:
+
+* Enforcing *less* than the semantic is under-enforcement: a security bug. The
+  fix may make a deployed policy stricter, but only by finally enforcing what it
+  already requested.
+* Enforcing *more* than the semantic is over-enforcement: a compatibility bug,
+  not a security bug.  The fix relaxes the restriction; because that is visible
+  to user space, it is advertised through the errata mechanism (see
+  :ref:`userspace-api/landlock:Compatibility`).  Most programs need not check
+  errata; when they do, an erratum should only gate enabling a restriction,
+  never dropping one.
+* An operation whose effect lies outside every right's semantic is simply not
+  covered; controlling it requires a new access right, not redefining an
+  existing one.
+
+What is a Landlock security bug
+-------------------------------
+
+A Landlock security bug is a deviation from this contract.  A sandboxed subject
+performs an action that its own active policy should deny (under-enforcement),
+including regaining an access across a domain transition. To classify a
+behavior, check in order:
+
+#. Does the domain *handle* the relevant access right or scope, or does an
+   implicit restriction above apply, and does that semantic cover the operation?
+   If not, the action is not restricted, possibly a limitation described below,
+   not a bug.
+#. Could the subject perform an action that a missing allow-list entry, a scope,
+   or an implicit restriction should deny?  That is a security bug.
+#. Did an access become allowed for the transitioning thread only after a
+   further domain transition, which must only remove access?  That is a security
+   bug.
+
+Conversely, Landlock denying a *legitimate* action is not under-enforcement. An
+intentional implicit restriction is expected, such as the ptrace hierarchy, or a
+filesystem-topology or reparenting restriction while a filesystem right is
+handled; these are non-selective limitations, described below.  Denying more
+than a handled right's semantic requires is over-enforcement, a compatibility
+bug, not a security bug.
+
+This concerns Landlock's access-control guarantees.  A vulnerability in
+Landlock's own implementation that an unprivileged process could exploit to
+escalate privileges or compromise the kernel, separate from this access-control
+classification, is a security bug under the general kernel threat model, like
+any other kernel code.
+
+Impact and blast radius
+-----------------------
+
+Security bugs (under-enforcement) vary in impact along two dimensions:
+
+* *Blast radius within a sandbox*: a flaw in a domain-wide mechanism such as
+  credential handling can drop all of a domain's restrictions (broad), while a
+  missing check for one access right only affects sandboxes using that right and
+  leaves their other restrictions intact (narrow).
+* *Affected processes*: a Landlock policy is self-imposed per domain, not
+  system-wide, so a bug weakens only the sandboxes that requested the affected
+  restriction; other sandboxes and unsandboxed processes are unaffected.
+
+Because Landlock only adds restrictions on top of existing access controls, an
+*enforcement* bug can at most undo Landlock's own restrictions on the affected
+sandbox: the leaked access is still subject to standard DAC and the other LSMs.
+
+What is not a Landlock security bug
+-----------------------------------
+
+The following are outside Landlock's threat model and are handled as ordinary
+issues, not security bugs (see also Documentation/process/threat-model.rst):
+
+* **Actions relying on privileges Landlock does not control**: a sandboxed
+  process stays bound by its domain whatever capabilities it holds, so bypassing
+  a handled right is a bug even for a privileged process.  Out of scope is what
+  a retained privilege (e.g. ``CAP_SYS_ADMIN``) enables outside Landlock's
+  coverage, including undermining the sandbox's own construction; dropping such
+  privileges is the sandbox's job (see `Sandboxing is layered`_).
+
+* **Interactions within the same domain**: the cross-domain restrictions
+  (:manpage:`ptrace(2)` and the ``LANDLOCK_SCOPE_*`` scopes) apply only when
+  leaving the domain hierarchy, not among tasks of the same domain or a domain
+  nested under it; a domain's filesystem and network access rights still apply
+  to all of its tasks.
+
+* **Direct interactions between threads of the same process**: Linux manages
+  credentials, and therefore the Landlock domain, per thread, so threads of one
+  process may even be in different domains.  Sharing an address space, they are
+  not a security boundary, and for practical reasons some restrictions are not
+  enforced between them: notably ``LANDLOCK_SCOPE_SIGNAL`` always allows signals
+  between threads of the same process, even in different domains (like the
+  :manpage:`ptrace(2)` same-process exception), because user space synchronizes
+  per-thread credentials by signaling within the process, and some runtimes do
+  not expose thread control.  This does not extend to objects tied to a
+  creator's domain, such as abstract UNIX sockets.  Consequently a per-thread
+  domain does not protect the process; a whole-process guarantee requires
+  confining all its threads with the same domain (see `Sandboxing is layered`_).
+
+* **Resources obtained from outside the sandbox**: receiving or inheriting a
+  file descriptor (or similar) is governed by the capability model, not
+  Landlock.  If an unsandboxed process willingly passes a sensitive resource,
+  that is a security-architecture issue (a possible confused deputy), not a
+  bypass; the resource carries the access rights set when it was created (e.g.
+  an FD's read/write mode), which may exceed the receiver's policy.  By
+  contrast, a resource the sandboxed process obtains itself stays bound by its
+  own domain: a subsystem it sets up, such as io_uring, captures the subject's
+  credentials, and with them the domain, so the work it later performs stays
+  restricted.
+
+* **Actions a user space service performs on the caller's behalf**: Landlock
+  mediates the kernel-level access to a service, such as reaching its socket,
+  not the service's own authorization of the requests it receives.  Exposing a
+  service to a sandbox is a policy choice; a more-privileged service that acts
+  on a sandboxed client's request without checking what that client should be
+  allowed is a confused deputy, an issue in the service, not a Landlock bypass.
+
+* **Denial of service by an already-privileged user**: such a user can exhaust
+  resources regardless of Landlock.  Landlock must, however, not give an
+  *unprivileged* process a new way to do so: its long-lived allocations are
+  accounted to the requesting task's memory cgroup (and thus limitable) and its
+  computation impacts only the processes requesting it (see
+  :ref:`userspace-api/landlock:Current limitations` and `Guiding principles for
+  safe access controls`_).
+
+* **Information disclosure about the policy or filesystem layout**: a denial
+  error code (e.g. ``EACCES`` versus ``ENOENT`` or ``EXDEV``) or timing can
+  reveal whether a path exists or what a policy allows.  Consistent with the
+  general kernel threat model, such probing side channels are not Landlock
+  security bugs; Landlock only minimizes avoidable ones (e.g. the random-step
+  domain identifiers above).
+
+* **Syscall-argument filtering**: that is seccomp-bpf's role, not Landlock's
+  (see `Guiding principles for safe access controls`_).
+
+Limitations are not security bugs
+---------------------------------
+
+Landlock is best-effort: it enforces what the running kernel and the program's
+configuration allow rather than refusing to sandbox at all.  An operation that
+cannot be restricted is a limitation, not a bug, in three cases:
+
+#. **Not requested**: the program did not handle the relevant right (a policy
+   choice).
+#. **Not supported by the running kernel**: the right belongs to a newer ABI
+   than the running kernel; programs query the ABI version and enable the
+   largest available subset.
+#. **Not supported by any kernel yet**: no access right covers the operation.
+   For example, Landlock restricts access to a file's data but not yet changes
+   to its metadata (chmod, chown, utime, setxattr).
+
+Likewise, some objects cannot be tied to rules and are not explicitly
+restrictable, such as pipes or sockets reachable only through
+``/proc/<pid>/fd/*``.  See :ref:`userspace-api/landlock:Current limitations`.
+
+Some restrictions are also non-selective rather than absent: a domain handling
+any filesystem right denies filesystem-topology changes (:manpage:`mount(2)`,
+:manpage:`pivot_root(2)` and the like), since Landlock cannot yet scope them to
+particular mounts, and denies reparenting a file to a different directory by
+default.  The ``LANDLOCK_ACCESS_FS_REFER`` right is denied even when not
+handled, and allowing a reparenting is subject to further constraints (see
+:ref:`userspace-api/landlock:Kernel interface`).  A policy cannot opt out of
+these while keeping its filesystem rights.  :manpage:`chroot(2)` is not denied:
+it only changes the calling process's root directory without relocating any
+inode, so the inode-based rules still apply (it can even narrow the visible
+tree).
+
+Best-effort matters because a program and its kernel are built and released
+independently, often by different parties, so the running kernel is often
+unknown at build time.  A program tested against the newest features it targets
+should still protect users as much as possible on an older kernel. This is safe
+because a right's semantic is identical across kernels (above), so a policy
+degrades gracefully.
+
+Landlock started with a limited set of access rights and gains more over time.
+Each new right is designed, tested, and documented, and once released its
+meaning becomes a permanent interface (above) that can never change. Classifying
+an operation as a limitation does not discourage lifting it: extending
+Landlock's coverage is welcome, and ongoing or planned work is listed in the
+`Landlock issue tracker <https://github.com/landlock-lsm/linux/issues>`_.
+
+Sandboxing is layered
+---------------------
+
+Landlock is the access-control layer of a sandbox, not the whole sandbox.  A
+robust sandbox also needs steps that are the program's responsibility: switching
+to an unprivileged user, dropping capabilities, setting ``PR_SET_NO_NEW_PRIVS``,
+and confining all threads of the process with the same domain.  A
+single-threaded process gets the latter for free; a multithreaded one can
+enforce a ruleset atomically on all its threads, or must otherwise synchronize
+them before any untrusted work.  Landlock is typically applied last, to tighten
+access and make the domain identifiable and auditable.
+
+Stronger isolation can come from combining Landlock with other mechanisms in a
+defense-in-depth approach, notably seccomp-bpf (see
+Documentation/userspace-api/seccomp_filter.rst) for what Landlock does not yet
+cover.  A long-term goal of Landlock is to control access to any kind of kernel
+resource in a way suited to sandboxing.
+
 Guiding principles for safe access controls
 ===========================================
 
-- 
2.54.0

