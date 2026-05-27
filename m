Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946C2236EE
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843691; cv=none; b=VDDkcnTVE9iDmV5yRs5EF8ML0LF0Hf/tRgdOYnVwO+4i5oUiZ9rdFBPOFhvOgPOI7x3ex/eZPTlTKf+zquZpbtim0F4hba6DK4mkqPsVIMqt4PUdnGLD1VZGaNN5n820fjYpkkIXTCR3uu+5U+oC1geat6lJGZSG5nuk5/WxbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843691; c=relaxed/simple;
	bh=31BRcjOY630T/ytoGKT6kcoWMlC20mzJZE7TmXYsi5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bn3FTlbnZlOqwTWVF+b2aHrmI/QmZ5/3n2BUJH34RaOqwnHirRbn82gn2FJC5Q5aR/cAMkGQ6Vv38cbWgRnkcQ5XGqG1U9KgEnJ5zg8UXUDZf5giYSSuGBfc4XfpICNwJMm+gfVfxiZHBID1hJBNVPtPWgfhkS32huR0FpGv2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=qs1kts34; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUtMSIvn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="qs1kts34";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUtMSIvn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 436B0140007E;
	Tue, 26 May 2026 21:01:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 21:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1779843688; x=1779930088; bh=B5
	fw1bf238dyavlm7h3cQONjsXMizDGvatPPIy3W/PU=; b=qs1kts34Ts7gaQ5yOa
	d3NfAXFjGy9HOKcXY3OWrJ90yHM3FrQyd5tW7hp1uEegXpp5gAEmMIlXkvtrUi5a
	S1DhOkiviQr1axNZ4qMdVewhqd/jlor6vXYeffLh7H9pqbA9Hdq/LGsxTJ8xHyDS
	0iVLmbGidnHq2lzFZJcNsKY0Q7NNYBFm3W2pJQuO+74CM2PK+Lz0XiJsBw8qI9QG
	b+1gzwjZho1dz1+mlPQ+N5ECeAuuMh0iMMnV9ANiIpo/GickbAihuHOKvJ6FGoJE
	R3E7sLj/Y/KEIEUhTQL322D2OqWgNwQD/iGS7Fex6FAULTMPDPKL91zhmWTftgr0
	BeTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779843688; x=1779930088; bh=B5fw1bf238dyavlm7h3cQONjsXMi
	zDGvatPPIy3W/PU=; b=CUtMSIvnNT4z9M/bo31a+2AVNYUrxY3bAwwcLbnx0Nm4
	bvcMqwGpc+rGKNcSM/25STObX+CwkumgD1Q14M5Ddhtfiqas1bLBDgL1g8nZwUQb
	EjbeK15a+rvnns38n5jOXMLRgKs3uxC2rKn+rIrY05gQ2CK5sllEKN/NsjvILrOA
	oHGfGtgRVFGTqEahafG4YjaWHUwFhg0DedIObyBzCaHj5o/0uPiHg+u5bxp3Ccki
	GuPXLkeP0SH+PGYWo0cNkFUDF2TXZTFqrQT+Eae/mTC5ay/77Oin14mTHzBo4G4A
	OzKNoO+TU8XU+XgXEyAEvJVSXYCjL3VH/Tjlafdnjg==
X-ME-Sender: <xms:Z0IWajvguwKW4cxQEB_bnoGPr1pp99xbai0SiknSAavG6QHxALoWGg>
    <xme:Z0IWamt_pdSt7XBmyJZjOP3mXKUj6wfs5Xksox6LOd4owyGuhFKFHwZnXJwJnjGQv
    NQrDA7fmUsqAwHDSRpgqChZP98JHgcTmo0ipP0Sg6ULrbloVTPPRoA>
X-ME-Received: <xmr:Z0IWapA-2WYSZDkhQVOeAB07nJtTvbY-8HXB_1_AZyrPhbwH2s7LEJaKadPUCZ-JGsQ>
X-ME-Proxy-Cause: dmFkZTGKH0WzdL79r6sQxAslNqKFOIlAL0wm1j1S1c72mg7029+z3IouelVTdFHME9HVmQ
    u/wzUbKFOFWTHRhUv7nLr03MlYSHSIa/mTWqg6zcPb6g7Ot970OoYnA5BlVpdxFMcf2u78
    Fa85q2iHuHKLTf/SqicaOw323d757zdniFRlPI45EI6H0aDHl49hOvNEYDNlZxmrrlPYk0
    S6/KOgNwVUROEUH1YWz6wGyLPNEIGJdruP+UDdyWMX/9vqpb7NWQcsEYcdv+jymr3mRfxy
    Fgn6lIggr7hhwmG0cAJYkIVIrhLT2z3EBTH31858iiELcwrzjkjuGqzo7EheAkl309qVn4
    ShT0yk72ABqhq7e1bulWzhep9z8YZeoWkByrDhuOh3gBL5eE1a/O+VCAsK4CgLh1MFQFBJ
    9iEX9AZdnd7BdVPNKBwWTnqPhoQdyy72vO3msitZAK7BN4nAi9KTp0cSQCIlcelUzG8IQ3
    Njll6fm/24DJVpY8X8mPgwpEbkZkuBWWAH5XK9nMZLW5YZ3/jzI6CIyY1fvAFsua1nwM35
    dNX1ZdSXsYrNQgI70WwkVpGaYnT72t6zjP5ysja0viv3nT2GQ+soN4eMnSJm5Z8sCeGecf
    MQiaYJU3KMYr0DklFScDeYohaYnSJnKqS7HWD2/CcTQGvanmtlk6Ogi6okwA
X-ME-Proxy: <xmx:Z0IWaoNxJBTrw4kVGqhA0qoagsBWHJ2n9nOw7DBM0_IHiXoWMb2mlA>
    <xmx:Z0IWaizb-NfJCLrHPQ2gDKntlLKIrpZXCV34DPJg79qp92hYRP9jLQ>
    <xmx:Z0IWaoU5vBCySF4cEUPYJdpXFKd8sb08qT10TW3c3d-IW7fqZ5JRPQ>
    <xmx:Z0IWakNXSAwcrS-HL8eqM3lORUgvbVY2z6wl2kQ6Dfqoz0E06x1Xzw>
    <xmx:aEIWaj4mYi2GhImxlCZCHgGVLtytwOMlBxfPXRHjDTYujiioxphmF4Gg>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 21:01:26 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v9 0/9] Implement LANDLOCK_ADD_RULE_QUIET
Date: Wed, 27 May 2026 02:01:10 +0100
Message-ID: <cover.1779843375.git.m@maowtm.org>
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

This is the v9 of the "quiet flag" series, implementing the feature as
proposed in [1].

v8: https://lore.kernel.org/all/cover.1775490344.git.m@maowtm.org/
v7: https://lore.kernel.org/all/cover.1766330134.git.m@maowtm.org/
v6: https://lore.kernel.org/all/cover.1765040503.git.m@maowtm.org/
v5: https://lore.kernel.org/all/cover.1763931318.git.m@maowtm.org/
v4: https://lore.kernel.org/all/cover.1763330228.git.m@maowtm.org/
v3: https://lore.kernel.org/all/cover.1761511023.git.m@maowtm.org/
v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

v8..v9:
- Refactor to store the collected rule flags in layer_masks instead
  (renamed from layer_access_masks).  Got rid of layer_mask_t again.
- Rebase sandboxer and net_tests on top of UDP support, resolving
  conflicts
- Additional small changes, noted in each patch

(Kept ABI version at 10)

All text following this line is unchanged
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
 samples/landlock/sandboxer.c                  |  134 +-
 security/landlock/access.h                    |   40 +-
 security/landlock/audit.c                     |  281 +-
 security/landlock/audit.h                     |    3 +-
 security/landlock/domain.c                    |   52 +-
 security/landlock/domain.h                    |   12 +-
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
 tools/testing/selftests/landlock/fs_test.c    | 2450 ++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c   |  138 +-
 .../landlock/scoped_abstract_unix_test.c      |   77 +-
 23 files changed, 3512 insertions(+), 218 deletions(-)


base-commit: fe7832557561ed6312563368854d5f8df1fa55e3
-- 
2.54.0
