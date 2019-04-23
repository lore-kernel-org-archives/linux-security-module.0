Return-Path: <SRS0=iQUf=SZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744E6C10F03
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 19:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3207421773
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 19:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JwagZLYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfDWTLZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:11:25 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46642 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfDWTLZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Apr 2019 15:11:25 -0400
Received: by mail-vs1-f67.google.com with SMTP id e2so8924650vsc.13
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2019 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHtt5m+l+HCxm2/aQ3CiCdm/qRf6FDQPPHURcC67FHo=;
        b=JwagZLYuUJZLwQj169iGPTDtVDfEsTyhf4LGF838jLBuKkjd4b/5k6dh6osH1hBA/G
         KXBt4JKuqlV4PmpQLbsBbCB8IU0jaQ3Fu9nZ5iLMnzb4Jjk5yiMotnrtn4zJWcERR4co
         AiNIc4sN9Pv+o/DIENIkK3b+C56hA5e9QydZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHtt5m+l+HCxm2/aQ3CiCdm/qRf6FDQPPHURcC67FHo=;
        b=l+JJAerRDiIm7VWmqT4yu5MLwKSLBS6DVDPeXdeTnBl/Kxh+bQehNsNjY+tQ7EuWWr
         GOYWgNkgEuqNUv84C21G6NteTUbpXqIsMmoJSF/d48TzKSaBcH2CH4SKWHkpYneXGjoK
         pqYcRPK80Ru+/O0sTJMKCKzsDpvt8gontsm3EgoM8cJ4E3nQfysnMLgKSDpFU3DXkUKf
         3WdiS5AHTF/teeTDl8qnIfKgXvQ2fBeWtBBG4H3mxh6yX26gtJEj3HvcRz8oohSSbS4U
         SCGvCdlbaQVvFPoAz5eF2E4PSG8nRWSzDth2xXiUE5miev2TdqBRfjNfx0Ka36PMFXPq
         kHQA==
X-Gm-Message-State: APjAAAWlT5CQHGFHKeXEgD6sONSaipbW9HfqleQk5iBpteBwRtKMMMxG
        IqLrnlwfh1yqLLW2+OlPkLOf7VtRjC4=
X-Google-Smtp-Source: APXvYqwn3BJRU8MBTOQ5To5cpLlEeuvvPOEaiy/O467wmu+jjLAp5mf+0KVcH1wfAZYIwiAcff/ujg==
X-Received: by 2002:a67:828f:: with SMTP id e137mr14762148vsd.131.1556046683692;
        Tue, 23 Apr 2019 12:11:23 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id b185sm2455945vka.52.2019.04.23.12.11.22
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 12:11:22 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id d8so8890250vsp.2
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2019 12:11:22 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr14352168vsp.188.1556046682180;
 Tue, 23 Apr 2019 12:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190418154208.131118-1-glider@google.com> <20190418154208.131118-3-glider@google.com>
In-Reply-To: <20190418154208.131118-3-glider@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 12:11:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ0EKVjKHFJETP+YnRPuT_Gr=ozXYU6sgak26BBCAEp7A@mail.gmail.com>
Message-ID: <CAGXu5jJ0EKVjKHFJETP+YnRPuT_Gr=ozXYU6sgak26BBCAEp7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] gfp: mm: introduce __GFP_NOINIT
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 18, 2019 at 8:42 AM Alexander Potapenko <glider@google.com> wrote:
>
> When passed to an allocator (either pagealloc or SL[AOU]B), __GFP_NOINIT
> tells it to not initialize the requested memory if the init_allocations
> boot option is enabled. This can be useful in the cases the newly
> allocated memory is going to be initialized by the caller right away.

Maybe add "... as seen when the slab allocator needs to allocate new
pages from the page allocator." just to help clarify it here (instead
of from the end of the commit log where you mention it offhand).

>
> __GFP_NOINIT basically defeats the hardening against information leaks
> provided by the init_allocations feature, so one should use it with
> caution.
>
> This patch also adds __GFP_NOINIT to alloc_pages() calls in SL[AOU]B.
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
> Cc: Qian Cai <cai@lca.pw>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> ---
>  include/linux/gfp.h | 6 +++++-
>  include/linux/mm.h  | 2 +-
>  kernel/kexec_core.c | 2 +-
>  mm/slab.c           | 2 +-
>  mm/slob.c           | 1 +
>  mm/slub.c           | 1 +
>  6 files changed, 10 insertions(+), 4 deletions(-)
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
>  /* If the above are modified, __GFP_BITS_SHIFT may need updating */

I think you want to add NOINIT below GFP_ACCOUNT, update NOLOCKDEP and
then adjust GFP_BITS_SHIFT differently, noted below.

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

This should just be 24 + ...   with the bit field added above NOLOCKDEP.

>  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
>
>  /**
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b38b71a5efaa..8f03334a9033 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2601,7 +2601,7 @@ DECLARE_STATIC_KEY_FALSE(init_allocations);
>  static inline bool want_init_memory(gfp_t flags)
>  {
>         if (static_branch_unlikely(&init_allocations))
> -               return true;
> +               return !(flags & __GFP_NOINIT);
>         return flags & __GFP_ZERO;
>  }

You need to test for GFP_ZERO here too: return ((flags & __GFP_NOINIT
| __GFP_ZERO) == 0)

Also, I wonder, for the sake of readability, if this should be named
__GFP_NO_AUTOINIT ?

I'd also like to see each use of __GFP_NOINIT include a comment above
its use where the logic is explained for _why_ it's safe (or
reasonable) to use __GFP_NOINIT in each place.

>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be84f5f95c97..f9d1f1236cd0 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -302,7 +302,7 @@ static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
>  {
>         struct page *pages;
>
> -       pages = alloc_pages(gfp_mask & ~__GFP_ZERO, order);
> +       pages = alloc_pages((gfp_mask & ~__GFP_ZERO) | __GFP_NOINIT, order);
>         if (pages) {
>                 unsigned int count, i;
>
> diff --git a/mm/slab.c b/mm/slab.c
> index dcc5b73cf767..762cb0e7bcc1 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1393,7 +1393,7 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>         struct page *page;
>         int nr_pages;
>
> -       flags |= cachep->allocflags;
> +       flags |= (cachep->allocflags | __GFP_NOINIT);
>
>         page = __alloc_pages_node(nodeid, flags, cachep->gfporder);
>         if (!page) {
> diff --git a/mm/slob.c b/mm/slob.c
> index 18981a71e962..867d2d68a693 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -192,6 +192,7 @@ static void *slob_new_pages(gfp_t gfp, int order, int node)
>  {
>         void *page;
>
> +       gfp |= __GFP_NOINIT;
>  #ifdef CONFIG_NUMA
>         if (node != NUMA_NO_NODE)
>                 page = __alloc_pages_node(node, gfp, order);
> diff --git a/mm/slub.c b/mm/slub.c
> index e4efb6575510..a79b4cb768a2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1493,6 +1493,7 @@ static inline struct page *alloc_slab_page(struct kmem_cache *s,

What about kmalloc_large_node()?

>         struct page *page;
>         unsigned int order = oo_order(oo);
>
> +       flags |= __GFP_NOINIT;
>         if (node == NUMA_NO_NODE)
>                 page = alloc_pages(flags, order);
>         else

And just so I make sure I'm understanding this correctly: __GFP_NOINIT
is passed to the page allocator because we know each allocation from
the slab will get initialized at "sub allocation" time.

Looks good!

-- 
Kees Cook
