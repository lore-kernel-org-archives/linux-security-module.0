Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424967;
	b=RtdqgHmjZIRnP5fb8KqLN2p2p3xcJkpZ4b0M6707HEw63TZ+rLh2/4mb/Fosc/pfg7PG
	 5p/pQ11TXEr29YTVwYY1zSLJvEDFBFxKUzlAO54VhKqMddrhItLFt2lDbQja/m4QQvfiX
	 kGccy6p0bFwTAYCgUWqx2jzruN4I3Pa47uuCh4uCfdL4hIBxNAd+CHnO7YZ+yw2gr67ke
	 dyalRZDz0ePSpH4GCMk1C5O2wXtpha7UHJWBzAig3+sXYNNPuJnqgosfu1o7d8chqEOvW
	 Ls0DcgowIdc8wKGVYpdt0UGmul2EPKtX7M+fBxNqYBxjXAJptPTylWGBo2Mi122VUpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oI06Hw4EgAvX07nfI/vDz9kV7OsrvYpqhL1uAoVx3iI=;
	b=uEBLnkATTFVsqMATTwrY38AwaN7CMeZRGOVY1lwpefYFudjMApYCCxQet+dxWe1Uy8QA
	 IbZOwMGdMZFrF3+O4UL2CUDe+N7Z6o+pCCiDtgM7kbEyWeu2G0A4hTH1au4TuHueQoHrO
	 Yw8d67Qc8UsXciQs/Bzb6EV18HXaXVzpcP/Me7N6gcA3TOE372c5ptGaM7JvBd+xEfuob
	 oFvKKQJmmM0qQdE7zT/N8IaGBW5XD5/HUjAcK6+BKXETpp2hOXJEF29/0raRHrE67ywIA
	 I6u9l6FO2Rw45sFvwwSpl7V7u+PJfyhu4YgNhfWrvgICf1gxJgZFEe70yUxxWYvQnHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WE2QfvAF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93E60874AE
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WE2QfvAF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812FF1F000C7
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792424966;
	bh=oI06Hw4EgAvX07nfI/vDz9kV7OsrvYpqhL1uAoVx3iI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WE2QfvAFGRu79le8nlaPCnLS2JY1U0WR84NS2z7zH97kf8AdrELw6SiOO1kMRg5jK
	 QxleXlpKn0DEr8G3jXbAvVz12f2N6zajYF9MLnEBf79PigW1Nwe80THLFGMt56zg3p
	 kOfRLn1SzaXjfvUF7tMU/xd6HfV0IJBAsxJdb24HUnE34DDUV2yJowBuh3rhISd0k+
	 OqKzMLPO3T8plfX27kyt8O00R53AsIPjrwBNwbhMeWCfP/jIv2oyY3/mzUIsHq3++Q
	 N8jw848Pm/HYp/lZoRhyYI3Cz2sTqkTGUu6JmgNLV7JuQuHnHzcSJ1W7+o2W3vx+qg
	 iAKNO+5yxB3tg==
Message-ID: <sashiko-outbox-177790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/8] KEYS: Reject @desclen values over U16_MAX in
 key_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019142516.300040-4-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
 <20261019142516.300040-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:49:26 +0000
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
- [High] KEYS: desc_len truncation in __key_create_or_update() before key_a=
lloc()
--

commit e49d7d031ada6f60dccb5c6e74d1e66145a0c3d4
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: Reject @desclen values over U16_MAX in key_alloc()

This commit adds a bounds check in key_alloc() to reject key descriptions
longer than U16_MAX with -EINVAL, preventing truncation when storing the
length in the 16-bit desc_len field of struct keyring_index_key.

> diff --git a/security/keys/key.c b/security/keys/key.c
> index b34a64d81d47a..a0f083339da8d 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -245,6 +245,8 @@ struct key *key_alloc(struct key_type *type, const ch=
ar *desc,
>  	}
> =20
>  	desclen =3D strlen(desc);
> +	if (desclen > U16_MAX)
> +		goto error;
>  	quotalen =3D desclen + 1 + type->def_datalen;
> =20
>  	/* get hold of the key tracking for this user */

[Severity: High]
Does __key_create_or_update() also need to validate the description length
before assigning index_key.desc_len?

In security/keys/key.c, __key_create_or_update() assigns strlen() to the
16-bit index_key.desc_len field and passes it into __key_link_begin() and
find_key_to_update() before key_alloc() is called:

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
	if (ret < 0) {
		key_ref =3D ERR_PTR(ret);
		goto error_link_end;
	}

	...
	if (allow_update) {
		if (index_key.type->update) {
			key_ref =3D find_key_to_update(keyring, &index_key);
			if (key_ref)
				goto found_matching_key;
		}
	}

	key =3D key_alloc(index_key.type, index_key.description,
			cred->fsuid, cred->fsgid, cred, perm, flags, NULL);
}

Although add_key() limits user-supplied _description strings to
KEY_MAX_DESC_SIZE, _description can be NULL when index_key.type->preparse
generates prep.description from the payload. For example, in
crypto/asymmetric_keys/x509_public_key.c, x509_key_preparse() constructs
prep->description from the X.509 certificate subject and hex-encoded
serial or skid:

	desc =3D kmalloc(sulen + 2 + srlen * 2 + 1, GFP_KERNEL);
	if (!desc)
		return -ENOMEM;
	p =3D memcpy(desc, cert->subject, sulen);
	p +=3D sulen;
	*p++ =3D ':';
	*p++ =3D ' ';
	p =3D bin2hex(p, q, srlen);
	*p =3D 0;

Since the payload can be up to almost 1MB, strlen(index_key.description)
can exceed U16_MAX.

If strlen(index_key.description) is a multiple of 65536 (or 0),
index_key.desc_len truncates to 0 and triggers BUG_ON(index_key->desc_len =
=3D=3D 0)
in __key_link_begin() in security/keys/keyring.c before key_alloc() is
reached.

If strlen(index_key.description) > U16_MAX is not a multiple of 65536,
index_key.desc_len truncates to strlen % 65536. Because
keyring_compare_object() in security/keys/keyring.c only compares
index_key->desc_len bytes:

	return key->index_key.type =3D=3D index_key->type &&
		key->index_key.domain_tag =3D=3D index_key->domain_tag &&
		key->index_key.desc_len =3D=3D index_key->desc_len &&
		memcmp(key->index_key.description, index_key->description,
		       index_key->desc_len) =3D=3D 0;

find_key_to_update() can match an existing key with a shorter description
sharing that prefix and update the wrong key via goto found_matching_key,
bypassing key_alloc() altogether (or fail with -EEXIST instead of -EINVAL).

In addition, keyring_search() in security/keys/keyring.c, as well as
request_key_and_link() and request_key_rcu() in security/keys/request_key.c,
also assign strlen(description) directly to .index_key.desc_len without
bounds checking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019142516.3000=
40-1-jarkko@kernel.org?part=3D3
