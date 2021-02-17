Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C101C433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Feb 2021 18:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579E164E5F
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Feb 2021 18:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhBQSVH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbhBQSVA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Feb 2021 13:21:00 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3440C061574
        for <linux-security-module@vger.kernel.org>; Wed, 17 Feb 2021 10:20:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f1so23267835lfu.3
        for <linux-security-module@vger.kernel.org>; Wed, 17 Feb 2021 10:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8i0g9QG9GcfcjV4SfK9KOZfpjS43yyxo3Zx1FaTpHg=;
        b=h7iUpSow9k12uVMOboB5Bjv17rWg/6jjYDY14S/c9H+JtKhmOqzKKU0SXNql5LMSHo
         5QUI6VYKH41Q7OVNhB/oRl8/+8YHm/LpjROCeDAL45ObLLq2hUNpbu9IH/1Wm79tGcHw
         7I/VLgzKKpQBdyOWC/bbaetILYY449szZWMu2hzrd6QIXUK6Su4OEsgmGEEmv+khIr+Z
         iv34uRIonT6ZvmaYzrb5/yPNbO6L3PG9NpOnmHBmEj/cnRPa0FJ9d3QXdUsaW3FPBHHs
         7RXQ0sx29ZzqUml1Qp9wzvoD0y+zw1iV0vedpNOeo9itpeCTUZGdnKWeiE2ri6WPbIvE
         hnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8i0g9QG9GcfcjV4SfK9KOZfpjS43yyxo3Zx1FaTpHg=;
        b=Qd1J+4IfDJvbAi35qGmHFH5HxYtcg1yZfTFSoi2vW2JzCh7lKSseuOMNXrz68PhPk/
         3U/t8WCI6xtTGxQA5+2fyJ/Ium14p0+FjRde+KLTuMOhc4AVXwnclHSginCvE2wHA/Pr
         bUI0oHZMAXJMvkIbeOT8lUPyJT5sHjRfcv95U4ogobdyuqqLdDM0tU0ZpQPxM/waS2Kl
         6V8hqGMgWvcOj24RoHszfHWTaP/QIGACGnAEIiguyxkGvof37UoBEdhh5BRx5anVm1Np
         M/lwUpz09+Umb8fExEhad7ypvU9efkafpeBhxr0IhgumWwKLv/0zEUEktFmczueCbrAy
         LUxQ==
X-Gm-Message-State: AOAM530QVwpY1FDHKxuTMwoXxx7Qt8GS3sCvRDsVXK0s/gssS0Veo5GX
        DhlTmObCth2u5qbVLQoFgqQ7qJZN00PMpCDOv+eFMg==
X-Google-Smtp-Source: ABdhPJxMOLeAZPfh9/xXXXpTBjyQSpSyJvRHbhY5s0MXSFezU+L7QBkjMpxGQPfs6EC3HXmAYL8YPvDdUF5+IFW0YzQ=
X-Received: by 2002:a19:4013:: with SMTP id n19mr89135lfa.543.1613586018064;
 Wed, 17 Feb 2021 10:20:18 -0800 (PST)
MIME-Version: 1.0
References: <3f61af0eee9b495e8e8c032902d033c5@AcuMS.aculab.com> <20210212195255.1321544-1-jiancai@google.com>
In-Reply-To: <20210212195255.1321544-1-jiancai@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 Feb 2021 10:20:06 -0800
Message-ID: <CAKwvOdn7N9dRfjrR0NiE6Dc_f_6PU-_4g1G5uRcoAvnob51ZfA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Implement Clang's SLS mitigation
To:     Jian Cai <jiancai@google.com>
Cc:     Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 12, 2021 at 11:53 AM 'Jian Cai' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:

The oneline of the commit is "ARM: Implement Clang's SLS mitigation,"
but that's not precise. GCC implements the same flag with the same
arguments.  There is nothing compiler specific about this patch.
(Though perhaps different section names are used, see below).

>
> This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
> -mharden-sls=all, which mitigates the straight-line speculation
> vulnerability, speculative execution of the instruction following some
> unconditional jumps. Notice -mharden-sls= has other options as below,
> and this config turns on the strongest option.
>
> all: enable all mitigations against Straight Line Speculation that are implemented.
> none: disable all mitigations against Straight Line Speculation.
> retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
> blr: enable the mitigation against Straight Line Speculation for BLR instructions.
>
> Link: https://reviews.llvm.org/D93221
> Link: https://reviews.llvm.org/D81404
> Link: https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation
> https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/frequently-asked-questions#SLS2
>
> Suggested-by: Manoj Gupta <manojgupta@google.com>
> Suggested-by: Nathan Chancellor  <nathan@kernel.org>
> Suggested-by: David Laight <David.Laight@aculab.com>
> Signed-off-by: Jian Cai <jiancai@google.com>

I observe lots of linker warnings with this applied on linux-next:
ld.lld: warning:
init/built-in.a(main.o):(.text.__llvm_slsblr_thunk_x0) is being placed
in '.text.__llvm_slsblr_thunk_x0'
You need to modify arch/arm64/kernel/vmlinux.lds.S and
arch/arm/kernel/vmlinux.lds.S (and possibly
arch/arm/boot/compressed/vmlinux.lds.S as well) to add these sections
back into .text so that the linkers don't place these orphaned
sections in wild places.  The resulting aarch64 kernel image doesn't
even boot (under emulation).

For 32b ARM:
ld.lld: warning:
init/built-in.a(main.o):(.text.__llvm_slsblr_thunk_arm_r0) is being
placed in '.text.__llvm_slsblr_thunk_arm_r0'
...
ld.lld: warning:
init/built-in.a(main.o):(.text.__llvm_slsblr_thunk_thumb_r0) is being
placed in '.text.__llvm_slsblr_thunk_thumb_r0'
...
<trimmed, but there's close to 60 of these>

And the image doesn't boot (under emulation).

> ---
>
> Changes v1 -> v2:
>  Update the description and patch based on Nathan and David's comments.
>
>  arch/arm/Makefile          | 4 ++++
>  arch/arm64/Makefile        | 4 ++++
>  security/Kconfig.hardening | 7 +++++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 4aaec9599e8a..11d89ef32da9 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -48,6 +48,10 @@ CHECKFLAGS   += -D__ARMEL__
>  KBUILD_LDFLAGS += -EL
>  endif
>
> +ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
> +KBUILD_CFLAGS  += -mharden-sls=all
> +endif
> +
>  #
>  # The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 4.9 and
>  # later may result in code being generated that handles signed short and signed
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 90309208bb28..ca7299b356a9 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -34,6 +34,10 @@ $(warning LSE atomics not supported by binutils)
>    endif
>  endif
>
> +ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
> +KBUILD_CFLAGS  += -mharden-sls=all
> +endif
> +
>  cc_has_k_constraint := $(call try-run,echo                             \
>         'int main(void) {                                               \
>                 asm volatile("and w0, w0, %w0" :: "K" (4294967295));    \
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 269967c4fc1b..9266d8d1f78f 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -121,6 +121,13 @@ choice
>
>  endchoice
>
> +config HARDEN_SLS_ALL
> +       bool "enable SLS vulnerability hardening"
> +       def_bool $(cc-option,-mharden-sls=all)

This fails to set CONFIG_HARDEN_SLS_ALL for me with:
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make LLVM=1 LLVM_IAS=1
-j72 defconfig
$ grep SLS_ALL .config
# CONFIG_HARDEN_SLS_ALL is not set

but it's flipped on there for arm64 defconfig:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make LLVM=1 LLVM_IAS=1
-j72 defconfig
$ grep SLS_ALL .config
CONFIG_HARDEN_SLS_ALL=y

What's going on there?  Is the cc-option Kconfig macro broken for
Clang when cross compiling 32b ARM?  I can still enable
CONFIG_HARDEN_SLS_ALL via menuconfig, but I wonder if the default
value is funny because the cc-option check is failing?

> +        help
> +          Enables straight-line speculation vulnerability hardening
> +         at highest level.
> +
>  config GCC_PLUGIN_STRUCTLEAK_VERBOSE
>         bool "Report forcefully initialized variables"
>         depends on GCC_PLUGIN_STRUCTLEAK
> --

-- 
Thanks,
~Nick Desaulniers
