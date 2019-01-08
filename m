Return-Path: <SRS0=cuGm=PQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28582C43387
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jan 2019 21:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C72206C0
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jan 2019 21:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lXYit3oI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfAHVnD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:43:03 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45243 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbfAHVnC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Jan 2019 16:43:02 -0500
Received: by mail-vs1-f68.google.com with SMTP id x28so3431808vsh.12
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jan 2019 13:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Scq86pte8Z5RyR2O4cAO6a/A5LpVDQKkkYRPfFQbRc=;
        b=lXYit3oICRErA1kEeIkG4VZjcFi1gZZI+7oFqZRUIp9+ads9hui++Y6sunTN8lC2Xr
         TWfNCOsBhnHU22K0U3dU2pL8gih8ONEnF6NjUCBXulucT54FF1hvxm4Cc6/rBM5JU/o+
         loVJ95YxjRJKyoAnaWkpBn7xCS4oNZTpzlufg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Scq86pte8Z5RyR2O4cAO6a/A5LpVDQKkkYRPfFQbRc=;
        b=oxjfSH3zLM/9ymBvfZxQm+GHNYw46EWdw2b3/CFJbj1ieeVfYyVfd/wvvs9eXohcwz
         fu8L3mRK50w6bfbvGJ8Gs+euXZTlBFc5CCf9e8U6aTvUD2O3wxzhcYhjjGHbAjnTU2jc
         E2fdOvRrnCV/5sIy6vLPRqVNM0E7keT8IV2KrMsTmdSlFVHzJc372h1HEGGF23uSUbVJ
         n0SdpXUc6LMds9MK0zkJFlrt8HHltNPw0O6GNu3xAW0gXYiBlDTsFYH/aLwpYP3SdZY1
         2EFnYbHm1SAE3v4RwobKV48E1wRX6FmcymVZjDhmuEXtuEsTYMfgRieXKgZMX0Lv2gEh
         zLFg==
X-Gm-Message-State: AJcUukdoY8sPEEtKL822JVr8zhkzE9wFGtZKL9b+TtzlaXhDjgPM87nr
        wJztCLm4Ig+EucdjLeqIwcB/er/HiWw=
X-Google-Smtp-Source: ALg8bN6yE/eJfnAHtm6Ln4GUtCLaTBbD8rPWNNWgOQHbt6dqhUijPQvSV9GnLD0Rh8mSuPPgNMP1vw==
X-Received: by 2002:a67:fe86:: with SMTP id b6mr1473950vsr.203.1546983781032;
        Tue, 08 Jan 2019 13:43:01 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id i17sm37701066vsg.30.2019.01.08.13.42.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 13:43:00 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id n10so3428451vso.13
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jan 2019 13:42:59 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr1444048vsl.188.1546983779474;
 Tue, 08 Jan 2019 13:42:59 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
 <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
 <alpine.LRH.2.21.1812120556040.11653@namei.org> <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
 <CAGXu5jJOGKAFrFF7HSPnqLpLz0no2Ae_z0TkWPeRt1WWqhqFOA@mail.gmail.com>
 <alpine.LRH.2.21.1901090805121.24546@namei.org> <2cd724a9-3735-1be3-4a42-facb264e70dc@schaufler-ca.com>
In-Reply-To: <2cd724a9-3735-1be3-4a42-facb264e70dc@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 13:42:47 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLQ8z8+oNcT=dTKHewC_bBPa9LuFuS1w1EejYh92vsvXA@mail.gmail.com>
Message-ID: <CAGXu5jLQ8z8+oNcT=dTKHewC_bBPa9LuFuS1w1EejYh92vsvXA@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 8, 2019 at 1:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/8/2019 1:05 PM, James Morris wrote:
> > On Mon, 7 Jan 2019, Kees Cook wrote:
> >
> >> On Tue, Dec 11, 2018 at 1:19 PM Kees Cook <keescook@chromium.org> wrote:
> >>> On Tue, Dec 11, 2018 at 10:57 AM James Morris <jmorris@namei.org> wrote:
> >>>> On Tue, 4 Dec 2018, Kees Cook wrote:
> >>>>
> >>>>> On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>>> v5: Include Kees Cook's rework of the lsm command
> >>>>>>     line interface. Stacking is not conditional.
> >>>>> Can you resend this series with corrected "From:" lines in the body, etc?
> >>>>>
> >>>>> Beyond that, I obviously like it. James, what's needed for this to move forward?
> >>>> If there are no outstanding issues, I plan to merge this for 4.21.
> >>> Yeah, it looks good to me. (Excepting getting the authorship sorted.)
> >> I didn't see this actually get merged? Was there something that needed
> >> fixing? Should I send you a direct pull request for v5.1?
> > Yep, please send a new pull request.
>
> Do you want it as is or rebased on 5.0-rc1?

I've rebased to 5.0-rc1, did some light (re)testing, and sent a pull request...

-- 
Kees Cook
