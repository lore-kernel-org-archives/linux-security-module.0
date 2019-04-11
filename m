Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF21C10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 17:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5C420818
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 17:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X+MWK/nB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDKRHb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:07:31 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39258 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDKRHb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 13:07:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id g127so3913735vsd.6
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbVhfxmGF0URsGvyR2UkMeD56y0+dvwTkthYL3Uleek=;
        b=X+MWK/nBnYRuHCbAkw7FFJUhs/b+TfhegS9ar0HHGiRvNTE24iJdfV77fs7sYwIhTZ
         7AHrBpobPL1qYM+8x2quOZno9dt9UpqI2l8hmRsmDhe1fOBt6/7WS57SQLr7A8czn+6I
         DKvlexZH15Z1OSRBWpQ565uNRY1P8uBJ+lh2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbVhfxmGF0URsGvyR2UkMeD56y0+dvwTkthYL3Uleek=;
        b=Ilodio8dbMbGWvKnequcu7q144AJ9fn9ngtpCoE3bQFuPgckC/OINdHsMrElqL4Ml+
         7CujQ/nM5ENHu9AMvO1OoRtrsnHrAavV0U8sjyh/sqntBSevr5MDIkDrBiYnc7r+zgJR
         KvKtb/7zaNkDKbOU4Y7L2M8aD0SifQyk1nlapBiwvdXmwbQhgVm8xOiecg10MSycDeuJ
         3goPfQSLF1pBcbViMkkAo181QC8NXek3+uI3M3MqqgMskL17ULNs3NEh8DzM0iIHjdX2
         qsX2Ir8CCcvIngvpCkx29xSG4OxvAsPGDaeJ5/LsbX0gE5QlP+oQPAWg7+I7wRpTNFeW
         5gVg==
X-Gm-Message-State: APjAAAWVEMA4Hg8Kycizm6lUJM+QXG35jphCBk0tlSiIbE1RD0IDZX6P
        VkH8yBsE+9L6onxa/5j665obVqzZCbM=
X-Google-Smtp-Source: APXvYqzFdVNcAG6EDDZM9U0Fq6Mqa7ZFjgRQNXbdc2Xr4FXNh2ElbT+roVrZvSHTUh0UBL4NoM7ueQ==
X-Received: by 2002:a67:efdb:: with SMTP id s27mr13136464vsp.132.1555002449701;
        Thu, 11 Apr 2019 10:07:29 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id r63sm9918697vsc.15.2019.04.11.10.07.26
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:07:26 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id x84so1538429vkd.1
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 10:07:26 -0700 (PDT)
X-Received: by 2002:a1f:ab8d:: with SMTP id u135mr25497993vke.80.1555002445937;
 Thu, 11 Apr 2019 10:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190410161612.18545-1-keescook@chromium.org> <20190410161612.18545-4-keescook@chromium.org>
 <CAK7LNAQpm5Tz_Fo0rSq00emB7BLnfYB-+mwXd9GiMKAqKCfkrA@mail.gmail.com>
In-Reply-To: <CAK7LNAQpm5Tz_Fo0rSq00emB7BLnfYB-+mwXd9GiMKAqKCfkrA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 10:07:14 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJYPO7buixedop=8e_e+Pf-4nmkz-iS3EV5CXC0obKpdA@mail.gmail.com>
Message-ID: <CAGXu5jJYPO7buixedop=8e_e+Pf-4nmkz-iS3EV5CXC0obKpdA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: Implement Clang's stack initialization
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 11, 2019 at 1:06 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Thu, Apr 11, 2019 at 1:16 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > CONFIG_INIT_STACK_ALL turns on stack initialization based on
> > -ftrivial-auto-var-init in Clang builds and on
> > -fplugin-arg-structleak_plugin-byref-all in GCC builds.
>
> Is CONFIG_INIT_STACK_ALL wired up to GCC plugin in any way?
> I could not understand it from the code.

No, it's only available under Clang. Clang is all-or-nothing, and the
GCC plugin has a degrees up to "all passed by reference" which isn't
truly "all" (i.e. Clang will initialize variables that aren't passed
by reference and trigger a compiler warning about being
uninitialized.)

> >  choice
> >         prompt "Initialize kernel stack variables at function entry"
> >         depends on CC_HAS_AUTO_VAR_INIT || GCC_PLUGINS
> > +       default INIT_STACK_ALL if CC_HAS_AUTO_VAR_INIT
>
> Why should this be enabled by default?
> Ins't it a performance regression
> since it inserts instructions in function prologue?

There are very few users of Clang right now (mainly Android), so I
figured it'd be nice to start Clang builds from a "protected by
default" here, especially given Linus's thoughts on making this always
happen[1]. I don't want to do it for GCC yet, since that would likely
come as a huge surprise to everyone else. :) But I'm happy to change
this, of course.

-Kees

[1] https://lkml.kernel.org/r/CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com

--
Kees Cook
