Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523148;
	b=NFe5pqLJbnA4QKyHKcMdmERbcGkN4DlmTeVRYtAKSkbkIPULz66qNUC7k0ruuXleJLvp
	 3K5odaKPilc2amIwrneklO8/EljlEZ5rMQTZwobNpApCBZEk8ZP68s0q6egEgg6lmd6BC
	 750eINlabMz6t7TJScwFBQOhsrXRUIi5H4gTjrd2AjZi5wjggM3igfP9ulFn8xsicQzaj
	 fiIt16Zq2TCIvg/mOs5v+CFUrWUZ6iqv3ycey364lAWoGRlyRhXOFQQEBYThmMmEryYPc
	 WKHm27ZHCJ/hrlC2E7i9g9aN27VkYI1zRPxV05GcQV5jSI5fKtT+MQUbsoRq8pNJ+8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523148;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ujAUg+kIYn4w+xd2n+vHeaS2wpmUyLkN9w+gxQCjgoQ=;
	b=CBPJAs/3b3LKkgkmhUA9fm22V+QzomfuKy/xMoZTu7uB7yqtHOTI9Jhhgeuo5K7ZUwqr
	 lqCPy6o8QgIw605MnKytoSPW6h0y5vL7MRpagRzqCNUaEi0rQNAG9HtxPiyCqezAd2yf/
	 zi8azgd2+gWMiWTyderzNSPSlE2koBtKlL93bZh9Smc+8qXix8X9ZT5D/lak9//smpJid
	 PuEbwa1ctkM7TzrkVc0eBIWT3fohdiF3Uli0Uz9Dpsey/7OUR4mFwQih0lhR5HJggdEpx
	 PsyXGstdrQ0CeiyHfRLX+S0pAr/u/nUSXU9InhTAvsYqtT1XiAghzUcdfEo6wyfvPZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbJ5LrqZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF803606A32A
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbJ5LrqZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF44A1F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795523148;
	bh=ujAUg+kIYn4w+xd2n+vHeaS2wpmUyLkN9w+gxQCjgoQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UbJ5LrqZtgXts8RImKjyATG2B36FjtIGU+yTBcBYqOFDp6A+rfvGwBMwF9LbLrXNq
	 Lj7RhiaRw//tDAOd1odVew0EO7akBwyqWDqXGrskEHG0wVFww1dQ8zkUnHKDTSvTE7
	 MamAiq0OoSXCtyQtzGtsu2VcFTOvn2XN+/lgtU7pRmeMNIk8mKWyDsO7grbP4nlfEO
	 mY7qydakRzZ79p8dU86DrfJFUrEQTc0Uc9khqdr1ovD9TB8YwBGoFx+CyVqjQzhrqS
	 RisCjCiw+lkLELAyYEbDl8WUGbcmF1BE21DVWbzGMd93mJsInewWWird0BVKCrBiMk
	 9CKEKzgi50pBw==
Message-ID: <sashiko-outbox-231132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/9] KEYS: trusted: asymmetric keys
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261124120044.1481752-1-jarkko@kernel.org>
References: <20261124120044.1481752-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:25:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 9-patch series:

- Patches 1, 3, and 5-8: no issues found.
- Patch 2 ("lib/asn1_encoder: Add asn1_encode_integer_bytes()"): 1
  potential issue (1 Low)
- Patch 4 ("tpm: Add persistent hierarchies to tpm2_create_prima..."): 1
  potential issue (1 Medium)
- Patch 9 ("KEYS: trusted: Add asymmetric key support for TPM2"): 2
  potential issues (1 Medium, 1 Low)

Detailed reviews have been sent as separate replies to patches 2, 4, and
9.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124120044.1481=
752-1-jarkko@kernel.org
