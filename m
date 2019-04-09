Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91309C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5998620883
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 17:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ut1TggDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDIRCB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:02:01 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36136 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIRCB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 13:02:01 -0400
Received: by mail-vs1-f65.google.com with SMTP id n4so10245945vsm.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZyEUkjW8Ay24Vka1ThslbtPf5USl2VxuLGXSQzvxsU=;
        b=Ut1TggDJQUicub65NmTH7IpXHb/UitE4Anib65Cq5Em/I3AThnvxo+tUFNmimTKlDw
         RkeQRFAymH2iIqxNSuMuE4TAR8foqAKWxYHf33e7k7g5Rb8WBZ+GZ/80odXhp3z/FaDj
         ktZy2jQbi6JRjZL3OF+88k0MNhPE6Tru5azTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZyEUkjW8Ay24Vka1ThslbtPf5USl2VxuLGXSQzvxsU=;
        b=mtNPqY12V/D+XKqttyEw9mrmUcEnZOQNCsg7niscPNuFovUq1179Y7uKjNugrfnoRU
         s3zU+OL6Nz6v0QmWe/yN65/JZRpyQEC9zL4ilpSEuWa5sU+y/hTSHiGkjjyWqnlOyM/7
         tu58KtEoN0KBo81ZQrlsy1/fLIYTnY+Eijsio9+P+oWsXNwOopifO9MrCzBq5QsT7wJ3
         7M1vfwwQls9LTFO/omkI9fyKackO49JK8BCk9EPX+UQfya/7HdJedetYicH1V5IQqKMs
         kJ6zSovYzxcwA18wjltfkRZ8tRf544rgy4B/B7i22zz/M9vrLUwmNn3TyszbGaDLYJ2S
         vAog==
X-Gm-Message-State: APjAAAVwxcl35dk+A2vR85N/kwHC90fPBcQVHldcWCbKyxRf58y9mRsU
        mzop6P1glMo6w1chxs+oylZPq33u0aU=
X-Google-Smtp-Source: APXvYqzXefJJPidIxUwlVX5OoYB9MJGkk+zJn5YC+5Lm9V7S63I9g9cFXVFrMjAlRhzTP6HXownhzQ==
X-Received: by 2002:a05:6102:44a:: with SMTP id e10mr20889533vsq.81.1554829319488;
        Tue, 09 Apr 2019 10:01:59 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id x80sm8511276vkd.22.2019.04.09.10.01.58
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:01:58 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id d8so10241012vsp.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 10:01:58 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr20195752vst.30.1554829317605;
 Tue, 09 Apr 2019 10:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190308132701.133598-1-glider@google.com> <20190308132701.133598-3-glider@google.com>
 <497b1201-b2ae-5e0c-d191-ff1830d92fc1@redhat.com> <CAGXu5jJUWKiyW-_ygHpg9rJc7wQ2XTzjH71CtJfdefLu2zZHEg@mail.gmail.com>
 <CAG_fn=WGOCsHZ4stECA9nUBUMCL9SA76QKTy3FifLxmTfsQivg@mail.gmail.com>
In-Reply-To: <CAG_fn=WGOCsHZ4stECA9nUBUMCL9SA76QKTy3FifLxmTfsQivg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 9 Apr 2019 10:01:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+uXoJj6DTOrsK78t7tc8g_bfZDpugV+TBJYTsQOfi49Q@mail.gmail.com>
Message-ID: <CAGXu5j+uXoJj6DTOrsK78t7tc8g_bfZDpugV+TBJYTsQOfi49Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
To:     Alexander Potapenko <glider@google.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 9, 2019 at 1:55 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Apr 8, 2019 at 7:14 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Apr 8, 2019 at 9:43 AM Laura Abbott <labbott@redhat.com> wrote:
> > > I've looked at doing something similar in the past (failing to find
> > > the thread this morning...) and while this will work, it has pretty
> > > serious performance issues. It's not actually the poisoning which
> > > is expensive but that turning on debugging removes the cpu slab
> > > which has significant performance penalties.
> > >
> > > I'd rather go back to the proposal of just poisoning the slab
> > > at alloc/free without using SLAB_POISON.
> >
> > I still agree this would make the most sense. Fundamentally it's not a
> > debugging feature.
> Wasn't it you who suggested using SLAB_POISON in the first round of comments? :)

Sure, if we want to use what we have right now, that's the way to go.
Optimally, I'd like to see it done the way Laura mentioned, but that's
a long road to convince the heap maintainers, etc.

> I actually have a working implementation that piggybacks on existing
> __GFP_ZERO code to initialize page_alloc() and SLUB allocations:
> https://github.com/google/kmsan/commit/4907af529ad525378a0728435c96d3812f71e594
> https://github.com/google/kmsan/commit/69618a9668bcf27700cc5da42eebf8ab50d1f56a
>
> I'd better cook a patch based on that.

I think it's still better to zero at free (this reduces the lifetime
of the data in memory and should make some use-after-tree bugs stand
out more), but we'll need to do something like what you have here for
doing memory tagging anyway, so we likely need both.

> There's also some overhead when allocations are initialized twice (in
> page_alloc() and kmalloc()) or thrice (page_alloc(), kmalloc() and
> e.g. sock_alloc_send_pskb())
> We can introduce another GFP flag explicitly telling the allocator to
> not initialize the memory chunk if we know it'll be initialized by a
> higher level allocator
> (something along the lines of
> https://github.com/google/kmsan/commit/4fc8cff79d868c29688c8a4186e504fda362f6fd)

Agreed.

-- 
Kees Cook
