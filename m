Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63794503A
	for <linux-security-module@vger.kernel.org>; Sun, 16 Jun 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718560497; cv=none; b=jcWW1WpzrKnADB0V3oxvgecDgkeoz8a98xTN6KDleNvUrDzyl9dcK37uzAHKp7srxB9vyqAyNKxzQ2XXtUeMvbjOxITT26KfJCfq1xmdgvQUtevxhbiwqSFSRpdIKgabAerVKv6UvIQmtD+6Xj+xFslfNoNR3u+FSOEGfDABOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718560497; c=relaxed/simple;
	bh=6bgUNJ2rYry/oQ2e3Z9Ha2X6ox2bK1wL4EgxBmoUKls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wb8UaOi53wmZhgdws9rXDrnNKjB+shWQd03zAOXH4FSvYS0g3OhwjHKb13dkDrao/mvKFEDkk3CFAE5oCIw6fnxFTEICkwFTNLGO/mgZD00zlf2xOHZGCQ78vB6PpAfTTy02grf8qgj9zfwBFAIxdbuvjztdRtF2x/ZHQVieP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=W9VyI8zF; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="W9VyI8zF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718560489; bh=kD62mAI0M2rWp1OcfBj675fX8BwJ3GiQhzzl1f1Qrec=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=W9VyI8zFt2pMS97U8cyRnYcBRc6C/WjpUoaJbgjoVONXSZB1xtJlAZG1JC6eNPP0OSmCNdMEjaa7SiXZ/AWRWTDKrgRN0jLVQCNvhINjKghdH9LteNyznFLV4ROmBjDvXGqM5tCoevgjZHCkV2a4bJGaEBnf2HjLVOTBmKMkiFX5PH2XzHM3u+4WFOoyPP/1rQc7q1hQ+vYZW9VIOITijU8a4d/+NMzWzQOc2ZKaiz+jlZB4TZkyueGpVWqXeKKD/rdqp4HMZZj1HNH8nmKrvXqiPUfPuEdwlhsvO8kbvqBmUiYOTOy6VR1y1q5Z6gzhdViJM6X/X1knt9FzZHZaSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718560489; bh=1uxJrQeT4tYd8gQg4Mt9exWMRBYdvapKxIxp2b6X+yp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ktq7YYglE1pjJEjE6m1pkpOQ8HM1/F5x6lmQPfKgXBJkfusJ88CmiSe0+N6AuGsSboeARNU5aEO3M6jv2kc4FL0TgP5DZqmw02iolII6UFKQNEuUzlOmodwerhqx7qPRtsZcwB77b1CAE2wAmHAXnrjp6Kasss6is7+klrzYabP6EmmywfhYRyiQtgYx+PUxVhOQLtOcGYpRwzlL9O5hofoIdZFUlqBThnU5Ai3Bhh5lSlbJ1Uzvdbnb/F2Uqb/rLHbYxgs9LUzk/PXieRFNUSthrKae8iYwlOqDRjy/q5zJjz3R/XwmcB8LXM1vrfpDCK4NUu43rmAi95v5YM5waw==
X-YMail-OSG: tjTxiBYVM1lA3knOTuKRy2YD4n8l0T4NxFJvk._g6kPIGX77_j0dkyfrTnk921.
 Zq6Fqqdq_swtvIqUCi7hCmCqNYhAeEglfNErnKFiDaDUG1U7gwae7_lqAy285qUFbXHpXVdkgPXS
 xfRspDln3Sc5fUbAH2q9y3K_TOoWNR1XPSRwyvyiDgeNpGDr.cbSLYHAF9zBtQF.bh8jTSIP03XQ
 aadLhHAgTv9MemaVJ9tC4bCySwHYKbnRXYeJ4Rizq0ryW6jEV7snUh5GWKBviUhvVq05a6j2MotT
 VPBMQSrscDWrxab4._RvRiaKF1hYOZhQDAXu7TS6Dh6zqIlT8GDG47gTY6PthGV8CMdieRw7yr8K
 rTNRUCiO1UrsZb6nBvmhf1tAUY8LuV8jkTM67W55cifyJ5RIMXDZRv..7aQqpL6sUyZGvAiyXvAu
 AncId63cSWURf3KHWgCPX3YAZz1Z2C5GF87mnmDhYAXZwsBjw7BGhpDznpRvdWlOOu_EaA.JHa6f
 Q1nhMGPLsmWnDDO.LmnsepB3Ip.s8t59CU_X8RIR64bE1CjYoTVVRTkfwvsKlZIhRVbdsZn4WLFK
 un1rmE8yFtaBYbgF3N1ueRFUjHKo7w5h3YAf4ItQxYOXDiM9Er135iov6USo3epXc8Nttws4tI1Q
 M2kcJl0Syvlyv.4FaJbXfxT6CmCUrTczD_NGyIdc5.wBV15tNGx847jcy5UdaNSH2viYG_7X4kM6
 sloe9siMX.uFjkA4V8ezAHhrC5LP5KJJBVyszNJ0WSLC.7snTn8WNq1z.07zow9QOThYi_tbmUhv
 uqYb7AoOhXhzxI5g17_e8UR_K6DIBbd2SgEkVG5pCVl3bU_vtGdBp1R88EtyRGz5oXLHwiuskhjR
 v_Z5KIB6TUuIuOJjLaQMzinvFqjF7kVpjpCSJd7PycM93StR1Lmkt9wN6leRrc74P48ESZHXMgsu
 SgFnrL8v1gTzTFNWYslfEiCktVGnsrmPChi0GF3emyPKAnFYJ3SfZSSRhQX2ZEVAU8R_HTpxq645
 fBwi3wWmpQx3wXELbbUG7MhU620QGrElJEyZnGFNXvdPTOeUs5izGGWO8qMEUKChL2G3jacVJacc
 34H9S.TaWkIY4xifStR6.aUYO9rjWrj61Ey3cxQB0ihTSrMxtFkf9kTeSigmvdzfrJ5Kh2ukfQl_
 LGOgGTbeI47MtMAHtmgvdRopUNLCpofIIO3w4v6hSXi9rfMPvszF9ETtq6TFSfrUThWh3qqzWh8j
 85NzfIewbG.EkshArJ4q7zDzqOLlEgyNqmMFoW47kItzVQ_.WVxmARRoeMjLF4L6hBwYQe5Itv.L
 InAtQgdiRcvflgIyMimKgXr69ZakGKGQyZipft8f.ypwXEcNjowEp81hAWh2OA3UjUeeWnHSyGbM
 c3OEwceN_6RNBZdW3R0lgHKyDos1HUN9wBg6GkTYlR0JX8woLXVkIvQowvCFN96GQQe3USPLlvDu
 kqsl36aTj0jfUu50P9DWsRKZtPLDEVf5avDtZ_C3FSgEjavEqafZD4BWDqAFMzo1qtCaaXgyc3DR
 dBpVmz9_77_2RI8T2WcJ0Aeylve4WAemAZPc455EGCCuLDkr25TZRWb.lzVd9wquZIadIu9E5lpM
 fiGsdKSj5ohTiyDC8z6Cu.iCVNhbq54ppciVDzR9fRI2W7Cgactpj3kr5dCyC4fYV4UVdMQWYwid
 _lAT8Y1Vz6rPTM9GMlByYTtMXA41CBsqjmi_8vSCvWO4uNPrZpnzJypgczwxCcP1XarsOncokLGe
 _5YJ_rFjkmH4HDK7YFHlqFSpXnpy8fVdbtsLfhOjhyISz_T65QW2uV.ySO8TAcD6uMfoBWaCub3A
 IzUha7Kha24c1w9aFQI90_qhdKEHRE4mdBbvUcw9VWp2YntjtCd_CrjWE_EilGXDWygAhKsuMeKX
 2jqJsgzLqmIZ74.AjYdYGG6tVV6x8RsV5PSZnJNQWCTjzXHOaTlt1h96X1qaYm.8rwtEgaAIrwXo
 uSIpertTFBBlP.DAGhvpS2GIE4cEg92zCFdS.WCTDX5kL3HgMiqXsSktjSZVvQ.OcCNvoMB6xnYN
 cFLavuWuV5IT2Uoew1FhXgsZMvKocHcd.LpSgRf_aU.rjNJmo8TLcTK5qD3bl9HqW8R43GlvxGl6
 tw9hLnlDaXkX96RjviYt.cU2rgyk6Lvj_mlozXq4tkIA2n1OktYwWuDBoulE98q7nkoCwn9JNABa
 I0EYn2JVMOg4J1n2PTfXrj9pwo6gK1aqZlFaAnTv_O0dZD5Yb6KoIWdw38ZiIpCBn5nP5iIi1s7E
 yyj_mBA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9a0cf727-2907-4bcd-aef7-729d7ecdb78f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sun, 16 Jun 2024 17:54:49 +0000
Received: by hermes--production-gq1-5b4c49485c-q2dhb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID edd5ecbda534338a3a5960c0058ac2cb;
          Sun, 16 Jun 2024 17:54:46 +0000 (UTC)
Message-ID: <c74af596-1691-4580-824f-2f1a811454ca@schaufler-ca.com>
Date: Sun, 16 Jun 2024 10:54:44 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: unix sockets: fix accept()ed socket label
To: Konstantin Andreev <andreev@swemel.ru>,
 linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240616142751.273466-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240616142751.273466-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/16/2024 7:27 AM, Konstantin Andreev wrote:
> When a process accept()s connection from a unix socket
> (either stream or seqpacket)
> it gets the socket with the label of the connecting process.
>
> For example, if a connecting process has a label 'foo',
> the accept()ed socket will also have 'in' and 'out' labels 'foo',
> regardless of the label of the listener process.
>
> This is because kernel creates unix child sockets
> in the context of the connecting process.
>
> I do not see any obvious way for the listener to abuse
> alien labels coming with the new socket, but,
> to be on the safe side, it's better fix new socket labels.
>
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
> ---
> The patch is against `next' branch at https://github.com/cschaufler/smack-next
> The patch does not hurt `Smack kernel test suite' https://github.com/smack-team/smack-testsuite.git
>
>  security/smack/smack_lsm.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 56e02cc5c44d..0843bc519ed9 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3846,12 +3846,17 @@ static int smack_unix_stream_connect(struct sock *sock,
>  		}
>  	}
>  
> -	/*
> -	 * Cross reference the peer labels for SO_PEERSEC.
> -	 */
>  	if (rc == 0) {
> +		/*
> +		 * Cross reference the peer labels for SO_PEERSEC.
> +		 */
>  		nsp->smk_packet = ssp->smk_out;
>  		ssp->smk_packet = osp->smk_out;
> +
> +		/* new/child/established socket must inherit listening socket labels */

Please use the multiple line comment style from above.

> +
> +		nsp->smk_out = osp->smk_out;
> +		nsp->smk_in  = osp->smk_in;
>  	}
>  
>  	return rc;
