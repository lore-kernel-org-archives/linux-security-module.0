Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CC28E0
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228951; cv=none; b=pD/vIEMQT5iDrMNAv6HNpDrq7MRLoPvCsacQm1X5o7dI0UFEp1+MJPsX2qVvxv8mvaKbA9xQ5jdsYd/JrN1Va+cawsnHtlwUcDVXCAakmbO8v5k8S6x614LiwYRu6FUqcQBa9kQh8ernwRvfdAcY5F98+3uaFKpq4HfovRVxpWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228951; c=relaxed/simple;
	bh=XdKai4oA6itIQiHM4tG4IYI3v5k2W4VIOHp7HkOEwVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kJsC4Gyt7I09wBmj+i57XN89O9MD4NWMYn+sK938PuGtrui6a/tsxFSd4ghNomdAKrVwOHKQJ/ZVDyrp3X+2jUXWOCz0UGkCjb4dtmUOnXDZiFIgS4kMnCTM/vaU1bQxYMmuFq0NLph/T8QG5jxvqmbiJYhNj0yKv6H/yzbukmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=eq1XKzsZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f9sa3JGl; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="eq1XKzsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f9sa3JGl"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D09A91D00130;
	Thu, 11 Jun 2026 21:49:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 11 Jun 2026 21:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1781228948; x=1781315348; bh=5k
	/kANjRa3GxrgHRqRD1vcIa+1In6nv0ytDgilWnobs=; b=eq1XKzsZUgSOe35Vn0
	QxrZAWrcVTlDPeN4RAXSzw3UiTPL1rtL0Cus4bEY8t2GPJRHbTqso5fVygjioIXr
	TPsCzi/VjWT9fD6QX2Yj1E40MxZjfqYMmGWiSIc7r/YxKK06aeGWxhYfvLfSwP2q
	aJcsw8BRCopz70iFKCgxiLLkvhrqWToRyGXhLaVAhzLMPO4oLIhjK2IQZz/0T6YI
	IDt/gh4xnidYW4Cq5pFGM0CZf/xbR2t+JIoQ7Tckb6CShBrxGzTW0aqWw8gdAXPz
	1NyAec7fpjXvJBp8CgTec/hYoItYWPG4meJqyHBb5/0cDfvDrmlI6hOzCQUl6i6E
	37Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781228948; x=1781315348; bh=5k/kANjRa3GxrgHRqRD1vcIa+1In
	6nv0ytDgilWnobs=; b=f9sa3JGlmOvyPP2UG5vgHtMXfLUZowZ1Oe/+nZBPs4e7
	4uBrC3XBOXFKWCoV5qa/NMhfGRtvktqUIZxoSxvaR+jls1AL/QK9laJ2IEHZV1gh
	JhBURqg/giD9iypA9mv7xFpWpnoq833+uG61xMqR+7lqAXQ0FFUYb2BkNHn8RVid
	NP4S/aHeN6RBGBeZTyb1bCXS2zYGyVmMl8yhLT0IL1SxHXNimDfye+1Veh1p0hpK
	7Mi/CjXBIkStinoET20OiAGNgYkvQGzyfIgILfW9KoVUkQCLV57RM0MJLIjEZ+9a
	Q7gToNQxSTFpn/U4/ED4/yxOI7oEwOgz7Ufz1l/3vQ==
X-ME-Sender: <xms:lGUras_BNQy0A_MCKkIyF_mf9hj_xpYd02_YLzynZMZpKvW0kNe4Qg>
    <xme:lGUram-DpaqrvAFAvSHHTtNqufzWVcC8Fdp6UIAdjjLXxO6SBAR2yY0x58Rd6F8ih
    LVT61TCkxMWquvObNguGn-oYFOsXw5i1JbLKMg89R_2qqN04-MRPBU>
X-ME-Received: <xmr:lGUrakSMJrTusB-xLa9NOcTpD1A3g9DLiEz5f19dhRcKdCaNpcFc6i6PcxYmij_V187pX7fbQjrGBrZ4SfmIe7_vV3Iv_ywb4LUkbb35VGr0ns19ZhCFL-8mLWc>
X-ME-Proxy-Cause: dmFkZTEayIIZQ72KHME27i2yGW2eIwiOF3QiyclsNlnkq2T9WAXj3WaF711bQz+B8VH1Hj
    NB1T70yMi5k/wBibttieCJIcC+toFJ2baxF9KOUPBD91zdawLR7NUAWP4ENFQgzfH1tKhD
    1afit35V9DYEGqz7CAAVYGGPs2OIQF2pE9AppRIm3ynN5B70W547Gcbd2LEA27CD7RqQ4n
    1qxa3z6bfAYr5mQ0ikDWkzSWWLKCybkSk82nNqICno4y6gWXGOjVcIWyH3h6I/cxp5RGeY
    xhXnOQ3LZ4f6IgJRxmke2GMZEv8kv4pGQFuJkAmHnyCMbJ0gNE0dj8TTXOfZGzzjdV1ypu
    uklwSDk8B6Vw+cuEhQLb42QMNhJhym9PrTOE25oQ3yTOpx7Lk1MU5xRx37GpqATDuMyuEU
    oS5/MUDsibUEG2JyvDWEe/33zOiayS6gCQoOZFaFqDfv780Jh8luzwj8a/rCTvID8t+SGu
    a538kNnVY+sf7oJGpZeyG1vkDaxry4+ry6VbaW/BnQwmuNdXd5igsTS0REOFWwN9zMpjoQ
    YAY0uTJ0+swZ8dcVuR4UaaVWmR5lidgWWOYS6q4VoXhxjIe9YpqDAPBYRz1v4fARPC/XcV
    52o3D2xecqCcmQpFr8J8gFy0p9ogMVw6WWhm8TiIndbgmKdcalJSN2q661+A
X-ME-Proxy: <xmx:lGUraic_zitJv1d3GztytV86TO71v9rYDTOprpzXzslq2B67HNdRbg>
    <xmx:lGUragDCNkXHuWh-h1WIcRVA3oqZsWNMX2qmO7o1EqZ-d86x-UqZBw>
    <xmx:lGUrasn56dThNec2GBSAC2TOTrTtFJQl1vHnSWhkyXQ77PcEOwfQaA>
    <xmx:lGUrajdMMOWj6divSe207gSkqHljMhUley3V4kcEU9la4S37hsvTsQ>
    <xmx:lGUraiLwrmtvucs5CLn44E6WUwAlnKHCqPc4_XV3W9YDydivC-Ip_tki>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 21:49:07 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v11 0/9] Implement LANDLOCK_ADD_RULE_QUIET
Date: Fri, 12 Jun 2026 02:48:46 +0100
Message-ID: <cover.1781228815.git.m@maowtm.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is the v11 of the "quiet flag" series, implementing the feature as
proposed in [1].

v10: https://lore.kernel.org/all/cover.1780272022.git.m@maowtm.org/
v9: https://lore.kernel.org/all/cover.1779843375.git.m@maowtm.org/
v8: https://lore.kernel.org/all/cover.1775490344.git.m@maowtm.org/
v7: https://lore.kernel.org/all/cover.1766330134.git.m@maowtm.org/
v6: https://lore.kernel.org/all/cover.1765040503.git.m@maowtm.org/
v5: https://lore.kernel.org/all/cover.1763931318.git.m@maowtm.org/
v4: https://lore.kernel.org/all/cover.1763330228.git.m@maowtm.org/
v3: https://lore.kernel.org/all/cover.1761511023.git.m@maowtm.org/
v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

v10..v11:
- doc and style fixes
- s/audit log/log/
- u32 flags arguments
- stop using bitfields for quiet_optional_accesses and fown_layer
- fixed bitfield using different types
- use u8 instead of bool in struct landlock_layer
- sandboxer: merge LL_{FS,NET,SCOPED}_QUIET_ACCESS into a single
  LL_QUIET_ACCESS with more descriptive values.
- selftests: also test the quiet_access_net and quiet_scoped fields.

(Kept ABI version at 10)

All text following this line is unchanged except for the demo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

v9..v10:
- clang-format on .h files
- doc changes
- remove stray __attribute__((fallthrough));

v8..v9:
- Refactor to store the collected rule flags in layer_masks instead
  (renamed from layer_access_masks).  Got rid of layer_mask_t again.
- Rebase sandboxer and net_tests on top of UDP support, resolving
  conflicts
- Additional small changes, noted in each patch

v7..v8:

- Rebase to mic/next
- Re-introduced layer_mask_t due to need in first patch
- Plumb through rule flags in hook_unix_find()
- Some selftests patches were not properly clang-format'd, fixed now.
- Minor env var handling change in sandboxer
- Fix selftests use of audit_count_records() without EXPECT_EQ

v6..v7:

- Remove "landlock: Fix wrong type usage" (merged)
- Revert back to taking rule_flags separately from landlock_request until
  we call landlock_log_denial (https://lore.kernel.org/all/20251219.ahn3aiJuKahb@digikod.net/)
- Rebase to mic/next

v5..v6 rebases on top of the new simpler disconnected directory handling,
change some bools into u32, and fix some typo and style.

v4..v5 addresses review feedbacks, most significantly:
  - reduces code changes by pushing rule_flags into landlock_request.
  - adding test cases for two layers handling different access bits.

v3..v4 is a one-character formatting change, plus more tests.

We now have 5 patches for the selftest - I'm happy to squash it into one
depending on preference (and happy for Mickaël to do the squash if no
other feedback):
- selftests/landlock: Replace hard-coded 16 with a constant
- selftests/landlock: add tests for quiet flag with fs rules
- selftests/landlock: add tests for quiet flag with net rules
- selftests/landlock: Add tests for quiet flag with scope
- selftests/landlock: Add tests for invalid use of quiet flag

v2..v3:
Not much has changed in the actual functionality except various comment,
typing, asserts and general style fixes based on feedback.  The major new
thing here is tests (a bit of KUnit squashed into the optional access
commit, a lot of selftests especially in fs_tests.c).

The added fs_tests should exercise code path for optional and non-optional
access, renames, and mountpoint and disconnected directory handling.  I
will add the above missing bits to v4.

Removed:
- "Implement quiet for optional accesses"
    (squashed into "landlock: Suppress logging when quiet flag is present")


Old feature summary below:

The quiet flag allows a sandboxer to suppress audit logs for uninteresting
denials.  The flag can be set on objects and inherits downward in the
filesystem hierarchy.  On a denial, the youngest denying layer's quiet
flag setting decides whether to audit.  The motivation for this feature is
to reduce audit noise, and also prepare for a future supervisor feature
which will use this bit to suppress supervisor notifications.

This patch introduces a new quiet access mask in the ruleset_attr, which
gets eventually stored in the hierarchy. This allows the user to specify
which access should be affected by quiet bits.  One can then, for example,
make it such that read accesses to certain files are not audited (but
still denied), but all writes are still audited, regardless of location.

The sandboxer is extended to show example usage of this feature,
supporting quieting filesystem, network and scope accesses.

Demo:

    /# LL_FS_RO=/usr LL_FS_RW= LL_FORCE_LOG=1 LL_FS_QUIET=/dev:/tmp:/etc LL_QUIET_ACCESS=read ./sandboxer bash
    ...
    audit: type=1423 audit(1759680175.562:195): domain=15bb25f6b blockers=fs.write_file,fs.read_file path="/dev/tty" dev="devtmpfs" ino=11
    ^^^^^^^^
    # note: because write is not quieted, we see the above line. blockers
    # contains read as well since that's the originally requested access.
    audit: type=1424 audit(1759680175.562:195): domain=15bb25f6b status=allocated mode=enforcing pid=616 uid=0 exe="/sandboxer" comm="sandboxer"
    audit: type=1300 audit(1759680175.562:195): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c86113d1 a2=802 a3=0 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
    audit: type=1327 audit(1759680175.562:195): proctitle="bash"
    bash: cannot set terminal process group (605): Inappropriate ioctl for device
    bash: no job control in this shell
    bash: /etc/bash.bashrc: Permission denied
    audit: type=1423 audit(1759680175.570:196): domain=15bb25f6b blockers=fs.read_file path="/.bash_history" dev="virtiofs" ino=36963
    ^^^^^^^^
    # read outside /dev:/tmp:/etc - not quieted
    audit: type=1300 audit(1759680175.570:196): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c868e400 a2=0 a3=0 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
    audit: type=1327 audit(1759680175.570:196): proctitle="bash"
    audit: type=1423 audit(1759680175.570:197): domain=15bb25f6b blockers=fs.read_file path="/.bash_history" dev="virtiofs" ino=36963
    audit: type=1300 audit(1759680175.570:197): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c868e400 a2=0 a3=0 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
    audit: type=1327 audit(1759680175.570:197): proctitle="bash"

    bash-5.2# head /etc/passwd
    head: cannot open '/etc/passwd' for reading: Permission denied
    ^^^^^^^^
    # reads to /etc are quieted

    bash-5.2# echo evil >> /etc/passwd
    bash: /etc/passwd: Permission denied
    audit: type=1423 audit(1759680227.030:198): domain=15bb25f6b blockers=fs.write_file path="/etc/passwd" dev="virtiofs" ino=790
    ^^^^^^^^
    # writes are not quieted
    audit: type=1300 audit(1759680227.030:198): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5565c86ab030 a2=441 a3=1b6 items=0 ppid=605 pid=616 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
    audit: type=1327 audit(1759680227.030:198): proctitle="bash"

Design:

- The user can set the quiet flag for a layer on any part of the fs
  hierarchy (whether it allows any access on it or not), and the flag
  inherits down (no support for "cancelling" the inheritance of the flag
  in specific subdirectories).

- The youngest layer that denies a request gets to decide whether the
  denial is audited or not.  This means that a compromised binary, for
  example, cannot "turn off" Landlock auditing when it tries to access
  files, unless it denies access to the files itself.  There is some
  debate to be had on whether, if a parent layer sets the quiet flag, but
  the request is denied by a deeper layer, whether Landlock should still
  audit anyway (since the rule author of the child layer likely did not
  expect the denial, so it would be good diagnostic).  The current
  approach is to ignore the quiet on the parent layer and audit anyway.

[1]: https://github.com/landlock-lsm/linux/issues/44#issuecomment-2876500918

Kind regards,
Tingmao

Tingmao Wang (9):
  landlock: Add a place for flags to layer rules
  landlock: Add API support and docs for the quiet flags
  landlock: Suppress logging when quiet flag is present
  samples/landlock: Add quiet flag support to sandboxer
  selftests/landlock: Replace hard-coded 16 with a constant
  selftests/landlock: add tests for quiet flag with fs rules
  selftests/landlock: add tests for quiet flag with net rules
  selftests/landlock: Add tests for quiet flag with scope
  selftests/landlock: Add tests for invalid use of quiet flag

 Documentation/admin-guide/LSM/landlock.rst    |    9 +-
 Documentation/userspace-api/landlock.rst      |   14 +
 include/uapi/linux/landlock.h                 |   61 +
 samples/landlock/sandboxer.c                  |  138 +-
 security/landlock/access.h                    |   44 +-
 security/landlock/audit.c                     |  288 +-
 security/landlock/audit.h                     |    3 +-
 security/landlock/domain.c                    |   57 +-
 security/landlock/domain.h                    |   11 +-
 security/landlock/fs.c                        |  157 +-
 security/landlock/fs.h                        |   21 +-
 security/landlock/limits.h                    |    3 +
 security/landlock/net.c                       |   22 +-
 security/landlock/net.h                       |    5 +-
 security/landlock/ruleset.c                   |   45 +-
 security/landlock/ruleset.h                   |   29 +-
 security/landlock/syscalls.c                  |   71 +-
 tools/testing/selftests/landlock/audit_test.c |   27 +-
 tools/testing/selftests/landlock/base_test.c  |  118 +-
 tools/testing/selftests/landlock/common.h     |    2 +
 tools/testing/selftests/landlock/fs_test.c    | 2450 ++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c   |  138 +-
 .../landlock/scoped_abstract_unix_test.c      |   77 +-
 23 files changed, 3576 insertions(+), 214 deletions(-)


base-commit: a6f0a6f5377fae42a8028f63c89d544c68f24b60
-- 
2.54.0

