Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012237;
	b=0YX0Yyes7+oFDBAwUXRnPOWjUPuVGlOzWBBY9uFhFj/pr/UtuOe/zNaNJB5TDPeV3Uh/
	 qVqrSBfhfrYvRXTaQ3gJxK2neQuUaEXvrE2DxaRda0RIX0dQFEATBNmKG1VsBLlvvi+D2
	 t3dWZu2fAM8QBXPil7m8h9TV5kbDAVSNf8ZBbxNR+fehzXU+HcItFnFvOAqm7HWRJzqcP
	 ne3+CMaC4vw7845+Yst6VIGeVCLJvXjpaKvbryy/ww7PlF8cBP8cupozz0VZzbu/xZl4v
	 jLqP7+vtIh5mDd7F9DBAz/ziKSKK3MSAY9L4q2dUVUP3rCdamev3b+Zjw2AGJCA99DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012237;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6xxceG4VccMBUtPYOfenWVyO2DxXbSf5kgGc80Jd2vA=;
	b=0TNIhD/346NIoJeKk9xmCE4EeeBFFRsTTxcnLx75xRvYRR+t6kVb6P9jSGlHCO9jmpVh
	 rc/SRPsgObp2PXJuZU35ItZbCi5CTk1SXyjjHrC3Xp7qz+dLbZSMWMqfxwKEcfrdCJjg8
	 X/Pc2BPPlsgf6WcHbpDxaTggSf77Df1vdJat4YJoGNG5Ji/YpsT9MLVlHSrBf4zV7ayeK
	 FFUfhtUg0dYNfM3QWYnm/26DzSN3vsD6/Qb5ghz00TodAdLQ/ZgOShni68EaXBaPx7DbP
	 YtfTqvnjvFg4wZb+HAX15fN26EjfmKxeYGYF+NX1/7fdHae1plxzQ/27tDIIno4HOlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=En0cP1FM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE12606A320
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=En0cP1FM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDA71F031E1
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012237;
	bh=6xxceG4VccMBUtPYOfenWVyO2DxXbSf5kgGc80Jd2vA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=En0cP1FMWwlMJ7w8Pi+GalW4ZlDymUoCakutRrfcco/jO+Navg+6nnh47DlfhzQym
	 jtL30koV79MMZg11FAeSu2EcPdZA9NCIBzxDVsr9dwnVzee1RpaVakfs/oOMP2XXB5
	 OsZ8xYU4Bib57d2AGUg+427QiNU2VWpKM8lcplEEgO293XLnA0Q7s+SXbd4PL3UKhm
	 DvSIGJRg/CjTXf80KS9QGvnENeXwt93Ret8Ri5l6cKKISGHp4r8viiSPhFLsk4C5FR
	 jfBmRq6LcTna9Ly2RO98hc0b+ecVoBvU5k86ZOmz3Rs/SEgTKYk1v2JTZerwiY4kn3
	 MoaLc0UF4zKIQ==
Message-ID: <sashiko-outbox-185030@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] lsm: fix the security_namespace_init() kernel-doc
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-work-security-namespace_free-v1-7-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <20261026-work-security-namespace_free-v1-7-ffa3ebbf71bd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:57:16 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The kernel-doc claims that the owning user namespace is available via
> ns->ops->owner(ns). But security_namespace_init() is called from
> __ns_common_init() before the namespace has been set up. Apart from
> network namespaces the owning user namespace isn't set at that point so
> ->owner() returns NULL. And for init_net with CONFIG_NET_NS=3Dn ns->ops
> itself is NULL.
>=20
> What a namespace_init hook can rely on is the namespace type and, now
> that it is allocated before the hook is called, the namespace id. So
> document that instead.
>=20
> No functional changes.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-work-secur=
ity-namespace_free-v1-0-ffa3ebbf71bd@kernel.org?part=3D7

