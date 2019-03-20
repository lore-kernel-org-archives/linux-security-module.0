Return-Path: <SRS0=5vuv=RX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ACCC43381
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Mar 2019 14:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00D02184E
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Mar 2019 14:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUtYv9NE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCTOo2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:44:28 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40162 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTOo2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Mar 2019 10:44:28 -0400
Received: by mail-vs1-f67.google.com with SMTP id z18so1625566vso.7
        for <linux-security-module@vger.kernel.org>; Wed, 20 Mar 2019 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DvySWBkIHY3NiSPRtx9jElEKGpct+6ynF1uYMVLsNx0=;
        b=iUtYv9NETH2vdCo7Mq0N5/BRGC9gOZXLyTFAvPpUpLmuX4DwSDWhua1WkCA4KjO6Fe
         DX6PV7zBLMzNzlE1xQ0UJ4E5PcsxCZ5Kt9wSEf6aQuC1UNyBBwReRQn5SJryFwnVHuTu
         j1f44e7yejTIWMPO7N65BChxrJXOt1r23aNPlNHnYT3nhJ+OTXM9qxzmaV709+TC5wJP
         sP9orMz1DqTb57j2eQI2cWdNCqH/X2Tin9khYPKpt9WuFWH+a6WqCRBSNZ2omKgqAa9d
         YU/aZBVIlhug9lE9l1OYAI6pFw+UK1ENL0hWk4LKPoLpFFdSYPULLdu68o3Gl/9eMF9q
         6oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DvySWBkIHY3NiSPRtx9jElEKGpct+6ynF1uYMVLsNx0=;
        b=FtI75BnxLpnPmqmHw/a//EKBd0edCimDO/9La0ZRebBznL5TtxeGuu7GVUL5J37Ywd
         z1WS6Ugt/Y2qJiT6JVQiFcVlBJFSQQibhZpUUxrt09PLH8jt5LGsuOrDH8t0OsiFo75w
         Us1j6vV2NwFq2LSI9CeyDgY0c/f7xhAP1wJWk0LcwAR6YgMSfGLt+zAY76+72Sp2V0Q3
         d0ub6duo8HUpQ6iQMUKzkHe0qoYpIsGxdUe4DashkQPL2ac2NrBgsozxX6N+gzEgQTxA
         yz9bH5+bb72Zn4tKb0bBM26fr1Ovn4qUNRRIZ+40NWKib6/qRXHTKGhkCkQyH0r2yXCB
         vF6Q==
X-Gm-Message-State: APjAAAUYyNZFBltiExuFcA5Csl9VUWd5PjVOXw51qcnMyg2r+/owG8A9
        lA4VxGaFwlmyuDE2JGi3ieqtQdTvypkE33pNhcViEA==
X-Google-Smtp-Source: APXvYqxL+JVGrgcLo6RzQ1wCHsknOHLgX5iLn2V+N/HCY1MKNg0iKEovimf8Vdw4bXo0hjQ81H+CTruz429e/x6rLVM=
X-Received: by 2002:a67:2444:: with SMTP id k65mr5018392vsk.39.1553093066381;
 Wed, 20 Mar 2019 07:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190308132701.133598-1-glider@google.com> <20190308132701.133598-2-glider@google.com>
In-Reply-To: <20190308132701.133598-2-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 20 Mar 2019 15:44:14 +0100
Message-ID: <CAG_fn=U6Rvg9S0AxLun0oHVx9i=JFc0Lzb+rvkiQn1sTHd-caA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
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

On Fri, Mar 8, 2019 at 2:27 PM Alexander Potapenko <glider@google.com> wrot=
e:
>
> CONFIG_INIT_ALL_MEMORY is going to be an umbrella config for options
> that force heap and stack initialization.
> The rationale behind doing so is to reduce the severity of bugs caused
> by using uninitialized memory.
>
> CONFIG_INIT_ALL_STACK turns on stack initialization based on
> -ftrivial-auto-var-init in Clang builds and on
> -fplugin-arg-structleak_plugin-byref-all in GCC builds.
>
> -ftrivial-auto-var-init is a Clang flag that provides trivial
> initializers for uninitialized local variables, variable fields and
> padding.
>
> It has three possible values:
>   pattern - uninitialized locals are filled with a fixed pattern
>     (mostly 0xAA on 64-bit platforms, see https://reviews.llvm.org/D54604
>     for more details) likely to cause crashes when uninitialized value is
>     used;
>   zero (it's still debated whether this flag makes it to the official
>     Clang release) - uninitialized locals are filled with zeroes;
>   uninitialized (default) - uninitialized locals are left intact.
>
> The proposed config builds the kernel with
> -ftrivial-auto-var-init=3Dpattern.
>
> Developers have the possibility to opt-out of this feature on a
> per-file (by using the INIT_ALL_MEMORY_ Makefile prefix) or per-variable
> (by using __attribute__((uninitialized))) basis.
>
> For GCC builds, CONFIG_INIT_ALL_STACK is simply wired up to
> CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL. No opt-out is possible at the
> moment.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Sandeep Patil <sspatil@android.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> ---
>  v2:
>   - addressed Kees Cook's comments: added GCC support
A friendly ping.
Please let me know if I should wait for any upcoming changes to
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
> ---
>  Makefile                 |  3 ++-
>  scripts/Makefile.initmem | 10 ++++++++++
>  scripts/Makefile.lib     |  6 ++++++
>  security/Kconfig         |  1 +
>  security/Kconfig.initmem | 29 +++++++++++++++++++++++++++++
>  5 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/Makefile.initmem
>  create mode 100644 security/Kconfig.initmem
>
> diff --git a/Makefile b/Makefile
> index f070e0d65186..028ca37878fd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -448,7 +448,7 @@ export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHE=
CK CHECKFLAGS
>
>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_L=
DFLAGS
>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> -export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
> +export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN CFLAGS_INITMEM
>  export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
>  export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
> @@ -840,6 +840,7 @@ KBUILD_ARFLAGS :=3D $(call ar-option,D)
>  include scripts/Makefile.kasan
>  include scripts/Makefile.extrawarn
>  include scripts/Makefile.ubsan
> +include scripts/Makefile.initmem
>
>  # Add any arch overrides and user supplied CPPFLAGS, AFLAGS and CFLAGS a=
s the
>  # last assignments
> diff --git a/scripts/Makefile.initmem b/scripts/Makefile.initmem
> new file mode 100644
> index 000000000000..a6253d78fe35
> --- /dev/null
> +++ b/scripts/Makefile.initmem
> @@ -0,0 +1,10 @@
> +ifdef CONFIG_INIT_ALL_STACK
> +
> +# Clang's -ftrivial-auto-var-init=3Dpattern flag initializes the
> +# uninitialized parts of local variables (including fields and padding)
> +# with a fixed pattern (0xAA in most cases).
> +ifdef CONFIG_CC_HAS_AUTO_VAR_INIT
> +  CFLAGS_INITMEM :=3D -ftrivial-auto-var-init=3Dpattern
> +endif
> +
> +endif
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 12b88d09c3a4..53d18fd15c79 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -131,6 +131,12 @@ _c_flags +=3D $(if $(patsubst n%,, \
>                 $(CFLAGS_UBSAN))
>  endif
>
> +ifeq ($(CONFIG_INIT_ALL_MEMORY),y)
> +_c_flags +=3D $(if $(patsubst n%,, \
> +               $(INIT_ALL_MEMORY_$(basetarget).o)$(INIT_ALL_MEMORY)y), \
> +               $(CFLAGS_INITMEM))
> +endif
> +
>  ifeq ($(CONFIG_KCOV),y)
>  _c_flags +=3D $(if $(patsubst n%,, \
>         $(KCOV_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)$(CONFIG_KCOV=
_INSTRUMENT_ALL)), \
> diff --git a/security/Kconfig b/security/Kconfig
> index e4fe2f3c2c65..cc12a39424dd 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -230,6 +230,7 @@ config STATIC_USERMODEHELPER_PATH
>           If you wish for all usermode helper programs to be disabled,
>           specify an empty string here (i.e. "").
>
> +source "security/Kconfig.initmem"
>  source "security/selinux/Kconfig"
>  source "security/smack/Kconfig"
>  source "security/tomoyo/Kconfig"
> diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
> new file mode 100644
> index 000000000000..27aec394365e
> --- /dev/null
> +++ b/security/Kconfig.initmem
> @@ -0,0 +1,29 @@
> +menu "Initialize all memory"
> +
> +config CC_HAS_AUTO_VAR_INIT
> +       def_bool $(cc-option,-ftrivial-auto-var-init=3Dpattern)
> +
> +config INIT_ALL_MEMORY
> +       bool "Initialize all memory"
> +       default n
> +       help
> +         Enforce memory initialization to mitigate infoleaks and make
> +         the control-flow bugs depending on uninitialized values more
> +         deterministic.
> +
> +if INIT_ALL_MEMORY
> +
> +config INIT_ALL_STACK
> +       bool "Initialize all stack"
> +       depends on INIT_ALL_MEMORY
> +       depends on CC_HAS_AUTO_VAR_INIT || HAVE_GCC_PLUGINS
> +       select GCC_PLUGINS if !CC_HAS_AUTO_VAR_INIT
> +       select GCC_PLUGIN_STRUCTLEAK if !CC_HAS_AUTO_VAR_INIT
> +       select GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if !CC_HAS_AUTO_VAR_INIT
> +       default y
> +       help
> +         Initialize uninitialized stack data with a fixed pattern
> +         (0x00 in GCC, 0xAA in Clang).
> +
> +endif # INIT_ALL_MEMORY
> +endmenu
> --
> 2.21.0.360.g471c308f928-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
