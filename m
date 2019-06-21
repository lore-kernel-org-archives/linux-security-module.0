Return-Path: <SRS0=QDjJ=UU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91EFC43613
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 15:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBE1206B7
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561129935;
	bh=5E76WBrshHECwVy9GvqjQ27jrP0Wk09U77Q050DKyBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ftjk0DI49E2mD8rAj8vOtx/twGq8expqAIUfzP7LHZUBO+dnaidfESU+QyVGcUCe1
	 dgHfPGFdvqx7q3lTVItO7K3514YgdqNjknzzlfgFL0cSx52vBVR0Asngnx8rAI9y6c
	 mS6zbebWbTt2KIox0NcwoPEvg7NPv33G0my5skqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfFUPMP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:12:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:36514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfFUPMP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 11:12:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 863DAABB1;
        Fri, 21 Jun 2019 15:12:13 +0000 (UTC)
Date:   Fri, 21 Jun 2019 17:12:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
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
        Marco Elver <elver@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v7 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <20190621151210.GF3429@dhcp22.suse.cz>
References: <20190617151050.92663-1-glider@google.com>
 <20190617151050.92663-2-glider@google.com>
 <20190621070905.GA3429@dhcp22.suse.cz>
 <CAG_fn=UFj0Lzy3FgMV_JBKtxCiwE03HVxnR8=f9a7=4nrUFXSw@mail.gmail.com>
 <CAG_fn=W90HNeZ0UcUctnbUBzJ=_b+gxMGdUoDyO3JPoyy4dGSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=W90HNeZ0UcUctnbUBzJ=_b+gxMGdUoDyO3JPoyy4dGSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri 21-06-19 16:10:19, Alexander Potapenko wrote:
> On Fri, Jun 21, 2019 at 10:57 AM Alexander Potapenko <glider@google.com> wrote:
[...]
> > > > diff --git a/mm/dmapool.c b/mm/dmapool.c
> > > > index 8c94c89a6f7e..e164012d3491 100644
> > > > --- a/mm/dmapool.c
> > > > +++ b/mm/dmapool.c
> > > > @@ -378,7 +378,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
> > > >  #endif
> > > >       spin_unlock_irqrestore(&pool->lock, flags);
> > > >
> > > > -     if (mem_flags & __GFP_ZERO)
> > > > +     if (want_init_on_alloc(mem_flags))
> > > >               memset(retval, 0, pool->size);
> > > >
> > > >       return retval;
> > >
> > > Don't you miss dma_pool_free and want_init_on_free?
> > Agreed.
> > I'll fix this and add tests for DMA pools as well.
> This doesn't seem to be easy though. One needs a real DMA-capable
> device to allocate using DMA pools.
> On the other hand, what happens to a DMA pool when it's destroyed,
> isn't it wiped by pagealloc?

Yes it should be returned to the page allocator AFAIR. But it is when we
are returning an object to the pool when you want to wipe the data, no?
Why cannot you do it along the already existing poisoning?
-- 
Michal Hocko
SUSE Labs
