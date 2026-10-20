Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461074;
	b=NX7RZyI9HdA6lmKhoAgjrVo21vSiPnEYAwivgoK9aLTyy0Lwzk5HW5IxRqJbSlYx3HDh
	 waBwKQPLlMKTpa37tSuBRBxiRGtI+UkZBlTQxIUDC+/ybBgnFglwwZ5GuZJcuJxc97ztm
	 HEx62pSdO6zIr5zgT9RIr2gtnXiENZ8Tz3kvL9BXYIIcSpTNq+nk1ElWVZaiM8WBnqMtE
	 EV6L+e8wN0xK+WCDh2EBZy5B+Fgi+CYbrgvo18E4E8GsIn6ZeBkaiu0PmNVLooz4PkW0a
	 g7Si2pA7QuLfPUedwPxhIZiaaGAjKDRNwLszs8Qvo4+E/YCmcWbXTnr7h6wakJ0PzKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P6YDnfoK9CDF0pnTZdUop+GCy67FiDRHVc4G0uu9GEs=;
	b=Y3mgkBWHkzoENk3FMdFBI54E77NpEqWDdqSI9jM49XH7i/oqmJcWOvJoneXglmQ2hVN1
	 1pPvLP6c2N5VVKrm0FoqktDaF8KAKVbfQQ0Y3unK4OPtp0liJmcpxoxA0vTP8zQ3/CLpN
	 iOdA4qkG24VeYIk70TS6LxPGQABIdgsvLpP4cyp6FOnKVPdxLgFNruAz0pKfARQRM4Un2
	 IU99zSBvmXp00CE7xD1O+JQ5cUPRp7wBcoFIuSO/+5UJ5iTBKaIPDc1i1wSI2dgz82o8M
	 slERSd++JP2e12gfioV5Q7NbX1dCI4anm0sCrsyccmqXSCV+inr2O4WDmtECE0iwCQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vy31K1/g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38640606A31B
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vy31K1/g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501171F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792461073;
	bh=P6YDnfoK9CDF0pnTZdUop+GCy67FiDRHVc4G0uu9GEs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Vy31K1/ggiUh4sWkhzPsnKLAm9vhc30ZL3lWjwbA0JfU0ditx3zvWnPxjLms3wWEv
	 qPxq1OOHnFw940qBFr5q0FKPwhcgSw5qgurYqdxkeQkg2CZ54AWdM7+x5NtUWD5wOT
	 kxH21UyfxGA5qUzTUHYPLrxGZU3DNs4CXfSl977z4qU4SHTCplHf1YjaqnKSt4+33G
	 3iwPOG6BZi/Cq4i78Rb5yJrXosmsoFlc5upeay1HJ3LwvJBpUD/Vu8nWp9UMSrK8o4
	 zv6p44EqdtAOAocrAYHXlqWFIzv9hqedbteiqJHJFX95BHMiEf+GLOC/jGwPtIx4B7
	 fKPEwNGBVaviQ==
Message-ID: <sashiko-outbox-178417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] KEYS: Reject @desclen values >=
 KEY_MAX_DESC_SIZE in key_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261020013903.1244157-3-jarkko@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:51:12 +0000
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
- [Critical] keys: u16 desc_len truncation in __key_create_or_update() befo=
re key_alloc()
--

commit e17213de3a1a23830538a740d7a666ca408d3916
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: Reject @desclen values >=3D KEY_MAX_DESC_SIZE in key_alloc()

This commit moves KEY_MAX_DESC_SIZE to include/linux/key.h and rejects
descriptions with length at or above KEY_MAX_DESC_SIZE in key_alloc() to
prevent overflowing the 16-bit desc_len field in struct keyring_index_key.

> diff --git a/security/keys/key.c b/security/keys/key.c
> index a438c4508595d..aa0112a693e68 100644
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
Is checking desclen in key_alloc() too late when a key is created or
updated through __key_create_or_update()?

In security/keys/key.c, __key_create_or_update() can obtain
index_key.description from index_key.type->preparse(&prep) (for example,
via add_key() with a NULL description and the "asymmetric" key type, where
x509_key_preparse() in crypto/asymmetric_keys/x509_public_key.c constructs
prep.description from the X.509 subject and hex-encoded serial or skid
without bounding it to KEY_MAX_DESC_SIZE) or from an in-kernel caller of
key_create_or_update().

Before calling key_alloc(), __key_create_or_update() assigns the length
directly into the 16-bit index_key.desc_len field and passes index_key to
the keyring lookup and linking helpers:

security/keys/key.c:__key_create_or_update() {
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
	key_ref =3D find_key_to_update(keyring_ref, &index_key);
	if (key_ref)
		goto found_matching_key;
	...
	key =3D key_alloc(index_key.type, index_key.description,
			cred->fsuid, cred->fsgid, cred, perm, flags, NULL);
}

If strlen(index_key.description) is 65536 (which x509_key_preparse() can
produce from a ~33 KB certificate payload because bin2hex() doubles the
serial or skid length), truncating it to the u16 index_key.desc_len yields
0 and hits BUG_ON(index_key->desc_len =3D=3D 0) in __key_link_begin() in
security/keys/keyring.c before key_alloc() is ever reached:

security/keys/keyring.c:__key_link_begin() {
	...
	BUG_ON(index_key->desc_len =3D=3D 0);
}

Similarly, if strlen(index_key.description) is >=3D KEY_MAX_DESC_SIZE and n=
ot
a multiple of 65536, the unvalidated or truncated desc_len is used by
key_set_index_key(), __key_link_begin(), and find_key_to_update(), which
can match and update an existing key with that shorter prefix via
goto found_matching_key without calling key_alloc(). Other paths that
populate struct keyring_index_key directly, such as keyring_search() in
security/keys/keyring.c and request_key_and_link() / request_key_rcu() in
security/keys/request_key.c, also assign index_key.desc_len =3D
strlen(description) without checking against KEY_MAX_DESC_SIZE.

Should the KEY_MAX_DESC_SIZE check also be enforced in
__key_create_or_update() (and other struct keyring_index_key initialization
paths) before assigning index_key.desc_len?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020013903.1244=
157-1-jarkko@kernel.org?part=3D2
