Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125E16F288
	for <linux-security-module@vger.kernel.org>; Tue, 30 Dec 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115263; cv=none; b=EzbwsSHnA1I/Ma8DAtqVjkiKVmbDOk2fhce+sQpsPr733yHwB4W/kksKpUFllC6FLPSfCFAKiDQP/+Xxm2qVz9YNc+fIsGvW+Ufx+VmpBisekN/Ykj7O1wYsd+8SU+5xOe32ZjYOYtu3r5iy03bOI5e/GdV2w5JcL1vnNPmxJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115263; c=relaxed/simple;
	bh=r3DW+WnCfnmpLCJM0I0nSbk90SRDGUXHIoJ0AYUjLaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGLBUOBfjcP13ohAzEkGpBY9EuUp+S4aaDDLINj3ocu+mW4VOP0khdvzi7pW+wEemddd0buLdZgnLD6wQ5VJirzCB1DcSwJ/iT0vA8xTrWZ46O1oSNndrcMHDQkoSEPrJx83wA1KfCYrhLNdICtDqCelRLzNWXr7ndBg5Bj2Sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=gvKrDll2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JHvsAk06; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="gvKrDll2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JHvsAk06"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 24B271D0004F;
	Tue, 30 Dec 2025 12:20:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Dec 2025 12:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1767115258; x=1767201658; bh=P/ugaFaLRIBOTXaAVBu/5
	fbX0qRh9rL2PKeWAVpSZYM=; b=gvKrDll2i0ypCF1X43GzvrqwqkCed4RkRaIWk
	DNX0TABxCma0Lr0z4ewpxNfb5522QrSDy3QQbxE8E3wk/TtSWFVS+5BPSPEJ84Dw
	0Rp4E7usAmTWYEBqs33fK71MHQb6Z3XSqKrigsxIUhZvCOiHY+fj8fBAl5/scnlH
	Rr11EgfwGzI52uTHzsx302kN46g/NXK2IABILg3Nea92jTyphWZrBtVelR1q3OGp
	u9kWdcKDKL3BoOOyJJl+eF/tTVtJ/Bw7T7hX0STK2HVuGQbWl44lG1bZhLTHFaoj
	fXyIH7d+yZAN/35IhuLb7w6EZFX+Mom0TwL6HGzLsi+c+dckA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767115258; x=1767201658; bh=P/ugaFaLRIBOTXaAVBu/5fbX0qRh9rL2PKe
	WAVpSZYM=; b=JHvsAk06romNFr1if0oQyXW0nmpWxSGPoJI+bIWvKZS8hQl8IGy
	dhIc9xVY/QZ6QLop2smSuLW3sOHO4ScAsVGLndeY0QDKxwMq2zv6gReV23xfD4fA
	Tx344vDcGWg+xhZbRmACfNoGdX6LnDTXD6IIb6F670Bh9M+xAtv7TxDsQEG2hQb/
	rK/cQ0aRbCFDT2+XwAecdfr9ipjd4aXvhIxxpPiyBH15wl8Jp4yPUiBwmjVrturQ
	AYN8P7pTIlBZtcvNwkiT8Fhp8GlIyhEmDvn5m1fCJXGHH+SFQAS+I6z4LhruZyp4
	/TQ9jeA7V9IEUuteRMasCAzJhEOKcgmi2eA==
X-ME-Sender: <xms:-glUaS0rbBinbziXTbmNxM4lV8QZr0XmKCvTH1xJg7815aB6D_AThg>
    <xme:-glUaXqwCJsBO_y9HKmgVlVmOt_CG9MvdfEWhDCZTV61ErpS4T1wacXEY4to6Fv5u
    vQjHv5Ngw98Q8WRWg2BDJpSGVQX8GA93H8i-_TaKxKrXyOQ4sSi1dA>
X-ME-Received: <xmr:-glUaeiU1tQ49eBwM64y8Lvu-e7JmBIrkytytSJpFrLCEPAjX7oy9Vw6ThQ7hsqwRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrghoucgh
    rghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepueeuvdelvd
    dtheekhfeuheehueffueeijeetgffhvdekgeekueeffeegheetudetnecuffhomhgrihhn
    pehsphgvtghtrhhumhdqohhsrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhr
    ghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hitgesughighhikhhougdrnhgvthdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdp
    rhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggvmh
    hiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehhihesrghlhihsshgr
    rdhishdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hfrghhihhmihhtrghhvghrrgesghhmrghilhdrtghomhdprhgtphhtthhopehuthhilhhi
    thihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtg
    hurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-glUaT-MkuyC1bK2o_Nj0CqpKIBBPCcOFryOkMXeCLAQaqecyjq7iA>
    <xmx:-glUaaWA-tFnbl2UKb_0cyTVPV-_yw-8CxoxbqR5tvcoe2W_wvoY8Q>
    <xmx:-glUaXC6-jZt50F1KgSwshrng-_k460osfNsnX-cD2beGdNFsjorKQ>
    <xmx:-glUafH9iHQtxbx3xiVxxasvO1AxuQH0-H1oN_49Em9os-d3Fegknw>
    <xmx:-glUaZi42Vq2HFuKYXzbJVxXvhbGyGwiZkFuygUM2b9feLJvKGcbzniY>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 12:20:57 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/6] Landlock: Implement scope control for pathname Unix sockets
Date: Tue, 30 Dec 2025 17:20:18 +0000
Message-ID: <cover.1767115163.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
  Fix grammar in doc, rebased on mic/next, and extracted common code from
  hook_unix_stream_connect and hook_unix_may_send into a separate
  function.

The rest is the same as the v1 cover letter:

This patch series extend the existing abstract Unix socket scoping to
pathname (i.e. normal file-based) sockets as well, by adding a new scope
bit LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET that works the same as
LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET, except that restricts pathname Unix
sockets.  This means that a sandboxed process with this scope enabled will
not be able to connect to Unix sockets created outside the sandbox via the
filesystem.

There is a future plan [1] for allowing specific sockets based on FS
hierarchy, but this series is only determining access based on domain
parent-child relationship.  There is currently no way to allow specific
(outside the Landlock domain) Unix sockets, and none of the existing
Landlock filesystem controls apply to socket connect().

With this series, we can now properly protect against things like the the
following while only relying on Landlock:

    (running under tmux)
    root@6-19-0-rc1-dev-00023-g68f0b276cbeb ~# LL_FS_RO=/ LL_FS_RW= ./sandboxer bash
    Executing the sandboxed command...
    root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
    cat: /tmp/hi: No such file or directory
    root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# tmux new-window 'echo hi > /tmp/hi'
    root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
    hi

The above but with Unix socket scoping enabled (both pathname and abstract
sockets) - the sandboxed shell can now no longer talk to tmux due to the
socket being created from outside the Landlock sandbox:

    (running under tmux)
    root@6-19-0-rc1-dev-00023-g68f0b276cbeb ~# LL_FS_RO=/ LL_FS_RW= LL_SCOPED=u:a ./sandboxer bash
    Executing the sandboxed command...
    root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
    cat: /tmp/hi: No such file or directory
    root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# tmux new-window 'echo hi > /tmp/hi'
    error connecting to /tmp/tmux-0/default (Operation not permitted)
    root@6-19-0-rc1-dev-00023-g68f0b276cbeb:/# cat /tmp/hi
    cat: /tmp/hi: No such file or directory

Tmux is just one example.  In a standard systemd session, `systemd-run
--user` can also be used (--user will run the command in the user's
session, without requiring any root privileges), and likely a lot more if
running in a desktop environment with many popular applications.  This
change therefore makes it possible to create sandboxes without relying on
additional mechanisms like seccomp to protect against such issues.

These kind of issues was originally discussed on here (I took the idea for
systemd-run from Demi):
https://spectrum-os.org/lists/archives/spectrum-devel/00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com/

Demo with socat + sandboxer:

Outside:
    socat unix-listen:/foo.sock,fork -

Sandbox with pathname socket scope bit:
    root@6-19-0-rc1-dev-00023-g0994a10d6512 ~# LL_FS_RW=/ LL_FS_RO= LL_SCOPED=u /sandboxer socat -d2 unix:/foo.sock -
    Executing the sandboxed command...
    2025/12/27 20:28:54 socat[1227] E UNIX-CLIENT: /foo.sock: Operation not permitted
    2025/12/27 20:28:54 socat[1227] N exit(1)

Sandbox without pathname socket scope bit:
    root@6-19-0-rc1-dev-00023-g0994a10d6512 ~# LL_FS_RW=/ LL_FS_RO= LL_SCOPED= /sandboxer socat -d2 unix:/foo.sock -
    Executing the sandboxed command...
    2025/12/27 20:29:22 socat[1250] N successfully connected from local address AF=1 "(7\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xB0\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xAE\xC3\xAE\xAE\xAE\xAE"
    ...

Sandbox with only abstract socket scope bit:
    root@6-19-0-rc1-dev-00023-g0994a10d6512 ~# LL_FS_RW=/ LL_FS_RO= LL_SCOPED=a /sandboxer socat -d2 unix:/foo.sock -
    Executing the sandboxed command...
    2025/12/27 20:29:26 socat[1259] N successfully connected from local address AF=1 "\0\0\0\0\0\0\0\0\0"
    ...

Sendmsg/recvmsg - outside:
    socat unix-recvfrom:/datagram.sock -

Sandbox with pathname socket scope bit:
    root@6-19-0-rc1-dev-00023-g0994a10d6512 ~# LL_FS_RW=/ LL_FS_RO= LL_SCOPED=u /sandboxer socat -d2 unix-sendto:/datagram.sock -
    Executing the sandboxed command...
    ...
    2025/12/27 20:33:04 socat[1446] N starting data transfer loop with FDs [5,5] and [0,1]
    123
    2025/12/27 20:33:05 socat[1446] E sendto(5, 0x55d260d8f000, 4, 0, AF=1 "/datagram.sock", 16): Operation not permitted
    2025/12/27 20:33:05 socat[1446] N exit(1)

[1]: https://github.com/landlock-lsm/linux/issues/36

Closes: https://github.com/landlock-lsm/linux/issues/51

Tingmao Wang (6):
  landlock: Add LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET scope bit to uAPI
  landlock: Implement LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
  samples/landlock: Support LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
  selftests/landlock: Support pathname socket path in set_unix_address
  selftests/landlock: Repurpose scoped_abstract_unix_test.c for pathname
    sockets too.
  selftests/landlock: Add pathname socket variants for more tests

 Documentation/userspace-api/landlock.rst      |  37 +-
 include/uapi/linux/landlock.h                 |   8 +-
 samples/landlock/sandboxer.c                  |  23 +-
 security/landlock/audit.c                     |   4 +
 security/landlock/audit.h                     |   1 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/syscalls.c                  |   2 +-
 security/landlock/task.c                      | 109 ++-
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 tools/testing/selftests/landlock/common.h     |  33 +-
 tools/testing/selftests/landlock/net_test.c   |   2 +-
 .../selftests/landlock/scoped_signal_test.c   |   2 +-
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 ...bstract_unix_test.c => scoped_unix_test.c} | 855 ++++++++++++------
 14 files changed, 757 insertions(+), 325 deletions(-)
 rename tools/testing/selftests/landlock/{scoped_abstract_unix_test.c => scoped_unix_test.c} (51%)


base-commit: ef4536f15224418b327a7b5d5cae07dab042760f
-- 
2.52.0

