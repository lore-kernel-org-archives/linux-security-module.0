Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446605;
	b=LMGSYSWI1xmjzDFeIf6FfjaQduOpleFekHgv3nRRl8zBIx0osWpXykKMMhdEUpkJcRG4
	 DgzOhbsXLvU0ynE2nvAdTLWMWCrshssv4SMNNaHc3lumnh58bivb7DqGxV94KMCPvgExz
	 UwR5Lo1XSBGGd49+j16uUqrdH6pmkKu43/FwCVS7dP3IN2daGMB/KlVN/J3nHXIdzjiEY
	 JMADrBZqBAaaQsR2fwapK63PAkvP512EmQYWQ2JunznNqzJPOe1WQZr+3pt5qWmLQguf3
	 I4S3uJaRxq1MNRqRF3TPBZ9oHU5H5pDjxy4cl7sKcUoZPHuOky0lEp+xdbHuGlOvbvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446605;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ukRfUYPbqlSldT7wtoLTXA5lk1MjoDDmz/VymKtc4Ak=;
	b=gZ8+9QndHw+g8VbpMuDsfvpfSaFKHMRhAXTYIfmDnoJSdvQmiFty83TmVt/FfJFnNUTS
	 ojFejDbWuusr6UKhDNHKMUFzPDgPCL0F03TuOIqTvuGPT5vY6nDVY5U8ov/L4V38tEOgh
	 Gt1Pa7E5FBOb0gGyeUgFyjZ2JFrGIm/ARuvTh6Su66nFPPcSxup7wzZKqGdr/RVl5/Sqz
	 zYbmo9zTXI+e/gfj+Uu4UhnWWmeyLi+NS8fJU6LNipJvpAL5WEN3kEFprhhdpLtLOREcj
	 VonzXZ1U4aJo8tbnJAndCg6EcX5gut4LZwJjdmJqIqEZ8e41gBc9zM7Wi7iYt+poN1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rs4iFl2a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B544606A319
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rs4iFl2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0471F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446604;
	bh=ukRfUYPbqlSldT7wtoLTXA5lk1MjoDDmz/VymKtc4Ak=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Rs4iFl2asBk6UkOGZ9/Q4Nn6kkJaegwwaVhqxXmDGgv78Occ5ob26DoL+vYlLT0FP
	 JAN/KUrUEwsn03MvUrGeS++4jpDZR7k5m//A4O/DVDwIvPmMQ1/HlGq68YeYQp42K+
	 yKyvFKG4u+8AUBjJQvmNwB2l2zDY6U7UR9cBrAN+RBl7bCR+y3XCX/UEMMR3KxVcVA
	 d4ufNsNy/twGqg3+IMsh2lSVe8d5HRT0hXwY3NBcsOrI+nTiZOCimETnH4p7Ir3yTl
	 6wuR1T7fk/h89RWgq2fCu1XyUJGOrQ/wlyWN6JlWRGRIJDLNk101BgLOqftHC+sBxv
	 uLQtLWCnJUKkQ==
Message-ID: <sashiko-outbox-178276@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/4] keys: add KEY_SPEC_IPE_KEYRING
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-2-156f0b93e843@nvidia.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-2-156f0b93e843@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:50:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Manuel Huber <manuelh@nvidia.com>
>=20
> The IPE policy keyring is allocated unlinked, so userspace would
> otherwise have to scrape /proc/keys to name it.
>=20
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-b4-ipe-key=
ring-rfc-v1-0-156f0b93e843@nvidia.com?part=3D2

