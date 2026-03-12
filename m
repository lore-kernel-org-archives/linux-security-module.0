Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2C3BED05
	for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310445; cv=none; b=dlOFzm0m1FpBvxqzKhQ3JXDWk5IEPkxuBjIrA19nV3o7QsyM1OA/n/34ls28XAR6/GenAj8WERXoiQkIpIIvhgybKaWBJvxjI4+r3FeUfvQGIzdPXYMrZ9RwU8jxmO+sNl3zFJIbjW6+jnQE4ZJ5BONbdrf3ZZs4irMTGctnzgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310445; c=relaxed/simple;
	bh=GFu4PJreuhmHlM2sVSrVPhXx0+56WKntAoKELbPLtfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GkMGgPhSbWv0kxhqL6H4rqqW/O510Thg67xWPvOUFj+OL6NPKAee4RQoSSbr89MtWH4dcUz/J4XUVRcG6MnPyHPekd+mzZsCsz6KQo2csFJCC1ZXHO/wB3yEQUxxetmvJgQjggs8fsAr/DYrmrgMCFSp41JjS18DiCebuAi4o+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=U+c2FJgn; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="U+c2FJgn"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fWjsZ3v13z19fy;
	Thu, 12 Mar 2026 11:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773309906;
	bh=LXD0E49hOrqvSLymcDYSQ+jv5CtOtilrn1vItkJ82dw=;
	h=From:To:Cc:Subject:Date:From;
	b=U+c2FJgnH82k60eRsEQmQAA+tmwvsGIOgAwMj2WsZ7xRtv9Z7Opt/GuxdwEAKpDZX
	 yin+3ritOWTch8zHSdHH4hrr3FEuA/iB0TsdNs6xYLYKoL9XYXE9sbEpro/72H5ZS4
	 YcO0FbW2040fsk8mjFVvgRN/t440Ie9XGHeIYjKw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fWjsY1XKsz17b;
	Thu, 12 Mar 2026 11:05:05 +0100 (CET)
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
Subject: [RFC PATCH v1 00/11] Landlock: Namespace and capability control
Date: Thu, 12 Mar 2026 11:04:33 +0100
Message-ID: <20260312100444.2609563-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Namespaces are a fundamental building block for containers and
application sandboxes, but user namespace creation significantly widens
the kernel attack surface.  CVE-2022-0185 (filesystem mount parsing),
CVE-2022-25636 and CVE-2023-32233 (netfilter), and CVE-2022-0492 (cgroup
v1 release_agent) all demonstrate vulnerabilities exploitable only
through capabilities gained via user namespaces.  Some distributions
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

This series adds two new permission categories to Landlock:

- LANDLOCK_PERM_NAMESPACE_ENTER: Restricts which namespace types a
  sandboxed process can acquire: both creation (unshare/clone) and entry
  (setns).  User namespace creation has no capability check in the
  kernel, so this is the only enforcement mechanism for that entry
  point.

- LANDLOCK_PERM_CAPABILITY_USE: Restricts which Linux capabilities a
  sandboxed process can use, regardless of how they were obtained
  (including through user namespace creation).

Both use new handled_perm and LANDLOCK_RULE_* constants following the
existing allow-list model.  The UAPI uses raw CAP_* and CLONE_NEW*
values directly; unknown values are silently accepted for forward
compatibility (the allow-list denies them by default).  The Landlock ABI
version is bumped from 8 to 9.

The handled_perm infrastructure is designed to be reusable by future
permission categories.  The last patch documents the design rationale
for the permission model and the criteria for choosing between
handled_access_*, handled_perm, and scoped.  A patch series to add
socket creation control is under review [2]; it could benefit from the
same permission model to achieve complete deny-by-default coverage of
socket creation.

This series builds on Christian Brauner's namespace LSM blob RFC [1],
included as patch 1.

Christian, could you please review patch 3?  It adds a FOR_EACH_NS_TYPE
X-macro to ns_common_types.h and derives CLONE_NS_ALL, replacing inline
CLONE_NEW* flag enumerations in nsproxy.c and fork.c.

Paul, could you please review patch 2?  It adds LSM_AUDIT_DATA_NS, a new
audit record type that logs namespace_type and inum for
namespace-related LSM denials.

All four example vulnerabilities follow the same pattern: an
unprivileged user creates a user namespace to obtain capabilities, then
creates a second namespace to exercise them against vulnerable code.
LANDLOCK_PERM_NAMESPACE_ENTER prevents this by denying the user
namespace (eliminating the capability grant) or the specific namespace
type needed to exercise it.  LANDLOCK_PERM_CAPABILITY_USE independently
prevents it by denying the required capability.

Namespace restriction is enforced at two hook sites: namespace_alloc
(unshare/clone) and namespace_install (setns).  Together, these ensure a
process denied a namespace type cannot circumvent the restriction by
entering a pre-existing namespace via setns() on an inherited or passed
file descriptor.  When a domain handles both permissions, both must
independently allow the operation (e.g., unshare(CLONE_NEWNET) requires
both CAP_SYS_ADMIN to be allowed and CLONE_NEWNET to be allowed).

Design evolution:

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
what makes CAP_NET_ADMIN exercisable.  LANDLOCK_PERM_NAMESPACE_ENTER
controls where capabilities are exercisable by restricting which
namespace types can be acquired.  LANDLOCK_PERM_CAPABILITY_USE controls
which capabilities are available, as a pure per-layer bitmask check with
no namespace awareness.  The two are independently enforced at their own
hook sites, with no interaction in hook_capable().  No scope flag is
added in this series.

Note that when Landlock filesystem restrictions are in use, mount
namespace creation has an inherent limitation: all mount topology
changes are denied when any filesystem right is handled, which is
optional.  A dedicated mount access control type is left for future work
[3].

https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org [1]
https://lore.kernel.org/r/20251118134639.3314803-1-ivanov.mikhail1@huawei-partners.com [2]
https://github.com/landlock-lsm/linux/issues/14 [3]

Christian Brauner (1):
  security: add LSM blob and hooks for namespaces

Mickaël Salaün (10):
  security: Add LSM_AUDIT_DATA_NS for namespace audit records
  nsproxy: Add FOR_EACH_NS_TYPE() X-macro and CLONE_NS_ALL
  landlock: Wrap per-layer access masks in struct layer_rights
  landlock: Enforce namespace entry restrictions
  landlock: Enforce capability restrictions
  selftests/landlock: Drain stale audit records on init
  selftests/landlock: Add namespace restriction tests
  selftests/landlock: Add capability restriction tests
  samples/landlock: Add capability and namespace restriction support
  landlock: Add documentation for capability and namespace restrictions

 Documentation/admin-guide/LSM/landlock.rst    |   19 +-
 Documentation/security/landlock.rst           |   80 +-
 Documentation/userspace-api/landlock.rst      |  156 +-
 include/linux/lsm_audit.h                     |    5 +
 include/linux/lsm_hook_defs.h                 |    3 +
 include/linux/lsm_hooks.h                     |    1 +
 include/linux/ns/ns_common_types.h            |   47 +-
 include/linux/security.h                      |   20 +
 include/uapi/linux/landlock.h                 |   89 +-
 kernel/fork.c                                 |    7 +-
 kernel/nscommon.c                             |   12 +
 kernel/nsproxy.c                              |   21 +-
 samples/landlock/sandboxer.c                  |  164 +-
 security/landlock/Makefile                    |    2 +
 security/landlock/access.h                    |   72 +-
 security/landlock/audit.c                     |    8 +
 security/landlock/audit.h                     |    2 +
 security/landlock/cap.c                       |  142 ++
 security/landlock/cap.h                       |   49 +
 security/landlock/cred.h                      |   47 +-
 security/landlock/limits.h                    |    9 +
 security/landlock/ns.c                        |  188 +++
 security/landlock/ns.h                        |   74 +
 security/landlock/ruleset.c                   |   23 +-
 security/landlock/ruleset.h                   |   53 +-
 security/landlock/setup.c                     |    4 +
 security/landlock/syscalls.c                  |  124 +-
 security/lsm_audit.c                          |    4 +
 security/lsm_init.c                           |    2 +
 security/security.c                           |   76 +
 tools/testing/selftests/landlock/audit.h      |   29 +-
 tools/testing/selftests/landlock/audit_test.c |    2 -
 tools/testing/selftests/landlock/base_test.c  |   20 +-
 tools/testing/selftests/landlock/cap_test.c   |  614 ++++++++
 tools/testing/selftests/landlock/common.h     |   23 +
 tools/testing/selftests/landlock/config       |    5 +
 tools/testing/selftests/landlock/ns_test.c    | 1379 +++++++++++++++++
 tools/testing/selftests/landlock/wrappers.h   |    6 +
 38 files changed, 3487 insertions(+), 94 deletions(-)
 create mode 100644 security/landlock/cap.c
 create mode 100644 security/landlock/cap.h
 create mode 100644 security/landlock/ns.c
 create mode 100644 security/landlock/ns.h
 create mode 100644 tools/testing/selftests/landlock/cap_test.c
 create mode 100644 tools/testing/selftests/landlock/ns_test.c


base-commit: 5dfb8077be2bbe2c3b9477da759e80fa9f98da42
-- 
2.53.0

