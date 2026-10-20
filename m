Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518571;
	b=1ewQjDIo4rfSNZWj5spaKmw94tqnsKUrrqogepD71SoJ33RJw9oYVtdT2Wf/bqckH04G
	 rnzYNfC0kVV11uSz69t7sexR4z97KaEURrcO5QpM9Jexjtki/F4dTKJgQmReM8zolcLB4
	 FoHxFwOtliEae59luzk1QqGwa4n7GB2MyIHV/xyha4/Ev2Y7pohptch4qIUf9p+9GYdJT
	 EH1xhWo2Rh1A7FBqEYV5KdkPArcAWI2nRFqohyGhzcItoVURMofEY0ts9N2Aps4CmkGEg
	 GHxsEZsmNUQHsn61I8nmxvs33hKvXJn9Nw50yx0UpE0l1wBQvaMW+apKgs7SjyYGA+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d9FQhGNCvDChwFSlFoHp0u4vgFynbcPEdrpEx9tAD4c=;
	b=TKfAEusisC97vOXQfvULjprJqtCzKw8zGOyopP8sEALrAT1nYnjuQUFrGq4te8A6xcBI
	 Mkel3xEWarvMKR8L+o92lGDHi/lQRgF3dhMl4ZC5pw2w1ZJ/I+dE9/6HL3y6kVXaT/S7X
	 oaVhALe51u4tdQRKSIsHosxtZ5xa6FsbUKINwYG2trMnTHuNa4XLXA9pW1rr5SJ1NJVds
	 NX2UPA2YEsAwpLfxIeIQXwMSATUdcdcgINzjigGiZrjDBWt0EIlpDNknkfJBPcWT68O8A
	 1fI+MalDvGGgOB9YG2bj9QgikjNsmk0duIQU89+SOdP1iyW8fxHUrMxfS7cqBnimvfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWyqi6Qm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762D606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWyqi6Qm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73111F000C9
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792518570;
	bh=d9FQhGNCvDChwFSlFoHp0u4vgFynbcPEdrpEx9tAD4c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HWyqi6QmBWwl1PK0Ka5TXC8cvTqqwIb5gpZVyShHaBfbztoNxOdlYLln9zHgAIvnK
	 j5zqtShUkL4tgtSyFoFLejqvVn23ViHfNsBHQwz2NCKegUVzSrXCl74H+o4V1ghntq
	 vOkbiYBaBo7LORMQvEsCchFX3y0IvC82o+HRZ/qiIVG/WSkJw07Kt0B8RfMabhzycB
	 OKeML0v0NeQAsh3dq+lTk/mWyBXLhfmhqKtA6fjOJMEN/rl3YkcEdKYfFGFHNvAeRb
	 VHlaV/Qp/INKfgvN/r2/VWTpWPcvWO41LoBZ5CK3NFB8pJoD9zeV1TV2b0Cw0+cqod
	 fv8aSvAHrum9A==
Message-ID: <sashiko-outbox-179447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] KEYS: Reject descriptions larger than
 KEY_MAX_DESC_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261020174325.2229448-3-jarkko@kernel.org>
References: <20261020174325.2229448-1-jarkko@kernel.org>
 <20261020174325.2229448-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:49:30 +0000
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
> Assisted-by: LLM
> Fixes: f771fde82051 ("keys: Simplify key description management")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020174325.2229=
448-1-jarkko@kernel.org?part=3D2

