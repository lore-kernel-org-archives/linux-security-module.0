Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373162;
	b=U9+Yibw1JldcWqU1O/vtlcxx83huj0hlojc+k8LSsu/IyzNc7FssaN1lqIzZgOAk4ACV
	 /uA33LuKf48XO1r3nhV7DvMb8XpnvLiGxF1zyx2cB9EYtsW7bKAJZgDxxUvaV8sLdTI77
	 vuMoGe9zKeOESzW5+AfQQXDv/BBDRrf7YMGxUirnaUi6u1+1fIBVQ93k0pVwyMSIXOxLu
	 PI13Ccikp65RtA884g4BSS2Bqu1O+EM9YHclQAxG+zwfPCyEIGgWmKLHBvfUB1ERw8yBl
	 HiSvFEV1hMW3TZs1ScZ7hLvkgj7jZ+JwqMFlJMNGXTlJgGAKXSqxK9/CLONXLAHjWsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373162;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VrMo0MJK27KjXYMADnhiXvBuZ10Oo7vTjRY2u+0t+Zs=;
	b=w9D9fdpZrgBhM/ZC5Et7l64aFbeblreZULwwXSnPIMUBfcJvr5DJqZGHVtzLfdugS4ym
	 fLT6GWc29nPJcvZjRjnAox3a2xMrVqEV67u0a0bYIcR6dtzg+179YJj/JnvCwe/0aWzUA
	 pPMOHZG0rScR+jGQjF8A/mZqdIiVal55pOqxxCZ3uH4XU+sbk0uxaXjXcQHffPz0FsPVu
	 vsyWuJaNKk6WDqnTQaN1I8reQuCG6abSE6wGZqg8shLaYFFU2d41+IK7nDf5CZOoAWhhn
	 xE1zddpNjT9gkdGPcIaJ9M6Bms2mnhdlyTXwfO/0oW9VTV05/Yr7ZC3gkwPDMyG4wpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d3K5/VNH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57F606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3K5/VNH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A5B1F0089F
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 04:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373161;
	bh=VrMo0MJK27KjXYMADnhiXvBuZ10Oo7vTjRY2u+0t+Zs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=d3K5/VNHFbkrhrLHRiLlsXU3GHOgkdfoMPzGyhdeKK36W19KiTcVikN0l0iMHp0RT
	 d0RRpm4FBcs5TOuv7CChzvBeRGv9jc/r6uzhzP61h2kn/wZ/BQAzCaCC/8yCqS8INb
	 uZbEx+kVjKQ4m1g8M9X4BmHy1lM7BnLnljTKOIbZPhm4W6SmOUXkFEDhTWc3dDpLut
	 LaCPP+pWoIpMbcvPfsB1WgEkKJho2/yTN1I9+cBwXmnozy58OFGtx4tCFewekCUyYQ
	 ullbm9YJ1zUShlkbjOp0pRhsj9o2WYx8EY+UIgW2k6nGvi0BEFhOh8eE+dxZiUnZrS
	 7aURJIe5q/FMA==
Message-ID: <sashiko-outbox-208320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] landlock: Fix landlock_restrict_self() failure on
 long executable paths
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261111-landlock-long-exe-v1-1-588cfd174a10@samsung.com>
References: <20261111-landlock-long-exe-v1-0-588cfd174a10@samsung.com>
 <20261111-landlock-long-exe-v1-1-588cfd174a10@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:59:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Daejun Park <daejun7.park@samsung.com>
>=20
> get_current_exe() treats a d_path() error on the current executable as
> a bug. But an absolute path is not bounded by PATH_MAX, and d_path()
> returns -ENAMETOOLONG when the path does not fit in the
> LANDLOCK_PATH_MAX_SIZE buffer.
>=20
> An unprivileged task with such an executable triggers the
> WARN_ON_ONCE(), and its landlock_restrict_self() call fails with
> -ENAMETOOLONG.
>=20
> The path is not used for enforcement. Record "<too_long>" instead, as
> audit_log_d_path() does, and create the domain.
>=20
> Reported-by: Dwi Siswanto <me@dw1.io>
> Closes: https://lore.kernel.org/r/20261102022018.73143-1-me@dw1.io
> Suggested-by: Dwi Siswanto <me@dw1.io>
> Fixes: 1d636984e088 ("landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain =
status")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-landlock-l=
ong-exe-v1-0-588cfd174a10@samsung.com?part=3D1

