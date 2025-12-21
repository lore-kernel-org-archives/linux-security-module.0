Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60872FF651
	for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766330475; cv=none; b=IIBmsa/zrKJZz5r26fqsSetwVpFNgo6Ml9NgAtsKjYskwB3IVqnjaFjYR6i6u0cxe7LF1ZrEQfsiFOjDbn2jl9nNL/usbpGkUWEZvQ8WfXUxC9c8jy46fy+6uFEFAK4NVRInvY8hSEPkiANNbYBJ5NoE9HjAx2V8cEMVoLnuNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766330475; c=relaxed/simple;
	bh=sNqStbwnfFP3tKO9vh0DlT5x2d+0/cYmlb9xICSpefk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bgptetlJZ4uvoZBNV0Q0Y/KNgjpmex+BayYk02vq1vZbZZZvy6Tq/WsmRxNz3U4cO/uh+c/nLH1c5CcTREKOYUIuIYCYl93mzv0s+2z7BzduyFeZjmc+NUClFFBDBZYtvTNQooE5rYdtYjxIcT7Kn+CJks4VHtx+PscAbqY6bIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=PBcxdQcH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yuY6Y3WV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="PBcxdQcH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yuY6Y3WV"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0062D1400022;
	Sun, 21 Dec 2025 10:21:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 21 Dec 2025 10:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1766330471; x=1766416871; bh=8t
	0TXRV81mCCLEPi/CPEn4F+Fm2U924qtQ7+jEQq/i8=; b=PBcxdQcH8C15tML1zk
	W3Q/0A1MK6O4kwcKoRjNZ9mum48cDyryCCc5LE1tRCdVvwhhxWU21MMlIvkEg6Ny
	C6L5WANYllpzl5l6LZKzhdVbBblWHRn9izAPyfFxnkml40Sswdc951Omyh+99dAm
	XLz2zFyZ6eM8dUsU8/DAP1oqQ68NmE86gP7XckffpKobUeeZgUaaoV9m+8vejyNc
	4dH6eQQeBCZfw75ONRVhPW9M5riM83HEgX2Q0tyxyuyG3IYD+uxdUTeE9SZh7KNV
	bhzY8CJ8nR6mS/hUxjF8mIzGlZeWmfdSveirfPF+cumzENw5HU2Bo+8DB8v2kWmr
	F2RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1766330471; x=1766416871; bh=8t0TXRV81mCCLEPi/CPEn4F+Fm2U
	924qtQ7+jEQq/i8=; b=yuY6Y3WV06RXArb00zwalN8em34gfE98eEpzZzuPa3CS
	AJkUDoN4p9ksT8A/udDYqsxauy14Rz1OAfzjpQ0qcAjf+0HPVJ2XMhdANOqgIw32
	EUkSqHh4aMQtUcl3lJti/hmRgfClbuInmzK5qCal4HNco1NPXUyh8gFjzNymOMZY
	KdvhMB/vuDVJ9qHzNHwaavKjLUL0mhFP0lswwwvzLQsEaQQ3v30/qi3g8ztyJamw
	cN8tDu2UQkOBm0Lyo35dHFb8BM5aWx1bWO6ZAJcf8So9p2AHv6usncsDSMddC+6i
	qjqj/nGovrjic1dfmvjmjPi1/Hs2IR0VPof63f7DcQ==
X-ME-Sender: <xms:ZxBIaaAqQx-nG1Ok39DmUda67FLxrHTgQQcq7q3p5CkrheLd-xDGkg>
    <xme:ZxBIaWzqMrLAK8dy1W7J5BJ1zdI_BG0MiCjibV5DLFBC3eA2PWDMhvhcHRF56HYL_
    6KyJCf0xYg_-25sKgg4LsFyw_h885ogAR7ZT9pw4Z6vzGHCRptD-jI1>
X-ME-Received: <xmr:ZxBIaf2zHk3w_Y0rYXbpR4kw1jPG_RGk7Gy5gzkytpQa_Gi8gIMzHSgfXlKp0UEzNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeegudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ZxBIaexes02KzMBvAuzEU93onBhsBW4Gvj5Zr3KIgC4AXp5iZCuH9w>
    <xmx:ZxBIaeFG7K3RGr8d_LChwiO1rpMQTVcsk1xahkMdsQsbkoSiz6Usiw>
    <xmx:ZxBIaZazAR0wXIaCHIR2D7mX2MnBygcfZJUTPDXFSmvLPeFRP6j0cw>
    <xmx:ZxBIaYCWNPcb6wrerq0W9YJjGaesXYJCh1lFVQ45GukOYsfiAaJ-Og>
    <xmx:ZxBIafCb-ISyTAQfluBGeX4CMtW6LB3NeV5sZJYaO-vEGWcsZAJr9lIB>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 10:21:10 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 0/9] Implement LANDLOCK_ADD_RULE_QUIET
Date: Sun, 21 Dec 2025 15:20:32 +0000
Message-ID: <cover.1766330134.git.m@maowtm.org>
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

This is the v7 of the "quiet flag" series, implementing the feature as
proposed in [1].

v6: https://lore.kernel.org/all/cover.1765040503.git.m@maowtm.org/
v5: https://lore.kernel.org/all/cover.1763931318.git.m@maowtm.org/
v4: https://lore.kernel.org/all/cover.1763330228.git.m@maowtm.org/
v3: https://lore.kernel.org/all/cover.1761511023.git.m@maowtm.org/
v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

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

 include/uapi/linux/landlock.h                 |   64 +
 samples/landlock/sandboxer.c                  |  129 +-
 security/landlock/access.h                    |    5 +
 security/landlock/audit.c                     |  255 +-
 security/landlock/audit.h                     |    3 +
 security/landlock/domain.c                    |   33 +
 security/landlock/domain.h                    |   10 +
 security/landlock/fs.c                        |  120 +-
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
 20 files changed, 3394 insertions(+), 132 deletions(-)


base-commit: 161db1810f3625e97ab414908dbcf4b2ab73c309
-- 
2.52.0

