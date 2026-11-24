Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536267;
	b=Cp4+h4IDCBMd2AfkvAS97yQAvQxtRoFg6bzZGpCuehQ9CZl42sKbbR/CrfMKcqli8eJU
	 IXSli4EJI51GzdYe8g4Tpy04UHZF4yjq8b0DdumNscJB3B41qlvORDRZYTd1JnBKKIa/t
	 rgyoaH46tj2KZL04OSMYk56ipVZIlkXklAVOoU4SAjbnADtlRdiO8I6gCUOd8WFvxs11r
	 eEIS2T978ulvHb8XIY163drn4AT39wTtf2C3O/GdU2J+petAGgXil8gPQLDl2LoAjOTJ3
	 pb/X68tRA2qWw3I0XmsJzwZmGHrs2sY4342F7imuWBFroISRCCohjzjAd2OX1aKdmAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536267;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LkawlzlyqDvqDdSvafqnJcN5wehj4EmK14w2vsr4oYo=;
	b=I2ZMdzUz73vr1Eo1YGsE/FdEcpuQbknChceNRPnNds7MRhjmekb1K0fyMXddnpCgEHD9
	 ncEXTxyC2XXlpQ2wSW8V5OtZvHqE1D8w8D/jFKmdNnRPPpnXFPw0Lc1xATsuP4UxOSkNf
	 xv1XjT/9q44eTZh9XWdct0LytkikrcoBa1jCn/ig8kTtl6n6/cOqCDV2h5kvWAthh/CwC
	 qzd1TkYf0aDhY4pSUwe4bBjPhV6O0CcGBzgug15g1LNQs8UXFEM7pv1Lc7C0i/qcxSLKX
	 LVPUP+x6O9JJOHf/C3YUPbCpb/py8goMuoDWbncgJJFOGPPLWvzkQ/+sFfc3I3+xUXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hB8JES/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FB606A31E
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hB8JES/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6201F000D1
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536266;
	bh=LkawlzlyqDvqDdSvafqnJcN5wehj4EmK14w2vsr4oYo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hB8JES/3hMLX3hMni1VGNFsLDolB9BpXoJ2EIBBwJh/qUIP5p97RwzwBU2Qul6b1V
	 pIJmRmQEOqDhBOfFUZFUkriu/cUtr+i0ujtpn2w42ZduTEXGeFYYQNVnTyCIFaIy5B
	 a0PhmNGBr63yo5XGpCw/CJ1Ez0us84JZn2gVoKF13YPXtBXpqk4eqM6yKAw/z2rIGm
	 wU7wX4RZwGkWV/hKfO9DDN7MkTAH7w5nymPalvss/j/IS3/y4ccmVBo+0dC4rUXl8k
	 Aq80WiNnBHftTjK6lWZz+fOcY+1K0JcwidqrZdf68IQ/kcsAlWSeJ+F/vpeiN4zuKF
	 4PxRKR+ftVvcA==
Message-ID: <sashiko-outbox-231521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: trusted: caam: propagate protected key option
 parsing errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?bGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZw==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261124155310.32044-1-tkdkei@outlook.jp>
References: <20261124155310.32044-1-tkdkei@outlook.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:04:26 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Keisuke Tsukuda <tkdkei@outlook.jp>
>=20
> get_pkey_options() returns -EINVAL for invalid protected key options,
> such as "key_enc_algo=3DGG". trusted_caam_seal() and trusted_caam_unseal()
> ignore this error and return 0. The trusted key core then instantiates
> a key without a blob for "new", or with a zero-length key for "load".
>=20
> On an i.MX6Q running a 7.4.0-rc2-based kernel, adding a key with
> "new 32 pk key_enc_algo=3DGG" succeeds, but KEYCTL_READ returns zero
> bytes because no blob was created. The key cannot be saved and
> reloaded.
>=20
> Return the parsing error from both paths. On the patched kernel,
> "new" and "load" with "key_enc_algo=3DGG" both fail with -EINVAL, while
> valid requests succeed.
>=20
> Fixes: a703a4c2a328 ("KEYS: trusted: caam based protected key")
> Signed-off-by: Keisuke Tsukuda <tkdkei@outlook.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124155310.3204=
4-1-tkdkei@outlook.jp?part=3D1
