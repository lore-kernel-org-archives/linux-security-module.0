Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6785C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 09:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A765B20830
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 09:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLqwxxFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfDIJx5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:53:57 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35030 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfDIJx5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 05:53:57 -0400
Received: by mail-vs1-f66.google.com with SMTP id d8so9417867vsp.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6XLZg7gttNTZ4EYU3buMds6paKoVzxzJh3bbXHN1+kQ=;
        b=SLqwxxFtFOJgcGhrCgNXMbT1oS+GsO0LFz1gkmlpMFpinP1vZoJth3y+vWN5CLOW4W
         OXjIL68C51A7p2ByALw0RXp3c67G+lggGyglSEFb+c5HQcO00zqU4hDyDsl4QGFEayHI
         I37xvbKOjaJIRIzSWFBCQu4fNaYAZ/LzQEw0Mf0XHzDw/EXnoGIcRgP9ilspIkwcNTsl
         xLRVDKt0Peeqv2+7jQ3xf85mdeToR5TTziXw+2eilgb9wl+nCWeNKX9j40zT+RbA082I
         kHgkPWRLhhVl43iNkN5KrREFjKYxvuiG5FJOCXUyS1TrXFjt4qe3hTb1+lAoaXAUXJsi
         683Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6XLZg7gttNTZ4EYU3buMds6paKoVzxzJh3bbXHN1+kQ=;
        b=nFAoHMEyVLbJaNQ5J3w2uEo7mgIBMlzsAvYXNboP95hyUyYLabVnAJ8FGP/ZIfrR2+
         R3SJtBHtpEuWuaZu0xeBy2dQyzxWIALaDGayo96svnpEG9s5vdl9WZUm0Edi3l2CJHIw
         Bv/SIE7iCcV8ZDpqFxOCavPkA/6hzXJo/D3yjpVDImdWAn5FutD65B3WgCbShd4xMemq
         zjJu5a45QTyIUrZ11dJko1ZnouvX70zmoeGkJUFgEBddb6NXTOrGRfVsC8eUm9DNP3DB
         EaqYYksq8Qmp1tZ31YcEmKEzZQZVj6GWutpf2vqYSnwKdK2qvH4aj43zZ/5oYwC7i9Wv
         NTPw==
X-Gm-Message-State: APjAAAXiVHpZUL/26QM2WcqLUKelVn4hKCeoM4dCO4dzYhm9D6hZ7pqC
        dV5bman9xOt9rsdf90X/IB67jTnyiyE0OLaoDfaJSw==
X-Google-Smtp-Source: APXvYqxwNgSXuxUF9nlGYaO/FN+Xq8zMWTHhqv4PSC3+oqg1Z+GL8k/ZrbgKUMVcawQguKcyxDWWOdPgQVmsvZT57fE=
X-Received: by 2002:a67:83c5:: with SMTP id f188mr18723495vsd.163.1554803635511;
 Tue, 09 Apr 2019 02:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190408170418.148554-1-glider@google.com> <20190408170418.148554-3-glider@google.com>
 <20190409093234.GB21979@lakrids.cambridge.arm.com>
In-Reply-To: <20190409093234.GB21979@lakrids.cambridge.arm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 9 Apr 2019 11:53:44 +0200
Message-ID: <CAG_fn=V3Kvr_0fnzyFuhOMEnUgW+aM792sJ0rHr7Y-Tz0Yqn-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 9, 2019 at 11:32 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Apr 08, 2019 at 07:04:18PM +0200, Alexander Potapenko wrote:
> > This config option enables CONFIG_SLUB_DEBUG and CONFIG_PAGE_POISONING
> > without the need to pass any boot parameters.
> >
> > No performance optimizations are done at the moment to reduce double
> > initialization of memory regions.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Kostya Serebryany <kcc@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Sandeep Patil <sspatil@android.com>
> > Cc: linux-security-module@vger.kernel.org
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: kernel-hardening@lists.openwall.com
> > ---
> >  v3:
> >   - addressed comments by Masahiro Yamada (Kconfig fixes)
> > ---
> >  mm/page_poison.c         |  5 +++++
> >  mm/slub.c                |  2 ++
> >  security/Kconfig.initmem | 11 +++++++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/mm/page_poison.c b/mm/page_poison.c
> > index 21d4f97cb49b..a1985f33f635 100644
> > --- a/mm/page_poison.c
> > +++ b/mm/page_poison.c
> > @@ -12,9 +12,14 @@ static bool want_page_poisoning __read_mostly;
> >
> >  static int __init early_page_poison_param(char *buf)
> >  {
> > +#ifdef CONFIG_INIT_ALL_HEAP
> > +     want_page_poisoning =3D true;
> > +     return 0;
> > +#else
> >       if (!buf)
> >               return -EINVAL;
> >       return strtobool(buf, &want_page_poisoning);
> > +#endif
> >  }
> >  early_param("page_poison", early_page_poison_param);
>
> IIUC this is only called if page_poison is passed on the command line,
> so want_page_poisoning won't be set automatically unless that's passed.
>
> Presumably you want to initialize it at definition with:
>
> static bool want_page_poisoning __read_mostly =3D IS_ENABLED(CONFIG_INIT_=
ALL_HEAP);
Yes, I've misunderstood how boot parameters work.
Thanks for the suggestions!
We'd better look into wiping allocations without POISON_SLAB though.
> with:
>
> #ifndef CONFIG_INIT_ALL_HEAP
> static int __init early_page_poison_param(char *buf)
> {
>         ...
> }
> early_param("page_poison", early_page_poison_param);
> #endif
>
> ... so that it can't be disabled?
>
> Thanks,
> Mark.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
