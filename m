Return-Path: <SRS0=dEQQ=WA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C05C19759
	for <linux-security-module@archiver.kernel.org>; Sun,  4 Aug 2019 17:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2F4206C1
	for <linux-security-module@archiver.kernel.org>; Sun,  4 Aug 2019 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564938490;
	bh=McJvKzXg7EOeeoTvWtcJ97DUI77ndntXv4DbFlzZrEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SPI5XdUq+w+2CxpHE6UEwzHL8PRsgviztKSAQPAujtkqMzw+XUiSC5gc1zAfThP/P
	 Ovkn9uql18W26I2Neb4Mu2hyDryKmVoZLONZo6uUmiheooCXqxYcnfOni7xziAcCBk
	 qYUkqd5Ha5OxGhKguZKOEcGVfL+a9QbFllUsW+FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfHDRHu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 4 Aug 2019 13:07:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37123 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfHDRHu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 4 Aug 2019 13:07:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so56136522lfh.4
        for <linux-security-module@vger.kernel.org>; Sun, 04 Aug 2019 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUuLjrr40eT0gT47Sq8V20yAh9inQI6F3hRPfWbEWq0=;
        b=XeKH/ON5ROKLw3AJirLwmiogg5d1JvAm75RUEeKG5SkDjhF6N0JWHG3O3I5DpwH5FA
         MK1gNT5J/NY4V4dy0S/wA+wt5FyyqfPZXGPH8ve2T2siAq/pL5Tq2KgGfuDP4X1Qeo/f
         c/lDfC0MoUMV4Sn7U2QBSmfsiRBwiKHl4fgUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUuLjrr40eT0gT47Sq8V20yAh9inQI6F3hRPfWbEWq0=;
        b=gZIdU1tWJ6rlX1gI76qXZvBaRcLjX1Nj3nmpP/dw8TAVCXavL03Pi2KMD8ZIu0soEe
         aTXAQO1WNNnDWTtU0bi8ZBJNvt3SZIGdHrIfVnmbE8I4ASahXisAiSQguHrGJWPq6JAY
         gWCgtd0PQ7sT1LU2Ot1rzipu576kVfVvhD/vXXAixMWan1TW0z0ZPGwtR6mgQ1JS71ML
         fEW1xl7j+hZj8Z6/OcJ6BbKL7KrD67a13jKj/bv8M5V7NHTJQxoqRfMUDWlVUj9MYMZY
         J55/1yL4Zh/N5EElJBPJ6BcdUHoC9zRVsDeLR6H7zwkrNj+26k08E797ZD5ifCAe8Y/q
         S1kQ==
X-Gm-Message-State: APjAAAU8EFDc7HZLnmIseBo1I8VfJTasr3rlSMGpmuPJN1+XtEMgEh8s
        n5G1cenw44ehAyMGcif1jtNlOBwMJpk=
X-Google-Smtp-Source: APXvYqxKTbQEDmnU8F/g/dpXGkGlPLVyXpTrkUW6ejpoVr0QhvC5HYlAfMWIPut3i2eoTrX4rTm1/Q==
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr55942253lfl.188.1564938468109;
        Sun, 04 Aug 2019 10:07:48 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u9sm14048728lfb.38.2019.08.04.10.07.46
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 10:07:46 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id m23so77133137lje.12
        for <linux-security-module@vger.kernel.org>; Sun, 04 Aug 2019 10:07:46 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr47452082lji.84.1564938466184;
 Sun, 04 Aug 2019 10:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com> <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
In-Reply-To: <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Aug 2019 10:07:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTOTAW5a4AcCfzRQihd2bNWvYtnqOmXc1QLfN=ZL1fUA@mail.gmail.com>
Message-ID: <CAHk-=wgTOTAW5a4AcCfzRQihd2bNWvYtnqOmXc1QLfN=ZL1fUA@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 1, 2019 at 11:11 AM Micah Morton <mortonm@chromium.org> wrote:
>
> Add entry in MAINTAINERS file for SafeSetID LSM.

So I've pulled this now.

However, I have to say that I'm now very nervous about future pulls,
simply because the last one had basically everything that can be wrong
be wrong.

Random rebasing of existing commits, a random merge with no sane merge
message.. All complete no-no's.

So I will have to remember to be careful when pulling from you, and
you need to get into a habit of not doing those things.

One very powerful git tool is "gitk". It's just a good idea to use it
to *visualize* to yourself what it is you actually have. Do something
like

    git fetch linus   (or "upstream" or "origin" or whatever your
remote branch for my tree is called)
    gitk linus/master..

which should show you very clearly what you have that is not in my
tree, and should show any odd merges etc.

Just doing "git diff" doesn't show garbage _history_, it only shows
the differences between the two states. There can be crazy bad history
that doesn't show up in the diff, exactly because you had duplicate
commits or something like that.

             Linus
