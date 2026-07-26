Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409F3CAE95
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082475; cv=none; b=o3RPGdYaNS1z6tDpJvomrk+WhHjx2nsgDnSstEYoObmnSemWaAcFBmHhY69whbroCToX8kzQ3WVgkbLKVaPk4gXbOZgL2vbM1Bd1za12bifBi6SZWxrjUoDwnp9SGwjeaZ2WWqH+3JIilxnM4DrCewPRtECm5WDHJk3eZUemoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082475; c=relaxed/simple;
	bh=X35VDc5bsyCAsVXhXfrV6JaupPelLoyKPbHu50wwBJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FkmSlt18+oojGteAlGeFbehKMeZ7KjmYayYWkOCxWC6vlR8i2ol+4+Bs66ZkAI94sTPm96ugaQB/fPRjwej0gJjzUPelNqltiKXU/F0Hu/jSCJmI2wDEz+YqWy3PLn6MPgebHhUI+0+j2/K690Oxih/EWPhMK1Kvy62mOR9xgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0igy0KGc; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0igy0KGc"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h7Rcg5jDYzcNT;
	Sun, 26 Jul 2026 18:14:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785082451;
	bh=2n37VSmpgOuXKc4pjqJk9nhzq9K0gwIUCDV/Hmf37QQ=;
	h=From:To:Cc:Subject:Date:From;
	b=0igy0KGcy1abAYOoc+ZkimIhrh7DNxBfx/UDU+Z3LOKtDazT3WztWpykEku2l8W/E
	 HePnNWCTGOojySsiJwT5ysktph77m1yttCxWjbYWHdo9LrjMLdD0aLTlO6IwlT1Ke9
	 SLlU6Y3VZO5mTMdbec3waea21SAnW5E6CF1+VxiA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h7Rcd6l6kzjyx;
	Sun, 26 Jul 2026 18:14:09 +0200 (CEST)
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
Subject: [PATCH v3 00/12] Landlock: Namespace and capability control
Date: Sun, 26 Jul 2026 18:13:45 +0200
Message-ID: <20260726161400.3010511-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This series builds on Christian Brauner's namespace LSM blob RFC [1],
included as patches 1 and 2 (a preparatory anonymous-mount-namespace
fix and the LSM blob and hooks it enables).  The FOR_EACH_NS_TYPE
patch from v1 has been merged in master: commit 935a04923ad2 ("nsproxy:
Add FOR_EACH_NS_TYPE() X-macro and CLONE_NS_ALL").

Christian, could you please review patch 1?  It splits the anonymous
mount-namespace free-path fix you proposed out of the LSM blob patch:
free_mnt_ns() now calls ns_common_free() unconditionally, and
__ns_common_free() releases the proc inum only for dynamically
allocated namespaces, so the reserved anonymous-mount inum is never
returned to the allocator.

Paul, could you please review patch 2 and 3?  The first adds the new LSM
hooks and the second adds LSM_AUDIT_DATA_NS, a new audit record type
that logs namespace_type and ns_id for namespace-related LSM denials.

Tingmao, could you please review patches 7 and 8?  They extend your
quiet feature to the capability and namespace permissions and diverge
from your earlier quiet_perm suggestion; the rationale is in the commit
message.  Patches 4 and 6 also rename and re-home the quiet mask your
feature added (quiet_masks -> quiet_access, copied in the merge helper).

Günther and Tingmao, I dropped your Reviewed-by tags from patches 7 and
8: those tags covered the v1 patches, which did not carry the per-member
quiet support folded in here.  A fresh review of the quiet additions is
welcome.

Motivation
==========

Namespaces are a fundamental building block for containers and
application sandboxes, but user namespace creation significantly widens
the kernel attack surface.  CVE-2026-43284 / CVE-2026-43500 ("Dirty
Frag"), CVE-2026-46300 ("Fragnesia"), CVE-2023-32233 and CVE-2022-25636
(netfilter), CVE-2022-0492 (cgroup v1 release_agent), and CVE-2022-0185
(filesystem mount parsing) all demonstrate vulnerabilities exploitable
only through capabilities gained via user namespaces.  Advisories for
the 2026 CVEs recommend disabling unprivileged user-namespace creation
as a temporary mitigation.  Some distributions (e.g. Debian and Arch's
linux-hardened kernel via the kernel.unprivileged_userns_clone sysctl)
block user namespace creation entirely, but this removes a useful
isolation primitive.  Fine-grained control allows trusted programs to
use namespaces while preventing unnecessary exposure for programs that
do not need them.

Existing mechanisms (user.max_*_namespaces sysctls, userns_create LSM
hook, PR_SET_NO_NEW_PRIVS, and capset) each address part of this threat
but none provides per-process, fine-grained control over both namespace
types and capabilities.  Container runtimes resort to seccomp-based
clone/unshare filtering, but seccomp cannot dereference clone3's flag
structure, forcing runtimes to block clone3 entirely.

Landlock's composable layer model enables several patterns: a user
session manager can restrict namespace types and capabilities broadly
while allowing trusted programs to create the namespaces they need, and
each deeper layer can further restrict the allowed set.  Container
runtimes can similarly deny namespace creation inside managed
containers.

Permissions
===========

Two permissions are needed because the controlled operations sit on
different LSM hook sites (namespace_init/namespace_install vs
capable) and address independent threat axes: capability acquisition
via user-namespace creation, and capability exercise after acquisition.
Collapsing them into a single permission would conflate hook semantics.
LANDLOCK_PERM_NAMESPACE_USE intentionally covers every kernel path
that grants access to a namespace (creation, entry, and fd reference)
because each path widens the kernel attack surface for that namespace
type; splitting it into finer create/enter/fd-reference permissions
would add UAPI surface without isolating a distinct attack axis.

This series adds two new permission categories to Landlock:

- LANDLOCK_PERM_NAMESPACE_USE: Restricts which namespace types a
  sandboxed process can use: creation (unshare/clone), entry (setns),
  and fd reference (open_tree, fsmount).  User namespace creation has
  no capability check in the kernel, so this is the only enforcement
  mechanism for that path.

- LANDLOCK_PERM_CAPABILITY_USE: Restricts which Linux capabilities a
  sandboxed process can use, regardless of how they were obtained
  (including through user namespace creation).

Both use new handled_perm and LANDLOCK_RULE_* constants following the
existing allow-list model.  The UAPI uses raw CAP_* and CLONE_NEW*
values directly; unknown values are silently accepted for forward
compatibility (the allow-list denies them by default).  This series is
rebased onto v7.2-rc4, which already ships Landlock ABI 10 (UDP support
and Tingmao Wang's quiet feature) without the new permissions, so the
series bumps the Landlock ABI to 11.

Each rule can also quiet the audit records of specific denied members,
per member and independently of the allowed set, via the
quiet_capabilities and quiet_namespace_types rule fields.  This
extends Tingmao Wang's quiet feature (LANDLOCK_ADD_RULE_QUIET for
filesystem and network objects) to the two new permissions, but uses a
per-rule bitmask instead of the shared flag because capabilities and
namespace types are a bounded, kernel-defined member set rather than
unbounded rb-tree objects.  This diverges from the earlier coarse
quiet_perm suggestion; the rationale is in the commit message.

The handled_perm infrastructure is designed to be reusable by future
permission categories.  The last patch documents the design rationale
for the permission model and the criteria for choosing between
handled_access_*, handled_perm, and scoped.  A patch series to add
socket creation control is under review [2]; it could benefit from the
same permission model to achieve complete deny-by-default coverage of
socket creation.

Enforcement
===========

All of these example vulnerabilities follow the same pattern: an
unprivileged user creates a user namespace to obtain capabilities, then
creates a second namespace to exercise them against vulnerable code.
LANDLOCK_PERM_NAMESPACE_USE prevents this by denying the user
namespace (eliminating the capability grant) or the specific namespace
type needed to exercise it.  LANDLOCK_PERM_CAPABILITY_USE independently
prevents it by denying the required capability.

Namespace restriction is enforced at two hook sites: namespace_init
(unshare/clone) and namespace_install (setns).  Together, these ensure a
process denied a namespace type cannot circumvent the restriction by
entering a pre-existing namespace via setns() on an inherited or passed
file descriptor.  When a domain handles both permissions, both must
independently allow the operation (e.g., unshare(CLONE_NEWNET) requires
both CAP_SYS_ADMIN to be allowed and CLONE_NEWNET to be allowed).

Design evolution
================

The first approach added CAP_OPT flags to security_capable() to
distinguish namespace creation contexts.  This was too invasive and
would have required capability splitting (a dedicated CAP_NAMESPACE)
which does not help because the CAP_SYS_ADMIN fallback for backward
compatibility undermines the distinction.

The second stored the namespace creator's domain in the LSM blob and
used domain ancestry comparison in hook_capable() to bypass capability
checks for namespace management operations.  A SCOPE_NAMESPACE flag
restricted setns() by the namespace creator's domain, like SCOPE_SIGNAL.
Both were dropped: scopes should only concern Landlock properties
(domain relationships), not kernel namespace state; and the
cross-namespace heuristic (ns != cred->user_ns) did not accurately
identify namespace management operations.

The final design drops all of this.  The key insight is that
capabilities gained through user namespace creation are only exercisable
against namespaces of a specific type: creating a network namespace is
what makes CAP_NET_ADMIN exercisable.  LANDLOCK_PERM_NAMESPACE_USE
controls where capabilities are exercisable by restricting which
namespace types can be acquired.  LANDLOCK_PERM_CAPABILITY_USE controls
which capabilities are available, as a pure per-layer bitmask check with
no namespace awareness.  The two are independently enforced at their own
hook sites, with no interaction in hook_capable().  No scope flag is
added in this series.

Limitations and future work
===========================

When Landlock filesystem restrictions are in use, mount namespace
creation has an inherent limitation: all mount topology changes are
denied when any filesystem right is handled.  A dedicated mount
access control type is left for future work [3].

Per Paul Moore's review, no security_namespace_switch() post-hook is
added in this series: such a hook would only serve LSMs that maintain
per-task state derived from the active namespace set (SELinux-style
state tracking), and no current LSM (including this series) needs that.
Landlock enforces at namespace_install() and namespace_init(), before
the task-to-nsproxy switch.  The hook is left for a separate LSM
infrastructure proposal once a concrete user emerges.

https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org [1]
https://lore.kernel.org/r/20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com [2]
https://github.com/landlock-lsm/linux/issues/14 [3]

Changes since v2:
https://patch.msgid.link/20260527181127.879771-1-mic@digikod.net
- Rebased onto v7.2-rc4, which now ships ABI 10 (UDP support and the
  merged quiet feature) and the series' dependencies; the new
  permissions therefore bump the Landlock ABI to 11, and handled_perm
  is placed after the released quiet_access_*/quiet_scoped fields.
- Added per-member quiet support for the capability and namespace
  permissions to their enforcement patches (patches 7 and 8): each rule
  carries independent allowed and quiet member bitmasks
  (quiet_capabilities / quiet_namespace_types).  The capability and
  namespace rule attributes are renamed accordingly (perm plus allowed_*
  plus quiet_*) and grow to 24 bytes.
- Extended the namespace and capability selftests (patches 9 and 10)
  for the rebase and the per-member quiet feature: renamed the rule
  attributes (perm plus allowed_*/quiet_*), bumped the ABI expectation
  to 11, and added per-member quiet audit tests (quiet-only denial,
  per-member quiet, allow-and-quiet, quiet-inert-when-also-allowed,
  youngest-layer-wins, parent-only-denying).  Added further coverage: a positive both-caps
  mount setns leg and a both-perms inverse test, an install-hook mirror
  of the unknown-bit no-runtime-effect test, quieted-setns and
  unknown-quiet-bit audit cases, positive controls proving quiet and
  CAP_OPT_NOAUDIT suppression are per-member (not global), an
  assertion that a quieted capability is still denied, and a
  combined-unshare pair proving CLONE_NEWUSER combined with another
  type in one unshare(2) still needs an allowed CAP_SYS_ADMIN.
- Dropped the Reviewed-by tags from Günther Noack and Tingmao Wang on
  patches 7 and 8: those tags covered the v1 patches, which did not
  carry the per-member quiet support folded in here; a fresh review of
  the quiet additions is welcome.
- Removed the RCU note from the security_namespace_free() kdoc
  (patch 2, suggested by Paul Moore).
- Documentation: fixed the CAP_BPF forward-compatibility example (rules
  allow-list), dropped the "category" jargon, added capabilities(7) /
  namespaces(7) references, and clarified the namespace "use" semantics
  (suggested by Günther Noack); also documented the combined
  deny-by-default, that creating a non-user namespace needs
  CAP_SYS_ADMIN even when CLONE_NEWUSER is combined in one unshare(),
  and the per-member audit quieting for the two permissions.
- Sandboxer (patch 11): added LL_CAP_QUIET and LL_NS_QUIET to quiet
  capability and namespace-type denials, merged with the allowed bits
  into one rule per category.
- New patch 1 ("ns: Free anonymous mount namespaces via
  ns_common_free()"): the anonymous-mount free-path change is split out
  of the LSM hooks patch, with a commit message explaining the
  inum-range check (suggested by Christian Brauner and Paul Moore).
- New patches 4 and 6 ("landlock: Rename quiet_masks to quiet_access"
  and "landlock: Copy the quiet mask in the ruleset merge helper"):
  rename the base's quiet-mask field for symmetry with the new
  quiet_perm, and copy both quiet masks inside merge_ruleset() under the
  ruleset lock so a new domain captures a single atomic snapshot of the
  ruleset (allowed plus quiet); no user-visible change.

Changes since RFC v1:
https://patch.msgid.link/20260312100444.2609563-1-mic@digikod.net
- Move security_namespace_install() before ns->ops->install() in
  validate_ns() and fix proc_free_inum() error path when inum is
  caller-provided (patch 1, suggested by Christian Brauner).
- Replace inum with ns_id in namespace audit records: ns_id is the
  stable 64-bit namespace identifier, never recycled (patches 2, 4,
  6, 9; suggested by Christian Brauner).
- Fix user_denied.setns test to expect EPERM from Landlock instead
  of EINVAL from userns_install() after hook reordering (patch 6).
- Add __packed __aligned(sizeof(u64)) to struct perm_masks to fix
  m68k build failure where GCC packs bitfields at byte granularity,
  and add WARN_ON_ONCE guards for invalid perm_bit or request_value
  in landlock_perm_is_denied() (patch 4, suggested by Tingmao Wang).
- Fix anonymous mount namespace blob leak: make __ns_common_free()
  always call security_namespace_free() and conditionally call
  proc_free_inum() via MNT_NS_INO_SPECIAL_MAX, so free_mnt_ns()
  calls ns_common_free() unconditionally (patch 1, suggested by
  Christian Brauner, also reported by Daniel Durning).
- Unify hook_namespace_init() and hook_namespace_install() into a
  shared check_ns_type() helper and drop the redundant entry-level
  WARN_ON_ONCE (the downstream warns in landlock_ns_type_to_bit()
  and landlock_perm_is_denied() suffice; patch 4).
- Remove duplicate ns_audit.unshare_denied test (identical to
  ns_audit.create_denied; patch 6).
- Add sandboxed_allowed variant to setns_cross_process to cover
  allowed cross-process setns (patch 6).
- Rebase onto landlock-next (includes the resolve_unix and UDP
  series).  No ABI bump in v2: the series is planned to merge in
  the same kernel as the UDP series, which already bumped to 10.
- Drop three patches now upstream on landlock-next: the two
  audit-test fixes (filter dealloc records, default audit socket
  timeout) sent independently with Cc: stable, plus the
  allowed_access best-effort filtering demonstration patch.
- Rename LANDLOCK_PERM_NAMESPACE_ENTER to LANDLOCK_PERM_NAMESPACE_USE
  (and audit blocker perm.namespace_enter to perm.namespace_use) for
  semantic accuracy: the verb _ENTER fits setns/unshare/clone but
  misleads for open_tree and fsmount where the caller holds an fd
  reference without entering.  _USE covers both cases and mirrors
  LANDLOCK_PERM_CAPABILITY_USE.
- Add a Design philosophy section to
  Documentation/security/landlock.rst stating Landlock's principle:
  restrict access to data, other tasks, and kernel resources.
- Rewrite Documentation/security/landlock.rst Ruleset restriction
  models with the per-object (handled_access_*) versus per-category
  (handled_perm) framing in place of the previous chokepoints/
  gateways wording.
- Enumerate the seven syscall paths covered by
  LANDLOCK_PERM_NAMESPACE_USE in
  Documentation/userspace-api/landlock.rst (membership via
  unshare/clone/setns; fd reference via open_tree and fsmount).
- Document the deterministic-semantics rationale for accepting
  unknown category member values in rule bodies (per-category
  permissions section of Documentation/security/landlock.rst);
  range-checking against CAP_LAST_CAP is intentionally avoided.
- Address Günther Noack's nits in the layer_config wrapper patch:
  clarify that _LANDLOCK_ACCESS_FS_INITIALLY_DENIED is ORed with
  the .handled field of all ruleset->layers[] entries; rename
  landlock_upgrade_handled_access_masks() to
  landlock_upgrade_handled_layer_config() to match the parameter
  type; rewrap the @layers kdoc to greedy fill (eliminating v1's
  manual short "rulesets in a" line).
- Rename struct layer_rights to struct layer_config: "config" is
  the more general term for per-layer state.
- Rename internal struct perm_rules to struct perm_masks to parallel
  the sibling access_masks in struct layer_config.
- Collect Reviewed-by tags from Günther Noack on patches 2, 3, 4,
  and 5 from the v1 thread.  Patch 1 and patch 8 changed
  substantially since v1 (the mount-namespace blob leak fix and
  validate_ns() reordering for patch 1; the libcap migration for
  patch 8), so the Reviewed-by tags from reviewers who had not
  requested those changes are not carried forward; the affected
  reviewers are kept as Cc:.
- Rename security_namespace_alloc() to security_namespace_init()
  (and the LSM hook namespace_alloc -> namespace_init, plus
  Landlock's hook_namespace_alloc() -> hook_namespace_init())
  to match the caller-name convention and reflect that the hook
  initialises LSM state attached to a constructed ns_common rather
  than allocating it (patch 1, suggested by Paul Moore).
- Refine the security_namespace_free() kdoc to clarify that
  RCU-safe blob freeing is required only if an LSM exposes data
  within the blob to concurrent RCU readers, and document that
  the blob memory itself is released with kfree() after the
  namespace_free hooks return (patch 1, suggested by Paul Moore).
- Use cap_from_name(3) from libcap in the sandboxer; LL_CAP now
  takes colon-delimited capability names (e.g. "cap_sys_chroot")
  or numbers (libcap's numeric fallback), and the Makefile links
  libcap (patch 8, suggested by Günther Noack).
- Rename the sandboxer env var LL_CAPS to LL_CAP for consistency
  with the singular form used by all other LL_* sandboxer env vars
  (LL_NS, LL_FS_RO, LL_FS_RW, LL_TCP_BIND, LL_TCP_CONNECT,
  LL_SCOPED, LL_FORCE_LOG; patch 8).
- Add a bridging sentence in the per-category permissions section
  of Documentation/security/landlock.rst contrasting per-category
  permissions with per-object access rights (patch 9, suggested by
  Günther Noack).
- Disambiguate the orthogonality invariant in
  Documentation/security/landlock.rst ("all new scoped features"
  -> "all Landlock access controls") to avoid clash with the UAPI
  scoped field (patch 9, suggested by Justin Suess).
- Add an introductory paragraph in
  Documentation/userspace-api/landlock.rst contrasting
  LANDLOCK_PERM_CAPABILITY_USE with PR_SET_NO_NEW_PRIVS (patch 9,
  suggested by Justin Suess).
- Add an explicit static_assert that LANDLOCK_NUM_PERM_CAP +
  LANDLOCK_NUM_PERM_NS fits in u64, complementing the implicit
  sizeof guard on struct perm_masks (patch 5).
- Document that setns_cross_process exercises only CLONE_NEWUTS
  (patch 6).
- Add add_rule_unknown_no_runtime_effect tests asserting that a
  rule listing only unknown bits has no runtime effect (patches
  6, 7).
- Extend the cap/ns stacking tests with the parent-denies/child-
  allows variant to complete per-layer walker direction coverage
  (patches 6, 7).

Christian Brauner (2):
  ns: Free anonymous mount namespaces via ns_common_free()
  security: add LSM blob and hooks for namespaces

Mickaël Salaün (10):
  security: Add LSM_AUDIT_DATA_NS for namespace audit records
  landlock: Rename quiet_masks to quiet_access
  landlock: Wrap per-layer access masks in struct layer_config
  landlock: Copy the quiet mask in the ruleset merge helper
  landlock: Enforce namespace use restrictions
  landlock: Enforce capability restrictions
  selftests/landlock: Add namespace restriction tests
  selftests/landlock: Add capability restriction tests
  samples/landlock: Add capability and namespace restriction support
  landlock: Add documentation for capability and namespace restrictions

 Documentation/admin-guide/LSM/landlock.rst   |   19 +-
 Documentation/security/landlock.rst          |  173 +-
 Documentation/userspace-api/landlock.rst     |  236 +-
 fs/namespace.c                               |    3 +-
 include/linux/lsm_audit.h                    |    5 +
 include/linux/lsm_hook_defs.h                |    3 +
 include/linux/lsm_hooks.h                    |    1 +
 include/linux/ns/ns_common_types.h           |    3 +
 include/linux/security.h                     |   20 +
 include/uapi/linux/landlock.h                |  127 +-
 include/uapi/linux/nsfs.h                    |    1 +
 kernel/nscommon.c                            |   17 +-
 kernel/nsproxy.c                             |    6 +
 samples/landlock/Makefile                    |    1 +
 samples/landlock/sandboxer.c                 |  200 +-
 security/landlock/Makefile                   |    4 +-
 security/landlock/access.h                   |   77 +-
 security/landlock/audit.c                    |   31 +-
 security/landlock/audit.h                    |    2 +
 security/landlock/cap.c                      |  137 +
 security/landlock/cap.h                      |   50 +
 security/landlock/cred.h                     |   55 +-
 security/landlock/domain.h                   |   10 +-
 security/landlock/limits.h                   |    9 +
 security/landlock/ns.c                       |  156 ++
 security/landlock/ns.h                       |   74 +
 security/landlock/ruleset.c                  |   43 +-
 security/landlock/ruleset.h                  |   73 +-
 security/landlock/setup.c                    |    4 +
 security/landlock/syscalls.c                 |  178 +-
 security/lsm_audit.c                         |    4 +
 security/lsm_init.c                          |    2 +
 security/security.c                          |   72 +
 tools/testing/selftests/landlock/base_test.c |   20 +-
 tools/testing/selftests/landlock/cap_test.c  |  889 +++++++
 tools/testing/selftests/landlock/common.h    |   23 +
 tools/testing/selftests/landlock/config      |    5 +
 tools/testing/selftests/landlock/fs_test.c   |   13 +-
 tools/testing/selftests/landlock/ns_test.c   | 2380 ++++++++++++++++++
 tools/testing/selftests/landlock/wrappers.h  |   29 +
 40 files changed, 5054 insertions(+), 101 deletions(-)
 create mode 100644 security/landlock/cap.c
 create mode 100644 security/landlock/cap.h
 create mode 100644 security/landlock/ns.c
 create mode 100644 security/landlock/ns.h
 create mode 100644 tools/testing/selftests/landlock/cap_test.c
 create mode 100644 tools/testing/selftests/landlock/ns_test.c

-- 
2.54.0

