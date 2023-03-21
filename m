Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B9C761AF
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Mar 2023 19:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCUTmh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCUTma (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Mar 2023 15:42:30 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6BE580CF
        for <linux-security-module@vger.kernel.org>; Tue, 21 Mar 2023 12:41:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-544f7c176easo154674787b3.9
        for <linux-security-module@vger.kernel.org>; Tue, 21 Mar 2023 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679427700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgzZ8y6+CQfoqQp3VNwp0xCPOHXZgU8HAtuGA1Guv+M=;
        b=TWpNVj339oQqLVbkaP05tNRi0XHHdxEfGKCBEgeyVBHMiyn9XHNGKLuzrH30vGBoyG
         g2kAZD0JvtfmDd0tzFENICFZaOuKM+w4pm7nPgGrKtjwCoj4CTRDVmi5EI7MkxolOhxB
         QAgVD1nrjHXXOQGdiRvv5AgT89ZRqZ+AgeTWYKNrvsIelnGLSd0o4PfigCK2IICBTw3O
         Qv306WlGHhwvTBrU/8yv2zGHpzSo+V4PeGkfpl4QxgfhERCY3yPDrpD1z61QW0XYAEmI
         lhE7oQUWl/+MU6aO9Yb4R7x9W6HCsS4uWFVyMsWoJXFaNWnLwY2JQGG8fV5t66xR2RoR
         3dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgzZ8y6+CQfoqQp3VNwp0xCPOHXZgU8HAtuGA1Guv+M=;
        b=Mthu43YbqwyxgBc1p0L/jvaUrInmdApydh99BMquyjkbnitohqsJDtfHsv7kBTqw7S
         VrvwwvS0YFBQTnAcakvWM4Ga+UsjAe/Nqe1PUi2o/6fK7loRNGPSIoXFDbBivgCjBGHN
         XpH+SNuywSA74Z8ejLOeku9AlSqGTbdKDMeaByCsTQGSR0aJNu7P3LLnA0KfQzz7A1yJ
         /iSp1B6fN4m4c9P+2k69QKelhn3eVJcIMHJQIu+pp2SSu7SMUYa2dSO0uhV+rPE033YX
         JQ8gwClmJ2jIu01a1PNG18aa4D4MRTb40XFrERI20L7bzpZgWpLRZX8UCySmk2FQyURF
         pCfQ==
X-Gm-Message-State: AAQBX9dcmuXqwqupK3YOonw+yuAQr5yLGjigDith9VKLfaZdwXBULBU1
        fIPqBWLZ3CbXdRiFVO+ve+BnVfX7END0rODCyxGt
X-Google-Smtp-Source: AKy350ZAxydX/D1jWJcnypgoOnY69y4T7+7hgicMGU23AAahNB/vlb0gq+ZpZA//1N6QxJVTAeuj3zgCMvOakdMjGTc=
X-Received: by 2002:a81:e803:0:b0:545:6106:5334 with SMTP id
 a3-20020a81e803000000b0054561065334mr270415ywm.8.1679427700196; Tue, 21 Mar
 2023 12:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
 <CAHC9VhTNcDRfMwtKg2xLcwKHN_pkiKd9wSovMiYkfnx_erTEow@mail.gmail.com> <CACT4Y+a0ENW23f00OGd1rZ7t-nO7JR6C83FOcJ4G0RCNXsafxQ@mail.gmail.com>
In-Reply-To: <CACT4Y+a0ENW23f00OGd1rZ7t-nO7JR6C83FOcJ4G0RCNXsafxQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Mar 2023 15:41:29 -0400
Message-ID: <CAHC9VhT_ms8X8NEdcaJOBqOm+ZK8bmLzJDz-qvduAR-pm3xWmQ@mail.gmail.com>
Subject: Re: LOCK_DOWN_FORCE_INTEGRITY_FOR_FUZZING?
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     jmorris@namei.org, mjg59@srcf.ucam.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        nathanl@linux.ibm.com, syzkaller <syzkaller@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 21, 2023 at 5:57=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com> =
wrote:
> On Mon, 20 Mar 2023 at 21:36, Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Mar 14, 2023 at 6:02=E2=80=AFAM Dmitry Vyukov <dvyukov@google.c=
om> wrote:
> > >
> > > Hi Lockdown maintainers,
> > >
> > > We don't enable Lockdown integrity mode on syzbot during fuzzing, but
> > > we would like to. The main problem is the restriction of debugfs,
> > > which we need for fuzzing. But we do duplicate some of its
> > > restrictions (e.g. DEVKMEM=3Dn).
> > >
> > > It come up again recently in the context of discussion of memory
> > > corruptions when a mounted blocked device is being written to by root=
:
> > > https://lore.kernel.org/all/CACT4Y+b1vGfe0Uvp6YmKahK4GfCfvdBLCh0SAQzG=
gWN1s6A+0Q@mail.gmail.com/
> > > It looks like this restriction of writing to mounted block devices
> > > should be part of integrity lockdown (but I am not an expert).
> >
> > The first question I would ask is are there legitimate reasons to
> > write directly to a block device that would not impact the integrity
> > of the device?  Of course the first thing I think of when I think of
> > block devices is a storage device with a filesystem on top, but I'm
> > not comfortable enough with my block device knowledge to know what
> > other classes of block devices might exist and how one might normally
> > interact with them.
>
> That thread mentions tune2fs utility that does this now.

In which case it would seem that this isn't something we could
restrict on the grounds of integrity.  Regardless, thanks for
mentioning it.

> > If storage devices are the only instances of block devices that we
> > support, we would also need to be careful that any calls to
> > security_locked_down() happen only when userspace is attempting a
> > direct write; we wouldn't want to bump into a lockdown access denial
> > when the filesystem attempts to write to the block device.
> >
> > > What do you think about the addition of a new level that is integrity
> > > but with debug fs access?
> > > LOCKDOWN_RTAS_ERROR_INJECTION also looks like it's in the same bucket
> > > of "fine for testing".
> >
> > It's been a little while, and I can't say I fully understood the
> > ppc/pseries RTAS stuff at the time (or now for that matter), but I
> > didn't think that the RTAS error injection mechanism was strictly for
> > testing, is it?
> >
> > Regardless of RTAS, if the goal is testing lockdown with syzbot, which
> > requires debugfs, why not test a lockdown level that still allows
> > debugfs?
>
> My understanding is that only possible to enable these 3 levels:
> https://elixir.bootlin.com/linux/v6.3-rc3/source/security/lockdown/lockdo=
wn.c#L19
> and we want something in-between "none" and "integrity".

Sorry, my apologies, most of my interactions with the lockdown LSM
have focused on the enforcement side and not the userspace API in
securityfs; while lockdown has multiple different levels/reasons, for
some reason only three are actually available to userspace.  I'm
guessing that the ordering of levels beyond the basic
none/integrity/confidentiality values is an area of debate and it is
easier to offer a limited number of options.

> > > At least for us it is OK if it can be enabled only via kernel config
> > > (no cmd line) and named accordingly
> > > (TEST_ONLY_DONT_ENABLE_IN_PRODUCTION).
> > >
> > > If we have it, we could restrict writing to mounted devices in
> > > integrity mode and enable this mode on syzbot.
> >
> > Regardless of what we decide wrt to a new level, I think we want it to
> > always be present and not dependent on a config knob, either runtime
> > or buildtime.
>
> This will work for testing scenarios, but I was worried about production.
> It's not supposed to be enabled in production builds, so making it
> available can open the door for misconfiguration.

I'm also concerned about the difference between test and production
and the potential for "special" test configurations making their way
into production systems, this is why I'm not in favor of special
configurations which are only enabled for testing.  I also have
concerns about testing "special" configurations as opposed to what
people actually run.

--=20
paul-moore.com
