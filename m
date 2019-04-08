Return-Path: <SRS0=KU/V=SK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65868C10F14
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1CF214C6
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 16:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfDHQnR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:43:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38787 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfDHQnR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Apr 2019 12:43:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so16239568qth.5
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2019 09:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fktxCS/6DL20gDwxEYMdN5s38uhu0kO5GlRhVKfC6es=;
        b=FNU3hfj3ME2jIclVEzUqOlcOdJvK7SAyMnnJUkFWzLdLZR06cqX6lNESjRshrlu1s7
         t1Th5WUGflFRXak5/AXXftjMX2JbnxIaF0+4ErWq+0pfopLVN1bL6ptfVSbg6yOVpDqw
         H5DXydPc2LhuujhQ09PCK13IDzKVuAXVFg50QC2bA6gXMqI6+UYxrJeEPIUx2iia2TTF
         4dKj0PuIQgAjG0otYbON2NSuBqBdMR3KQqgvcEKeglZYdrrD0xjzl0/KxU4WqNHrFssc
         hhA0s9fcrpr9koHVq2lSLl6LsXsJkkUPxl+hMnJgwdp7dtJmvLq/kxB6BLUzJknMXPDm
         qwaA==
X-Gm-Message-State: APjAAAV7IsHyQL8rDrRmtdOP4EV8+Q4YtPz+/gT9MdkpnyoxoBmx9XG+
        4HWdcwTjVqEdro8IStk8KrpleA==
X-Google-Smtp-Source: APXvYqzYmKXRLjkMbS9fOATnLwGMXiw8XG/yzCY83HLsy4A8i6vEdT5nUbeIWLq5A6ylsZe212PiwA==
X-Received: by 2002:ac8:544b:: with SMTP id d11mr24288266qtq.134.1554741796595;
        Mon, 08 Apr 2019 09:43:16 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6:8083:e891:a0d6:f666? ([2601:602:9800:dae6:8083:e891:a0d6:f666])
        by smtp.gmail.com with ESMTPSA id m73sm15796050qke.95.2019.04.08.09.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:43:16 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
To:     Alexander Potapenko <glider@google.com>,
        yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com, kernel-hardening@lists.openwall.com
References: <20190308132701.133598-1-glider@google.com>
 <20190308132701.133598-3-glider@google.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <497b1201-b2ae-5e0c-d191-ff1830d92fc1@redhat.com>
Date:   Mon, 8 Apr 2019 09:43:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190308132701.133598-3-glider@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/8/19 5:27 AM, Alexander Potapenko wrote:
> This config option enables CONFIG_SLUB_DEBUG and CONFIG_PAGE_POISONING
> without the need to pass any boot parameters.
> 
> No performance optimizations are done at the moment to reduce double
> initialization of memory regions.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Sandeep Patil <sspatil@android.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> ---
>   mm/page_poison.c         |  5 +++++
>   mm/slub.c                |  2 ++
>   security/Kconfig.initmem | 11 +++++++++++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index 21d4f97cb49b..a1985f33f635 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -12,9 +12,14 @@ static bool want_page_poisoning __read_mostly;
>   
>   static int __init early_page_poison_param(char *buf)
>   {
> +#ifdef CONFIG_INIT_ALL_HEAP
> +	want_page_poisoning = true;
> +	return 0;
> +#else
>   	if (!buf)
>   		return -EINVAL;
>   	return strtobool(buf, &want_page_poisoning);
> +#endif
>   }
>   early_param("page_poison", early_page_poison_param);
>   
> diff --git a/mm/slub.c b/mm/slub.c
> index 1b08fbcb7e61..00e0197d3f35 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1287,6 +1287,8 @@ static int __init setup_slub_debug(char *str)
>   	if (*str == ',')
>   		slub_debug_slabs = str + 1;
>   out:
> +	if (IS_ENABLED(CONFIG_INIT_ALL_HEAP))
> +		slub_debug |= SLAB_POISON;
>   	return 1;
>   }
>   

I've looked at doing something similar in the past (failing to find
the thread this morning...) and while this will work, it has pretty
serious performance issues. It's not actually the poisoning which
is expensive but that turning on debugging removes the cpu slab
which has significant performance penalties.

I'd rather go back to the proposal of just poisoning the slab
at alloc/free without using SLAB_POISON.

Thanks,
Laura


> diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
> index 27aec394365e..5ce49663777a 100644
> --- a/security/Kconfig.initmem
> +++ b/security/Kconfig.initmem
> @@ -13,6 +13,17 @@ config INIT_ALL_MEMORY
>   
>   if INIT_ALL_MEMORY
>   
> +config INIT_ALL_HEAP
> +	bool "Initialize all heap"
> +	depends on INIT_ALL_MEMORY
> +	select CONFIG_PAGE_POISONING
> +	select CONFIG_PAGE_POISONING_NO_SANITY
> +	select CONFIG_PAGE_POISONING_ZERO
> +	select CONFIG_SLUB_DEBUG
> +	default y
> +	help
> +	  Enable page poisoning and slub poisoning by default.
> +
>   config INIT_ALL_STACK
>   	bool "Initialize all stack"
>   	depends on INIT_ALL_MEMORY
> 

