Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761384;
	b=KWPSP3/e948S+HUKKX+i9t7B79Kbet3tyEcLqGJ/4zDz0tvaz2pmglqXfXkpTR8svl2/
	 qPTHQ3ve2IhwKVcqgBn0BzFkkKIvnUYsLc5bFilx3b1QVcdGtwXYoWrVXA0JV+0sNV1Xz
	 LpfY+NWrhS7l3AM+D8/4wkGYMiMYfzkjxJql4n2HoIEzzlzfzwJSgKhGkLpD7L+vPL6xu
	 lHHZrFsLnnAub6GaGfWt5q/s7eT5wdkMP6tFjdmuxtCDkLPY7SZBpXq7SONSvVgWx7RlF
	 +grl8u3lRn6LFHcpjiTcNuoFB0DYY/QY8ynQxJsE65aBbvKbezJMhKTXavjC2+iG6UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761384;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=td0PIYOHwZFm9qWBcFaPspD1omWCe3JU29/9KGBD7mg=;
	b=CJcmPEBbvrjshN7IHNxYgKAlD3Bm4xFBApxjemNkSmm5A/5W4Mdx6liWlpWBkSzeHZM6
	 OscR68+jkXoUGpioC4L3y+atjwxB6fkL7EwnhxreZ3QDOiI1FtjXxQ3w4vcZogBN8OZp9
	 yg4gphBi9cdgo+Dks0R32YFg42xJH0Q2jJOoMYHW+zw9DwYQpQPGvwHIlr4C5hgCp0Ub9
	 dVz0Q8hLzCleBB137O2LMrGMGNv0ORMu6RdN4sqNqwlpIGB3jidfh12UX+ome6jxhx/T0
	 Zzw9H9PvwZsRk209wxcFUyBHvArEBp9yQjPaITrQ3wyzHC4UE7B0P1D6seK1iVWBZ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmaRVcjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62F606A32E
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmaRVcjD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ED11F00A16
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761384;
	bh=td0PIYOHwZFm9qWBcFaPspD1omWCe3JU29/9KGBD7mg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fmaRVcjD1BZRACUTxfjQmBHuDYLsYuloykXPnMn2xOAi7Cu/trmr3WVRqBlafX8s5
	 U4lR+RsDGDMBqcKdELmQtSI3DFrVqpOUn9j0FZyleUiZAJ+X6bx6twIqolcKj6bNRl
	 tMHwxF963FbqwUNVHTcDogX4Ahwhk78Uq3CWeg29RGPSrRa9WL2LJO2vzA8n5ZBdgr
	 OPk/ieujm12cjY5gZmOEgf5pNf4DHvmp8DYVR1rfHErru4tMFGPHPA0WG50YnIu8rB
	 y382TzP/0xy0tMznYLImH2nccNYGyiACaziV9WIpsUrnxUpwq5JuMENJY+Omz9Idem
	 9uxZbPI+lACGA==
Message-ID: <sashiko-outbox-196567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 03/11] dns_resolver: Clear .dns_resolver cache
 when the last client unloads
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-4-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:03 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> dns_query() caches resolved dns_resolver keys into the module-owned
> .dns_resolver keyring until the TTL expires or module_exit() revokes the
> keyring.
>=20
> Once live keys pin their key type, cached entries keep dns_resolver.ko
> pinned after its client modules unload.
>=20
> Track active kernel client modules with dns_resolver_cache_get() and
> dns_resolver_cache_put(), and do the necessary plumbing for:
>=20
> 1. nfsv4
> 2. cifs
> 3. libceph
> 4. kafs
>=20
> When the last client unloads, clear .dns_resolver and flush key garbage
> collection so dns_resolver.ko can unload immediately.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D3

