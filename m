Return-Path: <SRS0=5Pje=UD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC65C282CE
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jun 2019 06:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02CC24484
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jun 2019 06:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFDGBu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:01:50 -0400
Received: from sg2plout10-01.prod.sin2.secureserver.net ([182.50.145.4]:57457
        "EHLO sg2plout10-01.prod.sin2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbfFDGBt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jun 2019 02:01:49 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181])
        by :SMTPAUTH: with ESMTPSA
        id Y2VzhXioTDXYNY2W1hhzmg; Mon, 03 Jun 2019 23:01:46 -0700
Received: by mail-qk1-f181.google.com with SMTP id r6so2097150qkc.0
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2019 23:01:45 -0700 (PDT)
X-Gm-Message-State: APjAAAVOkCPRUuBTHIsLsLPJVAl3OLDmB5uwfAukNHE5+5nnuSK5dS5l
        OR1bi8W6cd1jncHwNuztP17Db1/VjKxITEP+Pxg=
X-Google-Smtp-Source: APXvYqxT7OdBOOmJaeqjmKeYTdB5LBjyffUzRpjlvqr+jKG+mWOndHFL1cDFc4F9eHYl4Js78h2mPqyCgiG1+6Kw0k0=
X-Received: by 2002:a37:7786:: with SMTP id s128mr25455055qkc.63.1559628103055;
 Mon, 03 Jun 2019 23:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190529123812.43089-1-glider@google.com> <20190529123812.43089-3-glider@google.com>
 <20190531181832.e7c3888870ce9e50db9f69e6@linux-foundation.org>
 <CAG_fn=XBq-ipvZng3hEiGwyQH2rRNFbN_Cj0r+5VoJqou0vovA@mail.gmail.com> <201906032010.8E630B7@keescook>
In-Reply-To: <201906032010.8E630B7@keescook>
From:   Kaiwan N Billimoria <kaiwan@kaiwantech.com>
Date:   Tue, 4 Jun 2019 11:31:26 +0530
X-Gmail-Original-Message-ID: <CAPDLWs-JqUx+_sDtsER=keDu9o2NKYQ3mvZVXLY8deXOMZoH=g@mail.gmail.com>
Message-ID: <CAPDLWs-JqUx+_sDtsER=keDu9o2NKYQ3mvZVXLY8deXOMZoH=g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm: init: report memory auto-initialization
 features at boot time
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sandeep Patil <sspatil@android.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Marco Elver <elver@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4wfJU8MxV4SNDzzTHHkzOdBDmu272o440ZI/mkvA2sJqU6MXg2Ie7mvjqfgdCWG4LNEy3d/d5uYvtbWwLj3rFj+LyreILe58c+QgusrfyhBeAQ9Pis6/Pq
 VIqO9NB2v2uhrVDkuhFE5kIwgt4nwARU3dnGMByeDBsUVvTbUyVtLCnxN7G/jJEdMiLUoHZuk8bSk7clAkGKwW+o+kWAtCIEvbg=
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 4, 2019 at 8:44 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 03, 2019 at 11:24:49AM +0200, Alexander Potapenko wrote:
> > On Sat, Jun 1, 2019 at 3:18 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 29 May 2019 14:38:11 +0200 Alexander Potapenko <glider@google.com> wrote:
> > >
> > > > Print the currently enabled stack and heap initialization modes.
> > > >
> > > > The possible options for stack are:
> > > >  - "all" for CONFIG_INIT_STACK_ALL;
> > > >  - "byref_all" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL;
> > > >  - "byref" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF;
> > > >  - "__user" for CONFIG_GCC_PLUGIN_STRUCTLEAK_USER;
> > > >  - "off" otherwise.
> > > >
> > > > Depending on the values of init_on_alloc and init_on_free boottime
> > > > options we also report "heap alloc" and "heap free" as "on"/"off".
> > >
> > > Why?
> > >
> > > Please fully describe the benefit to users so that others can judge the
> > > desirability of the patch.  And so they can review it effectively, etc.
> > I'm going to update the description with the following passage:
> >
> >     Print the currently enabled stack and heap initialization modes.
> >
> >     Stack initialization is enabled by a config flag, while heap
> >     initialization is configured at boot time with defaults being set
> >     in the config. It's more convenient for the user to have all information
> >     about these hardening measures in one place.
> >
> > Does this make sense?
> > > Always!
> > >
> > > > In the init_on_free mode initializing pages at boot time may take some
> > > > time, so print a notice about that as well.
> > >
> > > How much time?
> > I've seen pauses up to 1 second, not actually sure they're worth a
> > separate line in the log.
> > Kees, how long were the delays in your case?
>
> I didn't measure it, but I think it was something like 0.5 second per GB.
> I noticed because normally boot flashes by. With init_on_free it pauses
> for no apparent reason, which is why I suggested the note. (I mean *I*
> knew why it was pausing, but it might surprise someone who sets
> init_on_free=1 without really thinking about what's about to happen at
> boot.)

(Pardon the gmail client)
How about:
- if (want_init_on_free())
-               pr_info("Clearing system memory may take some time...\n");
+  if (want_init_on_free())
+              pr_info("meminit: clearing system memory may take some
time...\n");

or even

+ if (want_init_on_free())
+                pr_info("meminit (init_on_free == 1): clearing system
memory may take some time...\n");

or some combo thereof?

--
Kaiwan
>
> --
> Kees Cook
>
