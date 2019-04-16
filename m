Return-Path: <SRS0=WmJh=SS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB68C10F13
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 15:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A482720872
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 15:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="X5278fNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfDPPcW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:32:22 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:38578 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfDPPcW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Apr 2019 11:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1555428741;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=/ZH+qQc+d3T9Uz+fe5gzibpOM/H0qPfROftUoVT10Kc=;
        b=X5278fNazPX14D+0RglGkXaLk/g3fLT6eAzYLZi9e90hc9jiTiSW+k+2BnL4rePK
        ol+DvSy7dHo7KUTaLL2v1Ovpxx9eOiLnuKqraWmO7vHFssb4k4zVGGOWYYCqzVSuiv/
        QCFin1yOMUal5z5Wg33FXWOF+U7DW3get5Q0Ax1A=
Date:   Tue, 16 Apr 2019 15:32:21 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Alexander Potapenko <glider@google.com>
cc:     akpm@linux-foundation.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, ndesaulniers@google.com, kcc@google.com,
        dvyukov@google.com, Kees Cook <keescook@chromium.org>,
        sspatil@android.com, labbott@redhat.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] mm: security: introduce CONFIG_INIT_HEAP_ALL
In-Reply-To: <20190412124501.132678-1-glider@google.com>
Message-ID: <0100016a26c711be-b99971ca-49f5-482c-9028-962ee471f733-000000@email.amazonses.com>
References: <20190412124501.132678-1-glider@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.16-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 12 Apr 2019, Alexander Potapenko wrote:

> diff --git a/mm/slab.h b/mm/slab.h
> index 43ac818b8592..4bb10af0031b 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -167,6 +167,16 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  			      SLAB_TEMPORARY | \
>  			      SLAB_ACCOUNT)
>
> +/*
> + * Do we need to initialize this allocation?
> + * Always true for __GFP_ZERO, CONFIG_INIT_HEAP_ALL enforces initialization
> + * of caches without constructors and RCU.
> + */
> +#define SLAB_WANT_INIT(cache, gfp_flags) \
> +	((GFP_INIT_ALWAYS_ON && !(cache)->ctor && \
> +	  !((cache)->flags & SLAB_TYPESAFE_BY_RCU)) || \
> +	 (gfp_flags & __GFP_ZERO))

This is another complex thing to maintain when adding flags to the slab
allocator.

> +config INIT_HEAP_ALL
> +	bool "Initialize kernel heap allocations"

"Zero pages and objects allocated in the kernel"

> +	default n
> +	help
> +	  Enforce initialization of pages allocated from page allocator
> +	  and objects returned by kmalloc and friends.
> +	  Allocated memory is initialized with zeroes, preventing possible
> +	  information leaks and making the control-flow bugs that depend
> +	  on uninitialized values more deterministic.

Hmmm... But we already have debugging options that poison objects and
pages?
