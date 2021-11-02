Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8AFC433FE
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Nov 2021 04:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22F460F58
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Nov 2021 04:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhKBEZq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Nov 2021 00:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhKBEZq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Nov 2021 00:25:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED7C061714
        for <linux-security-module@vger.kernel.org>; Mon,  1 Nov 2021 21:23:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id i26so30829762ljg.7
        for <linux-security-module@vger.kernel.org>; Mon, 01 Nov 2021 21:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOI6QRrV5zRFm8op/6Gd1rEX3NwOtN92NhH17jVxu8Q=;
        b=h2hpRrDEtL2p/0jKnOT1ONm13DydLtzTwK16ZAknZGkNhW/tlObp6XIQd0rp6I341A
         udIAa9pOsmlDUrXTMYgQUcl7ZnA8e0LTW5Af4pzSEIriRhrOdTUbOSj46aJLK2hVIQJz
         gI+p6bpFk2SL46CZy+5Qhjmn1YVMC8AVmA9+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOI6QRrV5zRFm8op/6Gd1rEX3NwOtN92NhH17jVxu8Q=;
        b=SlD9EwKq86ExmpqX/YuthzW5YN34ZismtGQUMgDON2Zfs22Er/H2Lzl4HjD8wkT2IJ
         gKSmG9Rzq+w9w3X0bgC5NyBy5tgILxWTCVwgWT4YjIk4ADUfxKOGEqLTUVhGl58ejcby
         8/u7hovGY/H9zvBDNhXGmIVszEXAdDCk/rxhRtf47y3gsR+m2Q8lGufhxbOVB63pSvB3
         WdFfwpUIsDi3FYlJvSCR80tpi1pbbcYP+lPmBYjP1hMx6dy8hzUnD086nvuXIz0y2G5s
         dcz5c0xilcSfgH3ktn7mMx/qv5q2/KgQq2tOozAhry/sNfiTMeeW38HUy43LQF236F9M
         h1nQ==
X-Gm-Message-State: AOAM530h48SF755KVjheMgpbIp1i1OXVHB+hRun49T7Rg6a+W6Oy1kkp
        6/w3N5+8sRTP9ibRW6l+0vZtVvRkwV6BMPs4
X-Google-Smtp-Source: ABdhPJyOYAM+zlQ8okLg/gQmfz9Evje1C2asn+NxzJSjYGyfgm8FP+a0OwOuA+N1udFjOxk4pPSCyQ==
X-Received: by 2002:a2e:6a09:: with SMTP id f9mr1063137ljc.395.1635826990136;
        Mon, 01 Nov 2021 21:23:10 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w6sm102022ljw.89.2021.11.01.21.23.09
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 21:23:09 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id u11so40415841lfs.1
        for <linux-security-module@vger.kernel.org>; Mon, 01 Nov 2021 21:23:09 -0700 (PDT)
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr32858764lfg.150.1635826989429;
 Mon, 01 Nov 2021 21:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
 <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
 <CAHC9VhS3LfGvuVyXW5ePTQNtQ0KeQ7vz3wLinoZrbGVjU6GuoQ@mail.gmail.com> <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com>
In-Reply-To: <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 21:22:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
Message-ID: <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 1, 2021 at 8:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This follow-up was sufficient. In fact, the original should have been
> sufficient for me.

... and as you saw from the pr-tracker-bot, it's all merged now.

Sorry for missing that part of your original pull request.

            Linus
