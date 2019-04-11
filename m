Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A0AC10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 08:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A08521841
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 08:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKE/Eny0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfDKIje (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:39:34 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38795 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfDKIjd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 04:39:33 -0400
Received: by mail-vk1-f196.google.com with SMTP id h71so1193513vkf.5
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H+mNETsQSuKlK2zprS5n1cDbQ8ByYlEoMREK54RdrAs=;
        b=DKE/Eny0btxPrxJaCsUr/VohgFIUe0du5ACOIrCQRCir0UB1qQyeq41qbUOWybpqUu
         HSs0fiXUg1fJ1uUQWHb5zMvSH/WpU/tt7FsVBsOhjTPfU5mrVamCNtTy07OkFOAFdtSJ
         RKnLVBacHRBoDFIs6Klc1a++b8sq90t64kDcqmflBEu4fDgKytDyxZR8OKjLKuZusOJQ
         1+P+NynxFuIW60XrucSPrWD6FicxdKlyKqQmmx52nShZZnJCiP8rLkvI2q5CCandeuy4
         2pMfI2nSzin0bjMzz+nWmkxlDI+UPatmUhQnhlSpKoGa0xXu6HKjeQ+dfUt5rOwwigQS
         d35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H+mNETsQSuKlK2zprS5n1cDbQ8ByYlEoMREK54RdrAs=;
        b=Ow4zfDBJA5n/SlFGGtQYO1kyRZZgGac9mFXrG4QVSPOQjPSLrjOKbN++NUpMu1j3DM
         6V2/wq9aERoPMFln7KecORr3WmiIfO/W6ERAMN87WesU5ZNuvWIk6Fb9/rVtNTY3dfZz
         sb7vXXBGlFuB2tEkVEBXyi+P8Ja5071MnxaBfgCBYTBzeq6gv1x39JdCYLWTrUvGwsGG
         5vbP5tr+3P3RmLosbc5QWtf46pup2kT6auS3qMlUdIimzE5AGV3IrjBJibtONr+kGW5m
         RSXPZ60LIO0do4XQopnWYNnvmiSheBiuNeyKKXVSAW+0IvgM+ednJyTGbhFy4wx9/phc
         7uZQ==
X-Gm-Message-State: APjAAAXqmL0efP/iT9Pc06u9MBe/HRUoOfqZkhNbWXaYTZdMbIg2c8o3
        uWLlCoWc50XfXxHm8W27jRE9xmiYXNEHjP+x9kbhgQ==
X-Google-Smtp-Source: APXvYqwQKGHe3SMF+GEc1x3iRT589EsVL8/HAqOSA+xK5goTbev7jYb0uXyhu8May2Ay3PafECaM8PolyXJnYLbd4UY=
X-Received: by 2002:ac5:c2cb:: with SMTP id i11mr26261054vkk.51.1554971972532;
 Thu, 11 Apr 2019 01:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190410131726.250295-1-glider@google.com> <20190410131726.250295-3-glider@google.com>
 <CAGXu5jJt3uNWVXDD=GR6oVwn=g7O=Jcz9sxai5q10X9yyR56XA@mail.gmail.com>
In-Reply-To: <CAGXu5jJt3uNWVXDD=GR6oVwn=g7O=Jcz9sxai5q10X9yyR56XA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 11 Apr 2019 10:39:20 +0200
Message-ID: <CAG_fn=Vkod40bxxP8PU-+zXs2u4arqAB_bYxqei1bb_tgsg8GA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] initmem: introduce CONFIG_INIT_ALL_HEAP
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
        Laura Abbott <labbott@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 6:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 10, 2019 at 6:18 AM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > This config option adds the possibility to initialize newly allocated
> > pages and heap objects with a 0xAA pattern.
> > There's already a number of places where allocations are initialized
> > based on the presence of __GFP_ZERO flag. We just change this code so
> > that under CONFIG_INIT_ALL_HEAP these allocations are always initialize=
d
> > with either 0x00 or 0xAA depending on the __GFP_ZERO.
>
> Why not just make __GFP_ZERO unconditional instead? This looks like
> it'd be simpler and not need arch-specific implementation?
Right, but it would mean we can only initialize with 0x00 pattern.
I believe that for testing purposes a nonzero pattern is better,
because it'll not only assure the execution is deterministic, but will
also uncover logic bugs earlier (see the discussion at
https://reviews.llvm.org/D54604?id=3D174471)
For hardening purposes the pattern shouldn't matter much.

If you think arch-specific code is too much of a trouble, we could
implement clear_page_pattern() using memset() on every architecture,
but allow the user to choose between slow (0xAA) and production (0x00)
modes.
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
