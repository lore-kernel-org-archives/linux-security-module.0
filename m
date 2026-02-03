Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B6374188
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160394; cv=none; b=dWDyNLPkXYJKX7cjES1mQM0/o8ZNH1wGpN7RPkfax/WiQr5ByMPpbY+QQB7oTWvzLFnU8ts7wBml+6h+h3ItRbIGC6m8VIHK2EkDKZdBLWcpAk/Tq9hHKE0kLmMBOVRJvVQWHPqc/vSFJ9JBGSE5UMSRtUZfTNZs0ca1yWopjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160394; c=relaxed/simple;
	bh=IiAyjxoCA4okUUxHmwGu2LRNuOfP8j0qWtij31aZwL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GL3+UzXjD3i9KntkWlUjBFjgkS4izHYny2Lh2Z82ePw8D/U41LKDGopYYC11cXv6bqsd822X1aOXcYVI3VH2KoZ1MESyiUVrpw6Jg4hPn1jwr2ObpruXxOfa700/ANroZYIAvy/Gn6oSQvrDCpv9+RZSXjr60J2Z9MiTyzKHO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=w+GJAiOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WpYHZdV6; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="w+GJAiOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WpYHZdV6"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EA1C14000B3;
	Tue,  3 Feb 2026 18:13:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 03 Feb 2026 18:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1770160390; x=1770246790; bh=OY
	6LHGS0/SUgh/T2Wq6sOVOgIq2yZ67sqKnmkJpgdlA=; b=w+GJAiOQLO2shMeY3D
	453IazVaeAo6sZt8v6UdwASJYTT7wPTZrG7AoAdeK/Qn9/ybQ+8wcmKYdhZq7bJR
	stjHcJCTGkk5S4lMXizTZIJo6O8r41BihGN/mzYmX33jL4j6XQPMixCcqqigBXTR
	EtxX86i5kgtRrIShunKbQUhzJXelojhUOcyshogHXsSnr3Xwphb+2ExHlB1gVyec
	XNhz/+M2eR1qcjpMQ3w33FEhAyDY0I6+hb9QnEg44Tc1cb2fxi0okV57Lq5UZq9r
	hwWTT08Hk0SLhvGKet1yYvQ2fzItuUFWwnoYXKxUcmu4CDZ1nlvAUXsimjK3S8f4
	sZlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770160390; x=1770246790; bh=OY6LHGS0/SUgh/T2Wq6sOVOgIq2y
	Z67sqKnmkJpgdlA=; b=WpYHZdV6X4Rqjqck/MQFO/0BafqYxkeHxxnwyvRoTI2M
	de//JqsJrVbX5EWrczUu+c2ng8mrCsaYPk0KsxALPs0fa0VZwgDN93/B2Hiy1Nou
	eSEPC6sOxO1rl/SJGlz15Zxk5ASdYcvHN5JJIJKQrUtvNJxH7tb6LJg6dmDbq2lK
	Kj+ShQRKH9F0RvAf4uDs2VkMbu5XFgdAuDclQ4PeMpL5pnAEIq1x24TiOX+xnY2M
	/amMyr8LZ5FcMlp5lBfv6KeN26abeacqT/UwC9tKIMv4sOJ3tZcG2W2pDk3Ft+wX
	lz75w8zoQfACvtgnxGG1JM67S1pVF/ASh10p18vrFA==
X-ME-Sender: <xms:BoGCaQAs9fSTR-fZbfsMu-9nkos31hJ4upz3L2_O8BK-BXbSMbJyMQ>
    <xme:BoGCaVGcn1RzYCsREzuVVojy3_Ku2qSfy8e-syx8Eo3s0jAlOW40GVSZX3jn7-zID
    nQgypxYFcZoHoR2qWJOtLN5e7HqRJ7qNH1HtpRDZsFmBePhNYueG6E>
X-ME-Received: <xmr:BoGCaXMpME7kUxRLLSZfUX_4if7r6VoGj1H8OlcXUuCZSZNTZ3HM3Y6zNUtS2CXRvOm5tTAOc-gNzor7sQ3Glsb_fabq7mky0wKWfD_DpESeplQgXQCW92k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepffeige
    dvveeiffekfeejteegfefhkefgffeljeeileffteeguefhvddufeduvedvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpshhpvggtthhruhhmqdhoshdrohhrghdpghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohep
    mhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtg
    homhdprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohephhhisegrlhihshhsrgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtph
    htthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:BoGCaW6tT42dqEu2arVZAxeHNPR4P-034x-uMuWgV2ZeHZtPN35gOQ>
    <xmx:BoGCaajbpYe4FxUhRCW_JngKBRqp-2maad2WOc2A8_nh3iQDOnGfrg>
    <xmx:BoGCabcseQXl9Iaqxl31ifncCQgugH--5KNaTckaICxG3D_6EwTPdA>
    <xmx:BoGCaSxwf-aXWSxg-U81TF_3cGEDi49vqsDFOjg1xW-k6AAz1flRvw>
    <xmx:BoGCaUfkrwIITESddISqZUPMslXgqcOx5BQiPwfcbbB8aPYfx8altoDy>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 18:13:08 -0500 (EST)
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
Subject: [PATCH v3 0/6] Landlock: Implement scope control for pathname Unix sockets
Date: Tue,  3 Feb 2026 23:12:27 +0000
Message-ID: <cover.1770160146.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This version contains some minor update based on feedback from Mickaël.

(Sending this anyway for completeness despite discussion in
https://lore.kernel.org/all/e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org/ )

The rest is the same as the v2 cover letter:

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
    sockets too
  selftests/landlock: Add pathname socket variants for more tests

 Documentation/userspace-api/landlock.rst      |  37 +-
 include/uapi/linux/landlock.h                 |   8 +-
 samples/landlock/sandboxer.c                  |  23 +-
 security/landlock/audit.c                     |   4 +
 security/landlock/audit.h                     |   1 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/syscalls.c                  |   2 +-
 security/landlock/task.c                      | 113 ++-
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 tools/testing/selftests/landlock/common.h     |  33 +-
 tools/testing/selftests/landlock/net_test.c   |   2 +-
 .../selftests/landlock/scoped_signal_test.c   |   2 +-
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 ...bstract_unix_test.c => scoped_unix_test.c} | 886 +++++++++++++-----
 14 files changed, 787 insertions(+), 330 deletions(-)
 rename tools/testing/selftests/landlock/{scoped_abstract_unix_test.c => scoped_unix_test.c} (50%)


base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
prerequisite-patch-id: 5f3ab4d7ae2173abb98b510534b2eabc575944ed # https://lore.kernel.org/all/20251230103917.10549-3-gnoack3000@gmail.com/
prerequisite-patch-id: 0002366468db0afd2e68f4ee4f6cfb0d8e7ed315
-- 
2.52.0
