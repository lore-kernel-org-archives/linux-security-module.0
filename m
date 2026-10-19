Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434641;
	b=uoHzmkQMlG/SkckGix8yFqcUYpvgM4OYMYbqoOj49VVwX7roFASOMPfZ7ep/PmlJ7+0L
	 Q6aaYeVPT6gWAGtIOvKsaKK3LpwrQ6je7hN/iqdI7Oh/LWOX5gipM+FrgBSu9M4y4XCES
	 cAJvaTCinfJKU+nwqACIYOOKNL2z9dl2O2saA7I2P0cTfcyKxh+Cav9uX38omEuKW1YHP
	 G9nW3T218Ebwtu+oW1HGuyfqAGeK9y0PkK7zXei58ocohIPEoDI5A9Z65rx69VY4+Mgsh
	 6C+11QrvdikLOoKTN+zTW7fevTzLxxvkY/mv4y6YeMAg29b/ydqjU/ELCWuz4nrvt/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434641;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IiERdvXgyJxNTYbete+O3PXMPJrR+KVSjkT2q5yz/NY=;
	b=SVA5Zt+9fwcT/1oE/RhwDIXf9ZSaEy7vx2yD00igiBzVl/R/AldrzIpXUNhfY/au+Yk/
	 JCyRJy027IiAOFvaEDwYFv3hpoofUNl9NBqvjWphPEp0V9OThUBP4Vi8DttQwWAUBj7x3
	 Qc9wIb9ITaH3IEkBsiujFh/YVqk9LgXMnYb93/uHoCURa0qpsgZyPRGR9tQZ0tv5TcM5+
	 2TalmUuq0JcZORnKcyeW1SoAud4N0CvXfM1e3RanORuqfF0JRj8xBhRK0NVcBI9QoLgAI
	 7HEdjnfG+pWupRxGrDIRZng/KOSka+1F9vDiq/yzFGHSEi8UiDmjTfDCj2X7ve3UhAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZQq9hSl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BD606A319
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZQq9hSl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C62B1F000C5
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434640;
	bh=IiERdvXgyJxNTYbete+O3PXMPJrR+KVSjkT2q5yz/NY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MZQq9hSlytTJ7gKPdeNDxmzutIZuCVrMG1MNtTKUsnPaECVmQ3BlYTHNdcq4bbA+o
	 vPXMFWrYcwhFianNrU60JG6JVg+wl3zSt8m1VJ1jBlmKiXx/ZtuXI8Af1+PqZxTAuU
	 jl4PRPcEHd73gjx1rFV/DAEBtSPMRyxMTlrvngVLqJVJ2iZ6cWswZOeIoo9SpvHVuw
	 33LotJE310Nr22fidrtpNIhuQdk8MnvTTPy8xUnDxb5ziQpY7amZSmhacDCUHgFG8d
	 djAYKzrnkBheIJAGG3uEsYlFLaNrn/r/l0buezYuXDgdw8S57ELS+QcKTefqx7aI8k
	 TWR2FkPKsSiYw==
Message-ID: <sashiko-outbox-178086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] KEYS: Reject @desclen values >=
 KEY_MAX_DESC_SIZE in key_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019181732.449591-3-jarkko@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 18:30:39 +0000
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
- [Critical] keys: integer truncation of desc_len in __key_create_or_update=
()
--

commit 40e3162313abde79a8374f519fc697c857a50981
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: Reject @desclen values >=3D KEY_MAX_DESC_SIZE in key_alloc()

This commit moves KEY_MAX_DESC_SIZE to include/linux/key.h and adds a check
in key_alloc() to reject descriptions with a length at or above
KEY_MAX_DESC_SIZE with -EINVAL so that the 16-bit desc_len field in struct
keyring_index_key does not overflow.

> diff --git a/security/keys/key.c b/security/keys/key.c
> index b34a64d81d47a..4f52245581a4c 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -245,6 +245,8 @@ struct key *key_alloc(struct key_type *type, const ch=
ar *desc,
>  	}
> =20
>  	desclen =3D strlen(desc);
> +	if (desclen >=3D KEY_MAX_DESC_SIZE)
> +		goto error;
>  	quotalen =3D desclen + 1 + type->def_datalen;
> =20
>  	/* get hold of the key tracking for this user */

[Severity: Critical]
Is checking desclen in key_alloc() too late for the __key_create_or_update()
path?

In security/keys/key.c:__key_create_or_update(), strlen(index_key.descripti=
on)
is assigned to the 16-bit index_key.desc_len field and passed to
key_set_index_key(), __key_link_begin(), and find_key_to_update() before
key_alloc() is ever called:

security/keys/key.c:__key_create_or_update() {
	...
	if (index_key.type->preparse) {
		ret =3D index_key.type->preparse(&prep);
		if (ret < 0) {
			key_ref =3D ERR_PTR(ret);
			goto error_free_prep;
		}
		if (!index_key.description)
			index_key.description =3D prep.description;
		key_ref =3D ERR_PTR(-EINVAL);
		if (!index_key.description)
			goto error_free_prep;
	}
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

When userspace calls sys_add_key() with a NULL _description, the
strndup_user(_description, KEY_MAX_DESC_SIZE) check in sys_add_key() is
skipped and index_key.type->preparse() can generate prep.description from t=
he
payload (for example, x509_key_preparse() in
crypto/asymmetric_keys/x509_public_key.c builds prep->description from the
certificate subject and serial/SKID without a KEY_MAX_DESC_SIZE limit).
In-kernel callers of key_create_or_update() and key_create() also pass
description directly into __key_create_or_update().

If strlen(index_key.description) is a multiple of 65536 (or 0),
index_key.desc_len truncates to 0 and triggers BUG_ON(index_key->desc_len =
=3D=3D 0)
in security/keys/keyring.c:__key_link_begin() before key_alloc() is reached.
If strlen(index_key.description) > 65535 truncates to a non-zero 16-bit len=
gth
L, key_set_index_key() and find_key_to_update() hash and match only the fir=
st
L bytes of index_key.description, which can collide with and update an
existing key with that L-byte prefix without ever reaching key_alloc().

Should __key_create_or_update() also validate that the description length is
non-zero and less than KEY_MAX_DESC_SIZE before assigning index_key.desc_le=
n?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019181732.4495=
91-1-jarkko@kernel.org?part=3D2
