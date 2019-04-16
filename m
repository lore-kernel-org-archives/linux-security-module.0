Return-Path: <SRS0=WmJh=SS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9641EC10F13
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC92206B6
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9bIzPtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfDPQBx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:01:53 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37080 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbfDPQBw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Apr 2019 12:01:52 -0400
Received: by mail-vs1-f67.google.com with SMTP id w13so11856541vsc.4
        for <linux-security-module@vger.kernel.org>; Tue, 16 Apr 2019 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hDWSZCo4hVwn0SqOh/8+4ITIl6IlceobuY8Gd3+R1MM=;
        b=p9bIzPtXET3z3NKbYtfuYI/FpJ0dQe2rd3zFiSfIhvO8wFtb/pzduy0icSsdsDeim3
         XZiUih1isGFN/ytxANL7PCBufLt2s8MaFfrsOfMDULwb52QuP6jPLc3TtAuz5TYTKd7h
         vFbGjVudiJEYDtMCZcon7GBoHeRTryNZ1CTCvSEyAM/2xdm+ZjD1kc5tB3Ed45RkxeT7
         usXU4xhbqR0c9h43yBeD1bP4/jUv1e5r/BTu38LoulNEylk5TkzylLeMAGgo+BYv8q0W
         Y82yavUJH1gkP1LAB5r3qxwf9NB54Vz5M03aM3Vh/7T804FTvFSaQUD+BD3NMRSQNFqt
         sg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hDWSZCo4hVwn0SqOh/8+4ITIl6IlceobuY8Gd3+R1MM=;
        b=CO+r2oBUywZozll3U67vD1v1xED2Oqg+18wIwA5BUuwiehbQDPFmRc8u0xglcJzBBK
         3FMNskug7ij/bOapzfl36s6C6WYdlSRGKln/Mm9EIAXeljbad/Ng+MzW4CLpM2jzl3af
         hWE0woa76JerQwehgqt8QUD5rSStiP/oL8kZ2R0vxT2jLf8JEv5ay9jYuWvZhmPA/Kzs
         gAD7/tm47Uiu+vckPNuiIULWpTwf1JaPU0aS8lmvvn+DYGI9/fYc3VSFdVuIp17pIZe8
         /g/xgHdjEn97S+vyy2Wgv9jPdqvKIqjsBiaC7wBs6n9qI2r1ZmFPOGzdNLkwvRxPN0ln
         jmeA==
X-Gm-Message-State: APjAAAWk/dJmf0ZNeCb4P7UkjxvkYewGkDdltJ6drgwUmJ+422+QvTlR
        FzH0TgwZCRIFrlomuHtdGHmITzCPonsHnJcFraMa/Q==
X-Google-Smtp-Source: APXvYqxtPZ9GG8J2wfnElBD5nZyQxKYstxWVNCMBJDV4JIhuFNQQyhgaxJwl5fIqzjHj2WlsYdNxT25/g2x5M7SWwwU=
X-Received: by 2002:a67:ba03:: with SMTP id l3mr26668886vsn.96.1555430509891;
 Tue, 16 Apr 2019 09:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190412124501.132678-1-glider@google.com> <0100016a26c711be-b99971ca-49f5-482c-9028-962ee471f733-000000@email.amazonses.com>
In-Reply-To: <0100016a26c711be-b99971ca-49f5-482c-9028-962ee471f733-000000@email.amazonses.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 16 Apr 2019 18:01:38 +0200
Message-ID: <CAG_fn=U6aWfBXdkcWs0_1pqggAC16Yg8Q6rxLiVeiO83q1hOCw@mail.gmail.com>
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

On Tue, Apr 16, 2019 at 5:32 PM Christopher Lameter <cl@linux.com> wrote:
>
> On Fri, 12 Apr 2019, Alexander Potapenko wrote:
>
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 43ac818b8592..4bb10af0031b 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -167,6 +167,16 @@ static inline slab_flags_t kmem_cache_flags(unsign=
ed int object_size,
> >                             SLAB_TEMPORARY | \
> >                             SLAB_ACCOUNT)
> >
> > +/*
> > + * Do we need to initialize this allocation?
> > + * Always true for __GFP_ZERO, CONFIG_INIT_HEAP_ALL enforces initializ=
ation
> > + * of caches without constructors and RCU.
> > + */
> > +#define SLAB_WANT_INIT(cache, gfp_flags) \
> > +     ((GFP_INIT_ALWAYS_ON && !(cache)->ctor && \
> > +       !((cache)->flags & SLAB_TYPESAFE_BY_RCU)) || \
> > +      (gfp_flags & __GFP_ZERO))
>
> This is another complex thing to maintain when adding flags to the slab
> allocator.
>
> > +config INIT_HEAP_ALL
> > +     bool "Initialize kernel heap allocations"
>
> "Zero pages and objects allocated in the kernel"
>
> > +     default n
> > +     help
> > +       Enforce initialization of pages allocated from page allocator
> > +       and objects returned by kmalloc and friends.
> > +       Allocated memory is initialized with zeroes, preventing possibl=
e
> > +       information leaks and making the control-flow bugs that depend
> > +       on uninitialized values more deterministic.
>
> Hmmm... But we already have debugging options that poison objects and
> pages?
Laura Abbott mentioned in one of the previous threads
(https://marc.info/?l=3Dkernel-hardening&m=3D155474181528491&w=3D2) that:

"""
I've looked at doing something similar in the past (failing to find
the thread this morning...) and while this will work, it has pretty
serious performance issues. It's not actually the poisoning which
is expensive but that turning on debugging removes the cpu slab
which has significant performance penalties.

I'd rather go back to the proposal of just poisoning the slab
at alloc/free without using SLAB_POISON.
"""
, so slab poisoning is probably off the table.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
