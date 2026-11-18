Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012390;
	b=kFDN4nmZS27R53Jk+8UB2minwkeZVYi1NVQlibw4C/B/V+FS3Q7zA95jcjAzbZ/l6cCz
	 6nk8HG2qQo/S7SrOR2W/8O6A/HaT1fAfWqnIcPswx3pWRySplUOI/52BVQOwZC2qYv9qi
	 W+gjrHKIvFmcKShAG2rZG4xJoYk8nEWWS9zRwv20h7YXc15XqMAlwwASWdwnwpkalZQjb
	 kVS26EsC44n0OgE8RpQj9CkkrWY25881lH0Bs/newdcaJVNc4nFTzrJ0M/4s03qoU9DMg
	 yE4iQeTJt9ZSzNYHybt9LVVvdCqg20Mg8YFqQAuvgP0nPulnTNE+pggaKCB0U76/DvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012390;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j73gTsbVfLHwn5hGckfjtLdUttk5ufE6oIaMmBbgci8=;
	b=rlPqaxHtplzNxxTRPElzWvSJjBAzRq8PaPMMoB69frk3Xc5/vsDwZfHfelBN6TzriU52
	 svo9ciRuieNKGX1AfWvy7QEdAQQrbL96UjayS8awXgDjeTcqjouUa8evm4T93eYCMgu59
	 vBXAqpDZgI57YS9tGjTzwIxc6TjfmWelAkBT2kl+rKQNS5wwXt0mbnmJNo142qXaJMS0a
	 e1MGYZ4/aSgdrmciwCOHqmwzqsW5A4NrjQhSdo9Dj+l8UhXocW3UkvlRQueLSBdlvBvCP
	 OuuM1ncNPzEgy3E9tka/7yFYKEnY+1Ez+3WGtbyvFpoib+0SzwCWSww5b4HO+tkjZCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8dasVgW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7697606A331
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8dasVgW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971C31F000C7
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012390;
	bh=j73gTsbVfLHwn5hGckfjtLdUttk5ufE6oIaMmBbgci8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=X8dasVgWfL2aoUC1FB4JnrrdwdMqW9n5bg7BbN3dFDd7O5tFKUpTvto+t4CVGQjIw
	 OUgcDMg9o72LQxOxTkfx1qighmeZmFHphpyLKWnFORN8tMQP/OKFykI+JIyjeqR3Pi
	 Ppd91iiv+E/slzVXKOqoQPiCTq1FD6i0rTxLtMOMAwFQGSZfGreqyOG/eC+VwP5WP7
	 qO4aGEfHAw3iCtL/6jQtWcl1fKOHblv3YELMqvC7R/pvZWx9P4t8mDUZ3BnaBOwkJ9
	 oeRte3AA/vtscHCzRcpk2G/FL7gE84nFf+zp2EfDuavnfNxSapyaVhE02VJqoqfrFL
	 KGLI0tUbk1Ewg==
Message-ID: <sashiko-outbox-221218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/9] KEYS: keycrypt: Add a key type for keys user
 space never reads
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118140421.584086-2-giometti@enneenne.com>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118140421.584086-2-giometti@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:33:10 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Programs that encrypt, decrypt or authenticate data with a symmetric
> key today hold that key: in a file, in a "user" or "logon" key handed
> to AF_ALG, or in memory a compromised process can read. On a device
> with a TEE or a crypto engine able to keep keys, nothing lets an
> ordinary program use such a key through a kernel interface, with the
> key fixed to one algorithm and purpose and never released.
>=20
> Add the "keycrypt" key type. A key is created by a backend ("new"),
> sealed from a key given in clear by CAP_SYS_ADMIN ("import", behind
> CONFIG_KEYCRYPT_IMPORT), or re-created from the blob its backend
> sealed ("load"); its algorithm (aes256-cbc, hmac-sha256), purpose and
> protection tier (kernel, tee, hsm) are fixed at creation and
> authenticated in the blob. User space reads only the blob.
>=20
> This adds a user API: KEYCTL_CRYPT_OPEN opens an operation context on
> a key, a file descriptor whose ioctls run the operation in the key's
> backend, as the documentation describes. Two system policies come as
> sysctls and boot parameters, both one-way: the system tier, a floor on
> the use of keys whose starting value is chosen at build time
> (CONFIG_KEYCRYPT_SYSTEM_TIER_*), and an import switch.
>=20
> Backends register through keycrypt_register_backend(); none is added
> here, so a well-formed add_key() fails with ENODEV until one is.
>=20
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118140421.5840=
86-1-giometti@enneenne.com?part=3D1

