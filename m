Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C22EBBA1
	for <linux-security-module@vger.kernel.org>; Sat,  6 Dec 2025 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765041104; cv=none; b=tbrorffgJgeGHgtFRNqXoP08eIwbgifEz7KQWd+UF89Bi/YrcyVloukjCOyc+iLo+TvapGX6DX3UQWVIryNaWqxPhiYrdKPPdWlgYupCxfbn0eQ9fBtBxdO9VDPGCbekgFTF8mDyGwdjfa3u/5+kN9Y6105fEh2Q9QH915+d/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765041104; c=relaxed/simple;
	bh=0wzWLxuUbC9q5T7oOSMG6t43xDEEyKpkkLTOr1rHsG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s9ewugRJF8mi38ZjoiyQI9eG9sKoTx7Zhslsb9vIpzDe6WpQIOoZdvEb4OIuQZlvaFSARcUaippv2jOo8Nd0BJgoR6K540r0pba5Y3+XbUPjU1qrx4ChEuUAUH1iaA8hfNby7rvBDobC2XdaNZUMZi+i6QBRTg97ko+iL/MIfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=VgHZkYA2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=no8/a65Z; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="VgHZkYA2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="no8/a65Z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BFD787A006A;
	Sat,  6 Dec 2025 12:11:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 06 Dec 2025 12:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1765041100; x=1765127500; bh=AB
	b5OmmnAr9P/y5m62+5mpd4K0XsCv9pm5EmBi8As3Q=; b=VgHZkYA2eBnivUkZaR
	PGBoxWWm2rNLmdMKP6NvXX5Qkv/JCePtTRLqviy/MG9nhYHQdnk6kvYQXgNJTYwV
	uSNj/O//zKxgvPG8jHyeA8Xy1vCmCo9Rb59xkuRsCeshRbuegDJKb55KerbWt7FY
	MQ9sAW+rIGka2LSpVPFtJuge+pKdaQDHEYcpH46PDLRg5qZv+Zs3cdVjSL5aTFCu
	UKmS/vGm4WVg8Uwq3wZPAxNEpkwjitnCY32HbkjWtO1tKNOF9PVRoRly/0pY7NfC
	aFiWTbkJwfSAlCNtz384Z0C5+KaPZDMENy8q4XWVQSfb82Ioa+hVpZv+FvoH2sgs
	N9Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1765041100; x=1765127500; bh=ABb5OmmnAr9P/y5m62+5mpd4K0Xs
	Cv9pm5EmBi8As3Q=; b=no8/a65ZRl7Bp5jaWXCm54ny8deIxfjctHdalSSHPKPl
	nQar9sHgkf3UDnzXn0HqZZ/BxT1LtpJCgpZphLaNL050aWuMgO/FFLgAcv5lSLjt
	i31W5pHXpBpKSsO1H57SS84cW/xLx0JJcU+2RiSp2v1yCH7sFnqQgHk9od4opsCB
	65DLmNU2Dg8EcPnJgruSru1WFJwSnF8GaCT/wSY0xQa3XPiaR63YPtIlOe8OnEv4
	5uO2YyP6BTNp7fgTBM8D1su09mySm4YblxM6Rvq8i7gJ6ZuJ9PCdzZvr8KZZdwpc
	CpDMJ2hC9VcJS57BCysofOvGkZeJBmP5tVWO27Zyvg==
X-ME-Sender: <xms:zGM0aXk91s8gzeClPaRAvvh2wg7ntF7L_PtUFhQquTyyghh_0kLsLQ>
    <xme:zGM0adHmzJFg6FFg0ZxOiVpLL_wuuGStg4Xy0A0I_W_EN2HVmb3fOYbuoKzw65UDy
    EvoBQEgsFjtvpEcYrFRL02lsuyQYmip5EkzMMTgKDdOStV6XpHLQuje>
X-ME-Received: <xmr:zGM0af7ojR3WdW_VfJMhhXqgkSmpLs3i4VAK4pR64hCH5Oaq2xIMZRSsbdLuRsTU5fUu0Y-wGnlI_WTblUNMRuGzX4lVPvoGOuOWCLaUf78w0QB4YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgrohcu
    hggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduueegte
    etfeeutddtlefffeeuudevheehjeeiudeiveevjeeitdehkeekfeejudenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgs
    pghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesug
    highhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphht
    thhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuhhtihhlihhthi
    gvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgt
    iidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:zGM0aVnWl7HQNmxvMkAstkh8Fpii7hH6tDsdKzbg5alFy8TY0JrUsw>
    <xmx:zGM0aUoO-xec33yz4fctFuuC3DWtIz1JgIgZAssv_6R5FB1wkRWxQQ>
    <xmx:zGM0aUvxQG_yjSGy6LcGIMBaIc6BO8ayytOZSv-ZVnDwPjm_nGPwxw>
    <xmx:zGM0aZF6bqbFaK5bUvOgRa5KD7LL86aJDGjh3--BlhkdTBNBOrwJ8A>
    <xmx:zGM0acWmkV2Ae3Z_j-j1GSi9wTe1-rj5K1XwKI7wvHwFFlK7GpddR3EK>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 12:11:38 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 00/10] Implement LANDLOCK_ADD_RULE_QUIET
Date: Sat,  6 Dec 2025 17:11:02 +0000
Message-ID: <cover.1765040503.git.m@maowtm.org>
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

This is the v6 of the "quiet flag" series, implementing the feature as
proposed in [1].

v5: https://lore.kernel.org/all/cover.1763931318.git.m@maowtm.org/
v4: https://lore.kernel.org/all/cover.1763330228.git.m@maowtm.org/
v3: https://lore.kernel.org/all/cover.1761511023.git.m@maowtm.org/
v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

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
 samples/landlock/sandboxer.c                  |  129 +-
 security/landlock/access.h                    |    5 +
 security/landlock/audit.c                     |  259 +-
 security/landlock/audit.h                     |    3 +
 security/landlock/domain.c                    |   33 +
 security/landlock/domain.h                    |   10 +
 security/landlock/fs.c                        |   86 +-
 security/landlock/fs.h                        |   19 +-
 security/landlock/net.c                       |   10 +-
 security/landlock/net.h                       |    5 +-
 security/landlock/ruleset.c                   |   19 +-
 security/landlock/ruleset.h                   |   38 +-
 security/landlock/syscalls.c                  |   72 +-
 tools/testing/selftests/landlock/audit_test.c |   27 +-
 tools/testing/selftests/landlock/base_test.c  |   61 +-
 tools/testing/selftests/landlock/common.h     |    2 +
 tools/testing/selftests/landlock/fs_test.c    | 2456 ++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c   |  121 +-
 .../landlock/scoped_abstract_unix_test.c      |   77 +-
 20 files changed, 3373 insertions(+), 123 deletions(-)


base-commit: 54f9baf537b0a091adad860ec92e3e18e0a0754c
-- 
2.52.0

