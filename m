Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B78CC10F0E
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 15:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F472171F
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 15:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M/dzDy8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDLPcX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:32:23 -0400
Received: from sonic302-27.consmr.mail.gq1.yahoo.com ([98.137.68.153]:46226
        "EHLO sonic302-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbfDLPcX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Apr 2019 11:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555083142; bh=aoLFF08o/3PPOaTV08q1rCQhJCFBJ9TCU8UHmzs0nDQ=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=M/dzDy8vvenLEm/aQlNWUTlolAbR87bHdmuQZStVWjt/2RY7PMGCqp+hrneXdtpsbxYKrahBTFedy2fuas20KiDKaBKlMLi9/f2e6ypgEvqEBVcZLUW7gKYlo5RLc+W9oIgSVCFhB/qxr17uNsvvglqUPXzNNRQx+Vx+0BoXasoEIHMWZGKYdNtEDh9Sy2DioFW2i8v4SWSZi4XECyEcxEVSLkefv0IwA1Yp3gozzXF1zGNanbl6/MfvidogfAoklFMaUZibXWQQydCYbZbLZQWFgu8R6QIgjuQ1Ie7Btgia/7Dnh+ybAMmfQWWFGM8+gJd7sVO2V6ieiWvcC0VqDQ==
X-YMail-OSG: x29m18IVM1lTQOtZUneq0eEjwkiQH.DzLI02zyCXRKovbgPXwoQHKcIWrFLZBkT
 yJzAmYZXe3DpONniw5y.yYac_X0g5NJxwJ739aAJ8EOIxEMvePkzWUqUc_sBfwXGPo3fK5FLnKr6
 aOa18eJkMeEPNkgqtmL_SLKsMy4g2j9El4mnOmigvjJ71Gj4lv9fN3dRbTAX.KMDjNwZK13OTl6r
 Y7vrHK5_pjpUXG94NtExCMoU.t3QUFGP9rsLrO4_BS4eE.fjznokraRLGGCzChQwjXu.5F4CMmYu
 a03cx0bIsp.46XRNIWTbMmoY8u6QZo98eTj_uwhC2iZJfQV7ee2pJ8.ijPi_kCLx_5_cvnKMcuQz
 z_82eUbrIPTxHMyLdjjkqtTjM5eIqUOq_5nfAhscJn7JSOPGzz2xOoVofQlMqERHkPbLtSVIeu5z
 8aO_Vmpdng5HkVO.VvhyxE.hxn8ZJIXvAWcQzarWBwr5Rnurp1dumj8VeNhDcNNx5_9HIXzrznLJ
 XAF22uc05ikfv1p53j5j.ypRQ_gTWjgoSQfEUpBctvjVL5_hZHVP3DC7B3nrEHLpc6uKlsPjLTnT
 L1xUTQcAmEsP22UF2u3M.zLDCZerzjdHeDQkq06N6GTc.4G95yf0nJnntarNYq4xktvDWnBKPQt6
 Webo_ikwRLDdjAivAD5cPC6KsLYBfsQivKwyl3VIl6emhRNjcoojtNa8YJbNGb38EQPFJ3JnqG1m
 kKAJvFhGco4IThwNXKfXoi7CvnI9OJP.buw5WTWeeTqYWUSEqGr.5fHNLsPHGHYEbSSmYm.s4p8u
 sTlL_QReE_dl4Kq_3Z8T0iqc9zec_9SVGfcqF8TpYviLcGqYZDQTuxpI0lGKg1BOLjeGix2Dx1Ks
 ilHVf9V31ttClDyDhcsZXQaeh5jbI3LnVOGduJwAJ0LQG8pjJeMkCXL9avDh2urvQ_Vt9fevQbsy
 d8PtW4jJKODbdGcYJsviwR3xHA8JMsdkW9XETI13JY3d9PMQ4t_GzHLN85yGdueHoq3IcgmTvflI
 YKbFiGlE5b7fJG5o5ph7J54lyzEXPV0NepjhcyW7IFPEAxVOEQKCvYHZqSSE2ucoLsdXpclUKVVn
 Rtu6ptfm0ONLw3gUyxNbs1uTxweOJyootv4iSOiiQPWCpBMxHWtkz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Fri, 12 Apr 2019 15:32:22 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4b507e55cc12007f3af17851c4fbdb6b;
          Fri, 12 Apr 2019 15:32:17 +0000 (UTC)
Subject: Re: [PATCH 2/3] smack: Check address length before reading address
 family
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org
References: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1555066776-9758-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <738815cc-ac59-63c9-1768-26df95689d7a@schaufler-ca.com>
Date:   Fri, 12 Apr 2019 08:32:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555066776-9758-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/12/2019 3:59 AM, Tetsuo Handa wrote:
> KMSAN will complain if valid address length passed to bind()/connect()/
> sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.
>
> Also, since smk_ipv6_port_label()/smack_netlabel_send()/
> smack_ipv6host_label()/smk_ipv6_check()/smk_ipv6_port_check() are not
> checking valid address length and/or address family, make sure we check
> both. The minimal valid length in smack_socket_connect() is changed from
> sizeof(struct sockaddr_in6) bytes to SIN6_LEN_RFC2133 bytes, for it seems
> that Smack is not using "struct sockaddr_in6"->sin6_scope_id field.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>   security/smack/smack_lsm.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 5c1613519d5a..4b59e4519e0c 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2805,13 +2805,17 @@ static int smack_socket_socketpair(struct socket *socka,
>    *
>    * Records the label bound to a port.
>    *
> - * Returns 0
> + * Returns 0 on success, and error code otherwise
>    */
>   static int smack_socket_bind(struct socket *sock, struct sockaddr *address,
>   				int addrlen)
>   {
> -	if (sock->sk != NULL && sock->sk->sk_family == PF_INET6)
> +	if (sock->sk != NULL && sock->sk->sk_family == PF_INET6) {
> +		if (addrlen < SIN6_LEN_RFC2133 ||
> +		    address->sa_family != AF_INET6)
> +			return -EINVAL;
>   		smk_ipv6_port_label(sock, address);
> +	}
>   	return 0;
>   }
>   #endif /* SMACK_IPV6_PORT_LABELING */
> @@ -2847,12 +2851,13 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
>   
>   	switch (sock->sk->sk_family) {
>   	case PF_INET:
> -		if (addrlen < sizeof(struct sockaddr_in))
> +		if (addrlen < sizeof(struct sockaddr_in) ||
> +		    sap->sa_family != AF_INET)
>   			return -EINVAL;
>   		rc = smack_netlabel_send(sock->sk, (struct sockaddr_in *)sap);
>   		break;
>   	case PF_INET6:
> -		if (addrlen < sizeof(struct sockaddr_in6))
> +		if (addrlen < SIN6_LEN_RFC2133 || sap->sa_family != AF_INET6)
>   			return -EINVAL;
>   #ifdef SMACK_IPV6_SECMARK_LABELING
>   		rsp = smack_ipv6host_label(sip);
> @@ -3682,9 +3687,15 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>   
>   	switch (sock->sk->sk_family) {
>   	case AF_INET:
> +		if (msg->msg_namelen < sizeof(struct sockaddr_in) ||
> +		    sip->sin_family != AF_INET)
> +			return -EINVAL;
>   		rc = smack_netlabel_send(sock->sk, sip);
>   		break;
>   	case AF_INET6:
> +		if (msg->msg_namelen < SIN6_LEN_RFC2133 ||
> +		    sap->sin6_family != AF_INET6)
> +			return -EINVAL;
>   #ifdef SMACK_IPV6_SECMARK_LABELING
>   		rsp = smack_ipv6host_label(sap);
>   		if (rsp != NULL)
