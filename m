Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20240C433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Nov 2021 01:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042E46134F
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Nov 2021 01:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhKLB3B (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Nov 2021 20:29:01 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:47064
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229835AbhKLB26 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Nov 2021 20:28:58 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6A9663F213;
        Fri, 12 Nov 2021 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636680368;
        bh=uW6RI9EgL3J/zRhraSfskUGkLZ10MJZhG2zpxNHtMK4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=QErOZCoIWvcWQZhc0MyxjDYtml+m2gi3zWSuLrxq8IIIXbij0GVBVPe1wpA8DEfmV
         wRKdjAZqOpYe3mvFfSHzSrMCs/v0GM/coqvKrj4ginoBmLh+S/MbDoMxZ196id9UN8
         riqlRiqDP6jZTiWfbuBXsjEDQLpWLibWGgB1ykdpVXtjs8B8FZsNHx+EEdWXhev/8k
         H26QTmkmMim5sNdI3o+p4TPDKIEjy5RN/DGBzagu+YhdVSW2vxM3dN5QyqrUNLpIkV
         CcxnAJVxKrkPt3qetnhJlTprtKDtpSVfuJoexKxm3/ZpP7ol2jFIrvIOJ4C8GTGH1N
         tHAwWYqGJQw4A==
Subject: Re: [PATCH apparmor] apparmor: remove unneeded one-line hook wrappers
To:     Florian Westphal <fw@strlen.de>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org
References: <20211011143854.17917-1-fw@strlen.de>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <0525571e-9950-b953-f6df-e6a81f5c54cc@canonical.com>
Date:   Thu, 11 Nov 2021 17:26:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011143854.17917-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/11/21 7:38 AM, Florian Westphal wrote:
> Use the common function directly.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

sorry, it looks like I forgot to reply to this. I pulled this into the
apparmor tree and it has been merged for 5.16

> ---
>  security/apparmor/lsm.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index f72406fe1bf2..eafb44aa553a 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1773,32 +1773,16 @@ static unsigned int apparmor_ip_postroute(void *priv,
>  
>  }
>  
> -static unsigned int apparmor_ipv4_postroute(void *priv,
> -					    struct sk_buff *skb,
> -					    const struct nf_hook_state *state)
> -{
> -	return apparmor_ip_postroute(priv, skb, state);
> -}
> -
> -#if IS_ENABLED(CONFIG_IPV6)
> -static unsigned int apparmor_ipv6_postroute(void *priv,
> -					    struct sk_buff *skb,
> -					    const struct nf_hook_state *state)
> -{
> -	return apparmor_ip_postroute(priv, skb, state);
> -}
> -#endif
> -
>  static const struct nf_hook_ops apparmor_nf_ops[] = {
>  	{
> -		.hook =         apparmor_ipv4_postroute,
> +		.hook =         apparmor_ip_postroute,
>  		.pf =           NFPROTO_IPV4,
>  		.hooknum =      NF_INET_POST_ROUTING,
>  		.priority =     NF_IP_PRI_SELINUX_FIRST,
>  	},
>  #if IS_ENABLED(CONFIG_IPV6)
>  	{
> -		.hook =         apparmor_ipv6_postroute,
> +		.hook =         apparmor_ip_postroute,
>  		.pf =           NFPROTO_IPV6,
>  		.hooknum =      NF_INET_POST_ROUTING,
>  		.priority =     NF_IP6_PRI_SELINUX_FIRST,
> 

