Return-Path: <SRS0=f9NI=R6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD2C4360F
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 20:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08FB2075E
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 20:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L5G8aRe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfC0Up7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:45:59 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45257 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfC0Up4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Mar 2019 16:45:56 -0400
Received: by mail-vk1-f196.google.com with SMTP id v187so3991561vkf.12
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2019 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kq826wvn/TLWGIs6hJHKhv70e9n0vWDj2EknqQ2AxhU=;
        b=L5G8aRe33gqcEZIDdrvBBKq4FXw3xngseYfNGfp/VClVytIBmagSaDHJWwmiop0/uk
         CLKJ3mOqeAM2Q2pWlbTiEqPBkXGXojIYu6tW5KW70890LuYTnS5IPX4dwNZFnHBS01Vz
         ePplaNVlsZWJO//U1H3kJNGvyK1f63HVgvzhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kq826wvn/TLWGIs6hJHKhv70e9n0vWDj2EknqQ2AxhU=;
        b=t2jbDrmeVl4YkoL//+M+YB0WVBBy0PcbHTGENnRTd+oT8qR7ffgXQM/Z8gAXwly0PI
         LCNFyvnjJt9YjueMK0L75fFYuErQ/lFbR5jXZOLaLiTBZN+0zPBoyOg8g7deReseDrIS
         ZWWsqaRHuf0bKapYwtjYdRwLE+Zx1VhCUcHDhcD47TfAQgL6VkORbyPilGEbtU4Etvd7
         IkLlRxG+A+x/lwyhXc+4KYTr748muVDr1EQw9PP6piXvPrtssA5KPMs8cmc1d+Y/oizp
         7G6c5ff3tYGWIFI5+LmSCTFMGeLMCkt+JP5dCgmgLYYKEeZA72ch1FOSr0OjqITnEdlL
         4Fcg==
X-Gm-Message-State: APjAAAXOhAMiBTuVPVCgrFYYdAGY2vMg04sbi3tMewmZXZvYUkg+bSex
        kOrM/mrm9+5DKeTIc+zUNWffH4T0TCk=
X-Google-Smtp-Source: APXvYqzx1FlkVDd+z/DeUZOaeM3WGk3JbwukVokm6utmDUahA7Sot3xUr8wuEfFL+8FoW6fgc6tyTA==
X-Received: by 2002:a1f:a247:: with SMTP id l68mr9318588vke.32.1553719554300;
        Wed, 27 Mar 2019 13:45:54 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id d187sm3755728vsc.17.2019.03.27.13.45.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 13:45:52 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id v187so3991522vkf.12
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2019 13:45:51 -0700 (PDT)
X-Received: by 2002:a1f:3458:: with SMTP id b85mr12458668vka.4.1553719551456;
 Wed, 27 Mar 2019 13:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
 <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org> <alpine.LRH.2.21.1903260607500.13529@namei.org>
 <8811b2e4-28e1-2f01-024b-fb7d0196483f@i-love.sakura.ne.jp>
 <CAGXu5jJZ1H1RFMFBxPsoBW+T17ya+50-d7-31Gr9ciRgpCOaDA@mail.gmail.com> <98289cd2-095a-f0cd-e405-887ecbba0030@i-love.sakura.ne.jp>
In-Reply-To: <98289cd2-095a-f0cd-e405-887ecbba0030@i-love.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Mar 2019 13:45:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKWECKxksJWPpCkBKG+wB26DhYK=nYBpuuoS+Pv9AsNwQ@mail.gmail.com>
Message-ID: <CAGXu5jKWECKxksJWPpCkBKG+wB26DhYK=nYBpuuoS+Pv9AsNwQ@mail.gmail.com>
Subject: Re: Linux 5.1-rc2
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 27, 2019 at 1:30 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/28 4:16, Kees Cook wrote:
> > The part I don't understand is what you've said about TOMOYO being
> > primary and not wanting the others stackable? That kind of goes
> > against the point, but I'm happy to do that if you want it that way.
>
> Automatically enabling multiple legacy major LSMs might result in a confusion like
> Jakub encountered.

The confusion wasn't multiple enabled: it was a change of what was
enabled (due to ignoring the old config). (My very first suggested
patch fixed this...)

> For a few releases from 5.1 (about one year or so?), since
> CONFIG_DEFAULT_SECURITY_* will be ignored after CONFIG_LSM is once defined in
> their kernel configs, I guess that it is better not to enable TOMOYO automatically
> until most people complete migrating from CONFIG_DEFAULT_SECURITY_* to CONFIG_LSM
> and get used to use lsm= kernel command line option rather than security= kernel
> command line option.

It sounds like you want TOMOYO to stay an exclusive LSM? Should we
revert a5e2fe7ede12 ("TOMOYO: Update LSM flags to no longer be
exclusive") instead? (I'm against this idea, but defer to you. I think
it should stay stackable since the goal is to entirely remove the
concept of exclusive LSMs.)

I don't see problems for an exclusive LSM user (AA, SELinux, Smack)
also initializing TOMOYO, though. It should be a no-op. Is there some
situation where this is not true?

The situation you helped me see was that a TOMOYO user with
CONFIG_DEFAULT_SECURITY_TOMOYO would not want to see any exclusive LSM
also initialized, since that may NOT be a no-op.

So, AFAICT, my proposal fixes both Jakub's issue
(CONFIG_DEFAULT_SECURITY_* oldconfig entirely ignored) and Randy's
issue (subset of Jakub's: choosing DAC should mean no legacy major
initializes), and the "TOMOYO user surprised to see an exclusive LSM
also initialized". If you're happy with the proposed change in my
prior email, I'll send it properly to James. If not, what do you see
that needs changing?

Thanks!

-Kees


--
Kees Cook
