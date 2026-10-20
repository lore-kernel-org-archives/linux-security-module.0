Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460663;
	b=la5qOgu1rxddCY2HMw7tv2M/q83D8u7UIrNDEQ5FMEGBUqfvrf86IQp6jtI2U8YpJz9Q
	 DVaVjfGHJvsYBImN7L4IcevAjKPwq2GlVsTWXn34/qUSldpi90o2ksQ1o25gIv4KDlmUR
	 /caTw7AihrFCP77bC6yad+fHAtEFUpoAaX4YnV1bIFPpdIW0VQTrPBC8kfjqJ368wswD/
	 rP12hcNw5xtAE2+Egr9fglvLuqoYroVJC+gzZkFh2NyRsNIUVPIUAMTfsLJlBG1DYd+pp
	 nEd5x4jODLyAxffg4s6hrQp8/+pK34H0Klb/AzO3/bQ2BA8q2NyQ3xrswJFeIbEFMVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460663;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G+Ou4j7z0wvTBzp9G1mpqS/th6Zs7gCCDrqWxbUqtJw=;
	b=A76z+XgpDK91paAh28znMmzFLcXdYafqsGRMBP9ZE+AZTv9G3Fp4lFCwQTzF0RzxtVel
	 4IjjnKJw1gb4wWGIvK5x3eY09Zo8ky0KbYC5i3dqM5bjCWh1KMRLRQf1p8LNBfMlcVLgz
	 4vPu0LH1lx3rx24SOTuER5OL/4E81qrDaio88xRnB6lhPW9BMuNdVftt5sis4bJOzeCIu
	 5r9vpcNpzRtBfyX6Fj4Qg4yUt8xfCHKY5r96fQlbPskIeg95VfU3EOSWenhveot2Etz8W
	 UeRkhyjPCb0ibfxAPqX0G9lJgGdCgMTZMbSlAmUso5B0h3xeBCtRzvr17dr8i+TUzuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLfKzAEb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FD606A319
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLfKzAEb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA64F1F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 01:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460662;
	bh=G+Ou4j7z0wvTBzp9G1mpqS/th6Zs7gCCDrqWxbUqtJw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mLfKzAEbKnN6SYlDwqyWZ47hjiWQkIMyCAPhpxhgLA4nDW6o1nhUTvAzyerb2w+Or
	 A9OjtuJRsaW+7eNR2Slzxt/2Nw4kw2uWTFE5YwwHTAYrR4O/mGvHQ1v74pmCkUxRwG
	 0TJrKIXtBNpj98RYX1Om4YlMNTG13CXfOgtAOcbCsbb9nTzd9NUAcr8eEvoZOqcByS
	 dus7/BzZqWc+fUj5WVEFC1oyrRXY/C9oBSmU0ybS2nPSqURxLHLTDsjEwP4S6bhxGZ
	 sB5jH6Uqg1FIeMdnfjTOoMgC6Ny/CzkCY4MnGkucSFOizQX1FsUGLZhSkrcF8dorJm
	 +bVERZHltM17Q==
Message-ID: <sashiko-outbox-178413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] KEYS: Verify the key identity in
 __key_unlink_begin
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261020013903.1244157-4-jarkko@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:44:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> When two keys have identical type and description, linking the second key
> replaces the first in a keyring. However, attempting to unlink the first
> key (no longer in the keyring) unlinks the second key.
>=20
> This happens because __key_unlink_begin() calls assoc_array_delete() with
> &key->index_key, matching only on type and description rather than the
> key's identity.
>=20
> Example:
>=20
>   keyctl new_session >/dev/null
>   keyctl newring ring_a @s
>   keyctl newring ring_b @s
>   A=3D$(keyctl add user A ss %:ring_a)
>   B=3D$(keyctl add user A qq %:ring_b)
>   keyctl newring R @s
>   keyctl link $A %:R
>   keyctl link $B %:R
>   keyctl unlink $A %:R
>   keyctl show
>=20
> Verify the key identity before unlinking, and return -ENOENT on mismatch,
> instead of unlinking the key with the wrong identity.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020013903.1244=
157-1-jarkko@kernel.org?part=3D3

