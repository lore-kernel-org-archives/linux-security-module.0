Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B3220F21
	for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767214331; cv=none; b=qTioQrJ7AR/3mYvxB3ubmd8X3DmfWF8TdoXL+0h9Hu+C3Fg836FDJf9RlPWH8HVY9fEFQv9VId6hZNqIFk8ao4Snm2L2NkNqYZXKGQ5BE3CuTVb9wHebi6Q654Tb27Bwv3nHahYlWVDCTIZj2Ohf5DO9DNyxE+2DnhWCs8UR4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767214331; c=relaxed/simple;
	bh=fJC2PiM28yRSfZA+qDiTo7jf5XLK5Z6aRrVj+EdCv1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAv9Rf/aYaQloeWp1+Tq0EA3LSTy3l5MMaoWsrWNRm28um5xnMjP78tiK6HuJd3hBaIYjyySECN2lWSAIv2d01Fwti/48mqU7yOum73NNUx9SvHlJi6DXLqgGNsAn56LJ+7cA8y33GqQE7/t2+XtM5xKL5l5R4PAFNRW2ON8nq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=boVnyFYT; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="boVnyFYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767214327; bh=/k3ahvAyEoNQSQGaNq0kBiOcvMqsffulEO7PgKm7OQU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=boVnyFYT/MXu6VgWeDHSSnszR/EdDxUbgCwnfP7lDeVJybdj5h5d0131jcnCAYxq5PfJtf9Je53PLJc0hkCy1JdbU8KREFH5noc8cBy3juErSt1/d3oQ0r/CYjEc0E7nCMMMPDOs5XBGyyCszcFcoJPQndED5yeYSq8hhhxSvJuV4W3TaI6+eJlMMTDSAh79vaFQW2GEw3Zdd0UAwrf/2CNRGLJwgOOeidIlgsV1FjHuj3J9FJYXmWX4bqqbcZLQE1Ufv8JbuWwTTXNfoMz9xP/xr72h4xnu1G0blLQZNOd0ZjIpl+6ZBANgn2n+VzCdx2QWCbC98kQLzVzf7l8yHg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767214327; bh=41spsgu4shkvGNNh/Vlwim369rZy4/zm93TPRL5zm8n=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fM++P8i/1Ws27XU9z2a3qrw/FAYGfeBys3AadEL7zM84Jg6J1o6++FyG637x+RstT/2qG7mHDS55+X55gymnndkLp9+U78jeZvw3CIGqz0ByJ/6oZyu+riD93QuXIJB86fyw6SKISned47FLgpFGfpWE7GZFrJql4oHRdI0lzyxrO8LZA6i0wLlWKH8rqaGWvFSVi4mHH3p5eUqiCViJemfxe+Wtty1YWA2UvUVHv3h9SGsR1nZzFhURgObesxc9BFhAv6zTPHkexVTfQwu0D22QSWnznTGPwmcdnxLxsYx+EZlPbQrjqyR5UZt6ZRYWYH0naXG14esMLQTq8N8pNA==
X-YMail-OSG: Jomm6MwVM1mPwDU7zjn_S5fFoyXJGqdEgs6bi.2d0g.LtIz.RuURVQWSkC1qQAS
 9PMcsLeoK9XaPWLeXsBzyZAm.0Es8drYPtbsWU_bsLDPcvWnhSQA3H54MWXpsNfe4LOyngkBzBxP
 sI678syX.GnkwUrmDkAXCqMtA0soKAppO9Zysmj6.a99XsT.d07R2LKy0YSqHg8gYgsRCbAePYtr
 1cC7PbCm6cN4K2d_UBR6y7k3VEmEJhULcIr2jFdCIWWnNiZV8lENt1mXqtVw9GWUeOSMpGuGRZ4I
 EHKBOM5DMR.J0wuhMofcDmDi6j22rpIE_Ld7dADj0zqqrxjQHE84uTFBtXU6mAMOLmHiE6jU6UdZ
 grCsGpuHHqIvPwtCHIiWARwSlPlzt2fr48TiJecGqm1QKRq1RSiMl4.U8kJd0VdLEGQbFSaH32Yg
 DszK.eoqCq8_kh16kiLraFzACPh8BG.OfVDvUpJs58f2NdALF101OWd6Ubn1uzZ9VTu8axKWQ6FA
 2gW1_aFNVjkl6vtWBpsu98Bi8pE2FvGpQRShT4hbqeWWvGmH8xZY3TbjNar01charokDcmvK7_W6
 7XdDeEcap.qH6oNtTfYqa_a_7iBv2OWIfYSWslp.iAPVRHvjvk2UZWRAlitELFwzhphoF5PEXqkg
 P5lo9PsnS4_z5u1fgt1hcLrc2VvppxGbqUql5J9rpNFnb_o3nFCKJfac8fOoquu83uZXgdkQhClD
 Pt6G5GwZ2tyun9MkZaEyX0tkOBSgMQyFj8A0RtZe4Q3iE_dFvrUb6aqslWk32NubFbkIZNXbGoml
 L2OXxv0Xb3xGxbPSBFPeqQblA0V5OGl_zpHCHLsx0rLNHWybhZM2UvW18sg1MaMKq4Ug.Px989Sx
 SYlDb32_sdNj9JlvxoyC4bk_02aUk9UYht8_YV_tmWvXZFl2wr04hqZca2Vk2eJQl8iw1PRr58S9
 _ojAIhYjqLljTZsMUlKuJAarxJDObYSY5UCQIeBlKW80MXN3V1gh6WC9L8pCgruz.A9SerpT8Q1Z
 LRR8pEmoTb.ztpv13Fn39Y081V2LuJS91C0ceXV203AGsBpeY_E9kKqbe7caji0cjD3DOvLaRYR4
 sqVmAdqtewZyndj.q0VMz8sIexvGjueWVX8t5Y1cuAT8sV0cjxxYm7nLlImju0Kcffl4tRsTadDa
 vmV8.bS3K1p.6BZta2xpEJUhGpq0nHy2OdRgzFfA7EJ0TNQOZnTdifSoevGgFm6dI7THhGduHKFa
 3g894jfPIYVoOWB3VWpW5QbZgLO9c.aD48FFrG4LLGQ6hun0lsnMr4ZFJYKbF_ykxLBLN3DrAYFg
 iu5PbSkGN6uYPMqx3uej.eKCn2ISik4nl.k2bFV9lIzGQVbXJ8TxQr25o6vzO8Cecg6Um8Lg6VQ4
 jpz2f8jVl82azYcetX5uVRpLudqlRCP1nmhlcrjtFs_E4d4r09KPDMWbTsttUehPZc0_Qmn6l6Wd
 LnZdBAkHVKn76OyHjm3XxXDpewPcAbm9j2lqFAuc5MbqHLURar7QS.zrO81KXX6mVlpYos54WZPc
 .BZ20zTll4oiE4BenkGBG1bdyyC0ZUwTFGBg_pdg7dH8JVE2crscoNraXZFn20NkQ8y.4R5Gg6rf
 _i5JDaar6prPap7R9U_G35RomUjjSKV0RGXopH2JsK8L1jKtTBQcSsb7PhkWmM.DfCYkEwDqsWPC
 pkUXAH56gZrUpcrrXoRiXAr3xKMiLtY.EQo_U1ce8q7SXScd_EbN5ijxpxFzdUNd5lXc07eznZwY
 q3eu8LHDT8v.BpbmTRH8fnKa56d6Jw57v6EQ2L7gF6cpH6Hgck_SDIRnro7DXsZdlaM9OylPydim
 .clTAkK6XSAcGvUGTTEX1gQdKCtgNC_nBIjLSYdP7PWQ6NckDafmMVqJRnFlgKNmlpbH2uhty1ut
 v89Vy_827PLtFVcKdbAfu3L.MP4ZNUPjRBGZt2OUm4tTBz7eEBAL8ns8GRBat.qNkjVE314tz1SG
 sdPilGlvVoIz29gk9PbWgvXCnEyaiLtLMBz.E0hkvjtNelHsQ5WFoMDQYwWlENXTMgjEaov4b3tr
 1qNXZxQmO9biuR0rH5DjiyE39.29Kwu4MmlA1W.20mpMdA3GU0VKdDvEblw4q564umBFrFDzoX0v
 Sm8RlREqQv2rmVxcNnttl7WS.sKzkgYbJt6zej1ZWYIo.w1UcHho33iOAsH16367RYca8TDDBXRM
 3B_4d0RrIbiAtj0g3OAozxIaY07NXplcbZe7ZDJZF10tTegMbu02j5MIu7R.XJqsP54t8mvv9PkU
 nrTscrUxw4yw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 70a13b35-2962-46f4-b29d-8a4604218a90
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 31 Dec 2025 20:52:07 +0000
Received: by hermes--production-gq1-54bf57fc64-lg4js (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9db7870508486662c6e86397f9baaec6;
          Wed, 31 Dec 2025 20:52:05 +0000 (UTC)
Message-ID: <3c92c2ec-dc2d-487e-b87c-1738737f8a7a@schaufler-ca.com>
Date: Wed, 31 Dec 2025 12:52:03 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: /smack/doi: accept previously used values
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250930123153.138644-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250930123153.138644-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/30/2025 5:31 AM, Konstantin Andreev wrote:
> Writing to /smack/doi a value that has ever been
> written there in the past disables networking for
> non-ambient labels.
> E.g.
>
>     # cat /smack/doi
>     3
>     # netlabelctl -p cipso list
>     Configured CIPSO mappings (1)
>      DOI value : 3
>        mapping type : PASS_THROUGH
>     # netlabelctl -p map list
>     Configured NetLabel domain mappings (3)
>      domain: "_" (IPv4)
>        protocol: UNLABELED
>      domain: DEFAULT (IPv4)
>        protocol: CIPSO, DOI = 3
>      domain: DEFAULT (IPv6)
>        protocol: UNLABELED
>
>     # cat /smack/ambient
>     _
>     # cat /proc/$$/attr/smack/current
>     _
>     # ping -c1 10.1.95.12
>     64 bytes from 10.1.95.12: icmp_seq=1 ttl=64 time=0.964 ms
>     # echo foo >/proc/$$/attr/smack/current
>     # ping -c1 10.1.95.12
>     64 bytes from 10.1.95.12: icmp_seq=1 ttl=64 time=0.956 ms
>     unknown option 86
>
>     # echo 4 >/smack/doi
>     # echo 3 >/smack/doi
> !>  [  214.050395] smk_cipso_doi:691 cipso add rc = -17
>     # echo 3 >/smack/doi
> !>  [  249.402261] smk_cipso_doi:678 remove rc = -2
> !>  [  249.402261] smk_cipso_doi:691 cipso add rc = -17
>
>     # ping -c1 10.1.95.12
> !!> ping: 10.1.95.12: Address family for hostname not supported
>
>     # echo _ >/proc/$$/attr/smack/current
>     # ping -c1 10.1.95.12
>     64 bytes from 10.1.95.12: icmp_seq=1 ttl=64 time=0.617 ms
>
> This happens because Smack keeps decommissioned DOIs,
> fails to re-add them, and consequently refuses to add
> the “default” domain map:
>
>     # netlabelctl -p cipso list
>     Configured CIPSO mappings (2)
>      DOI value : 3
>        mapping type : PASS_THROUGH
>      DOI value : 4
>        mapping type : PASS_THROUGH
>     # netlabelctl -p map list
>     Configured NetLabel domain mappings (2)
>      domain: "_" (IPv4)
>        protocol: UNLABELED
> !>  (no ipv4 map for default domain here)
>      domain: DEFAULT (IPv6)
>        protocol: UNLABELED
>
> Fix by clearing decommissioned DOI definitions and
> serializing concurrent DOI updates with a new lock.
>
> Also:
> - allow /smack/doi to live unconfigured, since
>   adding a map (netlbl_cfg_cipsov4_map_add) may fail.
>   CIPSO_V4_DOI_UNKNOWN(0) indicates the unconfigured DOI
> - add new DOI before removing the old default map,
>   so the old map remains if the add fails
>
> (2008-02-04, Casey Schaufler)
> Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")
>
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>

Added to smack-next for 6.20. Thank you.

> ---
> The patch is verified to work on top of "smack: /smack/doi must be > 0" patch.
> Link: https://lore.kernel.org/linux-security-module/20250930121602.138337-1-andreev@swemel.ru
>
>  security/smack/smackfs.c | 71 +++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 26 deletions(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 316c2ea401e8..d27d9140dda2 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -70,6 +70,7 @@ enum smk_inos {
>  static DEFINE_MUTEX(smack_cipso_lock);
>  static DEFINE_MUTEX(smack_ambient_lock);
>  static DEFINE_MUTEX(smk_net4addr_lock);
> +static DEFINE_MUTEX(smk_cipso_doi_lock);
>  #if IS_ENABLED(CONFIG_IPV6)
>  static DEFINE_MUTEX(smk_net6addr_lock);
>  #endif /* CONFIG_IPV6 */
> @@ -141,7 +142,7 @@ struct smack_parsed_rule {
>  	int			smk_access2;
>  };
>  
> -static u32 smk_cipso_doi_value = SMACK_CIPSO_DOI_DEFAULT;
> +static u32 smk_cipso_doi_value = CIPSO_V4_DOI_UNKNOWN;
>  
>  /*
>   * Values for parsing cipso rules
> @@ -663,43 +664,60 @@ static const struct file_operations smk_load_ops = {
>  };
>  
>  /**
> - * smk_cipso_doi - initialize the CIPSO domain
> + * smk_cipso_doi - set netlabel maps
> + * @ndoi: new value for our CIPSO DOI
> + * @gfp_flags: kmalloc allocation context
>   */
> -static void smk_cipso_doi(void)
> +static int
> +smk_cipso_doi(u32 ndoi, gfp_t gfp_flags)
>  {
> -	int rc;
> +	int rc = 0;
>  	struct cipso_v4_doi *doip;
>  	struct netlbl_audit nai;
>  
> +	mutex_lock(&smk_cipso_doi_lock);
> +
> +	if (smk_cipso_doi_value == ndoi)
> +		goto clr_doi_lock;
> +
>  	smk_netlabel_audit_set(&nai);
>  
> -	rc = netlbl_cfg_map_del(NULL, PF_INET, NULL, NULL, &nai);
> -	if (rc != 0)
> -		printk(KERN_WARNING "%s:%d remove rc = %d\n",
> -		       __func__, __LINE__, rc);
> -
> -	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | __GFP_NOFAIL);
> +	doip = kmalloc(sizeof(struct cipso_v4_doi), gfp_flags);
> +	if (!doip) {
> +		rc = -ENOMEM;
> +		goto clr_doi_lock;
> +	}
>  	doip->map.std = NULL;
> -	doip->doi = smk_cipso_doi_value;
> +	doip->doi = ndoi;
>  	doip->type = CIPSO_V4_MAP_PASS;
>  	doip->tags[0] = CIPSO_V4_TAG_RBITMAP;
>  	for (rc = 1; rc < CIPSO_V4_TAG_MAXCNT; rc++)
>  		doip->tags[rc] = CIPSO_V4_TAG_INVALID;
>  
>  	rc = netlbl_cfg_cipsov4_add(doip, &nai);
> -	if (rc != 0) {
> -		printk(KERN_WARNING "%s:%d cipso add rc = %d\n",
> -		       __func__, __LINE__, rc);
> +	if (rc) {
>  		kfree(doip);
> -		return;
> +		goto clr_doi_lock;
>  	}
> -	rc = netlbl_cfg_cipsov4_map_add(doip->doi, NULL, NULL, NULL, &nai);
> -	if (rc != 0) {
> -		printk(KERN_WARNING "%s:%d map add rc = %d\n",
> -		       __func__, __LINE__, rc);
> -		netlbl_cfg_cipsov4_del(doip->doi, &nai);
> -		return;
> +
> +	if (smk_cipso_doi_value != CIPSO_V4_DOI_UNKNOWN) {
> +		rc = netlbl_cfg_map_del(NULL, PF_INET, NULL, NULL, &nai);
> +		if (rc && rc != -ENOENT)
> +			goto clr_ndoi_def;
> +
> +		netlbl_cfg_cipsov4_del(smk_cipso_doi_value, &nai);
>  	}
> +
> +	rc = netlbl_cfg_cipsov4_map_add(ndoi, NULL, NULL, NULL, &nai);
> +	if (rc) {
> +		smk_cipso_doi_value = CIPSO_V4_DOI_UNKNOWN; // no default map
> +clr_ndoi_def:	netlbl_cfg_cipsov4_del(ndoi, &nai);
> +	} else
> +		smk_cipso_doi_value = ndoi;
> +
> +clr_doi_lock:
> +	mutex_unlock(&smk_cipso_doi_lock);
> +	return rc;
>  }
>  
>  /**
> @@ -1599,11 +1617,8 @@ static ssize_t smk_write_doi(struct file *file, const char __user *buf,
>  
>  	if (u == CIPSO_V4_DOI_UNKNOWN || u > U32_MAX)
>  		return -EINVAL;
> -	smk_cipso_doi_value = u;
>  
> -	smk_cipso_doi();
> -
> -	return count;
> +	return smk_cipso_doi(u, GFP_KERNEL) ? : count;
>  }
>  
>  static const struct file_operations smk_doi_ops = {
> @@ -2984,6 +2999,7 @@ static int __init init_smk_fs(void)
>  {
>  	int err;
>  	int rc;
> +	struct netlbl_audit nai;
>  
>  	if (smack_enabled == 0)
>  		return 0;
> @@ -3002,7 +3018,10 @@ static int __init init_smk_fs(void)
>  		}
>  	}
>  
> -	smk_cipso_doi();
> +	smk_netlabel_audit_set(&nai);
> +	(void) netlbl_cfg_map_del(NULL, PF_INET, NULL, NULL, &nai);
> +	(void) smk_cipso_doi(SMACK_CIPSO_DOI_DEFAULT,
> +			     GFP_KERNEL | __GFP_NOFAIL);
>  	smk_unlbl_ambient(NULL);
>  
>  	rc = smack_populate_secattr(&smack_known_floor);
