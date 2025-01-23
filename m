Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611DC16EC19
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668197; cv=none; b=XWCgA8gqM/ygdmR8oOPQeT5ZZWeh/k/Ra7Xeera3z+W5dGCkFGba+IdfSzlrjDlU3pxPDYKBH4uVgmnRe/ELbk61Li9ZDX9+vqeSmb/BQGrVEPe02gVsRjKkx2zLtVJqNx4+bk5qV5iH5kdW5ACRsGZ0sxYsaXYUULXbzdFU8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668197; c=relaxed/simple;
	bh=ShbUmDRQx8Qtn6lh9rqAE/0Liywr8hUyTte9D0zo56A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGaMzAD1Ya/PAtphvkX3hzMjyhweKYtpJCXEqvL5Ri5Zo8e+zWe4ySNY1k8MA+f2GMWiA5Kl2dJiBSqE8SBcwKoHnYNzephnkWDiploGwxLisCxE6A9636+NVP1ZNgnm4e2BTgn+qEN0CKGgnB6IrU8qfiUoIDmjXMJADcLC7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BEdaQH4n; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BEdaQH4n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737668186; bh=AfvNVlYwhJwT6SISlMqT5Fak8MP/SSCtn3Dz2bb5uic=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BEdaQH4n0vZsWURy3jUFF791Bt+tQ9vTg5L4YcjhfDTk8ZKdAvijAmzG6ZmY2VZjojLVtqQ3Tzt+B7WnhsBsRKOmbWPGy62j0wkuq6sTwfvPd/Hl5FbmOI5M4ZWFB6aLxV7qaBLhkCRJnbv/kCLdoa+ELu+6Cat2Uq68ArhVJ7TS0ngLyu3ZHLB5gBFhpaQHCroOVoZSOF7RHqgLCKU9mAUFBTQmOlOZuhL1T+XQLXPprAG+LHeFgtiBwIhjAAncGI6w5L/R3T5WK2Tibn20knaW5QtyHtRalvw2qSNf9waGDg4QZc4VSt9KQPXjuODJdLaUaJsrguuUT4C5Gvntxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737668186; bh=WPHvuB9J6NIJu6UnI99t5+jaWYoJco+UK+s9LmcuNYo=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eCuRogskhVwk7xVTQVdeMIKyzqNFTzkOpusAmqnCWFc69I/tLdTC95DggsJ1Sb30oDfz3wxa8W8t50fyNGyM71iED8px+PUFuV4y61ZIqQvkTB39zWAt5UVL3Sne1xrrMSCQTww/plrlz0plifasdniQ7xz6iF7jwp3H82RH6iEPPVorqZmH3ceRq2Wgzd4Zv9CxlGkbI75RWVyuPn3bhUXloSpzx3FA4HfFiEAaEPE7Dd5HbCHrHL8NhGREmblZOcuN3jrS8KA6BPbdn9PHDXkvuFsBwUP6H5iOmkQEn4aPaYy1D3ZdamsrGrcQ9lY+bbBw/eaMNsCurTFrbJ9rSg==
X-YMail-OSG: 3GDHdGIVM1mZXtsoq1_EI2G6jHXARxSjXb3EfzZoGTZpr1yGcq2a.CrdGkS0gGA
 Ww13OrrrF0dP_TAFHsYzVrrhPzFN8dAaNuHqpL9WGfAytzN2YcWiB10NBNhci1rSyneT9uTeiQ5w
 t_TnIKmi_iKfwUKlWvCGpvHXQKgn2OuAyI87eNjQWeKj8KW02TARpiqFR42S3t2mR9RaZTEpfkXc
 R327GB2AaNv7yiP4JgLuy9EZtoOCFgB55CnrZyA7E28oKbudqfUPs9E0bCDMxQv0XBuPQToJ5t0j
 Zbgy1qynJP6rVRSugocyCYUK9I0hXxDaA2shHaqsY9XD0dlKPeU8O4GZN8diTvin8SWPjIIk89rn
 CwXxRkmhtWKiuesUNjnNSbpQ9I0Z3MScd9w9gOufbi5GmiWK20tCO_kAduJGHbbeyecIiszKfQQH
 Z_kDUxzccJwPS_Onap4s1rDtxajl1M.Oe8RW.zQRUsr9it436VRbf_pd11k.RECxj9pKFtl3M0Cm
 MCTuf6uuXv1vvfh5kCphh7nNHTdCsJB.a9G5PDNYj.wlQGQNPNoI8oZxzaM10Y_1W6UUttOAW9rv
 xKonlFHVJGvUsviaXAupR2SYt48eiPb5FthKme.ikbKM6O_3vhyH592BtzjCESSjpwGW3fiv_i6B
 QtG.DgzqccNxnxj.2KLc33GKVOZoT8HKXPIJUXpOA2HVrJEz09Kuce4RfTza6OzVlSrfFFH5PbMD
 vNwtmnKWzOeLrBtVZ_FvHd4yJg2lPFRgd4JU8f3OXDA0_yVLG9lFBhS7GkPaT6VzYyRYW4wbdx2a
 9CkWSra_xJgWYmjoMMFO1svTOZOMl6G6zR.9xtgwMY1hFpAV7.uxG6oWITftJWe5uzRg2NKOgMt_
 6copkjhL3lPlKaJw6gMVeTWAo6fRn6mtdaFCTdfBueDQuEusvAZjn_Jdstiu9Edsj1a3W5IONp5I
 H3T3CPgJS957fj5ik6MgA2GNzMLHoyCIJ4UWnLqvfwRhbYD4UeyAyQFugppOhSFXR8ktt3oCOSQA
 TJMgV1Bq2kjvh6kAKZnY57dxzmcGM9F_eEEn4u44encEsBIwOSWsoBugbuh3o.QGQJYHnADy5d23
 BAKCktjY0cAU0fQRL4oL15OqQII5jn585BgYV9IdN0873nAizqBtdHzmKZLFCa.vqveW3fXcnBFF
 4fRdyrZkK7mpJkvi7UpfTLQfT8VBEU.l3qQHX39MIeifiAnCcrjzQtPZMVq9w375Vb5NnyFndH1r
 2ZEF2aMZEkw1axkyFv.FqEvKE2lDPlEii3VH1VjvwQWywLdrfLAg6.IHRsh2DU9ItgYmpFqqXdmq
 VIpgE984bOMn0ZRPHOrjHGOtXAlDh_SWp__rDH4ROZF9HiUS9Pe2FkKO4XxTZVdQku5iBek5M2Gr
 GBL5nZzfHHWC9NjHT_.xEzdDe69i7bJeZLXWR8gzyTdoaxDXYDtxuc1Jaj_JKe8zXe8NmNcpklk_
 fVCjRFdPFcGY68dB1NcYgsTnRBbOrnVHPic2kAeoy.Ktm9bYoncxIJFlOydr3wHLCkRqjJtpbV0n
 .Vff_xP.NZEEQueNTpKeNyDBr3guS0ssCBQvsfLmFDzYot6GxcdjkeALdM_Nmmy48J0N053msjGc
 141EImGJ3uFjsIYaa.YqtuLlb72Hi.sXOges_yTTUXr_2W6Y2gAoA.LVtgjClk9xB0_D.tGtQ2tT
 V.P5cC74xYswr5bRmTJNRRA.ONINuTJb6agG.XWfLbrIMUCgfxidFZm6mP5FpKzhqdUschlTJB9A
 M0uv5IaVkH53XgyKHlgx0iqF6kHeUPWGnTkcF8nWyKukAjDWxEwPh1ChDmZz26E2e4c5ANifehe_
 iH_ycC5uYLqPgJ2JUOjpLMFx4w69Q8rEP7yYKOOMsuRQkLOn.PBt4cCc0Mv.3Mka9flUpD9AO7NU
 SQBltF5Zgqmyn_lOTJgIKwDSugcSVDEj0zIxR6P7UrBdtGZZXxkqITgplgwEWOuBLQu1FHPQC5Al
 Ud3Brw3l2dA2jEYKnFhgcHM1kOdL.QiHBp1QUfbPpBc.eEjyiLYRAcUalrpooWljST3FW4O_Dv79
 C0HM8wUL66SLXN8TMdo8yowXSqAiRBHe.0seeFS3EvltiCmyyAUCf4DWpzbKOvL9LF.YqA0yX79X
 Rxn.mnukVy.ZY_kONjub2YxBpk_0S6Z1A_033I3d0wXYhUHHAzFR35O1KRxFR.0H.B8J_5tvnnMK
 lG8Xt16KsfWGcK3z4GOHmeYpp.bm1d6DlCJ7nAfApC517eeLbnAOf7QYpMRVvUUR_1kwktU47.MN
 QtiiRQjCyQ9brSAUPjoT0bk4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fae87e87-0e0a-43ac-946a-b87ed0223d88
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 23 Jan 2025 21:36:26 +0000
Received: by hermes--production-gq1-5dd4b47f46-whghm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 29b9c64b92639f174b64565878a2c407;
          Thu, 23 Jan 2025 21:36:21 +0000 (UTC)
Message-ID: <6ff03d09-104f-4148-822d-b488eca98b86@schaufler-ca.com>
Date: Thu, 23 Jan 2025 13:36:19 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: smack: fix typos and spelling errors
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>, zohar@linux.ibm.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, anupnewsmail@gmail.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250123194455.2710-1-tanyaagarwal25699@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250123194455.2710-1-tanyaagarwal25699@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/23/2025 11:44 AM, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
>
> Fix typos and spelling errors in security/smack module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
>
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


Thank you. I will take this in through the Smack tree.

> ---
> Original discussion:
> https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail.com
>
> This patch set is split into individual patches for each LSM
> to facilitate easier review by respective maintainers.
>
>  security/smack/smack.h        | 2 +-
>  security/smack/smack_access.c | 4 ++--
>  security/smack/smack_lsm.c    | 6 +++---
>  security/smack/smackfs.c      | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index dbf8d7226eb5..ca38e145f364 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -42,7 +42,7 @@
>  
>  /*
>   * This is the repository for labels seen so that it is
> - * not necessary to keep allocating tiny chuncks of memory
> + * not necessary to keep allocating tiny chunks of memory
>   * and so that they can be shared.
>   *
>   * Labels are never modified in place. Anytime a label
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index 585e5e35710b..5c17aee5dd78 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -242,7 +242,7 @@ int smk_tskacc(struct task_smack *tsp, struct smack_known *obj_known,
>  	}
>  
>  	/*
> -	 * Allow for priviliged to override policy.
> +	 * Allow for privileged to override policy.
>  	 */
>  	if (rc != 0 && smack_privileged(CAP_MAC_OVERRIDE))
>  		rc = 0;
> @@ -277,7 +277,7 @@ int smk_curacc(struct smack_known *obj_known,
>  
>  #ifdef CONFIG_AUDIT
>  /**
> - * smack_str_from_perm : helper to transalate an int to a
> + * smack_str_from_perm : helper to translate an int to a
>   * readable string
>   * @string : the string to fill
>   * @access : the int
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 0c476282e279..85ec288eefe7 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1950,7 +1950,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
>  	 */
>  	file = fown->file;
>  
> -	/* we don't log here as rc can be overriden */
> +	/* we don't log here as rc can be overridden */
>  	blob = smack_file(file);
>  	skp = *blob;
>  	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
> @@ -4211,7 +4211,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  		/*
>  		 * Receiving a packet requires that the other end
>  		 * be able to write here. Read access is not required.
> -		 * This is the simplist possible security model
> +		 * This is the simplest possible security model
>  		 * for networking.
>  		 */
>  		rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
> @@ -4717,7 +4717,7 @@ static int smack_post_notification(const struct cred *w_cred,
>   * @gfp: type of the memory for the allocation
>   *
>   * Prepare to audit cases where (@field @op @rulestr) is true.
> - * The label to be audited is created if necessay.
> + * The label to be audited is created if necessary.
>   */
>  static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
>  				 gfp_t gfp)
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 1401412fd794..432e2d094e35 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -165,7 +165,7 @@ static int smk_cipso_doi_value = SMACK_CIPSO_DOI_DEFAULT;
>  #define SMK_LOADLEN	(SMK_LABELLEN + SMK_LABELLEN + SMK_ACCESSLEN)
>  
>  /*
> - * Stricly for CIPSO level manipulation.
> + * Strictly for CIPSO level manipulation.
>   * Set the category bit number in a smack label sized buffer.
>   */
>  static inline void smack_catset_bit(unsigned int cat, char *catsetp)
