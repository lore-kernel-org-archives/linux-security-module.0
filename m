Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE0C04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 16:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6272087E
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 16:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dxB5PWDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfEQQNR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 12:13:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41247 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfEQQNR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 12:13:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so3553891plt.8
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m02iPOvo556PAupUnS9qzquFGaL67NVm3EjfgL2dy5A=;
        b=dxB5PWDK5Ubq2UYGrAtUPASDCX1nBouaHJnYPPCDht/KwMlctyK5LwRI6KbDJjVvbI
         HqXHsPePvPX1QWUDr1d9ekMHs0Zj5byZfC4wEAdxVtQcEXr/Wtj5v6/zHjqcimjzICBF
         Yvt8t2d/Y9dZzZnkJh8xnV/qjGuh6UppseOIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m02iPOvo556PAupUnS9qzquFGaL67NVm3EjfgL2dy5A=;
        b=jX8wQ6xF2Ja7i5KHmnm2KrGG9to0/2X+AK9DePucCkOXQbTEQxqYZ6otQmfkbRVgB8
         LKlDe4CDT6a19trz8lUKACGyfdpBHZyrH/0XPhR9i9/9flHzzO3pcxNScuTScggPHT4H
         04NCy2lAfsbzlI8/WjSnpYSpPASwtlGyyRVN+2Fty3JC5FxVPZtLECID8HurYb6TYxse
         Rvprm6PK/Gk1+TATSsrx0kPmMAsstNsj2W6RhNx8Y26+SJzMVLNBm7b/Nh5x7uvU7rCv
         ufAESuczgPAWl93ELyKA9hGXXE2zgM7qJCioigZ5D2lSEXgapC40daGDE1bZLVMwboIo
         gyfw==
X-Gm-Message-State: APjAAAXT/oNC2xxtIVkniggVH7rz9R4pjUQKFbBZ7M+tm+jEe5ql+fBi
        K6e4tKzXFQaEjK5OhQ4UbeoSPA==
X-Google-Smtp-Source: APXvYqzxdYYkC4Vm6qLkhkpXpaHS6hS+/bNgbbir5gqCgNKRQ20zMhl2VQQoGk52iRa1FhEBt45aSg==
X-Received: by 2002:a17:902:8214:: with SMTP id x20mr35601151pln.308.1558109597070;
        Fri, 17 May 2019 09:13:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 37sm13381620pgn.21.2019.05.17.09.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 09:13:16 -0700 (PDT)
Date:   Fri, 17 May 2019 09:13:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] net: apply __GFP_NO_AUTOINIT to AF_UNIX sk_buff
 allocations
Message-ID: <201905170900.BFA80ED@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-5-glider@google.com>
 <201905160923.BD3E530EFC@keescook>
 <201905161714.A53D472D9@keescook>
 <CAG_fn=Vj6Jk_DY_-0+x6EpbsVh+abpEVcjycBhJxeMH3wuy9rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Vj6Jk_DY_-0+x6EpbsVh+abpEVcjycBhJxeMH3wuy9rw@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 17, 2019 at 10:49:03AM +0200, Alexander Potapenko wrote:
> On Fri, May 17, 2019 at 2:26 AM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, May 16, 2019 at 09:53:01AM -0700, Kees Cook wrote:
> > > On Tue, May 14, 2019 at 04:35:37PM +0200, Alexander Potapenko wrote:
> > > > Add sock_alloc_send_pskb_noinit(), which is similar to
> > > > sock_alloc_send_pskb(), but allocates with __GFP_NO_AUTOINIT.
> > > > This helps reduce the slowdown on hackbench in the init_on_alloc mode
> > > > from 6.84% to 3.45%.
> > >
> > > Out of curiosity, why the creation of the new function over adding a
> > > gfp flag argument to sock_alloc_send_pskb() and updating callers? (There
> > > are only 6 callers, and this change already updates 2 of those.)
> > >
> > > > Slowdown for the initialization features compared to init_on_free=0,
> > > > init_on_alloc=0:
> > > >
> > > > hackbench, init_on_free=1:  +7.71% sys time (st.err 0.45%)
> > > > hackbench, init_on_alloc=1: +3.45% sys time (st.err 0.86%)
> >
> > So I've run some of my own wall-clock timings of kernel builds (which
> > should be an pretty big "worst case" situation, and I see much smaller
> > performance changes:
> How many cores were you using? I suspect the numbers may vary a bit
> depending on that.

I was using 4.

> > init_on_alloc=1
> >         Run times: 289.72 286.95 287.87 287.34 287.35
> >         Min: 286.95 Max: 289.72 Mean: 287.85 Std Dev: 0.98
> >                 0.25% faster (within the std dev noise)
> >
> > init_on_free=1
> >         Run times: 303.26 301.44 301.19 301.55 301.39
> >         Min: 301.19 Max: 303.26 Mean: 301.77 Std Dev: 0.75
> >                 4.57% slower
> >
> > init_on_free=1 with the PAX_MEMORY_SANITIZE slabs excluded:
> >         Run times: 299.19 299.85 298.95 298.23 298.64
> >         Min: 298.23 Max: 299.85 Mean: 298.97 Std Dev: 0.55
> >                 3.60% slower
> >
> > So the tuning certainly improved things by 1%. My perf numbers don't
> > show the 24% hit you were seeing at all, though.
> Note that 24% is the _sys_ time slowdown. The wall time slowdown seen
> in this case was 8.34%

Ah! Gotcha. Yeah, seems the impact for init_on_free is pretty
variable. The init_on_alloc appears close to free, though.

-- 
Kees Cook
