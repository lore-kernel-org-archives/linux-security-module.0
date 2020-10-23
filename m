Return-Path: <SRS0=sNlH=D6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189CC388F9
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Oct 2020 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499F92192A
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Oct 2020 17:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603475883;
	bh=SyoSo3J4ke+4ThtJXuRUjaWCwMN0NTnuNJkXWI/AUVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W2wMQWH3CjB/iUJuFsi4nxXUVvEjP9wv9oCwrG0ogN894HtIQNHo5DGeJpoha52e7
	 dmMn6qyGKODxepdzwZ3oBpNoEjhEY8mPlukj6V/N0YLK9M5RuSKxWG6NHq0TZlO+jm
	 RIOrOi4kZF31uO6lX4OLfwTMgbhZVO4ypMg2Dq0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbgJWR6C (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370201AbgJWR6B (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Oct 2020 13:58:01 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F01C0613CE
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2020 10:58:00 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so3130403lfl.2
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2020 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OND/0ZMqlDSvX9CBDIIXY1Bnl1QNzB/WvdK3N8e5bc=;
        b=J4OytyOSN6yYKcMTq6lD3LKXaUzglar8AQOy3mU8H66JZTZN9U/2mpy/SLnt6doik/
         OBBnUArLrtHD5UVK7Aq9EI4ZihGemkOPAtCAA0wsOWpEjFbOkmALpCir2KcmOiIHOIDE
         FR9LBu9ye+FNEYsajxe2d7pKLF6/61uC+2tz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OND/0ZMqlDSvX9CBDIIXY1Bnl1QNzB/WvdK3N8e5bc=;
        b=haHySZUyZ1IZ4qctDhkgw7TIzXYnDnblXxQ0oOcrwiz9/m6OAgChRazlUTZMCclUm0
         Iv68giQ7mUm5xiJYwMWVA/+KCIsyud8oV51RNySmxlK6tJYzuEJqRFpPtJ/hGhbCryrE
         VG84aSvoR2XZM2eySCO2yNoW8E1mCQ0JZ8D9nOR/ShJrvAN1l05p8vqDbGWX5LOkG5kf
         wbjAomes+Fqf0gJ4YjiWT0ypznoye9bpPlUDPWqBhdTW6Ojo9syOiELyTY/Ve2aBZMBO
         h8ASFqCFNvy+38+CXjrlLZlulPWgkuj63gZKacgaBzUmRzt03KqRWAB2KidgMB0/D2EX
         yzwg==
X-Gm-Message-State: AOAM531SU4gUD9kPIdO/QI4CBACdK6dfz5Z6ZuulVCDv6GazxA2V615j
        kZjpFGpsuRgEDH90A7VKpGalowPVefIhgg==
X-Google-Smtp-Source: ABdhPJwsrJTZUk5f1S49ifWfcwnf07c22+kn1RUhzPORsBNUviSS1+sgRbGfa3XKcq+VsqwVCCfPvQ==
X-Received: by 2002:a19:2408:: with SMTP id k8mr1237581lfk.80.1603475878261;
        Fri, 23 Oct 2020 10:57:58 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 184sm199981lfh.232.2020.10.23.10.57.56
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 10:57:57 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y16so2491124ljk.1
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2020 10:57:56 -0700 (PDT)
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr1269612ljj.371.1603475876643;
 Fri, 23 Oct 2020 10:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
 <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com> <CAJ-EccPLAD5TGg=KQ-m54ymrVdd++Dg7A_UR+v535iOVRsDe4w@mail.gmail.com>
In-Reply-To: <CAJ-EccPLAD5TGg=KQ-m54ymrVdd++Dg7A_UR+v535iOVRsDe4w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 10:57:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_BD0OVHgj09kKgiuwyrth3ora_ZgLznW_q-+z-BR=3w@mail.gmail.com>
Message-ID: <CAHk-=wi_BD0OVHgj09kKgiuwyrth3ora_ZgLznW_q-+z-BR=3w@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 15, 2020 at 5:01 PM Micah Morton <mortonm@chromium.org> wrote:
>
> I just rebased to v5.9 to make sure the 1-line changes that touch
> kernel/capability.c, kernel/groups.c and kernel/sys.c still applied
> cleanly without conflicts. Should I have rebased onto one of the -rc's
> for v5.9 instead?

No. You shouldn't have rebased at all.

Making sure something applies cleanly is simply not a reason to rebase.

See

  Documentation/maintainer/rebasing-and-merging.rst

for some common rules.

             Linus
