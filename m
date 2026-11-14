Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685462;
	b=GFTZY0aB0sggSimf5ZbwuvJCIeT7LXtU+XCwS4lKEybdlvovlulAQtoY2gowJW1yQqVr
	 /+JbOSjufbgq+KpAl5SNSVVBjXC7ys9kfq080RfyQ9OzfBT58MH+R72OpAc7D+Nb1YRtl
	 13bTwH2wPBRDoFf1+JO7XfkWxvo4jzNR+m9YE2rGqWnyH/mP+4FqWuHj0x73tHg0BoLoE
	 ahRBgcSKzSC/bfbQlsucJM/13Dv9ciiBKGEhLfeqvmvIgQRV7f15jXRKvky1LcHVTB2Oe
	 6b3A5/IRKaVId4S5yn6J3NMlXc/CquP697qzzjQ9MLrMCP7YWeWRPIEr512ugVW1AFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sLn5NUYatzNU/c02Tk4CdSrtvDHh5tKDZhQYOwnMzRE=;
	b=B+r7FLNm48nIlRz8m6sKRMj2YvAoJarhHcRqEwcMhiNPVIr7c29qdM00zXqoo+FUkg6e
	 aC2SdVu9QAR9MBMnbA3N5Dm8CTEdZqHI/iY/8PVEP3MCpbOzRqOxto5ElNX2aO7vIJ7lC
	 4gU7LuR5eAYuTnBCq11FfQ64Q8JFaV6teOFyEup83tOONMhrjWMXMMXHxqTA0vijujlo0
	 xImiQbZK05yzUNtiDqB5E5zLnOguoGfSa1wnlOofWE3Wtjjbn3tULCwgDZcpSBBEwxLPe
	 dNg+ayXIDMjY8a/1wJkXnWmOvE70/iyvZc/QiIGpd16Jvan5qVCfhSOlVAI51y8N3Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki6uidLA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16861606A323
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki6uidLA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B96D1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794685461;
	bh=sLn5NUYatzNU/c02Tk4CdSrtvDHh5tKDZhQYOwnMzRE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ki6uidLAmpAAV32tWjXsJ0XsfJOiCUGwRcxOOBkwUNSGmHTcgckVdou2tCBOGYYdz
	 vc7eaZifN0aA/y/Jh1zS/MEaEiPMYYRVBOesOtsSMQgaJB6Mqk19XZodBZjrhl9I2k
	 D1h5vl1wXsfDP2oN89w1PVbjhdFw1Fb8xpahgRkB7mn0V1h3Unbk/AQot/WOJ6q4HN
	 89hNP5M6KpQL0VdIMjBk/zH5Lj04y+LoO8rP6zRQ1JYQz2TMyqLgMzrQBFw0ndYtQP
	 7bKx3skkSsEfsJ2W4i/8x3nFJ9bwhpezhjPHDnGcaSvz68CF/Fcx3uoVsj7fQ263sx
	 qL9sJ5iYpePdg==
Message-ID: <sashiko-outbox-214983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 7/7] lib: Remove assoc_array
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114193631.731615-8-jarkko@kernel.org>
References: <20261114193631.731615-1-jarkko@kernel.org>
 <20261114193631.731615-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:44:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> As assoc_array has no longer in-kernel users, remove assoc_array
> implementation, includes and documentation.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114193631.7316=
15-1-jarkko@kernel.org?part=3D7

