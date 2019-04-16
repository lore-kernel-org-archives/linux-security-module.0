Return-Path: <SRS0=WmJh=SS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C051C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 02:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5DA2084B
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 02:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555380136;
	bh=PDu0IIP7BV+JY0VdchKq6Zuwd7LFfJmDxgTFn+z7+es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UUkHvHz/njCqB5PJH8Au52nd1fZGUbMvgA7e2ShmTiwfb2gJJxgoU6v6w0Zx/hA/a
	 NDbAs4Fd7qN4PxKWiV5duYo7OeC14Rn0BOn4gYh1WxyJOHplPI2mzamKirh6k8EGyG
	 5iC6gKpy+FZzGJcH0TbOfV5zsPDJEhvAk3dgcE/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfDPCCP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:02:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfDPCCP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Apr 2019 22:02:15 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3DE82941;
        Tue, 16 Apr 2019 02:02:14 +0000 (UTC)
Date:   Mon, 15 Apr 2019 19:02:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        ndesaulniers@google.com, kcc@google.com, dvyukov@google.com,
        keescook@chromium.org, sspatil@android.com, labbott@redhat.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] mm: security: introduce CONFIG_INIT_HEAP_ALL
Message-Id: <20190415190213.5831bbc17e5073690713b001@linux-foundation.org>
In-Reply-To: <20190412124501.132678-1-glider@google.com>
References: <20190412124501.132678-1-glider@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 12 Apr 2019 14:45:01 +0200 Alexander Potapenko <glider@google.com> wrote:

> This config option adds the possibility to initialize newly allocated
> pages and heap objects with zeroes.

At what cost?  Some performance test results would help this along.

> This is needed to prevent possible
> information leaks and make the control-flow bugs that depend on
> uninitialized values more deterministic.
> 
> Initialization is done at allocation time at the places where checks for
> __GFP_ZERO are performed. We don't initialize slab caches with
> constructors or SLAB_TYPESAFE_BY_RCU to preserve their semantics.
> 
> For kernel testing purposes filling allocations with a nonzero pattern
> would be more suitable, but may require platform-specific code. To have
> a simple baseline we've decided to start with zero-initialization.
> 
> No performance optimizations are done at the moment to reduce double
> initialization of memory regions.

Requiring a kernel rebuild is rather user-hostile.  A boot option
(early_param()) would be much more useful and I expect that the loss in
coverage would be small and acceptable?  Could possibly use the
static_branch infrastructure.

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

Is there any reason why this *must* be implemented as a macro?  If not,
it should be written in C please.


