Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354E46BF
	for <linux-security-module@vger.kernel.org>; Sun, 23 Nov 2025 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763931740; cv=none; b=Z2L4LDpi5oFsOH4GkoempnI1h0SJNgYarwrto0dVsJp+nkqyL63jTE1dujkYydm2srOFag7LjuViPte/K5QdmmuZW5cLAYRynjbi3SsrzrMwz99wz0opatwsplE3GQ9XUuMAdSx0vITCjhjhXJjao9D4YKdkZSRe12tT0aEgJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763931740; c=relaxed/simple;
	bh=Xy67yy9l6tggBPqL5ihPQjQmdwarG+GvbshWr/K0isc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BzHFLiVe0DtRe0cyKIkhG7ysif3ACOK4Qrr4NPV4jkY8FCyVPiOzgTst3sTT5+6VoCnaW05pdhRz68wt14XuxBY5svdYX7Am91YWSUc2Po3MljebNHhr5q5snJmJg92j40WGpFEwjJyGlWc9JNcbRPSaBN3ZsvlCK4iKNV3mWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=MywgvAQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yQPPmCGk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="MywgvAQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yQPPmCGk"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 01DABEC01D7;
	Sun, 23 Nov 2025 16:02:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 23 Nov 2025 16:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1763931736; x=1764018136; bh=l7
	96J+yPn3ZjaAL6t3UY9kqLuhj6mBi+zqjdFHBbou8=; b=MywgvAQM2EIpcAwsru
	Za8Jg+hTQwb+IYPBgkfmmxOOB1Ak8/C55NVmeaot18YNM6RM0d8mDkVJfWSiRznI
	mYQ5bqGFCF5GZPu2jiGXhvFV/ftgeXuSiyAHY8UU58cj4okL4eyghzbIua/dswqS
	0q/EE73Dc6O7njpBB6Mqz4UcDJgT0RQJa7mlEemXlXFUOmsAT2pNWMED2rLBIOvn
	6LqGOIIT8N/OCxx77v41j336HsIn2YfOaurcG+CiYvw3z5JWRQZ6niH/gFwuZaNp
	v4G/rTXZvRqMulMuIBsH5OSB3yNZPRbA9XooUr3vGp+xwecIzfHG5iLiWJMxvkWV
	43cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1763931736; x=1764018136; bh=l796J+yPn3ZjaAL6t3UY9kqLuhj6
	mBi+zqjdFHBbou8=; b=yQPPmCGk9FwDNaOrV4cjHHWRH0axQ3KOdEFUzVINs/zX
	mSZqI8nSo7qRiaqonMO8mea6JN1xOLAv8q9aybcKpQqfo4SZHtwrGamaIpzGO9JU
	Gz/VBcfEVUmknuwmbTaszaQr3qRTuxhTqDvNc/OLJpoIZa3gUutqOFbJ6ZpFDhXp
	pBZf60AX51W3VFhaTdE/+q/LAWzTW9Hd6cgFrHr6HGx/EQQl4v3vNleSorKdGwBX
	6HLgbBsrl+XTHduv99sWCpwT1TebS52w1Gz83n+9ssBREkMlcuJRkIJOztDgQ0Hp
	2lrHUK4Gqa8nUxKutQSz1XSy5I7l7NUDTB+4fb0GjA==
X-ME-Sender: <xms:WHYjads59ZxHsBJsN62nkDZbQBUjW9xu2m8yZPildol0P80VPIZuwQ>
    <xme:WHYjaYtoFmUCO-LOXA383F8Mr7CYsAgt837um12jHjQ4KTQaNmXwGnICi2egHxTxt
    4QMbQwHNDRQe-2rIg-iU-fdBbqG5yiLk_8nyDMfYn9XGm_hhBSstYs>
X-ME-Received: <xmr:WHYjaTBB3wGs5Y5KNLLfq1iXRnjGTo9hHQ1k7WoGDCdFK9q_ceSAsZI8dQEQQ7MDRhSd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeijeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepudeuge
    etteefuedttdelffefueduveehheejieduieevveejiedtheekkeefjedunecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtse
    guihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghp
    thhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehuthhilhhith
    ihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhsvgdr
    tgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:WHYjaaNPj6dFI3eC26IZe_VmUSPJSgbfLnuSSJS2zRYOeKoP3tp_5A>
    <xmx:WHYjacwuiiVZRzcDktnnmbM5QkY9O2KEf4BW9pILNmt3k_npN6Hj8Q>
    <xmx:WHYjaaWUPoB7sSmx6n0XiKiwcTEyMep1w4GihDC0S3_W4lKXZVJKKw>
    <xmx:WHYjaePjJ2ZzBgBrYsdEnbQughUdccdgWw0Fzi4ChcMTRNgdoLU52w>
    <xmx:WHYjaV8a3x9f1eOMMGjaJ2fN4zYnwbcOsYzsSxi5ONdI8CfTPbkPRrod>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 16:02:15 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 00/10] Implement LANDLOCK_ADD_RULE_QUIET
Date: Sun, 23 Nov 2025 20:57:36 +0000
Message-ID: <cover.1763931318.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is the v5 of the "quiet flag" series, implementing the feature as
proposed in [1].

v4: https://lore.kernel.org/all/cover.1763330228.git.m@maowtm.org/
v3: https://lore.kernel.org/all/cover.1761511023.git.m@maowtm.org/
v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

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

Tingmao Wang (10):
  landlock: Add a place for flags to layer rules
  landlock: Add API support and docs for the quiet flags
  landlock: Suppress logging when quiet flag is present
  landlock: Fix wrong type usage
  samples/landlock: Add quiet flag support to sandboxer
  selftests/landlock: Replace hard-coded 16 with a constant
  selftests/landlock: add tests for quiet flag with fs rules
  selftests/landlock: add tests for quiet flag with net rules
  selftests/landlock: Add tests for quiet flag with scope
  selftests/landlock: Add tests for invalid use of quiet flag

 include/uapi/linux/landlock.h                 |   64 +
 samples/landlock/sandboxer.c                  |  133 +-
 security/landlock/access.h                    |    5 +
 security/landlock/audit.c                     |  259 +-
 security/landlock/audit.h                     |    3 +
 security/landlock/domain.c                    |   33 +
 security/landlock/domain.h                    |   10 +
 security/landlock/fs.c                        |  104 +-
 security/landlock/fs.h                        |   19 +-
 security/landlock/net.c                       |   10 +-
 security/landlock/net.h                       |    5 +-
 security/landlock/ruleset.c                   |   19 +-
 security/landlock/ruleset.h                   |   38 +-
 security/landlock/syscalls.c                  |   72 +-
 tools/testing/selftests/landlock/audit_test.c |   27 +-
 tools/testing/selftests/landlock/base_test.c  |   61 +-
 tools/testing/selftests/landlock/common.h     |    2 +
 tools/testing/selftests/landlock/fs_test.c    | 2464 ++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c   |  121 +-
 .../landlock/scoped_abstract_unix_test.c      |   77 +-
 20 files changed, 3403 insertions(+), 123 deletions(-)


base-commit: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5
-- 
2.52.0

