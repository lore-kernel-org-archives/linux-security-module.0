Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890386;
	b=g6gPFa4amZWUu8PJ9p+rV6CaRJCgK940HNYpPwvRGlAx/GdKrTc2tbFV5L9nmHQnGArs
	 fw9KX0dMg2AkAhxNrti7Jd9pNYyEtOpFhtC7fKQE+YVLQkTsgs+Y7wReWrZxx3lGqnkB/
	 IdlcZsHYbFkQG06Px3as6seBo+GasgA4/HO5CE2Mk6soXHaT0/k5pn9fCkmL/YN2y4oOi
	 E+iKmXP9kaxI8Jl2HInmRKXk1k6YSMyLjEUXWi/RqKeNue7w7It5DFM44pkjIY+7By1Jn
	 OznDIM0IZ2BicT7+TCBc0E0Zh783wmJpBk5NyWgTZdf6V+RGsCAM5rLXkY88SoDKWFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890386;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+6Frxs6rS1KYbetbG7oD6detBnq4Hec8my8RIdSRVCA=;
	b=kWfhGehtUi9wgHm5jBPgsG/UxHCWZh5Wq5IUlrOac+sbv5j+bLiw+BzAxpgbeTosdBzH
	 ZqS3XiBnIKbJmmmRSNB6CJmS7oFqrbLB4+41PIhCQLl8R+tovOXnz1ysDeHCbosgYX9Rc
	 ItmH3OO9ZKV++ZgJX6UfmF2FEfyzLN/vO8EN+oZWQA1ZayciZpZRP5lnopeh9pQhlZcIZ
	 g03FvryrHaeyVD0ojy+XlzN78p1OZR8WrbgQb/gxPVu7+jO6ZjUWyJjCAsk/LJL0xWEHb
	 0edFbtz5XRriid3Jd09KmltqXN2jT0xTNT2l84uhSRxZRT9XZ2ojXzC5TOb+x3LxCWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZOJaFP8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F869606A326
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZOJaFP8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C321F000C1
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890385;
	bh=+6Frxs6rS1KYbetbG7oD6detBnq4Hec8my8RIdSRVCA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CZOJaFP8oR12U+IabCl8teTYP4T9JSK3vpt+x0iAipFhmPA4kVanL7+mf2kMhxy/T
	 yAStaPuEt/KRHpbaK9J1bHmJZfuJthBW+lf65psnkf15NgkJVILeJ9BmR8K0HcE7F9
	 6ta4tIetYrHmcRsIZV2jpVeFPUUrjMRL2gH2Ciy2xA4ZHWXOhjFrkLurgHIQnu+uzx
	 6y/+NU8/x3sfXQCuuL32uBmPsrcUgAO9Lw9aKFd07jVHDhw5HOSAo/7+D1hSFgv+oP
	 GFhrGcFSLiPwt+SPsE9rBQRor11TfHqng5G+Rp9AgzPfjMHG/O6OxysTv95ZL6zmoM
	 rWfuq/zj+MqFA==
Message-ID: <sashiko-outbox-199271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] keys/trusted_keys: propagate wrapping key
 generation errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105144320.357260-2-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-2-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:53:05 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> plpks_gen_wrapping_key() returns a negative errno when default wrapping k=
ey
> generation fails. However, trusted_pkwm_init() returns -EINVAL for all su=
ch
> failures, discarding the original error.
>=20
> Propagate the error returned by plpks_gen_wrapping_key() unchanged.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105144320.3572=
60-1-ssrish@linux.ibm.com?part=3D1

