Return-Path: <SRS0=3Nce=TJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CBAC04A6B
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 01:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62CE21479
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 01:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b4bKpqtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfEIBFK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 May 2019 21:05:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEIBFK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 May 2019 21:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G13SwZrvXQwLwqfSvC5cLaD8FJjp+bG9vvkSPGdxrhE=; b=b4bKpqtlBzzAQmT4dULJ60Wx/
        4+mV8vaQI2ye68XjE42FuRpIw2V+NKJMAqALzmF4L45TsWnm64cyf9aZYpA8l8d1NVLuDS8uIeCMm
        2B7tvT+bSk4czrUY6K7SQEb6YcRxEbbkhhUCmU6VEmkdwCO+ZFvwQ/ZUJqgP/w4jZo4iHlN3eaVL+
        kK/r7hTkrByF/ZaNFivjTPBINatmyiTOXJz51A7fd2jgcAqqDsyZ7d8uJeCUAQmLsnA5elniY+wKR
        sRgfHraFrxNNMgi36b/ZcrHq1Zw1KU7TahBjwB+7xbQIFWjjkzqDqw82hUi657MF+rES6DBkqzcCu
        rbCtLeMpQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOXUW-0003Al-Pt; Thu, 09 May 2019 01:04:56 +0000
Subject: Re: [PATCH 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org,
        cl@linux.com, keescook@chromium.org, labbott@redhat.com
Cc:     linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com, yamada.masahiro@socionext.com,
        jmorris@namei.org, serge@hallyn.com, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, sspatil@android.com,
        jannh@google.com, mark.rutland@arm.com
References: <20190508153736.256401-1-glider@google.com>
 <20190508153736.256401-2-glider@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6e5ccf92-cc58-ab2b-d025-0f5642d5f4a6@infradead.org>
Date:   Wed, 8 May 2019 18:04:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508153736.256401-2-glider@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/8/19 8:37 AM, Alexander Potapenko wrote:
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 0a1d4ca314f4..4a4001f5ad25 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -159,6 +159,22 @@ config STACKLEAK_RUNTIME_DISABLE
>  	  runtime to control kernel stack erasing for kernels built with
>  	  CONFIG_GCC_PLUGIN_STACKLEAK.
>  
> +config INIT_ON_ALLOC_DEFAULT_ON
> +	bool "Set init_on_alloc=1 by default"
> +	default false

That should be spelled "default n" but since that is already the default,
just omit the line completely.

> +	help
> +	  Enable init_on_alloc=1 by default, making the kernel initialize every
> +	  page and heap allocation with zeroes.
> +	  init_on_alloc can be overridden via command line.
> +
> +config INIT_ON_FREE_DEFAULT_ON
> +	bool "Set init_on_free=1 by default"
> +	default false

ditto.

> +	help
> +	  Enable init_on_free=1 by default, making the kernel initialize freed
> +	  pages and slab memory with zeroes.
> +	  init_on_free can be overridden via command line.
> +
>  endmenu
>  
>  endmenu


-- 
~Randy
