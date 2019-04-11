Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0A5C10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 17:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45782084D
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 17:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZeiSLgTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDKRkw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:40:52 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45346 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDKRkw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 13:40:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id o10so3960673vsp.12
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=35rWfMZgmkQO15+1Xqh2bHCrgRPMlpqlp9r2GPs7TUQ=;
        b=ZeiSLgTbq6HS7AzXW9AD/+JzPy/v4mEjRMn3GJxiEXuw2O2ZzSULRW2q8L2asl/HJg
         yXjDiqgTIO361QvKnP1QBdUaYq2TVzLS93QfMHt55H6WjVMZDIdX8dCs1DLxegeheMwM
         RpvGbHSzP0YHncdWwlflgqX/6EAXI+jTQb9fMQsCqIkGuKFdxpAWogOAbEd1hBk7+4Q8
         h3SoertYaZFK6TGIOq4Hphv6uzMSKxQw5HnE/oy89+7sgueVM4ZKv1g+cJKZjsT1TwtI
         Y/3VZLfvL13yxvAP7aEXuRcVnkj/1teF4INg+6FH1MU4cwLMV1Oo5JvupDrdO1OA/FU8
         XcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=35rWfMZgmkQO15+1Xqh2bHCrgRPMlpqlp9r2GPs7TUQ=;
        b=bRwXWxEWu4+kWc54zkHO6zEY/zfg7SDEG4Pj/aK0s9kGRvC/7+4MSqgmLG+gYpTq1U
         e3oGnaHnvWortLY851JPJfvzZt0iuqB+oH4FBR5RGvI6Zy4gjt+1BCHYLpM4RvQWQ82F
         NRrCGSBhK1XodHNc9QKx3g2f1r9aqVXMC2gxuvNqiHXGcneCjS1QBPEQj+YWGO93krdI
         Qk06DCLS9uH+5pkXvpQ5YWCHVJdqmuFPlNz+2R4X4NdQm3uSSpfadBpoHpyFlerhBapy
         j1ZdS/KBeXM/XpDO20KbHDCEceDDEyP2F7j0Bvq8dmFNHUFHaBj5MhGffEkDw/K/4mWX
         W8FQ==
X-Gm-Message-State: APjAAAWrMC6uGddsqEMVKVWnzVIKuP/MwKZ0Lqb9j+brqOZxEd23O84J
        YLnh72qcy7Lj4ZFisficsfxuiS/seu7/5RH8oY1tjQ==
X-Google-Smtp-Source: APXvYqyloErT2Bsk9NCmoYHvTQ/XNXQSXMu19w+aj6lwWPi9ELsaDpxt071GNu6T0mVUdRvweizOrQZci4sS7NdPrCg=
X-Received: by 2002:a67:870a:: with SMTP id j10mr27873925vsd.161.1555004450543;
 Thu, 11 Apr 2019 10:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190410131726.250295-1-glider@google.com> <20190410131726.250295-3-glider@google.com>
 <CAGXu5jJt3uNWVXDD=GR6oVwn=g7O=Jcz9sxai5q10X9yyR56XA@mail.gmail.com>
 <CAG_fn=Vkod40bxxP8PU-+zXs2u4arqAB_bYxqei1bb_tgsg8GA@mail.gmail.com> <CAGXu5jLEGmMVTJEJHFM3z0EVBAryK3x8Uz4K+mMaOJhfuL9Acg@mail.gmail.com>
In-Reply-To: <CAGXu5jLEGmMVTJEJHFM3z0EVBAryK3x8Uz4K+mMaOJhfuL9Acg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 11 Apr 2019 19:40:39 +0200
Message-ID: <CAG_fn=Wc6VBrr=wg4d4kmk9M=9N7DJEJSdSM6DmnVM3YP8GP_g@mail.gmail.com>
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

On Thu, Apr 11, 2019 at 7:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Apr 11, 2019 at 1:39 AM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > On Wed, Apr 10, 2019 at 6:09 PM Kees Cook <keescook@chromium.org> wrote=
:
> > >
> > > On Wed, Apr 10, 2019 at 6:18 AM Alexander Potapenko <glider@google.co=
m> wrote:
> > > >
> > > > This config option adds the possibility to initialize newly allocat=
ed
> > > > pages and heap objects with a 0xAA pattern.
> > > > There's already a number of places where allocations are initialize=
d
> > > > based on the presence of __GFP_ZERO flag. We just change this code =
so
> > > > that under CONFIG_INIT_ALL_HEAP these allocations are always initia=
lized
> > > > with either 0x00 or 0xAA depending on the __GFP_ZERO.
> > >
> > > Why not just make __GFP_ZERO unconditional instead? This looks like
> > > it'd be simpler and not need arch-specific implementation?
> >
> > Right, but it would mean we can only initialize with 0x00 pattern.
> > I believe that for testing purposes a nonzero pattern is better,
>
> Can it be implemented in a way that isn't arch-specific? I'd really
> like to have a general solution that works immediately for all
> architectures. (Can't everything just use a memset?)
>
> > because it'll not only assure the execution is deterministic, but will
> > also uncover logic bugs earlier (see the discussion at
> > https://reviews.llvm.org/D54604?id=3D174471)
> > For hardening purposes the pattern shouldn't matter much.
>
> So, for hardening, it actually does matter but only in certain cases.
> On 64-bit, a 0xAA... pointer will have the high bit set, so it'll land
> in the non-canonical memory range, which is good. For 32-bit, 0xAA...
> will be in userspace (TASK_SIZE is 0xC0000000). In the above URL I see
> now that 32-bit pointer init gets 0x000000AA, which is good, but for
> heap init, types aren't known. So perhaps use 0x000000AA for 32-bit
> and 0xAA... for 64-bit heap init? (0xAA... has stronger properties
> since there have been NULL page mapping bypass flaws in the (recent!)
> past, so I could see keeping that for 64-bit instead of just using
> 0-init everywhere.)
>
> > If you think arch-specific code is too much of a trouble, we could
> > implement clear_page_pattern() using memset() on every architecture,
> > but allow the user to choose between slow (0xAA) and production (0x00)
> > modes.
>
> How about 32-bit use 0x00, 64-bit use 0xAA (and provide per-arch
> speed-ups with a generic "slow" version for all the other
> architectures?)
Might be easier to start with a generic 0x00 version and add
improvements on top of that :)
I'll send an updated patch.
> -Kees
>
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
