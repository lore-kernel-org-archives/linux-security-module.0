Return-Path: <SRS0=Yqxb=TI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959CCC04A6B
	for <linux-security-module@archiver.kernel.org>; Wed,  8 May 2019 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3652053B
	for <linux-security-module@archiver.kernel.org>; Wed,  8 May 2019 19:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CFwO3s1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfEHTIj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 May 2019 15:08:39 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45773 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEHTIj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 May 2019 15:08:39 -0400
Received: by mail-vs1-f68.google.com with SMTP id o10so13341560vsp.12
        for <linux-security-module@vger.kernel.org>; Wed, 08 May 2019 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qI7nQdd3bNYCa2qF4UH/4IqrrO0K8+DgZr0J5nYZ54=;
        b=CFwO3s1B4b6gP84OVgCdY0F8XJ7Y2NgQn0S0V9cEflkmltxNycTIalnzb+5p+pWV3J
         45bh/SDBPLW0AQ3qJzdK4EptfEdJuqhNSAwQcT9ShwAhyA9io4vJn45B57823OdiUHhi
         v9viJPqnmNK011qboLI/zS/IJ7LA/BE7RzBm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qI7nQdd3bNYCa2qF4UH/4IqrrO0K8+DgZr0J5nYZ54=;
        b=JERaTx/Z8e+w5ByyoU6rzrp/JG7LteT14QTb1YqJymjYRBLJO1SFVzpyHuY01dRfHJ
         KZdPlUuKVNBdzAPDfCVGHbTLo0+CxHgMz3ba7aPwZiwZnwdtX1/3Dv+QBmgljHlYMc+7
         Uf2n0nCDLJzE1AITB9xFeICPoR4WePBY8kC7Q+jp/+3MBXHUF/rAid1QtmadTk1tfFXT
         LEmE6hvcHlvLWK7/QnaZdG6/imKed4JwIPLVCBue91ol+M7f2ILJF+Ghd67s7qH6nKAg
         4e/I7g3O5NcNOnP7kiYTDYXVydOjyeETQnd45u1CRqtu3vSFsKmUgLotyOAfKOcGuUI7
         x9sw==
X-Gm-Message-State: APjAAAVidJZ05dQCy1i81mUzDS1VT+cv00Qqsd1GiCPqKxifkq9EdX9k
        hY5vO02HMnR9OnqUcgalhIwwnr5bu2s=
X-Google-Smtp-Source: APXvYqyotvH06k944CEIYhLx5GWTGaAQWmIMxHnZWIoPLHL/xdAMUpMHctUUHTHOh0BPX+T2if8okg==
X-Received: by 2002:a67:69c4:: with SMTP id e187mr22316050vsc.214.1557342517008;
        Wed, 08 May 2019 12:08:37 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id u3sm6574146vsi.2.2019.05.08.12.08.35
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 12:08:35 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id l73so2469885vkl.8
        for <linux-security-module@vger.kernel.org>; Wed, 08 May 2019 12:08:35 -0700 (PDT)
X-Received: by 2002:a1f:3804:: with SMTP id f4mr5366867vka.4.1557342514950;
 Wed, 08 May 2019 12:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190508153736.256401-1-glider@google.com> <20190508153736.256401-4-glider@google.com>
In-Reply-To: <20190508153736.256401-4-glider@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 8 May 2019 12:08:23 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJS=KgLwetdmDAUq9+KhUFTd=jnCES3BZJm+qBwUBmLjQ@mail.gmail.com>
Message-ID: <CAGXu5jJS=KgLwetdmDAUq9+KhUFTd=jnCES3BZJm+qBwUBmLjQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] gfp: mm: introduce __GFP_NOINIT
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 8, 2019 at 8:38 AM Alexander Potapenko <glider@google.com> wrote:
> When passed to an allocator (either pagealloc or SL[AOU]B), __GFP_NOINIT
> tells it to not initialize the requested memory if the init_on_alloc
> boot option is enabled. This can be useful in the cases newly allocated
> memory is going to be initialized by the caller right away.
>
> __GFP_NOINIT doesn't affect init_on_free behavior, except for SLOB,
> where init_on_free implies init_on_alloc.
>
> __GFP_NOINIT basically defeats the hardening against information leaks
> provided by init_on_alloc, so one should use it with caution.
>
> This patch also adds __GFP_NOINIT to alloc_pages() calls in SL[AOU]B.
> Doing so is safe, because the heap allocators initialize the pages they
> receive before passing memory to the callers.
>
> Slowdown for the initialization features compared to init_on_free=0,
> init_on_alloc=0:
>
> hackbench, init_on_free=1:  +6.84% sys time (st.err 0.74%)
> hackbench, init_on_alloc=1: +7.25% sys time (st.err 0.72%)
>
> Linux build with -j12, init_on_free=1:  +8.52% wall time (st.err 0.42%)
> Linux build with -j12, init_on_free=1:  +24.31% sys time (st.err 0.47%)
> Linux build with -j12, init_on_alloc=1: -0.16% wall time (st.err 0.40%)
> Linux build with -j12, init_on_alloc=1: +1.24% sys time (st.err 0.39%)
>
> The slowdown for init_on_free=0, init_on_alloc=0 compared to the
> baseline is within the standard error.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Sandeep Patil <sspatil@android.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-mm@kvack.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> ---
>  include/linux/gfp.h | 6 +++++-
>  include/linux/mm.h  | 2 +-
>  kernel/kexec_core.c | 2 +-
>  mm/slab.c           | 2 +-
>  mm/slob.c           | 3 ++-
>  mm/slub.c           | 1 +
>  6 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index fdab7de7490d..66d7f5604fe2 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -44,6 +44,7 @@ struct vm_area_struct;
>  #else
>  #define ___GFP_NOLOCKDEP       0
>  #endif
> +#define ___GFP_NOINIT          0x1000000u

I mentioned this in the other patch, but I think this needs to be
moved ahead of GFP_NOLOCKDEP and adjust the values for GFP_NOLOCKDEP
and to leave the IS_ENABLED() test in __GFP_BITS_SHIFT alone.

>  /* If the above are modified, __GFP_BITS_SHIFT may need updating */
>
>  /*
> @@ -208,16 +209,19 @@ struct vm_area_struct;
>   * %__GFP_COMP address compound page metadata.
>   *
>   * %__GFP_ZERO returns a zeroed page on success.
> + *
> + * %__GFP_NOINIT requests non-initialized memory from the underlying allocator.
>   */
>  #define __GFP_NOWARN   ((__force gfp_t)___GFP_NOWARN)
>  #define __GFP_COMP     ((__force gfp_t)___GFP_COMP)
>  #define __GFP_ZERO     ((__force gfp_t)___GFP_ZERO)
> +#define __GFP_NOINIT   ((__force gfp_t)___GFP_NOINIT)
>
>  /* Disable lockdep for GFP context tracking */
>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>
>  /* Room for N __GFP_FOO bits */
> -#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
> +#define __GFP_BITS_SHIFT (25)

AIUI, this will break non-CONFIG_LOCKDEP kernels: it should just be:

-#define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (24 + IS_ENABLED(CONFIG_LOCKDEP))

>  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
>
>  /**
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ee1a1092679c..8ab152750eb4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2618,7 +2618,7 @@ DECLARE_STATIC_KEY_FALSE(init_on_alloc);
>  static inline bool want_init_on_alloc(gfp_t flags)
>  {
>         if (static_branch_unlikely(&init_on_alloc))
> -               return true;
> +               return !(flags & __GFP_NOINIT);
>         return flags & __GFP_ZERO;

What do you think about renaming __GFP_NOINIT to __GFP_NO_AUTOINIT or something?

Regardless, yes, this is nice.

-- 
Kees Cook
