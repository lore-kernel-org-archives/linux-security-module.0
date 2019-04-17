Return-Path: <SRS0=FWzS=ST=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9ECC282DA
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 17:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9292173C
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 17:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJV/eGTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfDQREr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:04:47 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:32914 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfDQREq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Apr 2019 13:04:46 -0400
Received: by mail-vs1-f68.google.com with SMTP id s11so3315603vsn.0
        for <linux-security-module@vger.kernel.org>; Wed, 17 Apr 2019 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZebXcbPeVNYkkX9yJaiZl3S9wzSgvNBK3FgGu78AaCE=;
        b=rJV/eGTFo1+fnGJmSyo4+xil5449L1OKBtDHkZ9nA3qiNq/Tt3wAMSZVVB2nvWiZly
         gp6+0PW2FCUXoi8rhrIoooa6Gv2tuBOp5vJ3EeO5HTRgD5zLxGJlidxN20m6vAG/WN7s
         1Jqi0odOTjHP2OvlaqMWHYrRB6shoWrFgistYzQvOgnAkd6ZgNZgzuJDRKuIT7pCmPtj
         QkNL4g+/YKQiqP/8Uqp3SswOGp2RMhvDLv84OI+RHJdYNZ9UoFZf/5JrFQ7QlXwYo9VS
         tFYKa9K/W2pUyIcO3JQeJz++dnP9W5+hKQz+vP7wwi/BIowHFzXS8ZDW8Lcwm5WzjSBT
         czSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZebXcbPeVNYkkX9yJaiZl3S9wzSgvNBK3FgGu78AaCE=;
        b=RLpgpsJycx9KBs9LrjFtRKDVkzdK0wZ4T0gOu53BsmcJA6p8QetaNIr+hJXY9woj+E
         aJ895DbrL1TQTTr8Uwa6c/43pjvkRaytGJ5h0lpuSP3bYZTuxzMFad3LIESfN4AcZdN1
         TmYEKx49hoepBSJn0NFlVKa2lEHTKxOBXTBB3K3+AAc5Rx7kni6JfVldOwf5Pg856/W7
         7dPO1wHzfEsciGB/cK8WG8p2hjYGZ3tuG4PMhgUqnOGCvRg5rXKcOrbjeVq2OyuuO+09
         o81UKUbheEFvrcQVQsPv+N3YXy/8HxpCpF8qo6kAuB0zKsw8Je2BUcCLlb7fS94pKRdE
         XpSQ==
X-Gm-Message-State: APjAAAWbY5NLqxn6WKFdARsqBgDdPfTHRYGdgl5j26ADFPSZMX20WXcT
        vOfALyF0X4+HmRQAHwF1rOyzfhASsFzrbhZ7X1ZIvA==
X-Google-Smtp-Source: APXvYqyth700R2P9Z5YeZllE6N3/x5jl7uGJWDZ5uk7e3eN4YreSXsUzJgfEggRBiI07XM09qPD6JHxtPpvj0M/RPNs=
X-Received: by 2002:a67:eeda:: with SMTP id o26mr50920891vsp.209.1555520685261;
 Wed, 17 Apr 2019 10:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190412124501.132678-1-glider@google.com> <0100016a26c711be-b99971ca-49f5-482c-9028-962ee471f733-000000@email.amazonses.com>
 <CAG_fn=U6aWfBXdkcWs0_1pqggAC16Yg8Q6rxLiVeiO83q1hOCw@mail.gmail.com>
 <0100016a26fc7605-a9c76ac4-387c-47a3-8c53-a8d208eb0925-000000@email.amazonses.com>
 <CAG_fn=XW=-=SiAjToBNGDBdr1iZFA-9Ri_a4tF40448yPTbU4w@mail.gmail.com>
In-Reply-To: <CAG_fn=XW=-=SiAjToBNGDBdr1iZFA-9Ri_a4tF40448yPTbU4w@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 17 Apr 2019 19:04:33 +0200
Message-ID: <CAG_fn=UMww4b8+NuBZ82pq4DS19tQx=h_3E6C2s3fkLLGD7fMg@mail.gmail.com>
Subject: Re: [PATCH] mm: security: introduce CONFIG_INIT_HEAP_ALL
To:     Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 17, 2019 at 1:03 PM Alexander Potapenko <glider@google.com> wro=
te:
>
> On Tue, Apr 16, 2019 at 6:30 PM Christopher Lameter <cl@linux.com> wrote:
> >
> > On Tue, 16 Apr 2019, Alexander Potapenko wrote:
> >
> > > > Hmmm... But we already have debugging options that poison objects a=
nd
> > > > pages?
> > > Laura Abbott mentioned in one of the previous threads
> > > (https://marc.info/?l=3Dkernel-hardening&m=3D155474181528491&w=3D2) t=
hat:
> > >
> > > """
> > > I've looked at doing something similar in the past (failing to find
> > > the thread this morning...) and while this will work, it has pretty
> > > serious performance issues. It's not actually the poisoning which
> > > is expensive but that turning on debugging removes the cpu slab
> > > which has significant performance penalties.
> >
> > Ok you could rework that logic to be able to keep the per cpu slabs?
> I'll look into that. There's a lot going on with checking those
> poisoned bytes, although we don't need that for hardening.
>
> What do you think about the proposed approach to page initialization?
> We could separate that part from slab poisoning.
>
> > Also if you do the zeroing then you need to do it in the hotpath. And t=
his
> > patch introduces new instructions to that hotpath for checking and
> > executing the zeroing.
> Right now the patch doesn't slow down the default case when
> CONFIG_INIT_HEAP_ALL=3Dn, as GFP_INIT_ALWAYS_ON is 0.
> In the case heap initialization is enabled we could probably omit the
> gfp_flags check, as it'll be always zero in the case there's a
> constructor or RCU flag is set.
> So we'll have two branches instead of one in the case CONFIG_INIT_HEAP_AL=
L=3Dy.
>
Ok, I think we could do the same without extra branches.
Right now I'm working on a patch that uses static branches in the
function that checks GFP flags:

static inline bool want_init_memory(gfp_t flags)
{
        if (static_branch_unlikely(&init_allocations))
                return true;
        return flags & __GFP_ZERO;
}

and does the following in slab_alloc_node():

        if (unlikely(want_init_memory(gfpflags)) && object)
                s->poison_fn(s, object);
, where s->poison_fn is either memset(object, 0, s->object_size) for
normal SLAB caches or a no-op for SLAB caches that have ctors
(I _think_ I don't have to special-case SLAB_TYPESAFE_BY_RCU).

With init_allocations disabled this doesn't affect the kernel
performance (hackbench shows negative slowdown within the standard
deviation). Most certainly the indirect call is performed not too
often.
With init_allocations enabled this yields ~7% slowdown on hackbench. I
believe most of that is caused by double initialization, which we can
eliminate by passing an extra GFP flag to the page allocator.

>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
