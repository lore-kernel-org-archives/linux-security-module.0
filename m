Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0605FC74A5B
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Mar 2023 15:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCQP1z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCQP1y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Mar 2023 11:27:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C692F1C
        for <linux-security-module@vger.kernel.org>; Fri, 17 Mar 2023 08:27:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y20so6975412lfj.2
        for <linux-security-module@vger.kernel.org>; Fri, 17 Mar 2023 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679066872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv5cOEcdxEBmp663aNSEQdflb05PiC21ONlyQB9IU1g=;
        b=Mq/VKKNzWbwpAnIHgBPYSROApket/7Go0yuyT5+Iny5gJVPspQpzMvXOXPwvhlcnuo
         8xhw7C0mmz7InfY0XLFZRRNTKoJPu0Qf1ymibgj2SXPkXBzY+OGHW2RdGoFxX5yo5MO0
         YOw4GlS9xpQsu0/0lU83MPqIzNhOfgQkNIJaz+g0haw+OY7yYwIaO6LKPOTIOTJzo/B0
         N4Y2E/z9tDoY9VfsMyKz293jaFEI9vsbHb3bHV3PLU9qoHMXCpHQM1q9mN8VRDkv5k5p
         Jjz5Ghm0+VQNz8Q5brdvsKKv3KwnOS2YQA8Z2ePUHUElC4eXq6cOoOd6KWrzF2NjFsvn
         gzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679066872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nv5cOEcdxEBmp663aNSEQdflb05PiC21ONlyQB9IU1g=;
        b=UjDFeNuWnvafJV5T70+C8BKIzF+gxZ+q+yNV3o/88o7y7ufsN4qK72M0XPnD1H9s+a
         djtYxs1yNiuUPOcKS/Hgmr8xloyMwWtpik5JHA/pHN247SZXN46U7ywL4uGHUDsX5pZl
         0O6xj1zGzqXdkjT2B+mC6E1GarrnzHbJalR2cLoXhtPzgfBU6UIuMbUcxL4CZgK3OqBm
         Av2jE2ENsToO1bWXvBvHx9vSyH4mIekp8NlelDOFDAn1xYE3M0KFmCpmzPdWIsndkMAl
         TMSNcGmRmZB+pDj6KJHCDGgihdHpRzJJtzDu4fmofxXLU3m7BNElvYn2l0CtFEltIdMW
         UObA==
X-Gm-Message-State: AO0yUKWKTzdBfy1NEoRtvsuuTyBLmq8MHqQasZgmDOaatdYi8Ybje+dm
        9JciObhuklMMuFMfL9ucGs9RbY+Hy5wlSVyEvAHpIg==
X-Google-Smtp-Source: AK7set/Wzjr8T0RiAIbq2pXVyJ87t0h1QpURbaYUliCvi7szZqLLwtfi/oxSutsEDerrvGj4YaRYeBPAqR8efT0E61o=
X-Received: by 2002:ac2:5deb:0:b0:4db:3ab2:896e with SMTP id
 z11-20020ac25deb000000b004db3ab2896emr4642945lfq.6.1679066871689; Fri, 17 Mar
 2023 08:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
 <87y1nv76au.fsf@linux.ibm.com>
In-Reply-To: <87y1nv76au.fsf@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Mar 2023 16:27:38 +0100
Message-ID: <CACT4Y+Z1TmGuFRfaSPfJkzu2Fo-3JN4XPrWpME=bPwe=50-kFg@mail.gmail.com>
Subject: Re: LOCK_DOWN_FORCE_INTEGRITY_FOR_FUZZING?
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>, jmorris@namei.org,
        mjg59@srcf.ucam.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 17 Mar 2023 at 16:21, Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> Hi Dmitry,
>
> Dmitry Vyukov <dvyukov@google.com> writes:
> > Hi Lockdown maintainers,
>
> I'm not a lockdown maintainer, but I feel like I can respond to a couple
> things here.
>
> > We don't enable Lockdown integrity mode on syzbot during fuzzing, but
> > we would like to. The main problem is the restriction of debugfs,
> > which we need for fuzzing. But we do duplicate some of its
> > restrictions (e.g. DEVKMEM=n).
> >
> > It come up again recently in the context of discussion of memory
> > corruptions when a mounted blocked device is being written to by root:
> > https://lore.kernel.org/all/CACT4Y+b1vGfe0Uvp6YmKahK4GfCfvdBLCh0SAQzGgWN1s6A+0Q@mail.gmail.com/
> > It looks like this restriction of writing to mounted block devices
> > should be part of integrity lockdown (but I am not an expert).
>
> I'm not sure, I'll leave that question to others.
>
> > What do you think about the addition of a new level that is integrity
> > but with debug fs access?
> > LOCKDOWN_RTAS_ERROR_INJECTION also looks like it's in the same bucket
> > of "fine for testing".
>
> Thanks for checking. Error injection via RTAS (pseries partition
> firmware) can cause unrecoverable cache and memory corruption. Right now
> I don't think including LOCKDOWN_RTAS_ERROR_INJECTION in a relaxed
> integrity mode for fuzzing would yield useful results.
>
> > At least for us it is OK if it can be enabled only via kernel config
> > (no cmd line) and named accordingly
> > (TEST_ONLY_DONT_ENABLE_IN_PRODUCTION).
> >
> > If we have it, we could restrict writing to mounted devices in
> > integrity mode and enable this mode on syzbot.
>
> So I understand the proposal to involve something like:
>
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -120,11 +120,12 @@ enum lockdown_reason {
>         LOCKDOWN_TIOCSSERIAL,
>         LOCKDOWN_MODULE_PARAMETERS,
>         LOCKDOWN_MMIOTRACE,
> -       LOCKDOWN_DEBUGFS,
>         LOCKDOWN_XMON_WR,
>         LOCKDOWN_BPF_WRITE_USER,
>         LOCKDOWN_DBG_WRITE_KERNEL,
>         LOCKDOWN_RTAS_ERROR_INJECTION,
> +       LOCKDOWN_INTEGRITY_FUZZING_MAX,
> +       LOCKDOWN_DEBUGFS,
>         LOCKDOWN_INTEGRITY_MAX,
>         LOCKDOWN_KCORE,
>         LOCKDOWN_KPROBES,
>
> Is that right?

Hi Nathan,

Thanks for the feedback.
Yes, something like this + config to enable this mode.

> I don't have a specific example at hand, but I suspect that enabling all
> of debugfs would allow syzbot to reach code that integrity mode
> ordinarily would prevent. Which doesn't seem like what you would want?
>
> I wonder if the debugfs-hosted facilities needed by syzbot could be
> identified in a finer-grained way that could be incorporated into the
> lockdown reason list for this purpose. So that way only the things
> syzbot needs would be exposed.

Debugfs also contains lots of code that needs to be tested.
It's also required to test production code, e.g. set up some stub devices, etc.
We generally can restrict fuzzer access based on paths (it's also
required to avoid writing garbage into /dev/sda, etc). So far having
debugfs accessible did not cause any problems.
