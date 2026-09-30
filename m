Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A04F4047
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776534; cv=none; b=rboIYAJErSKe84fG2/YKNOlggS4mi9GaH5c09qJRyf0LORNDF3DvZc0lVPZH3h6WvQ6G5LZUN23aWqYmdcJjtJ0Cf8tOqTKvsKKuzxaFo3cILuMoHwblPQo3ocyQP3C6EiSgRmZVgyPJhI7QqK6FA4xSmAev0em+kz00iKn/Ay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776534; c=relaxed/simple;
	bh=5zuDm0fjvz+c4G85/bG76BROPTJiCJEjLHNxq1/ELCM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hJ1jJxuLTq5TnVrEyCMQ9Nem4TAk/8cS+xqx6VmlWTNPWc/Q5ElIhnpnWZnatchrRjawrlfte2oIKwFBZSLUFnPGzrkOKvSbIzIi5lBNfsgLGTcKbqrBZXt+7utTbRFwFpA4WeRuDNIv8UY3JFN42PcafNlAvj8+XNA8tMqQwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvQPl4Q6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvQPl4Q6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4421F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776516;
	bh=RPYSGrmzVN7Cs9Wdj4ROkVBHZERBZsKALB9wNqT4XUg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NvQPl4Q6SZ0xsA+cAhbrRNHxttdSwdpUa8cIgYl/D5hSp3gyX6178MfvPN3z8nSj0
	 1O6092r+l4ni9u/42KfN8WWmUX6JCOZHgA3jLKHFYX7+Y2ZGt5YhHL1CcsxftwPTwH
	 TQBBMBXdV/PBfUY433z0IXaL/EVnHJS6pql5HNoEg5Jp+BJNxGifETOr73XQql0lSP
	 whTlQHL1vccqVesjuuJApxZhHO5/lBOfCJ2m1315DMwO+Bvd2mRwK6dcLoNYcphDQy
	 ItFvzh05NwmlucAWrriVko4ljzdboE8KcwORThcpQql98oJsg2K0rnDMOxSN04fs1V
	 MPkqRX1lKPsBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] security: IMA: introduce ima_mr structure
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260930-ima_tgx_integration_v2-v1-2-722c35370548@arm.com>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
 <20260930-ima_tgx_integration_v2-v1-2-722c35370548@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:55:15 +0000
Message-Id: <20260930135515.DB4421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] ima: memory leak of ima_shash_tfm and ima_algo_array in ima_init=
_crypto()
- [Medium] ima: memory leak of digests array in ima_init_digests()
--

commit babc42a28171ec6623537f00a8d1222d9f72a6e2
Author: Yeoreum Yun <yeoreum.yun@arm.com>

security: IMA: introduce ima_mr structure
   =20
This commit introduces the ima_mr structure to abstract measurement registe=
rs=20
and operations, preparing the subsystem to integrate TSM measurement regist=
ers=20
with IMA. It also migrates the TPM device using PCRs as measurement registe=
rs=20
to use this new interface.

> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
> index 0d72b48249ee6..efa27ce5f1282 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c

[ ... ]

> @@ -77,6 +77,7 @@ int __init ima_init_crypto(void)
>  	enum hash_algo algo;
>  	long rc;
>  	int i;
> +	mr_bank_info_t bank_info;
> =20
>  	rc =3D ima_init_ima_crypto();
>  	if (rc)
> @@ -85,8 +86,12 @@ int __init ima_init_crypto(void)
>  	ima_sha1_idx =3D -1;
>  	ima_hash_algo_idx =3D -1;
> =20
> -	for (i =3D 0; i < NR_BANKS(ima_tpm_chip); i++) {
> -		algo =3D ima_tpm_chip->allocated_banks[i].crypto_id;
> +	for (i =3D 0; i < NR_BANKS(ima_mr); i++) {
> +		rc =3D ima_mr->ops->mr_get_bank_info(ima_mr, i, &bank_info);
> +		if (rc)
> +			return rc;

[Severity: Medium]
Does this direct return bypass the cleanup for ima_shash_tfm?

Since ima_init_ima_crypto() is called earlier and allocates it, it looks
like returning rc here skips the out label where the cleanup happens.

> +
> +		algo =3D bank_info.crypto_id;
>  		if (algo =3D=3D HASH_ALGO_SHA1)
>  			ima_sha1_idx =3D i;

[ ... ]

> @@ -95,24 +100,28 @@ int __init ima_init_crypto(void)
>  	if (ima_hash_algo_idx < 0)
> -		ima_hash_algo_idx =3D NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
> +		ima_hash_algo_idx =3D NR_BANKS(ima_mr) + ima_extra_slots++;
> =20
>  	ima_algo_array =3D kzalloc_objs(*ima_algo_array,
> -				      NR_BANKS(ima_tpm_chip) + ima_extra_slots);
> +				      NR_BANKS(ima_mr) + ima_extra_slots);
>  	if (!ima_algo_array) {
>  		rc =3D -ENOMEM;
>  		goto out;
>  	}
> =20
> -	for (i =3D 0; i < NR_BANKS(ima_tpm_chip); i++) {
> -		algo =3D ima_tpm_chip->allocated_banks[i].crypto_id;
> -		digest_size =3D ima_tpm_chip->allocated_banks[i].digest_size;
> +	for (i =3D 0; i < NR_BANKS(ima_mr); i++) {
> +		rc =3D ima_mr->ops->mr_get_bank_info(ima_mr, i, &bank_info);
> +		if (rc)
> +			return rc;

[Severity: Medium]
Could this return cause a memory leak of ima_algo_array and any hash
transforms allocated in previous loop iterations?

Taking this path bypasses the explicitly defined out_array cleanup label.

> +
> +		algo =3D bank_info.crypto_id;
> +		digest_size =3D bank_info.digest_size;
>  		ima_algo_array[i].algo =3D algo;
>  		ima_algo_array[i].digest_size =3D digest_size;

[ ... ]

> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 67782c004cdf7..037979829242c 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c

[ ... ]

> @@ -548,25 +547,27 @@ void __init ima_init_reboot_notifier(void)
> =20
>  int __init ima_init_digests(void)
>  {
> +	int rc, i;
> +	mr_bank_info_t bank_info;
>  	u16 digest_size;
> -	u16 crypto_id;
> -	int i;
> =20
> -	if (!ima_tpm_chip)
> +	if (!ima_mr)
>  		return 0;
> =20
> -	digests =3D kzalloc_objs(*digests, ima_tpm_chip->nr_allocated_banks,
> -			       GFP_NOFS);
> +	digests =3D kzalloc_objs(*digests, NR_BANKS(ima_mr), GFP_NOFS);
>  	if (!digests)
>  		return -ENOMEM;
> =20
> -	for (i =3D 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
> -		digests[i].alg_id =3D ima_tpm_chip->allocated_banks[i].alg_id;
> -		digest_size =3D ima_tpm_chip->allocated_banks[i].digest_size;
> -		crypto_id =3D ima_tpm_chip->allocated_banks[i].crypto_id;
> +	for (i =3D 0; i < NR_BANKS(ima_mr); i++) {
> +		rc =3D ima_mr->ops->mr_get_bank_info(ima_mr, i, &bank_info);
> +		if (rc)
> +			return rc;

[Severity: Medium]
If mr_get_bank_info() fails here, does this return abandon the newly
allocated digests array?

It appears kfree(digests) might be needed before returning rc to prevent a
memory leak.

> +
> +		digests[i].alg_id =3D bank_info.alg_id;
> +		digest_size =3D bank_info.digest_size;
> =20
>  		/* for unmapped TPM algorithms digest is still a padded SHA1 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-ima_tgx_in=
tegration_v2-v1-0-722c35370548@arm.com?part=3D2
