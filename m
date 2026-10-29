Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312310;
	b=xPsVZO2OTcibfzI6NPctraVHDI9vGzCDJku3qSARszzYQ9FpgbIFNhRrPRojMwivCpwW
	 2ubJTHSW7lmyHSBPBmXKasIiSEHdfRC98G2RRsbI9rbt3SxcI2jAcs6sZRNLSIl894WLo
	 N7mZQ5Zf9bU/a6k+e06gKIFmMMpWdzdQGYfqf2HrXBx08CFv0zKSVVasH6scFXkviPtk0
	 TT5AqSjrWTdyBMey0SDiG9dAKd1QCdNc7JMTcOX+Iy1YRPjGGsY8T+VnblL4K149/G2iW
	 n7mKnWFZSlaigd5xoxHZhcM6XRirEvrffCNDaYblYLoj58Zn4ciNBsjovpggHO9i6xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8DaIsZUm0SfTqL9IEgP7wDZ3j/073Qbdz3D0IhWkRr4=;
	b=2e5Bw0VBfn+QGHRERPISXvBWwZXkJh27IHHdA6NMBpN+EEseYrLJlZJmsV+Ws1QTGv0h
	 DtnXchWElZnwTkhDwsJJoR7vyTfs5upYeH1HfKI6A2zkC6rB2qbVcy4RrGNdMwPNN5j79
	 84/Qt2Wa5mnbgoLZr2gAo/3YSGWL6rAw+BwJP3K0Tec8new6GF3wCD1Rzc1z2U7t6l/+j
	 xhx2YeFc+uvle58GYBN2uE0gK9MmoCxmNF18L1uAOqdCVV/WrpQGCo4aYk/zqHSV83T7m
	 9XFTUBDvpH8QTYXUfg54tutbK4Muw8ngvs0frdaXkPv5xEYCdLQgDA4NlUsK7bs2jVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i94sPDTJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA769606A31F
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i94sPDTJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833DF1F01825
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312309;
	bh=8DaIsZUm0SfTqL9IEgP7wDZ3j/073Qbdz3D0IhWkRr4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=i94sPDTJtfWpSw78lkqGuXN2tr0cyoFMe8Swh+hB4tfMejNE2k7t3BxKYIhlQr6gY
	 pR7GJJKIrDcclNO0D+s+542KCr7OJV61sa4exIY5Hif5QLeRQK29/MMnG444x47MXB
	 oq7uVxDPKcNYNz+dRULbehJdGk25TxP3jPs0owzwUs08saiX9PrtOTMw5cdBJjhDy3
	 /qedPypp3RJKliT2yUqicQ1VqMl15IXjhpY08hjGkparltVQYQGoXR6Lq/DwJ61I3J
	 H8KCqBgUZ5YbhadiMz7ZZoiqSjSLmrqw2AdkfGugJtScHccUYl8MdWG1cifE43o8IR
	 eX9OtoaqVmiRw==
Message-ID: <sashiko-outbox-190067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] selftests/capabilities: tests for user namespace
 capability bounding set
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028221705.3915340-7-halg@google.com>
References: <20261028221705.3915340-1-halg@google.com>
 <20261028221705.3915340-7-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:18:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add tests in tools/testing/selftests/capabilities for the user
> namespace capability bounding set feature:
>=20
> - Verify default full capabilities and sysctl capability restriction for
>   unprivileged user namespaces.
> - Verify that unprivileged creators retain their existing effective
>   capabilities despite the sysctl ceiling.
> - Verify that privileged creators bypass the sysctl ceiling.
> - Verify monotonic capability restriction across nested namespaces.
> - Verify parent-ownership capability bounding.
>=20
> Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028221705.3915=
340-1-halg@google.com?part=3D6

