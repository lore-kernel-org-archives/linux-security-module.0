Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8491C433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jun 2022 17:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377496AbiFPRT6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378286AbiFPRTz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jun 2022 13:19:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355FE4CD59
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jun 2022 10:19:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so3989563ejj.10
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jun 2022 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHjV6+d1wPcbJIXXueZ8eXPKto8w1sGcbUP/nhry+Lc=;
        b=fZLZmEgXFFCbwyUw1zXJ5JL28E/ey7iqcZSqht9lq7kKmvINuMARA0+Ulb4FJDUsty
         hAgz7ZM0rJIjo1enFtWyVxi8pMFilkYjG+n1yIzkefLHxUTnJEm9Z7JzL0MpVfkVVr0k
         /IPzEpcZksaPiymRJXKfSMDmYfFX1gnvZoDKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHjV6+d1wPcbJIXXueZ8eXPKto8w1sGcbUP/nhry+Lc=;
        b=WwuWn/3VVFScKbe2GU0OgMPxQ1v0H6lfVCfAa1Y6HOaWkYHcs6zItGoIQF7YFdDU5p
         NsjFqtaF3NccQJimdLauMfiyRSmgmi2YcXqlaPAYIPJeucp7ELIu19FP7ynpe4sBtQ9N
         gYamLYGceMRQGgaVvqqepIlWBGtsGAPdEE5QfaI7kDJRpvf/qJuz1mkuDvP3dTMmth97
         bA9/Chzx5EDHRGfu6/P4wAEWAxFUfHf3KojPSed6fG3qO30iCiGbcY4Rib+XMM5pMmgd
         qLs61hKiGcg5lNP9y0W0SVSDmBis8uGiifFCS0PMoCh/xc4fYe0UKQZfaNI8aV7sd4pV
         fLyQ==
X-Gm-Message-State: AJIora89C1Z5aiuVnp05EWiEj0djqsVzc09AB4VnpNf5+FA+b/XEEFdj
        0UOluHscuRey4o7tILYsPi4HzwSLqlbq+pN5ZoJMQm0iYZ0=
X-Google-Smtp-Source: AGRyM1vE8prXPyyX2KZN3XXldr/y6R0KwwEZo+KVjq+te8IczQ+4jeOKiFUFoM9AGnEq4B+OLELhdnvfnwrsQXYLabg=
X-Received: by 2002:a17:906:4fd6:b0:70c:9284:cc01 with SMTP id
 i22-20020a1709064fd600b0070c9284cc01mr5513350ejw.553.1655399992619; Thu, 16
 Jun 2022 10:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220613202852.447738-1-mortonm@chromium.org> <CAJ-EccOhrYG6n6As72R7YzSk+Zzy=oFFJ62hG9476njprpJuvw@mail.gmail.com>
 <202206131643.4FB2340C43@keescook> <CAJ-EccN92u8y46j+h1Vg8tzFfRDynMM=1zRF6zGjx_4qKJ=AbQ@mail.gmail.com>
In-Reply-To: <CAJ-EccN92u8y46j+h1Vg8tzFfRDynMM=1zRF6zGjx_4qKJ=AbQ@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 16 Jun 2022 10:19:41 -0700
Message-ID: <CAJ-EccMGXZ_-eQsqwFEbxXs-ZBah5q4okBVL9cf8Qx+0nuLs7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: SafeSetID: Add setgroups() security policy handling
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 14, 2022 at 10:36 AM Micah Morton <mortonm@chromium.org> wrote:
>
> On Mon, Jun 13, 2022 at 4:46 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 13, 2022 at 02:00:03PM -0700, Micah Morton wrote:
> > > On Mon, Jun 13, 2022 at 1:28 PM Micah Morton <mortonm@chromium.org> wrote:
> > > [...]
> > > > +static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       /* Do nothing if there are no setgid restrictions for our old RGID. */
> > > > +       if (setid_policy_lookup((kid_t){.gid = old->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
> > > > +               return 0;
> > > > +
> > > > +       get_group_info(new->group_info);
> > > > +       for (i = 0; i < new->group_info->ngroups; i++) {
> > > > +               if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {
> > >
> > > Oops, should be:
> > >
> > > !id_permitted_for_cred(old, (kid_t){.gid = new->group_info->gid[i]}, GID)
> > >
> > > Guess I won't send a whole new patch just for that one line
> >
> > This begs the question: are there self-tests for this LSM somewhere?
> > It'd be really nice to add them to tool/testing/selftests ...
>
> There actually is tools/testing/selftests/safesetid/ but I haven't
> updated it since v1 of SafeSetID that only accommodated UIDs. I've
> been relying on integration testing we have out of tree on the Chrome
> OS side but I suppose its reasonable to bring the selftest up to date
> as well :)
>
> Also both patches are a couple lines off from the ones I was finished
> developing/testing with.. some kind of screw up happened when I copied
> from my dev machine to another where I could get git-send-email
> working properly. I'll just resend these 2 patches along with the
> update to the selftest.

Just sent the updated patches and selftest patch.

>
> Thanks
>
> >
> > --
> > Kees Cook
