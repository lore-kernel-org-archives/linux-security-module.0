Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427010;
	b=gmlKxmjPNSrMaZda7yemKwmu6nhkusk7MLG6iQFIwmoXyUEWmKXT0HeK4Ryx1U1HP3jy
	 wROoWcz6ymAe6ByA2MVPrTVSnb8RCnHHGLWlquA0pmXb7I+LEfWxtfYJS2yo8d5jlmBMC
	 6TZ33EoKARdmR9Uc+FxCIbtAjrTZqZVuoFqjFrtzXU0uY/FJof+PE0sglv4tvZbzc1HUn
	 t1YivuIOMIVmfYGRIKHTGwW0MO1hHYrDvmoTMZO2f3nG7w1cFs7JbdeRnq8ULm7ERQhbR
	 ywQLGv32RJDf/v1N4NpZwAIqXJ+rRcMDUY/ToqX9vFgV1QxMs+ds4fI+cDK4d1sxfnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t8LsP4Mcem69S3npEwb56bDlaAJaVxEbndvu/T5wjIg=;
	b=iv4xYK4EQVxLWTNXIYtg47IQA0okLmv2mO/Lwy7c04QAG3YmsOd+k/dfht+oqiYcXa4G
	 J39DNUL0Dpp15ZzrNb35LWNYnod6Az4sGMRnJKCHCL/Z561tTATKLCitlH71Ue5lcVMuD
	 8NGaLNuxmUEWpc1pIvkGCNOSZcOtf6kspcXpRgR3GxSnUsOMe19HzJluJGPFByyhejI8e
	 T5Pb0xepdyHL9iQTlWtK1H6+GdD5F+0ihKMZ+RqEQ3e7pfyHAPs67SxRrZ7aBZETaaLma
	 HBRldqWqneQkPe0D7LzkgANVmg8+71gd3PjVFD1VfVi5mfLppE7wbVXMcZPpn03ffSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is4ov+Sg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F34606A319
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is4ov+Sg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91361F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427009;
	bh=t8LsP4Mcem69S3npEwb56bDlaAJaVxEbndvu/T5wjIg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=is4ov+Sgg/P6YjBMWAgt431SOY9YfgcDdWE2Y7q4uBPaC7yJfL4hQ6YqRK/oMnzKZ
	 aXz2GxOTzn4q/lb2fXgw4yR4V/wTd9lqk0dTvhpJGwmiHre8sVpab1yn3CZ2K6IbD+
	 gW+TwuLaDTOgSGSkjFfUA3Ok9Wnv4re/Ir091cGlhtSmq6qW1tnSC+JegDuXiQqr58
	 8Frps4Qq58W9GKy0g7waeZ2zyvhduheWwubr7b9wgzJOQr83AySg/m6oPrG5yTequn
	 uUd/XTHDwZ6gJ475LTAx7/YS1jwIATEPVcjSyN3LdpfPKROgmGxfKg+WPZ3EXR3kba
	 NWK+5Sr8WMcyw==
Message-ID: <sashiko-outbox-177876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/8] KEYS: Verify the key identity in
 __keyctl_unlink
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019142516.300040-9-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
 <20261019142516.300040-9-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:23:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Let's define the following preconditions:
>=20
> - Two keys: A and B.
> - R is a keyring.
> - Both have the same type/description/domain.
>=20
> Then:
>=20
> 1. KEYCTL_LINK(A, R) =3D> {A}
> 1. KEYCTL_LINK(B, R) =3D> {B}
> 2. KEYCTL_UNLINK(A, R) =3D> {}
>=20
> Instead, verify key tidentity before unlinking, and return -ENOENT on
> mismatch.
>=20
> Cc: stable@vger.kernel.org
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Assisted-by: LLM
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019142516.3000=
40-1-jarkko@kernel.org?part=3D8

