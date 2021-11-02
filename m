Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48782C433F5
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Nov 2021 00:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D5761051
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Nov 2021 00:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhKBArd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBArd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Nov 2021 20:47:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21190C061764
        for <linux-security-module@vger.kernel.org>; Mon,  1 Nov 2021 17:44:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y8so3512706ljm.4
        for <linux-security-module@vger.kernel.org>; Mon, 01 Nov 2021 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wp3R+DkLsT+T3YFoaJRIQIAYG7GAntJAXplDMUWd84=;
        b=QtBmRWZR83NCW2csJHPlbE12FMx+9r1wlUflS7a1ivTNjOWkmht93vyMN+4cUmk7xz
         fI++ujKaX5Xmgic2PeRnf55VSeBcdPabRbOfUKwhlS8puywYcn5QxRXi0dM7BDOc4MG1
         S4lO208Qp7TtLEtNczYjepazrKZhJCYWvruSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wp3R+DkLsT+T3YFoaJRIQIAYG7GAntJAXplDMUWd84=;
        b=n/Wc2JsKMYtIZxHbFLTKG6HzVHQv/DCLtxU+VhPZruPZImm+DwJA4nUPzME1/Zagsp
         yZ5BDzcuL7F8wCKs5zOfsSl6CUTJenkjUdAirabruK1CNpgdpbzqOSuVcOc4wLtsIrYA
         buK0lZxdaJqDuIr4Y3sNXPM+ttksqeal/Chl90gCJo51AzdnGclcE3fxk5ID6KJR8MyN
         f4a99hbgM/aGv3QgtkEDpGgjvI/wy7sxmg+oJpFk3uz6hWrhGUrjR5TUpcn8rRdVwEv0
         Wpk2wXQmbUH/ydpkYahITIt2x9tvFEkQ3a6EyXCmuoCqO3mb/NXlFdDNVW+c4kyCwE9Z
         2vSA==
X-Gm-Message-State: AOAM531yL1rpUSAikr5jpjiOZcpxXL8wxB2/pXFX8GK4rKdZFIcynUgR
        QTMgtvoT0sYDqrn/uOWSUE6Cn1up3BtXD80C
X-Google-Smtp-Source: ABdhPJygXbm7A4T6/ONvHOJGKA6TvFREk+WbHdcP4t5X+erJkV0FZD/2y52dAKiDE0MU+zf0X0tu3g==
X-Received: by 2002:a05:651c:38c:: with SMTP id e12mr34576329ljp.292.1635813896510;
        Mon, 01 Nov 2021 17:44:56 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c7sm540953lfr.71.2021.11.01.17.44.55
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 17:44:55 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h11so32151575ljk.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Nov 2021 17:44:55 -0700 (PDT)
X-Received: by 2002:a05:651c:17a6:: with SMTP id bn38mr34106005ljb.56.1635813895143;
 Mon, 01 Nov 2021 17:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
In-Reply-To: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 17:44:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
Message-ID: <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 1, 2021 at 4:59 PM Paul Moore <paul@paul-moore.com> wrote:
>
> - Add LSM/SELinux/Smack controls and auditing for io-uring.

I started doing the merge resolution, and then I noted that there is
no sign that this has been discussed with the io_uring developers at
all.

Maybe there have been extensive discussions. I wouldn't know. There's
no acks, no links, no nothing in the commit messages.

So I ended up deciding not to pull at all after all.

You really can't just decide "let's add random audit hooks to this"
without talking to the maintainers.

And if you _did_ talk to maintainers, and got the go-ahead, why is
there absolutely zero sign of that in the commits?

              Linus
