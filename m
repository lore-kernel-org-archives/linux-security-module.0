Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87887C43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 18:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A58A20854
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 18:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7Dh/2MM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCGShp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:37:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33380 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGShp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Mar 2019 13:37:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id h11so11947719pgl.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2019 10:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yN9dkPJ+T+XhphozCC/KJodxLcW/ZtrytsUC0g0Sv0o=;
        b=Y7Dh/2MMKLhhKqDUd8o2AoIjqtTVnJDalUWeFUmhIcimRxh/WWh7yAx7oXcZypcS67
         EX0lQbLnEm4OdByCrxze4f5WFMtmXohQnhQBlFD9Wo/sGIDpBPl3M6wzj3U6Ia/+NjR/
         3723v+3tg/NTYwSGh9nSPrtIKeKwJ5kcE+vCNRvy9rBtk5rb8ptp2ey9Rgy5eCmf4Dme
         JjbXiO5KFTrkOUS5UgjtkdI/6LfjIUnyPreu0NUYKZ9Il3k35mnm4qKm8GHvRrzkTwS0
         olTSCgeNOB9SQrPsgqPjrOC3bvXS15/4byQ9+x0fCCqh5GU3FbSXEGfwy54Bl2ciw9J0
         dVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yN9dkPJ+T+XhphozCC/KJodxLcW/ZtrytsUC0g0Sv0o=;
        b=dMsENhZb6LrHHznJMh9mIQvIXt+QaUoCfvLVhi26N/dNjjP+88W4P3BuUGjNVBGsoU
         wN90wzYmfqlihjAZPo6JYpchvegvb9Ib68ecyt/2DNQr/n6NG3VcXwxDb8QGZlHu2c0X
         Pj69As6sCZW1wW3u71PT4uePxSVB5Q5jDq2k1wo5yESaPHAu/UVDcDE5hcvtJIhBYXTL
         2HHAdvL60Exq84clmk3D6NnhE2+q9i/9lCq8XMxeUpepHGA8WaihpvJQRgLT/PJ0vBrm
         gwj8IyGnOS53frnx3faSyq89Bp+nJJCiw8PF4VLjRYJH065l8uS4bKTUAfMNlTwn6Hdr
         I7JA==
X-Gm-Message-State: APjAAAXiOgyssqWT452RS4dOG6L7EWRzpqkghVK5iwMODiq0g+Cftu0k
        AZLqLNyqK7fW36FnUOZOvF3MbtlenJaUcgaWDyGO3g==
X-Google-Smtp-Source: APXvYqxoRj1f8Whzy2v3IenCCTKRJ/D8QUhft4Sku0yC6Ek6+qKyHzx803T9+vZhZCL0QmP5zPJafsuUog5ocgkWj1s=
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr2621721plc.238.1551983863980;
 Thu, 07 Mar 2019 10:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20190307133514.44378-1-glider@google.com> <20190307133514.44378-2-glider@google.com>
In-Reply-To: <20190307133514.44378-2-glider@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 10:37:32 -0800
Message-ID: <CAKwvOdnRNyANL4T3CZxWiE_s+mKTYBBXbczeei8Ne6Sy7jb+og@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Alexander Potapenko <glider@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>, sspatil@android.com
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
>
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

Hopefully the disagreements there about "defining a new dialect of
C++" don't apply to us in the kernel.  We'd like to have this feature;
our dialect of C is already quite far from what ISO has specified,
both through the explicit use of `-f` compiler flags and use of most
GNU C extensions.  We already have our own dialect of C for the
kernel, it's too late for that.  But maybe I should go bikeshed in
cfe-dev...

Thanks for this patch.  I'll take a closer look once Kees' feedback
has been addressed.

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
> per-file (by using the INIT_ALL_MEMORY_ Makefile prefix) or per-variable
> (by using __attribute__((uninitialized))) basis.
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
> +
> +if INIT_ALL_MEMORY
> +
> +config INIT_ALL_STACK
> +       bool "Initialize all stack"
> +       depends on INIT_ALL_MEMORY
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
Thanks,
~Nick Desaulniers
