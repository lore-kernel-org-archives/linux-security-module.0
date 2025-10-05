Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CB33985
	for <linux-security-module@vger.kernel.org>; Sun,  5 Oct 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686983; cv=none; b=D5P4WN3uvHoytol031zBVfQPZO4hEFQd8Np7bEVbPXQ2EocmplQGE24evY2mO3BwUiNpANEd9W1662rch9R7M0MZG1OHMuuGVzn8oEMdtqvEREvk7sLvUqRomkAGXrKPd2oX1H21+plmpMQonM8dkulwWRaG70S0YQmUs9IkBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686983; c=relaxed/simple;
	bh=mE98mqjUQ0X9S7d67+8OXO4z6Alg2suxFFJD4J5Ab+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgDoDzhiHIxgSRSu1zZYLnbDIeAD4rEmv2I8Wlig6drGTRsP/B6bZO77PTtPOz41hPKjUENO56uRCOL9gu0JWDwOvX/6I1bW9F6FzsDVaJ/hA7+LrHmlgmrFYQnZdL9VwZ/1SjKYupE6swn0FqMNWaWmbFftwHtGa267cs0XLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=DRxP//kB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j6KrpI0s; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="DRxP//kB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j6KrpI0s"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E0C441D0001B;
	Sun,  5 Oct 2025 13:56:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 05 Oct 2025 13:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1759686979; x=1759773379; bh=JbI0YOu7Czq4g82hNjcFr
	JhP4eD/bjxwSOlK3PgcGRI=; b=DRxP//kBssSod8oelYQM0k+mg+QGFGyOWPlYb
	gVyAozLgUQSpqvMvWmc6LuOP3FrryAj3ffOPqKL32l3dsAEWAJUTFoyZNM4X54mg
	Yr4EwQr0paJLNGDyEbrV21v9+9WgsZbdMF/yebiyi9lhQcMk4SbAF1g2HYEelM+b
	7KsuOhRCe7ep3pQ0rP76rc7UB2iPqH+ZgGX3c6qCDtKPj1AeRheM8H4DktTCzJcx
	YykRYcL79Lt2xy7LF2GqY8wwzpfShV3p67kF9BTUfsY2i1tKnh/Sux1YGsS+bg91
	dlOxkOibAcVjdxyXpfdGjwdmizQr4bvFb0zUgTWBA3Qa+EiPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759686979; x=1759773379; bh=JbI0YOu7Czq4g82hNjcFrJhP4eD/bjxwSOl
	K3PgcGRI=; b=j6KrpI0sVvnoRf3WGaE/n03iP1iCtxk0fGBvWzE9MApcYo2SdLw
	vXNBYzn+DAx1AKnk1NqT9jDfpLxL7xSjgkryxA9F0fT60Bje77Z8b5JuXxcefDeB
	v56v3uaYiInVVa5O1lBrWlK0p+R14WUC703o7XebQARiA+sC8b7YT4vzAiwYYan8
	Xe/govRoaaVcUN745sAOp9F8Hjg4Fzn/4dYTxAHLNjziPp0pJ9agHEsvJqdpBx/w
	DvDHULKFVc9hptB3ebpr+EUMK4CixiahN+LdbrROQ6KZK1XcoyF4PnslcDibGu38
	lynwLSYn07kS0EbzZZLz0FORX2b93ZJrjHA==
X-ME-Sender: <xms:Q7HiaB7kGZGSNdcDkBmCqqw-qw83QamkcwoalzEGCOPXkB-BOWZsxg>
    <xme:Q7HiaKans_3OwtfspF5ipUEdLA6tTT2V3J_A8DLwuoprTZJMCevk44LOOfiz9MhDY
    7MTUQ1SyJ_vD_7Qoq7ElTsvITq8I_lN91WriRPPsB55F5fDUFmTC7k>
X-ME-Received: <xmr:Q7HiaO6vxnS4a7NZU2EIc6CDa5DxX1RHRt-otL7WRI0he4LVkauG52gdkTFBkFPh64pHe4yP_rk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrghoucgh
    rghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepheffheejte
    ffhfethfegtdfhveejfeffjeeuteeiveevgfehfffhtdfhgeegkedunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguih
    hgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthht
    ohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhush
    gvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q7HiaFB5JgMjaQG_Cy_Fhu2_TPPXg8BCE5LLMyuA2YI_mZZqzvSaBw>
    <xmx:Q7HiaMfgGyIbGnBWy_ePEL9cUqYLpeeM4pUK5OY2-4W6LMypLJupSg>
    <xmx:Q7HiaMLGfrF0TQBhF48I6Kh83jFjAAL-qqRDZiAUSIgTi301lkVAUw>
    <xmx:Q7HiaP0t1uebLLre6eym5h_b2-qrIXX2iDE_fRfzZ9XFL9UJJ-xFsQ>
    <xmx:Q7HiaKGxKUC5cvi9l4nlQEbQtFnmU3Q42bFqgaqTKcnmoiPY0DA3PyvY>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 13:56:18 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/6] Implement LANDLOCK_ADD_RULE_QUIET
Date: Sun,  5 Oct 2025 18:55:23 +0100
Message-ID: <cover.1759686613.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the v2 of the "quiet flag" series, implementing the feature as
proposed in [1].

v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

The quiet flag allows a sandboxer to suppress audit logs for uninteresting
denials.  The flag can be set on objects and inherits downward in the
filesystem hierarchy.  On a denial, the youngest denying layer's quiet
flag setting decides whether to audit.  The motivation for this feature is
to reduce audit noise, and also prepare for a future supervisor feature
which will use this bit to suppress supervisor notifications.

In this version, the most significant change is that we now have a quiet
access mask in the ruleset_attr, which gets eventually stored in the
hierarchy. This allows the user to specify which access should be affected
by quiet bits.  One can then, for example, make it such that read accesses
to certain files are not audited (but still denied), but all writes are
still audited, regardless of location.

This version also implements quiet support for optional accesses (truncate
and ioctl), scope denials (signal, abstract unix socket), addresses
suggestions from v1 review, and further enhances sandboxer to allow full
customization of which access to quiet.  Network and scope access quieting
are now also supported by the sandboxer via additional environment
variables.

I still haven't added any selftests yet but did some testing with
sandboxer.  I would like this to be reviewed as it stands, before
finishing up the tests which I will hopefully add in v3.

Patches removed since v1:
- landlock/access: Improve explanation on the deny_masks_t

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

All existing kselftests pass.

[1]: https://github.com/landlock-lsm/linux/issues/44#issuecomment-2876500918

Kind regards,
Tingmao

Tingmao Wang (6):
  landlock: Add a place for flags to layer rules
  landlock: Add API support and docs for the quiet flags
  landlock/audit: Check for quiet flag in landlock_log_denial
  landlock/audit: Fix wrong type usage
  samples/landlock: Add quiet flag support to sandboxer
  Implement quiet for optional accesses

 include/uapi/linux/landlock.h                |  64 +++++++++
 samples/landlock/sandboxer.c                 | 133 +++++++++++++++++--
 security/landlock/audit.c                    | 113 +++++++++++++---
 security/landlock/audit.h                    |   4 +-
 security/landlock/domain.c                   |  23 ++++
 security/landlock/domain.h                   |  10 ++
 security/landlock/fs.c                       | 103 ++++++++------
 security/landlock/fs.h                       |  36 +++--
 security/landlock/net.c                      |  11 +-
 security/landlock/net.h                      |   3 +-
 security/landlock/ruleset.c                  |  19 ++-
 security/landlock/ruleset.h                  |  39 +++++-
 security/landlock/syscalls.c                 |  72 +++++++---
 security/landlock/task.c                     |  12 +-
 tools/testing/selftests/landlock/base_test.c |   4 +-
 15 files changed, 538 insertions(+), 108 deletions(-)


base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.51.0

