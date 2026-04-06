Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2312D47E9
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490749; cv=none; b=dEI87/+Tj1GA2w7C5F6I1MAVcn2EeO+pD9vsFBmAaUMxvrgOyLp1pWkur/LDEU6d7TsOG/PgaKe3nAf1oleDfSrOygc8p2S8GoedHouIUQlidUksDpIbvgb18Jv+sgEOfz5x6i1gSnTBan7c4cqWKmjL7McbQk+pz7AMKp9siCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490749; c=relaxed/simple;
	bh=8TN8nJn2QQ59YIS+gI7BqlaUkOMRJHg4FnwJBOAKTbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lt24Q5AwQMW5PWQQLsXjb+I743luea9MOcvt7TxKC+yCmJGAarcoYCoZbexF81XMikgPutSJI5qHZB58rZHqaFgFoSYkWlXFVTcifU651sQ82hefExzBWQG4SoOXUs0C10SQoORwwO7O2hloxf5/O5lz1dr5F94vPUcHJdPV5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=EzBsiq8n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hrwtga2H; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="EzBsiq8n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hrwtga2H"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 965BF7A0038;
	Mon,  6 Apr 2026 11:52:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Apr 2026 11:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1775490746; x=1775577146; bh=t2
	/uyc+zQ/906xJCnMM9QO2f/MbvPruLa9bDTvkfCew=; b=EzBsiq8nvLV1ugTNhl
	za70yrega7PBIqCHukb2G0ZvkoE4UPiyAoBZpXZB7aoNEEn6jed3mp7XbGJhYX4t
	AGqNlKzowMPudVZS43nYgGOdHCcGUCOfmyRMMdzLty3MRpeEts3xX0m/H14+hXMW
	j4Z9FdW7VcmifJsyU2dbOQSmP6gV2Js6fpS+v8cj8tc5hsQGA0riuIVS9S75xYrd
	IQBAE+oucADe3avjr3e5jTS+Kgwc2r3VTi073SkgGqRyI09D25xTW7qwhFcwkGrA
	+NmrVTnWnWgQugSOeLv8RF9x1eXQAcNuPh2qd+Sg29O6LceorrudtsHpyTWs5zil
	jstA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1775490746; x=1775577146; bh=t2/uyc+zQ/906xJCnMM9QO2f/Mbv
	PruLa9bDTvkfCew=; b=hrwtga2HhiWfjuXHRc3LY/tzOiUpWmi23C3xa3xOk88k
	YJPl2zCtXpEAhWrEd1vkEPr3ZX3IDV/7aFDBFdgY84bz2HlxiuISRVEdfKQJ+LXI
	yVNUv6uTV//8h/Gy/+Uso257Io8iLruikS+zvzUIK63xMSK7/8YlsMbpOEWkyUxB
	qBmjSPdv2Uc/rHfhTBpejiZw7Ew9hZ8dW7X0CLCNsfwWt4xws4nla/HPnerGcN07
	0Y0911O4LCgaUIBy7C4RAU6+Nf2C4tkGwqKUNrj0XKPFNlB3ga/CLDtZcklS9c6s
	a4deDQnkUtlVD5a+FqtEP1NQPo0mDjN0ogADo9busQ==
X-ME-Sender: <xms:udbTaT9pIVfGbe0hDmQ6clfjYDDocXaSZYf_l7LIQYt_vXZc2ro9Mw>
    <xme:udbTaR9uqsQyVp9gYijVQbEJ7jGjShw71pUxmYtvz1MfZJqGinv3jgk4mc8Vi8nqA
    AHWCvg_L7QYE7CetDoF4wlxeawrtghBmMICFD12XkMabZ6YNWW7DAE>
X-ME-Received: <xmr:udbTaTSZWC2_VP1gnlsB8Qw5PG6Q74T6p5qQ7Ri8Mn7AEl7BxBzvjFT8LNsPwO0eFUGliQNJOElISvYPgznM-Fx3AXLUahnFaUCe01ZxXeuMNY4-xjS9BVWAhJbSzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgrohcu
    hggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduueegte
    etfeeutddtlefffeeuudevheehjeeiudeiveevjeeitdehkeekfeejudenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgs
    pghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesug
    highhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtphht
    thhopehgnhhorggtkheftddttdesghhmrghilhdrtghomhdprhgtphhtthhopehuthhilh
    hithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghksehsuhhs
    vgdrtgiipdhrtghpthhtohepgigrnhgufhhurhihsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:udbTaVdh_cpwfl4MWi6E66PuKa1-GnRDDQfBnBC2-nChyAB4ufOJ8A>
    <xmx:udbTaXBwP4mkvj1MJoVQAqA2izY3iIEtuQwdrsltR0b2otfdBaIDyA>
    <xmx:udbTaXnflIi1OddFxC-T6YWpp9sGPd8j0kyzhLB207yVYdReT1brEQ>
    <xmx:udbTaSc4kE3lfDM9i8WICUaKAVuactfnwFtQ3greh7gnnHn8sHnb2A>
    <xmx:utbTaRRArB4X1P9NX2lIfqDbfF0oS2w_U2z070yLuphYVUQHHtlJtUED>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:52:24 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v8 0/9] Implement LANDLOCK_ADD_RULE_QUIET
Date: Mon,  6 Apr 2026 16:52:13 +0100
Message-ID: <cover.1775490344.git.m@maowtm.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is the v8 of the "quiet flag" series, implementing the feature as
proposed in [1].

v7: https://lore.kernel.org/all/cover.1766330134.git.m@maowtm.org/
v6: https://lore.kernel.org/all/cover.1765040503.git.m@maowtm.org/
v5: https://lore.kernel.org/all/cover.1763931318.git.m@maowtm.org/
v4: https://lore.kernel.org/all/cover.1763330228.git.m@maowtm.org/
v3: https://lore.kernel.org/all/cover.1761511023.git.m@maowtm.org/
v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

v7..v8:

- Rebase to mic/next
- Re-introduced layer_mask_t due to need in first patch
- Plumb through rule flags in hook_unix_find()
- Some selftests patches were not properly clang-format'd, fixed now.
- Minor env var handling change in sandboxer
- Fix selftests use of audit_count_records() without EXPECT_EQ


All text following this line is unchanged
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
 samples/landlock/sandboxer.c                  |  128 +-
 security/landlock/access.h                    |    5 +
 security/landlock/audit.c                     |  255 +-
 security/landlock/audit.h                     |    3 +
 security/landlock/domain.c                    |   33 +
 security/landlock/domain.h                    |   10 +
 security/landlock/fs.c                        |  142 +-
 security/landlock/fs.h                        |   19 +-
 security/landlock/net.c                       |   24 +-
 security/landlock/net.h                       |    5 +-
 security/landlock/ruleset.c                   |   20 +-
 security/landlock/ruleset.h                   |   44 +-
 security/landlock/syscalls.c                  |   72 +-
 tools/testing/selftests/landlock/audit_test.c |   27 +-
 tools/testing/selftests/landlock/base_test.c  |   63 +-
 tools/testing/selftests/landlock/common.h     |    2 +
 tools/testing/selftests/landlock/fs_test.c    | 2450 ++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c   |  121 +-
 .../landlock/scoped_abstract_unix_test.c      |   77 +-
 20 files changed, 3415 insertions(+), 149 deletions(-)


base-commit: 8c6a27e02bc55ab110d1828610048b19f903aaec
-- 
2.53.0

