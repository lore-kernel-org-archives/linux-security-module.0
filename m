Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286CEC433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Feb 2022 21:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347435AbiBBVJc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiBBVJb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Feb 2022 16:09:31 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3577C061714
        for <linux-security-module@vger.kernel.org>; Wed,  2 Feb 2022 13:09:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k17so379767plk.0
        for <linux-security-module@vger.kernel.org>; Wed, 02 Feb 2022 13:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N/I9lN88woCCUFoo8q3GQ0U+UOLVhyA+KEq79xDhOwQ=;
        b=gy2KhoZlWLVxHSeIlgNS6LXR2Do4lE0fzqAmjllj1apNx5NM03qgdBQOKsPdZMjYmC
         DzR2yPDsHQfDvpcQQde05juXuWh8Az/4jleLh1nFeg7UL+dTeUB7Kvj+n1+XZ5P+AlfZ
         hOXLTDoIBxgMnG4UXHSA4hMy5PGguDk8o1u+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N/I9lN88woCCUFoo8q3GQ0U+UOLVhyA+KEq79xDhOwQ=;
        b=MinxkwlgqcTIeZSZ8JiOfeJKgA9c5/pT5aDo1QD2KQDeTTGrb4idmyAuXpCtORGyT6
         EGTp2yonHw3UOdjSCnYejduIkRdL9h46CA4gjb2qYH/170a08LuX2kout7UNyXEQ4crK
         Edd/qCKTlv/UvxK4zRoGM+tCQ3DJUQX3f0eJDwr/lb6a8wQP/RZYS6XvVgO0IKnlVTWN
         SuuY6NDSV6Rw2q9RWllp/UdCLw2ZdtcNDV+vklnUjmZyPebLTkMpH/UKepm9qms7e8+t
         GeS60VBR5nHd4UopTZEsat394+jPDW3Ej7n+9DkVAbdgqg7PwnuTKHdlU4MxS2EHtHGQ
         QlQw==
X-Gm-Message-State: AOAM532OvPdw0YztbUBEj6x+gbx9505zSQDlAAsTUtbM+dU0D4Qj07EJ
        AC6CyggcqWd1MgW1Z9uxd9qnPfEgEP/JCA==
X-Google-Smtp-Source: ABdhPJwLGGUSXvSqUXoGyNotccNLcNU1es0zC0+QmCFktC8Y7/ncaKyqZeg/GnVbmr6ggTBnd6rZGw==
X-Received: by 2002:a17:902:ec81:: with SMTP id x1mr31734885plg.109.1643836171113;
        Wed, 02 Feb 2022 13:09:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm8158756pfj.148.2022.02.02.13.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:09:30 -0800 (PST)
Date:   Wed, 2 Feb 2022 13:09:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/4] Compiler Attributes: Add Clang's __pass_object_size
Message-ID: <202202021307.75435AF9@keescook>
References: <20220202003033.704951-1-keescook@chromium.org>
 <20220202003033.704951-2-keescook@chromium.org>
 <CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 02, 2022 at 02:11:51AM +0100, Miguel Ojeda wrote:
> On Wed, Feb 2, 2022 at 1:30 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > +/*
> > + * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size
> 
> For attributes that are not supported under all compilers, we have the
> "Optional" lines in the comment. From a quick look in Godbolt,
> `__pass_object_size__` and `__overloadable__` are supported for all
> Clang >= 11 but not GCC/ICC. Thus, could you please add to the
> comment:
> 
>     * Optional: not supported by gcc.
>     * Optional: not supported by icc.
> 
> to those two patches?
> 
> For `__diagnose_as_builtin__`, I only see it on Clang trunk, so I
> assume >= 14, thus could you please add:
> 
>     * Optional: only supported since clang >= 14.
> 
> ?
> 
> Thanks!

Gotcha, I will adjust these.

> > + * The "type" argument should match the __builtin_object_size(p, type) usage.
> 
> This should go above on top of the comment (it is true there is one
> case that does not follow it, but that one has to be cleaned up).
> 
> Also, this bit seems to be explained in the Clang documentation (i.e.
> not kernel-specific). Do you think we need it here?

It's the kind of detail I feel like I might forget a month from now, so
I added it as a bit of a hint. If you think it's too redundant, I can
leave it off.

-- 
Kees Cook
