Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C29C10F14
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 17:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAFC2084D
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 17:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bpp+zLDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDKR37 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:29:59 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40235 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKR37 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 13:29:59 -0400
Received: by mail-ua1-f68.google.com with SMTP id b8so2297009uaq.7
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bU95QZrmnFmUeLQob16tlouK5Bd9LJa/CSBxkao+cvU=;
        b=bpp+zLDM4zmlKvaOodNvnWi03BrsCbOglVq4PIviVJvoUQYGOMnmsRLm/GOjbh9Yjp
         R4Tu35VOzb5Tg8nWNvMfb52tpZ1TSnvqx5jgafWwsNd6aibu/T5LjztxvtboMBiMe8Lc
         hGY2O/UPOkXRVknjTaJ6A1xh+ZcqsdLtIi1To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bU95QZrmnFmUeLQob16tlouK5Bd9LJa/CSBxkao+cvU=;
        b=bNtvLDbK5cu+5fQ7aor6xDcsHOVxsXEdME0aJloHh5TZJGojfv2WoxdYiS6UDexBbT
         VR1nXg4orVfS7qI73UAkqJVbBIYYWHG6RY25fR1ZSevl5K/h+lAne2DRaA7TNOqt3bUs
         rx+WZ5KVAroR1Ov7Oy6LXLsx0OEihh5tFz6USUPSEBGNPEH6EDoQR5smgSC1XqSJns/s
         yX5k9WnwY6n+H9pKShiIs4I57eY2/EYQfnV6/mSQ8BMPisoZKDxiD7Er3rwnZF3ouMS3
         oMs6Vt5rqa/Tn4RIVH71oDaJwhEfMZku0RYSoYtafrSuwBsZ7lI6YwUtEbXmeMYlhbTv
         oVmw==
X-Gm-Message-State: APjAAAWJpb3A5acfB7zUg6f+tvDwyJJsTKRu5CONTqMNGa/QGtI0Fe/g
        yF3nCgabL9O6uPCOds/F2s5KJIzKOSI=
X-Google-Smtp-Source: APXvYqwg+NgGUvPjELOKx7FLi7YLl89A6y0Ci3g8lR0CUDCuZHLArvRxEHtQxzU9ueuOhWE3ljglag==
X-Received: by 2002:ab0:208d:: with SMTP id r13mr24885621uak.128.1555003797308;
        Thu, 11 Apr 2019 10:29:57 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id w69sm7280175vsc.8.2019.04.11.10.29.55
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:29:56 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id p13so2287466uaa.11
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 10:29:55 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr27717490uah.123.1555003795252;
 Thu, 11 Apr 2019 10:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190410131726.250295-1-glider@google.com> <20190410131726.250295-3-glider@google.com>
 <CAGXu5jJt3uNWVXDD=GR6oVwn=g7O=Jcz9sxai5q10X9yyR56XA@mail.gmail.com> <CAG_fn=Vkod40bxxP8PU-+zXs2u4arqAB_bYxqei1bb_tgsg8GA@mail.gmail.com>
In-Reply-To: <CAG_fn=Vkod40bxxP8PU-+zXs2u4arqAB_bYxqei1bb_tgsg8GA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 10:29:43 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLEGmMVTJEJHFM3z0EVBAryK3x8Uz4K+mMaOJhfuL9Acg@mail.gmail.com>
Message-ID: <CAGXu5jLEGmMVTJEJHFM3z0EVBAryK3x8Uz4K+mMaOJhfuL9Acg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] initmem: introduce CONFIG_INIT_ALL_HEAP
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
        Laura Abbott <labbott@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 11, 2019 at 1:39 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Wed, Apr 10, 2019 at 6:09 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Apr 10, 2019 at 6:18 AM Alexander Potapenko <glider@google.com> wrote:
> > >
> > > This config option adds the possibility to initialize newly allocated
> > > pages and heap objects with a 0xAA pattern.
> > > There's already a number of places where allocations are initialized
> > > based on the presence of __GFP_ZERO flag. We just change this code so
> > > that under CONFIG_INIT_ALL_HEAP these allocations are always initialized
> > > with either 0x00 or 0xAA depending on the __GFP_ZERO.
> >
> > Why not just make __GFP_ZERO unconditional instead? This looks like
> > it'd be simpler and not need arch-specific implementation?
>
> Right, but it would mean we can only initialize with 0x00 pattern.
> I believe that for testing purposes a nonzero pattern is better,

Can it be implemented in a way that isn't arch-specific? I'd really
like to have a general solution that works immediately for all
architectures. (Can't everything just use a memset?)

> because it'll not only assure the execution is deterministic, but will
> also uncover logic bugs earlier (see the discussion at
> https://reviews.llvm.org/D54604?id=174471)
> For hardening purposes the pattern shouldn't matter much.

So, for hardening, it actually does matter but only in certain cases.
On 64-bit, a 0xAA... pointer will have the high bit set, so it'll land
in the non-canonical memory range, which is good. For 32-bit, 0xAA...
will be in userspace (TASK_SIZE is 0xC0000000). In the above URL I see
now that 32-bit pointer init gets 0x000000AA, which is good, but for
heap init, types aren't known. So perhaps use 0x000000AA for 32-bit
and 0xAA... for 64-bit heap init? (0xAA... has stronger properties
since there have been NULL page mapping bypass flaws in the (recent!)
past, so I could see keeping that for 64-bit instead of just using
0-init everywhere.)

> If you think arch-specific code is too much of a trouble, we could
> implement clear_page_pattern() using memset() on every architecture,
> but allow the user to choose between slow (0xAA) and production (0x00)
> modes.

How about 32-bit use 0x00, 64-bit use 0xAA (and provide per-arch
speed-ups with a generic "slow" version for all the other
architectures?)

-Kees

-- 
Kees Cook
