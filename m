Return-Path: <SRS0=478F=TU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82664C04AAF
	for <linux-security-module@archiver.kernel.org>; Mon, 20 May 2019 06:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BF820657
	for <linux-security-module@archiver.kernel.org>; Mon, 20 May 2019 06:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y0j6sgfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfETGKb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 May 2019 02:10:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44745 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfETGKb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 May 2019 02:10:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id w25so8079660qkj.11
        for <linux-security-module@vger.kernel.org>; Sun, 19 May 2019 23:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFukLdZ7lb89NEuXmBM0ev5FCwA/kWpf23+eFLzEIzc=;
        b=Y0j6sgfc8k9053lZUMt5CBFGP0kn69SC0iJEQW0SB6iNThpcQOmoG99zvBBpusukVZ
         qA4kSf3AQnhuJgAcUxy6UuCw21GAZA6aj4EBvN4bY3FVkGlSAfQE2ruxt+Kkl658PCqX
         MwZcFB/DwMSAmeq1+Nkcj/G40xH7lWYAslj7bLerr/3XAbdteF6FwjNgA3VWzkPGQ2IX
         s32DEctR+QFtSws0fK7dWAUspu83t0DVKiNxQcBcLTOc88uPJPzxwbY2HpO2URmzy/Bm
         /vrXXLx5jZ0hICGuwDA6cVtAeDAd7R3/V0KJ1YLrLnHNqidbInrrROqP1gBuCXqfziVK
         wzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFukLdZ7lb89NEuXmBM0ev5FCwA/kWpf23+eFLzEIzc=;
        b=j4/gH5D1ZuNFcEEFbXx94/n8b8HuNYW6dzj90V2VW8DHXO/Q55N1W0elpww9K+R8b/
         OhmLciUSJ0rDMVmkhNwwauucCMADqWUTCGIWqgFCpP+LEUbR1ur6DiEf9foUEluC9l5Y
         +Q1m9Ou1XS5gl6/AF+lTDDt9WSqYnPVVG+pq6zCu/8P0UAWE9t6EUutrVYAZm6td1Ba4
         uC50AfAZCyKzr5VrGdA+WhMZMIvvoGlt9HiUXF2nKnxZfWu4TA+FJQqzhuycprB6AAE2
         oDyliqmcTxONvN0m97nuwsF/QWlG46M+VYceFXRYtfHD2Lymi/k3sAJbuaqqdiAM4yj7
         FuHQ==
X-Gm-Message-State: APjAAAVWweLsXD+aHEBsGlfwTc9HTFgl2tiBn4VPGhQlXe82gvcP0uqe
        /EQrWWeLtxhMSBaXbK2R7JM2bgrcjbzbZt2Br44=
X-Google-Smtp-Source: APXvYqxhDBaw1gzS0+uR0z6oe2PI6vSPUSrFMeRAnod4ezCaN0wue1Ets49Z3HT+wJ4G1Ljd7FkZBW40qgfo4D/nd9s=
X-Received: by 2002:a05:620a:5ed:: with SMTP id z13mr20140322qkg.84.1558332630219;
 Sun, 19 May 2019 23:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190514143537.10435-5-glider@google.com> <201905161746.16E885F@keescook>
In-Reply-To: <201905161746.16E885F@keescook>
From:   Mathias Krause <minipli@googlemail.com>
Date:   Mon, 20 May 2019 08:10:19 +0200
Message-ID: <CA+rthh9bLiohU78PBMonji_LPjj756rhTy22v9nL8LpL0cTb5g@mail.gmail.com>
Subject: Re: [PATCH 5/4] mm: Introduce SLAB_NO_FREE_INIT and mark excluded caches
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Kees,

On Fri, 17 May 2019 at 02:50, Kees Cook <keescook@chromium.org> wrote:
> In order to improve the init_on_free performance, some frequently
> freed caches with less sensitive contents can be excluded from the
> init_on_free behavior.
>
> This patch is modified from Brad Spengler/PaX Team's code in the
> last public patch of grsecurity/PaX based on my understanding of the
> code. Changes or omissions from the original code are mine and don't
> reflect the original grsecurity/PaX code.

you might want to give secunet credit for this one, as can be seen here:

  https://github.com/minipli/linux-grsec/commit/309d494e7a3f6533ca68fc8b3bd89fa76fd2c2df

However, please keep the "Changes or omissions from the original
code..." part as your version slightly differs.

Thanks,
Mathias

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
>         bh_cachep = kmem_cache_create("buffer_head",
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
>         names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_NO_FREE_INIT, 0,
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
>         mm_cachep = kmem_cache_create_usercopy("mm_struct",
>                         mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> +                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT|
> +                       SLAB_NO_FREE_INIT,
>                         offsetof(struct mm_struct, saved_auxv),
>                         sizeof_field(struct mm_struct, saved_auxv),
>                         NULL);
> -       vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
> +       vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT|
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
>         anon_vma_cachep = kmem_cache_create("anon_vma", sizeof(struct anon_vma),
> -                       0, SLAB_TYPESAFE_BY_RCU|SLAB_PANIC|SLAB_ACCOUNT,
> +                       0, SLAB_TYPESAFE_BY_RCU|SLAB_PANIC|SLAB_ACCOUNT|
> +                       SLAB_NO_FREE_INIT,
>                         anon_vma_ctor);
>         anon_vma_chain_cachep = KMEM_CACHE(anon_vma_chain,
> -                       SLAB_PANIC|SLAB_ACCOUNT);
> +                       SLAB_PANIC|SLAB_ACCOUNT|SLAB_NO_FREE_INIT);
>  }
>
>  /*
> diff --git a/mm/slab.h b/mm/slab.h
> index 24ae887359b8..f95b4f03c57b 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -129,7 +129,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  /* Legal flag mask for kmem_cache_create(), for various configurations */
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> -                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
> +                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
> +                        SLAB_NO_FREE_INIT)
>
>  #if defined(CONFIG_DEBUG_SLAB)
>  #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
> @@ -535,7 +536,7 @@ static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
>  static inline bool slab_want_init_on_free(struct kmem_cache *c)
>  {
>         if (static_branch_unlikely(&init_on_free))
> -               return !(c->ctor);
> +               return !(c->ctor) && ((c->flags & SLAB_NO_FREE_INIT) == 0);
>         else
>                 return false;
>  }
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e89be6282693..b65902d2c042 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3981,14 +3981,16 @@ void __init skb_init(void)
>         skbuff_head_cache = kmem_cache_create_usercopy("skbuff_head_cache",
>                                               sizeof(struct sk_buff),
>                                               0,
> -                                             SLAB_HWCACHE_ALIGN|SLAB_PANIC,
> +                                             SLAB_HWCACHE_ALIGN|SLAB_PANIC|
> +                                             SLAB_NO_FREE_INIT,
>                                               offsetof(struct sk_buff, cb),
>                                               sizeof_field(struct sk_buff, cb),
>                                               NULL);
>         skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
>                                                 sizeof(struct sk_buff_fclones),
>                                                 0,
> -                                               SLAB_HWCACHE_ALIGN|SLAB_PANIC,
> +                                               SLAB_HWCACHE_ALIGN|SLAB_PANIC|
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
