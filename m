Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C02FE055
	for <linux-security-module@vger.kernel.org>; Sun, 26 Oct 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511514; cv=none; b=ULoja3G1xrHfF6cbouipHXOH5aOVa/Tbbd02pP01FAtay75pMNcAROkMayleE+NHl9/h74arHg5R5WogvyAt37HZfOjPrJnRRFMH53ovg+Dg+/V6YxlUQ9i6jeazR4v/PVVoZ+M7RuVyjg/ES3zCdXczDjjnWj24Eh8XjCS9wpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511514; c=relaxed/simple;
	bh=+YIVMfDoPOBxBzIgytPaaXoa0V1PJRm4EpjiPBCTEwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TY9YLP+MBtndFrYpTjneSRTFOYe+NAszasHIIHgrG8rh/3JwI8o9QyN9jo4c5kcQI1PfYfMo2hGATVCPLytq2jRiPpWGMYOuZ1D8wVvvjPM+kQN6iXKVWsAuP4WhzRElkcbq7TKY7oOdEXkRBeRf1JooR4v8Usqo32CSKmMBjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=ZsrAhFt5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IfaiYZBV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="ZsrAhFt5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IfaiYZBV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D5AF1400241;
	Sun, 26 Oct 2025 16:45:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 26 Oct 2025 16:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1761511510; x=1761597910; bh=RT
	QsyiUEE6akjbyIH7wztNfFRMKbXnTaYUoslgKMToQ=; b=ZsrAhFt56c7XJdeq7j
	N0LIrfeeUmBmYrXa4nR6K3NgUIsueM/te/okNhjZHpeOPV9CbUygEUhfpRSRsD/P
	vZnasvf+yvVCXdu6Z7PiAmSAfKVP2yMnO7aq4bJB7dbkIb0o3JVGxutfqGpQNUrm
	OLEsY2aTIy/Bk/IrerQ3gYz8ZxaINELrVYzISbkvER8eXD52E1L/kAP1ECe2dv8F
	8pD40sChE59dyUs99KlTvSXFfsRYyglkFNFcohjubBAcxgBZ7UwmE+5bMpebA+i4
	9eQDkh8Y0LzD94p8uElgloOBMp9L1wG7RI13lMaz5UuO0tDS2D9zqu9gVK8yRMKP
	58KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1761511510; x=1761597910; bh=RTQsyiUEE6akjbyIH7wztNfFRMKb
	XnTaYUoslgKMToQ=; b=IfaiYZBVpc2wWAKbIq+TOoSicFdYJ/lDu8HIDpyRaUYg
	XZ/rBnM9ZGfFby149r1ddUKM2AHHu/e1W4Pr2EiN4MHhag10S8F+Q23FhC54KVKV
	YBsmgTIG8RNHAjTeUpqbGjkW2hEfT10X4wg9GfDuQ1pzRHxKcwoFKx4NuOmVoTbw
	UE9UaDtE+1WguKkIAMM2EqyIB1PZ5Uav4/rNavhDuDTryxOHrTU4ElVNoefcVjnL
	BoMWlRrEhxKFVFvoygXufbg4zGEycl2a8BnaTZAHY4ToqOjcblhK7IZtaqCD1zQl
	6e0wLk4Yb0MwTbRz9n6g5LwnheI3Ue3rv+qEegrFng==
X-ME-Sender: <xms:VYj-aG63Et4hZizd5V42ArjL10JYPBvs-5fHkGjrwbzHUkM1c3rNVQ>
    <xme:VYj-aDkvntNdGc7XjshzyHnMylANpubzof7uhNL7d5wvtqU7LnbSuIWYX5KLa7od2
    stQkuxW_y-ZAAsOZwbcRFIDtKDS3dcXcnu1SL12btAZqwlVDFK-2vM>
X-ME-Received: <xmr:VYj-aPSrFnhHEIuRWYbo__tguvo8JwacEIcAotNP0YN3FhITMqFEoN6hWYJm3A03RH7q3igLgOgACqycCQiVvfmae53Ky5z69Y9qLggeXd5S84NwVMTN6QKxAGXA8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepudeuge
    etteefuedttdelffefueduveehheejieduieevveejiedtheekkeefjedunecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtse
    guihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghp
    thhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhessh
    hushgvrdgtiidprhgtphhtthhopeigrghnughfuhhrhiesghhmrghilhdrtghomhdprhgt
    phhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:VYj-aKHeAYGrtyU4YTPWWvkd7l0BQalU_D37f_FfxT_lG42cLBl1og>
    <xmx:VYj-aME_stxXUbmlxNfbY6WqwTsh5qZA7QTg8s7PZwZp39abYhfs6g>
    <xmx:VYj-aASqSNATJI-2Yripks3RihpPLfiD6qwtfn43_cNVIH7oyVTY_A>
    <xmx:VYj-aFJyaDmUqaj7prtS-d_rfPOFvLK73-nXNjZqq-sfDenvpcw1Og>
    <xmx:Voj-aJDSF9W8K_y6Nrl66WelpFas-qOZp3haKL2h11IfcxVkmJ3os-U7>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 16:45:08 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/8] Implement LANDLOCK_ADD_RULE_QUIET
Date: Sun, 26 Oct 2025 20:44:15 +0000
Message-ID: <cover.1761511023.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is the v3 of the "quiet flag" series, implementing the feature as
proposed in [1].

v2: https://lore.kernel.org/all/cover.1759686613.git.m@maowtm.org/
v1: https://lore.kernel.org/all/cover.1757376311.git.m@maowtm.org/

Not much has changed in the actual functionality except various comment,
typing, asserts and general style fixes based on feedback.  The major new
thing here is tests (a bit of KUnit squashed into the optional access
commit, a lot of selftests especially in fs_tests.c).

This series is still missing:
- Tests for scopes (ptrace, mounts, signals, abstract sockets)
- Some trivial edge cases (quiet_access > handled_access, setting quiet
  when quiet_access == 0)

However it turns out the tests I've already finished has grown quite
large, and I expect many feedback on it.  As such I thought I would send
this v3 now anyway, as there is probably already a lot to review.  The
added fs_tests should exercise code path for optional and non-optional
access, renames, and mountpoint and disconnected directory handling.  I
will add the above missing bits to v4.

New patches since v2:
- "selftests/landlock: add tests for quiet flag with net rules"
- "selftests/landlock: add tests for quiet flag with fs rules"

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

Tingmao Wang (8):
  landlock: Add a place for flags to layer rules
  landlock: Add API support and docs for the quiet flags
  landlock: Suppress logging when quiet flag is present
  landlock: Fix wrong type usage
  samples/landlock: Add quiet flag support to sandboxer
  selftests/landlock: Replace hard-coded 16 with a constant
  selftests/landlock: add tests for quiet flag with fs rules
  selftests/landlock: add tests for quiet flag with net rules

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
 tools/testing/selftests/landlock/audit_test.c |    2 +-
 tools/testing/selftests/landlock/base_test.c  |    4 +-
 tools/testing/selftests/landlock/common.h     |    2 +
 tools/testing/selftests/landlock/fs_test.c    | 2238 ++++++++++++++++-
 tools/testing/selftests/landlock/net_test.c   |  121 +-
 20 files changed, 3058 insertions(+), 132 deletions(-)


base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
-- 
2.51.1

