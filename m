Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCCEC433FE
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 23:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEBE61178
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Sep 2021 23:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhIUXvw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhIUXvu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Sep 2021 19:51:50 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C2C061574;
        Tue, 21 Sep 2021 16:50:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c7so3609253qka.2;
        Tue, 21 Sep 2021 16:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3pBdD6hrMTmywMpC16GHqHBzp8LFNfLUt8n19YiipuE=;
        b=j98HoVhGODFy30aSZxYuX/CaYVRRgrLXGPZZcL3+5TEMk0kxZ9rEUZ5VzStdEt0IGw
         3GdBetANKHrXw0Bg13KgU9vZfOKAKCK8ysvqoLeq2CE8u8xSqc/YIrNHWmSlqDbYFesa
         fd4+CZ0W6h3HDeC+g6xK4UlALy3rQ5FspPWvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pBdD6hrMTmywMpC16GHqHBzp8LFNfLUt8n19YiipuE=;
        b=vslkV3CsHe4z0JIxkIbXwCPK09gGvwaUmWUbLqAR73qmBtYd6UusMWoGwbBy5UvdEG
         au1VHoSleK34TopmxsEv/Y761l7pMnhgYDIIqYhMrvAcKNjMuSUhXkbEvqRZQlCdtrgq
         ntgut/BpmamBy1dkP1Sz9AFpCZ7XvHexF1Wc5lGUn7Uzhd1gVPtnR8X+TH4YgDUqE4kY
         oeR/UKPtRVDEfQPJMRPldwGf3g8kwQS7eoTstMBkvddieIo6mEluzuVEv5tn3VBclu7F
         XVn+GoNDJYqbhCzeTas3LQEBX5VpJi9iLq7tYOrUSGVeCmqSp0WRvjNvNXWtEDFYDXwE
         HN6Q==
X-Gm-Message-State: AOAM532Y+4IqssVI40nYb9579QkNcomVs2ojo8fWlkE+D/slYCI3NWwP
        AmQha6KXXjiUKxoQ1K2KtWGKtUbXrkMg1b3h6CE=
X-Google-Smtp-Source: ABdhPJzmNaG8eSfVVVJ//FXKvDj4/vyLvQR0ArS164V3qTiwONEwO8r07klh3oIBYs3tiqkXwlfH9eLZGel8VCFwWKo=
X-Received: by 2002:a37:6596:: with SMTP id z144mr18531657qkb.292.1632268220710;
 Tue, 21 Sep 2021 16:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210921061149.1091163-1-steve@sk2.org>
In-Reply-To: <20210921061149.1091163-1-steve@sk2.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 21 Sep 2021 23:50:08 +0000
Message-ID: <CACPK8XeH55MGGPHEXXq1jmeQHQYuOfEuDYTbQiG6SWhwgLd7Sw@mail.gmail.com>
Subject: Re: [PATCH] mm: Remove HARDENED_USERCOPY_FALLBACK
To:     Stephen Kitt <steve@sk2.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 21 Sept 2021 at 09:50, Stephen Kitt <steve@sk2.org> wrote:
>
> This has served its purpose and is no longer used. All usercopy
> violations appear to have been handled by now, any remaining
> instances (or new bugs) will cause copies to be rejected.
>
> This isn't a direct revert of commit 2d891fbc3bb6 ("usercopy: Allow
> strict enforcement of whitelists"); since usercopy_fallback is
> effectively 0, the fallback handling is removed too.
>
> This also removes the usercopy_fallback module parameter on
> slab_common.
>
> Link: https://github.com/KSPP/linux/issues/153
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Suggested-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/powerpc/configs/skiroot_defconfig |  1 -

For the defconfig change:

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

>  include/linux/slab.h                   |  2 --
>  mm/slab.c                              | 13 -------------
>  mm/slab_common.c                       |  8 --------
>  mm/slub.c                              | 14 --------------
>  security/Kconfig                       | 14 --------------
>  6 files changed, 52 deletions(-)
>
> diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
> index b806a5d3a695..c3ba614c973d 100644
> --- a/arch/powerpc/configs/skiroot_defconfig
> +++ b/arch/powerpc/configs/skiroot_defconfig
> @@ -275,7 +275,6 @@ CONFIG_NLS_UTF8=y
>  CONFIG_ENCRYPTED_KEYS=y
>  CONFIG_SECURITY=y
>  CONFIG_HARDENED_USERCOPY=y
> -# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
>  CONFIG_HARDENED_USERCOPY_PAGESPAN=y
>  CONFIG_FORTIFY_SOURCE=y
>  CONFIG_SECURITY_LOCKDOWN_LSM=y
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0c97d788762c..5b21515afae0 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -142,8 +142,6 @@ struct mem_cgroup;
>  void __init kmem_cache_init(void);
>  bool slab_is_available(void);
>
> -extern bool usercopy_fallback;
> -
>  struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
>                         unsigned int align, slab_flags_t flags,
>                         void (*ctor)(void *));
> diff --git a/mm/slab.c b/mm/slab.c
> index d0f725637663..4d826394ffcb 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -4207,19 +4207,6 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
>             n <= cachep->useroffset - offset + cachep->usersize)
>                 return;
>
> -       /*
> -        * If the copy is still within the allocated object, produce
> -        * a warning instead of rejecting the copy. This is intended
> -        * to be a temporary method to find any missing usercopy
> -        * whitelists.
> -        */
> -       if (usercopy_fallback &&
> -           offset <= cachep->object_size &&
> -           n <= cachep->object_size - offset) {
> -               usercopy_warn("SLAB object", cachep->name, to_user, offset, n);
> -               return;
> -       }
> -
>         usercopy_abort("SLAB object", cachep->name, to_user, offset, n);
>  }
>  #endif /* CONFIG_HARDENED_USERCOPY */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a4a571428c51..925b00c1d4e8 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -37,14 +37,6 @@ LIST_HEAD(slab_caches);
>  DEFINE_MUTEX(slab_mutex);
>  struct kmem_cache *kmem_cache;
>
> -#ifdef CONFIG_HARDENED_USERCOPY
> -bool usercopy_fallback __ro_after_init =
> -               IS_ENABLED(CONFIG_HARDENED_USERCOPY_FALLBACK);
> -module_param(usercopy_fallback, bool, 0400);
> -MODULE_PARM_DESC(usercopy_fallback,
> -               "WARN instead of reject usercopy whitelist violations");
> -#endif
> -
>  static LIST_HEAD(slab_caches_to_rcu_destroy);
>  static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work);
>  static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
> diff --git a/mm/slub.c b/mm/slub.c
> index 3f96e099817a..77f53e76a3c3 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4125,7 +4125,6 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
>  {
>         struct kmem_cache *s;
>         unsigned int offset;
> -       size_t object_size;
>         bool is_kfence = is_kfence_address(ptr);
>
>         ptr = kasan_reset_tag(ptr);
> @@ -4158,19 +4157,6 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
>             n <= s->useroffset - offset + s->usersize)
>                 return;
>
> -       /*
> -        * If the copy is still within the allocated object, produce
> -        * a warning instead of rejecting the copy. This is intended
> -        * to be a temporary method to find any missing usercopy
> -        * whitelists.
> -        */
> -       object_size = slab_ksize(s);
> -       if (usercopy_fallback &&
> -           offset <= object_size && n <= object_size - offset) {
> -               usercopy_warn("SLUB object", s->name, to_user, offset, n);
> -               return;
> -       }
> -
>         usercopy_abort("SLUB object", s->name, to_user, offset, n);
>  }
>  #endif /* CONFIG_HARDENED_USERCOPY */
> diff --git a/security/Kconfig b/security/Kconfig
> index 0ced7fd33e4d..d9698900c9b7 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -163,20 +163,6 @@ config HARDENED_USERCOPY
>           or are part of the kernel text. This kills entire classes
>           of heap overflow exploits and similar kernel memory exposures.
>
> -config HARDENED_USERCOPY_FALLBACK
> -       bool "Allow usercopy whitelist violations to fallback to object size"
> -       depends on HARDENED_USERCOPY
> -       default y
> -       help
> -         This is a temporary option that allows missing usercopy whitelists
> -         to be discovered via a WARN() to the kernel log, instead of
> -         rejecting the copy, falling back to non-whitelisted hardened
> -         usercopy that checks the slab allocation size instead of the
> -         whitelist size. This option will be removed once it seems like
> -         all missing usercopy whitelists have been identified and fixed.
> -         Booting with "slab_common.usercopy_fallback=Y/N" can change
> -         this setting.
> -
>  config HARDENED_USERCOPY_PAGESPAN
>         bool "Refuse to copy allocations that span multiple pages"
>         depends on HARDENED_USERCOPY
>
> base-commit: 368094df48e680fa51cedb68537408cfa64b788e
> --
> 2.30.2
>
