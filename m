Return-Path: <SRS0=2koH=SH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129FC4360F
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8654121852
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqoXuF/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfDEOAR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:00:17 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39317 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbfDEOAR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Apr 2019 10:00:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id g127so3538233vsd.6
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2019 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XWbFfbwXDUh9HzwsjjSuBYocWfNAzfzS0o/h2xYGUCk=;
        b=PqoXuF/GMB6StDcMhaIbQnOQ4u/pDmnJ0aBbH4QUkW691QPc7mBilCg/9vSXNRSqGI
         TCmrvAttG7EYKisDfwYk2UHHBjHbnz2vvkgY5dmNh+JJfpoP8IkXZXULl3LF9pEsDPad
         vvgTv41L7GMIdmCvxzHxEfUbH6976gGPZMSwNAg7fRXA2B2Ez6AiVUwiPpAukkJ+NqRs
         jddCDqEc+KBpZMyuvAbNZE8ugeCfmWN3R8KUA5lO2OV5XJ5rn336uDi9QtaMa6MjLdKt
         bLbEGrZOB9H6UaoDb4qCnmScA1oVs8pWTdrKH5W4aiPxmoHCawIKGEHreDfvUAu41No+
         fezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XWbFfbwXDUh9HzwsjjSuBYocWfNAzfzS0o/h2xYGUCk=;
        b=c1WoOjSGGSSewQXqjfrijSme/hAZMG9rv+lZxcg2kI4SGrZkgfg4iN4n2IX00lsVfw
         CcIsHPI9YAsRmFwxfZ/SDITuTjD1elFYodfDqo6gQmM4lZRa8fbG3PRCEX1SXbXnEShR
         q5ND+lIDVPFDaGeT+bcW2K4A2i7A1bEM84BVhXjcHLu/ksfducl0B1cH606Vtbf5kue4
         A93HxqQftadmPZY/inKcwZh340tL10KcO94NtTBYx6m9J73Blz53DJtn9/0Eg6cvd5P5
         01FU/idYDERnAgBscg6j3C7MwmPeIgoNRh94WaJcuFi9mrqE1axiPGYgfDgX7WKDeZoj
         iMJA==
X-Gm-Message-State: APjAAAVEvjNousVGIN1gGHIqhMc/sfR/HnwuToMdIa43oHfp+wZ8mrT9
        n6gNW5l1msqNk1/0tkF7er86s6j3CxUiTvoyYFy5UQ==
X-Google-Smtp-Source: APXvYqwyYIVaHjgIS2rBYvxm/IzCTBxbRSYQqrHVnVODInNKOwu47jTQyDICFuZsrzVzKK/qqqIFFE2upobo9QRe84U=
X-Received: by 2002:a67:7d8e:: with SMTP id y136mr8311062vsc.147.1554472816025;
 Fri, 05 Apr 2019 07:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190308132701.133598-1-glider@google.com> <20190308132701.133598-3-glider@google.com>
 <CAK7LNARV+_RNE4E5H37e9wH6iPyrzqsLtcWd0wLSt+vsEvncRA@mail.gmail.com>
In-Reply-To: <CAK7LNARV+_RNE4E5H37e9wH6iPyrzqsLtcWd0wLSt+vsEvncRA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 5 Apr 2019 16:00:05 +0200
Message-ID: <CAG_fn=X1CJ6+1rHeHLUjJmXYPLbOL8_2sSrFBv+oxpMvw87ACg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
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

On Fri, Apr 5, 2019 at 1:36 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Mar 8, 2019 at 10:27 PM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
> > index 27aec394365e..5ce49663777a 100644
> > --- a/security/Kconfig.initmem
> > +++ b/security/Kconfig.initmem
> > @@ -13,6 +13,17 @@ config INIT_ALL_MEMORY
> >
> >  if INIT_ALL_MEMORY
> >
> > +config INIT_ALL_HEAP
> > +       bool "Initialize all heap"
> > +       depends on INIT_ALL_MEMORY
> > +       select CONFIG_PAGE_POISONING
> > +       select CONFIG_PAGE_POISONING_NO_SANITY
> > +       select CONFIG_PAGE_POISONING_ZERO
> > +       select CONFIG_SLUB_DEBUG
>
> This should like follows (no CONFIG_ prefix):
>
>          select PAGE_POISONING
>          select PAGE_POISONING_NO_SANITY
>          select PAGE_POISONING_ZERO
>          select SLUB_DEBUG
Thanks!
> But, again, this causes unmet dependency if SLUB=3Dn
          select SLUB_DEBUG if SLUB
seems to help. Guess it's better than making CONFIG_INIT_ALL_HEAP
depend on SLUB.
>
>
>
>
> > +       default y
> > +       help
> > +         Enable page poisoning and slub poisoning by default.
> > +
> >  config INIT_ALL_STACK
> >         bool "Initialize all stack"
> >         depends on INIT_ALL_MEMORY
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
