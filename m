Return-Path: <SRS0=KU/V=SK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC4C10F13
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E088A20879
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXbEmyxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfDHRjp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:39:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33726 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfDHRjp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Apr 2019 13:39:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id e5so11208468oii.0
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2019 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WozGhqKUqua5KrlkGY6Ygf16R0x9CKfFPoN4BtTrUUU=;
        b=pXbEmyxvYbfbKrwa+vil7482EPIheE/6h3oee7vG63LS2HoB21998E0fgxMsct01AU
         MPM+NA/q1W7m3WFe//GjWGO9Ox8YhpOzxTAwuMrv19GsfwWFF6cZGO3DCWpFA9g1Flg/
         X2qX1HuDXhGbZUphQASRApJQOBXolO+VufAEE40znwKLHoXvj29To0GaKOmMo3exU3K/
         CLIipbQFY4gc6s/UyyNObXhMNmEYSiUlBjXAzJcfCrxI50RGEBZw92WmytrOeYSB6gWN
         L00Ns9PnHH8yIMzGXHWcULgT6nJlL7L8WGlpumW4YpWeR9r9io9RIobVW+2NK8njGiYB
         mJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WozGhqKUqua5KrlkGY6Ygf16R0x9CKfFPoN4BtTrUUU=;
        b=G3I/OnvpVQpXtFjfgQwRu4fbVBm3LHYMzfgM8iblpNW8Dr2dbqlDMNTdksS+mfssRP
         Ad+TeRl3RN5MxZIkNcRoYAq/O+TQFuumg2PbHAcR4bdUysyYR/YB/XxKVCkVtHfDNoN1
         DG/8pZpyUsZSWfSY9q0oI9i1eMKOpVqfguDw67NNwr3mDORspkYpCZjG/0MKFnxAI1m5
         f3wSDzS41jqIr1XeMhV8M7K7Jm9sU5IQfYSp5oLnXiRFLsBn2G4DHf9AUZuDqS8Q9fmQ
         HfIA5LhcYemZGOStVhemHORu1cVaWKQAOUbcYdo5LoaPa0/pPHKMVfm2W49r4Z03YeC/
         swPA==
X-Gm-Message-State: APjAAAXukdu52eVYjxEAjaULKg4647Xqul634mtPBGNQCRJUxYTI2hdg
        fDJJnlFY/YWvZMjOkonRT9juMypw8IM//nx4y6m1vw==
X-Google-Smtp-Source: APXvYqwV+lSXrHXLACqkdNoCd6Fy8hwCUxpMNof1FefgUPQXdFHbeaz1QN4+8PC7MktYbfCLJY8Rho96o8TgZGSZvmM=
X-Received: by 2002:aca:bf83:: with SMTP id p125mr7619124oif.47.1554745184212;
 Mon, 08 Apr 2019 10:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190408170418.148554-1-glider@google.com> <20190408170418.148554-3-glider@google.com>
In-Reply-To: <20190408170418.148554-3-glider@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 8 Apr 2019 19:39:18 +0200
Message-ID: <CAG48ez0BJNhfaCJde0UWrNLztsuAKR3QCm+d-j_Qa3R_KDSKHA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
To:     Alexander Potapenko <glider@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>, sspatil@android.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 8, 2019 at 7:20 PM Alexander Potapenko <glider@google.com> wrote:
> This config option enables CONFIG_SLUB_DEBUG and CONFIG_PAGE_POISONING
> without the need to pass any boot parameters.
>
> No performance optimizations are done at the moment to reduce double
> initialization of memory regions.
[...]
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index 21d4f97cb49b..a1985f33f635 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -12,9 +12,14 @@ static bool want_page_poisoning __read_mostly;
>
>  static int __init early_page_poison_param(char *buf)
>  {
> +#ifdef CONFIG_INIT_ALL_HEAP
> +       want_page_poisoning = true;
> +       return 0;
> +#else
>         if (!buf)
>                 return -EINVAL;
>         return strtobool(buf, &want_page_poisoning);
> +#endif
>  }
>  early_param("page_poison", early_page_poison_param);
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 1b08fbcb7e61..00e0197d3f35 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1287,6 +1287,8 @@ static int __init setup_slub_debug(char *str)
>         if (*str == ',')
>                 slub_debug_slabs = str + 1;
>  out:
> +       if (IS_ENABLED(CONFIG_INIT_ALL_HEAP))
> +               slub_debug |= SLAB_POISON;
>         return 1;
>  }

I don't understand how this is supposed to work. As far as I can tell,
the "slub_debug |= SLAB_POISON;" only happens if you actually pass in
a "slub_debug" boot parameter? Same thing for "want_page_poisoning =
true;".

Also, didn't Laura suggest in
https://www.openwall.com/lists/kernel-hardening/2019/04/08/4 that a
different approach might be more sensible to reduce the performance
hit?
