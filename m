Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011269;
	b=1Tfy9seRKSymKMGPxblDrOldpLKX9hUW6QQ4n4kf/MKRN77QvV5CNg7BnCFu3WH2bqPu
	 RGcM8YYunDIGeli2CBhG+S7VO6QQsYvN4OoIb6w2G7qpnUQRji8Lh4/Iqz1dTjXinAuxD
	 lfL6ey5P6hDVgl6kyTFG2lbHo7QUTzY0BYpVBsGsQqoKgM1XtetjQvkWeAljFAnxkxMIg
	 qsLUYIDITGUuiWz7SrstidN3qahNIm+d1v9RM4PR37/o8/hX0VQyrkEAppQryw2/zQJ8s
	 8pqMVtyuwe64Qp2UNPJt1hy0oPUcC7/4UNW6ujAVnqnPb/jntEr1yNUZbTkc3ynFh5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011269;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O9SmVOh1SnrAPQx2CmxrjX5S2NEplFoqLnzbW46FOcs=;
	b=CiQ1JozG3GaLGvixS1OZeFcwJmw34hoJdd/yQAx0BZhIw+fNDnNSp1P8zwTFtaisupAx
	 nHMCXgK/v/ng1MYvyXTtOY5kxdrg52XoVroor4UX1o1WEmRew5f75G9hnL4D92smjpaUS
	 aKcBjlLPJI0R/vR4Hu8WqcHunPjAbQlVqTfsKkOpvu0HoIN/IltnZiySBI2uAfinYEwMF
	 xkRvtAwY7YnQYDGbAoLYhdZkB5bVtxuSjW+b4Ru+T0TrtZ/oJjMCNd+A1r44twyx4yV7C
	 wyVYe2ORKf0hfc40wnENNDGwl5Uy573envf6P0cs6U8cQgJ6Q4MpGsPnR0yd35UX/jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkD+jw1q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C68606A31B
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkD+jw1q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB03B1F031E7
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011269;
	bh=O9SmVOh1SnrAPQx2CmxrjX5S2NEplFoqLnzbW46FOcs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WkD+jw1qkwNG682DV7CbPOfSJ32cZEn+QCJmpucqOfYJSvUCu/8Bfm1T7cLWuB0en
	 riWm4qJGorE2QMZ58+Ag+zUawlUHophkwO0hiXyW6oGkdzltN2Ge1AtZD9KNOavUKD
	 RUAbgyVcE8sIIVLJ+C/25m2c8Cl50uUhJb68z0sD62TQ8C5ECsyi/jgoW5ACxIsz6t
	 sgBbjhnur0FfBRIzU/WoVPvwz8S/pvMFXAIkKIJ67vB0ImW5YaX6Y+r6VhmF/7wgwM
	 lSaWTNJmKR8ov87tWwsRKjSmyZGx6aLKKqpJhxN/w6R/dnW6XOOzVXAkhiuCpfzxTy
	 mDvb3GnBo8Qcw==
Message-ID: <sashiko-outbox-184981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] bpf: don't mark namespace_init and namespace_free
 arguments as trusted
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-work-security-namespace_free-v1-2-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <20261026-work-security-namespace_free-v1-2-ffa3ebbf71bd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:41:08 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The bpf LSM marks the arguments of all hooks as trusted unless the hook
> is listed in untrusted_lsm_hooks. That list was added in commit
> c0c852dd1876 ("bpf: Do not mark certain LSM hook arguments as trusted")
> for hooks that are called on objects that are only partially set up or
> that are already on their way out. The namespace_init and namespace_free
> hooks are exactly that but they aren't listed.
>=20
> namespace_init is called from __ns_common_init() before the namespace
> has been set up. It isn't in the namespace trees yet and for all types
> but network namespaces even the owning user namespace isn't set yet. If
> any LSM rejects the namespace or if anything after ns_common_init()
> fails the namespace is freed right away without looking at its reference
> count.
>=20
> namespace_free is called from __ns_common_free() when the namespace is
> torn down or when its initialization failed.
>=20
> Currently there's no kfunc that takes a namespace. But once there is
> one, e.g., for namespace local storage, a program could take a reference
> to or create storage on a namespace that is about to be freed. So don't
> mark the arguments of these hooks as trusted. namespace_install is
> called with a reference to a fully set up namespace and stays trusted.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-work-secur=
ity-namespace_free-v1-0-ffa3ebbf71bd@kernel.org?part=3D2

