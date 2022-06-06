Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B64C43334
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jun 2022 19:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiFFTsR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiFFTsQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jun 2022 15:48:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1D595B8
        for <linux-security-module@vger.kernel.org>; Mon,  6 Jun 2022 12:48:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg6so11143622ejb.0
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jun 2022 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DT6839JbDy2yIdEYMFoTCSnqwzHXVdWj4aG9+gbEJ94=;
        b=TD3VNjXXe98Co3b86I6MMAPvAqs7GFH9zK5G2EFMl80w/4jTsLDTJTlvJaPlCJ165s
         hN2+7BnMlwCh8SH5aG2nXEF9n5Jn6LQtN4zAVq5mmshHyYzYyDJZcnSBlQSMRFduucv2
         UlPhDYoxVlqwIbAP7DMLZrAx/ovYm8t7HBN8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DT6839JbDy2yIdEYMFoTCSnqwzHXVdWj4aG9+gbEJ94=;
        b=Xf2VYXzoBbXFT2dwX0oJnSwnHgI6iK1+1F0dZndEi8ywtBozKe1FpRJThO1cVMVneF
         JDu2iEoE4C5dvs9kWZcXhdzOIM7SbIpEMcA2ieiPXJ1FHQ22HueE0VmR+xo7NouPVQB9
         XhsZfsilLRWKGS1uyfDnmZHK06BXpvEuQJfGMHojSLuqtwSSlMml46aecwjzMjuXmMYe
         w5QR12jKpRYF7XJXbANR2CNs0utAlls3wiJ3BguGC6nXeJEuZPa24GX2Trc1s6xBT8Zp
         Vz5cfH71P3u0MpIcOfCj8kOOJOr8diSZzBrs/RhYVhhJYkuGobLraZI6gDUQC+RmsZIS
         rCtQ==
X-Gm-Message-State: AOAM5309Yc92YjIpXGsoU/bXYKTEc2+PfpWjszrsmF5SBsgCEtAj5K/e
        jDV/VIsYFaGvlSH7vl9MyPPsxiaLxjBcOaEX7V0=
X-Google-Smtp-Source: ABdhPJwI0w0i32D1kMTxyq6N/KB1pQKR5WknTrSqxg5+AWylb+kHSxmrfEmhsJU8V2+yHWjeQdSomg==
X-Received: by 2002:a17:907:a422:b0:705:e944:fd3e with SMTP id sg34-20020a170907a42200b00705e944fd3emr22382553ejc.309.1654544893325;
        Mon, 06 Jun 2022 12:48:13 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id l15-20020aa7c3cf000000b0042bdb6a3602sm8843080edr.69.2022.06.06.12.48.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 12:48:12 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h5so21261900wrb.0
        for <linux-security-module@vger.kernel.org>; Mon, 06 Jun 2022 12:48:11 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr23878066wrf.193.1654544891292; Mon, 06
 Jun 2022 12:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org> <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org> <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
 <266e648a-c537-66bc-455b-37105567c942@canonical.com>
In-Reply-To: <266e648a-c537-66bc-455b-37105567c942@canonical.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Jun 2022 12:47:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+C9XYbu59vuBv1Z9KHd7_tQN_Skd6xzrM512hFJq5aw@mail.gmail.com>
Message-ID: <CAHk-=wi+C9XYbu59vuBv1Z9KHd7_tQN_Skd6xzrM512hFJq5aw@mail.gmail.com>
Subject: Re: Linux 5.18-rc4
To:     John Johansen <john.johansen@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, gwml@vger.gnuweeb.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 6, 2022 at 12:19 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> > I suspect that part is that both Apparmor and IPC use the idr local lock.
>
> bingo,
>
> apparmor moved its secids allocation from a custom radix tree to idr in
>
>   99cc45e48678 apparmor: Use an IDR to allocate apparmor secids
>
> and ipc is using the idr for its id allocation as well

The thing is, I'm not entirely convinced you can deadlock on a local lock.

A local lock is per-cpu, so one CPU holding that lock won't actually
block another CPU holding it. Even on RT, I think.

I *think* local locks are useful for lockdep not because of any lock
chains they introduce, but because of how lockdep catches irq mis-use
(where they *can* deadlock).

But I may be entirely wrong, and maybe that lock chain through the
local lock actually does matter.

Let's bring in people who actually know what they are doing, rather
than my wild speculation. Thomas?

                    Linus
