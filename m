Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B939FC1550C
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A4164F45
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 00:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCCX7r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 18:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347434AbhCCPTn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Mar 2021 10:19:43 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A9C061763
        for <linux-security-module@vger.kernel.org>; Wed,  3 Mar 2021 07:18:45 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v5so37637848lft.13
        for <linux-security-module@vger.kernel.org>; Wed, 03 Mar 2021 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1EgmR4iNgHLIiSmovii//tHLOrgOuYElC0B+L466FE=;
        b=MeXdy5ELJ8KysVIcMymUJ6XoMIVkBzMk/q9/3VqZ9qXhae+QwDzQD6/d6JAYsLZiKg
         Im7F7MfmsqLrmn+e/eoDa/PWyQqlsSlWGOfe4WYjNTxocdmJA3Z9RDkOQVlReDlMdiIH
         zrDGzNjqqgB/3ihvoEhRlQMEV+3Q87FFBsqe2IuvBH95gSru/Lq/aexiN6BjshpEHRl2
         7P0qttdG7VTVNmtPtOR5baaYS1vZp7PAKYPWag4ascvIh4+NgjbGxVCFMckDz0nxvZqv
         cAbUfMr/ejIBgtC83hLMGHP5TfstRhDcjbRtdyDtRaFqEZ6vAevN2vgRDLDGM4Cifqyd
         ubYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1EgmR4iNgHLIiSmovii//tHLOrgOuYElC0B+L466FE=;
        b=PNDiG2Q6I/680XnCQYqCgqSVa4ea3QyaBmH0Thkkm/w2T0dzK83lClj2j1Dc4HDmPt
         ssWOcdNHyMkCJjs4VMSpu35Cnnm9wIZ0IcVEXvnDSke0BViZs/7I2GP3PRbjK143+tz1
         KH98c9sB2GJKE8wjxdSwhoecVDJOtXz1boPbqlHS3t/qO+BDUdbe7tZflol9Vg2I8hiZ
         P2FYR/+i04MvALwH/B1Gq/e6XUqFLY6jpUJkwHZXEXY452Nsbrk996Idb5VcbQ5+1up9
         SmZjbUOvF2JaKdM1ywtHD1B6z7XolK2Ss3RROZUAG8VQUC9LQd23cv/uAr+W1+77qmhv
         e9ug==
X-Gm-Message-State: AOAM532aHdjGkuEAKzeBeqlOpwqAKgnf33aYGqgUcX1kwpLAMaQkBRco
        Aymo6IrKILuKK4Tw+qpVEJaig6XBrJ1comD+HZT12w==
X-Google-Smtp-Source: ABdhPJxWs0EKhEU3+cXlcQKVKJwnoA45aO7AE9vyg48ZK4GwVXG4V6ruO9zr58sUevEavcdfJhR6bEvR0hrBBVCLWxw=
X-Received: by 2002:a19:548:: with SMTP id 69mr13152043lff.465.1614784724064;
 Wed, 03 Mar 2021 07:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20210219201852.3213914-1-jiancai@google.com> <20210219230841.875875-1-jiancai@google.com>
 <20210222115816.GA8605@willie-the-truck> <CA+SOCLJVGJSn67VU24wPDdsOVeHhGe+KO5ekOCusano=bhn1Mg@mail.gmail.com>
 <20210223100453.GB10254@willie-the-truck>
In-Reply-To: <20210223100453.GB10254@willie-the-truck>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 16:18:32 +0100
Message-ID: <CACRpkdYaSEb8bAztR-s_K17K+Zqusiofwa_dSjz-cwM2+N=57A@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: Implement SLS mitigation
To:     Will Deacon <will@kernel.org>
Cc:     Jian Cai <jiancai@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 23, 2021 at 11:05 AM Will Deacon <will@kernel.org> wrote:
> On Mon, Feb 22, 2021 at 01:50:06PM -0800, Jian Cai wrote:
> > I am not sure if there are any plans to protect assembly code and I
> > will leave it to the Arm folks since they know a whole lot better. But
> > even without that part, we should still have better protection,
> > especially when overhead does not look too bad: I did some preliminary
> > experiments on ChromeOS, code size of vmlinux increased 3%, and there
> > were no noticeable changes to run-time performance of the benchmarks I
> > used.
>
> If the mitigation is required, I'm not sure I see a lot of point in only
> doing a half-baked job of it. It feels a bit like a box-ticking exercise,
> in which case any overhead is too much.

I wrote some suggestions on follow-ups in my reply, and I can
help out doing some of the patches, I think.

Since ARM32 RET is mov pc, <>
git grep 'mov.*pc,' | wc -l gives 93 sites in arch/arm.
I suppose these need to come out:

mov pc, lr
dsb(nsh);
isb();

As ARM32 doesn't have sb my idea is to make a macro
"sb" that resolves to dsb/isb when this is enabled and then
we could start patching all the assembly users with that as
well. I need the Kconfig symbol from this patch though.

I also suggest selecting this mitigation as part of
HARDEN_BRANCH_PREDICTOR, by the token that either
you want all of them or none of them.

Yours,
Linus Walleij
