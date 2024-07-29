Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60924653
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291594; cv=none; b=ruNTfqizIu1Vca2zA5qielzZLGVV31uuLWXwSQ82HynUdQjXS45EUTFrKJe4ROBooFF6xZUeFa1WEEgfnolUbR9zaGZFz4gVs44kfHuk/wONWjFslrJSldug7KD7/KHPE+DQB1b3Evr+m0cceS++ByZZGAcW4Amb3vmYcVMZ7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291594; c=relaxed/simple;
	bh=uFue5T7p+msPSssmFDyg5SIwpfbf0gxBCnZxS95H45w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=u5WphFJSSVnkei5RBHbxDkVlRPVMkfFkU0qRVrakvExhMfgIHNgvSTnuRU/io9HYYF+mkbSwcqmACVRuvRPJZy9uQZc5oMXjMapEBICuSPtppsXzZVagLtUd7SSYa5YHRODILBw5lqDhgVDOcyJF1bvCST6dBTqq1Lk8XiffTMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HHoNHj4E; arc=none smtp.client-ip=66.163.185.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HHoNHj4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1722291591; bh=8Q1GEVNfsZZTVbEsPQqG0xM2GiBj4VrXV3uPepkDb4I=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=HHoNHj4EIFCT3iI8DNAsWe35z+w+KZnbuDG0xjk6SpBHTACiJebT9hN6Zsj88mXO4dKwrz8YWxTBCFgRzTMXAKFh3THVTkGL3KotoVU1J3MoPI06u6CqrmuMrPS6DW3HoGaKeRFWXvAPV8Hew+4ZLWBpHOh2ZJ13XTjxaLR76hxTYPR1ACjbwY3MaBlgN+FkqO0UgKKsw0CRuh817adnHckR620m4YvQWOs5H+fgZCjrqbcPWJfQg1s/+qJPMmHwx+BAWLYt/cfXsLiYEjsIy8c7iLfMAEHlAEZl4VcraaJlXLBirZNj5n6B2ldMw1kMZB3IAmYGE3seRGTAeqrmTA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1722291591; bh=JPHpt+dt67SOOVdQYBjeinTpbMNwdwZSX41VhjvlRu3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ssKrVwBb43DwD9tVWi6SrrNB7Zt4+gTIPfrHSOCnFrWo2gmoqTyuZI0JwjC4Md8Sw04gIWt2bNRwbPME2sP/Awog+jDyWTpAKXseXBKUoXRMxOK8HkaDu30Rnm3DzK+SQvXYg5zECM3bsu74XnPOPHNhXgRJK7AvxWOa90xmAJ7FNxr55T12l8Y6B5f9ZbYarH+UnIPW7qtAyxF42iysjARCcoJXNEkrdzWdb21FGi2e2Un8Dh3GN108cok4ppMj8UXPxZoe9uOpHZPbYh31xRscE0mFmSKaZewkiF4vWMpsQgSDWXzHqyEbXv+8WtfHbdUtYAeUnzolzq6vLu7aRw==
X-YMail-OSG: d7VGCmMVM1nX4948aW_BFuH_FUdlhsOMUHGjS8qzYt_V3GmkCePILKIhH2F0cK6
 3aAj4wriNVmtUrZGGkruhbirMFwKKGcQ6Ymp_pxjYUBWOyhEnfOY_ff26TveKEUUPmifXbCMrZYp
 qDX.DtrSHsHgBNEOaPE4mE3WaLpOFjJQL0c63yLcTPx045ZMVhHtRCpTD_Qe5YwXir7BKmM2XRd_
 F.ObGlOE9cY9Kt8v1RT75i8N0J4brd923hDOmKM6naf.lzdt6r81c_Sov4iNM5UJrAkV7dosmKho
 gA.HUnobELYrvujyx3NMvVbXkJE9AJwXSbWVMQsMVPaU6C0FqENl6xZHzMIrKpCuOOxNEexo592g
 D9ygqtwfxfxkr0pykF3rqMguxq_EK8MKefNsZm9iitoitIFH97gMrzEtl8aYPMzacsCO8XIbFwy4
 n5V0Ke5VcT69hyBlzfYAjaq4t1p5ja7xb2JE6xIiOKwVGSyxY_5LHsWvHal9LnyUHbsf3MFstcFh
 ktskz_N1jB8887kWWvRT1DvUubsRaC9Gk55bjWUEmdYV7YT0CT6F22mrAMbFoQnV4NxpPMGRiRDy
 F64rQRvmp.b8fax05qeh9Ix.YVrJy_8.ErgySPgRMD1usRcC6aYpbjoaiY6muE6QU2qvcpoHcuTR
 8Aq0.45Iq8LGOEtef4KJnFZnHyznUvH3QBxB62ZF9eKfoyN8efpcjqcWZ2c6Qmih7NO6X7.ZdpZt
 yC1FuHkZvB4oPOEB1cXKMqD7FSMruPxZvMrrogj37.43_GUEOfDnV7IwKcWnNR7OS8FWa74q4aqX
 aqIbKp9VcpSgdLLwrn7wbyL_anSfA52k_Av6lhnQm.hqykIPHvqvc7kUzSt4rZpJm7y2bXNoituZ
 9BAr_TNopQg3lHjXUjpjBVbP1Gml6c6QxFdDTWzxsHjQ.ql8bwfqF8.dgYjkJYR6rEhd9harmCdL
 SvV4CIO9.o_pMJMSpkVJRXKPx4I0EmUl2mQS2LdpwJlg8MX2pm_m0Vuf_SMNI9P.eXD8mozSE_EU
 4vC.EKz1r42IBAHGC5UA5LCxHp6aJ_abID31CokYq9QdFt3lAT.fyWQ7TwNm.H1vmumJzc0E83cW
 pXHykrrLwlef.g2G_J8l0cGGDRVkZ2nEz0rdKU127cvvHmlJuwQzjKXWQmRZ7yjan_MKSmGI.tOu
 u6M6f9A4fBP.98yc5JrR5AGzHhlY97ZiibzaEXqAI1cJsuNMdxDaT2fbf4Ppf65T5Y6c09GZgG_d
 iesa_Q5UKJD_5_OpDmXTLc5WfHFfbGJ.JiMcxXo89IxCK1ZOKDmDoIUVAOZRw5jBZH_WLohThJH0
 oXRrHoPIUGFkKIjcSrIHb2eYwXEG_VUwZnrJPrbUbn1.18halTSpEKTD3ywK0pTxyWmnn5LndHcS
 eb_pu8sXXs2caEzxvyauXS4W8cDPTvVsLcTCjr8EgVOW33q035.A4w277O_HC_.knuJi4o_SC4Nw
 QBw0NFfx6IYHXfkKaxx8K5FmGt8cWOT0TdMk9QW6pu.jk0LOiU.rN0Ll6lir_rSpmxv5nLgIkzJd
 kztR3KqY9AyVuVyozsjXf_Dj2IBIwcXJZWq0V1jKwkgjX_DQtI642DwaF4mHm.xdo9wyjtJ2T_6R
 N34Ro1TjL_RTvtarZMCnZQhMTetEo9XAz9VO4SIvRdMlXjaGBQJI7quErhtDYXIsPjM_ZNOfprDj
 6YfInsGNcB8zAVWmXmWNP7GaY4kXqmCXpRaCgpuaZTlVFXLuP3mCCpMuImONZqsYceNlOJpF85QB
 vZZ.7TxWJ3zzVIKM3altGp7GlA4DRRnR.nHnMgyC2wHtJtR8mwtXCSmLa1JCjHnUfDrE0y8DHFte
 gyudj5DLC522Fr2Z6k2wlWITGFrsywymU5a9OF_13fGseGK.ENlCdUI_p72eYq7QxMAG7sumzTNM
 9W8gtzGf0.xRSJzbDsIj82pYqiv4nDOs8CR1ESvTrvXYsYdpkrto_aPLwBO0WjtBUnBoktr3tEml
 4SkIr5XQY7c8vCh4U6BSZkEkTWc.DM.tBDPGAzQx_51_ZE8oh4EFl3QW9o2SiiyvOTIgXcooIrCs
 js1pxSE0cN_Ez.sx8z6oKkUMeW6s4QGcG_tb8sk01rvxVyd9e9bAfNjIxQeeJWdIDVollJujKr_u
 gUc1eFXaEchSpoMZBxGjSXtJKM.M3uEALUAKeOILOeU_tKLyqul_4GmXIv4Ek4PIuTaSqW0lqjPU
 nU6NqF041BCsW6_2kmpEHZ0J_9614EOSegTYljg65HJbWoif_zixzdVD5GCY.ZRafDAAwAPYpQoY
 Mumg1
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 983562c8-dec7-4038-8297-1b24dc8a33e0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 29 Jul 2024 22:19:51 +0000
Received: by hermes--production-gq1-799bb7c8cf-zh7nt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9edf7fb820238b006d648f0715dda5c7;
          Mon, 29 Jul 2024 22:09:41 +0000 (UTC)
Message-ID: <519e4173-56b4-4b0d-850c-ddb590a75e5d@schaufler-ca.com>
Date: Mon, 29 Jul 2024 15:09:38 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: cleanup lsm_hooks.h
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
References: <20240729215702.318099-2-paul@paul-moore.com>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240729215702.318099-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/29/2024 2:57 PM, Paul Moore wrote:
> Some cleanup and style corrections for lsm_hooks.h.
>
>  * Drop the lsm_inode_alloc() extern declaration, it is not needed.
>  * Relocate lsm_get_xattr_slot() and extern variables in the file to
>    improve grouping of related objects.
>  * Don't use tabs to needlessly align structure fields.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Sense of aesthetics aside,

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h | 82 +++++++++++++++++++--------------------
>  security/security.c       |  2 +-
>  2 files changed, 41 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 845457f0eeb7..f0dd453b39d5 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -79,8 +79,8 @@ struct lsm_static_calls_table {
>   * Contains the information that identifies the LSM.
>   */
>  struct lsm_id {
> -	const char	*name;
> -	u64		id;
> +	const char *name;
> +	u64 id;
>  };
>  
>  /*
> @@ -93,48 +93,30 @@ struct lsm_id {
>   * @lsm: The name of the lsm that owns this hook.
>   */
>  struct security_hook_list {
> -	struct lsm_static_call	*scalls;
> -	union security_list_options	hook;
> -	const struct lsm_id		*lsmid;
> +	struct lsm_static_call *scalls;
> +	union security_list_options hook;
> +	const struct lsm_id *lsmid;
>  } __randomize_layout;
>  
>  /*
>   * Security blob size or offset data.
>   */
>  struct lsm_blob_sizes {
> -	int	lbs_cred;
> -	int	lbs_file;
> -	int	lbs_ib;
> -	int	lbs_inode;
> -	int	lbs_sock;
> -	int	lbs_superblock;
> -	int	lbs_ipc;
> -	int	lbs_key;
> -	int	lbs_msg_msg;
> -	int	lbs_perf_event;
> -	int	lbs_task;
> -	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
> -	int	lbs_tun_dev;
> +	int lbs_cred;
> +	int lbs_file;
> +	int lbs_ib;
> +	int lbs_inode;
> +	int lbs_sock;
> +	int lbs_superblock;
> +	int lbs_ipc;
> +	int lbs_key;
> +	int lbs_msg_msg;
> +	int lbs_perf_event;
> +	int lbs_task;
> +	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
> +	int lbs_tun_dev;
>  };
>  
> -/**
> - * lsm_get_xattr_slot - Return the next available slot and increment the index
> - * @xattrs: array storing LSM-provided xattrs
> - * @xattr_count: number of already stored xattrs (updated)
> - *
> - * Retrieve the first available slot in the @xattrs array to fill with an xattr,
> - * and increment @xattr_count.
> - *
> - * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
> - */
> -static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
> -					       int *xattr_count)
> -{
> -	if (unlikely(!xattrs))
> -		return NULL;
> -	return &xattrs[(*xattr_count)++];
> -}
> -
>  /*
>   * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for void
>   * LSM hooks (in include/linux/lsm_hook_defs.h).
> @@ -153,8 +135,6 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>  		.hook = { .NAME = HOOK }		\
>  	}
>  
> -extern char *lsm_names;
> -
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>  			       const struct lsm_id *lsmid);
>  
> @@ -176,9 +156,6 @@ struct lsm_info {
>  	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
>  };
>  
> -extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> -extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> -
>  #define DEFINE_LSM(lsm)							\
>  	static struct lsm_info __lsm_##lsm				\
>  		__used __section(".lsm_info.init")			\
> @@ -189,7 +166,28 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  		__used __section(".early_lsm_info.init")		\
>  		__aligned(sizeof(unsigned long))
>  
> -extern int lsm_inode_alloc(struct inode *inode);
> +/* DO NOT tamper with these variables outside of the LSM framework */
> +extern char *lsm_names;
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
> +extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
> +extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> +
> +/**
> + * lsm_get_xattr_slot - Return the next available slot and increment the index
> + * @xattrs: array storing LSM-provided xattrs
> + * @xattr_count: number of already stored xattrs (updated)
> + *
> + * Retrieve the first available slot in the @xattrs array to fill with an xattr,
> + * and increment @xattr_count.
> + *
> + * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
> + */
> +static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
> +					       int *xattr_count)
> +{
> +	if (unlikely(!xattrs))
> +		return NULL;
> +	return &xattrs[(*xattr_count)++];
> +}
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index 780b84f5d09c..7ac6765f9260 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -764,7 +764,7 @@ static int lsm_file_alloc(struct file *file)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_inode_alloc(struct inode *inode)
> +static int lsm_inode_alloc(struct inode *inode)
>  {
>  	if (!lsm_inode_cache) {
>  		inode->i_security = NULL;
