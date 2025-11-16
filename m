Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A42AE78
	for <linux-security-module@vger.kernel.org>; Sun, 16 Nov 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763330548; cv=none; b=fkNI3qtFgRzrlu5rVIUdfZ8Osxoi4/mLZQmOi81wtZh0l3eU//hntqA+BGj1Orx7IYlNiiB+pZNINtcHHbQNoM/cab+y1G5HRJzi9w7HeX9PIjjbBcJHavBaPZtXhnuyDIvMzV+K4AhAudcNXNF9qri7L3cYTgb8LmK1jCskNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763330548; c=relaxed/simple;
	bh=VYIMBiG3tsK4WAwlG+RZT1bf2E9/KJtv/psXpKoiPtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RhX3G7qs8/S+DVUSV/EtaZD22R90YwYDImw6bLbt7FFfvCaiGdllYuURxi6a5Xvny0o1fq9CIuzn8nNMD6rAnb7Hm0zwBQH2bP+5DVRq58FdlhZgt3xzMOQmyaAp9xxfoJyO00Zgmj6l8bArdxMQsm2FJN/LI4TrbJSbrwiWcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=d67NysnR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tl84+V/R; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="d67NysnR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tl84+V/R"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 977C81D000B0;
	Sun, 16 Nov 2025 17:02:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 16 Nov 2025 17:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1763330544; x=1763416944; bh=8p
	N9FXOcbnzJPP9QLUucPW1t2kgPPwddqTPsMoGGumM=; b=d67NysnR2GXtnrPnf3
	6UHM8N/oNFESR0yPBFEw8+oLFX7+kU2q/JKlaio8s6Koxl6pcUAEKIFohqLfGKrG
	/C2mQVaryxdD4XB+G3FqtApqTb2ih6g6szG75KroTAPYrmobtq3IyCA29SAFJLFl
	KkFVt+uje1KmZa/GOenhvDw2wqrAiPH7mEVOT7jeKgwBqLb7vBfy7Pr4NvuiPlW4
	f41Cg3Tl1X0Tr2OwPY/zjE4rKYkuj9ICxLl+vkBeyt+VFtGWFxYL23EXy3OEUT6s
	hG8EAw6MTWAJVbS9rWgDsyusA4Bi00v5BE6OZfRgzRApJgXgFnsCYHyt/cx4yeh/
	+5gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1763330544; x=1763416944; bh=8pN9FXOcbnzJPP9QLUucPW1t2kgP
	PwddqTPsMoGGumM=; b=Tl84+V/R2xPIrDu1OW/3cE9NPssMTOTQJsx1E7c3vjsr
	GDrgYj9WNgRkWSUUUXEW5SFDH5ovYsMJKdXTGgW8fP2a8XEw+CprSIqnBu9XlRap
	XMWzAEZnUiKHrg4Y+WduTb2bpbIdqsrRwgBRghRLYhni2SjKKKMYvh1+Oe9AluhO
	61I2yShYmhSrRL6rFVZwBEsdEP5OuK6tgsu4hQUlFYsq0JA3+rg1gBezZMh2lyd0
	uPN+Tke/SgGktaUolqigGiYH0TGWt6K6Hqj8eOe5L0tCMomvbEYRLGOZR8gp/Yq4
	mLVRcFf7b2LlUDe5MH7N1bykOOe7wxQWuOE+JUHWLg==
X-ME-Sender: <xms:70kaaQOFSt15-68zU-8XJxisOxKVpRzDb85cx8wd6klboo3M8J90Pw>
    <xme:70kaaZNYzWNVeyq2nZuJFlyOdt-L_RgWX_FIoUWYpWdo_bIf1XDpfBPDCW6WgcEuN
    MFsDi7TBZ739gZ-15QnefBKiTJ-VbvNth_CdS6Xjf5a5KGs5Zu5RWJP>
X-ME-Received: <xmr:70kaaZikyghAjO6H6COmLoHWuNj5vYE0io85O52QBM_oBSXcZTitxYUmwa2jyUHUtTkY5x9GiUTMkakUc1KD1jKmVd_eg1NBaAr_9Yiz0hHKAAsr3ZY3N44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeijeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:70kaaesS-OilU2P3w4dnGwcAJYVeiBxfaQwsO4JbNxDsAYJ5MUHENw>
    <xmx:70kaaXQE-JR-veLyAdnVZmSWihCAqJSAfLkh3d_DdTF3ioarsrskAQ>
    <xmx:70kaaS1910b6YpA60lFk6-7StAsoMLvwrY81n1pdZjBNa00MYtCSYg>
    <xmx:70kaacsVjaM7BxNfTA4HLIiW8yk9altWQjbAXhXdgs4nA4roVhBpFg>
    <xmx:8Ekaaee3LSgNJy_6TFASZ5OBdnYIr2NMxnokQ55-4k1WxlT5GlYdvbBM>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 17:02:22 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 00/10] Implement LANDLOCK_ADD_RULE_QUIET
Date: Sun, 16 Nov 2025 21:59:30 +0000
Message-ID: <cover.1763330228.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is the v4 of the "quiet flag" series, implementing the feature as
proposed in [1].

v3: https://lore.kernel.org/all/cover.1761511023.git.m@maowtm.org/
v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

v3..v4 is a one-character formatting change, plus more tests.

We now have 5 patches for the selftest - I'm happy to squash it into one
depending on preference:
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
 security/landlock/audit.c                     |  257 +-
 security/landlock/audit.h                     |    4 +-
 security/landlock/domain.c                    |   33 +
 security/landlock/domain.h                    |   10 +
 security/landlock/fs.c                        |  144 +-
 security/landlock/fs.h                        |   19 +-
 security/landlock/net.c                       |   11 +-
 security/landlock/net.h                       |    3 +-
 security/landlock/ruleset.c                   |   17 +-
 security/landlock/ruleset.h                   |   39 +-
 security/landlock/syscalls.c                  |   72 +-
 security/landlock/task.c                      |   12 +-
 tools/testing/selftests/landlock/audit_test.c |   27 +-
 tools/testing/selftests/landlock/base_test.c  |   61 +-
 tools/testing/selftests/landlock/common.h     |    2 +
 tools/testing/selftests/landlock/fs_test.c    | 2238 ++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c   |  121 +-
 .../landlock/scoped_abstract_unix_test.c      |   77 +-
 21 files changed, 3202 insertions(+), 147 deletions(-)


base-commit: 0f2995693867bfb26197b117cd55624ddc57582f
-- 
2.51.2

