Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC70C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 08:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96AF20883
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 08:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0vh+RB7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDIIiF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:38:05 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:45271 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIIiF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 04:38:05 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x398bmAn006923;
        Tue, 9 Apr 2019 17:37:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x398bmAn006923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554799070;
        bh=VUyI4ES9NZKBpAx333DGaTxA4S8CQkeGuFLjcY9dpsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0vh+RB7Pk0dDQUJh9ti8pOedwOexbOhG1J4HtA+0hKXKZLbjY594cMzm1BacmO1gQ
         J/r7MVDQ694TjxzhQdqmBZ44DgUkarsSvslKv+/J8P23MBb5JUAEfBLHObBQFNynnt
         cjIUtBczIRkXZvu/QNxdDyX8e9ru2haAKh/TsJkLtYZlUScL+9GmAZSi6ielYcIGzN
         nhsTTzqLu/1p1rfPA8G3wh8crvYXLTXHd1OFP8vGyQxXKOj1eiwLwMxQCa0GpkkIxA
         /C4bgHR5vuRo7PHvH3D4WYFu1cUwUB+HzjnxiEbzl7KHa5RHC/OBl9odolitmsbxju
         8Z5yeoZ39LGzw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id a190so2334630vsd.0;
        Tue, 09 Apr 2019 01:37:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUOJdcN5OV7iS7SvLPYqtF0OKXiIeJ/0Yg8KSVs2Zx1wSNLNUH0
        km8MRcDrcJnlsUAJsgQEy8E7OQi55NAwmGwzaE4=
X-Google-Smtp-Source: APXvYqznu4k63IT8Hiv20k7atyEQeu/jXMooYcR+gfFEF/Hyogt/3Jk0vj+7AWwuAKbbI3/KvydlpYmHWgbdhn1GUPI=
X-Received: by 2002:a67:c29e:: with SMTP id k30mr18557458vsj.203.1554799068448;
 Tue, 09 Apr 2019 01:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190408170418.148554-1-glider@google.com> <20190408170418.148554-2-glider@google.com>
In-Reply-To: <20190408170418.148554-2-glider@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Apr 2019 17:37:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS3+FKpgBvvxKDukD1xcHUZ1o3TsE1BjjVq5P13MrO7Fw@mail.gmail.com>
Message-ID: <CAK7LNAS3+FKpgBvvxKDukD1xcHUZ1o3TsE1BjjVq5P13MrO7Fw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Alexander Potapenko <glider@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>, sspatil@android.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 9, 2019 at 2:04 AM Alexander Potapenko <glider@google.com> wrote:
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
> -ftrivial-auto-var-init=pattern.
>
> Developers have the possibility to opt-out of this feature on a
> per-variable basis by using __attribute__((uninitialized)).
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
>  v3: addressed Masahiro Yamada's comments:
>   - dropped per-file opt-out mechanism
>   - fixed GCC_PLUGINS dependencies
> ---
>  Makefile                 |  3 ++-
>  scripts/Makefile.initmem | 10 ++++++++++
>  security/Kconfig         |  1 +
>  security/Kconfig.initmem | 29 +++++++++++++++++++++++++++++
>  4 files changed, 42 insertions(+), 1 deletion(-)
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
> index 000000000000..a6253d78fe35
> --- /dev/null
> +++ b/scripts/Makefile.initmem
> @@ -0,0 +1,10 @@
> +ifdef CONFIG_INIT_ALL_STACK
> +
> +# Clang's -ftrivial-auto-var-init=pattern flag initializes the
> +# uninitialized parts of local variables (including fields and padding)
> +# with a fixed pattern (0xAA in most cases).
> +ifdef CONFIG_CC_HAS_AUTO_VAR_INIT
> +  CFLAGS_INITMEM := -ftrivial-auto-var-init=pattern
> +endif
> +
> +endif

Now that you dropped per-file control,
why is this necessary?
Also, CFLAGS_INITMEM is not wired up to anything,
so this patch has no effect.


I think you can add the following to top Makefile, and that's it.

ifdef CONFIG_AUTO_VAR_INIT
KBUILD_CFLAGS += -ftrivial-auto-var-init=pattern
endif




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
> index 000000000000..5e49a55382ad
> --- /dev/null
> +++ b/security/Kconfig.initmem
> @@ -0,0 +1,29 @@
> +menu "Initialize all memory"
> +
> +config CC_HAS_AUTO_VAR_INIT
> +       def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
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
> +       depends on CC_HAS_AUTO_VAR_INIT || (HAVE_GCC_PLUGINS && PLUGIN_HOSTCC != "")
> +       select GCC_PLUGINS if !CC_HAS_AUTO_VAR_INIT
> +       select GCC_PLUGIN_STRUCTLEAK if !CC_HAS_AUTO_VAR_INIT
> +       select GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if !CC_HAS_AUTO_VAR_INIT
> +       default y
> +       help
> +         Initialize uninitialized stack data with a fixed pattern
> +         (0x00 in GCC, 0xAA in Clang).
> +


I am not sure about the benefit of these umbrella CONFIGs
since these make 'depends on' and 'select' complicated.
I will leave it to Kees, though.



> +endif # INIT_ALL_MEMORY
> +endmenu
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Best Regards
Masahiro Yamada
