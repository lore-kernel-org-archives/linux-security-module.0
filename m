Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DFDC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 14:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4CF6101D
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 14:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhJLOkZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:40:25 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:40927
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237266AbhJLOkX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 10:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634049502; bh=ajkQCqh8R1xj55HNYjqmZNpAqZT9WiN/huGWLcAi0EA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=NFswxsXdo7VvZgO3ofi3rZeWtmRj+yu/b9tGsHWwD2MdERSziXiI63t9yQ68qApmpSMXNSw0fmu+HFAJH26b/WdsjDDPJjvTrIaJ0DPiMpq7qzj6z6IJA+RzS6wuvFioUVIT99Y2qA84nPMRue8YsyQWPsEOhXGdNfayW4Y2n4gNHtW0j4OVoDqOzfYUNZ6gmY1Re6Kj+x3u1rXJLSS9rW+yw2QEFO/FyKJwtaj/Oa7Ygjk8vwCKawTcrRFAtH6zrUbBdV66+CeWTYf+TQZ+1oP2pYkSbk4OTGSXt7LDtOrxageMxA50cIGaEoz0vj+NQECmXPtoqHIv3lNEeGP5Rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634049502; bh=+5jH39yxp6huHQ4VVAO/+pkVrbi7pFslvBkWs6wj1CB=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=nR2ifgw7gGuNeBZ52S8GvhRfczL24gz65QQyeBA0W9Yv8CZ58a3P8xIEchEifVaxWbDZ7Jd1GB7Nm4gRme5eEJkuQqOu3WAJUvHQV0zEi5xwE2Yea+cai0GLI2xcuzi+sIl7oAi0tAJw8+AyBL/kJ9M9dnOmZFVjg37tB3wf/06DO+CMlDI8c5lNVB9m/Js5Z7I01VtOV2HZ7h8FQ+PhqSv5t73IDVCDPod+P57QaKQ9A3ysb2rDgNd0PyxqCyVnWXnJ1lv6+9wBkBz2MBeOQ5aOBON3AWTfSuEFQYyd4JyqU/DmCNLQSqYRoYr/ACmkyokontO4MbB2jSTDpsIUfg==
X-YMail-OSG: l2i3K_IVM1kH14UAOiUiYqkNtYhivkEHorEDhd4atO9MVCfjy5kHYKDjbu0.HN_
 KFpgp.1r_bXTOnTyJxr1ZZYzBXMVKkFW7Cb9moHRRZVJrMBHZLATlPiZoAWvDbkB.1Amc9SlF7Dr
 rUQ91DTijCy9xbRT6rBN9nYKD2ULANrgIVzgqKRANpxeDTop_4K9Zdd4ME4lrly8oudAn874i1c1
 kOI4JaQtbKK1aN8NXuia.c_h6JgUT0FpfB4iqHGq1WhLj1T6iX.ymIR3lc0wAJP8njD.1haOUWPP
 2tWKb0rIVebn_0cU4mIDJCJaHnSFBrRzDB3DHF.1AGA3csmVdNxpEo1BUc6IjDFNRCXfdyaORxvk
 5_9eiZhzTGCwQlnVqExG1bfWsNii_Sa6Nk0iBQRYPDNt.2E_Mcipui0H59IKEFjEzfnFQ.TolMsq
 P3sZbrXmNuJuk0SLt2kC3e3lZ0KPjZEA_qKHdKVk.8He50UCR9w5NgtfzKT2AiTA0G3ScxiJf0kI
 MDgiDnY3awvg.2lIQc3fM96nOwgfEH6hzCQniceQWLA.NjaUPhkwMTT_MsxcpcCZWfZm17Z0u_Xp
 u1a_6ES.dW16xl1uT1iHZ7EYLnDkIq7zh.2R.Jba8WkDajeR8RIdW8Mob2bmMufAYJ32G.fdg.cu
 YxQc7z0TtFak9Q8y4An5b9TKgU2C9yAUJmVZXV2c0.q6Z.gO1TxTk9XRBPMs0_kKlBPlIMciJqIy
 6wfggrLXzJiJzBu1ke4.2Ur25BokET4VaA2XA9OSA3gVR1iYPZfy7_vLlcG_t_jiuupy3QWYsNij
 WoW5BMWNBgwSjW6iWdXJ2esxgjt3oq2Yao5CzWVgd9PixCu5emcPB8K.Y05Y7VKxSbn_SGbp1OBc
 VdxhtouqyPTy3oitscDcQSkxTx.Qm5vN4.3IwRTPDR3Q1Rd7tYLdTYAfG0Y2s55hWknYnz7.yuqo
 9ePYmOQP1TBP5mSo0kWM1dGFmMwoFl6molNK1mwjJPw4.kpl8wdl.loPhareuUYoJYbz9hK096T0
 vW9yPDpNwZKxyc2_XFEgsRmnbklvdEjnkCyy0MWlWVcyNjDLHehiRe3MsCGwA.Xaw2ckZ94Rgk90
 E8_5XLZrUYOv57P8UDzIOhvSBcic9FRNl21EcUSNn2ByrIBTfBjvYOYd8u3ICs61kqL_GlzEfONm
 FxZ0XILa4r3EyzCumphxZHMdRIKftFC4atzrbgeHVCarGdRBDSfbhCY_jnXAzCAUgDb5THeLEQkg
 EV3hOgAeQzcnk70Z6RtQZyzOREx5RhZzf9tuz971z20EIYYm0qQpBFdCH7PEAj9Xd1XShYPPnjTH
 fWzxedF0IlWCWQWRM66_tiQDDqBoPf8qYTJ0gBge94ZT9drEQlD0TGZ28YYERmWg3Dxy5x0E7zBd
 S_qhPLBP9zSlbV8soO1jWGDK4j2dSlveTJTP2TQ5ee.alh4Nv7_PDj_lA77kAAfrueBhCfbkauMI
 PLs_RUPFpMFPkuJxso.w070Mfltt4Z9bw2q3MAqoPk7vWOnboNg6Yt4Ih5ANFunXBFDgW_wJF7uY
 FbzihtQeHLjtNmPhSDSOy50Q6Nf4VZDkOezIGxp5Rt12aCcdwlgCpPBTgXGjEzz9EQciP1F8PcYO
 j84VDa.sbKE2ab4arRvEHLXrxTgqRQMFA4AAzyrWgTlfldUMv6VjF9kYfwhaz0TlXeFhpOMZmgPq
 HJVtypOQqhrYBsqyj3tGguxMBwQdrHprqa6IuafcmQccTwl6GaP9zWj6Ie_taVeLs.96nHrfzZS3
 2mvPwuarsOZx.FIN_oMmi1Oz9fV4HaYhkWaQxCkMs.LOOxEIMYn6CrlReJ9JA1gkR_4vHzeD4HaU
 GjtMczsPD2yVWX5xd7sjHF5rhzGrFFanUfEc7NEJaycn4SZOT8d.VyWzJu5wS3rB3bVdSYB2pG.Z
 0zHU5mzwivITwVQBttZL6.MvLGL0OCB3FMZkDu2tzpJTCImE28Ur4s4I3pWBLeNjLl39Yp0H.XHB
 IYK1.79GL0rGSNGKjqXYeUst8JM90lZbngBZj.m2yVE9em.ZAsoNVKNv.IVBQq_Vw4.bcpEX25TQ
 yKca7FylN3odAsZOWrFgRWFbAVk2Yq6PfHJgYlGYsz93GG0zcYWnXIqo_oaWH5UPJnZblp.YQdZ0
 O9yVgnmLvplXsqCmmFmLht9PWl.kUtKVw1DeJ7bgMpmotq2E3dGk95qqqEQqx.jONsoGzarzsLEF
 d6UaC9GmLejCmk__PhCCiqRvPIqsfUDHD_rzqLIlqYL_TcxYVfw53YEcpPB7B4PzPxuFptHxxUQ0
 GnsBOE2BCvaY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Oct 2021 14:38:22 +0000
Received: by kubenode534.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 694b85d7ad037a75725227ef66182e7a;
          Tue, 12 Oct 2021 14:38:16 +0000 (UTC)
Subject: Re: [PATCH smack] smack: remove duplicated hook function
To:     Florian Westphal <fw@strlen.de>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211011143309.17203-1-fw@strlen.de>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <700b26f3-a8ef-969b-dd3c-4ad849d8c4ab@schaufler-ca.com>
Date:   Tue, 12 Oct 2021 07:38:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211011143309.17203-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.19116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/11/2021 7:33 AM, Florian Westphal wrote:
> ipv4 and ipv6 hook functions are identical, remove one.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Looks fine, with the one change I've noted below. If you're
OK with that change I can take it for smack-next.

> ---
>  patch targets next branch of
>  git://github.com/cschaufler/smack-next.
>
>  security/smack/smack_netfilter.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
>
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index fc7399b45373..a7ef2e2abc8a 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -18,27 +18,7 @@
>  #include <net/net_namespace.h>
>  #include "smack.h"
>  
> -#if IS_ENABLED(CONFIG_IPV6)
> -
> -static unsigned int smack_ipv6_output(void *priv,
> -					struct sk_buff *skb,
> -					const struct nf_hook_state *state)
> -{
> -	struct sock *sk = skb_to_full_sk(skb);
> -	struct socket_smack *ssp;
> -	struct smack_known *skp;
> -
> -	if (sk && sk->sk_security) {
> -		ssp = sk->sk_security;
> -		skp = ssp->smk_out;
> -		skb->secmark = skp->smk_secid;
> -	}
> -
> -	return NF_ACCEPT;
> -}
> -#endif	/* IPV6 */
> -
> -static unsigned int smack_ipv4_output(void *priv,
> +static unsigned int smack_hook_output(void *priv,

I would prefer smack_ip_output() to smack_hook_output().

>  					struct sk_buff *skb,
>  					const struct nf_hook_state *state)
>  {
> @@ -57,14 +37,14 @@ static unsigned int smack_ipv4_output(void *priv,
>  
>  static const struct nf_hook_ops smack_nf_ops[] = {
>  	{
> -		.hook =		smack_ipv4_output,
> +		.hook =		smack_hook_output,
>  		.pf =		NFPROTO_IPV4,
>  		.hooknum =	NF_INET_LOCAL_OUT,
>  		.priority =	NF_IP_PRI_SELINUX_FIRST,
>  	},
>  #if IS_ENABLED(CONFIG_IPV6)
>  	{
> -		.hook =		smack_ipv6_output,
> +		.hook =		smack_hook_output,
>  		.pf =		NFPROTO_IPV6,
>  		.hooknum =	NF_INET_LOCAL_OUT,
>  		.priority =	NF_IP6_PRI_SELINUX_FIRST,
