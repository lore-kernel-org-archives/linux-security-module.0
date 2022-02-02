Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09213C433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Feb 2022 21:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbiBBVWZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiBBVWY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Feb 2022 16:22:24 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C355C061714
        for <linux-security-module@vger.kernel.org>; Wed,  2 Feb 2022 13:22:23 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id c15so920370ljf.11
        for <linux-security-module@vger.kernel.org>; Wed, 02 Feb 2022 13:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wuDa52cDIJ8DIOvRv+VwSSr1tZwFekRYSng4dxWGIo=;
        b=RX8WbXQJNzT8YobsQ7pN+17muhyEYapyF2D2WcDwMvaDo1P8HG1Ud8/UakbAkuxVog
         nml3I2ULWZThFrpimwx88tbOp5t7nyYt+43mPTpfKM59rS4+yfOBZMPIeQXQSz2sGGNP
         MqvheDLz/Ol9fUoyLOg9hoJ8QP2B34C6ef97chssdqjHD3VHFA2leoPnsZQA9e2t8GcT
         STAnpYPr+tTgrCIXUncGPiECiNr/RQbOVqqNYdYDvAz+yR+DK99rr01jFDYuARgaVj6d
         LKWEWSGgb2iO8CL0iXqwJRg4xZCy6fWvAY8qZsLIBjKsVELmOFUiobtxr7mCisqVXJ0m
         +JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wuDa52cDIJ8DIOvRv+VwSSr1tZwFekRYSng4dxWGIo=;
        b=5jp/hgC2gkGGdMj1gE3YfMP6j0NLGKLXN3L0kjGjrRBxqDAP+QGvjIFoCJpO4rjxg0
         N6PpwQ55IIowbOYBVAmeOKtimotmGWb7ldyaUSWdGasH+p91VtEqpMmhyINs9ssY4DT0
         1Q10NH6NUDmv2vZQ7SCI/ItCO29Q2+5PojUheiaV1P2SeANKROB24XNfMIDxRRKjwRaP
         mgixkQiKnG3SyZ07qOPaTVrL2E+y/bHg2MsAV1h5zJRU13WLJzLOZfO20O+EIHGAnhUy
         agF7OmS3/VlZ20x10LX7KXfwJu2Tm05A/VV29AEDQZ6vVFx+45+NGpSjRorP87rfmFkb
         LnEQ==
X-Gm-Message-State: AOAM531SwqUVaxFXkebmeaOQL9Q8BmlFPZbstLbM4ZY4CrScAka0sxVj
        BfUOju3NLp9SvqK6JzB9sB9z5z0jtyhczfbXbFEZHg==
X-Google-Smtp-Source: ABdhPJyG5Ks6tJj9Y9UQ16rXkmZ1tEB3sUgYszm3BP1C9UdQ8c+nNKEyd56xb8gMk43byZ/OQvWw4beJKF6O0l/0Xz0=
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr20984195ljc.526.1643836941590;
 Wed, 02 Feb 2022 13:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20220202003033.704951-1-keescook@chromium.org> <20220202003033.704951-5-keescook@chromium.org>
In-Reply-To: <20220202003033.704951-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Feb 2022 13:22:09 -0800
Message-ID: <CAKwvOdm1O+cKn5C86C2cB7hUCupv+Mf0w1d1pcaUNniYvc5jEw@mail.gmail.com>
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -179,7 +179,7 @@ config FORTIFY_SOURCE
>         depends on ARCH_HAS_FORTIFY_SOURCE
>         # https://bugs.llvm.org/show_bug.cgi?id=50322
>         # https://bugs.llvm.org/show_bug.cgi?id=41459
> -       depends on !CC_IS_CLANG
> +       depends on !CC_IS_CLANG || CLANG_VERSION >= 130000

Are these comments still relevant, and is the clang version still correct?

In https://lore.kernel.org/llvm/CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com/
Miguel notes that diagnose_as only exists in clang-14+.  If this
series relies on diagnose_as, then should this version check be for
clang-14+ rather than clang-13+?

https://bugs.llvm.org/show_bug.cgi?id=50322 is still open, but doesn't
signify why there's a version check. It makes sense if there's no
version check, but I'm not sure it's still relevant to this Kconfig
option after your series.

https://bugs.llvm.org/show_bug.cgi?id=41459 was fixed in clang-13, but
it was also backported to the clang 12.0.1 release.  Is it still
relevant if we're gated on diagnose_as from clang-14?

Perhaps a single comment, about the diagnose_as attribute or a link to
https://reviews.llvm.org/rGbc5f2d12cadce765620efc56a1ca815221db47af or
whatever, and updating the version check to be against clang-14 would
be more precise?
-- 
Thanks,
~Nick Desaulniers
