Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A875CC433E6
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 22:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7C064D74
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 22:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhBVW6j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 17:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhBVW6h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 17:58:37 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A29C06178B
        for <linux-security-module@vger.kernel.org>; Mon, 22 Feb 2021 14:57:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k13so29980256ejs.10
        for <linux-security-module@vger.kernel.org>; Mon, 22 Feb 2021 14:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=appB3USc9BYbOHaMaLlCBWgrnFJA97ooreJNgz7Bs+E=;
        b=NCqNpT0Fh4EhH+R6BF38wGXYMzGMo+UXICnd1zIuLwnjVhP3agDg9U0bBLVLtWbhCh
         di98VXZ9z5I5PFVSYrWLmTvH24uCvL7jWxLpC+JkbujBGazWMzzl4FGpxWKm+ZfIpyFe
         GccAnJGvkygmuhZNLEwFV65Sj2a2fZo4qh2SKWQeWpBgjz+EGJVQH/Y+liPFcqUiEndy
         T11iq+EZeoIVXIZQ6Egp5xVJMPGn9XD35fIEwLeG3ESr8MBFV07M/duyP18fbaabsFfq
         SPv38UaRGhO9h7dxtcdrUfxirtyw+jdUizJzvm6RAXckgtpa78iLSv9X/5T1i8mRikJQ
         xP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=appB3USc9BYbOHaMaLlCBWgrnFJA97ooreJNgz7Bs+E=;
        b=i97ohqv8C+cLupLvjHF5PaSv297PCB2iN8krPGciXs0yPdwigxXnGCkP8DGx1+/v/c
         Q876rLFlpWwkpV0BXNI3FCzKlD41Wuo4WxjNWMB97WZxYEN8j4JGR2T5My88N1+4Zyrq
         7k+n7KUIc/kTvRKjZD1/xzL2Ixc/HaEX8B0LCGM7F3OUOSaYJ+6IysXbgrmnOQXdcIlC
         /AlyTxkVoSc+7Vc2LQI9QdDlnTNRNeIsyFtGG7JjNfeCb8eGTFyKmIhEYN0WMov/aDo+
         FHKLP3GczH7sJPV+lut1HPYBk5+STl097H4/DU8f2WFeHIUV2e/X2KZK0c9hb2cQrKcp
         eftw==
X-Gm-Message-State: AOAM532g57QWAcoooU6AG+mE4SMzC0yXctiixNVu8XTwrITz9v4mf2Ed
        rBKc0svoVtzZNvMrP2Dfy42l5yMvNCO+Qsq+1rHETJmzCg==
X-Google-Smtp-Source: ABdhPJwcKQP0hfOsJylOSmtgZYkORZG40bGafGECNzqdPRMMkAZNAS+HZEFKkU6YD2HR7tbtzsHmq9M0OCnjtOV8xeo=
X-Received: by 2002:a17:906:2bd6:: with SMTP id n22mr4857616ejg.91.1614034675929;
 Mon, 22 Feb 2021 14:57:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRkn65jgVW5fTRWOrDe+dXQD-_-BTN+rZ8Kcq5qxFi45Q@mail.gmail.com>
 <CAHk-=wjs1S_63iF509z6-ZJSXbm5rASYYykMAcOLzjP46eYuRQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjs1S_63iF509z6-ZJSXbm5rASYYykMAcOLzjP46eYuRQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Feb 2021 17:57:44 -0500
Message-ID: <CAHC9VhRSYNcaji0E5PhKap0z3Fdszqa5vZy5R3Jdxzr-GtABbA@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Feb 21, 2021 at 8:07 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 15, 2021 at 1:57 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > - Add support for labeling anonymous inodes, and extend this new
> > support to userfaultfd.
>
> I've pulled this, but I just have to note how much I hate the function
> names. "secure inode"? There's nothing particularly secure about the
> resulting inode.
>
> It's gone through the security layer init, that doesn't make it
> "secure". ALL normal inodes go through it, are all those inodes thus
> "secure"? No.
>
> Naming matters, and I think these things are actively mis-named
> implying things that they aren't.

I don't disagree that naming is important, I would only add,
non-sarcastically, that naming is hard (as a coworker likes to remind
me on a regular basis).

My personal take on the "secure" function variant is that it provides
some indication that this is tied to a LSM hook.  For better or worse,
all of the LSM hooks start off with "security_" and most (all?) of the
LSM blob void pointers in various structs throughout the kernel are
named "security".  While arguments can be made about the merits of
that depending on how you define "security", the fact remains that
they are named that way.  If you, or anyone else reading this, has
another suggestion for the function names I'm listening ...

-- 
paul moore
www.paul-moore.com
