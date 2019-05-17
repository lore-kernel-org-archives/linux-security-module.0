Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDACC04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FB420848
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 16:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BrIhPn8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfEQQ14 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 12:27:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43520 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQQ14 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 12:27:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so3555521plp.10
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iWEen/ZJGfJ/91ljuOGunKKjV2wkX9buixAuCmp2VbQ=;
        b=BrIhPn8ivTpMxlGPBk6IKIJLDMLnaVlDNMmu/vyM0gUSzZQvMLtGhLveRkfKi2vAM6
         +YkxY+z/cz2xTsv4w3Vlqtv9pbXvDXBqlfpTdOthbYK93wuom517jGpjWySLJNPNrOSc
         h8Jjt1InPKK6ea8zEWJIYE8CvdlJcSCOeFKdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iWEen/ZJGfJ/91ljuOGunKKjV2wkX9buixAuCmp2VbQ=;
        b=eQMl/jXsP4BpkT77IYW8sezwK7t6PG3bDyZ2AFVOD9sC02o1YVNq9NPiOyVTJnAKMt
         5h2Q/ZnEbMTMJnJogktMuSBN82WKH9VG5EpbkqRGakwrBxDSdhN/RA6VjxBZ2ApOyC3y
         nXNAAr9yF5nzGIqxktePu4a7Enn43RXtedTbcyL0yJYNiQJuxMZwwzGpew3oFd8Illx9
         eDF9wcjtYh2B1ZFuRuweWs9T6fe8pea3QJ7CwZxFdioLPzjbmldaPkBUqqJT9t3i3zs/
         TTMxdBQWLVJvQ8ZEiB2+zrJL6gLMJSmQlGJ4MGiRZBzs0nKWGPn3S1N640u5RPmL0OjR
         iPHA==
X-Gm-Message-State: APjAAAUHSAal2L/1WDroVIzGRQ/U1Yk6jwumHvX/UN0GMk5qKROK8s1K
        VDeT9CMlQGoNVN02HhkcaVH5eA==
X-Google-Smtp-Source: APXvYqzdfBNgSus/Lm8itRXOgphQ1CTGG6b41OjNny+0hxO3EQG2Jz/Uzp0pZo6RricP0oBOyE23uA==
X-Received: by 2002:a17:902:7d90:: with SMTP id a16mr56467129plm.122.1558110476011;
        Fri, 17 May 2019 09:27:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i65sm12436762pgc.3.2019.05.17.09.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 09:27:55 -0700 (PDT)
Date:   Fri, 17 May 2019 09:27:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
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
Message-ID: <201905170925.6FD47DDFFF@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-4-glider@google.com>
 <20190517125916.GF1825@dhcp22.suse.cz>
 <CAG_fn=VG6vrCdpEv0g73M-Au4wW07w8g0uydEiHA96QOfcCVhA@mail.gmail.com>
 <20190517132542.GJ6836@dhcp22.suse.cz>
 <CAG_fn=Ve88z2ezFjV6CthufMUhJ-ePNMT2=3m6J3nHWh9iSgsg@mail.gmail.com>
 <20190517140108.GK6836@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517140108.GK6836@dhcp22.suse.cz>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 17, 2019 at 04:01:08PM +0200, Michal Hocko wrote:
> On Fri 17-05-19 15:37:14, Alexander Potapenko wrote:
> > > > > Freeing a memory is an opt-in feature and the slab allocator can already
> > > > > tell many (with constructor or GFP_ZERO) do not need it.
> > > > Sorry, I didn't understand this piece. Could you please elaborate?
> > >
> > > The allocator can assume that caches with a constructor will initialize
> > > the object so additional zeroying is not needed. GFP_ZERO should be self
> > > explanatory.
> > Ah, I see. We already do that, see the want_init_on_alloc()
> > implementation here: https://patchwork.kernel.org/patch/10943087/
> > > > > So can we go without this gfp thing and see whether somebody actually
> > > > > finds a performance problem with the feature enabled and think about
> > > > > what can we do about it rather than add this maint. nightmare from the
> > > > > very beginning?
> > > >
> > > > There were two reasons to introduce this flag initially.
> > > > The first was double initialization of pages allocated for SLUB.
> > >
> > > Could you elaborate please?
> > When the kernel allocates an object from SLUB, and SLUB happens to be
> > short on free pages, it requests some from the page allocator.
> > Those pages are initialized by the page allocator
> 
> ... when the feature is enabled ...
> 
> > and split into objects. Finally SLUB initializes one of the available
> > objects and returns it back to the kernel.
> > Therefore the object is initialized twice for the first time (when it
> > comes directly from the page allocator).
> > This cost is however amortized by SLUB reusing the object after it's been freed.
> 
> OK, I see what you mean now. Is there any way to special case the page
> allocation for this feature? E.g. your implementation tries to make this
> zeroying special but why cannot you simply do this
> 
> 
> struct page *
> ____alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> 							nodemask_t *nodemask)
> {
> 	//current implementation
> }
> 
> struct page *
> __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> 							nodemask_t *nodemask)
> {
> 	if (your_feature_enabled)
> 		gfp_mask |= __GFP_ZERO;
> 	return ____alloc_pages_nodemask(gfp_mask, order, preferred_nid,
> 					nodemask);
> }
> 
> and use ____alloc_pages_nodemask from the slab or other internal
> allocators?

If an additional allocator function is preferred over a new GFP flag, then
I don't see any reason not to do this. (Though adding more "__"s seems
a bit unfriendly to code-documentation.) What might be better naming?

This would mean that the skb changes later in the series would use the
"no auto init" version of the allocator too, then.

-- 
Kees Cook
