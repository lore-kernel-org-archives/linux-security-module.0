Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B96C04AAF
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 01:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027EF2082E
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 01:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QNQxNc5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfEQB0Z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 May 2019 21:26:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45300 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfEQB0Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 May 2019 21:26:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so2764100pfm.12
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2019 18:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+cJ2gxhZLau5gmuenPlTtxJhsl5TXn8iu9yGe1AQQrg=;
        b=QNQxNc5ypRwtdFSH6HpSYR0MThc0HpZETeuvrI6NSQk2We0nlIfd3RF8xLG1Ydb5Ni
         C7l69sF2b+zwXTu+27LDKNH02FrrDRkffXWwiX6s9n+JvtV+SEbf828xWCOVEFv3hlWv
         U1gbvwBvIrttUqNQjSQ0XLYWgiKZYmbIip2B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+cJ2gxhZLau5gmuenPlTtxJhsl5TXn8iu9yGe1AQQrg=;
        b=m1sM8eOh0RWwnXOwV8jT7BX1F8y6fcM3QieR+fmJ1vIG9R7EeC6QOqhKNjn2FDeQVP
         nXZ5d8oSx6mteTE6jdrnIqMc9/UXvY4kgoODJL66rSAzQdMv4g/d4KS7nEwf6w1fgAup
         /iNXO4ATYC7IM5O1Zyo2BxU5zrEGEGECNIzIt2HnQH2Qg4IACSWUYIBUO4eVhayLVpB9
         1LmBflnQiFHnfkDQ7xJ3OEnt8rXWzu7fPcrV21o0N+11L4NZ5V0Qc8gJJJllNvRKSzqF
         v6KPOle9ctOUga1fxi37XlzHStYboUbY2mWCxiY+NnbIazk25FxxIEcDuqx+QflXsZRA
         BvFg==
X-Gm-Message-State: APjAAAW5QVcj3dsGHa7oiFL/EikmNaV9+qw2Ax9dvf8fVGhsOzh4PzdR
        vKyVnuz8grlNscmJJPNP+iLnKQ==
X-Google-Smtp-Source: APXvYqz3bg5gRNoTrwMyo5+vXZ7qa4nbJU852Lnd6zCfw82/d5ftsiATgeUm4vLixEXP76pwv/yJLQ==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr54079259pga.412.1558056384345;
        Thu, 16 May 2019 18:26:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u11sm7829530pfh.130.2019.05.16.18.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 18:26:23 -0700 (PDT)
Date:   Thu, 16 May 2019 18:26:22 -0700
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
Subject: Re: [PATCH v2 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201905161824.63B0DF0E@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514143537.10435-2-glider@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 14, 2019 at 04:35:34PM +0200, Alexander Potapenko wrote:
> [...]
> diff --git a/mm/slab.h b/mm/slab.h
> index 43ac818b8592..24ae887359b8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -524,4 +524,20 @@ static inline int cache_random_seq_create(struct kmem_cache *cachep,
> [...]
> +static inline bool slab_want_init_on_free(struct kmem_cache *c)
> +{
> +	if (static_branch_unlikely(&init_on_free))
> +		return !(c->ctor);

BTW, why is this checking for c->ctor here? Shouldn't it not matter for
the free case?

> +	else
> +		return false;
> +}

-- 
Kees Cook
