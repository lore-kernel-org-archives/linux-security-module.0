Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754169;
	b=IBPVV/FztcO2HfxiFtBpYWTCXjebOlHEpqQDt0axQrGBc+D9++GYj4dXGE2pST6Wo8eB
	 6jwi7qSV1h/m8AhjUiNP+JboNoUjHJPpz7+rLPU9eHC5YgRL9N7OV0Og9Ob6auR9LLYDE
	 VNIPwRTeLqzxELqCzCn2OTpGqKDl/MQI4ZN2yFtpaNBT4AdBYogHBK+GpOruFYpmDsnpv
	 ArI1l6W8adqPWVocfdT5hSoiYscjf6lGIfmx+jrAJ0Rqil/q0mTkYph/o7+OCwu0r7vU3
	 piu+7xXqAIthZayzqAoKGuJjquouC2to6xs+B+2KHouSgCDHsQOrGVh3WSUtuPw3WaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754169;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iauiOs20iBA3VpbttkU/Vvoj9OLAQdIn24yIcgp6rsQ=;
	b=tRR1vkzwRF75Z12pqT76wvUl0a3xWyI/csdr5jYFLIBVx9xQqQUoWclkxn6kLZ6GwOWE
	 FMTjG3n5nz0Sh097n2BFTgr9Qy4rSPm1665tEVbg1YgVZbox31waRz5bmegx6MwMT9OST
	 siek/vW4k/4z0IZ7UN7zVem3ibOBDh6nK1hAT+QZP7XWcOB84cIk1p/IRyE/aNAIBqJsj
	 4wqL/g9u9fkbsAPOxB8fc8wQv7uU94JyEgRUYRlw+DDCfU5BzYpUGfzcspxn4hUMTk6O7
	 B0PTzzCU1juDbHfEGGEj4oZ2BS6tCHoW/1wZOzKGbrKdUJZTGpXIBjTNl4Pd84wC1Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cde9vpsO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB2606A31A
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cde9vpsO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705691F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794754168;
	bh=iauiOs20iBA3VpbttkU/Vvoj9OLAQdIn24yIcgp6rsQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cde9vpsOho0ici/Dc/emxgSP9Iiwv9vS1thiJ7aBQ9TiU709/IBs/jzHYX0CbkQnP
	 8wdby6VpSzB8atxPrEQ6dbh+6HM3PKzGHvzO4KIrOkCxmkaXPlWvRXXMCCzBkANxns
	 BKH2CNYEdbkjmhgUbbTSxAOCQJyJwend7p+xsopMwLxgYCPN/pW8F1JovwnqQpAciI
	 dPoTtFDcHC6VUB43pU9DTztl6+Ud+URyro9oyVGrc9xTEW/Gh0YCIgEb8rLaNfno/m
	 lO6c76ckRPVrRYaOK+uud9jr7SDvze/pJNpqbNRZ2tZ1HZRWIlGxa1CbajSnntyojl
	 ErgAAQiBikz7A==
Message-ID: <sashiko-outbox-215591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] ipv6, calipso: fix data-race in calipso_cache_add()
 bucketsize check
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115144508.71543-1-jiayuan.chen@linux.dev>
References: <20261115144508.71543-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:49:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Issue found by sashiko when reviewing my data-races patch [1]. This is
> not a plain READ_ONCE() annotation like the rest of that series but a
> real fix, so it is sent separately.
>=20
> calipso_cache_add() reads calipso_cache_bucketsize twice: the "<=3D 0"
> guard on entry, then the "size < bucketsize" test after taking the
> bucket lock. A writer can flip it to 0 in between:
>=20
>   CPU0                                    CPU1
>   calipso_cache_add()
>     calipso_cache_bucketsize =3D=3D 10 (> 0)
>                                           proc_dointvec()
>                                             calipso_cache_bucketsize =3D 0
>     spin_lock_bh(&bucket.lock)
>     size(0) < calipso_cache_bucketsize(0) -> false
> [ ... ]
>=20
> [1] https://lore.kernel.org/netdev/179428999963.994134.169045445008900536=
68@kernel.org/
>=20
> Fixes: 4fee5242bf41 ("calipso: Add a label cache.")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115144508.7154=
3-1-jiayuan.chen@linux.dev?part=3D1

