Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923480;
	b=A7hmDtJ7empudBNTCtlRyJDy0IK9wvWC2xGom+NS9Tgege9Q+ygpNZwVN6Qu3og74kH7
	 RQNZ8FaFYROTBkxc6LpbI3+Jb/HpF6qN/K3gowEx1pYJmVtH39eJdVWkyWIckNULAAUCR
	 sYO9vn9g2bZ12gNKAVFTbbAtbErO0CJ0ei5Z30IwXa5DXb4cw2vl6NoWDufBqb5mYiJFH
	 XEc0aqVeGXTQgmiBDgnUBJB24eonICID9XA0QvEn0XIugubCFCEWoZ80gFoS4w+yX91FM
	 kAbyvDZVBTiEh8cjxLAwevI9GkYg2PHTWiw54iBQij4cfyK8PXb3VvzmYvp1bG8XvWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923480;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=An62cQp4PQGRTZyLaanT29NwoMwFeQNXdZh52ZkyRjQ=;
	b=CxvD8f3WCd9W6qP2tzM4Uwuqq6BFSiYU5oZhc3Lf+GEQUV3MpBLwYxDdfI53R87g6LcL
	 Xmkg6Sj4TcBZiobPrzy+o5rCG12iOAUzGxmeMkQpD0iVnxvbPCHSh9C4XKpnSYGjnwmHc
	 ghUZugvDZlXjRNNGhYlAgnjB56Q8+KqBfCnfP15YTwLx3PauRc3f3jujnyX8zqyJq5KE3
	 6vk0n/8i332mTKrV/iK5RVJITHXHroCIr6/Vqde8ZOpeAjo2pGuHykCWmwcYzt2CpZeTT
	 h2DPA6/15elY7i0fa3jvIguBazfd8EC/k9zIIw/ETfoTQyLrsQX1jVwC4LxlvH2HRqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=YCBhdle6;
	arc=none smtp.remote-ip=185.125.188.120
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC777606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC777606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=YCBhdle6
Received: from sec-questing-amd64 (lfbn-idf3-1-218-1.w90-22.abo.wanadoo.fr [90.22.217.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6D3F13FA3E;
	Tue, 17 Nov 2026 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1794923471;
	bh=An62cQp4PQGRTZyLaanT29NwoMwFeQNXdZh52ZkyRjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=YCBhdle68T1Ml3NYLXgMPNKGZw7zpEM5htQCjihcuNkytIn646aPFY5kzv4PmnURu
	 uM50kzJoFxsg3W4r9Dxmoqg0h0fHEyOZYGG1BVz2ip7PD9cV4NLxqJBA0DjwruskTn
	 RjAY1Vns5NuumNhMWK6za351zEo32s2yIyjJgi3Orpn3JxZ0d51bfKDTDB6tXGnlFL
	 CvovNJIycQPZY1gHVDyysFAej3K5RcZu9iuySKmD1Pi36S0C7Dn6dqd4d2baBLUDJx
	 c3b9sn7bMXWD4hkmffUshRLf8TvrNxDUXG8OyqLBkG8uj88K2MzQVaZrAsGCXZpxVn
	 s7PgMpcSFc5MjmeeeOaojNH0KulrBbxvddhlWtuLoP7Q6U/8yaAI8Miy4auynRAHra
	 KPLug8R7n07Zajtd50rJMU3XlCI51MrGmFgru9Mq9EV7bW1d5dlyk5x79aCvOy75CP
	 EzV1fNmVeKJu52PQESzGSUwSPfWkouGnmtMm+lkQuYJSHbpGzeAP0BArThHCocNLW+
	 E1WIdeGQFkNv0o1be74AmUCICyPE0qz2i9fJhOSFkXims7dwv6t5F4Q2n9Pu5o3UN5
	 UoTNn2osRNQDWF6E3QyOTMGNK+ThIzqtZypt5jYe6Ou+2grMBVUI+ypxmrm83x9EHT
	 Xba68YOS3TLuCGEvWDr3crNI=
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH 0/4] apparmor: provide the kernel feature set at build time
Date: Tue, 17 Nov 2026 14:50:06 +0100
Message-ID: <20261117135042.78238-1-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

AppArmor policy is compiled in user space for the feature set of the
kernel, and the cache of compiled policy is keyed on that set. The set
can only be read from /sys/kernel/security/apparmor/features once the
kernel runs, so the first boot into a kernel with a new feature set
compiles all of the policy.

Every entry of the feature set is a build-time constant. This series
writes the set to a file when the kernel is built and installs it as

  /lib/modules/<release>/apparmor/features

so that user space can compile the policy when the kernel is installed,
and the first boot takes it from the cache.

Patches 1 and 2 prepare the feature tables to be built into a host
program, patch 3 writes the file with that program, and patch 4
installs it with the modules.

The file is identical to the output of "aa-features-abi -x" on the
booted kernel.

Maxime Bélair (4):
  apparmor: move the feature tables to a header
  apparmor: make the feature tables build without kernel headers
  apparmor: write the feature set to a file at build time
  kbuild: install the AppArmor feature set with the modules

 Documentation/admin-guide/LSM/apparmor.rst |  15 ++
 scripts/Makefile.modinst                   |   6 +
 security/apparmor/.gitignore               |   3 +
 security/apparmor/Makefile                 |  25 ++-
 security/apparmor/apparmorfs.c             | 127 +--------------
 security/apparmor/capability.c             |   6 -
 security/apparmor/gen_features.c           | 100 ++++++++++++
 security/apparmor/include/capability.h     |   2 -
 security/apparmor/include/features.h       | 173 +++++++++++++++++++++
 security/apparmor/include/net.h            |   3 -
 security/apparmor/include/resource.h       |   2 -
 security/apparmor/include/task.h           |   4 -
 security/apparmor/net.c                    |  15 --
 security/apparmor/resource.c               |   5 -
 14 files changed, 328 insertions(+), 158 deletions(-)
 create mode 100644 security/apparmor/gen_features.c
 create mode 100644 security/apparmor/include/features.h

-- 
2.51.0

