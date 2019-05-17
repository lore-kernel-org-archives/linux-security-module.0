Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2454C04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 17:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ABE20848
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558113078;
	bh=7UZuJXocK6xbm1x1t2BXecJQo5/K2Y27siX9jHLU0lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rQfH7BTZW2HQNc2beniUIvYKaK7wdW4+hqmoPvsE71oAtb9fBARquuBg/U3Q4x79I
	 vrAi7OwFp4wQYOJAWLOh1jNYEOlilWpWEk2ovYwNSg9XcRYNU9s3ChWQ/n+vINLuXa
	 vqLSdOHF5sRjEa27Tr9sHjNhZjvKc72hiZM4E93k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfEQRLS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 13:11:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfEQRLS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 13:11:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29A57AEB0;
        Fri, 17 May 2019 17:11:16 +0000 (UTC)
Date:   Fri, 17 May 2019 19:11:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kees Cook <keescook@chromium.org>
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
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <20190517170805.GS6836@dhcp22.suse.cz>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-2-glider@google.com>
 <20190517140446.GA8846@dhcp22.suse.cz>
 <CAG_fn=W4k=mijnUpF98Hu6P8bFMHU81FHs4Swm+xv1k0wOGFFQ@mail.gmail.com>
 <20190517142048.GM6836@dhcp22.suse.cz>
 <201905170928.A8F3BEC1B1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905170928.A8F3BEC1B1@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri 17-05-19 09:36:36, Kees Cook wrote:
> On Fri, May 17, 2019 at 04:20:48PM +0200, Michal Hocko wrote:
> > On Fri 17-05-19 16:11:32, Alexander Potapenko wrote:
> > > On Fri, May 17, 2019 at 4:04 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Tue 14-05-19 16:35:34, Alexander Potapenko wrote:
> > > > > The new options are needed to prevent possible information leaks and
> > > > > make control-flow bugs that depend on uninitialized values more
> > > > > deterministic.
> > > > >
> > > > > init_on_alloc=1 makes the kernel initialize newly allocated pages and heap
> > > > > objects with zeroes. Initialization is done at allocation time at the
> > > > > places where checks for __GFP_ZERO are performed.
> > > > >
> > > > > init_on_free=1 makes the kernel initialize freed pages and heap objects
> > > > > with zeroes upon their deletion. This helps to ensure sensitive data
> > > > > doesn't leak via use-after-free accesses.
> > > >
> > > > Why do we need both? The later is more robust because even free memory
> > > > cannot be sniffed and the overhead might be shifted from the allocation
> > > > context (e.g. to RCU) but why cannot we stick to a single model?
> > > init_on_free appears to be slower because of cache effects. It's
> > > several % in the best case vs. <1% for init_on_alloc.
> > 
> > This doesn't really explain why we need both.
> 
> There are a couple reasons. The first is that once we have hardware with
> memory tagging (e.g. arm64's MTE) we'll need both on_alloc and on_free
> hooks to do change the tags. With MTE, zeroing comes for "free" with
> tagging (though tagging is as slow as zeroing, so it's really the tagging
> that is free...), so we'll need to re-use the init_on_free infrastructure.

I am not sure I follow, but ...
> 
> The second reason is for very paranoid use-cases where in-memory
> data lifetime is desired to be minimized. There are various arguments
> for/against the realism of the associated threat models, but given that
> we'll need the infrastructre for MTE anyway, and there are people who
> want wipe-on-free behavior no matter what the performance cost, it seems
> reasonable to include it in this series.
> 
> All that said, init_on_alloc looks desirable enough that distros will
> likely build with it enabled by default (I hope), and the very paranoid
> users will switch to (or additionally enable) init_on_free for their
> systems.

... this should all be part of the changelog.
-- 
Michal Hocko
SUSE Labs
