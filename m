Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A257C433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Sep 2021 19:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052C560F6E
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Sep 2021 19:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhI0UAY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:00:24 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:33156
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230456AbhI0UAX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Sep 2021 16:00:23 -0400
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B5E364061B;
        Mon, 27 Sep 2021 19:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632772723;
        bh=xmwBKNXZo0n8LBAjrwFTMI68qaFuQZXLVCt0chGL24Y=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Kllg9jO4SrE0OzURH43XIEW+T/MmA4HGb8twZ+6IB1vNSw1kPlP1+UXJ9IoEA7MK6
         ec2SsO4l3Fe3vGr0kZge3BLL2Zz+pUqzYxwwoQl1U7lHBHi7dPqTjmfqLJRLbgndDb
         WLlpKb+/86QITS/8qP8LhBtfnWjwOiYrZvk9W8qDylHvh+8gbkII1ON08lenSDuE+D
         S4jnBCR7w08YXsTV+6T9wY3SafRpG/tic6JD4EzkykxgT7/AsGwpJqRve49id7P0is
         v6P8TXDpmISRZoRvP1PQ8PxsTMYNNDA+G52LxYXvCr4IoWk/w4YVAAfmRcfwrYBpBe
         cQAS/eka3vD1w==
Subject: Re: [PATCH] [RESEND] apparmor: avoid -Wempty-body warning
To:     Arnd Bergmann <arnd@kernel.org>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210927100919.1500526-1-arnd@kernel.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <9ef5889e-243a-5906-31cd-820a96859034@canonical.com>
Date:   Mon, 27 Sep 2021 12:58:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927100919.1500526-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/27/21 3:09 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 

Arnd, yep my bad for various reasons I haven't done a merge request since then.
I can pickout a set of minor fixes including this and send them up this week.

-
john


> Building with 'make W=1' shows a warning for an empty macro:
> 
> security/apparmor/label.c: In function '__label_update':
> security/apparmor/label.c:2096:59: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
>  2096 |                 AA_BUG(labels_ns(label) != labels_ns(new));
> 
> Change the macro defintion to use no_printk(), which improves
> format string checking and avoids the warning.
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> Link: https://lore.kernel.org/all/4e3e409e-c72e-edd5-379a-60883f166405@canonical.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I sentn this back in April, and John replied that it's in the apparmor
> tree, but the fix is still missing as of v5.15-rc2.
> 
> Please double-check and re-apply if necessary.
> ---
>  security/apparmor/include/lib.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
> index 7d27db740bc2..394130a0f3a4 100644
> --- a/security/apparmor/include/lib.h
> +++ b/security/apparmor/include/lib.h
> @@ -36,7 +36,7 @@
>  #define AA_BUG_FMT(X, fmt, args...)					\
>  	WARN((X), "AppArmor WARN %s: (" #X "): " fmt, __func__, ##args)
>  #else
> -#define AA_BUG_FMT(X, fmt, args...)
> +#define AA_BUG_FMT(X, fmt, args...) no_printk("Apparmor WARN" fmt, ##args)
>  #endif
>  
>  #define AA_ERROR(fmt, args...)						\
> 

