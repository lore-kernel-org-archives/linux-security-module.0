Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827532;
	b=0JVlY301KC9HuO/6zoeJOuqbWU2gYg/N0KLDLXO5RzO5xzB3I1A2/Shc/UaZEyn1XGO+
	 41MDvImWHeQj4XMaVMgn7F01wyXU+27pb43CsJ8l6qoYvAkVOWb97Vm1iWFwPH1yGSnbb
	 wzJ3hrngDZu/4zIXTTu9zvIjcVfX7Vh6iy2yUA1N25eazGLZm8PeHCsB4ZhdsUAUlc7E9
	 Yv1rorMe+2zKE5nddjkM5lQvdIpzbsNdmJJlnbE9UI6PFo+qlABMOCAoKuZAxCgu1S8oC
	 E4LVB+hHw9U1cDkZzSrrRFrZNpSXjBq7ykZxHg1siJZxumUkfxkHNB3lurGWN/uH6Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827532;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/1QUN62BGAdoPMyynV3/B1q5dqdNyHmFW8ObkCGMl4g=;
	b=Eri6whnCus9rrCUw+wvAc7OfYTQ73liKTnhdZFLtOjyldaOscD0+PMbPWZkqoN0Hp0NA
	 ODGjCsscujPJUKwBFkubcKfr9vLg9SvCpKcfMCnl6x2wHlXhR2mLukwZG0rp3OLfPLV64
	 +IoohVZZ7Qb2Dg4aa+WMdH2rCx2APIiOjx0CBp2UeSDfMNQyKv/PmekyFbf9JV7+7AOAe
	 W34S6AXl5gXtPugA2BhBE/SfG8vQZvoGdpkHTIoTBC+frYc5Zm592wWsM0Z/ttsCFp9zp
	 4J3sWQA2UGeNtPbgtDGtb2nVY2xBLZAPilW1aFy9NTLkYL4dhdHNqAFdD34/ZxE4+DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPIDmdtW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CD606EE94
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPIDmdtW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5288B1F0093A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827531;
	bh=/1QUN62BGAdoPMyynV3/B1q5dqdNyHmFW8ObkCGMl4g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hPIDmdtW/BcwZz3JRw6G0hjtFcBnKThse3BNPNagCHu6RWtRtb0VT7uKfwZWh0AiK
	 URfEE3nirE8xa5bm8iQ3A80uaboC+pqruIKok/MZA+Vuqm4Lrh7AslOx6N/BwE6H2/
	 Vc294GDl4evJD10MQsesmyzszMUQ657ssa3h/JY+4Lj2LtzPWpUQJ0GgGqFOPvfYYU
	 IO83fb/J4VbdPItR9WO74eaPDGOI/kdwb7efFdNfrrGFlebkOsyBC7ygQCs9EYg9fp
	 eU7k9b8UVjV34QQEpwZQ38pcq16fwJIIVAypkq2bYZ2/vbSmqWBHoHdcv0gHm2q3ZS
	 C0swCOrdv2vCg==
Message-ID: <sashiko-outbox-198112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/27] selftests/landlock: Assert WIFEXITED() before
 checking the exit status
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-25-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-25-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:25:30 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> WEXITSTATUS() is only meaningful if WIFEXITED() was true (see
> wait(2)).  Check WIFEXITED() with ASSERT, as most tests already do, so
> that a signaled child does not also produce a misleading exit status
> failure.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D25

