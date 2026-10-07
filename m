Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6B3B71C2
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367403; cv=none; b=Yie+xLqy7lSHIZqcnYH26J/PEAGgn4aVMZWxtuABuHsAlBcSjYgpSYCszQqjIAIDjs05VxjJJbaXpTq0mLhkBUigw2yD0bRsfJ89RQ5mCe+5tJdQjrOg2PpATKFQNwp3vMCl6d0PTovEJJPWbjqQXdFA1BHwMUa8XcVhy+HK8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367403; c=relaxed/simple;
	bh=jmj1prso2dZECkjru/xerXU7/uDWVdOItj9o+Z0fAO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPipbptZC3QdTv1R7S4lY36MbCYeFsqujIfsQeKMtQ1si1slKJ6sq4LqMFbWLMvtgwh0Ux8ReBxeCdNkvCnB7Ax58VfSS2BoXo7noJknY3jf75fY3iI1kIdDfHEsckDeeX2T4eEnhehFRP8jWQGCpLhu3zGL3xvJaShmudR0Qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VnjPBS2k; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VnjPBS2k"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j07wh59v9zrBy;
	Wed,  7 Oct 2026 12:03:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791367380;
	bh=z2BFpt6Syq0C2TAfIKz4C1tJ1cqJNHCn8mIO7xxQtPI=;
	h=From:To:Cc:Subject:Date:From;
	b=VnjPBS2kJn/Zl4erZoW7Svx7lZcLKuZhCQADVZSG+ldPwS0j8qBvW87DGXsKMO+Ws
	 ksQp3NVLCrA8qsQw/f6MtNIZgnwCi2cWmBaSWPd0+o3cN9SoCRaKwUmGlC5UwH/KX/
	 JzNHeM29DZarCxuNWnc1u4lKCwTwGnaTCMlEdjH4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j07wf6Wh7zvsD;
	Wed,  7 Oct 2026 12:02:58 +0200 (CEST)
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
Subject: [PATCH v5 0/8] Landlock: Namespace and capability control
Date: Wed,  7 Oct 2026 12:02:43 +0200
Message-ID: <20261007100255.1333386-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This series adds composable Landlock controls for namespace types and
Linux capabilities.  It is based on v7.3-rc5 plus the merged LSM
prerequisites, ending at c0a3be0adcce971e28de1c3baeeac472fe97fcaf.

The first three patches from v3 are now merged as commits 4f238e6e1c2c
("ns: Free anonymous mount namespaces via ns_common_free()"),
f675d2e95569 ("lsm: add LSM blob and hooks for namespaces"), and
e26307d83048 ("lsm: add LSM_AUDIT_DATA_NS for namespace audit
records") in lsm/dev (and landlock/next), so they are not resent.  The
updated base also includes commit 11d73af7b083 ("lsm: update the
BUILD_BUG_ON() in audit_log_lsm_data()"), which makes the audit-data
size bound architecture-independent.  The old quiet-mask copy patch is
also dropped: the ruleset snapshot and create-domain tracepoint already
run under the same ruleset lock, and the shared layer refactoring now
provides complete locked assignments.  The current series contains eight
patches.

Tingmao's Reviewed-by tag is not carried on the namespace and
capability enforcement patches, which now fold in the new trace events
and ABI 12, so a fresh review of those two is welcome.

Motivation
==========

Namespaces are a fundamental building block for containers and
application sandboxes, but user namespace creation significantly widens
the kernel attack surface.  CVE-2026-43284 / CVE-2026-43500 ("Dirty
Frag"), CVE-2026-46300 ("Fragnesia"), CVE-2023-32233 and CVE-2022-25636
(netfilter), CVE-2022-0492 (cgroup v1 release_agent), and CVE-2022-0185
(filesystem mount parsing) all demonstrate vulnerabilities reachable
through capabilities gained via user namespaces.  Advisories for the
2026 CVEs recommend disabling unprivileged user-namespace creation as a
temporary mitigation.  Some distributions, including Debian and Arch's
linux-hardened kernel through kernel.unprivileged_userns_clone, block
it entirely, but this removes a useful isolation primitive.
Fine-grained, per-process restrictions can retain that isolation while
reducing unnecessary kernel exposure.

Existing mechanisms (user.max_*_namespaces, userns_create,
PR_SET_NO_NEW_PRIVS, capability sets, and seccomp) each address only
part of this threat.  In particular, seccomp cannot dereference
clone3()'s flag structure and is not composable across independently
stacked policies.  Landlock layers let a session manager or container
runtime set broad limits while allowing each descendant to add stricter
ones.

Permissions and enforcement
===========================

The series introduces two independent, deny-by-default permissions with
Landlock ABI 12:

- LANDLOCK_PERMISSION_NAMESPACE_USE controls which CLONE_NEW* namespace
  types a process may acquire.  security_namespace_init() covers
  creation through clone(2), clone3(2), unshare(2), open_tree(2) and
  fsmount(2); security_namespace_install() covers entry through
  setns(2).

- LANDLOCK_PERMISSION_CAPABILITY_USE controls which CAP_* capabilities a
  process may exercise, independently of the target user namespace and
  regardless of how those capabilities were acquired, including through
  a new user namespace or a privileged exec.

The permissions are separate because they are enforced at independent
LSM hooks and address independent axes: acquiring access to a namespace
and exercising a capability.  If a domain handles both, both must allow
an operation: creating a network namespace needs a namespace rule
allowing CLONE_NEWNET and, because the kernel checks it, a capability
rule allowing CAP_SYS_ADMIN.  User namespace creation has no capability
check, so the namespace permission alone controls that path.

handled_permissions selects the permission types, and the capability and
namespace rule attributes carry raw CAP_* and CLONE_NEW* values.
Unknown member values are accepted and ignored for forward
compatibility; deny-by-default behavior remains unchanged.  Every
successful permission-rule call advances the ruleset version and emits
an add-rule trace event, including repeated and unknown-only effective
no-ops, so tracing preserves the syscall history.

Each rule can independently mark specific denied members quiet with
quiet_capabilities or quiet_namespace_types.  Quiet members remain
denied and visible to tracing with logged=0; only audit submission is
suppressed.

Implementation
==============

The first two patches prepare a shared per-layer representation:
quiet_masks becomes quiet_access, then each ruleset/domain layer is
represented by struct layer_config.  The namespace patch adds the
shared permission infrastructure and the capability patch fills the
second permission dimension.  struct permission_masks remains one forced
8-byte value containing 8 namespace bits and 41 capability bits on this
base; struct layer_config is 16 bytes.  Allowed and quiet masks are
snapshotted under the ruleset lock.

Namespace and capability denials use the common Landlock logging path.
Audit submission honors quiet masks, while denial tracepoints remain
visible.  The capability hook performs a fast applicability check
followed by a flat per-layer bitmask walk; the namespace hooks use the
same permission walker.

The sample adds LL_CAP, LL_CAP_QUIET, LL_NS and LL_NS_QUIET.  It remains
buildable without optional libcap development files: capability numbers
are always accepted, and builds with libcap also accept names.  Builds
without name support warn when capability settings are used.  Empty
capability or namespace lists keep their intentional fail-closed
meaning; absent lists leave the permission unhandled.

Limitations and future work
===========================

When Landlock filesystem restrictions are active, every mount-topology
change is denied if any filesystem right is handled.  Namespace-use
control does not lift that existing limitation; a dedicated mount
access-control type remains future work [1].

[1] https://github.com/landlock-lsm/linux/issues/14

Changelog
=========

Changes since v4:
https://patch.msgid.link/20261002124409.1277970-1-mic@digikod.net
- Isolate the capability test's denied hostname check in a private UTS
  namespace and consistently clear temporary effective capabilities
  after the related probes (isolation issue reported by Sashiko).
- Keep the sandboxer buildable without optional libcap development
  files by always accepting numeric capabilities and conditionally
  enabling names.  Warn when capability settings are used without name
  support and document the optional dependency in its own Kconfig help
  paragraph (reported by Sashiko).
- Source namespace flags from the kernel UAPI instead of libc, whose
  older headers omit CLONE_NEWTIME (reported by Sashiko).

Changes since v3:
https://patch.msgid.link/20260726161400.3010511-1-mic@digikod.net
- Rebase onto v7.3-rc5 plus the merged LSM prerequisites, including the
  architecture-independent audit-data size bound, ending
  at c0a3be0adcce.
- Assign the namespace and capability permissions to ABI 12.
- Spell out perm as permission across the UAPI, the internals, the
  trace fields, the tests, the sample, and the documentation, and name
  the audit blockers namespace.use and capability.use after their
  domains.
- Adapt the internal split to ruleset->layer and domain->layers[], using
  complete struct layer_config snapshots for handled and allowed masks.
- Add handled_permissions plus namespace/capability rule and denial
  trace events.  Successful permission rules, including effective
  no-ops, advance the version; audit-suppressed denials remain
  trace-visible.
- Gate the sample's new permission rules on ABI 12; consume unsupported
  settings, reject capability numbers that cannot fit in the UAPI's
  64-bit mask, and document the complete policy and its libcap
  dependency.
- Refresh permission, audit, trace, and permission-rule error
  documentation; make target-user-namespace independence explicit; and
  regenerate the basic trace example.
- Add trace and audit selftests for raw namespace values and IDs,
  permission-rule versions, rejected and repeated calls, ordinary and
  quiet denials, unrecorded CAP_OPT_NOAUDIT probes,
  target-user-namespace independence, allow/quiet overlap,
  youngest-denier selection, and invalid rule pointers; suppress
  expected namespace and capability conversion warnings, fix the clone3
  assertion, isolate hostname changes in private UTS namespaces, and drop
  CAP_AUDIT_CONTROL after fixture cleanup.
- Drop v3 patches 1-3 because their equivalents are merged.
- Drop Tingmao Wang's Reviewed-by from the namespace and capability
  enforcement patches, which now fold in the new trace events and ABI
  12.
- Drop v3 patch 6 because ruleset->lock already serialized the ruleset
  snapshot and trace emission.

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
- Rebase onto landlock/next (includes the resolve_unix and UDP
  series).  No ABI bump in v2: the series is planned to merge in
  the same kernel as the UDP series, which already bumped to 10.
- Drop three patches now upstream on landlock/next: the two
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

Mickaël Salaün (8):
  landlock: Rename quiet_masks to quiet_access
  landlock: Wrap per-layer access masks in struct layer_config
  landlock: Enforce namespace use restrictions
  landlock: Enforce capability restrictions
  selftests/landlock: Add namespace restriction tests
  selftests/landlock: Add capability restriction tests
  samples/landlock: Add capability and namespace restriction support
  landlock: Add documentation for capability and namespace restrictions

 Documentation/admin-guide/LSM/landlock.rst    |   46 +-
 Documentation/security/landlock.rst           |  178 +-
 Documentation/trace/events-landlock.rst       |   66 +-
 Documentation/userspace-api/landlock.rst      |  243 +-
 include/linux/landlock.h                      |   29 +-
 include/trace/events/landlock.h               |  244 +-
 include/uapi/linux/landlock.h                 |  139 +-
 samples/Kconfig                               |   13 +-
 samples/landlock/Makefile                     |    5 +
 samples/landlock/sandboxer.c                  |  269 +-
 security/landlock/Makefile                    |    4 +-
 security/landlock/access.h                    |   61 +-
 security/landlock/audit.c                     |   32 +-
 security/landlock/cap.c                       |  163 +
 security/landlock/cap.h                       |   48 +
 security/landlock/cred.h                      |    2 +-
 security/landlock/domain.c                    |   13 +-
 security/landlock/domain.h                    |   98 +-
 security/landlock/fs.c                        |    2 +-
 security/landlock/limits.h                    |    9 +
 security/landlock/log.c                       |   53 +-
 security/landlock/log.h                       |   10 +-
 security/landlock/net.c                       |    2 +-
 security/landlock/ns.c                        |  241 ++
 security/landlock/ns.h                        |   18 +
 security/landlock/ruleset.c                   |   27 +-
 security/landlock/ruleset.h                   |   33 +-
 security/landlock/setup.c                     |    4 +
 security/landlock/syscalls.c                  |  217 +-
 security/landlock/trace.c                     |   27 +-
 tools/testing/selftests/landlock/base_test.c  |   21 +-
 tools/testing/selftests/landlock/cap_test.c   | 1373 +++++++++
 tools/testing/selftests/landlock/common.h     |   23 +
 tools/testing/selftests/landlock/config       |    5 +
 tools/testing/selftests/landlock/fs_test.c    |   13 +-
 tools/testing/selftests/landlock/ns_test.c    | 2643 +++++++++++++++++
 tools/testing/selftests/landlock/trace.h      |   52 +-
 tools/testing/selftests/landlock/trace_test.c |    8 +-
 tools/testing/selftests/landlock/wrappers.h   |   29 +
 39 files changed, 6284 insertions(+), 179 deletions(-)
 create mode 100644 security/landlock/cap.c
 create mode 100644 security/landlock/cap.h
 create mode 100644 security/landlock/ns.c
 create mode 100644 security/landlock/ns.h
 create mode 100644 tools/testing/selftests/landlock/cap_test.c
 create mode 100644 tools/testing/selftests/landlock/ns_test.c


base-commit: c0a3be0adcce971e28de1c3baeeac472fe97fcaf
-- 
2.55.0

