Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131A8C6FD1D
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Mar 2023 09:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCUJ5x (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Mar 2023 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCUJ5w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Mar 2023 05:57:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67761ACCF
        for <linux-security-module@vger.kernel.org>; Tue, 21 Mar 2023 02:57:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j11so18316882lfg.13
        for <linux-security-module@vger.kernel.org>; Tue, 21 Mar 2023 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679392668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3BEzDtoU9W/KVuMsofXInBWMY8wR+yOMc95H9NkD/c=;
        b=YjRlootqCioWHbUqCfyIozqtZyHAGpsgCTuXENnjntmf77gX3/VpsdlmFcrcHfXGKc
         /k4Cba/+rHbtxs4omPYoVGsXbuVhRqWiK2fY8aEtnmo/1wMJFnS3UuMatoSA8xxkwGXN
         FVIm3aatK3Iu3pi+YoZ39IcvK3gm5IKt16kEI2PaR7D/PLLzD83TPnaYmdBwEHB/qvis
         WjrDASYYRHeB2A830bzQpD2Wz5axwvx5IBV87ldt5SOFj0R2DoETaC2Hz4DAiLr0W5aY
         MfWOkuB5IdznndXKtZXOjvdMOtyH1mpheIOtYswV6vg/u/dB1bMu/lHTY6+hojUXTHrN
         JRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679392668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3BEzDtoU9W/KVuMsofXInBWMY8wR+yOMc95H9NkD/c=;
        b=p3U5cPmVga11sSWdhGV981oWpx9TNz8YhXGR11VZBb5ZyFlnk7SzlrQpugh6zgwx1q
         UqR2GGnC+4cZy7H57pIgc5FNPXBlYFuWhDpSGQ0OOnWPbO3S/mFvSXIzf88sMEHTK+l6
         pHtIWBGbfL6nYcMkvEe5HHzS4QmZqBfH82acv1duOenSXijQWmP4R1ZpkCmvmuDEfKgX
         I3BAZqiUBogDVMTs2KnyenZUgOz6QRXwuIeyyTghADDbCcf75Y022E0xAyNmyAZABT7b
         Ro5RVcfUyiQhrIVo5/2AVJVwXaUGAqG0ywQ/eJxY+lJ6d47umpnbkSa+WkHdD6Ukl2Oj
         yjCg==
X-Gm-Message-State: AO0yUKVJWuHod3tkCcsc3RlH3nC1q6pt/a5WMy3FBcNvzQfqQVYS3N1Z
        lRc2NtPUA7a+ioXyqdTjYScIFYAe3Rgtt2Qq+gA+Rw==
X-Google-Smtp-Source: AK7set+oE451EcbSTGnDEKBUYdrItn385rdkeEUYAR150mBNOPsncoQms8wwOC2j2kuqQ7TV76C8NWag6G5qmiiRC0o=
X-Received: by 2002:ac2:5984:0:b0:4db:1a09:a674 with SMTP id
 w4-20020ac25984000000b004db1a09a674mr610280lfn.6.1679392667755; Tue, 21 Mar
 2023 02:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
 <CAHC9VhTNcDRfMwtKg2xLcwKHN_pkiKd9wSovMiYkfnx_erTEow@mail.gmail.com>
In-Reply-To: <CAHC9VhTNcDRfMwtKg2xLcwKHN_pkiKd9wSovMiYkfnx_erTEow@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Mar 2023 10:57:35 +0100
Message-ID: <CACT4Y+a0ENW23f00OGd1rZ7t-nO7JR6C83FOcJ4G0RCNXsafxQ@mail.gmail.com>
Subject: Re: LOCK_DOWN_FORCE_INTEGRITY_FOR_FUZZING?
To:     Paul Moore <paul@paul-moore.com>
Cc:     jmorris@namei.org, mjg59@srcf.ucam.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        nathanl@linux.ibm.com, syzkaller <syzkaller@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 20 Mar 2023 at 21:36, Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Mar 14, 2023 at 6:02=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com=
> wrote:
> >
> > Hi Lockdown maintainers,
> >
> > We don't enable Lockdown integrity mode on syzbot during fuzzing, but
> > we would like to. The main problem is the restriction of debugfs,
> > which we need for fuzzing. But we do duplicate some of its
> > restrictions (e.g. DEVKMEM=3Dn).
> >
> > It come up again recently in the context of discussion of memory
> > corruptions when a mounted blocked device is being written to by root:
> > https://lore.kernel.org/all/CACT4Y+b1vGfe0Uvp6YmKahK4GfCfvdBLCh0SAQzGgW=
N1s6A+0Q@mail.gmail.com/
> > It looks like this restriction of writing to mounted block devices
> > should be part of integrity lockdown (but I am not an expert).
>
> The first question I would ask is are there legitimate reasons to
> write directly to a block device that would not impact the integrity
> of the device?  Of course the first thing I think of when I think of
> block devices is a storage device with a filesystem on top, but I'm
> not comfortable enough with my block device knowledge to know what
> other classes of block devices might exist and how one might normally
> interact with them.

That thread mentions tune2fs utility that does this now.


> If storage devices are the only instances of block devices that we
> support, we would also need to be careful that any calls to
> security_locked_down() happen only when userspace is attempting a
> direct write; we wouldn't want to bump into a lockdown access denial
> when the filesystem attempts to write to the block device.
>
> > What do you think about the addition of a new level that is integrity
> > but with debug fs access?
> > LOCKDOWN_RTAS_ERROR_INJECTION also looks like it's in the same bucket
> > of "fine for testing".
>
> It's been a little while, and I can't say I fully understood the
> ppc/pseries RTAS stuff at the time (or now for that matter), but I
> didn't think that the RTAS error injection mechanism was strictly for
> testing, is it?
>
> Regardless of RTAS, if the goal is testing lockdown with syzbot, which
> requires debugfs, why not test a lockdown level that still allows
> debugfs?

My understanding is that only possible to enable these 3 levels:
https://elixir.bootlin.com/linux/v6.3-rc3/source/security/lockdown/lockdown=
.c#L19
and we want something in-between "none" and "integrity".


> > At least for us it is OK if it can be enabled only via kernel config
> > (no cmd line) and named accordingly
> > (TEST_ONLY_DONT_ENABLE_IN_PRODUCTION).
> >
> > If we have it, we could restrict writing to mounted devices in
> > integrity mode and enable this mode on syzbot.
>
> Regardless of what we decide wrt to a new level, I think we want it to
> always be present and not dependent on a config knob, either runtime
> or buildtime.

This will work for testing scenarios, but I was worried about production.
It's not supposed to be enabled in production builds, so making it
available can open the door for misconfiguration.
