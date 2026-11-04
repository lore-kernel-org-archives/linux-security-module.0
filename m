Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761390;
	b=HerkQn5bakFFGGufzU1fsvHGLZtMr1pxmSlXUSHVQUVbu+msorSOJRbBrmZdwTPow0EG
	 bVHibBNivrQnk6+X4Zqzs5ykltiyfwikPzNaVleM2H5UE2OJSQWINULVoEJtlYoE5OHPl
	 xpBmwEh7jVmrp5RXueauJmVKAL4R+T8umAoqPv41uL7gzzP4TkTwWUj7qlwqnK/7yyxa0
	 1L0Yf7E8r3Br4wiz65uhr0/Pey0xHGd96y/jldIGy0MRs8X0Pm/Ihmy4v2TuMz8hx7EW8
	 pGkTjVupMGXNIIvuYUqBvc+3jEVhABz0/Gl0g9aT2XzNF1SMnoSpitZVIRFdVKgq+2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761390;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N3Qp+RSHxpj1QIthbH+5Tl3w38jwvFw7YB0Sv02EonQ=;
	b=H/p+SBZse3KKtzB+QRrB/wrW3/FipmbA1yvMk3gaS08Ggusgh/hQOV8eVsfWtavfyatD
	 BWImzanu54A6zyIUfPYdMYiJNFSl5gRqxwsFLrtUv54Jp7tZx+stDt0xslMLEFrSM0H2l
	 sP2DKdo847jQBF7JJHpsvRsaxqLOTgBHHD3/2I5ITyYl9fJJYAKsQQrx1pX24A5cmD909
	 QMj2AJvIPLp9P81ZpVx+W7VD0sULtyZ/JJ69yqhdK6mlHpd3KDbW7zMhkHypXwpIuRwDK
	 OzpamMmv1i8ZFTaVluAyiUtEeV804l4ykM9gEj30M9wAPUoBPiU3f/NB9gUHrgf/YAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O8qR/nu2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB398606D81A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O8qR/nu2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5681F00A20
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761389;
	bh=N3Qp+RSHxpj1QIthbH+5Tl3w38jwvFw7YB0Sv02EonQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=O8qR/nu2d5FUz5efjtsjiS1pdwIdRDRWoqejq3vZ+i8dV48Pt+qiKS7tb7axsRATl
	 hHFXkUOurIItUZ1hVcVZDAc7VaWbAmAcPuPUOOf2GHEgYeVRrVHZ8iUS+zW19w3z2A
	 k3AuJPrIu6DJwP1MlLyTwWOP1xGXAh6LaDP5da5lMduy2QszcYKxgXI7HH59CKf8z6
	 VHTxffj/6hybSkDFXYes/o7ECO4o+xJnWvNF1XyM8n4J6BS8A9iAvozrpxyWSSd4L2
	 HtowLIyZGKcVhUfjjqUjJui7ufM3nEGup88y3SACKsnfoKBpjPpQ7feBIsPamffwYp
	 xKc7w1T3ODfvg==
Message-ID: <sashiko-outbox-196574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/11] KEYS: Remove key_type_dead
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-11-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-11-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:08 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> unregister_key_type() no longer needs to retype live keys as keys and
> restrictions pin the module while they reference it.
>=20
> Remove key_type_dead and associated code from the keyring GC.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D10

