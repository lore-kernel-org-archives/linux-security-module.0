Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC812FDC29
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766925967; cv=none; b=M0mba1MfFOpdKuicqjOIfsMrQsdUW3sY6tGSHYmr/9Ey1AEWitfZ9LmiPAKRnyziG2+88lIU2YIik6YzrcEV/s/aIid1qzKqssyvnftWvceHEsGyzONHXVg93pk1kdeGBb+VAFauXzb36csXXhKfBfcV76E8qN4sSgm2AGqsp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766925967; c=relaxed/simple;
	bh=U7oblZNKwLywC0d/zU3Z3PqIN3lMlbNGaatykq4dydU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NrEtEU0OzXFMJWz9Ye3ccDmaul3YuC3hBF3y/BoJPBU/8w9BSLE+7jD/V34XEHpdWnpKLcpyjKcr69lLFoIowaAEpZses7FM0V8AVl7bbjaJveXGaJ2Hvh7xp83drxRGhHMZOtEt4LOeGqnVtpCvlhYLqwAIuT+jiPuL/0r+bL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=FlaH4kED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tb+23YxE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="FlaH4kED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tb+23YxE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id ADD741D00371;
	Sun, 28 Dec 2025 07:46:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 28 Dec 2025 07:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1766925961; x=1767012361; bh=uteRUcWHCOTdix0Cb1kQl
	QxGVnw7Jh1esUbKNeSES9M=; b=FlaH4kEDS2JAYYVxqtJGT44XLdsOj5EHsQpJw
	DDZEBu8O+jT209LERaaxhf0cnoQdpf8+e6mTdIM5P2X/SVw370C2IirvnnpIPsa9
	7JlmaFRFyzQRr8RklmmGwRVRQ/fXQBPJW6dKQ9lLliwFYXi/mUZhzG2ue1tQ08fI
	AxkGdvAPL6+9XC21OoOVWKOp40GShl7P9PaMiGajpfdTHUOzpW+iRAvQXoY1/VWJ
	nPlEqnNfTZNRqN1aSgQrbFlUc4+KHvC8NmSFFWbUykF5kKeYDNRjt53WZGi/2nhk
	l0u/AJyi/nXDHbl/5matydEgIdvxB9OPyJcJSiQhh1gOr8YUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1766925961; x=1767012361; bh=uteRUcWHCOTdix0Cb1kQlQxGVnw7Jh1esUb
	KNeSES9M=; b=tb+23YxEOxiozniYprJv0efleRzti9huKj1Qr6yuWXh+QTo9mX8
	Fz4ow4r6vfm3uZGUf6LQtRjfuTHxLyubRvoNochYUOVu0yE0AMwXKWMo9svdO5zY
	vRh8c9FS1gSl++G3QS7HwbovOTMccnnpAIE5uVo5qFLQ1XRhVz86oN9x4EasqFax
	j86I3qaRpAp3uAGqUBjinxvl5nKj0rXpn4f16Zb9cyfAmYjQszv8Ca0bP3UICxKM
	J/Nw92gA4tIcH/43AEryQOhIEkOOEDneis2rhEHg2paUTR65W1ex5srgbgbt57UK
	1z98ZH7TcJU4hvLRx0G2jZ41rghCFxhCvWA==
X-ME-Sender: <xms:iSZRaTFVbeak6kblKU3sa92RRQDBUURZLcZ7ZbL_O0Ndw1Lk95RezA>
    <xme:iSZRafZGrOxGw7jecA6PZOp9-i_UidN_5yVI5LrdOnjNEl21RVTjnPZtBiotFcaKa
    stbXUy3rzeGnq4GNBMiZiodlNDie999EgxCUmvqiO9K3i_IKM3ayQI>
X-ME-Received: <xmr:iSZRabX4b9-OAgl91FlIVHPFawMiF_2DVw93NljF3bgiIfwY3-8XWAyR42h5ByLYTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrghoucgh
    rghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepiedvhfeuke
    dvveevteehgfffhfeiuddugfeivddvueejvddujeegudejgeffveegnecuffhomhgrihhn
    pehsphgvtghtrhhumhdqohhsrdhorhhgpdhgihhthhhusgdrtghomhdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    mhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhes
    mhgrohifthhmrdhorhhgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomh
    dprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohephhhisegrlhihshhsrgdrihhspdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepfhgrhhhimhhithgrhhgvrhgrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iSZRadmg5G3pnKSJKbkylKZaCr0daX4SQUpYNv2u1AQU9PCCTgPTPQ>
    <xmx:iSZRaeAAJtFeYoPWBGga1ZC6YjUzQA0SGgvFB5NLiIHD7oNybqYujg>
    <xmx:iSZRaUidLyFFHEYBGXMVZWDmdX1NIHZIjIC_tlui2ZizVebz21wE4g>
    <xmx:iSZRaTz4t9mn9McK6s9ryeLdocEtk0PgQE5NP4H4xjnAU8_fvqLlUQ>
    <xmx:iSZRaXCA2WqMsgClsCL3uqnhGiVIufwnuN319hXwvUQTaN6D-mlxmghm>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 07:46:00 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/6] Landlock: Implement scope control for pathname Unix sockets
Date: Sun, 28 Dec 2025 12:45:39 +0000
Message-ID: <cover.1766925301.git.m@maowtm.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
following (while only relying on Landlock):

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
 security/landlock/task.c                      |  74 +-
 tools/testing/selftests/landlock/base_test.c  |   2 +-
 tools/testing/selftests/landlock/common.h     |  33 +-
 tools/testing/selftests/landlock/net_test.c   |   2 +-
 .../selftests/landlock/scoped_signal_test.c   |   2 +-
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 ...bstract_unix_test.c => scoped_unix_test.c} | 855 ++++++++++++------
 14 files changed, 752 insertions(+), 295 deletions(-)
 rename tools/testing/selftests/landlock/{scoped_abstract_unix_test.c => scoped_unix_test.c} (51%)


base-commit: 161db1810f3625e97ab414908dbcf4b2ab73c309
prerequisite-patch-id: 4eaf9fc84a1911a86c8a5db5a48e1e30dd13988f # https://lore.kernel.org/all/cover.1766885035.git.m@maowtm.org/
prerequisite-patch-id: b0750cf8e20fbd1b39b0836da7a980a9592a461b
prerequisite-patch-id: 4b6d65083f8b677c5dd249eb28625c152f5e91ab
prerequisite-patch-id: 2558c06992f9a689b11f05ae26acf26b7d56fa28
prerequisite-patch-id: 87beca2ee8cb7fc774ebff8449817e98fb849efa
-- 
2.52.0
