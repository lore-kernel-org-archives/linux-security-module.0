Return-Path: <SRS0=QDjJ=UU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A1DC43613
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 12:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C202A208C3
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 12:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="soq/7Xfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFUMgU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:36:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42453 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUMgU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 08:36:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so6657609qtk.9
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBKx8sViduB8/NHSaBz+lQt81NUha225P55KtDTPEaw=;
        b=soq/7Xfb9EAK1xkovVmvRSMrIXKPoUGsDqwj+T7RFaVnWX65AEd2mtelJQ3SQYVYnw
         JIdsZwQwk2vjzpajthJ208SBphOMwR+Zq36bLzBs1+VTD1eiXGLLK4XaoULTyLswIERp
         5wisMkOxpzzZlFkrXCbFKG0hekuHPL0EU0rSHQKCfxTnLVxBmyXhptDtSfOvo3lKgdD4
         8KM6CVLOs7VJXEgAdGkUlFFuwjPcYPYN2k2TFCJzZB0RHvAZERuda5NuwuMyD80c45EW
         Bp72Z5Eg+fI1ObG3zIIPUpy90AGu0HMzX1P89kWwZNewfMXKa+v91las0xj+Z8gNRiP4
         nhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBKx8sViduB8/NHSaBz+lQt81NUha225P55KtDTPEaw=;
        b=IpU86OxrmF9DYmNAsSANfSDE86MKMdtjwN5mOrTROKmPWhEvyQztW7eIpkClAQvgVY
         ngUQPttDiPGgXBTKuMHyyCDtLeTLXeh0Kr3X0aW1h+YxEaeLbXSkiOnSDUcEd/b5c0Zv
         IXjXuustTUJe70sjH2gbEO3ur/A4ncfzyq224foHnXzQV7nuQfCkzkuLID+k90TTUlig
         ruT0rjb6bExk5hVxNOQGCTHch7UHpMaFSDL6zAyoyccsEHhALcEEkOGHHjC6Sl8vBntW
         xyb3mbwxlsGee5p4j2uFEpQQgWedsf1ltO7KkFtNKgYqpEkllhNshzz9+mdFArwcFRDq
         dgqg==
X-Gm-Message-State: APjAAAUE26CUl6USr1kyQhZBwxyM66jGAZDulXazVBZr4Jqd20MbSre6
        WhA8tqXP89zpeMH0DJ2dso6JuA==
X-Google-Smtp-Source: APXvYqwL6+nDofOA0J5oQ5U0Uk7Iqo52p2eNAGCYHn5yYdrRC0hfgRC5/1kGnoIUgbZWmjXfIX2otg==
X-Received: by 2002:ac8:26dc:: with SMTP id 28mr113596286qtp.88.1561120578711;
        Fri, 21 Jun 2019 05:36:18 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g2sm1424436qkb.80.2019.06.21.05.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 05:36:17 -0700 (PDT)
Message-ID: <1561120576.5154.35.camel@lca.pw>
Subject: Re: [PATCH v7 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
From:   Qian Cai <cai@lca.pw>
To:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date:   Fri, 21 Jun 2019 08:36:16 -0400
In-Reply-To: <20190617151050.92663-2-glider@google.com>
References: <20190617151050.92663-1-glider@google.com>
         <20190617151050.92663-2-glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2019-06-17 at 17:10 +0200, Alexander Potapenko wrote:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d66bc8abe0af..50a3b104a491 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -136,6 +136,48 @@ unsigned long totalcma_pages __read_mostly;
>  
>  int percpu_pagelist_fraction;
>  gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
> +#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
> +DEFINE_STATIC_KEY_TRUE(init_on_alloc);
> +#else
> +DEFINE_STATIC_KEY_FALSE(init_on_alloc);
> +#endif
> +#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
> +DEFINE_STATIC_KEY_TRUE(init_on_free);
> +#else
> +DEFINE_STATIC_KEY_FALSE(init_on_free);
> +#endif
> +

There is a problem here running kernels built with clang,

[    0.000000] static_key_disable(): static key 'init_on_free+0x0/0x4' used
before call to jump_label_init()
[    0.000000] WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:314
early_init_on_free+0x1c0/0x200
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.2.0-rc5-next-20190620+
#11
[    0.000000] pstate: 60000089 (nZCv daIf -PAN -UAO)
[    0.000000] pc : early_init_on_free+0x1c0/0x200
[    0.000000] lr : early_init_on_free+0x1c0/0x200
[    0.000000] sp : ffff100012c07df0
[    0.000000] x29: ffff100012c07e20 x28: ffff1000110a01ec 
[    0.000000] x27: 0000000000000001 x26: ffff100011716f88 
[    0.000000] x25: ffff100010d367ae x24: ffff100010d367a5 
[    0.000000] x23: ffff100010d36afd x22: ffff100011716758 
[    0.000000] x21: 0000000000000000 x20: 0000000000000000 
[    0.000000] x19: 0000000000000000 x18: 000000000000002e 
[    0.000000] x17: 000000000000000f x16: 0000000000000040 
[    0.000000] x15: 0000000000000000 x14: 6d756a206f74206c 
[    0.000000] x13: 6c61632065726f66 x12: 6562206465737520 
[    0.000000] x11: 0000000000000000 x10: 0000000000000000 
[    0.000000] x9 : 0000000000000000 x8 : 0000000000000000 
[    0.000000] x7 : 73203a2928656c62 x6 : ffff1000144367ad 
[    0.000000] x5 : ffff100012c07b28 x4 : 000000000000000f 
[    0.000000] x3 : ffff1000101b36ec x2 : 0000000000000001 
[    0.000000] x1 : 0000000000000001 x0 : 000000000000005d 
[    0.000000] Call trace:
[    0.000000]  early_init_on_free+0x1c0/0x200
[    0.000000]  do_early_param+0xd0/0x104
[    0.000000]  parse_args+0x204/0x54c
[    0.000000]  parse_early_param+0x70/0x8c
[    0.000000]  setup_arch+0xa8/0x268
[    0.000000]  start_kernel+0x80/0x588
[    0.000000] random: get_random_bytes called from __warn+0x164/0x208 with
crng_init=0

> diff --git a/mm/slub.c b/mm/slub.c
> index cd04dbd2b5d0..9c4a8b9a955c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1279,6 +1279,12 @@ static int __init setup_slub_debug(char *str)
>  	if (*str == ',')
>  		slub_debug_slabs = str + 1;
>  out:
> +	if ((static_branch_unlikely(&init_on_alloc) ||
> +	     static_branch_unlikely(&init_on_free)) &&
> +	    (slub_debug & SLAB_POISON)) {
> +		pr_warn("disabling SLAB_POISON: can't be used together with
> memory auto-initialization\n");
> +		slub_debug &= ~SLAB_POISON;
> +	}
>  	return 1;
>  }

I don't think it is good idea to disable SLAB_POISON here as if people have
decided to enable SLUB_DEBUG later already, they probably care more to make sure
those additional checks with SLAB_POISON are still running to catch memory
corruption.
