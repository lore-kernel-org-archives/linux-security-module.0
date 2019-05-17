Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6218FC04E87
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2947020873
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 08:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTu4YULs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfEQIej (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 04:34:39 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35271 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfEQIej (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 04:34:39 -0400
Received: by mail-vk1-f196.google.com with SMTP id k1so1805640vkb.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 01:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IXFYp9dXdqOGmv2GZlMSV+ZWmX1vIYgX7tAhUZgFrwY=;
        b=UTu4YULsBx6VcP9vrIzXhWm8Y+uCliaAjCh+8sltKt7pcgDt89X+byBprR+w0oWZbk
         deRXHG5rJJPcFWTG21XQAz9q+pVUWgpPBtQH3FDC29d+IUGf1Bz6IdJJ2CaJJq8NGRdG
         pd7sytdMIQhbiFykg3BicDQ6d7Lxtj3N9wmelAiCFsp3EIrogWuATiiRsXVdQtFLc2id
         ZrZK8yhfe1Hw2A50tFa1/63RdDrt1r63SaCIKO2T2fsltnD3sStlFhhsX68SaZdKa8/A
         3M31PwIcH4mpKtYmeowBMWKe5emm5Bj8pgYyXIMwXrP/0w2/vTYCgdz6HLeX5VY1FmuJ
         j1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IXFYp9dXdqOGmv2GZlMSV+ZWmX1vIYgX7tAhUZgFrwY=;
        b=pph2YDubGwSvs7KsahiPJiRO49XzFQsfK/ARNZAx3081MFysX2UYYqquoq2M/mj8U5
         frWX6cygZlA5Yi7eGxi2gzh2agfkW27Q8mu8DUtVzMQYETzwRbgYc/Yy3QKzWl3D4/bm
         E+h7MzwEQmGeHA0wFAKzV3mWhmEHOiWDBp2NxTZ59JDiYQjwVYm2nBw1WtCu24k+B2pF
         rh/ITzTHHd/ymvj3j/362bAvPe9L752IgmlNDaPyWNyqqf+r9cdS01TtiWwS26ppnbCU
         9KLfbfmJZWK/+KSxeNAyaexU2YjQHYT5EKv7n0u9BYmbYx//VwhgEr4s8ya1S2qSgOoW
         0DVg==
X-Gm-Message-State: APjAAAXEkV0j8QIu6sRHAowlH8bxE92VcPL8F3EEEdQwrow6c2tOQ9v2
        BP32hWRH0zGCBSJ6hMgvEbh9bPxlvp1r+A8OsdYDQg==
X-Google-Smtp-Source: APXvYqyyuNywbu+7GesPli45mX02H2z5juDdbDIF7jowpZusr4p7m2UEfICnYf6Udf4bUxb0LNMiwSRXEQnzj4itKH8=
X-Received: by 2002:a1f:6011:: with SMTP id u17mr1711683vkb.64.1558082077400;
 Fri, 17 May 2019 01:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190514143537.10435-5-glider@google.com> <201905161746.16E885F@keescook>
In-Reply-To: <201905161746.16E885F@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 May 2019 10:34:26 +0200
Message-ID: <CAG_fn=W41zDac9DN9qVB_EwJG89f2cNBQYNyove4oO3dwe6d5Q@mail.gmail.com>
Subject: Re: [PATCH 5/4] mm: Introduce SLAB_NO_FREE_INIT and mark excluded caches
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 17, 2019 at 2:50 AM Kees Cook <keescook@chromium.org> wrote:
>
> In order to improve the init_on_free performance, some frequently
> freed caches with less sensitive contents can be excluded from the
> init_on_free behavior.
Did you see any notable performance improvement with this patch?
A similar one gave me only 1-2% on the parallel Linux build.
> This patch is modified from Brad Spengler/PaX Team's code in the
> last public patch of grsecurity/PaX based on my understanding of the
> code. Changes or omissions from the original code are mine and don't
> reflect the original grsecurity/PaX code.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/buffer.c          | 2 +-
>  fs/dcache.c          | 3 ++-
>  include/linux/slab.h | 3 +++
>  kernel/fork.c        | 6 ++++--
>  mm/rmap.c            | 5 +++--
>  mm/slab.h            | 5 +++--
>  net/core/skbuff.c    | 6 ++++--
>  7 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 0faa41fb4c88..04a85bd4cf2e 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3457,7 +3457,7 @@ void __init buffer_init(void)
>         bh_cachep =3D kmem_cache_create("buffer_head",
>                         sizeof(struct buffer_head), 0,
>                                 (SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
> -                               SLAB_MEM_SPREAD),
> +                               SLAB_MEM_SPREAD|SLAB_NO_FREE_INIT),
>                                 NULL);
>
>         /*
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 8136bda27a1f..323b039accba 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -3139,7 +3139,8 @@ void __init vfs_caches_init_early(void)
>  void __init vfs_caches_init(void)
>  {
>         names_cachep =3D kmem_cache_create_usercopy("names_cache", PATH_M=
AX, 0,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL)=
;
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_NO_FREE_INIT, =
0,
> +                       PATH_MAX, NULL);
>
>         dcache_init();
>         inode_init();
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 9449b19c5f10..7eba9ad8830d 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -92,6 +92,9 @@
>  /* Avoid kmemleak tracing */
>  #define SLAB_NOLEAKTRACE       ((slab_flags_t __force)0x00800000U)
>
> +/* Exclude slab from zero-on-free when init_on_free is enabled */
> +#define SLAB_NO_FREE_INIT      ((slab_flags_t __force)0x01000000U)
> +
>  /* Fault injection mark */
>  #ifdef CONFIG_FAILSLAB
>  # define SLAB_FAILSLAB         ((slab_flags_t __force)0x02000000U)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b4cba953040a..9868585f5520 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2550,11 +2550,13 @@ void __init proc_caches_init(void)
>
>         mm_cachep =3D kmem_cache_create_usercopy("mm_struct",
>                         mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT|
> +                       SLAB_NO_FREE_INIT,
>                         offsetof(struct mm_struct, saved_auxv),
>                         sizeof_field(struct mm_struct, saved_auxv),
>                         NULL);
> -       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACC=
OUNT);
> +       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACC=
OUNT|
> +                                                   SLAB_NO_FREE_INIT);
>         mmap_init();
>         nsproxy_cache_init();
>  }
> diff --git a/mm/rmap.c b/mm/rmap.c
> index e5dfe2ae6b0d..b7b8013eeb0a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -432,10 +432,11 @@ static void anon_vma_ctor(void *data)
>  void __init anon_vma_init(void)
>  {
>         anon_vma_cachep =3D kmem_cache_create("anon_vma", sizeof(struct a=
non_vma),
> -                       0, SLAB_TYPESAFE_BY_RCU|SLAB_PANIC|SLAB_ACCOUNT,
> +                       0, SLAB_TYPESAFE_BY_RCU|SLAB_PANIC|SLAB_ACCOUNT|
> +                       SLAB_NO_FREE_INIT,
>                         anon_vma_ctor);
>         anon_vma_chain_cachep =3D KMEM_CACHE(anon_vma_chain,
> -                       SLAB_PANIC|SLAB_ACCOUNT);
> +                       SLAB_PANIC|SLAB_ACCOUNT|SLAB_NO_FREE_INIT);
>  }
>
>  /*
> diff --git a/mm/slab.h b/mm/slab.h
> index 24ae887359b8..f95b4f03c57b 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -129,7 +129,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned =
int object_size,
>  /* Legal flag mask for kmem_cache_create(), for various configurations *=
/
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> -                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
> +                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
> +                        SLAB_NO_FREE_INIT)
>
>  #if defined(CONFIG_DEBUG_SLAB)
>  #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
> @@ -535,7 +536,7 @@ static inline bool slab_want_init_on_alloc(gfp_t flag=
s, struct kmem_cache *c)
>  static inline bool slab_want_init_on_free(struct kmem_cache *c)
>  {
>         if (static_branch_unlikely(&init_on_free))
> -               return !(c->ctor);
> +               return !(c->ctor) && ((c->flags & SLAB_NO_FREE_INIT) =3D=
=3D 0);
>         else
>                 return false;
>  }
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e89be6282693..b65902d2c042 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3981,14 +3981,16 @@ void __init skb_init(void)
>         skbuff_head_cache =3D kmem_cache_create_usercopy("skbuff_head_cac=
he",
>                                               sizeof(struct sk_buff),
>                                               0,
> -                                             SLAB_HWCACHE_ALIGN|SLAB_PAN=
IC,
> +                                             SLAB_HWCACHE_ALIGN|SLAB_PAN=
IC|
> +                                             SLAB_NO_FREE_INIT,
>                                               offsetof(struct sk_buff, cb=
),
>                                               sizeof_field(struct sk_buff=
, cb),
>                                               NULL);
>         skbuff_fclone_cache =3D kmem_cache_create("skbuff_fclone_cache",
>                                                 sizeof(struct sk_buff_fcl=
ones),
>                                                 0,
> -                                               SLAB_HWCACHE_ALIGN|SLAB_P=
ANIC,
> +                                               SLAB_HWCACHE_ALIGN|SLAB_P=
ANIC|
> +                                               SLAB_NO_FREE_INIT,
>                                                 NULL);
>         skb_extensions_init();
>  }
> --
> 2.17.1
>
>
> --
> Kees Cook



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
