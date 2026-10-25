Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889497;
	b=Jif4fiviEGNsWI6CBX0a90xjwEtIzbJglYi/HHCaBvX6zMtLQQZRFySOsOTNxi1qV22b
	 pOxN79LE1ZuTsysySkSrrp5IOdkGFX53BfTOooUatHqPAcGXOi6aCDoLWvgCpTGdEA14c
	 hixK+9QrBHai7VRvoQiW/XdvnBULI/DnLidoaXBdAkxdwHii0fy7wc4DrhO36KHvlXCzF
	 izk+xqlwBoZDd1Whs6ZWaq4FIx3gYSPji2J+WKsC6H0zjkyezwEIYRUnxzA0O6YYYwZ8L
	 zl5ILLWctgO2zzHHsjdDeHqNyvq0m4LO3zCcafCZ3s5IpuhOGUNoJTvHAR9xO1n2SBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889497;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q/zgt+Sd6MvxoVr2vqEd6hxQLHPg9HGGAKLNi5IwZtY=;
	b=q696MrvH6shK3Y1EbuyEoC/JuXoVbnCk+K1fwBQuW0aRo0f9r+hXxoPoNBUPfszQV9Lv
	 BSxlSwO6K7isq9JMAFrWSwlae1u2p4cKC+Mp+Z9NlRMk/zSARiIx9QqnpehVuv0kk1+EA
	 dKyfNfr/CCRvyTHaWAbKVA2Mws5E2G+QJ+mV8qeC/MeBF09V5LmfoHYs+Hbsrz0KpSH+B
	 nt8afDKnioFECebIVfav/zX8Fua6DyY3xQHBZ54hEOCFQgceVM2nCatrIj6p7FWZ5iVp5
	 jN8FWrXhLSTfnfrR0ZhxO8ozpSTuXGeo+6hY8+jRGEu3Z889E+GK7cYcbweMeT0FQrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0z9zTyt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9E606A31B
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0z9zTyt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296701F01828
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 00:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792889497;
	bh=Q/zgt+Sd6MvxoVr2vqEd6hxQLHPg9HGGAKLNi5IwZtY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=S0z9zTytxXWnDG6HpjrlEmSjFEDQk6vwJ9F1ugEkYmVtO82HIb8fZ0OGyB+ktEy/o
	 S1JQvRfrDlT0TH8QDp3I/8m+WbYoxC12fp8CZV8OZoVnXXdMmV3+nFW2CEOdT2pvng
	 r5zsThzdmK8qIsKiLZ9yMoseHFI2bPLU55pUlxQzPp0afABzXaDRffyfEbnzoyqech
	 PTm3Vad/1BDS6FjCg0gkMScIbRZv9vaGxhteH2YnnpDD2gzmyLzf9I4C16Zy3E5W6u
	 TtA9+r/aRPiYisxqoURuT+snK2kMPYXLKA4Qal4hsmUKknUbG8XgFcIEObRx/tqzSZ
	 6/045xxZeiCuA==
Message-ID: <sashiko-outbox-183956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] KEYS: Introduce keyring_is_empty()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261025001105.1824178-5-jarkko@kernel.org>
References: <20261025001105.1824178-1-jarkko@kernel.org>
 <20261025001105.1824178-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 00:51:36 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Introduce keyring_is_empty() in order to decouple for dm-verity and
> fs-verity how keyring internally manages the keys.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025001105.1824=
178-1-jarkko@kernel.org?part=3D4

