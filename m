Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26342122E
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185817; cv=none; b=HMcHl6LzW/oARo2qC44FqjTy2H2jWmWztVf5hx3fiyxMYkeUA8/vSRF0VYNfWg/Pq5m97/Clbc5pbW03Wg7oZNOJU2Wc2dHI80fBD2pxiGC0xYBydu+sFs5TDKkxcttsoJ/yZ4vRkO1dJ4iBzH9UuWDyx5L4RHsEEIp40WHcU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185817; c=relaxed/simple;
	bh=5vCW2Zc5F/Bj4mF1cPSqH0TYj+zhUFfAab4oCU9d37Y=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b040aT61E4Mnqrcf+kNR8KmR8GwyFopy/8zcOfILpYorYKbiyHJFlAd+x8UqqEnDoNB3t+6e75HasOdxkyfmWQHSH6Bv715EorluAn9zZ9SNnvd0w3+N0RkvHRam34ytxdceLuzzdfYbfpB2hJU/lYakC+rJkB/g7y/cMqhaqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgnd6RAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgnd6RAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4651B1F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185814;
	bh=Rjozu35aBlLr6NYjdhQ8TpLKpQjgR1j9yNN02pT91AQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jgnd6RAbGAgktx7hKvIT88pgOu4k7MP1kUjnWjFhB40o0/Xb323mlrEaDp2K7DsdA
	 DUOXrRg9hEXgfgYjo3N5R9qrTMbyQgFFKFNuiimi1Nc+Z03MwMYG7T+vmvA6l/FJ/z
	 hc8lPLrbamqn8Zpv8mpfC6LrTIkKJrGdQpqxIliTR6OrzSyM812iSC4tfO7wyvX9ta
	 wT9AoNXBYCfYXkrVEhHrJo8HJ76I2p3gXPGhGXL9QFycFNqAcKUFNdeQcwuw9SfVPM
	 HDJTeou2qXZRi2aLHRSz2nGYIxzhe868wCxXJM5MNFVzvmVTyfLIzqpyXCFNoMC8kI
	 4ZjrJGm0cj7CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: trusted: Fix blob allocation size in
 tpm2_key_decode()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260923173506.41519-1-sgarzare@redhat.com>
References: <20260923173506.41519-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:50:13 +0000
Message-Id: <20260923175014.4651B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] keys: trusted: tpm2_key_decode() causes ZERO_SIZE_PTR derefere=
nce panic
--

commit 0b756ca20b74ac8e9fbfa99370ee0a0c61126972
Author: Stefano Garzarella <sgarzare@redhat.com>

KEYS: trusted: Fix blob allocation size in tpm2_key_decode()

This commit adjusts the allocation size for the TPM2 key blob in
tpm2_key_decode() to match the actual size of the decoded data, removing
an unnecessary 4-byte padding. The author notes that a separate commit,
114f00d738f1, fixes a boundary check in tpm2_load_cmd() that correctly
reports the decoded blob size.

> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/tr=
usted-keys/trusted_tpm2.c
> index 6340823f8b53c..ed88758c7e9bf 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -116,7 +116,7 @@ static int tpm2_key_decode(struct trusted_key_payload=
 *payload,
>  	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
>  		return -EINVAL;
> =20
> -	blob =3D kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> +	blob =3D kmalloc(ctx.priv_len + ctx.pub_len, GFP_KERNEL);
>  	if (!blob)
>  		return -ENOMEM;

[Severity: Critical]
Does this code handle the case where both lengths are zero?

If a payload contains empty strings for both privkey and pubkey,
asn1_ber_decoder() will succeed with ctx.priv_len and ctx.pub_len both
being 0 in tpm2_key_decode().

Because the padding has been removed, this results in:

    kmalloc(0, GFP_KERNEL)

which returns ZERO_SIZE_PTR (0x10). Since 0x10 is not NULL, the if (!blob)
check passes.

Later in security/keys/trusted-keys/trusted_tpm2.c:tpm2_load_cmd(), the
code unconditionally dereferences the newly allocated blob:

    private_len =3D get_unaligned_be16(blob);

The boundary check in tpm2_load_cmd() uses payload->blob_len (which is >=3D=
 15
for this ASN.1 sequence) instead of the decoded key length. Thus, the check
passes, dereferencing ZERO_SIZE_PTR and causing a kernel panic.

While the commit message mentions commit 114f00d738f1 as correctly reporting
the decoded blob size, that prerequisite commit is not present in this tree
or series. Applying this patch without its prerequisite introduces a
regression where this panic can occur.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173506.4151=
9-1-sgarzare@redhat.com?part=3D1
