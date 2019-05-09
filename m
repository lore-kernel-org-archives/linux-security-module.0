Return-Path: <SRS0=3Nce=TJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33106C04AB1
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 15:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED33D2085A
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="llu68/yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfEIPaA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 May 2019 11:30:00 -0400
Received: from sonic312-29.consmr.mail.gq1.yahoo.com ([98.137.69.210]:40868
        "EHLO sonic312-29.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbfEIPaA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 May 2019 11:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1557415798; bh=xyHh7rldW0yaAWUvjMEZaVnEJgJw4FoFOJT6EdmXXFc=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=llu68/yWMXMR67wUduQOtitn3tPcvQ7iuzEWscEpsga5+TLSZufh/D3bsjHnGzYLdDRV94B6lK9aX5eafcYl7rwC6+yzqQM/B7gIOXj4wDOMfjXv0bvwJZ2FhmnSTTL7E+DgnGZZCCeCNG+H/ZAbKbhrhw9+GrwujxzdZkTcaQC/Wwh3e4iqSbB1vdunArBp/Jsn7ptCZxzgb/TI77ct3zeTTbxCghI1NzwHAb+3NOg4d84bZJ2VCgC2tIJHlwJuK51S0TgGYjr8UNR9+VWBK7UBr9VD+qQ2NpFy8zgVzwDTEPct/+eYkWQDqYvq0As4PGa4IQuSR+fbmpBv/9mR1Q==
X-YMail-OSG: RB3clxUVM1lKY9rQRBWwUskp0J4aTRmkpUAYmtmT.WxhfEZDQT2pPCDPGyJ722q
 FdIvYJ1OsDsR1UWLx8ZZ.E30sG3UUMTX18bhREmRmsHWKur.V5bqn73d6oroobu3ME.PUUPgfnZS
 YRqnBb4Xrvu42TjUOiC2P7uWj1m8V2jqOIXlJyxhZXJs3W45bK.F84WWYNGzl5fBVKzYTLQt7eXp
 8g3VGf2ujM_zfqtMbaNiyQoyRkdkWrgtCNrn4NXu156c_Yn_U3NjZVIqUfiT97FHBQT7kqEabrir
 Esz6ImFn1CExsKHQvAvPFOSAs23hlP383ITRGrrRoo1y1qbEVbrQKm.wI18LXPr_ZpuTK5N1yDJY
 ebnpsc5MJP1hgzQqq9mIWOPxqJj4VzkcXpu7pduh1smLBdjgUBpOBQeqQ4qAXrsuzWDStQJb2Ckg
 n1uZf2Dp8H6zTSor7_NiY8qRZuIiD5rhhkC2gM4iZPTsoIu.2QHfNvS6ini.FUbprvA56DoXb4xL
 mdCVf_GYZJO9ZrKkNi4olufWQvfrTFbpN9Kdq4DVYAml1wgWoW9e90BcFzFaTb.smyu_JMauAq6o
 NCHATcippO0sDzUqnKCnIJTHAtE8YWTYqJ4m3r8yfHeinpyZQg53fa8Vu35g4fyyu2miAmfQC97Y
 qqAETlCLjMEFOKmwcueO.zzjzPL44b.AhbAbSE3TzfNH24eAdMTGKb34mmfWNBcvgLPQ6IULTRrk
 gPVAtFQTlsCIExm7f8fDKLXtfRj7d1eS4m_bn7N4lCsM_s9R8VIeRoFgWX9ZlWsDjgin.vq4S.ss
 kQ72mPuoDBf_YLjIYQnPUGj1yXlnwqovS94Plt9akgSq1cTKpSGpqKXg1Czj5b2fmAXpnqbLHckw
 9SWVb8ifMc.dOjyqojP9S1UaPRwkFr8zhsEmQirpKmLVC2pAjf0ckgbNUfK.BD3a5GfoN4ktHaRz
 ZcgXqQR7ttuJ4ZUB0dWXhRutbnEg6DURrchwhCmGkGcjV.MSlgvFA14QtGekyrn1GtvK_ieeecCn
 2mzk.VDGPhvCjiB_SF9xCztPQWMazRmTjKdDYBRi0_Pj4u8pC2EQXEDPKd17EixDKGKY_EROOIi3
 ioG.b0mu_X91pTaOImMAwar0r3vv8gxdDwc8HvAppA7.Y2FkGvm0jVbqSBcKgH7hpQ95wSiKCwtV
 aajd9n4nTx_lo0.5m0lSUCn.uVP2AFdv12t4w3hICNgVN5OXR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 May 2019 15:29:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 55aa1e5d6171fdae2d0ab23330ce6005;
          Thu, 09 May 2019 15:29:53 +0000 (UTC)
Subject: Re: [PATCH next] security: smack: fix sap undeclared error in
 smack_socket_sendmsg
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org
References: <20190509124628.189228-1-wangkefeng.wang@huawei.com>
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <73cebc57-3947-c438-9316-0c64302e97e5@schaufler-ca.com>
Date:   Thu, 9 May 2019 08:29:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509124628.189228-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/9/2019 5:46 AM, Kefeng Wang wrote:
> If CONFIG_IPV6 is disabled, there is build error, fix it.
>
> security/smack/smack_lsm.c: In function ‘smack_socket_sendmsg’:
> security/smack/smack_lsm.c:3698:7: error: ‘sap’ undeclared (first use in this function)
>       sap->sin6_family != AF_INET6)
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thank you for your patch. This has already been fixed and
will be in 5.2 when James sends the pull request.

> ---
>   security/smack/smack_lsm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index b5b333d72637..ff5b7dc6816f 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3693,6 +3693,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>   			return -EINVAL;
>   		rc = smack_netlabel_send(sock->sk, sip);
>   		break;
> +#if IS_ENABLED(CONFIG_IPV6)
>   	case AF_INET6:
>   		if (msg->msg_namelen < SIN6_LEN_RFC2133 ||
>   		    sap->sin6_family != AF_INET6)
> @@ -3707,6 +3708,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>   		rc = smk_ipv6_port_check(sock->sk, sap, SMK_SENDING);
>   #endif
>   		break;
> +#endif
>   	}
>   	return rc;
>   }
