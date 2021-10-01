Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1093C433EF
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Oct 2021 23:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E3061A63
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Oct 2021 23:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhJAXjH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Oct 2021 19:39:07 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:60244
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230368AbhJAXjG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Oct 2021 19:39:06 -0400
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 738543F070;
        Fri,  1 Oct 2021 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633131437;
        bh=vRkTc7a319YRKj25e89fGcdfX8UPZN/zppQ98ri+pck=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=bsPRuL2qT9FakZgkoHJUgt8/iIpL+rJrxE18oGlZTSKlry8ifMyNtrPUdQpj8QhMa
         92Hld23/DA5KAR+p3DOpn09sklKYe41mZtqqCajJ1DsRtgmIjcUbMNmG65K+f3c7Ol
         pZb948s+/qUnBI9FnJDjZ529lfxkC0FTh0x7MSD4KotRQoXp2Fkd5bRaIH1cXavih0
         kNo6c8kIkJqKYHqSBiuxxqCKzwdlGiOcRfFvg/8XRVs3eMk9XBprCT9kVDWbIJz0xn
         uDE6fPZfE367enZwBVWafDS2dqwywqfALONDGOgawSe5Iqq+rXd+MyTIxopTsLvmYS
         F8CUt+BL8QFjQ==
Subject: Re: [PATCH][next] apparmor: Use struct_size() helper in kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210929220526.GA355783@embeddedor>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <4c851990-45d7-a0ff-e398-92ecb2454242@canonical.com>
Date:   Fri, 1 Oct 2021 16:37:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929220526.GA355783@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/29/21 3:05 PM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worse scenario, could lead to heap overflows.
>> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

nice

I will pull this into my tree
Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>  security/apparmor/label.c  | 3 +--
>  security/apparmor/policy.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index 6222fdfebe4e..0b0265da1926 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -425,8 +425,7 @@ struct aa_label *aa_label_alloc(int size, struct aa_proxy *proxy, gfp_t gfp)
>  	AA_BUG(size < 1);
>  
>  	/*  + 1 for null terminator entry on vec */
> -	new = kzalloc(sizeof(*new) + sizeof(struct aa_profile *) * (size + 1),
> -			gfp);
> +	new = kzalloc(struct_size(new, vec, size + 1), gfp);
>  	AA_DEBUG("%s (%p)\n", __func__, new);
>  	if (!new)
>  		goto fail;
> diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
> index 17191a9eae41..5827dbdfbfca 100644
> --- a/security/apparmor/policy.c
> +++ b/security/apparmor/policy.c
> @@ -260,8 +260,7 @@ struct aa_profile *aa_alloc_profile(const char *hname, struct aa_proxy *proxy,
>  	struct aa_profile *profile;
>  
>  	/* freed by free_profile - usually through aa_put_profile */
> -	profile = kzalloc(sizeof(*profile) + sizeof(struct aa_profile *) * 2,
> -			  gfp);
> +	profile = kzalloc(struct_size(profile, label.vec, 2), gfp);
>  	if (!profile)
>  		return NULL;
>  
> 

