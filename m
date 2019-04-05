Return-Path: <SRS0=2koH=SH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DD7C4360F
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 14:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7D92186A
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 14:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0bpZId9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfDEORs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:17:48 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38661 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfDEORs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Apr 2019 10:17:48 -0400
Received: by mail-ua1-f65.google.com with SMTP id t15so2112634uao.5
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2019 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f7ByQhEGjRcUuqbtjW5Y7vsWK9vezH8NZBudfje6K1w=;
        b=T0bpZId9rXozH7dGZltw9oTHA5d5UOoy/DJhfATeOoU1Nsm8VNNikyUYgkGsAE4sNO
         R4F+R/azTNAjA8fGxF61X+G8mHXxZ0ReaYNwO5s4Q8lKGi5Q3zjtEM5LlTBiWpEL2BxC
         6WEu3VCCPqVU8p0+18lWik67iZ3LxArOif8Ey4J03tvNZt0/38ys85MJm536lJNE7BNX
         QchA/9gqIQyJ/K9ojkQh7hM6xcBdjKpAyKWxfFAt8Y2oRgefPOduoU65Rsp5VACoufZ4
         QdPcwZ9G5ORasJzPdm9neWCkFkeagPSj+CkiV79Kp1zsnB8z3mHdSJgwgk3PnmKcPPKm
         jWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f7ByQhEGjRcUuqbtjW5Y7vsWK9vezH8NZBudfje6K1w=;
        b=AsN/NgxIxgjO67thYBhG/vpYfxqzqHvOHJUooVgdebkDVGoeJkXC+aQdh9OFfSxyC3
         mtjhIKpHTJLO8iDepUxBM+gQ01yGwdVMxkqE+RaJk6CVuthN3dkALKCqa1YfcNBRDedX
         v3VGr9op5HVj+swQtOrXsSawAPeDjk38Bk4Wz5YM+3akxfNXid+s1+Y9Geq3z1S8CWcd
         QjTxvq7nVqXnDkf5Ii8y4182vr7fsqmKHvkLJD5ZDPv3Ug5GuISiaQGPfDg1bsgTUAUS
         I0lG7i/NkyqfKQy1t2Iwak011NN/Vf6cCGJ5E3VQOkbFTlPEMnszZbsUd9oTLE8JXZtG
         9C7A==
X-Gm-Message-State: APjAAAWh6SKNSCYbL4e7LHJBRCGR9DcINlAxd4hLTAn/Ri3lz8hUY1Fk
        Jt4XDTA2LZInc6dOwra6WRSoSmLVzYn3q0E1JS+l7QwPvL6y/Q==
X-Google-Smtp-Source: APXvYqzohvrXLiB+a31X+5IQwrLjPlyod5NTBG+M/hjO7q3Sdnz7vHDIeEWK6pWmAQeESxpT6RqY9qhOtlbX3sFa18c=
X-Received: by 2002:ab0:2399:: with SMTP id b25mr7425643uan.129.1554473866856;
 Fri, 05 Apr 2019 07:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190308132701.133598-1-glider@google.com> <20190308132701.133598-2-glider@google.com>
 <CAK7LNATGJ9JZ8XxP2jQ-smDNH6igNvrSZB2TF62rykpqJBF8qg@mail.gmail.com>
In-Reply-To: <CAK7LNATGJ9JZ8XxP2jQ-smDNH6igNvrSZB2TF62rykpqJBF8qg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 5 Apr 2019 16:17:35 +0200
Message-ID: <CAG_fn=V=-iMdxH9YEVyLTr2qczCDOz37gwrVDk5POwnUOrne6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 5, 2019 at 1:19 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Mar 8, 2019 at 10:27 PM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > CONFIG_INIT_ALL_MEMORY is going to be an umbrella config for options
> > that force heap and stack initialization.
> > The rationale behind doing so is to reduce the severity of bugs caused
> > by using uninitialized memory.
> >
> > CONFIG_INIT_ALL_STACK turns on stack initialization based on
> > -ftrivial-auto-var-init in Clang builds and on
> > -fplugin-arg-structleak_plugin-byref-all in GCC builds.
> >
> > -ftrivial-auto-var-init is a Clang flag that provides trivial
> > initializers for uninitialized local variables, variable fields and
> > padding.
> >
> > It has three possible values:
> >   pattern - uninitialized locals are filled with a fixed pattern
> >     (mostly 0xAA on 64-bit platforms, see https://reviews.llvm.org/D546=
04
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
> > per-file (by using the INIT_ALL_MEMORY_ Makefile prefix)
>
> Do you have a plan to use this per-file prefix?
> If so, could you elaborate which parts should opt out?
I've added that when I started experimenting with auto-initialization,
but so far I haven't encountered a use-case for that, especially since
there's __attribute__((uninitialized)).
I'd better remove this part for now till we actually need it.
>
> > or per-variable
> > (by using __attribute__((uninitialized))) basis.
> >
> > For GCC builds, CONFIG_INIT_ALL_STACK is simply wired up to
> > CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL. No opt-out is possible at the
> > moment.
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
> >  v2:
> >   - addressed Kees Cook's comments: added GCC support
> > ---
> >  Makefile                 |  3 ++-
> >  scripts/Makefile.initmem | 10 ++++++++++
> >  scripts/Makefile.lib     |  6 ++++++
> >  security/Kconfig         |  1 +
> >  security/Kconfig.initmem | 29 +++++++++++++++++++++++++++++
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
> > index 000000000000..a6253d78fe35
> > --- /dev/null
> > +++ b/scripts/Makefile.initmem
> > @@ -0,0 +1,10 @@
> > +ifdef CONFIG_INIT_ALL_STACK
> > +
> > +# Clang's -ftrivial-auto-var-init=3Dpattern flag initializes the
> > +# uninitialized parts of local variables (including fields and padding=
)
> > +# with a fixed pattern (0xAA in most cases).
> > +ifdef CONFIG_CC_HAS_AUTO_VAR_INIT
> > +  CFLAGS_INITMEM :=3D -ftrivial-auto-var-init=3Dpattern
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
> > index 000000000000..27aec394365e
> > --- /dev/null
> > +++ b/security/Kconfig.initmem
> > @@ -0,0 +1,29 @@
> > +menu "Initialize all memory"
> > +
> > +config CC_HAS_AUTO_VAR_INIT
> > +       def_bool $(cc-option,-ftrivial-auto-var-init=3Dpattern)
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
> > +       depends on CC_HAS_AUTO_VAR_INIT || HAVE_GCC_PLUGINS
> > +       select GCC_PLUGINS if !CC_HAS_AUTO_VAR_INIT
> > +       select GCC_PLUGIN_STRUCTLEAK if !CC_HAS_AUTO_VAR_INIT
> > +       select GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if !CC_HAS_AUTO_VAR_INIT
> > +       default y
> > +       help
> > +         Initialize uninitialized stack data with a fixed pattern
> > +         (0x00 in GCC, 0xAA in Clang).
>
> Ugh, the logic is getting complicated.
Not sure what's the best strategy here.
GCC provides only the 0x00 initialization.
Clang provides both, but 0x00 is hidden behind the
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
flag, which may be gone at some point.
Overall, initializing locals with 0xAA pattern is better, as it is
more likely to cause early detectable crashes when using those values.
>
> When I enabled INIT_ALL_MEMORY, I saw this:
>
> WARNING: unmet direct dependencies detected for GCC_PLUGINS
>   Depends on [n]: HAVE_GCC_PLUGINS [=3Dy] && PLUGIN_HOSTCC [=3D]!=3D
>   Selected by [y]:
>   - INIT_ALL_STACK [=3Dy] && INIT_ALL_MEMORY [=3Dy] &&
> (CC_HAS_AUTO_VAR_INIT [=3Dn] || HAVE_GCC_PLUGINS [=3Dy]) &&
> !CC_HAS_AUTO_VAR_INIT [=3Dn]
Yes, we need to check for PLUGIN_HOSTCC as well. I'll update the patch.
FWIW you need gcc-*-plugin-dev installed in order to use these plugins.
>
>
>
> > +endif # INIT_ALL_MEMORY
> > +endmenu
> > --
> > 2.21.0.360.g471c308f928-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
