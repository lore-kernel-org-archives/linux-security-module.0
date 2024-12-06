Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66B2220687
	for <linux-security-module@vger.kernel.org>; Fri,  6 Dec 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506286; cv=none; b=FtHWT7BJyBBKxFKqDer1vP6iKWu/93xKkmUs5FdhN4awZPPCFWhjs2OSz5QsEVLD9kTwC4o1nDoyDhatvy7IyQBM1mng+4bQZx9bkzkq23sX/n+I97t/7v1FnXfaF10DiiR5Om4ImTUsjOpkfNu362UL4LOoQW6tH88BtBQHWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506286; c=relaxed/simple;
	bh=yu8OqX3ajrhGNi5OoZzH2zGVE0fOfTtjILscNBnxHE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoRFNh+MswsI5lnT/RZAnNdyzMlUTblI41wz7M9obq9YQf+AFlhhsIYOkw4CArJSQl+RfouyH8D9Wp4MP6m5ydVodJXtMcjKxraWB2nuAVxlU5IitHlkutjLuisRH8DzLLocmiYmQasiNNT8AjzOn4GMukDo1ZRYfy1Q3hSR6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=iKzazBxi; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iKzazBxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733506277; bh=j5K0xGK8JbeYPhrngdk51VFt2kWShTfe0AnUcJRVKi0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iKzazBxi0UXEGkpId+wN9R++h+WlbiPG6dgzIeV57V4wOFtPrsMhW3yINF59mdnHLq2pboNiZIvB8rnGEf6NPEkMQOLVmkS0qKbqy4NLWsasLu8s9WStkrthH11W6YYXG+UDodmAARjo0gSnPuw5RJt/OhRlMWZbJbRCBADzQWGXn+Hxpp5yFaZ2P32l1nz4phZZGDXd7YROiDahoX13W58HBeALJvaTgbcT9zjjGA6vdU2ll24RefnyAN2hm6ATwKCAChlaY6bqn5Xi0a0CWcIfDWroqb2MGlQn0PKYsYKJ6AHDDrYKoUpEXZSOgvKTzmOttQK6EIZJoS/eWFb0Lg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733506277; bh=FNuAK4NNbmQQM64aexFPaDdc8gzXdVBUqWdU4Z7avNU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=C67RO4r12Nuutma6NiGWXW4NInemnHfMBqsZpNvyXrnUlxfhvfKBZ2ALiXiEhKZB4glxaLwy2zmK+MWk3bTMYmZksJ4JD2qWPTDhz2Hg9xAMTWCG/fpBTe7/WIeaibccTSuE8dgPNITFdQhEYRKLl5PbVlbkC6gLSteqYIoHVF+IT64V1aWbGbAGqkb236YgZvD1URKhu+t0o+eYqD8EGGMGgcpeWiyRNfYRAFZ9n8Wt0lux1D6ORsryorATlBCKlMvxeVEn957LPY+LM+gvi1EzHYI8ZZTzazFc3bEsh2cnDDJ7LOCEiBsMGu1buPTALJyOsL6bFgSG5aCGmJ/K8g==
X-YMail-OSG: ZzKOmu4VM1k9OnZ3TsW_H.7nSMc_KcMaszdvm9em8YdJjygCn81ANT3W37Nfgoi
 YetoEH.BNHq0kF1Rn1jDbyiDvycsaC4.NjX5RuSWAZZ8GCQyCgBv_W3SBJrMX8nIGSyxlHLxbw4t
 KEHAxSZVJGf2TBZUDBxxiWuD4lZchM.v_4FB7z96uXHV6J.R7gTLHlqbjMa0sQ3styCaV_jN.Lax
 wtKGRdKRXNlpS6WnQ1H7ikxy25_PcmE9zpElLh2eg8NtS9nWt0SaBFKrh8CfLmhKwtKC.xuofNR7
 oooSax6X3NhIlsHd1nn5HUUHzw.o9XKAGX34ACp5mIPcv5X8YCkRi57G07s63oTWVNxXxi74r_nW
 DfBQvE86pYGljKBKl7kf0pC4PoNfsmkYgh2e4RqpS_tufJPrmNT85SURfy_10j0nqHFLMBOhvMwf
 anQ.Z9OmFU84FXQNYiF.tDDtDcmc3qzhKYPrAHt90uyDa5sDq6eCgfZ2zOoHZ9qJq6rZHVykvVhn
 80Pq5QCCo3AFyP5d5rmowJYpajzHyhQX3ErMruDOKk5nRJtCd3.SkgNT27CI5KROOsL6wcZ1VMP8
 dFcZgcSERK5LMywikXNTD3qWsheuyJya8wM8pdLx80sj3bVKidHUj.l4NnAlfQEenyuZucNma1yV
 hgbNZj39C_j0j68BGgKUb4Q1LQdQo87lnYzsW4lFIkWlPSaoGymVHMh57he73sJVJH4dPADS2nY5
 mTbVEAD5Q6LkIjmCrPbuM1WQHBPRNQCZx69GiqG5WdKBwXCGUVFCCHFyqK2gy.sSXcZwcq86Xx5g
 .1QHPZWQR6xvVqT5VO9D_GeikcHTrhUaMeliQzNYaRPENi_h4vB13yY7a9NmSWkLXWO7UYFZhGF3
 ppqc_5CbyYCsDX7PKnDwPZ5Alcj3FTfTqHQThEKJMnNz1KsFBA2.X77GCHfwbQny7BauNObzyxny
 _W43binlxCyfJXpJ8VPcQkYA92YNYh1dJ37YCUAJN5SbFA4IWANhm8Ma_zIfwyty7zgpJIP3QRVv
 xDXV9ITLMsvot_eiIifxm_1wRRuuNoJiX3k91Lgm3vhzNTWoTZofI8VosuY1zMlh0Uo0cYLH.smp
 HupVH.Mpj5LDd2fxaICzyA_Kzr.IIA1kIU7Trq8Y42jFZJQfxo4546xSnRLtR2FKcjl0HaU4vLtc
 Da1C5teh2obyYS.GB4d6wPsqkiYBdSRCB_QwvEJuQvNnwsH3ooVeS7wQSrQG.1ktrmFBkMTCX.ma
 wj0UZLR7NQAr.O6SBmSI5aShP73Nw_pEuBsLWFGtSnTdX_CH7S3RjSAFR1laFWUeqhcMrdlOQpra
 nWCSNMFi6yGZ2jHuVghkpeMijcnD8kTmzlK2ieRq9BYI01YhMGCjnd8PK3DFU8D8er90Ft0TiAIO
 y9q_1tlkqDkSvpfYFLv7Dt7Yl3H6c54uTFUTw0yxbMrxcp7i4YszpzJP0_Nxz9vQy35UKwDcvAOf
 7eLi6_.CLfyqwrcYdmZcQoXm8V3a6Ncz6tEAmCuSe1htabWjw.6ZGzyHqJqXGdezqtkxV4Zjzytp
 JaVjVly8ow8PgCaGjyQSbEHQJDlouaENPmFqZ0EfnoFKuOgJAcLsRtcQ3sx.Xz0neMSL5SzZAhG.
 ewFUdMj1Uab42xSPVUL0bkTIBzF__1H400kODdFH6WH11TgTLthvSVkqJPwwZG0n0PLVIE4NbRm0
 eQYRA9M7gwxGIwNHNkvxnmdIKdwnxOohf.cBQ2lwxZWLkyklyCcYKTXYM2roPcNjsiJPbzvbgGXC
 c29RxppYv_Mt.KMC5YOAT56tMi3UqpKr9wUxSRn9Vtu2SbZ.rwN5v_SKwaeLGayjUz5WrJR8GdWP
 zkF6z0Dx_St1uIxFVfrqhmVjtszbghR9GYwSohqibfpld9hO62w1iOBXyU.9y78cbsBD6BsrLMdN
 BdPvpugqK6Ghkc5XXBBvZ0eXYE8IHh86Fo2e50cQph.dexrjl.Vu4nXFun7pLOoCZ3G4v1HoyX_s
 J06_cF6.OAJQ1SZZBg5JDtahWs3433Yw3e6BZsHHqdBMqMWBqCgPpV3tNZ78t_w.b8_W7RnkR0EK
 0hjbr3LyvPddAJvu3Hd2saKCGJrPovC_n5e_ByPx5FZp1ZIvM7KrI7hVCgcjsW_8KCnKqUOISzQ4
 lrlRI5LjgzlCjbqleupC0AbYcjMr6boC0j_OMvQVd1ewXSTbSdepNTg3weROZKKk2v6BzhVMP38k
 1x_SjsDN65V2YX3ryDVnBYlvV5qzQvVexhLJtzERxF36DBOG33WShAbVzkB0CBPUb6VA2JWkQe.E
 SHqoAwp2C.w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fb0ad389-7b55-4b1f-91d3-01774a3429c9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Dec 2024 17:31:17 +0000
Received: by hermes--production-gq1-5dd4b47f46-pfhh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 15f76afc6bd5d564891b81fbe5d419c8;
          Fri, 06 Dec 2024 17:31:13 +0000 (UTC)
Message-ID: <d772e32c-446c-4b89-bbe9-93f68e8cede3@schaufler-ca.com>
Date: Fri, 6 Dec 2024 09:31:11 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: add reserved flag in lsm_prop struct
To: 15074444048@163.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-security-module@vger.kernel.org
Cc: lihaojie <lihaojie@kylinos.cn>, Casey Schaufler <casey@schaufler-ca.com>
References: <aef181673159ac72f1e7922548186fc6@paul-moore.com>
 <20241206114108.342819-1-15074444048@163.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241206114108.342819-1-15074444048@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/6/2024 3:41 AM, 15074444048@163.com wrote:
> From: lihaojie <lihaojie@kylinos.cn>
>
> lsm_prop size is controled by macro, lsm_prop size will be 0
> when marco don't define. add flag to alloc sm_prop basic size.
>
> empty struct will make target_ref & target_comm in audit_context
> located at the same address, __member_size of target_comm is
> same as __member_size of target_ref, so strscpy warn buffer
> overflow when compile time.

Can you cite where this warning occurs?

>
> Signed-off-by: lihaojie <lihaojie@kylinos.cn>
> ---
>  include/linux/security.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cbdba435b798..f502deecb142 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -164,6 +164,7 @@ struct lsm_prop {
>  	struct lsm_prop_smack smack;
>  	struct lsm_prop_apparmor apparmor;
>  	struct lsm_prop_bpf bpf;
> +	u8 reserved;
>  };

I don't care much for this approach. Increasing the size of the structure
to avoid a warning in the case where it isn't used seems problematic.

>  
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
