Return-Path: <SRS0=tuDa=UC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E68C04AB6
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Jun 2019 09:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296A627FE2
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Jun 2019 09:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMLIbGGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfFCJZC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:25:02 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45396 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfFCJZC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Jun 2019 05:25:02 -0400
Received: by mail-ua1-f65.google.com with SMTP id v18so214605uad.12
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2019 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w8FJ04SPncA3GGt4qcZJVbuvO4+vsSKpHoksXqQuYUI=;
        b=OMLIbGGF4iqU/3IBxXXOo51Z1Gh2iX+jT/XJanv3y/0Mlanl8zJA2fHTPptaNqwAy/
         wCPISvYJLg8glT89EOkSCGrUEwLbQNGSsPQB3xP0gjI7Qnoj9v/0iNfgM4mS6UVs1cdI
         ASiojU2tdAvCieLPAYfFUbKUwAx39XfYmeDORSJzdkuJ3vkYOm8FZf+sap+UctIi5Inl
         AgNqY79mVOQvJbxNLvSndWErvOsmI5+gxjsaG/j0cl6rh4ldiKUw56A3oejSuCOFbFTv
         5Lkaj44XlpdgfkLJZbb89pa8zO7s4vqoneWdvi7fIrUzKI7kgDAV+syf1sGfWPpsVjG/
         PAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w8FJ04SPncA3GGt4qcZJVbuvO4+vsSKpHoksXqQuYUI=;
        b=NF15hZafgb4ewBOQY/3nvHOGf3W32lbYD6AtrfEJ241QJI38JBHWf6ZTflhwqP75mg
         G83usTOLmkpfugtkZxyGxr6zs3UAGmEHN+7vpDiAegCZhHjBU3wvgIijI/ziURwDxGi6
         6QZ37IFSPjlLo31hifyAtsN2E5yowbBrZ/chu6jvMB+9m1fXSob8s45W/gHDyEUGmRCu
         WDf0WbItQU/x5a/dPVOJwVHV06pXuVQ0t33a7+tAGDSSmMQvT2165vBRRsJwY4XELVHg
         qDi9wGOA0r3L3MPUpurqSZ8H+D7XTg8PgFTBnUMQVqMpMnEag5Lf5fO8ooJUpYuonjTG
         nxnQ==
X-Gm-Message-State: APjAAAUGxdLcy5i/FnkxrySx5Rix7F1ouwXxSztyzkacvBrxOK3fAgjH
        6ymMy4KQ3dCaMa4wpiKtfmIE39fSQ5fTi5zxH3pkNQ==
X-Google-Smtp-Source: APXvYqyh6QlCEo0EU+R0uj2OfHoB0V/HJYqXE1klW7h8DXFh/JtB716lws+dopD6Xp86RJPH8UG3RqT+AAiUP3DAyxA=
X-Received: by 2002:ab0:c11:: with SMTP id a17mr8422532uak.3.1559553901030;
 Mon, 03 Jun 2019 02:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190529123812.43089-1-glider@google.com> <20190529123812.43089-3-glider@google.com>
 <20190531181832.e7c3888870ce9e50db9f69e6@linux-foundation.org>
In-Reply-To: <20190531181832.e7c3888870ce9e50db9f69e6@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 3 Jun 2019 11:24:49 +0200
Message-ID: <CAG_fn=XBq-ipvZng3hEiGwyQH2rRNFbN_Cj0r+5VoJqou0vovA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm: init: report memory auto-initialization
 features at boot time
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Christoph Lameter <cl@linux.com>,
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

On Sat, Jun 1, 2019 at 3:18 AM Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>
> On Wed, 29 May 2019 14:38:11 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> > Print the currently enabled stack and heap initialization modes.
> >
> > The possible options for stack are:
> >  - "all" for CONFIG_INIT_STACK_ALL;
> >  - "byref_all" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL;
> >  - "byref" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF;
> >  - "__user" for CONFIG_GCC_PLUGIN_STRUCTLEAK_USER;
> >  - "off" otherwise.
> >
> > Depending on the values of init_on_alloc and init_on_free boottime
> > options we also report "heap alloc" and "heap free" as "on"/"off".
>
> Why?
>
> Please fully describe the benefit to users so that others can judge the
> desirability of the patch.  And so they can review it effectively, etc.
I'm going to update the description with the following passage:

    Print the currently enabled stack and heap initialization modes.

    Stack initialization is enabled by a config flag, while heap
    initialization is configured at boot time with defaults being set
    in the config. It's more convenient for the user to have all informatio=
n
    about these hardening measures in one place.

Does this make sense?
> Always!
>
> > In the init_on_free mode initializing pages at boot time may take some
> > time, so print a notice about that as well.
>
> How much time?
I've seen pauses up to 1 second, not actually sure they're worth a
separate line in the log.
Kees, how long were the delays in your case?



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
