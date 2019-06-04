Return-Path: <SRS0=5Pje=UD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA7C282CE
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jun 2019 15:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0322075C
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Jun 2019 15:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUgOTHyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfFDPGw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:06:52 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34512 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbfFDPGw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jun 2019 11:06:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id q64so4041091vsd.1
        for <linux-security-module@vger.kernel.org>; Tue, 04 Jun 2019 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W49hJTPyGHTeCq1eaPKrKSt8wWOXsDB44kzR8MDEcNQ=;
        b=kUgOTHyiy4gjZrqjJd6XCiluIRCTk1Ty+Lu9WMWtf6nWiXvg7Gl2wZEMyDWXBXnWVJ
         EXijX6fvjXfPgxbIX1H/0d63FLBK6Vu6/jMcQwCHS+kGn255u3FNrSAkBtjdgi77VeMT
         75RbP/MxlLHCTrlWiQVVNp9bagAKrSFm14QyTkBmxXnI2D+A28XXDgdY0wIbrU2YrNPc
         yiZw0Vr2Vze2Q097L2N6agpIg2MekCTKjzfXkSGUSZsh2/k3cPgiUBIeG31VVGeUlwd/
         7qU2B0ya0GDmxgCfNNr4vaG/AE8OhAI28Zsr4UyW/dcaeJouMareTr8dWZS14jhNtuYL
         2Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W49hJTPyGHTeCq1eaPKrKSt8wWOXsDB44kzR8MDEcNQ=;
        b=QTK8w+9ZMEhvn0ZoWpUv+1tH6WtU9hvl08hyEOTQY9NH+W5BW8VDu22FAr2YnNHal5
         MisGuJ7DFCfYkp2TF2su+2Q4xhw8Po1Zk9f0AKmeCyWx4hR8mC++vEkrdXN4/DmvWTZZ
         1W/YQY+knVhgKlZXCMkA++fkRWqeqCZPDQokfeRFl0fYc3uyU39wioyjDsqFJy1tJYzB
         F5UEnibx6KlR3kPpCrL1cAe8qWJ2/1YLsQ00taT7MlHmcRalY7DrQ3G//5XGPUJz0y3E
         Nh6p0xrB9hSIs/wtV+5gys+3QkUlWU0C6aquZBI2ton+H9OudID/PpDTGZ8bAF/wCRYX
         nGMw==
X-Gm-Message-State: APjAAAXcGub0ccEramBw8YlVsIlD88xg/QPr9/ujkaLEoESquZF915Uq
        W6EjEBH2x9zMXOk5qU86qJyeCUVwhTNTQDidKmPVVw==
X-Google-Smtp-Source: APXvYqylaMBXgwiEMx6a3mBJoNMZNivsGG6/K2ImcC6RkV4tmp4KahfoqMGHmAsWa2Lj7YNjdkJ7hMGMgsAwTdzOkEI=
X-Received: by 2002:a67:1bc6:: with SMTP id b189mr267198vsb.39.1559660810775;
 Tue, 04 Jun 2019 08:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190529123812.43089-1-glider@google.com> <20190529123812.43089-3-glider@google.com>
 <20190531181832.e7c3888870ce9e50db9f69e6@linux-foundation.org>
 <CAG_fn=XBq-ipvZng3hEiGwyQH2rRNFbN_Cj0r+5VoJqou0vovA@mail.gmail.com>
 <201906032010.8E630B7@keescook> <CAPDLWs-JqUx+_sDtsER=keDu9o2NKYQ3mvZVXLY8deXOMZoH=g@mail.gmail.com>
In-Reply-To: <CAPDLWs-JqUx+_sDtsER=keDu9o2NKYQ3mvZVXLY8deXOMZoH=g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 4 Jun 2019 17:06:39 +0200
Message-ID: <CAG_fn=UxfaFVZbtnO0VefKhi3iZUYn5ybe_Nvo0rCOxxA2nn-Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm: init: report memory auto-initialization
 features at boot time
To:     Kaiwan N Billimoria <kaiwan@kaiwantech.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 4, 2019 at 8:01 AM Kaiwan N Billimoria
<kaiwan@kaiwantech.com> wrote:
>
> On Tue, Jun 4, 2019 at 8:44 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 03, 2019 at 11:24:49AM +0200, Alexander Potapenko wrote:
> > > On Sat, Jun 1, 2019 at 3:18 AM Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
> > > >
> > > > On Wed, 29 May 2019 14:38:11 +0200 Alexander Potapenko <glider@goog=
le.com> wrote:
> > > >
> > > > > Print the currently enabled stack and heap initialization modes.
> > > > >
> > > > > The possible options for stack are:
> > > > >  - "all" for CONFIG_INIT_STACK_ALL;
> > > > >  - "byref_all" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL;
> > > > >  - "byref" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF;
> > > > >  - "__user" for CONFIG_GCC_PLUGIN_STRUCTLEAK_USER;
> > > > >  - "off" otherwise.
> > > > >
> > > > > Depending on the values of init_on_alloc and init_on_free boottim=
e
> > > > > options we also report "heap alloc" and "heap free" as "on"/"off"=
.
> > > >
> > > > Why?
> > > >
> > > > Please fully describe the benefit to users so that others can judge=
 the
> > > > desirability of the patch.  And so they can review it effectively, =
etc.
> > > I'm going to update the description with the following passage:
> > >
> > >     Print the currently enabled stack and heap initialization modes.
> > >
> > >     Stack initialization is enabled by a config flag, while heap
> > >     initialization is configured at boot time with defaults being set
> > >     in the config. It's more convenient for the user to have all info=
rmation
> > >     about these hardening measures in one place.
> > >
> > > Does this make sense?
> > > > Always!
> > > >
> > > > > In the init_on_free mode initializing pages at boot time may take=
 some
> > > > > time, so print a notice about that as well.
> > > >
> > > > How much time?
> > > I've seen pauses up to 1 second, not actually sure they're worth a
> > > separate line in the log.
> > > Kees, how long were the delays in your case?
> >
> > I didn't measure it, but I think it was something like 0.5 second per G=
B.
> > I noticed because normally boot flashes by. With init_on_free it pauses
> > for no apparent reason, which is why I suggested the note. (I mean *I*
> > knew why it was pausing, but it might surprise someone who sets
> > init_on_free=3D1 without really thinking about what's about to happen a=
t
> > boot.)
>
> (Pardon the gmail client)
> How about:
> - if (want_init_on_free())
> -               pr_info("Clearing system memory may take some time...\n")=
;
> +  if (want_init_on_free())
> +              pr_info("meminit: clearing system memory may take some
> time...\n");
Yes, adding a prefix may give the users better understanding of who's
clearing the memory.
We should stick to the same prefix as before though, i.e. "mem auto-init"
>
> or even
>
> + if (want_init_on_free())
> +                pr_info("meminit (init_on_free =3D=3D 1): clearing syste=
m
> memory may take some time...\n");
>
> or some combo thereof?
>
> --
> Kaiwan
> >
> > --
> > Kees Cook
> >



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
