Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792835923;
	b=bWKqXayTXlI00KrQjenX3TeaiBx7+xaXTmAijmezLgw2Aft28+AoaMmJfbf3Yn5iJc6U
	 VpMT1jVw3ECNqbzE9uS1lFdn7PtV6OWFM+Hf7z2884oE5LUudOP5fEVXHsyuLg4WDq07h
	 nzlQxqP//jetZsuh6zC/E6C1pTu0BtG0Eq4S2TdGnwxhWXcQgSYCWGkGGZ2V2GfO6Rf4A
	 bzz5h+OpOyfo0WY4m0V3BIf8WuAnJRG91Aapy+KLFGgTwBn/ZExSs99lUVWtO0cCccYfo
	 ggFb5r0G0vrptwAY5P9XUd/P1VWYgYuJnKjAgSe72MB7qryWvmGBfvD7VLu7NNgpFlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792835923;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UyPhDvvu9/5pgkHy1M16uWL9wIliVZa/AKN9bTMv2lE=;
	b=ufUuWlMgjzHdjEgGL+e5TSXL9i6Y3u3OXzL7Vrh0eVExOZb7Gq8GEfAVkrIZO1TNxLR9
	 kQgHPcaFFODEXiDZgDvBNQQXXeyTeNiNaAAKi/EDjg6GSI82wlUiwMtO9Yt46h6T4o3Bw
	 fAoyrFZMgwBsIPIov8xSp4DDqJZq/00AxyMq8epNxmZmHureDBtTTlf7S7oig2ymQz8CN
	 lXl8tokebVB+MRmW/WllaUzH8F1la18iYQVxmhIFRoVz54m0hLY0MjmpdhJ++yA2BUg7q
	 EcSAEP+TSXA+zaofy7uLdmziNcRPKOmKt60v7iyidKfkzDXcd+0p8SrIRWJR3x/PNcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJN3HOkV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C3606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJN3HOkV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0A41F01825
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792835922;
	bh=UyPhDvvu9/5pgkHy1M16uWL9wIliVZa/AKN9bTMv2lE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lJN3HOkVksMrlFJdATcDcL9A8SSWVS4tOIqixx0aVPJ+aWSGDWZz/7fMdTtnExprR
	 6WzAlMZ+kP3mDZz6wuOQ8dGeyXXEQ5KYPnouIlEUrxGngTOQb9nwBGXY2sLasSRNXK
	 KPwxqEXeK7s/5247dxTbctCJ3GfbBtGqUirIsFB4sRadIhn9BYyr7REmmRuKYncap1
	 AUhRgJPNuWSSQTnomqtORn8RDpaLG7EPd48fQmKQT1f8kFLB9Aqv3XuWnOL2AFclrS
	 /ducUGoOiF2nASYYErfxz3bbP6e/nC3YcLmd+XExYKQcfVVz4aGOAvOmLJXgjeL1hc
	 u7+ZWPoxQayhQ==
Message-ID: <sashiko-outbox-183637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] ima: discard modsig when detached data cannot be
 supplied
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261024093918.2929374-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261024093918.2929374-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261024093918.2929374-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 09:58:42 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ima: ignored pkcs7_get_digest() failure in ima_collect_modsig()
- [Medium] ima: unintended measurement in process_measurement() when modsig=
 is discarded
--

commit 6ba08dabf06dd0a8dc8646bcd331980059e5a114
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

ima: discard modsig when detached data cannot be supplied

This commit updates ima_collect_modsig() to return a boolean indicating
whether detached file data was supplied to the PKCS#7 message, and
discards the modsig in ima_collect_measurement() if supplying the
detached data fails.

> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index 45701f04ba62f..7859c9d1a27f5 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -235,6 +235,8 @@ static bool ima_get_verity_digest(struct ima_iint_cac=
he *iint,
>   *
>   * Calculate the file hash, if it doesn't already exist,
>   * storing the measurement and i_version in the iint.
> + * If modsig is provided, discard it when detached data cannot be suppli=
ed
> + * so ordinary measurement and xattr appraisal can proceed.
>   *
>   * Must be called with iint->mutex held.
>   *
> @@ -242,7 +244,7 @@ static bool ima_get_verity_digest(struct ima_iint_cac=
he *iint,
>   */
>  int ima_collect_measurement(struct ima_iint_cache *iint, struct file *fi=
le,
>  			    void *buf, loff_t size, enum hash_algo algo,
> -			    struct modsig *modsig)
> +			    struct modsig **modsig)
>  {
>  	const char *audit_cause =3D "failed";
>  	struct inode *inode =3D file_inode(file);
> @@ -262,8 +264,10 @@ int ima_collect_measurement(struct ima_iint_cache *i=
int, struct file *file,
>  	 * the file digest without collecting the modsig in a previous
>  	 * measurement rule.
>  	 */
> -	if (modsig)
> -		ima_collect_modsig(modsig, buf, size);
> +	if (modsig && *modsig && !ima_collect_modsig(*modsig, buf, size)) {
> +		ima_free_modsig(*modsig);
> +		*modsig =3D NULL;
> +	}
> =20
>  	if (iint->flags & IMA_COLLECTED)
>  		goto out;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index fed80da3ee096..336e17ec4f7a3 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -422,7 +422,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
> =20
>  	hash_algo =3D ima_get_hash_algo(xattr_value, xattr_len);
> =20
> -	rc =3D ima_collect_measurement(iint, file, buf, size, hash_algo, modsig=
);
> +	rc =3D ima_collect_measurement(iint, file, buf, size, hash_algo, &modsi=
g);

[Severity: Medium]
Can discarding modsig in ima_collect_measurement() leave IMA_MEASURE set
in action when the measurement was only requested to record the modsig?

Earlier in process_measurement(), if IMA_MODSIG_ALLOWED is set and
ima_read_modsig() succeeds on an already-measured file, IMA_MEASURE is
added to action:

	if (iint->flags & IMA_MODSIG_ALLOWED) {
		rc =3D ima_read_modsig(func, buf, size, &modsig);

		if (!rc && ima_template_has_modsig(template_desc) &&
		    iint->flags & IMA_MEASURED)
			action |=3D IMA_MEASURE;
	}

When ima_collect_measurement() subsequently discards modsig and sets it
to NULL because pkcs7_supply_detached_data() fails, action still has
IMA_MEASURE set.

If the earlier measurement that set IMA_MEASURED used a non-default PCR
and the current hook only matched an appraise rule (leaving pcr at
CONFIG_IMA_MEASURE_PCR_IDX), ima_store_measurement() will see modsig =3D=3D
NULL, find that the default PCR bit is not set in iint->measured_pcrs:

	if (iint->measured_pcrs & (0x1 << pcr) && !modsig)
		return;

and record an extra measurement with no modsig into the default PCR.
Should IMA_MEASURE only be added to action after modsig collection has
succeeded?

[ ... ]

> diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima=
/ima_modsig.c
> index 632c746fd81e4..e640a9a53508e 100644
> --- a/security/integrity/ima/ima_modsig.c
> +++ b/security/integrity/ima/ima_modsig.c
> @@ -96,8 +96,12 @@ int ima_read_modsig(enum ima_hooks func, const void *b=
uf, loff_t buf_len,
>   * Since the modsig is part of the file contents, the hash used in its s=
ignature
>   * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
>   * calculates a separate one for signature verification.
> + *
> + * Digest export is best-effort; not all signatures expose a single dige=
st.
> + *
> + * Return: true if the file data was supplied, false otherwise.
>   */
> -void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t s=
ize)
> +bool ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t s=
ize)
>  {
>  	int rc;
> =20
> @@ -109,11 +113,13 @@ void ima_collect_modsig(struct modsig *modsig, cons=
t void *buf, loff_t size)
>  		sizeof(struct module_signature);
>  	rc =3D pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
>  	if (rc)
> -		return;
> +		return false;
> =20
>  	/* Ask the PKCS7 code to calculate the file hash. */
>  	rc =3D pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
>  			      &modsig->digest_size, &modsig->hash_algo);
> +
> +	return true;
>  }
> =20
>  int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integri=
ty/ima/ima_template_lib.c
> index 9bd80ca1159a2..585cd59f00a2e 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -478,8 +478,8 @@ int ima_eventdigest_modsig_init(struct ima_event_data=
 *event_data,
>  		if (rc)
>  			return rc;
>  		else if (hash_algo =3D=3D HASH_ALGO__LAST || cur_digestsize =3D=3D 0)
> -			/* There was some error collecting the digest. */
> -			return -EINVAL;
> +			/* Keep the ordinary measurement without an exported digest. */
> +			return 0;
>  	}

[Severity: High]
What happens in ima_check_blacklist() and ima_store_measurement() when
pkcs7_get_digest() fails in ima_collect_modsig() (note that the return
value of pkcs7_get_digest() also remains unchecked in the follow-up commit
"ima: audit failure to supply detached data for modsig")?

When pkcs7_get_digest() fails (for example, returning -EBADMSG when
sinfo->next !=3D NULL, or -EINVAL when !sinfo->sig->m_free for algorithms
such as ML-DSA) or leaves modsig->hash_algo as HASH_ALGO__LAST,
ima_collect_modsig() still returns true. That leaves modsig non-NULL in
process_measurement() with modsig->digest =3D=3D NULL, modsig->digest_size =
=3D=3D
0, and modsig->hash_algo =3D=3D HASH_ALGO__LAST.

In security/integrity/ima/ima_appraise.c:ima_check_blacklist(), a
non-NULL modsig takes the first branch and skips checking iint->ima_hash:

	if (iint->flags & IMA_MODSIG_ALLOWED && modsig) {
		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);

		rc =3D is_binary_blacklisted(digest, digestsize);
	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
		rc =3D is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->leng=
th);

Because digest is NULL and digestsize is 0, is_binary_blacklisted(NULL, 0)
returns 0. Since pkcs7_get_digest() rejects messages with multiple
SignerInfos (sinfo->next !=3D NULL) while ima_modsig_verify() ->
verify_pkcs7_message_sig() succeeds as long as at least one SignerInfo is
valid and trusted (and similarly for ML-DSA signatures where
!sinfo->sig->m_free), wouldn't a blacklisted binary bypass
ima_check_blacklist()?

In addition, because ima_eventdigest_modsig_init() now returns 0 instead
of -EINVAL when hash_algo =3D=3D HASH_ALGO__LAST || cur_digestsize =3D=3D 0=
 while
event_data->modsig is still non-NULL:

1. For templates like ima-modsig (d-ng|n-ng|sig|d-modsig|modsig),
   ima_eventdigest_modsig_init() leaves the d-modsig field empty while
   ima_eventmodsig_init() still populates the modsig field with the raw
   PKCS#7 signature, breaking the requirement in check_template_modsig()
   that modsig be paired with d-modsig.

2. If the file was already measured (iint->flags & IMA_MEASURED),
   process_measurement() and ima_store_measurement() will record a second
   measurement entry and extend the PCR again even though no modsig digest
   could be exported.

Should ima_collect_modsig() fail and discard the modsig when
pkcs7_get_digest() fails or leaves modsig->hash_algo =3D=3D HASH_ALGO__LAST?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024093918.2929=
374-1-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1
