Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426576;
	b=u6bYGH/OifsuuBKB1qSqim0C+T1VdCJ4xEBxmfg6zoOWTgsRqIAwJLwT39ZUIyra7roP
	 /3fWzQLBkNqTfxmDYHsIokhVOCZtlTPNPCHjM52MdHhDCB8XlVrbFl/lv4RrSfMHxJZP0
	 t++fLCacRJBTFBbnFxlNYPqPY5myo2X0wIQG6jTSt8L7LwfFcgCWNbZ8os0qKNJ6WgwSj
	 6zPRilz0hzVC/OcC0nWvXjCU2W0xw+xOqgEIE1iVHYugDXpVfb+1b+9Gfgir51TOwJf7I
	 8pb7zX2nivy5JMXCy/tKcuVRACFuDqhMSmmVflNY0pXhxED7gnssQ6HyOX2u2PyXF0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426576;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RojD5i9RE8rjAIMaA4bRRNE3UvbYKN7pQQIZ7hckK6Q=;
	b=N84mQKtah/OAn/KIoehlykDCC4u2u+8Kybzey48/56RtKrSnNKVB3jIFzCrVYg/3DKSB
	 KHIEnx/C9zN6toJurfXuN8Srx3ZbXE04BjKX9irmN2L4Fq57m9QGTaQA5br+AdwhhHJXK
	 kSQI+Cn/O7eXftgsIOnVwmxHYyAY4hhub8MSaWV++93bKAn9YEWnkuI9Pk4CLSt1yzBDx
	 BPNkmOGJa9o+3hJyn8eAFGDE14hbIUo0FL8jtYP9L794w+d9ya5pAWq/aNaYqkmejFSGo
	 iDxEitG0Yc4nkYe36AtSNDaBzZIES7Fpbo4lXcACGKLXimgzzKxQOv9aX/5O+nv1wMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RorrD42l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA3606A32A
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RorrD42l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544C01F000C6
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426567;
	bh=RojD5i9RE8rjAIMaA4bRRNE3UvbYKN7pQQIZ7hckK6Q=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RorrD42lw3GPmKsAO+TLamV6wf6vE1MqFx9oRk3I4bzy2sIwPB5VDpNleHiBuy0qy
	 VKhmM/M8Fxjy7irTbT5CdyBfsKP0cP0w9GBhfsEgu5GAQ/25klNIpOCr8m0uUiaxSE
	 0/P/set/gleaU4OW7DOiKf5YCko8T6lRdyKeFVf3hjPhrPDRo8SnBtuqKip/AofMES
	 SFXXf5R2lUipteFfKg2L94YtXQlrJVspnDJDNn4j1w+EgBRnnjl3ZZH1fiY9uNOO4o
	 PLPITa+OPqWeiJkdhlqTtqk44ZMGCpgULtsUHnPDDbTCD4IaYYIlxBLfyCN/cFz2xj
	 a1/vBlFHPuXTg==
Message-ID: <sashiko-outbox-177853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/8] KEYS: Prevent overflow of quota in key_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019142516.300040-6-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
 <20261019142516.300040-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:16:06 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] keys: u16 truncation of desc_len in __key_create_or_update()
--

commit ceebacfa6e4fbe645d2fe96b70fce1be4e928c92
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: Prevent overflow of quota in key_alloc()

This commit adds a check in key_alloc() to ensure that the calculated
quotalen does not exceed INT_MAX when combining desclen and
type->def_datalen.

> diff --git a/security/keys/key.c b/security/keys/key.c
> index 2996a387a3553..24d1c33ff87b4 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -245,7 +245,7 @@ struct key *key_alloc(struct key_type *type, const ch=
ar *desc,
>  	}
> =20
>  	desclen =3D strlen(desc);
> -	if (desclen > U16_MAX)
> +	if (desclen > U16_MAX || type->def_datalen > INT_MAX - desclen - 1)
>  		goto error;
>  	quotalen =3D desclen + 1 + type->def_datalen;
> =20

[Severity: High]
Is checking desclen > U16_MAX in key_alloc() sufficient to prevent u16
truncation of index_key.desc_len in the __key_create_or_update() path?

In security/keys/key.c:__key_create_or_update(), when index_key.type->prepa=
rse
generates prep.description (or a caller passes a long description to
key_create_or_update() or key_create()), strlen(index_key.description) is
assigned directly to the u16 field index_key.desc_len and passed to
__key_link_begin() and find_key_to_update() before key_alloc() is ever
called:

security/keys/key.c:__key_create_or_update() {
	...
	index_key.desc_len =3D strlen(index_key.description);
	key_set_index_key(&index_key);

	ret =3D __key_link_lock(keyring, &index_key);
	if (ret < 0) {
		key_ref =3D ERR_PTR(ret);
		goto error_free_prep;
	}

	ret =3D __key_link_begin(keyring, &index_key, &edit);
	...
}

For example, when add_key("asymmetric", NULL, payload, plen, keyring) is
called with a crafted X.509 certificate, asn1_ber_decoder() caps the input
blob at datalen <=3D 65535, but x509_key_preparse() constructs
prep->description by hex-encoding cert->raw_serial (or cert->raw_skid) via
bin2hex(), which doubles its length:

crypto/asymmetric_keys/x509_public_key.c:x509_key_preparse() {
	...
	desc =3D kmalloc(sulen + 2 + srlen * 2 + 1, GFP_KERNEL);
	if (!desc)
		return -ENOMEM;
	p =3D memcpy(desc, cert->subject, sulen);
	p +=3D sulen;
	*p++ =3D ':';
	*p++ =3D ' ';
	p =3D bin2hex(p, q, srlen);
	*p =3D 0;
	...
}

If a certificate has sulen =3D=3D 0 and srlen =3D=3D 32767 (with distinct i=
ssuer
and subject so x509_check_for_self_signed() skips signature verification),
strlen(prep.description) is 0 + 2 + 32767 * 2 =3D 65536 (U16_MAX + 1).

When __key_create_or_update() assigns 65536 to u16 index_key.desc_len, it
truncates to 0, and __key_link_begin() immediately hits a BUG_ON before
reaching key_alloc():

security/keys/keyring.c:__key_link_begin() {
	...
	BUG_ON(index_key->desc_len =3D=3D 0);
	...
}

If strlen(index_key.description) exceeds U16_MAX and is not a multiple of
65536, index_key.desc_len truncates modulo 65536, causing
__key_link_begin() and find_key_to_update() to operate on a truncated
description length before key_alloc() can reject it.

Should __key_create_or_update() also validate strlen(index_key.description)
<=3D U16_MAX before assigning index_key.desc_len?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019142516.3000=
40-1-jarkko@kernel.org?part=3D5
