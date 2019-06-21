Return-Path: <SRS0=QDjJ=UU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CB7C43613
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 01:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2733320652
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 01:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UgJtjkuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfFUBhe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:37:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43804 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFUBhd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Jun 2019 21:37:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so2504078pgv.10
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2019 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+BBLwZtK559RusCbv05GmPVwa01R9tY1N/TrVS8kF/s=;
        b=UgJtjkuAPfCnrYv5/+nT3DgmraBLhmyJlPrB/1R/HP+7xj5HMoOxBowzAxJKYuhXal
         TUXR4AliTFs+xAYskx4xEjwkCvPnV5s/p3VitrZPdgdQ+pzqZ4eC+e5HFC1HQ72WpDov
         PdJmAQwmEYv2XrO5loF/BkZSQVzjTeTg7Sv8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+BBLwZtK559RusCbv05GmPVwa01R9tY1N/TrVS8kF/s=;
        b=Ak7N9PCTL6Vk9mM+TQ4BayTkna9Ai5jQ/vmWXKXPAyWaVnAinZ6ZJ4lB53H96NGdKZ
         cIiSRVfZ4673XvaTg3GieMq6moThrSS/a1ZsmPiuZOnd32aWRLXzSieX8fDsvUaB+704
         5wN1LTMER4lWKMoEST7kGH0zX3hr/0MdqDh5YjKUEwg0D7L5ASQ4azByJojIaNtAPlWV
         sMH4sjUKXOtrzlY9ayr1K7MRYJNVA9MXf6GHng+Nop/jegZdMmWNUES3Mp4umZ+AZmJi
         wG7zzN2GXiPteXUxVgrfEtwPH7Ea394qxD/c1FRmK7WSyIr9qqVvQQo7eMpVZqn7ZEJO
         ep6Q==
X-Gm-Message-State: APjAAAXYy5chqdIGOYUTk+okfEA3KEKl2/1mr+noq2taVQkFdkyjzgfg
        EKsJOfSEDLxjoEvBPBwGSdN2AD+qfJE=
X-Google-Smtp-Source: APXvYqz96MlZh/gHUsZQiQrw95Tphw+Mau0IgtUkGB4/+lWwwoAdzVWZRWZFmnOth83mrBsvYd712g==
X-Received: by 2002:a63:60d:: with SMTP id 13mr10624086pgg.272.1561081052880;
        Thu, 20 Jun 2019 18:37:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14sm821876pjp.29.2019.06.20.18.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 18:37:31 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:37:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
Subject: Re: [PATCH v6 1/3] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201906201821.8887E75@keescook>
References: <20190606164845.179427-1-glider@google.com>
 <20190606164845.179427-2-glider@google.com>
 <201906070841.4680E54@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906070841.4680E54@keescook>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 07, 2019 at 08:42:27AM -0700, Kees Cook wrote:
> On Thu, Jun 06, 2019 at 06:48:43PM +0200, Alexander Potapenko wrote:
> > [...]
> > diff --git a/mm/slub.c b/mm/slub.c
> > index cd04dbd2b5d0..9c4a8b9a955c 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > [...]
> > @@ -2741,8 +2758,14 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
> >  		prefetch_freepointer(s, next_object);
> >  		stat(s, ALLOC_FASTPATH);
> >  	}
> > +	/*
> > +	 * If the object has been wiped upon free, make sure it's fully
> > +	 * initialized by zeroing out freelist pointer.
> > +	 */
> > +	if (unlikely(slab_want_init_on_free(s)) && object)
> > +		*(void **)object = NULL;

In looking at metadata again, I noticed that I don't think this is
correct, as it needs to be using s->offset to find the location of the
freelist pointer:

	memset(object + s->offset, 0, sizeof(void *));

> >  
> > -	if (unlikely(gfpflags & __GFP_ZERO) && object)
> > +	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
> >  		memset(object, 0, s->object_size);

init_on_alloc is using "object_size" but init_on_free is using "size". I
assume the "alloc" wipe is smaller because metadata was just written
for the allocation?

-- 
Kees Cook
