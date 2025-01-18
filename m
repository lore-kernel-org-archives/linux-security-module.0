Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5B1A725A
	for <linux-security-module@vger.kernel.org>; Sat, 18 Jan 2025 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737221274; cv=none; b=hUscP/Is4ll31r8QxxnkxqNrUE5135XQ7C3H42i+f+ND4XHxD1+Q0NdiEOnYszFTKc9TPu3S2FmbXUFSA1s3619JSB/jpWSc+k97c/d9Gj2AIGgc9VFNFzmLiogQWFiSLvssNgjUPmoypfG+vT7eM6FcYxwW5E9JgB3G+0NKb6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737221274; c=relaxed/simple;
	bh=Cpmg6Jw5/9k9HD+VPC8V2OoXO9dzUY2zEU3kK5U4aB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgtXDv4eICb+V6EdUfhn+uyrEaMjPZGGApEFka5IZCQ3G/MXcgWreG/p7Fqd0ceVT9CURroAQTRe4jQNxnx44QiMrBpK1EjCfKlVhJnCaepUSJlUaqF3L03L70OcUJI7b/0HMIvQkMFKpSgejia50ynfxKzeZ0Qx2WLhPlspfTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TQsjmduH; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TQsjmduH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737221271; bh=K/7imn4gd5/o/U/ucMyj8k2yeRDK9dTDA0gSNUiEH+w=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TQsjmduHcDCip32uIDfD2CVxymVOdcziMpmMwGWXp0aQuUciLAahnciCkV/cpoEIWVR5zYpE/soA2GSY+ixbog58G+hOZYu87AihReBUPYR6ojUc/FeEx2R1Gif9GpZmJaNKVY2Ax1hWwzJr6EYGSrbRYuN4o8jPzR594gDtdlyQUDu1bE1oxTb5rXlRms4vYEwIgUasIzbmhj5oRf16ojKS4b14PdznOgrs09upq6xtJXuluW7bI6N2iJh8e5HZaFfHMLArky9s1KzEx7yp/ifz/b+NLRtE6BMr8imoht5bhfhDe3CoyfpiSJN5k2ajVqP3CYq20vlUx5NmnzlzWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737221271; bh=yqCmLS8Wa4YFhtlhO29EEvHEl006Q+nQPgQhLO91wMP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=krxhju5tjQNC83sYu4al0wlDA6OylSXJ93pGvzb2K94gtXSzuGk2L5Rb19I+BEfeOVSquOz+kVd3OR9BjK5rOAhg37aRBRcSHkmSZgw8mxIsg9k+BOOCvreO7+t86Ad2vCiBq5MaHHnBcbuiuWm1qjERkNW07SaKYX36SfXHkmryGpiE7++ZDOg4EO7uA0oSx9Al7sLicVpylOFnUTpRR+RHC2hzxGLgEazAt+zwBkoCbgdsXj7T8B043f+qgc4kZn0onlJWqj4ds1sPVHgWVXNacluTCNrhCC1JizJe2YGXYXrRrZ8sYnSZU+4b0Fu6SiuscFlBhMSoHCKj7qZO5A==
X-YMail-OSG: nHndhQ8VM1k4PBcxMMh6xFuO5HE.DxDl1RD3ogpg6DO7MZ1DdEEKwPAe.LmBSZp
 3PoKPz6.MechP3._.vzpOlwgOF57l7kKWwjDoYBPHb_fsUFoZJBPfTYjnXcoph12ru9cr.tYkBB.
 y1OHD70n4puP.76aaiU6gyGlv.dTCZFk4FZ_OxxFAHvX9_8XrzgQJODkSXkpinfr.PCOsDV3I_2a
 DOyoKL08exNWlrcGOGviR6j2eUfQYcEqngMbWlWqwpwqHPyfNFCoAXU6SSLCQY.LtbHyHw.huWbA
 RMbd8hOEfxdAgDh.ll0PgMXGEYFxuBs4xOGyQZmOTbOZrhIuQPeRAoykiZ96KDoj3SHAXBVGYUYq
 vsCJItwvoB4BHAi2K95xS7_8SiTw9pkHXvTTepW.bB77pUINAnnK4ICZJC3mF1UxW9xSkF44wq24
 dhbcD7yreRK.8JcShO6dyazmktNLXcJf22JKKPCJPCrMcNgVnW_vF0wb9f5NK.gSIwTJkGqqUUgN
 kU5BJcj5PR5.Gt.n7szsJhx9uWR0Kdmy9Yn4Eup_2w2Yi1A5iX4.1luYVU_6HEaef8khEJg6wfYI
 NUU4ezADOSC4UNIDXlaQRwblLWs1pClbCK_MkO2LMfLA4NXbI6VJ2iTVgy5gCkdzAKLt54kocn9R
 sVFYTEqCtLcoMe2_0fmpFn0oKqwJcy8jbsXTo4adNnTYS2ZxH2bcSu0efF4PecKXRboGFxxEFi4i
 CF_NXY5JiqbJcefOzeyF8eyLfs6SwsWpZfppE8ksBaRGrFbw9ftCkiFV6lsc6.cl2p94HmQWxTgc
 PTtZz.ziFeMJlkkJkIAAvlQK_Pp02T0_GIblXFZvCTsfS80NSJ_0Y6nAgpoPpDJZi0Ep8pqfSkrj
 h8Nq21KPWhHfy0wzAN1.AVtLuAmsGnyjdlPu74FYwGFSeF3nPZeLFKWoqRnFB2P3PpKawh3Xxhza
 ETTdb2i7nQFRLkTWdheLXJk_IHIdEOAbUHTMQeD5MCdu9f5mfYm_AS.kqLL0EU2JD2kdzOF9Bc9q
 JZUiuse0IMpBTdbZ03r9wE6DIogSp5pMDeG0nwH0UPwV6UUKbX3wZ_ysdFSBVjmIkrSgGk8ro2Rv
 WzHuxU467JIPUP3bL0AcX14tpAPxclZM70cYRVQAUlHCbtl600DxMqSAQdXXNTJ2Lr0Aw_ZVZbk3
 2m.gx0tBOWbHxqAQqsXAFb.cnTN0z7nvsXPAVvS7AsM2TzstT_JEc2yjTkkAvDsaM1U1VjVGV8.g
 bmW6v3g0MN8xPQZGZ_f7i3aa9X2U.3Ut8m_DZgJleT4tj.NuQkh5AGOWo5KtmwnAIvXNDinYPrlq
 U1GbhXpJygT1Fjh8iBxTbzo1KszYeDcBJqdF1fhwAB4wp_Mc25f0VYt2TggQhVL4Sxk8MvyHF2E3
 ZlpxyykqcYD9BLzrc4kT2vH3ji_4XWYV68fd_Cow30ZKuu1MZXxCjZ5qiwQkN16uATIGnBzQzS7L
 7O.oLE7MEX.q66zDIXkkudrDan5gUCPNtOBN2swKo.DQsy7IPz2UlUqBopojX3E1S7r5ZNciHEgR
 ll5EvL2MuiGtgjFZG02B2G96JFEg4jRzUb7qIpPUS4pRYwQoffHbUCWzUkCZmvxq4gtQHZU3NFzo
 HXWmYdSMHVl_iWL7cWgdXuXOvvcRwDyLuZRun2or30L3dNr4oGtBV5LjVb1yBYsTETFHaLZ1fAJ.
 S5RaT7GKWoihP2CBG8UcOxhI1pCkuVU8c5Qox_g0JIhI24AEK6AQExBFivLAfJmqjQrxLS7uw.9A
 dYW4nyn3zci7PqO8ROmrb3fOytsb7y0y2i33gLMjRgBjgkbu6kjJWolQNaa.eDHF35aAqGLtyQZO
 7kR4gbtVC7lgDA_duuVgQgEHDJUKKt0cIM4IulyHTOy.VfzyTKCwVfYyjmXwR3.PozVs0BI.e8W2
 5lgQWZYMeWwGYwkGOeZYnRgF3xw_vVu27sH.pl_ZTb5U1PwBLT18xJ2uVAl.ZDlWIv7Chv8rtOW8
 LY3HDdZbOW7.NSuGIiILpeWKnrtRAAkA_CldlcP0MPkR.z06ghGSM34du0I8BSaJKYEmYv6neYNt
 wbs1jSJPvjtFd7xef6oyq9zd3pKnCjPlgSB9u90u46YHM63CBn8uAQXUrLHoyEcWoAcGxTUBrNDV
 gI_RviNJ9EMP8GBryONnrz3EMQcg2_KqAvKHJakzQkKRdtKQmiDmE4sBEkGgGqllmdQ1OTUbbbv.
 PPOxRepaLTwKhVEYfQs30Px.oQQBoJe80MCSAgRlMHmSbdsZ8mA1rmMndt9lQUgiV8ZdgDDDKuNq
 zpbFElUY6
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c7b56288-7d27-4037-bce8-0d88361e3e78
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 18 Jan 2025 17:27:51 +0000
Received: by hermes--production-gq1-5dd4b47f46-5xsmt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 643d66c3e396314676b29aa96ca3a51b;
          Sat, 18 Jan 2025 17:17:40 +0000 (UTC)
Message-ID: <5589ad00-89f9-4f87-9de1-c869fa527c8c@schaufler-ca.com>
Date: Sat, 18 Jan 2025 09:17:39 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: remove /smack/logging if audit is not configured
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250117214655.3138888-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250117214655.3138888-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/17/2025 1:46 PM, Konstantin Andreev wrote:
> If CONFIG_AUDIT is not set then
> SMACK does not generate audit messages,
> however, keeps audit control file, /smack/logging,
> while there is no entity to control.
> This change removes audit control file /smack/logging
> when audit is not configured in the kernel

Is there a real reason to do this? I can easily see systems
that expect to turn logging off getting upset if the interface
disappears seemingly at random.

>
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
> ---
>  security/smack/smack.h        | 12 ++++++------
>  security/smack/smack_access.c |  2 ++
>  security/smack/smackfs.c      |  6 ++++++
>  3 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index c4d998972ba5..1fb6957545b5 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -432,6 +432,12 @@ static inline struct smack_known *smk_of_current(void)
>  	return smk_of_task(smack_cred(current_cred()));
>  }
>  
> +void smack_log(char *subject_label, char *object_label,
> +		int request,
> +		int result, struct smk_audit_info *auditdata);
> +
> +#ifdef CONFIG_AUDIT
> +
>  /*
>   * logging functions
>   */
> @@ -439,12 +445,6 @@ static inline struct smack_known *smk_of_current(void)
>  #define SMACK_AUDIT_ACCEPT 0x2
>  extern int log_policy;
>  
> -void smack_log(char *subject_label, char *object_label,
> -		int request,
> -		int result, struct smk_audit_info *auditdata);
> -
> -#ifdef CONFIG_AUDIT
> -
>  /*
>   * some inline functions to set up audit data
>   * they do nothing if CONFIG_AUDIT is not set
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index 3727379623e2..606cb340e819 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -45,11 +45,13 @@ LIST_HEAD(smack_known_list);
>   */
>  static u32 smack_next_secid = 10;
>  
> +#ifdef CONFIG_AUDIT
>  /*
>   * what events do we log
>   * can be overwritten at run-time by /smack/logging
>   */
>  int log_policy = SMACK_AUDIT_DENIED;
> +#endif /* CONFIG_AUDIT */
>  
>  /**
>   * smk_access_entry - look up matching access rule
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a7886cfc9dc3..c28188bc2bc8 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -41,7 +41,9 @@ enum smk_inos {
>  	SMK_AMBIENT	= 7,	/* internet ambient label */
>  	SMK_NET4ADDR	= 8,	/* single label hosts */
>  	SMK_ONLYCAP	= 9,	/* the only "capable" label */
> +#ifdef CONFIG_AUDIT
>  	SMK_LOGGING	= 10,	/* logging */
> +#endif /* CONFIG_AUDIT */
>  	SMK_LOAD_SELF	= 11,	/* task specific rules */
>  	SMK_ACCESSES	= 12,	/* access policy */
>  	SMK_MAPPED	= 13,	/* CIPSO level indicating mapped label */
> @@ -2126,6 +2128,7 @@ static const struct file_operations smk_unconfined_ops = {
>  };
>  #endif /* CONFIG_SECURITY_SMACK_BRINGUP */
>  
> +#ifdef CONFIG_AUDIT
>  /**
>   * smk_read_logging - read() for /smack/logging
>   * @filp: file pointer, not actually used
> @@ -2190,6 +2193,7 @@ static const struct file_operations smk_logging_ops = {
>  	.write		= smk_write_logging,
>  	.llseek		= default_llseek,
>  };
> +#endif /* CONFIG_AUDIT */
>  
>  /*
>   * Seq_file read operations for /smack/load-self
> @@ -2876,8 +2880,10 @@ static int smk_fill_super(struct super_block *sb, struct fs_context *fc)
>  			"netlabel", &smk_net4addr_ops, S_IRUGO|S_IWUSR},
>  		[SMK_ONLYCAP] = {
>  			"onlycap", &smk_onlycap_ops, S_IRUGO|S_IWUSR},
> +#ifdef CONFIG_AUDIT
>  		[SMK_LOGGING] = {
>  			"logging", &smk_logging_ops, S_IRUGO|S_IWUSR},
> +#endif /* CONFIG_AUDIT */
>  		[SMK_LOAD_SELF] = {
>  			"load-self", &smk_load_self_ops, S_IRUGO|S_IWUGO},
>  		[SMK_ACCESSES] = {
