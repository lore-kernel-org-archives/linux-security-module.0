Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703939;
	b=oqQAZSaQKhIkM4JDcaBLD58Nklz57pBmeCNmeOwEYXdOOblfRaOcZig+ubogKMhsdFr2
	 luYmkfRmuSsSjZ1qj9JJ7DkkCC8JAJm3HnHORvK/kwttdhxYA+fciHRs6MMCimEr4FNq6
	 E7yyy7mxRg3TsC6yEtyZ2oYOpRQgG6vK87Sf2ahycX2CWfLDJg0Pur/hhHUAglBsnNlFT
	 TUB3774BYwHp3gcY0M4L7X1dHvoupdrtn5MwI3poD0X2I9kFVXGZsRcuE0UT3LHZZE1YP
	 72NLZKl21TfYUuJm6inS7pv4rIL7TU/tFNB5v4kccchcidaXJ0HOOpEEop1BCqDullg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703939;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S8Elhprq9IaSoaQTI3SK8rOYLEiC2ss56k6iikp1Gkk=;
	b=DeNwSrBXAaT2gbCMd7qzgxP5+D9PEm9SMMsxuR4jjKL3yN2jh7JTbNGHAb5Dx/mMYotY
	 kRCHae4Tdy3QjV3VsRjJtvyVtSjAFso4ZcAOak6IbVYRYL3AqgQalUHz1oOmm2U08y+6o
	 WuVBT2ZFtNuh8+zugXNtSK31VwD39M02iYvfRsCsDo7VU+uKZQpNBLuyTZ2jyey2kO8u0
	 0hT1ytsl4PJJZ/RCGTH+fUQHnFmld0PqKtVuaS3kkSSFg5MR1BqrBmj/HUITYB9eQeNVP
	 19epgAMCxD3FVCwm/riHtjkmSCD4+O67cNKjTcOSy4wO39da9mlBQbkoYhXfZwwcmDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK19TyOE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE1606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK19TyOE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296201F01825
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 21:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703939;
	bh=S8Elhprq9IaSoaQTI3SK8rOYLEiC2ss56k6iikp1Gkk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AK19TyOEPjm09xJbycvQuXbONdW2uKsmjvS6Q10UnCR9Tgvo3QuCEiEQIGifKQjj1
	 apdhkPtBV3YwwAXYqv6LukpCJw4KWaBBVGWbGoiaY4XmBhP0wJK18eI3kd9+Y6hcTR
	 ygiXQ+jc9jc1SunPxuz4XuQtJDC0SdFvGfb9TXNeewBRiNhXKd7f9rRV7zLM2KDEj+
	 DDIGtyM4bi2XczMRRWVPgKXDIMaNoSGID2eDn1DW+WrknNZ42tuln79mqy7ivUmSad
	 pzguB9kSMiCof6yi7t6coh+oy3mMqZDG7HxFewOIZRLIT4WVgm+EmdIa03Ck1/c1Th
	 8l+TpVCBxzcww==
Message-ID: <sashiko-outbox-182056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fsverity: Explicitly require FMODE_READ to retrieve
 hashes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261022211522.1489943-1-ebiggers@kernel.org>
References: <20261022211522.1489943-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 21:18:58 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The comment in fsverity_ioctl_read_metadata(), which justifies not
> checking for FMODE_READ, doesn't consider that the nonstandard access
> mode 3 (ioctl-only) exists.
>=20
> Opening an ioctl-only fd generally requires read (and write) permission.
> However, there are gaps with certain LSMs: an ioctl-only fd requests
> read (and write) permission via security_inode_permission, but not
> security_file_open.  With certain LSMs relying on the latter, such as
> Landlock and AppArmor, an ioctl-only fd can be opened without the LSM
> granting read (and write) permission.
>=20
> Since FS_IOC_READ_VERITY_METADATA returns hashes of file contents
> blocks, it should require read permission.  This also applies to
> FS_IOC_MEASURE_VERITY, which returns a hash for the whole file.
>=20
> [ ... ]
>=20
> Fixes: 4dd893d832cf ("fs-verity: implement FS_IOC_MEASURE_VERITY ioctl")
> Fixes: e17fe6579de0 ("fs-verity: add FS_IOC_READ_VERITY_METADATA ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022211522.1489=
943-1-ebiggers@kernel.org?part=3D1

