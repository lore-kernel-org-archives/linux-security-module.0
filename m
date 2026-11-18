Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044332;
	b=0XR6cgBjZh0mcbJt4vPlBzS0IcEXQRI4YjtDpQeHq14n3EaJfgKDeOIhaUWocU40mq7m
	 6yrdjZR14ZWduIMN8ZOoXs1kHIptl07veAxM3Ch72Liy7u6goMwdbaXkpV8yQw7aQsNCq
	 mZvHQLAOem+h+eD2ZH5MagnpKeAu5DxfH4DJUQhoyyaHCVjts6YOtpLTD0ZTfuh4MKwW6
	 AmlplTjN2gEG6PZYokRETvm3dQTDRvJXCRYwMfTZorHNwxS59rcid9j+hJAILzsk5OgPA
	 bblA+o3pteMjEIg1/DY0BqZ4TgVsk+wLrq9MVpDP8mNsUinMsE4YE3sCyULZwgIHdCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=svDEqioSRNFRy+oE4Hq/EVSrs01fmS9Z3iU9XWsYHgE=;
	b=VcgLV7G5aN0VzqC8QJ+ARgNxuBAEQ46mC4EL7Rgj+2/PcWZTdqPHUSLI+1XcmiSDhCoZ
	 5jJ9WorB0baKyXCY8UFBfHkTi0eAxj+YbxeSWEHUjfhulDZxn+4/1SITFrQocQQEyWYng
	 H9Q/1EsY/hLB2uYWSzcrXDqWm8dpjgcf41UF7S7XVtR4EOe1oIVuN+fg9xw5xR07ebLgm
	 4Oc2H8SMuCcE8wtNY/rqrg9daFKoits00l7kBkJtOrIT0GggN0obWEabeU4caRTu5aO5T
	 O8fjsEseU5L67xQjKd95VkIbalCNfZFlLPr6IknxzBoB7KF93NkxpXfWR5OZ9UGTnwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifmAyr5V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A9606A320
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifmAyr5V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52E91F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044331;
	bh=svDEqioSRNFRy+oE4Hq/EVSrs01fmS9Z3iU9XWsYHgE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ifmAyr5VVjDOBeVU4Keoiri5kmiNRq97REp/76IfK66QHkhmKGQxb3wWKNBD6Wi8A
	 a6Yzdx2SSUWuHyf0vgsyvx6/ViP0VLYNqWIIc6G/DshZv8+idHE/DwoOT4TpRsCusp
	 umFIBXAt9q6/2phffvvAbjpMNTjjmWx3nKK/8jZbis31QzZFTTPVkOr9jp6X9oJUDC
	 SNSOvgC7m29cTeBM4HAsN54JceaH92ME2XbmBAzbMugfqLanT9XVn/e1UUxc3mc0x7
	 tiG7q/P6HwixS4S1wgfxIBpuQfePpyQsnAYesAxlUVls1CVsjctKOhieYTfARlRpI6
	 KqZKatEYbifdw==
Message-ID: <sashiko-outbox-222178@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KEYS: asymmetric: Fix PKCS#1 decryption of an
 empty message
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261119-keyctl-pkey-fixes-v2-2-9e2d1c7db7ec@cispa.de>
References: <20261119-keyctl-pkey-fixes-v2-0-9e2d1c7db7ec@cispa.de>
 <20261119-keyctl-pkey-fixes-v2-2-9e2d1c7db7ec@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:25:31 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Florian Bauckholt <florian.bauckholt@cispa.de>
>=20
> KEYCTL_PKEY_DECRYPT with enc=3Dpkcs1 on a valid ciphertext of an empty
> message returns the key size instead of 0, and the output buffer is
> filled with the ciphertext.
>=20
> crypto_akcipher_sync_encrypt() returns 0 on success, so
> software_key_eds_op() maps a result of 0 to crypto_akcipher_maxsize().
> The mapping is applied to decryption as well, but
> crypto_akcipher_sync_decrypt() returns the length of the plaintext,
> which is 0 for an empty message. By then crypto_akcipher_sync_post()
> has copied its scratch buffer to the output. pkcs1pad copied nothing
> into that buffer, so it still holds the ciphertext.
>=20
> Only the caller's own input is returned, so nothing is disclosed, and
> messages that are not empty are decrypted correctly. An empty message
> is valid, though: RFC 8017 section 7.2 only limits the message length
> to k - 11 octets.
>=20
> Apply the mapping to encryption only.
>=20
> Fixes: 63ba4d67594a ("KEYS: asymmetric: Use new crypto interface without =
scatterlists")
> Cc: stable@vger.kernel.org # v6.5+
> Link: https://lore.kernel.org/all/20260919221742.3709658-1-benquike@gmail=
.com/
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Florian Bauckholt <florian.bauckholt@cispa.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-keyctl-pke=
y-fixes-v2-0-9e2d1c7db7ec@cispa.de?part=3D2

