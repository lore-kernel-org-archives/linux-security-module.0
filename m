Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284453;
	b=GmXIls+FAmcyRvJrUH/fkHeR/5fkg3k55pYH8QTRgrGCS+KVyjwzLTsIZ4srR83PT0+Z
	 EzSORR71TISYroq4KLjBtX7XribhpPd5DI8HTn/ZLxBSLN99dOb1E1MsfiLLsW7N0PBNE
	 1DUlpDl/ustA+SIG2fT4m6J/TQjhHFw1qSulPpFf5n+bul1uaM4Y+X4oSqnZ5cFPvy42B
	 miAtgbclNa/TkonXMrXYe1hcbMbjMGYoBcB1s4u5/L/YUllcD7C6+YOPa8c1RkUPHBdTX
	 26X74ETdmFlqH+uXrdb/j943Rtiqo9096mjeV+k+7K7a2WwlheqlOhpMYYGi9w7nOMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N75GM6JV3IGplKJi2i4PSaHp2gUTRYn/qtH9tM/9R0E=;
	b=jHR4XAR3AdR4yVFrUXijTkfr4AK+4UFD5ZJf86P9nDVNFEQyHCq8o7KgMGmVSqVCkmjH
	 Ls8d8VeHUBDtnNEUe9rWoU9zWwH8pWGzG/xdqro5SEYt0Wde2u7ah9q43UfzHAwa85wPV
	 62pPxChbTXA6e3kRdu0wlIhqHkfD/7xiNNdmJnf+40NYpy2Q49NV5a2EeXfG6p+AuCY3N
	 eF2a4xHP+U9XLxOT2pGFqzbrWygZ9hV2o2Wn2a3jmbrIHUe1OFeWYndmLzOghtKncz8j7
	 rHiSL9KqAN/X5CSXe2sx7r67aAdNiYnOT0KcfixAI0g+iGubGboF2k7wBl5SHEW/WFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnivEmJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4315606A31E
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnivEmJO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073521F01825
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 14:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793284453;
	bh=N75GM6JV3IGplKJi2i4PSaHp2gUTRYn/qtH9tM/9R0E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LnivEmJOTwLBamkiauChcyg8+dpfkCERY6lpYqsN2yAeZLFXWN5n6X/3njlxOpRg9
	 CFSbBsgZr+IxwVUl3cDVW7tSAnUmiNApOIw6LmXoTWHOi1jk2EQMjPTxgR28JMtPPO
	 5rCZDfnRDNYnSKu6J79dS+vWCrlOIByxWiDIQwGS1JBZC8QYsNDqvxXbT5SBO0YWSg
	 JDexuXE3xUw/qyWPtkUUBHGKl8L116Fn71Rf0j/S5DZvDmZZ25YvkEGydMAJCHy1Us
	 N1wrrgR+gsl7Truqbd950a0CPFjQI1Zdnt7dXegLsZcZ0KjBoyNkID7VTN+8u0ZqSS
	 1OeKyIya919PQ==
Message-ID: <sashiko-outbox-189529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] evm: Bound writes in evm_read_protected_xattrs() to
 buffer_size
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029142707.2602008-1-roberto.sassu@huaweicloud.com>
References: <CAD2AHCbuQyKwR27hNcYRhU7njCeigmQoL9x9i25zb0N5-8Kx+A@mail.gmail.com>
 <20261029142707.2602008-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:34:12 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> ima_eventinodexattrs_init_common() calls evm_read_protected_xattrs()
> first with a NULL buffer to obtain the required size, allocates a buffer
> of that size, and then calls it again to fill it. Nothing keeps the
> result stable between the two calls: a protected xattr may be added to
> evm_config_xattrnames through the evm_xattrs securityfs file (with
> CONFIG_EVM_ADD_XATTRS=3Dy), or a protected xattr may be set on, removed
> from, or changed in the measured file in the meantime.
>=20
> However, the 'n' (names) and 'l' (lengths) cases write into the buffer
> without checking buffer_size, so if the data grew between the two calls,
> they write past the end of the allocation.
>=20
> The 'v' (values) case passes the remaining space to __vfs_getxattr(),
> [ ... ]
>=20
> Fixes: 8314b6732ae4 ("ima: Define new template fields xattrnames, xattrle=
ngths and xattrvalues")
> Reported-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> Closes: https://lore.kernel.org/linux-integrity/CAD2AHCbuQyKwR27hNcYRhU7n=
jCeigmQoL9x9i25zb0N5-8Kx+A@mail.gmail.com/
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029142707.2602=
008-1-roberto.sassu@huaweicloud.com?part=3D1

