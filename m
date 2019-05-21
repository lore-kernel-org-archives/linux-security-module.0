Return-Path: <SRS0=jdUL=TV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B96C04AAF
	for <linux-security-module@archiver.kernel.org>; Tue, 21 May 2019 14:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6710D21773
	for <linux-security-module@archiver.kernel.org>; Tue, 21 May 2019 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558448746;
	bh=sT+ird8U2IVxZAdPDlPBppZmecuzFmpVzfknLrIu0CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NYCu7a6E26w3Y0qjvKGk6VCGi26VkyadfggIj6WZO++jI7LO6bknq8exs5dNaMLSf
	 DMfibySWITMab0PS6tbG1dgggRF/hdJWwv0S/J6Wresdpz6u6YPECN7ibj8l6iq/oP
	 dvr8lDACyb5pLEEUo2vyUBaF29f5ASPL4s6UUyF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfEUOZp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 May 2019 10:25:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727812AbfEUOZp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 May 2019 10:25:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E995AE91;
        Tue, 21 May 2019 14:25:43 +0000 (UTC)
Date:   Tue, 21 May 2019 16:25:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] gfp: mm: introduce __GFP_NO_AUTOINIT
Message-ID: <20190521142541.GW32329@dhcp22.suse.cz>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-4-glider@google.com>
 <20190517125916.GF1825@dhcp22.suse.cz>
 <CAG_fn=VG6vrCdpEv0g73M-Au4wW07w8g0uydEiHA96QOfcCVhA@mail.gmail.com>
 <20190517132542.GJ6836@dhcp22.suse.cz>
 <CAG_fn=Ve88z2ezFjV6CthufMUhJ-ePNMT2=3m6J3nHWh9iSgsg@mail.gmail.com>
 <20190517140108.GK6836@dhcp22.suse.cz>
 <201905170925.6FD47DDFFF@keescook>
 <20190517171105.GT6836@dhcp22.suse.cz>
 <CAG_fn=W9Y7=RZREi5S8z-sAMg2GfPsWqrHo+UawXWiRbhrNd0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=W9Y7=RZREi5S8z-sAMg2GfPsWqrHo+UawXWiRbhrNd0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue 21-05-19 16:18:37, Alexander Potapenko wrote:
> On Fri, May 17, 2019 at 7:11 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 17-05-19 09:27:54, Kees Cook wrote:
> > > On Fri, May 17, 2019 at 04:01:08PM +0200, Michal Hocko wrote:
> > > > On Fri 17-05-19 15:37:14, Alexander Potapenko wrote:
> > > > > > > > Freeing a memory is an opt-in feature and the slab allocator can already
> > > > > > > > tell many (with constructor or GFP_ZERO) do not need it.
> > > > > > > Sorry, I didn't understand this piece. Could you please elaborate?
> > > > > >
> > > > > > The allocator can assume that caches with a constructor will initialize
> > > > > > the object so additional zeroying is not needed. GFP_ZERO should be self
> > > > > > explanatory.
> > > > > Ah, I see. We already do that, see the want_init_on_alloc()
> > > > > implementation here: https://patchwork.kernel.org/patch/10943087/
> > > > > > > > So can we go without this gfp thing and see whether somebody actually
> > > > > > > > finds a performance problem with the feature enabled and think about
> > > > > > > > what can we do about it rather than add this maint. nightmare from the
> > > > > > > > very beginning?
> > > > > > >
> > > > > > > There were two reasons to introduce this flag initially.
> > > > > > > The first was double initialization of pages allocated for SLUB.
> > > > > >
> > > > > > Could you elaborate please?
> > > > > When the kernel allocates an object from SLUB, and SLUB happens to be
> > > > > short on free pages, it requests some from the page allocator.
> > > > > Those pages are initialized by the page allocator
> > > >
> > > > ... when the feature is enabled ...
> > > >
> > > > > and split into objects. Finally SLUB initializes one of the available
> > > > > objects and returns it back to the kernel.
> > > > > Therefore the object is initialized twice for the first time (when it
> > > > > comes directly from the page allocator).
> > > > > This cost is however amortized by SLUB reusing the object after it's been freed.
> > > >
> > > > OK, I see what you mean now. Is there any way to special case the page
> > > > allocation for this feature? E.g. your implementation tries to make this
> > > > zeroying special but why cannot you simply do this
> > > >
> > > >
> > > > struct page *
> > > > ____alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> > > >                                                     nodemask_t *nodemask)
> > > > {
> > > >     //current implementation
> > > > }
> > > >
> > > > struct page *
> > > > __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> > > >                                                     nodemask_t *nodemask)
> > > > {
> > > >     if (your_feature_enabled)
> > > >             gfp_mask |= __GFP_ZERO;
> > > >     return ____alloc_pages_nodemask(gfp_mask, order, preferred_nid,
> > > >                                     nodemask);
> > > > }
> > > >
> > > > and use ____alloc_pages_nodemask from the slab or other internal
> > > > allocators?
> Given that calling alloc_pages() with __GFP_NO_AUTOINIT doesn't
> visibly improve the chosen benchmarks,
> and the next patch in the series ("net: apply __GFP_NO_AUTOINIT to
> AF_UNIX sk_buff allocations") only improves hackbench,
> shall we maybe drop both patches altogether?

Ohh, by all means. I was suggesting the same few emails ago. The above
is just a hint on how to implement the feature on the page allocator
level rather than hooking into the prep_new_page and add another branch
to zero memory.
-- 
Michal Hocko
SUSE Labs
