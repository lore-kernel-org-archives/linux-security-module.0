Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761385;
	b=q65WZhUmSQ87yHsELzJMn8kdTzf73Z+64adxKZF+12aN+HQHhNz2wQtU8v5NH5kxxgCZ
	 YQPvyuNPxqpVlUM3Jm3y+zuMCV8RRSg/MLzKpX8ZVLcrsvFWGTWL+LPMDrAjEdy9zAzsN
	 TlQL0UsNeIPjxpgKVJSqe51HN52kgGzjrnWTAOZETXLTTmfDbD3E8opgrO1CbERsMmTnJ
	 BOIE2Dhd/tVgdYFcCqdc7aKj+4i+jaCTfqcday9AkxKb38jue8bNaYqRCx/sfcR32uQE/
	 qHRp2c+q24FCEgJyD+lfYhJF1it9AVkAQZlFhYZrPK1qrVlKB1gmbRTrqZohXbcuzIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s/OvMH0f3ANIkZNB+14YLrbB70X7p6/tAlDbmNP/Tdo=;
	b=JV992gxfaaIMbnFnT1zHNidPwF1Z5itbur47nSfchrwI94synTAEacOJMU4JmOOI8qfX
	 5dbJgMjwsklY/slydd7PZajBmZI1iyGTgRyJpaXiT0FUu/FiXFIPqRWZrJKQb40EhU5Hp
	 tBtokZaRGEYq/UosNYSNJcP13tRDo1H3JeshwFtMrrWrPLeVZn8+eMRRC7oRF7zbuLrGY
	 ixeNtrD3qzM/GJr4R5dPuVEMGJ4XYb8rY7aAzt9KcGPZ8gK1gfsYRzS2VCTyvZtPI1kUW
	 GzEbarY2a9JOk1/7WrZ7akuaVYmELNPzEhxwnTBLGpaTUk/sj4JLmxWzp1oqgnu683g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSLwS9Gp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B3606A329
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSLwS9Gp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C151F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761384;
	bh=s/OvMH0f3ANIkZNB+14YLrbB70X7p6/tAlDbmNP/Tdo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iSLwS9Gp6aBzWEl2p23Wd8PRaM2FCsZvnJ8np6TRgrNMJ5x//UoiO1n22nZ51Dc6v
	 AgXQy2+iu7bao62eU1cM/yS4ZmaAcqyFrmBi1db5Qrr9aIaGu7/66zt0Js72BzOGGR
	 45hHWItaeyJT2cUeIGYPbm0zP3SSDcwrrm5/JsevWNXy3JUADZvZQxiiS2D5H6Aivo
	 Ex3F8KtGXZ312wGy0E3y0nP+VoZYewie+KdPCLbMJqCyQjM4oQlEQ5rSujySe4mTnB
	 Bn7ZAf/3xY/jyLruE8eQ4u0Bs2nO7kwia5+N6hrcttlHHNhuWNgE9XuvxnXUZB+vNW
	 CoE5fzwXGEN+g==
Message-ID: <sashiko-outbox-196568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 04/11] NFSv4: Clear idmap keyring cache when the
 last client unloads
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-5-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> id_resolver_cache->thread_keyring caches id_resolver_legacy keys until
> nfs_idmap_quit() tears down the keyring from module_exit(). Once live
> keys pin the key type, cached keys keep nfsv4 pinned so module_exit() is
> never reached after all mounts are gone.
>=20
> Track active idmap instances under a mutex and clear the idmap cache
> keyring when the last client is destroyed.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D4

