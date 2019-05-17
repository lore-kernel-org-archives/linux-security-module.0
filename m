Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317A5C04AAF
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 00:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D5F206BF
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 00:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ASs9/AsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfEQA0N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 May 2019 20:26:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38668 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfEQA0N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 May 2019 20:26:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id b76so2715996pfb.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2019 17:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ilDv0+YTa/WnY3XhZH80fN4U1WpmetjpQlVMabTh6tw=;
        b=ASs9/AsKmgukkUd8ZkGKrmFLrJLHhcmjh9zttsNZWu9UiLxwGqq+jTPLZfvADEE6BT
         0wo7n9b7ck3n1cRmgHDKeiMzhg+VhnE8FHKem/W4KuR+HtEfYDi+njtYVyXvv+cb4FKI
         TheGLDDVwvh9uyy0Qq5Jox9zPBUe3teBFpXhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilDv0+YTa/WnY3XhZH80fN4U1WpmetjpQlVMabTh6tw=;
        b=cezb4sHBCTfvD4XElJB4pUsyayxaXX3UdTVMghZEcu6HHbSsNCTjRThYqe0Apo5Y1y
         coOIO0Vn+Bu4S8gGz51QNYEk/GPilobS+Td55/MlEIE2fKP18gTLpeXLhrkBrWI9ExFC
         EzWTKAriJ9QoR93ov3KoyPjxKlMNuuemRbh6U/6D5Psvt1IjzvopG1EgkfD0FVKoj/Ty
         WEk1I2LiZSvI+3KIEvTE1yc8CSrob6YZOYYXe0A1QYXco3Rgeo5NHiKEu+IecmtaYAyR
         PVqnlRyh6atCms569i/+llFGi7UIj1CuQZAGk4o4K/XEHltBF6jTtze/+6K5Nprh54Fd
         Azqg==
X-Gm-Message-State: APjAAAW37lFAnKjtziTRZuKx/w0WtXmDig2uU6W5fugpzSAQN9XfalSS
        ShyB428LxhfUr1zfj4QdWIC1fY6sSb8=
X-Google-Smtp-Source: APXvYqwlMKqnUliknBdwEvFPxguLJNac2aseYZx+RJq6e02esXvj8m81/U384KtDWip6FxOC9kYkMg==
X-Received: by 2002:a63:ef56:: with SMTP id c22mr2023348pgk.13.1558052772428;
        Thu, 16 May 2019 17:26:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r64sm14143496pfa.25.2019.05.16.17.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 17:26:11 -0700 (PDT)
Date:   Thu, 16 May 2019 17:26:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, cl@linux.com,
        kernel-hardening@lists.openwall.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: apply __GFP_NO_AUTOINIT to AF_UNIX sk_buff
 allocations
Message-ID: <201905161714.A53D472D9@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-5-glider@google.com>
 <201905160923.BD3E530EFC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905160923.BD3E530EFC@keescook>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 16, 2019 at 09:53:01AM -0700, Kees Cook wrote:
> On Tue, May 14, 2019 at 04:35:37PM +0200, Alexander Potapenko wrote:
> > Add sock_alloc_send_pskb_noinit(), which is similar to
> > sock_alloc_send_pskb(), but allocates with __GFP_NO_AUTOINIT.
> > This helps reduce the slowdown on hackbench in the init_on_alloc mode
> > from 6.84% to 3.45%.
> 
> Out of curiosity, why the creation of the new function over adding a
> gfp flag argument to sock_alloc_send_pskb() and updating callers? (There
> are only 6 callers, and this change already updates 2 of those.)
> 
> > Slowdown for the initialization features compared to init_on_free=0,
> > init_on_alloc=0:
> > 
> > hackbench, init_on_free=1:  +7.71% sys time (st.err 0.45%)
> > hackbench, init_on_alloc=1: +3.45% sys time (st.err 0.86%)

So I've run some of my own wall-clock timings of kernel builds (which
should be an pretty big "worst case" situation, and I see much smaller
performance changes:

everything off
	Run times: 289.18 288.61 289.66 287.71 287.67
	Min: 287.67 Max: 289.66 Mean: 288.57 Std Dev: 0.79
		baseline

init_on_alloc=1
	Run times: 289.72 286.95 287.87 287.34 287.35
	Min: 286.95 Max: 289.72 Mean: 287.85 Std Dev: 0.98
		0.25% faster (within the std dev noise)

init_on_free=1
	Run times: 303.26 301.44 301.19 301.55 301.39
	Min: 301.19 Max: 303.26 Mean: 301.77 Std Dev: 0.75
		4.57% slower

init_on_free=1 with the PAX_MEMORY_SANITIZE slabs excluded:
	Run times: 299.19 299.85 298.95 298.23 298.64
	Min: 298.23 Max: 299.85 Mean: 298.97 Std Dev: 0.55
		3.60% slower

So the tuning certainly improved things by 1%. My perf numbers don't
show the 24% hit you were seeing at all, though.

> In the commit log it might be worth mentioning that this is only
> changing the init_on_alloc case (in case it's not already obvious to
> folks). Perhaps there needs to be a split of __GFP_NO_AUTOINIT into
> __GFP_NO_AUTO_ALLOC_INIT and __GFP_NO_AUTO_FREE_INIT? Right now
> __GFP_NO_AUTOINIT is only checked for init_on_alloc:

I was obviously crazy here. :) GFP isn't present for free(), but a SLAB
flag works (as was done in PAX_MEMORY_SANITIZE). I'll send the patch I
used for the above timing test.

-- 
Kees Cook
