Return-Path: <SRS0=RbId=RL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3E7C43381
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5032A2087C
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 13:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Visi6nGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCHN35 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:29:57 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42087 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHN34 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Mar 2019 08:29:56 -0500
Received: by mail-vk1-f195.google.com with SMTP id j195so4550496vkj.9
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2019 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fojwiTgRNq4YW5dXSNW2ki8ONGhc3IYERBDBDordqMY=;
        b=Visi6nGJpqPqz7+I6F+ie5H2UL4IO9hL1sfLCAG1i7jTSzIhaNDFGe6ESgkRcwnKNG
         XQ9gsmF40Vb5pspngPsbCe+Lq1VfpVhQntnS1EksnRjurJlB2J0iY43gv0petB3EcFXo
         x04JJzzP8B6WZi0MU2+ZNtjcULgJ+PX7a6ui3cngZ3eRrOkzexuIGBKjz6YzKEMgYN95
         XOKbFJAn8b7hN4cfo7cz2FmIrVtLaM8tZ444vR93P39VTVmZqwBMz2ps1OYstBuPQAIc
         hezmt2rbQwjRzp+CJCkSgkMWPW0phHcEuy5UPn8zhOJCgyhPuc0/gJJkxbDkDSehLA8z
         YinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fojwiTgRNq4YW5dXSNW2ki8ONGhc3IYERBDBDordqMY=;
        b=Fd99ehjUyZJi2hDo51v8dtlsPmiT7vFeyk1ntdKcPXFqLyQoIcAU6BlqXkQygn7zaK
         TjIyBGyFTMrV0TgZ1+n2FSMoBqgD1DfU/N0ky17+rb4ehU5jJZMYOYnlokXvgJ7D8xrH
         12Y7Ina4cn17IBlwO1gUA0u/AezEuOgL1M2sMTaynNvJTXWoT9hJ9IeMyDgXrSlLRh8o
         RhzHcNYYWUBTly8Hc0NLOYCaYwM5azEsoS2QckyiaNJVvzLEWF0mX3Czu9Fb2brpKznD
         wuprIEAA1pPjnUSa6/YrDM959MlSacqYKHWAhuHQfCx30SuRtnWNBhtvuNvYJFNkvkdb
         jzsg==
X-Gm-Message-State: APjAAAW3g45i6TeY6Nj6R8b92DUT0RZK9dZOJaJKW7i14hcGBfzRoXBL
        RwVZlUFZ+D08OBs8y1gZYqm76LJvv+F0L2q/W6AJlg==
X-Google-Smtp-Source: APXvYqzFDD542XJ9Jk3ZkeA5atK9xWQndSLAVvMM1J3Z8GR3P/LX3QEA4SxzzN5zV91OzMPn1LMN43v6IbtmXL3bBv4=
X-Received: by 2002:a1f:de82:: with SMTP id v124mr9056124vkg.26.1552051794716;
 Fri, 08 Mar 2019 05:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20190307133514.44378-1-glider@google.com> <20190307133514.44378-2-glider@google.com>
 <CAKwvOdnRNyANL4T3CZxWiE_s+mKTYBBXbczeei8Ne6Sy7jb+og@mail.gmail.com>
In-Reply-To: <CAKwvOdnRNyANL4T3CZxWiE_s+mKTYBBXbczeei8Ne6Sy7jb+og@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Mar 2019 14:29:43 +0100
Message-ID: <CAG_fn=Xa20o7UoQkqLBM_5TMHHao05_0UzqN6MtGpmF+sp3wmg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sandeep Patil <sspatil@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 7, 2019 at 7:37 PM Nick Desaulniers <ndesaulniers@google.com> w=
rote:
>
> On Thu, Mar 7, 2019 at 5:35 AM Alexander Potapenko <glider@google.com> wr=
ote:
> >
> > This patch is a part of a bigger initiative to allow initializing
> > heap/stack memory in the Linux kernels by default.
> > The rationale behind doing so is to reduce the severity of bugs caused
> > by using uninitialized memory.
> >
> > CONFIG_INIT_ALL_MEMORY is going to be an umbrella config for options
> > that force heap and stack initialization.
> >
> > CONFIG_INIT_ALL_STACK turns on stack initialization based on the
> > -ftrivial-auto-var-init Clang flag.
> >
> > -ftrivial-auto-var-init is a Clang flag that provides trivial
> > initializers for uninitialized local variables, variable fields and
> > padding.
> >
> > It has three possible values:
> >   pattern - uninitialized locals are filled with a fixed pattern
> >     (mostly 0xAA on 64-bit platforms, see https://reviews.llvm.org/D546=
04
>
> Hopefully the disagreements there about "defining a new dialect of
> C++" don't apply to us in the kernel.  We'd like to have this feature;
> our dialect of C is already quite far from what ISO has specified,
> both through the explicit use of `-f` compiler flags and use of most
> GNU C extensions.  We already have our own dialect of C for the
> kernel, it's too late for that.  But maybe I should go bikeshed in
> cfe-dev...
>
> Thanks for this patch.  I'll take a closer look once Kees' feedback
> has been addressed.
I've sent out the updated version.
> >     for more details) likely to cause crashes when uninitialized value =
is
> >     used;
> >   zero (it's still debated whether this flag makes it to the official
> >     Clang release) - uninitialized locals are filled with zeroes;
> >   uninitialized (default) - uninitialized locals are left intact.
> >
> > The proposed config builds the kernel with
> > -ftrivial-auto-var-init=3Dpattern.
> >
> > Developers have the possibility to opt-out of this feature on a
> > per-file (by using the INIT_ALL_MEMORY_ Makefile prefix) or per-variabl=
e
> > (by using __attribute__((uninitialized))) basis.
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
> >
> > ---
> >  Makefile                 |  3 ++-
> >  scripts/Makefile.initmem | 17 +++++++++++++++++
> >  scripts/Makefile.lib     |  6 ++++++
> >  security/Kconfig         |  1 +
> >  security/Kconfig.initmem | 22 ++++++++++++++++++++++
> >  5 files changed, 48 insertions(+), 1 deletion(-)
> >  create mode 100644 scripts/Makefile.initmem
> >  create mode 100644 security/Kconfig.initmem
> >
> > diff --git a/Makefile b/Makefile
> > index f070e0d65186..028ca37878fd 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -448,7 +448,7 @@ export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE C=
HECK CHECKFLAGS
> >
> >  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD=
_LDFLAGS
> >  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> > -export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
> > +export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN CFLAGS_INITME=
M
> >  export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
> >  export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
> >  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
> > @@ -840,6 +840,7 @@ KBUILD_ARFLAGS :=3D $(call ar-option,D)
> >  include scripts/Makefile.kasan
> >  include scripts/Makefile.extrawarn
> >  include scripts/Makefile.ubsan
> > +include scripts/Makefile.initmem
> >
> >  # Add any arch overrides and user supplied CPPFLAGS, AFLAGS and CFLAGS=
 as the
> >  # last assignments
> > diff --git a/scripts/Makefile.initmem b/scripts/Makefile.initmem
> > new file mode 100644
> > index 000000000000..f49be398f2c1
> > --- /dev/null
> > +++ b/scripts/Makefile.initmem
> > @@ -0,0 +1,17 @@
> > +ifdef CONFIG_INIT_ALL_MEMORY
> > +
> > +# Clang's -ftrivial-auto-var-init=3Dpattern flag initializes the
> > +# uninitialized parts of local variables (including fields and padding=
)
> > +# with a fixed pattern (0xAA in most cases).
> > +ifdef CONFIG_INIT_ALL_STACK
> > + CFLAGS_INITMEM :=3D -ftrivial-auto-var-init=3Dpattern
> > +endif
> > +
> > +ifeq ($(call cc-option, $(CFLAGS_INITMEM) -Werror),)
> > +   ifneq ($(CONFIG_COMPILE_TEST),y)
> > +        $(warning Cannot use CONFIG_INIT_ALL_MEMORY: \
> > +            -ftrivial-auto-var-init is not supported by compiler)
> > +   endif
> > +endif
> > +
> > +endif
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 12b88d09c3a4..53d18fd15c79 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -131,6 +131,12 @@ _c_flags +=3D $(if $(patsubst n%,, \
> >                 $(CFLAGS_UBSAN))
> >  endif
> >
> > +ifeq ($(CONFIG_INIT_ALL_MEMORY),y)
> > +_c_flags +=3D $(if $(patsubst n%,, \
> > +               $(INIT_ALL_MEMORY_$(basetarget).o)$(INIT_ALL_MEMORY)y),=
 \
> > +               $(CFLAGS_INITMEM))
> > +endif
> > +
> >  ifeq ($(CONFIG_KCOV),y)
> >  _c_flags +=3D $(if $(patsubst n%,, \
> >         $(KCOV_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)$(CONFIG_KC=
OV_INSTRUMENT_ALL)), \
> > diff --git a/security/Kconfig b/security/Kconfig
> > index e4fe2f3c2c65..cc12a39424dd 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -230,6 +230,7 @@ config STATIC_USERMODEHELPER_PATH
> >           If you wish for all usermode helper programs to be disabled,
> >           specify an empty string here (i.e. "").
> >
> > +source "security/Kconfig.initmem"
> >  source "security/selinux/Kconfig"
> >  source "security/smack/Kconfig"
> >  source "security/tomoyo/Kconfig"
> > diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
> > new file mode 100644
> > index 000000000000..5ac3cf3e7f88
> > --- /dev/null
> > +++ b/security/Kconfig.initmem
> > @@ -0,0 +1,22 @@
> > +menu "Initialize all memory"
> > +
> > +config INIT_ALL_MEMORY
> > +       bool "Initialize all memory"
> > +       default n
> > +       help
> > +         Enforce memory initialization to mitigate infoleaks and make
> > +         the control-flow bugs depending on uninitialized values more
> > +         deterministic.
> > +
> > +if INIT_ALL_MEMORY
> > +
> > +config INIT_ALL_STACK
> > +       bool "Initialize all stack"
> > +       depends on INIT_ALL_MEMORY
> > +       default y
> > +       help
> > +         Initialize uninitialized stack data with a 0xAA pattern.
> > +         This config option only supports Clang builds at the moment.
> > +
> > +endif # INIT_ALL_MEMORY
> > +endmenu
> > --
> > 2.21.0.352.gf09ad66450-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
