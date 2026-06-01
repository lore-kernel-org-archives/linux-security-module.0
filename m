Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BBA3FCC
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272058; cv=none; b=ZKUWLNzjoQ3ac+OE23sJZLhLqSfagJovOgbegm9WxrkPt4KJ/3Iwi11g0E5Fi/0Swy1q7phS7DTbM6fD1auNQWzIHXo5emBbGZ4dy2m5DntpyPrXVK5Cw83X71k7SZeEJIHZlDwz8vVNYLtuh6ki6ckFbbhgo0Tz+KU04zQV01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272058; c=relaxed/simple;
	bh=zKr10Cdp/+n7erM+wjlHQe7N/GZAumvBSSt6mWGu3kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H4uoNMQdb/bySVxNNU/5uLG54tcptByKQEiMgtDI/Su5aw95ttl0FdPPoahDrb/2fEHVpT8nowORc4xUgeWowvekDMPvSvWGCyCjQOxgvxaVMfwTY303TBRNOpY6OZ4UXEiXU4BNWXHOSOFT0MuXsAZ6M6dM0CfrEBXxOloiRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=pMFCkUAx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVFIgJzo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="pMFCkUAx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVFIgJzo"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 19B931D000B4;
	Sun, 31 May 2026 20:00:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 31 May 2026 20:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1780272054; x=1780358454; bh=dt
	pdk5kEyV71ZqdpZbdfG5AGGgBgDiUhNyEqxNTDEy0=; b=pMFCkUAxj3WAdYAdXC
	FUUn43fDL49NUzejiUiQag7nY/lJFDHjO6NLJpYLpzGAkiV2QeWAx6e9AfNKp2gB
	9VdboXDW0OxAPcBvlUOGl2Bz1q48+6lJtfyenmPg+flpRQloIaihLXlB8i024Qvf
	jzJyUdSbSAV/avgWoGrP8WNcnaBjwMSJvqLEl1K1I/9xM+b0a4bKI3ahb8n6DQkg
	T6a0ekkkoqZ46mFH8iBbhpTyKETlFNt6ATd7c3+t5MjzGLa5sHd7O7k/Azg6Y5Gh
	RnXK+QGygvBc9/DZ6CWglt6+8ctXqkuPJwgFAp0ysFLmn7BNrIJS9uOofTHR2L3L
	K/Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1780272054; x=1780358454; bh=dtpdk5kEyV71ZqdpZbdfG5AGGgBg
	DiUhNyEqxNTDEy0=; b=GVFIgJzoYXgYrtl4OAVa8zLjnjpMnrHqhx5vtIG//sQ2
	u1zBtCZq2J5fhR4vcu0OOu/Av5w/ayVP+yd9kBARzycwcykTjfvf5T3QYMxuulaL
	gYF9UzVE6tj/EZHhr3/g8/TAQEApcelO44sloJqXx9mCAKHQVibgAFpxMdgHNYWq
	I6vAkFwY1oFbeGRNyEVlEoEcKchS61W06VacyBDrOm0lOBDiX7fvpe29AB0Tb++a
	PcAaA5HaMVZpxSEP4b/58Hf/lTKcWyuZxXLaBf+QKCv2XmgB3fPu6xmfsmKiOBkl
	eLflyuOU5W3bHeVMwetamI8ZRUrdjs9x7OrisU1j7w==
X-ME-Sender: <xms:tsscata7_rzOqJbuWsP3ARp_qgQ86U8tzVDjUzanARSqCy42-u42fA>
    <xme:tsscampCThG0yfFsNe1MDQbFTLxIDm5k_gkwPIiObO2DyDmHGYg0s_QcbwWpzN6LO
    UKVQkzDHDHJWB-06E80FNOOVLTbtx8rsTDNnUotJDbMFVNfl84TKhRs>
X-ME-Received: <xmr:tsscaiNf-b6LAUXzpKt4C7vw83U9a1SRqTrvdXpQNf2it6L4uNUrHCWwTfqhEtxLXr4>
X-ME-Proxy-Cause: dmFkZTEjxaIEVRkJYV03KEf1qZGGdKSCbRWtieehNXjqMQQx993dVYCSZdG2DJpAOTxxfn
    020l2qqrynvOqmazMAQt/+kisE40c27c0Z58kG59CLHn8MwImrWXFcZr4j8JQ0eTiEZxCc
    v5KxVy+ZvgqQvsbtfYtUJDVdmPknABvAxLspJrsOZd26jyBoK+1PMoGMtoz9DN5bIXZ2Au
    0tyB4E3zaKa4zWIQ/AAIEMfKBm2NJFycd1GPLGNIudFyMpJdReS4GaLXAhQGWEO5G6Uooi
    ri/80ighIO5zGpzc0ieCDzqQIdx7K40IrZnsKTnxca05GkVtephCn1lzZWEkXhAkE3Y2NJ
    oBrYETi43UVYQS0LpQ3oDqgJMedkWp86FhGn2tLlavsmswt0BVC2N+kz3tfsiR0NAhlSyZ
    a840ep28ifR3Fbx3BRzb3OlmAredpfVPKGjZqt4BE33XBMZ8baqQCX1np9+js85iJ0co7L
    z+c9qLMGdPwttOWGbxGq2FJmwO77UwoNZ5QfC4kCBaPfMV6ZHJyKAacE2dslpx0zBhYUYY
    Kyc6Av8mYymOhAVC6sP/YkQFFK2Qz1x0mBCnCAySuY/RtIoImtNIqvVACZAY1KrwtxSeMU
    BYMDz7AWBO72G+6ZMIKxl63IECFSL7IAOt6kB6ich0AQr+n+jKOoIisDdixw
X-ME-Proxy: <xmx:tsscahpimvgzUqXuXa-aXvkYA04XYOWvgu5jsysnfna1cVYiM6d7Jw>
    <xmx:tsscanf1i9HrhH2vjzPOXR8BVghHjWoH7nO2VWbZJUEmw8BZpHV31A>
    <xmx:tsscanTNIcUd43X29LHoXiyNw_n8V80ogz1CgUM9L3DbC5n5oAHdQA>
    <xmx:tsscagYOxcAjLnPl4ydOokvi9SR2SzoqcvCDgfmtdVqY4dY07aBOGw>
    <xmx:tsscasWXtyw60iWgeoTK3l5YrDwf5KcYgGwUnsZfYR-nEyPO9hgP2II1>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 20:00:53 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v10 0/9] Implement LANDLOCK_ADD_RULE_QUIET
Date: Mon,  1 Jun 2026 01:00:34 +0100
Message-ID: <cover.1780272022.git.m@maowtm.org>
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

This is the v10 of the "quiet flag" series, implementing the feature as
proposed in [1].

v9: https://lore.kernel.org/all/cover.1779843375.git.m@maowtm.org/
v8: https://lore.kernel.org/all/cover.1775490344.git.m@maowtm.org/
v7: https://lore.kernel.org/all/cover.1766330134.git.m@maowtm.org/
v6: https://lore.kernel.org/all/cover.1765040503.git.m@maowtm.org/
v5: https://lore.kernel.org/all/cover.1763931318.git.m@maowtm.org/
v4: https://lore.kernel.org/all/cover.1763330228.git.m@maowtm.org/
v3: https://lore.kernel.org/all/cover.1761511023.git.m@maowtm.org/
v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

v9..v10:
- clang-format on .h files
- doc changes
- fix grammar in various comments
- remove stray __attribute__((fallthrough));

(Kept ABI version at 10)

All text following this line is unchanged
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

    /# LL_FS_RO=/usr LL_FS_RW= LL_FORCE_LOG=1 LL_FS_QUIET=/dev:/tmp:/etc LL_FS_QUIET_ACCESS=r ./sandboxer bash
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
 Documentation/userspace-api/landlock.rst      |   11 +
 include/uapi/linux/landlock.h                 |   61 +
 samples/landlock/sandboxer.c                  |  133 +-
 security/landlock/access.h                    |   44 +-
 security/landlock/audit.c                     |  281 +-
 security/landlock/audit.h                     |    3 +-
 security/landlock/domain.c                    |   52 +-
 security/landlock/domain.h                    |   11 +-
 security/landlock/fs.c                        |  180 +-
 security/landlock/fs.h                        |   19 +-
 security/landlock/limits.h                    |    3 +
 security/landlock/net.c                       |   22 +-
 security/landlock/net.h                       |    5 +-
 security/landlock/ruleset.c                   |   45 +-
 security/landlock/ruleset.h                   |   29 +-
 security/landlock/syscalls.c                  |   71 +-
 tools/testing/selftests/landlock/audit_test.c |   27 +-
 tools/testing/selftests/landlock/base_test.c  |   59 +-
 tools/testing/selftests/landlock/common.h     |    2 +
 tools/testing/selftests/landlock/fs_test.c    | 2449 ++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c   |  138 +-
 .../landlock/scoped_abstract_unix_test.c      |   77 +-
 23 files changed, 3512 insertions(+), 219 deletions(-)


base-commit: b7d9ce964102b004a90568726dcdf9051602ddd9
-- 
2.54.0

