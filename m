Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108B2C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 14:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85CC206B5
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 14:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ja5bDYhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgHXOJ0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHXOJZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 10:09:25 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA6C061574
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 07:09:24 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g13so8747601ioo.9
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bA1BV2aseyQF/WzkRQXsks8mi0w91MOj30YomTdhB24=;
        b=ja5bDYhrwnRbhqtcV0+hArCGMnGdzSqsZnKyGRT5k1UJ6WElf/GjM4OZXfddKwvvzm
         aWNZ6AFUkq8/LzdiwGSPGOjVfTOb4+3TJ7ET1YyZp1Zdnod24BL/Sra3SQj1gqE4cvlb
         7QU0pJv/WCuTKoWLToLBqK3d9nWpz/R1RPA7yiC6ko5eWBRA/SLEIuIekew8dqUHOfEs
         /GbP79fBHvXldRjOSv36xwdhJF2LjlICsaoDuvKZSilgvgGVmo6nMlfSK2tr98QDU6z7
         ccrR0wUHcnJB0uD8sb4A5AUXB02vie0m06hkYEraoVRGjxgJ31pfijIQ25dwc6Ox/eH7
         9GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bA1BV2aseyQF/WzkRQXsks8mi0w91MOj30YomTdhB24=;
        b=ZHPuSZ2aqoxw9OrcBqI7Zw9+BGGL5rh3B69HUZ7HM6WerFKuA30Rm+s0NhPdSxB4Tm
         rHw9lnlQEKGUpnuZxmxb4mervZLUr29SMDjLm3ntWdgiNFxJSHBzyqm185uU6s4bmwdq
         DjGt4Wo4NR4xWWqGUcb72NZ9teNWrv72l6vXuw1hf7D0wq3forA0+kBj0rm4LgOF4rYT
         1QefQUyYe1o9I+EQA92DdkEt0Cv7sFJdBDTK6nqt3m3jTuAVrhasFwki8EbXxXXFwJbQ
         4XCLp0nn27ma046JI0eznQsC/Y3QHczK15LbMPmOnGZNLu122TjCtkivEn8+aRl8c7f9
         KE4w==
X-Gm-Message-State: AOAM532zhR9VfoIIwca2vqiGJEP//1ekVSji5AD9hC84FAMkO1+Yog5C
        bLJ+XWZt2pe4fF2DsQrxSqta5TwAyywCoE7QWjpvcA==
X-Google-Smtp-Source: ABdhPJwjelAWzcEn7VzNUk7+Vkp9BFR/nJBH2gLe74ADI/3bVYbtSMs4/T4jOU84m5eRayVGvqGd5Ele60w9x5+iCr0=
X-Received: by 2002:a02:a403:: with SMTP id c3mr5678171jal.102.1598278161040;
 Mon, 24 Aug 2020 07:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200820164753.3256899-1-jackmanb@chromium.org> <202008201435.97CF8296@keescook>
In-Reply-To: <202008201435.97CF8296@keescook>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 24 Aug 2020 16:09:09 +0200
Message-ID: <CA+i-1C0XEuWWRm5nMPWCzEPUao7rp5346Eotpt1A_S3Za3Wysw@mail.gmail.com>
Subject: Re: [RFC] security: replace indirect calls with static calls
To:     Kees Cook <keescook@chromium.org>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, pjt@google.com,
        Jann Horn <jannh@google.com>, peterz@infradead.org,
        rafael.j.wysocki@intel.com, thgarnie@chromium.org,
        KP Singh <kpsingh@google.com>, paul.renauld.epfl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 20 Aug 2020 at 23:46, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Aug 20, 2020 at 06:47:53PM +0200, Brendan Jackman wrote:
> > From: Paul Renauld <renauld@google.com>
> >
> > LSMs have high overhead due to indirect function calls through
> > retpolines. This RPC proposes to replace these with static calls [1]
>
> typo: RFC

Oops, thanks - I also meant to have the [RFC] subject prefix.

>
> > instead.
>
> Yay! :)
>
> > [...]
> > This overhead prevents the adoption of bpf LSM on performance critical
> > systems, and also, in general, slows down all LSMs.
>
> I'd be curious to see other workloads too. (Your measurements are a bit
> synthetic, mostly showing "worst case": one short syscall in a tight
> loop. I'm curious how much performance gain can be had -- we should
> still do it, it'll be a direct performance improvement, but I'm curious
> about "real world" impact too.)
>

Sounds good - I'll gather some more data and get back.

(I would also reiterate what KP said in response
to James: the "worst case" relative indirect call overhead (i.e. the case
where the hook callback does minimal work) is exactly the case we care
about here. If the callback is doing enough work that the indirect call overhead
becomes negligible, that callback is probably anyway too heavyweight for the
use cases that motivated this work).

> > [...]
> > Previously, the code for this hook would have looked like this:
> >
> >       ret = DEFAULT_RET;
> >
> >         for each cb in [A, B, C]:
> >                 ret = cb(args); <--- costly indirect call here
> >                 if ret != 0:
> >                         break;
> >
> >         return ret;
> >
> > Static calls are defined at build time and are initially empty (NOP
> > instructions). When the LSMs are initialized, the slots are filled as
> > follows:
> >
> >  slot idx     content
> >            |-----------|
> >     0      |           |
> >            |-----------|
> >     1      |           |
> >            |-----------|
> >     2      |   call A  | <-- base_slot_idx = 2
> >            |-----------|
> >     3      |   call B  |
> >            |-----------|
> >     4      |   call C  |
> >            |-----------|
> >
> > The generated code will unroll the foreach loop to have a static call for
> > each possible LSM:
> >
> >         ret = DEFAULT_RET;
> >         switch(base_slot_idx):
> >
> >                 case 0:
> >                         NOP
> >                         if ret != 0:
> >                                 break;
> >                         // fallthrough
> >                 case 1:
> >                         NOP
> >                         if ret != 0:
> >                                 break;
> >                         // fallthrough
> >                 case 2:
> >                         ret = A(args); <--- direct call, no retpoline
> >                         if ret != 0:
> >                                 break;
> >                         // fallthrough
> >                 case 3:
> >                         ret = B(args); <--- direct call, no retpoline
> >                         if ret != 0:
> >                                 break;
> >                         // fallthrough
> >
> >                 [...]
> >
> >                 default:
> >                         break;
> >
> >         return ret;
> >
> > A similar logic is applied for void hooks.
> >
> > Why this trick with a switch statement? The table of static call is defined
> > at compile time. The number of hook callbacks that will be defined is
> > unknown at that time, and the table cannot be resized at runtime.  Static
> > calls do not define a conditional execution for a non-void function, so the
> > executed slots must be non-empty.  With this use of the table and the
> > switch, it is possible to jump directly to the first used slot and execute
> > all of the slots after. This essentially makes the entry point of the table
> > dynamic. Instead, it would also be possible to start from 0 and break after
> > the final populated slot, but that would require an additional conditional
> > after each slot.
>
> Instead of just "NOP", having the static branches perform a jump would
> solve this pretty cleanly, yes? Something like:
>
>         ret = DEFAULT_RET;
>
>         ret = A(args); <--- direct call, no retpoline
>         if ret != 0:
>                 goto out;
>
>         ret = B(args); <--- direct call, no retpoline
>         if ret != 0:
>                 goto out;
>
>         goto out;
>         if ret != 0:
>                 goto out;
>
> out:
>         return ret;

Hmm yeah that's a cool idea. This would either need to be implemented
with custom
code-modification logic for the LSM hooks, or we'd need to think of a
way to express it
in a sensible addition to the static_call API. I do wonder if the
latter could take
the form of a generic system for arrays of static calls.

It would also need to handle the fact that IIUC at the moment the last
static_call may be a tail
call, so we'd be patching an existing jump into a jump to a different
target, I don't know if we
can do that atomically.

More research required on my side here, on both points.

 > [...]
> > Signed-off-by: Paul Renauld <renauld@google.com>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> This implies a maintainership chain, with Paul as the sole author. If
> you mean all of you worked on the patch, include Co-developed-by: as
> needed[1].

Yep, this is intentional - Paul is the sole author so far (I suppose
KP's sign-off
is not technically required since he's also at the Google).
