Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BD6C43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05062081B
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 17:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hezhWNdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfCGRMM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:12:12 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39656 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfCGRML (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Mar 2019 12:12:11 -0500
Received: by mail-ua1-f68.google.com with SMTP id s15so10431761uap.6
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2019 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpG7H+Lmi/XoqP0W29KE8uxjO79VPwfg2RcpuQ1zT7c=;
        b=hezhWNdN5Xf0D9ULyoINB4xTKkNb/Irrdrc3LgVlGYWLnRWLyy1azBRC6EsYUGCFyp
         68oNszPEu1rpVofyhTgTyUImWsHoGEzjvUCMI9ncyOG38CQePTfTA5bPbG7NMxFhd4Mk
         KnTFuw16rz398zNDdf1L1i1frUiwlZPaRNzPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpG7H+Lmi/XoqP0W29KE8uxjO79VPwfg2RcpuQ1zT7c=;
        b=hYjPceMBAjUc2u3rcJqT5cyQJ9IZsh+i6NF1ezmofEALB4bJ5abNp3jm0bf2aCfrQJ
         nXCR9cOLWeE2ShGuinZVkWggtRn55tE0XkGW8JUhuxY4HktQEsbm6XalfY68O7tl/geV
         v8bEx8Ok98v6Aj1DdiE9qeqiOCmIqexJYwJbKSdgXjGNPZVuCv7N38oS+CkLwegO2mVd
         SKVTyQDoCrVGpzVu+YtkzDzovmxa3mGv0w+08cVKD4VAhMw3LaS+zGYPRpWdXGofLQva
         76/LnJFoG390H+ybwnHxBXybB8//VybjkZ0ZC9m63JN0YUhTuYrydtfzjKMoRFTgxBvk
         Qrdg==
X-Gm-Message-State: APjAAAUrGAAWkA2ZKR2dkslrOkYMRijjV048lH59qeyMnY6XTbxWap1q
        FLvjpBNcE1TDY+RcG8a8bQAv/A3H31s=
X-Google-Smtp-Source: APXvYqzE1F4A7Ypf/V/uplMMtwOA4v1eHA3xdR8SK1I91XL4TMW5gfasvQ29+HWz3hjuP6rpFNhiPA==
X-Received: by 2002:ab0:6705:: with SMTP id q5mr6769141uam.43.1551978727687;
        Thu, 07 Mar 2019 09:12:07 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id b198sm3579142vkf.27.2019.03.07.09.12.06
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 09:12:06 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id q17so10452573uam.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2019 09:12:06 -0800 (PST)
X-Received: by 2002:ab0:4a8d:: with SMTP id s13mr7515445uae.122.1551978725636;
 Thu, 07 Mar 2019 09:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20190307133514.44378-1-glider@google.com> <20190307133514.44378-2-glider@google.com>
In-Reply-To: <20190307133514.44378-2-glider@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 7 Mar 2019 09:11:54 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJM4RNOUUSu5YnT_csdHjra=qJv3kiC6qh1aZTLCKvxdw@mail.gmail.com>
Message-ID: <CAGXu5jJM4RNOUUSu5YnT_csdHjra=qJv3kiC6qh1aZTLCKvxdw@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Alexander Potapenko <glider@google.com>
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
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 7, 2019 at 5:35 AM Alexander Potapenko <glider@google.com> wrote:
>
> This patch is a part of a bigger initiative to allow initializing
> heap/stack memory in the Linux kernels by default.
> The rationale behind doing so is to reduce the severity of bugs caused
> by using uninitialized memory.
>
> CONFIG_INIT_ALL_MEMORY is going to be an umbrella config for options
> that force heap and stack initialization.

We have some level of control over the heap portions already with the
poisoning options, but they currently require command-line enabling.

For the slab allocator:
CONFIG_SLUB_DEBUG=y
and boot with "slub_debug=P"

For the page allocator:
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
and boot with "page_poison=1"

So I think it would make sense to wire up the boot defaults and
continue some of the benchmarking work to improve the performance hit.

> CONFIG_INIT_ALL_STACK turns on stack initialization based on the
> -ftrivial-auto-var-init Clang flag.
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

This should get wired up to CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL in
the GCC case.

> The proposed config builds the kernel with
> -ftrivial-auto-var-init=pattern.
>
> Developers have the possibility to opt-out of this feature on a
> per-file (by using the INIT_ALL_MEMORY_ Makefile prefix) or per-variable
> (by using __attribute__((uninitialized))) basis.

I would like a clean way to offer a paranoid "true init all memory"
config that will ignore the attribute. Also, BYREF_ALL needs to gain
the attribute knowledge.

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
>
> ---
>  Makefile                 |  3 ++-
>  scripts/Makefile.initmem | 17 +++++++++++++++++
>  scripts/Makefile.lib     |  6 ++++++
>  security/Kconfig         |  1 +
>  security/Kconfig.initmem | 22 ++++++++++++++++++++++
>  5 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/Makefile.initmem
>  create mode 100644 security/Kconfig.initmem
>
> diff --git a/Makefile b/Makefile
> index f070e0d65186..028ca37878fd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -448,7 +448,7 @@ export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
>
>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> -export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
> +export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN CFLAGS_INITMEM
>  export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
>  export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
> @@ -840,6 +840,7 @@ KBUILD_ARFLAGS := $(call ar-option,D)
>  include scripts/Makefile.kasan
>  include scripts/Makefile.extrawarn
>  include scripts/Makefile.ubsan
> +include scripts/Makefile.initmem
>
>  # Add any arch overrides and user supplied CPPFLAGS, AFLAGS and CFLAGS as the
>  # last assignments
> diff --git a/scripts/Makefile.initmem b/scripts/Makefile.initmem
> new file mode 100644
> index 000000000000..f49be398f2c1
> --- /dev/null
> +++ b/scripts/Makefile.initmem
> @@ -0,0 +1,17 @@
> +ifdef CONFIG_INIT_ALL_MEMORY
> +
> +# Clang's -ftrivial-auto-var-init=pattern flag initializes the
> +# uninitialized parts of local variables (including fields and padding)
> +# with a fixed pattern (0xAA in most cases).
> +ifdef CONFIG_INIT_ALL_STACK
> + CFLAGS_INITMEM := -ftrivial-auto-var-init=pattern
> +endif
> +
> +ifeq ($(call cc-option, $(CFLAGS_INITMEM) -Werror),)
> +   ifneq ($(CONFIG_COMPILE_TEST),y)
> +        $(warning Cannot use CONFIG_INIT_ALL_MEMORY: \
> +            -ftrivial-auto-var-init is not supported by compiler)
> +   endif
> +endif

This should be done in the Kconfig (see how stack protector is
handled), rather than the Makefile. See below.

> +
> +endif
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 12b88d09c3a4..53d18fd15c79 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -131,6 +131,12 @@ _c_flags += $(if $(patsubst n%,, \
>                 $(CFLAGS_UBSAN))
>  endif
>
> +ifeq ($(CONFIG_INIT_ALL_MEMORY),y)
> +_c_flags += $(if $(patsubst n%,, \
> +               $(INIT_ALL_MEMORY_$(basetarget).o)$(INIT_ALL_MEMORY)y), \
> +               $(CFLAGS_INITMEM))
> +endif
> +
>  ifeq ($(CONFIG_KCOV),y)
>  _c_flags += $(if $(patsubst n%,, \
>         $(KCOV_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)$(CONFIG_KCOV_INSTRUMENT_ALL)), \
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
> index 000000000000..5ac3cf3e7f88
> --- /dev/null
> +++ b/security/Kconfig.initmem
> @@ -0,0 +1,22 @@
> +menu "Initialize all memory"
> +
> +config INIT_ALL_MEMORY
> +       bool "Initialize all memory"
> +       default n
> +       help
> +         Enforce memory initialization to mitigate infoleaks and make
> +         the control-flow bugs depending on uninitialized values more
> +         deterministic.

See my notes about enabling page/slab poisoning via this option (which
should probably be a separate HEAP option).

> +
> +if INIT_ALL_MEMORY
> +
> +config INIT_ALL_STACK
> +       bool "Initialize all stack"
> +       depends on INIT_ALL_MEMORY

For example of doing this in Kconfig:

config CC_HAS_AUTO_VAR_INIT
        def_bool $(cc-option,-ftrivial-auto-var-init=pattern)

config INIT_ALL_STACK
        bool "Initialize all stack"
        depends on CC_HAS_AUTO_VAR_INIT || HAVE_GCC_PLUGINS
        select GCC_PLUGINS if !CC_HAS_AUTO_VAR_INIT
        select GCC_PLUGIN_STRUCTLEAK if !CC_HAS_AUTO_VAR_INIT
        select GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if !CC_HAS_AUTO_VAR_INIT

probably GCC_PLUGINS needs to be "default y" so this select mess is
less crazy. I already started work on reorganizing the Kconfig there:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/gcc-plugin/structleak&id=81a56f6dcd20325607d6008f4bb560c96f4c821a

> +       default y
> +       help
> +         Initialize uninitialized stack data with a 0xAA pattern.
> +         This config option only supports Clang builds at the moment.
> +
> +endif # INIT_ALL_MEMORY
> +endmenu
> --
> 2.21.0.352.gf09ad66450-goog
>

-- 
Kees Cook
