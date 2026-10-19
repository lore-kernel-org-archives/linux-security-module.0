Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434336;
	b=jTICPkQeNC19zF4hNwlgEOYbP7PmKBfwOUxfPvlb0JirTfNwrQSRshmyfuEaqSwocOPi
	 9uD7h8NuhLCF2pK1FhVXDTZJYUwujuGbKTZ0c5QHQxxbHDxHCKjz+V8q+uP7TGH+3e8pG
	 1jM+w9ir1+R1gnl+H0GID8F5s6dZtwW65AMiTrIbfx6c8wkR/DK9EV8a+IVx2659393/Q
	 l0+HImbocKoWbnXViVeD7YD6RkHPjLEqkCdMPRxSMhwCu7zKQcMW2ljm1WqEV4sCoD0Py
	 1TGjdtkqBLJ4pvJ9olG+wAT0WN0cwVT1tCW12QFT73jQvM2lxxI9ELe36Be27Z9Ukpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q6pzJekZWjm1Y1x05ARDDWi9B+06lelV8BtLiRiV1CQ=;
	b=vz7NUodb1mLjOWMrqNiRG5F/Wq3vG1JgpeFG47oFyygLcYSMtcFeHat0GfEyWas3FTab
	 EbbnPVV9EqVpZGiOilhGqFn9y0m2PI71gNLsaOCGyCFOq1qP0iVx0+dr+4+/pXBMLEXLN
	 jTTox/FGjgod8Os2DFNSXT4YxN0VFLk2HdivgbqvMYEy7itu71Q+BGQIMi2TUiV/kcW2Q
	 P4BaemTWTASI58Lc/RPGJjpO2kJXIZB01K6p0kqnpSH489Ic1q4ZcKXIhr4tG4cDGdHu9
	 gqhqcnh5UPS5eRcC+RPuL5xGa3QcMtAcYaWwCOf2v704vthzyj8NN3fIUCpD8qpLPHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnqC03Sh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB3606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnqC03Sh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D02F1F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434336;
	bh=q6pzJekZWjm1Y1x05ARDDWi9B+06lelV8BtLiRiV1CQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JnqC03ShDwmHVWIAAg9jbfvg6RZ02Zm73/rCcukLkGCBZao8Sqdv3sZ8PWXu19eZH
	 fD6Hudi+UiojXbPUB+SclB28VGeC8fZhwJRMRQEAc92Jo2/4fPTVShiiIhagYOCzrc
	 cqflXqMnYFNF2GxCeEig6/Cux4SBj13NE/NVRD9/HkdQlNi30FwON6qi+n7cf7+8Pu
	 0y2gSLR1RVgfzvdqKRU6N5VxwDD1ryqHCEhvgBILGngTX+4BiySQMPt27De3IQTQlQ
	 poBkOr3X9+TQFlKu//iCHiaVrPJjayEYygV9bzJZ/UM4T3A1RoMvy1no6InXF0YIM9
	 z8LkN/PmMLRBw==
Message-ID: <sashiko-outbox-178076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] KEYS: Prevent overflow of user->{qnkeys,qnbytes}
 in key_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019181732.449591-4-jarkko@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 18:25:35 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add the missing overflow checks for user->qnkeys and user->qnbytes
> in order keep calculations within INT_MAX range, which is the
> absolute maximum quota.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019181732.4495=
91-1-jarkko@kernel.org?part=3D3

