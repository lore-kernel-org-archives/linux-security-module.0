Return-Path: <SRS0=RbId=RL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ED9C43381
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 10:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADB120854
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 10:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="je0aJNi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCHKJU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:09:20 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34655 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfCHKJU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Mar 2019 05:09:20 -0500
Received: by mail-vs1-f65.google.com with SMTP id h7so6324576vsl.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2019 02:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t/tVaI8asrkS6e9NZu7j5HT/6EyT+IW0eK2Gk+x2c/U=;
        b=je0aJNi8sjgo2XnNPUapISgSqZmb55r8SQD/R9SLCLhpTV7rRhnO9hn21u+xt31Zes
         8idrFOdOQ1H6RMaVGsuuDqd1RWXkNH286lBUoi0yVkiEpA+07xhGYnxL7Uw7/tIkXg3o
         w25aJyNQqWWBvmVYXPjHKm2I7vPlbe/UZixBt6MnxnFw7G3dM3BO3J09BgTzE0P0bmgM
         IXKf+dHSvb3H465H2aRt9Y+phLREYHrrlVNJA39Yrg1GoV+WdWXhLZTkc7DKv6UVSMWh
         4EePU9M0u6SFYMXhb5g+5+8eqoG0CucYago55mva1/MMu/Bi1ZJcXfH0LrC8PMVrXtEK
         icNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t/tVaI8asrkS6e9NZu7j5HT/6EyT+IW0eK2Gk+x2c/U=;
        b=miNNnEkUDvMjwdTz5RdHausz1oqqYEgw+HDLxFECq1FNRB6mw26kN95pMijgMVx27T
         SneFkY55I2MEv3QW69P/9UwOU9CXQvV0VYbw8hXRz2RF/B0SAAEFBG62USQpNa4GQOnJ
         HHbRfCUegK1iyt4puVCo/M1QfLz0HHiMmyKXUPsK7ghu5hP1EARNo0eKz5IqHVvF3QTm
         6IGByxKdkIOBrcwz2Hj+jlzL1aK/PIGskvxDyxy3OgcfYXZyg79fJL/4ws3Xhi5osGdZ
         Gqf5x7OAH/8tCaJIEHnBHT8HhClySWkgPomzlho+mTFDX8tcMKbKl+wdE8FGCDOjO0Im
         N3GQ==
X-Gm-Message-State: APjAAAURNItGN8h/jH+FOr7OBCBia3Cs9FWrCpiYhRVMRpo88TnOB5Qm
        IX1LNj52P51zeDP+vAIw6aXb/DdBWLp6OJFodbZpzA==
X-Google-Smtp-Source: APXvYqyw9TQtJ9V6314WsKR0Tk+N1xGKhLtIVv7+GDA3DpXZ0nj/+J+ali+ReXtz3qVzeoY9JSV9KVVjolL5Ni9n77c=
X-Received: by 2002:a67:fbc6:: with SMTP id o6mr9498995vsr.39.1552039758404;
 Fri, 08 Mar 2019 02:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20190307133514.44378-1-glider@google.com> <20190307133514.44378-2-glider@google.com>
 <CAGXu5jJM4RNOUUSu5YnT_csdHjra=qJv3kiC6qh1aZTLCKvxdw@mail.gmail.com>
In-Reply-To: <CAGXu5jJM4RNOUUSu5YnT_csdHjra=qJv3kiC6qh1aZTLCKvxdw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 8 Mar 2019 11:09:06 +0100
Message-ID: <CAG_fn=WmEFOPjPBB86o+7PCwuBD6qOic75D7TvKo+MrGozFtKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 7, 2019 at 6:12 PM Kees Cook <keescook@chromium.org> wrote:
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
>
> We have some level of control over the heap portions already with the
> poisoning options, but they currently require command-line enabling.
>
> For the slab allocator:
> CONFIG_SLUB_DEBUG=3Dy
> and boot with "slub_debug=3DP"
>
> For the page allocator:
> CONFIG_PAGE_POISONING=3Dy
> CONFIG_PAGE_POISONING_NO_SANITY=3Dy
> CONFIG_PAGE_POISONING_ZERO=3Dy
> and boot with "page_poison=3D1"
>
> So I think it would make sense to wire up the boot defaults and
> continue some of the benchmarking work to improve the performance hit.
Should we care about the poison values being different for stack and
heap initialization (probably no)?

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
> >     for more details) likely to cause crashes when uninitialized value =
is
> >     used;
> >   zero (it's still debated whether this flag makes it to the official
> >     Clang release) - uninitialized locals are filled with zeroes;
> >   uninitialized (default) - uninitialized locals are left intact.
>
> This should get wired up to CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL in
> the GCC case.
I'm not really familiar with CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
Does it initialize a variable if it's not explicitly address-taken,
but is used in a computation of another variable's value?
Also, are we ok with Clang and GCC producing different poison values
for the stack? (probably yes)

> > The proposed config builds the kernel with
> > -ftrivial-auto-var-init=3Dpattern.
> >
> > Developers have the possibility to opt-out of this feature on a
> > per-file (by using the INIT_ALL_MEMORY_ Makefile prefix) or per-variabl=
e
> > (by using __attribute__((uninitialized))) basis.
>
> I would like a clean way to offer a paranoid "true init all memory"
> config that will ignore the attribute.
How paranoid should it be? E.g. current instrumentation in Clang (nor
in GCC, I guess) doesn't prevent the following situation:

char local[8];
int init_later;
copy_to_user(userp, local, 12);
init_later =3D 1;

Do we want to true init |init_later| despite there's a write to it later?

Regarding the attribute, right now it only makes sense to use it in
the cases the compilers fail to apply DSE to the unneeded
initializers.
For example, Clang fails to do so for |oldbit| in __test_and_set_bit()
here: https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/b=
itops.h#L245
(We could fix this with a heuristic to not initialize scalars used as
assembly outputs, but that's walking on thin ice)
Do you know how GCC handles this situation?

> Also, BYREF_ALL needs to gain
> the attribute knowledge.
>
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
>
> This should be done in the Kconfig (see how stack protector is
> handled), rather than the Makefile. See below.
>
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
>
> See my notes about enabling page/slab poisoning via this option (which
> should probably be a separate HEAP option).
>
> > +
> > +if INIT_ALL_MEMORY
> > +
> > +config INIT_ALL_STACK
> > +       bool "Initialize all stack"
> > +       depends on INIT_ALL_MEMORY
>
> For example of doing this in Kconfig:
>
> config CC_HAS_AUTO_VAR_INIT
>         def_bool $(cc-option,-ftrivial-auto-var-init=3Dpattern)
>
> config INIT_ALL_STACK
>         bool "Initialize all stack"
>         depends on CC_HAS_AUTO_VAR_INIT || HAVE_GCC_PLUGINS
>         select GCC_PLUGINS if !CC_HAS_AUTO_VAR_INIT
>         select GCC_PLUGIN_STRUCTLEAK if !CC_HAS_AUTO_VAR_INIT
>         select GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if !CC_HAS_AUTO_VAR_INIT
>
> probably GCC_PLUGINS needs to be "default y" so this select mess is
> less crazy. I already started work on reorganizing the Kconfig there:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=
=3Dkspp/gcc-plugin/structleak&id=3D81a56f6dcd20325607d6008f4bb560c96f4c821a
>
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
> --
> Kees Cook



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
