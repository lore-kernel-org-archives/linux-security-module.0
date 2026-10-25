Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889620;
	b=y+C5E2j8oc+A7KN111CYklFP3+uGq4lLn8MZCJaHGsn8XpfUcZIbVPtvWHyaxUXjL7o+
	 4ay7zZgYBtRnhSQtAVRTpRwYVwTxaOEKTj/pSoH4VZrZVTeVw8uoDO3pA85Z3fuHlnVUy
	 CvK4JYu15FeMcdNzSSliykDLSFpxyu26aae0wisrhg9TNwB7E1mR3a98jMVOJg9oXR4eJ
	 WG+QxbwNkXPUUevBw1XLgzJnB+jaXGiK14gnb0gURm5qxAkUa86SdD3CTEXw2GCymWQZu
	 VksPpKm0KkjuCexI8VYJXtcljka22OS5VYFY515v3vK+PEXb0uM0PFbhIZ5Pk4tPVmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889620;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i/Sa5rClq660EBgs8OXvxmdBN9bAycutCNkmT1xIPbs=;
	b=owhLZw2qEH27Ytxzvo/WKeCljK6AGcKW/7HpzpwjAKdj2a5tEvhVx2aj2wnwoTTLmGbP
	 mSauO55vzzCgIepAWNMD9evzaovQMh/zlB6pEjzvRLphHMIojL2saBMInZOHnTtAt6ZOC
	 ShQdIDYH2cog0RrRDPBuUpzsziWFHqxX5a9H49SSkuubSdF4ERaka3dAqMAg9BErghXH/
	 5mfw7qpQHe5EdoP+x5zPGwwuEAeYPbcwaCCj8dTTdxxFBgmFNfZrh9xC1EuEtUtF6Hf7Y
	 VTGjrL+fmAjO75LJYtdNyi7z8EZOIuX2eqHV0CFJxHXAmDAQTI2XmurZ8+stxZxCX9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6ZkzcVO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74250606A31A
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6ZkzcVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21A71F01825
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 00:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792889620;
	bh=i/Sa5rClq660EBgs8OXvxmdBN9bAycutCNkmT1xIPbs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=d6ZkzcVOVT8De/OF5K1Qlt1GOlxZ5ZcSl9tV8dEGn0GqU9yVf6Wo6UHsTXD6wTKnL
	 CsseP0gAi8fIEDb51OeasjfPGLSRYwaTvqzpfk0zewD8iUmnmGc3fMM2WIoqCsQ7iW
	 V2j+aUOmHw1+ExYRbf7YzgVfXTfUE36UK0ylW0seuXuDUWINyOp87CVy4z7EQ2F0DD
	 PJWF/kvmwq8GO2KvS82Z4BnqNTqiNybHPCJxPcAxTPS+HNjwtJPuoKketSHpLgpjBd
	 YiNBzRdYi2VqNley/CDSLUY1jpPv5zL9xczIoOfr0kFX+FXgF2pTxcSI7fffdwUnWE
	 pyFzdXFK375ww==
Message-ID: <sashiko-outbox-183961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] KEYS: Verify the key identity in
 __key_unlink_begin
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261025001105.1824178-4-jarkko@kernel.org>
References: <20261025001105.1824178-1-jarkko@kernel.org>
 <20261025001105.1824178-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 00:53:39 +0000
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
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Link: https://lore.kernel.org/r/20261020174325.2229448-4-jarkko@kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025001105.1824=
178-1-jarkko@kernel.org?part=3D3

