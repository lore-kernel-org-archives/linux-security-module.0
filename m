Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434203;
	b=GuOTcM1RAg2GVnVqy+rsnv5RRowTkEkbgQlxY8PX8gnX8CERmv/jnBowMoos+c2hDtiY
	 EgS52eYswIr2Us913YEheOUSYoI698RT2uVL/MUb15kBFRzMANvbEs/MvqxTOMlW2UdH7
	 bOKUgSG/pCwejShVeOCt0B/Zr4tPQa+yGnJnX58jUinsw9eiiHXh+VVZ1ue9YC0WUPdKz
	 z+P48Le7abugRDfWdVg2iXly/OBsyEYHx+sZAcIJ1c5dhDFgD0b1UoTl7BTlVDWHsL4Ex
	 u9La0xrdNjGvEMAGHdg+jfmGLtcneRZlz4E/x41G6TjLhQPCADrvpx4tZfd6TvekkYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434203;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UjSCaYd73gw6wLG1XooQw5qzLSuuvd5y31RAa+KDPOU=;
	b=RurmNMEznL64Ef78lfTDAv9f8cFhrK5cB8xl+kkvC76vQzWBeaJpzNopjjBl6YA7jeZ/
	 b5STsp3EXxVeIHXNc9pWwAlfD88iqlw/ejsPvqETXCMRvSj58FZne9KDyaamBLS6SD3A3
	 xrnNqqbymqzyeYK5WjrCB8fgrcJTqMMrORC9oCqmES/GAU9YjRkbZPgOiMjPYujC8sGfh
	 +8rPo/PmiL3/j60x2lwfpxEI4VdnTTZj8kPuHejyyXNM/KvZDCtIsKf5UniwdziChK0NS
	 iUby4BieGq1SFIq8i5uviLrywReFwf4EXQ8E9d8UqBvsyt/OsmrbJJ+qwdDm5OeIANA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTfa4EGz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A55606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTfa4EGz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D2C1F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434203;
	bh=UjSCaYd73gw6wLG1XooQw5qzLSuuvd5y31RAa+KDPOU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MTfa4EGzlNy+Uyxt1D1E7WijDMLWzpg14aeiHAWKDrSJ981zoO/HJ7/lGCJd61Eaq
	 G3BVY4mfZjZsbUQQ6/uNfjmV5LTDT/7HzwdRAa1MDNKRHObSwSYWvaCArss4Vct1IC
	 Rba2erqMuCzrHcMienub1SiSW0zUoEqMvFu+dKSord8aEya4cuWhLQNDQNdKvsmtA1
	 XwMK1Q9lA3PsC5CbYySERWjnzHuVlSpHTLw7Dke+TWZ/DnYKJbgjkqo7Hs9m/Iban8
	 v1V9Z3/3ZLRPSYQtQA7IzIvfbCn3SB5kLsIciByWTyVpC2NGJgILchiYLrqib6b0p6
	 8MeU35FFIlXAg==
Message-ID: <sashiko-outbox-178071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] KEYS: Prevent overflow of quota in key_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019181732.449591-5-jarkko@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 18:23:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Check that the calculated quota length does not go over INT_MAX.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019181732.4495=
91-1-jarkko@kernel.org?part=3D4

