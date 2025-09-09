Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D335959
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376418; cv=none; b=mPf9tAKNSX1L7lZNt+DrHaCumehIRDC3icFHrQy3pocH533Wst04hKAS1hfSzXEWFYpE5nLEIR+jlw1ZVbGHyctKFUtKAosmigIaIHwSDp4bWdszK3JiVLcADmtfDDHSMul5h/vmQWer3THdk3o7PHDWWcK/r/jdQBaYpIseINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376418; c=relaxed/simple;
	bh=tWVeEYNCohk3iC1GsirW/IUA0QtntRhaaFFWAxULG2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fppp1JQjFuDF+gZ0bE3MMGonW/Dc6OJ0wuRPwQIv9hUIaO4QDqlfgzSvxNGV1lwOKHX/etJcyzTJVI2OEHfYa024osVuJP6jVfVfOoNiRixc/BjsbjPywSP0SAxgAKgWagtYrtPnlXMlc9jxQbWj3jWkChzXkVJr2o6pe+4Gyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=PB5M76cv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBWMAFdH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="PB5M76cv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBWMAFdH"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 453967A0183;
	Mon,  8 Sep 2025 20:06:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 20:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1757376414; x=1757462814; bh=Tt
	Qm6nZG1xiqalST041DzJ1DVIHmxriZzeQfpbBCFCA=; b=PB5M76cvlgtM/JvZRe
	jW9ZXRmcnuVSa41djKRSrP3Pz29bnlYEOpI37RHfIT3bXLGh3BwG2rzdv4kjf+nE
	YTzk8/OmT3OFg0tlEIPIXhDPCNDm5hjB53lPrGWi12ZgOT9sK43z6U0r0US0glKs
	mwNi9UOuJvH0DBc3O7lH7k0mfGGLP141RFGQ3/Aq8f/WB8xf2/okwm+/la/N7H1h
	3d1m7jcAaMH6WzXnYgJ9Vz2avdkykS5KeCKxlwF7Bvr2oyRGvg1lumSJckUUrJRW
	DDqe1XbUYQCiRavj2bNThHVjmpheMYGlUvYxp/rtJoznhO469MYyX4ijexfz3fx8
	KGhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757376414; x=1757462814; bh=TtQm6nZG1xiqalST041DzJ1DVIHm
	xriZzeQfpbBCFCA=; b=jBWMAFdHEajsWmRpPOYTZ0scITgOHZITUOeoflWwC+Vo
	10L01/flQ9OTyQot4wmmVpGm/wCvmTQ+EBC/gjpkf+ge3fFkiBZs7sR7MQN6xyZ2
	q6zPxZSEyfXu+s/mxx6WSlyHlc2m9307FYWMt921QwX6tTR4gbQy4hrOjgvCHOtq
	QzHjlabXWds5r0khwJ79mkdXgycYd23JA2hJtrhhGbJGYifvNyOa6Pgzaw30JWKy
	VbSTfhoaruHDePOcaxzTWnf1+KPs9Tv3AAh9iCp5WCmZv694AYDDPl7Mjl4PJaoV
	gjILpNMGl3HHk7bT747kl43gKFUSz01Vx3toPNI3hA==
X-ME-Sender: <xms:nW-_aBcv0jTDL1ESXqfmBjASTHXbafiFCHTaaq9WU-P9DqpN-gqMrA>
    <xme:nW-_aKtJE1JngZ5LOF8DbxREa3sQX-Sxy3m0rG6025JmRBje6JyN-uD4qFnTl6gPA
    4Dww0FzXWcUMKgPIfA>
X-ME-Received: <xmr:nW-_aA8qq_-oqEnsMDSeKMgr_NXsem_DtxXJPHzrYuBanVScPx6tXB0LjeXqbUqKbPRWVu_DsWIRwOmSs_zR6WzybaEUUeLUf2PjFAhSgVYlEI6O5CmrwCztGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgrohcu
    hggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeukedvje
    ejveeuudeiiefhudeuueekkedtgeehhfelgfdukefgveduvefglefgvdenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpd
    hrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepghhnohgrtghksehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtth
    hopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:nW-_aF0flKBZBc-GPzXkNt1aB2IyC-IGaomyMpyqgdaepxiINIZg9w>
    <xmx:nW-_aFBC9wZ7Wo7JyahvrOJqStq-smK3IDDa6K35XsmbGxo4cE0TeQ>
    <xmx:nW-_aBdk1PT42SR7JNMLsj7ppuwyxR5aHXF1i997QpC_pDVskgbplA>
    <xmx:nW-_aC6JAD-JcRpbKWNOjg7TcMt0F2tURW6XJon0HDb6jRWYsrekog>
    <xmx:nm-_aA6sLrCCPTf_54h-HSGViAOIT2zDjamG_jGZ2GPoPfjCdZeEQ_hB>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 20:06:52 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 0/6] Implement LANDLOCK_ADD_RULE_QUIET
Date: Tue,  9 Sep 2025 01:06:34 +0100
Message-ID: <cover.1757376311.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël,

This RFC patch series implements a first pass patch of the "quiet flag"
feature as proposed in [1].  I've evolved the design beyond the original
discussion to come up with what I believe would be most useful.  For this
implementation:

- The user can set the quiet flag for a layer on any part of the fs
  hierarchy, and the flag inherits down (no support for "cancelling" the
  inheritance of the flag in specific subdirectories).

- The youngest layer that denies a request gets to decide whether the
  denial is audited or not.  This means that a compromised binary, for
  example, cannot "turn off" Landlock auditing when it tries to access
  files, unless it denies access to the files itself.  There is some
  debate to be had on whether, if a parent layer sets the quiet flag, but
  the request is denied by a deeper layer, whether Landlock should still
  audit anyway (since the rule author of the child layer likely did not
  expect the denial, so it would be good diagnostic)

This series does not add any tests yet (and also no support for
suppressing optional access denial audit yet due to complexity).  If
you're happy with this design I can write some tests (and add the missing
support).  Here is a sandboxer demo:

    # LL_FS_RO=/ LL_FS_RW= LL_FORCE_LOG=1 LL_FS_QUIET=/tmp linux/samples/landlock/sandboxer /bin/bash
    Executing the sandboxed command...
    [  135.126499][   T60] audit: type=1423 audit(1757374868.281:942): domain=1a435130e blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=11
    [  135.133298][   T60] audit: type=1424 audit(1757374868.281:942): domain=1a435130e status=allocated mode=enforcing pid=959 uid=0 exe="/linux/samples/landlock/sandboxer" comm="sandboxer"
    [  135.141869][   T60] audit: type=1300 audit(1757374868.281:942): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=557a9cda83d1 a2=802 a3=0 items=0 ppid=958 pid=959 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
    [  135.156620][   T60] audit: type=1327 audit(1757374868.281:942): proctitle="/bin/bash"
    bash: cannot set terminal process group (958): Inappropriate ioctl for device
    bash: no job control in this shell

    # echo quiet > /tmp/aa
    bash: /tmp/aa: Permission denied

    # echo not quiet > /usr/aa
    [  165.358804][   T60] audit: type=1423 audit(1757374898.513:943): domain=1a435130e blockers=fs.make_reg path="/usr" dev="virtiofs" ino=840
    [  165.363746][   T60] audit: type=1300 audit(1757374898.513:943): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=557a9ce447c0 a2=241 a3=1b6 items=0 ppid=958 pid=959 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
    [  165.375594][   T60] audit: type=1327 audit(1757374898.513:943): proctitle="/bin/bash"
    bash: /usr/aa: Permission denied

    ## (still in sandboxer)
    # LL_FS_RO= LL_FS_RW=/ LL_FS_QUIET=/ linux/samples/landlock/sandboxer /bin/bash
    Executing the sandboxed command...
    [  203.490417][   T60] audit: type=1423 audit(1757374936.645:944): domain=1a435130e blockers=fs.write_file path="/dev/tty" dev="devtmpfs" ino=11
    ...
    # echo "child can't suppress audit logs" > /usr/a
    [  219.948543][   T60] audit: type=1423 audit(1757374953.101:945): domain=1a435130e blockers=fs.make_reg path="/usr" dev="virtiofs" ino=840
    [  219.953918][   T60] audit: type=1300 audit(1757374953.101:945): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=5651ea7875c0 a2=241 a3=1b6 items=0 ppid=959 pid=960 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
    [  219.969167][   T60] audit: type=1327 audit(1757374953.101:945): proctitle="/bin/bash"
    bash: /usr/a: Permission denied
    # echo "/tmp is still quiet" > /tmp/a
    bash: /tmp/a: Permission denied
    # exit

    (still in first layer sandboxer)
    # LL_FS_RO=/ LL_FS_RW= LL_FS_QUIET= LL_FORCE_LOG=1 linux/samples/landlock/sandboxer /bin/bash
    Executing the sandboxed command...
    ...
    root@fced6595bd01:/# echo "not quiet now" > /tmp/a
    [  492.130486][   T60] audit: type=1423 audit(1757375225.285:949): domain=1a435132a blockers=fs.make_reg path="/tmp" dev="tmpfs" ino=1
    [  492.136729][   T60] audit: type=1300 audit(1757375225.285:949): arch=c000003e syscall=257 success=no exit=-13 a0=ffffffffffffff9c a1=55fc4c168450 a2=241 a3=1b6 items=0 ppid=959 pid=964 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="bash" exe="/usr/bin/bash" key=(null)
    [  492.151727][   T60] audit: type=1327 audit(1757375225.285:949): proctitle="/bin/bash"
    bash: /tmp/a: Permission denied

All existing kselftests pass.

[1]: https://github.com/landlock-lsm/linux/issues/44#issuecomment-2876500918

Kind regards,
Tingmao

Tingmao Wang (6):
  landlock: Add a place for flags to layer rules
  landlock: Add API support for the quiet flag
  landlock/audit: Check for quiet flag in landlock_log_denial
  landlock/audit: Fix wrong type usage
  landlock/access: Improve explanation on the deny_masks_t
  samples/landlock: Add FS quiet flag support to sandboxer

 include/uapi/linux/landlock.h                | 25 +++++
 samples/landlock/sandboxer.c                 | 20 +++-
 security/landlock/access.h                   |  6 +-
 security/landlock/audit.c                    | 18 +++-
 security/landlock/audit.h                    |  3 +-
 security/landlock/fs.c                       | 99 ++++++++++++--------
 security/landlock/fs.h                       |  2 +-
 security/landlock/net.c                      | 11 ++-
 security/landlock/net.h                      |  3 +-
 security/landlock/ruleset.c                  | 17 +++-
 security/landlock/ruleset.h                  | 29 +++++-
 security/landlock/syscalls.c                 | 28 +++---
 security/landlock/task.c                     | 12 +--
 tools/testing/selftests/landlock/base_test.c |  2 +-
 14 files changed, 199 insertions(+), 76 deletions(-)


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.51.0

