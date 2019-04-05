Return-Path: <SRS0=2koH=SH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC33C4360F
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 11:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E29E2186A
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 11:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q1RYlE5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfDELgG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:36:06 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:62612 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELgG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Apr 2019 07:36:06 -0400
X-Greylist: delayed 1013 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Apr 2019 07:36:05 EDT
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x35Ba2TZ010688;
        Fri, 5 Apr 2019 20:36:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x35Ba2TZ010688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554464163;
        bh=CUJlDP1tnHE8qrG/10NNQI9jQMbX8JoUEaTCQMeYC/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q1RYlE5nsmmeHuYKMfAup2A6ROFCP8U8NVb5q7G/uwonew4kAeQER48LJWaGpv957
         Bcyca7+t/c1zRdqeedNZp79WhRWNcI+U2fheXlwly97FCMH8ARpFF9nUVRrzHMef7n
         niorBYJTPrp0iEQx25j656ExEuCLPWUvjU/FW7WdPOn7J4LF4XO8sZqU1T5Wt1MiO/
         uIddVcLBxWyumOoVQCnjosTM2gjTIT+DdIOBDnxBqT85J6Hw1Ai98OSCn9AxIgeeQ8
         pwj70Gbp07nplFBBrTGCXJwjOPBlj9lGBPGdgDBUTR2vFBBTgdjVvs9zAh1pfUo7n/
         D/SFgV0GXRhxQ==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id d8so3285642vsp.2;
        Fri, 05 Apr 2019 04:36:02 -0700 (PDT)
X-Gm-Message-State: APjAAAUZHscabt26DZeuDIc+Yv8euNTUoxA1OdhyyqnaVeqa3o7mjctM
        ypzkczsZQU6O4MSQAitLHEgMfHa79RGTt2AkgFg=
X-Google-Smtp-Source: APXvYqyYU3FDLG3yBwWpt9lx2Z6xOfEnoJl/eYKZGDivR7wohkmYpnGMCV0c3Qu5K6jTn9czkkDhxR9YRlwTaPybYHU=
X-Received: by 2002:a67:fbcc:: with SMTP id o12mr8008193vsr.60.1554464161996;
 Fri, 05 Apr 2019 04:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190308132701.133598-1-glider@google.com> <20190308132701.133598-3-glider@google.com>
In-Reply-To: <20190308132701.133598-3-glider@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 5 Apr 2019 20:35:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARV+_RNE4E5H37e9wH6iPyrzqsLtcWd0wLSt+vsEvncRA@mail.gmail.com>
Message-ID: <CAK7LNARV+_RNE4E5H37e9wH6iPyrzqsLtcWd0wLSt+vsEvncRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
To:     Alexander Potapenko <glider@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, kcc@google.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>, sspatil@android.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 8, 2019 at 10:27 PM Alexander Potapenko <glider@google.com> wrote:
>
> diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
> index 27aec394365e..5ce49663777a 100644
> --- a/security/Kconfig.initmem
> +++ b/security/Kconfig.initmem
> @@ -13,6 +13,17 @@ config INIT_ALL_MEMORY
>
>  if INIT_ALL_MEMORY
>
> +config INIT_ALL_HEAP
> +       bool "Initialize all heap"
> +       depends on INIT_ALL_MEMORY
> +       select CONFIG_PAGE_POISONING
> +       select CONFIG_PAGE_POISONING_NO_SANITY
> +       select CONFIG_PAGE_POISONING_ZERO
> +       select CONFIG_SLUB_DEBUG

This should like follows (no CONFIG_ prefix):

         select PAGE_POISONING
         select PAGE_POISONING_NO_SANITY
         select PAGE_POISONING_ZERO
         select SLUB_DEBUG

But, again, this causes unmet dependency if SLUB=n





> +       default y
> +       help
> +         Enable page poisoning and slub poisoning by default.
> +
>  config INIT_ALL_STACK
>         bool "Initialize all stack"
>         depends on INIT_ALL_MEMORY
> --
> 2.21.0.360.g471c308f928-goog
>


--
Best Regards
Masahiro Yamada
