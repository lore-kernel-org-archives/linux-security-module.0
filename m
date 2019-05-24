Return-Path: <SRS0=sk88=TY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138ABC282E1
	for <linux-security-module@archiver.kernel.org>; Fri, 24 May 2019 00:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5026217D9
	for <linux-security-module@archiver.kernel.org>; Fri, 24 May 2019 00:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mmoVsIwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbfEXAEw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 May 2019 20:04:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45807 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388423AbfEXAEw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 May 2019 20:04:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so4134305pfm.12
        for <linux-security-module@vger.kernel.org>; Thu, 23 May 2019 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bg3lp1cp1YsHZIAZ+WZ5FtPbgNHk60LZKuR1dQM5X0o=;
        b=mmoVsIwHReQDPhkE8pfZYV7WXqnOV5tXm/Zklyw0xJ+ipTIIWge6M4WmPf43jJn3Ku
         wNC+tgP1Y9/6J2WES4ibeG2Hlp7iGy/v9AnM7BXbJMKkW4roaMU7xT6Dhyq1lNn2mIen
         RxLb0WX+C2o54dluBacYUimfY7Ll09hMwa7dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bg3lp1cp1YsHZIAZ+WZ5FtPbgNHk60LZKuR1dQM5X0o=;
        b=WztdWEZxgiri3EEXqd1QYNGX6TpNNzk7/pPh6/PTtrJlS0qJPiYagFxU+HTkH2hTYk
         AU9Mjuav3+TvtcMunpGxArvA8P8QByqR4tmrA+c2/BVysubX1OlubOBlJHqxLHmNyqNo
         KCF2LVcyJjubvoW4Crs4VPY1O88x5jvDReB8jsz/Nbfc6zkB3xMwAjHcNvo3Izzq0237
         AVD0igssWHxwY2XkNTrsUTNn23gdP4xtNIf0OgbhhPKTtg+N8440YbOOXAqGk0XafyH6
         df4Kj8oABzq+9XLUven6iCserXyUhYe34DsKrypSLJkGTn6CiIgUfDtduoxZDtqNmoa5
         QH9A==
X-Gm-Message-State: APjAAAUVrB1RPgnPWxqTRifqir6KFM3XXs2ljOSOxVIfobXMzY4iucOY
        6rxwzppl/FRTZEUagascBdkQxQ==
X-Google-Smtp-Source: APXvYqyctB5V+K3NG1DpFLMcyJb93jrwPDhvUf/DwGjUNUzz8Ua+BzD11CKG169jmEoBbkZnJd67Uw==
X-Received: by 2002:a63:1c16:: with SMTP id c22mr41564941pgc.333.1558656291059;
        Thu, 23 May 2019 17:04:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm625527pfp.32.2019.05.23.17.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 17:04:50 -0700 (PDT)
Date:   Thu, 23 May 2019 17:04:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, cl@linux.com,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/3] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201905231647.ED31A5FE30@keescook>
References: <20190523140844.132150-1-glider@google.com>
 <20190523140844.132150-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523140844.132150-2-glider@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 23, 2019 at 04:08:42PM +0200, Alexander Potapenko wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 52e6fbb042cc..68fb6fa41cc1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1673,6 +1673,14 @@
>  
>  	initrd=		[BOOT] Specify the location of the initial ramdisk
>  
> +	init_on_alloc=	[MM] Fill newly allocated pages and heap objects with
> +			zeroes.
> +			Format: 0 | 1
> +			Default set by CONFIG_INIT_ON_ALLOC_DEFAULT_ON.
> +	init_on_free=	[MM] Fill freed pages and heap objects with zeroes.
> +			Format: 0 | 1
> +			Default set by CONFIG_INIT_ON_FREE_DEFAULT_ON.
> +
>  	init_pkru=	[x86] Specify the default memory protection keys rights
>  			register contents for all processes.  0x55555554 by
>  			default (disallow access to all but pkey 0).  Can

Nit: add a blank line between these new options' documentation to match
the others.

> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 0a1d4ca314f4..87883e3e3c2a 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -159,6 +159,20 @@ config STACKLEAK_RUNTIME_DISABLE
>  	  runtime to control kernel stack erasing for kernels built with
>  	  CONFIG_GCC_PLUGIN_STACKLEAK.
>  
> +config INIT_ON_ALLOC_DEFAULT_ON
> +	bool "Set init_on_alloc=1 by default"
> +	help
> +	  Enable init_on_alloc=1 by default, making the kernel initialize every
> +	  page and heap allocation with zeroes.
> +	  init_on_alloc can be overridden via command line.
> +
> +config INIT_ON_FREE_DEFAULT_ON
> +	bool "Set init_on_free=1 by default"
> +	help
> +	  Enable init_on_free=1 by default, making the kernel initialize freed
> +	  pages and slab memory with zeroes.
> +	  init_on_free can be overridden via command line.
> +

I think these could use a lot more detail. How about something like
these, with more details and performance notes:

config INIT_ON_ALLOC_DEFAULT_ON
	bool "Enable heap memory zeroing on allocation by default"
	help
	  This has the effect of setting "init_on_alloc=1" on the kernel
	  command line. This can be disabled with "init_on_alloc=0".
	  When "init_on_alloc" is enabled, all page allocator and slab
	  allocator memory will be zeroed when allocated, eliminating
	  many kinds of "uninitialized heap memory" flaws, especially
	  heap content exposures. The performance impact varies by
	  workload, but most cases see <1% impact. Some synthetic
	  workloads have measured as high as 7%.

config INIT_ON_FREE_DEFAULT_ON
	bool "Enable heap memory zeroing on free by default"
	help
	  This has the effect of setting "init_on_free=1" on the kernel
	  command line. This can be disabled with "init_on_free=0".
	  Similar to "init_on_alloc", when "init_on_free" is enabled,
	  all page allocator and slab allocator memory will be zeroed
	  when freed, eliminating many kinds of "uninitialized heap memory"
	  flaws, especially heap content exposures. The primary difference
	  with "init_on_free" is that data lifetime in memory is reduced,
	  as anything freed is wiped immediately, making live forensics or
	  cold boot memory attacks unable to recover freed memory contents.
	  The performance impact varies by workload, but is more expensive
	  than "init_on_alloc" due to the negative cache effects of
	  touching "cold" memory areas. Most cases see 3-5% impact. Some
	  synthetic workloads have measured as high as 8%.


-- 
Kees Cook


-- 
Kees Cook
