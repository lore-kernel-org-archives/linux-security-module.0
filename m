Return-Path: <SRS0=f9NI=R6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964B9C4360F
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 21:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A8421738
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 21:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dBlbl/HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfC0Vnz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:43:55 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:35651 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfC0Vnz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Mar 2019 17:43:55 -0400
Received: by mail-vs1-f47.google.com with SMTP id e1so10892977vsp.2
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2019 14:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2H9efyYuxSZyrKK5zpfZ+IOK9WqTnb1AoQmbDeHmHqM=;
        b=dBlbl/HIhfeZzoow57UlUGikPWwoKN6NxQ3pNVIIqU5DThO1MNGYVbrn3M3+dhuCQq
         6ZVZMJzPTWT8a3/EittrmyL5Zd4mrInyCGen2fMY+Q9Znvre8z7pim8aUBS3/LhRaAS9
         ZSPF8MTs1FYoun7ZAQZCLTa3mjw9yiSUZP2cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2H9efyYuxSZyrKK5zpfZ+IOK9WqTnb1AoQmbDeHmHqM=;
        b=tRnaAPxDPBdob4UBMQVCQwa7Nt2l6/TLeThdWO22SCSJN7sdM2fOmAtPla8Mc46MtY
         DsFM8+SI9gnWDpzuS7Wcq4LM1FfG/mnoSGgVzNf/x8aDn2wP4xt9pU5JWgwzo1pLm2X0
         YpRvU6TqQUrF1zn4FbUKU5YH+h4xE0czwr5Ny0/9MAWe62kW34ispHjlo3dKB/8Pj2GS
         TOpXre4VCJEjvFKysXkr58JR2QG4YTLuplWMM09X3exuNo8N2EU9MAxwedzSMXTRol3G
         afJofANDxHpQYKbIoqd869gGyFAURYzX0lnOs1UbRWxIkqds9qxBNpVJ/kF4RxAQdMe6
         Tmfg==
X-Gm-Message-State: APjAAAUJ3l+PMRHbxTS+iDo1CFydZodRIhivOobMsRLbyVj+70VjgC81
        C5VZMdqUDxOr43L54Zjiy8/OXuPek04=
X-Google-Smtp-Source: APXvYqwNOgiWV0i32yZEejpzaOeXlXg/8kMzXUzYUSIWgZLOMp0M8ay7Z9EWqV/aAt85ZGotplV2VQ==
X-Received: by 2002:a05:6102:3c2:: with SMTP id n2mr24032078vsq.41.1553723033414;
        Wed, 27 Mar 2019 14:43:53 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id j8sm4948403vke.1.2019.03.27.14.43.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 14:43:52 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id f22so7202005vso.7
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2019 14:43:51 -0700 (PDT)
X-Received: by 2002:a67:fa94:: with SMTP id f20mr23597542vsq.172.1553723031625;
 Wed, 27 Mar 2019 14:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
 <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org> <alpine.LRH.2.21.1903260607500.13529@namei.org>
 <8811b2e4-28e1-2f01-024b-fb7d0196483f@i-love.sakura.ne.jp>
 <CAGXu5jJZ1H1RFMFBxPsoBW+T17ya+50-d7-31Gr9ciRgpCOaDA@mail.gmail.com>
 <98289cd2-095a-f0cd-e405-887ecbba0030@i-love.sakura.ne.jp>
 <CAGXu5jKWECKxksJWPpCkBKG+wB26DhYK=nYBpuuoS+Pv9AsNwQ@mail.gmail.com> <e1f6f5a6-9fce-2e95-4593-79f1e836bac5@i-love.sakura.ne.jp>
In-Reply-To: <e1f6f5a6-9fce-2e95-4593-79f1e836bac5@i-love.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Mar 2019 14:43:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL0YzgQR_p9otyOX4+00a0i7Tfv9aLqauZFZs4-Kfjakg@mail.gmail.com>
Message-ID: <CAGXu5jL0YzgQR_p9otyOX4+00a0i7Tfv9aLqauZFZs4-Kfjakg@mail.gmail.com>
Subject: Re: Linux 5.1-rc2
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 27, 2019 at 2:05 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/28 5:45, Kees Cook wrote:
> > On Wed, Mar 27, 2019 at 1:30 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2019/03/28 4:16, Kees Cook wrote:
> >>> The part I don't understand is what you've said about TOMOYO being
> >>> primary and not wanting the others stackable? That kind of goes
> >>> against the point, but I'm happy to do that if you want it that way.
> >>
> >> Automatically enabling multiple legacy major LSMs might result in a confusion like
> >> Jakub encountered.
> >
> > The confusion wasn't multiple enabled: it was a change of what was
> > enabled (due to ignoring the old config). (My very first suggested
> > patch fixed this...)
>
> Someone else might get confused when TOMOYO is automatically enabled
> despite they did not specify TOMOYO in lsm= or security= or CONFIG_LSM.
>
> >
> >> For a few releases from 5.1 (about one year or so?), since
> >> CONFIG_DEFAULT_SECURITY_* will be ignored after CONFIG_LSM is once defined in
> >> their kernel configs, I guess that it is better not to enable TOMOYO automatically
> >> until most people complete migrating from CONFIG_DEFAULT_SECURITY_* to CONFIG_LSM
> >> and get used to use lsm= kernel command line option rather than security= kernel
> >> command line option.
> >
> > It sounds like you want TOMOYO to stay an exclusive LSM? Should we
> > revert a5e2fe7ede12 ("TOMOYO: Update LSM flags to no longer be
> > exclusive") instead? (I'm against this idea, but defer to you. I think
> > it should stay stackable since the goal is to entirely remove the
> > concept of exclusive LSMs.)
>
> I never want to revert a5e2fe7ede12. For transition period, I just don't
> want to automatically enable TOMOYO when people did not specify TOMOYO.
>
> >
> > I don't see problems for an exclusive LSM user (AA, SELinux, Smack)
> > also initializing TOMOYO, though. It should be a no-op. Is there some
> > situation where this is not true?
>
> There should be no problem except some TOMOYO messages are printed.

Okay, so I should send my latest version of the patch to James? Or do
you explicitly want TOMOYO removed from all the CONFIG_LSM default
lines except when selected by CONFIG_DEFAULT_SECURITY_TOMOYO? (I worry
the latter will lead to less testing of the stacking.)

-- 
Kees Cook
