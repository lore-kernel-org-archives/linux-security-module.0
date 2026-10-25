Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889589;
	b=HjTyz1lrJgU7R81FApWDrUIB3njbQXBCFbfCElX3zTQroxzYZYki6rU4Zl/tB9KR5xLH
	 W4JooOWQx+RN34YwdVgcu5zeQF+Bby0n+m/ZdF4ikGZgNTxdQfyMtoh88uVQ9AvWmU0np
	 vkrN7g6XcOV3OKu4wiAkKa+kNGzVCnEOMJ1TBVcKCEBbZt7r04jO2eHWGu8vcldTCkntv
	 fKQKsyu8jrBmwXY954IBKB6TTLLQVZgHCZacb/2vj3QFQ0gGAcpPnAmzjKujq54U+mi+4
	 G+Juiu59pg2HTJ1GRT5pQzdUpbJJ0wv7gvokIni8gE9+eEoR04H21IULDv9ZELBwirw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889589;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Km6M28IinXIM5IoZOp1h4vQ4wacKAybmKhU6Xwt8pNE=;
	b=yk9TyeQE9WqPOuv3SJBP+e6UPwCCdaTUYfjnIRu2sR8N57JRssjHKVoI1nkDbti3QUxS
	 +vjQiRE49jOdSINndsErr1nD77n3HUL3c65RVvSXr16dKWiIk7IAUk0HqNja8tKq0qUdx
	 M2xnQHx0ULA4oBr6HbIGIHChzXlqdqicQ1APMqp6Dah3n4NQCWKo25mgOuH1dmqeqLbhU
	 CYyWUtz9UA5SU2UQHLIKvmpP5BPkQk5mRowTHnhLBG/n/guHPH4avBmiVgbJFuCzm6amm
	 0CT6k4a5ZW9pVB1/qbio9APECqQJP52/FhnPTdcwsIKqpdHOTB6GSpfAt++b0P5rqeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTxm2J+3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E25606A323
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTxm2J+3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDB01F01829
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 00:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792889589;
	bh=Km6M28IinXIM5IoZOp1h4vQ4wacKAybmKhU6Xwt8pNE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aTxm2J+3t86NJzyAyo2Vy3iMcrw42wbG23p1P5hBuPfk3H0/qfXGbsqz9HXAceNeB
	 xkUXMxsyT3J40Sk0xeKW98fvFQ7z9QVXJzpQBB8T2vhuNPqygKUZHkebnKCdxHDT/x
	 a79nfrkDbeS5nusF7IxM9WpM3m1xz36r+S/e83Vk6HvDsnHVuYSpxMryxBr7VA0e+n
	 +NqoGgzw9bfQLrbaAPQzjC6BPnJtIGYa/yTOSxKlt/hzR4g2sbfZWYcrmoZEHs8sij
	 jDGU7Efrg8BcOIr3qxjwiAFVU/tF+51UTHSGajV76khjXGB2vX9qrruXgr54gIED7Y
	 uyvcKu+rfbpzg==
Message-ID: <sashiko-outbox-183960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] KEYS: Reject descriptions larger than
 KEY_MAX_DESC_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261025001105.1824178-3-jarkko@kernel.org>
References: <20261025001105.1824178-1-jarkko@kernel.org>
 <20261025001105.1824178-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 00:53:08 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> KEY_MAX_DESC_SIZE includes the trailing NULL character. Descriptions
> generated from payloads and in-kernel paths bypass the userspace limit.
>=20
> Reject descriptions at or above KEY_MAX_DESC_SIZE with -EINVAL at the
> following sites:
>=20
> - key_alloc(): before quota calculation
> - __key_create_or_update(): before key_set_index_key()
> - keyring_search(): before match_preparse
> - request_key_and_link(): before match_preparse
> - request_key_rcu(): before check_cached_key()
>=20
> Cc: stable@vger.kernel.org
> Fixes: f771fde82051 ("keys: Simplify key description management")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Link: https://lore.kernel.org/r/20261020174325.2229448-3-jarkko@kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025001105.1824=
178-1-jarkko@kernel.org?part=3D2

