Return-Path: <SRS0=jdUL=TV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A6AC04AAF
	for <linux-security-module@archiver.kernel.org>; Tue, 21 May 2019 14:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BC42173C
	for <linux-security-module@archiver.kernel.org>; Tue, 21 May 2019 14:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTJztX72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfEUOSu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 May 2019 10:18:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43560 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfEUOSu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 May 2019 10:18:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id d128so11223797vsc.10
        for <linux-security-module@vger.kernel.org>; Tue, 21 May 2019 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qtX9Hg9OdKmNACjDNc2C4CJaIyLblfI3YJJML4Ge4iM=;
        b=NTJztX72UA9iNvFngsBwxBL+hTK1rrcc6O8IJk9ixFH6J0FNp+KDxT2l5NAaWCrUYD
         LvZeaWVrXsPRyJNTE85kXQuuwnnSpoMidAeqsK1cy/eapyZIpM2Q6lWpgQB6gWR9T7TY
         d/tg1j2PhleWIfSNzUEqq0OKSSZ7niWgXj2xrErR4yEu52O7uBJMZ12GX+PZ27NGJm0w
         8puc+SYingWJmZFwyKXeF8B1nyUvy6aQ+1j3X6Dz+MeeTw9epsRiWJ1zDDd02Ovj1Rqt
         oLGs11YfWQOi2X7+m43sXBbI6GNJJDJsq/dvx1E3ZwyRK+72xuKM8wLHYmkt2u6eeV2H
         g5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qtX9Hg9OdKmNACjDNc2C4CJaIyLblfI3YJJML4Ge4iM=;
        b=Oigtff3ucNueQqCOTQF9fksBwubGsw8lSmF12O+iX/hN1bx8KA01kkMUdvwzAsYa1q
         ijAYBFAKG1hq+gB+R9vdYPanD6yjnzzyvyF1BbqqA9mqFMKOC/U5I1piEirE5LRyn29i
         Wy6VOBspLp688DG4u6SOUwrs3141SRyZxadKqMkZKXWUN4CgrihRglasDHVLOVgNeLHE
         lCp7uynq0hm3YOq8BgBx52SSh6I20l0VAqMJ+a0YXy/8uK3+kM1NTgVPpMChUnM+BC6l
         TRv8Uvtt0aiFYu30m9h/Fp8SxwmC3k/AVJYWUwAw3E0IGBMrxlIHQVCngwMPdy0o2Szz
         LZwA==
X-Gm-Message-State: APjAAAVG/yvxb/uuJXq28NtX2D4tkcd/7BSVkhy6zHFmoyeZ9e5DHrZ4
        HRyZoTc2LCQdIc1sUUdzZ27UgzEpRN275/7dcjGVwA==
X-Google-Smtp-Source: APXvYqwKOTGXRYs34MOtbc1g3kDsxubZ5iCKp4Y0aBRDYqNVHnTecFwIZa7kAkIjkyfwnIPq354glnHuQC3BMacUY0c=
X-Received: by 2002:a67:e401:: with SMTP id d1mr1438945vsf.103.1558448328921;
 Tue, 21 May 2019 07:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190514143537.10435-1-glider@google.com> <20190514143537.10435-4-glider@google.com>
 <20190517125916.GF1825@dhcp22.suse.cz> <CAG_fn=VG6vrCdpEv0g73M-Au4wW07w8g0uydEiHA96QOfcCVhA@mail.gmail.com>
 <20190517132542.GJ6836@dhcp22.suse.cz> <CAG_fn=Ve88z2ezFjV6CthufMUhJ-ePNMT2=3m6J3nHWh9iSgsg@mail.gmail.com>
 <20190517140108.GK6836@dhcp22.suse.cz> <201905170925.6FD47DDFFF@keescook> <20190517171105.GT6836@dhcp22.suse.cz>
In-Reply-To: <20190517171105.GT6836@dhcp22.suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 May 2019 16:18:37 +0200
Message-ID: <CAG_fn=W9Y7=RZREi5S8z-sAMg2GfPsWqrHo+UawXWiRbhrNd0Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gfp: mm: introduce __GFP_NO_AUTOINIT
To:     Michal Hocko <mhocko@kernel.org>, Kees Cook <keescook@chromium.org>
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
        Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 17, 2019 at 7:11 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 17-05-19 09:27:54, Kees Cook wrote:
> > On Fri, May 17, 2019 at 04:01:08PM +0200, Michal Hocko wrote:
> > > On Fri 17-05-19 15:37:14, Alexander Potapenko wrote:
> > > > > > > Freeing a memory is an opt-in feature and the slab allocator =
can already
> > > > > > > tell many (with constructor or GFP_ZERO) do not need it.
> > > > > > Sorry, I didn't understand this piece. Could you please elabora=
te?
> > > > >
> > > > > The allocator can assume that caches with a constructor will init=
ialize
> > > > > the object so additional zeroying is not needed. GFP_ZERO should =
be self
> > > > > explanatory.
> > > > Ah, I see. We already do that, see the want_init_on_alloc()
> > > > implementation here: https://patchwork.kernel.org/patch/10943087/
> > > > > > > So can we go without this gfp thing and see whether somebody =
actually
> > > > > > > finds a performance problem with the feature enabled and thin=
k about
> > > > > > > what can we do about it rather than add this maint. nightmare=
 from the
> > > > > > > very beginning?
> > > > > >
> > > > > > There were two reasons to introduce this flag initially.
> > > > > > The first was double initialization of pages allocated for SLUB=
.
> > > > >
> > > > > Could you elaborate please?
> > > > When the kernel allocates an object from SLUB, and SLUB happens to =
be
> > > > short on free pages, it requests some from the page allocator.
> > > > Those pages are initialized by the page allocator
> > >
> > > ... when the feature is enabled ...
> > >
> > > > and split into objects. Finally SLUB initializes one of the availab=
le
> > > > objects and returns it back to the kernel.
> > > > Therefore the object is initialized twice for the first time (when =
it
> > > > comes directly from the page allocator).
> > > > This cost is however amortized by SLUB reusing the object after it'=
s been freed.
> > >
> > > OK, I see what you mean now. Is there any way to special case the pag=
e
> > > allocation for this feature? E.g. your implementation tries to make t=
his
> > > zeroying special but why cannot you simply do this
> > >
> > >
> > > struct page *
> > > ____alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int pref=
erred_nid,
> > >                                                     nodemask_t *nodem=
ask)
> > > {
> > >     //current implementation
> > > }
> > >
> > > struct page *
> > > __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int prefer=
red_nid,
> > >                                                     nodemask_t *nodem=
ask)
> > > {
> > >     if (your_feature_enabled)
> > >             gfp_mask |=3D __GFP_ZERO;
> > >     return ____alloc_pages_nodemask(gfp_mask, order, preferred_nid,
> > >                                     nodemask);
> > > }
> > >
> > > and use ____alloc_pages_nodemask from the slab or other internal
> > > allocators?
Given that calling alloc_pages() with __GFP_NO_AUTOINIT doesn't
visibly improve the chosen benchmarks,
and the next patch in the series ("net: apply __GFP_NO_AUTOINIT to
AF_UNIX sk_buff allocations") only improves hackbench,
shall we maybe drop both patches altogether?
> > If an additional allocator function is preferred over a new GFP flag, t=
hen
> > I don't see any reason not to do this. (Though adding more "__"s seems
> > a bit unfriendly to code-documentation.) What might be better naming?
>
> The naminig is the last thing I would be worried about. Let's focus on
> the most simplistic implementation first. And means, can we really make
> it as simple as above? At least on the page allocator level.
>
> > This would mean that the skb changes later in the series would use the
> > "no auto init" version of the allocator too, then.
>
> No, this would be an internal function to MM. I would really like to
> optimize once there are numbers from _real_ workloads to base those
> optimizations.
> --
> Michal Hocko
> SUSE Labs



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
