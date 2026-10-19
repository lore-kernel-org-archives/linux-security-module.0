Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425751;
	b=tZ1tqCTGpZ5wA3QheJc1GNnjilSADy2Ss9v24c/vBbTYuIK3INcFeKCR1M8KQlULGNz0
	 kWSvf0WcyBvbWg01ZDQsCandMjDTTUsXJRClppwPVOX58oCGUTM3cgnTTy1AR/9K3WKrv
	 /ZaFR2XjG8X6uctxtNi3uZimsPjG9MkyT7ix+Ag/qjHfKKjIt9kHSAvHX4K9iqXemGjVT
	 I4p48QGgniQntV3NMNkK1qhxK/mOdCmmNoi7dgiPk3fUv9tO7QUmSQmEI6zOTCQSBp5cN
	 4xF/IHVNB6s5ddyrYikYSqrbT+LqyNHU/tGzhGPnmHI3h2Lgff4A76K0lD2jAI+s9yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425751;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hWJBewij0zpX1KGXOdex7jzm+KRZsFSks8GUX71lFdk=;
	b=JowfPOWAsWjVL0JAtWaRs+OTKINgKmTwsRe8bNsgdjmFB/A3WwMl51jwj+SXLKQVNvDs
	 doFuCtNc6erDtzQ9+7WzMbXiL6ZHCjNOiCkJMxv6GAer/ZW0XDDmGis3LfZ/3wTrVZK24
	 PfmHmhr+MMV009b9bebqHMDWx7XPtA4ccrVdYDGIWkgzXwhdtgicmfcMqcfhIDE9M+40u
	 dZI8O3uLYhWDaMyXC1YVzFn9R+zNfwvt+Y7dhPiWW43vejz4MQpH18ScZ8xckQvqXeKCv
	 mOnNA6WkyPbWMcGk62+F/39J2fjyZnAmUyd7k0/Jf9/vcyxQNpbLPySo6waUbWI5P0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PH96ojEW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C205607553C
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PH96ojEW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB51F000C9
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425751;
	bh=hWJBewij0zpX1KGXOdex7jzm+KRZsFSks8GUX71lFdk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PH96ojEWv9z+6RtqkarluXs2X1AIlfKcswZsJwt8sStVInuW6JFCCtbe6014L+w1B
	 q6e/tZgOnaU3cHP9uH1Zo7gCp2izvY25dI7SkU+Bz63Y8M5tgPEG1soZneJWXkC8jH
	 +ZyOCxPYB2bBu1b3PZHtFQODMegS0+2S0y6gTzblyqKZdjJZhST7Afnp8cJjA7Hsw6
	 nBZewXQFbZgsh+1dGWIb6Y2bAKSrqPabY46cRIh0dMNtnkinK/mcVsGeCz9wB2wtYS
	 t5ukjRC+sZPeej6SNjnR2XfFJvw2P98IQQzoh3+bMhpcwm86FlAKyXagziBu1sFUjl
	 Awjy7UZAa2E9Q==
Message-ID: <sashiko-outbox-177800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/8] KEYS: Prevent overflow of user->qnkeys in
 key_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019142516.300040-5-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
 <20261019142516.300040-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:02:30 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add the missing check rejecting allocations when user->qnkeys has reached
> INT_MAX.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019142516.3000=
40-1-jarkko@kernel.org?part=3D4

