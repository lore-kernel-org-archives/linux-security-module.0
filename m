Return-Path: <SRS0=O5tY=3S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51747C33C9E
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Jan 2020 02:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F45E214D8
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Jan 2020 02:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580266307;
	bh=OiH/oj2VycHiKcdQlAsCj5JzWAJneFSpuFK/p3ElhKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PnmpLPtmS6Br28d6fXYPRSD9CoC7Dio9gVoGLjRTNm1m9WSetK615dl6Ik4XpUxy2
	 uayxFUauw9FTv9Jz5hHJpCfrwhbqCSpGvzQ8Ag/PxU4+JryvJFayiAFIf8QWW4wBE2
	 XX+cZrqJcq5yOZeFvYdSnhZIU4i+rWJC3LDhcBr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgA2Cvq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:51:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37879 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgA2Cvq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jan 2020 21:51:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id v17so16838190ljg.4
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2020 18:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEBoHy8/kVU5+VWVHv6c35kU1W4QCWcAErDCF+G6RIc=;
        b=Wzsu0iHQn5RVqXApanAOBm2JoulXNqWvJR6JFfn3pRw2NiSLsmeBw4rh8YvwHZTuPy
         gUwlDOtD5a6Ydokg5wTLQ0pHVHI1wqmVyaIauiIIXbtGgW2YDkvm/xHD8n50V6urz11M
         Q98pBOEBBMf4a3HvN6C1WEojU4Jtcuegij/20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEBoHy8/kVU5+VWVHv6c35kU1W4QCWcAErDCF+G6RIc=;
        b=slDqkIeku6j+sjwdvthzUlCGzySNdmoLIKHad2pTNr9t2sS3z6/FPukF4poKIq9Mmu
         yyiOmOF5rUuDb1AItr1auEBbyeiJFJAODMlW7VaXjh8V2P+0atwdAg7znAszZ1CjF0Vx
         pyrFyPSkkdPxL/3fwOQbMhrCILavIAjetWnQD7cRaNAzBzfN/2JrlayuratQHNnF8t+C
         KahItSlb/0SaKwW3JLsocVMf29desey4ezHWNK8jyNEFxzTZE3V2pzcTVnjWa8zaPANP
         WZpAz21NMMn1LkfRzdyVKpfroA6X5meqFvJuzJwABferOh6VFaSJ1B3APVGdQHAbbloY
         UY0A==
X-Gm-Message-State: APjAAAViNdiZICLn527Dp8BnrmOpo2NeaAYuUV/J+RPaRSjS/OZvh/IJ
        GAocgZyB4myeqUm44Y+uRjvnAQ6IeSI=
X-Google-Smtp-Source: APXvYqwkxqCvjcQWc9+LQ29ehRE2Pk1NW1BJwSgC68eoFfPT5LvjEqCKJKtortGRv74zrxCJr1/uBQ==
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr15191362ljj.14.1580266303745;
        Tue, 28 Jan 2020 18:51:43 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id z19sm263430lfg.26.2020.01.28.18.51.42
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 18:51:42 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id m30so10715232lfp.8
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2020 18:51:42 -0800 (PST)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr4090986lft.192.1580266302409;
 Tue, 28 Jan 2020 18:51:42 -0800 (PST)
MIME-Version: 1.0
References: <cdf30cd3-8b0e-9014-0474-ce978e6bcc3b@i-love.sakura.ne.jp>
In-Reply-To: <cdf30cd3-8b0e-9014-0474-ce978e6bcc3b@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jan 2020 18:51:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg7qXKuB=Pi6wnZT39Cj8yJuKMAtsxv2XB6byzbNFztMg@mail.gmail.com>
Message-ID: <CAHk-=wg7qXKuB=Pi6wnZT39Cj8yJuKMAtsxv2XB6byzbNFztMg@mail.gmail.com>
Subject: Re: [GIT PULL] TOMOYO patches for v5.6
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 27, 2020 at 8:17 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> One "int -> atomic_t" conversion patch for suppressing KCSAN's warning.

The git tree looks fine, and I've pulled, but your pull request was
missing the shortlog and diffstat that I expect (and that "git
request-pull" generates).

                 Linus
