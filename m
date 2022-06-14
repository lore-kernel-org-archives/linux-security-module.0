Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD026C43334
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jun 2022 17:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiFNRhN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiFNRhM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jun 2022 13:37:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88CC2BB18
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 10:37:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x62so12651897ede.10
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jun 2022 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/o/RV1wuM6nbYpO+7qYN86XKOHWQh2hN8VI/abfDqY=;
        b=UJxaWhDmrHuXP7KTB8VONn/p0WAg1P1msemNJScm0SoQJUhLcLCZJFkvAWGV22KmGT
         dTfXA5SlP3e4nZ3q52s+wIHCwtJOsdn3t7BDmkibJfyr6sIkvwjL6icoJDNzkLxPSlvz
         Zoux5qJ8F81p//tB87eH2FMACflqCgXnIEyq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/o/RV1wuM6nbYpO+7qYN86XKOHWQh2hN8VI/abfDqY=;
        b=E6aQFNjTWNfKRuUjs9l95zXLkzpHfHGbFzy7VFp6GECtK6M0+TstVH1fE+VpRvxgcm
         9Z/L97qxVM77D6oKluCkoJ0sqsDWAIUoQoIRHzahu5krn1yrcNnD+FmyOGFetSd9rTR+
         Qcu3woE/ayWaeLJbQDx8+ClhiX24zIHFyZ/rHXBDkUS6fQKDZ+RImattKg30M1n8Kr3o
         T8204qpxAM0SWbI1ETRi4M6GTUEb1QtUBGjE8vbe7ZFNoJmxdI+YzKwri9GcgpSgxOsC
         q3SD/2ohqKugALZB2YbXcpL3Hdw93A/1qFcIaomZq1grkDNO5Xq8cnfw6ltX171KcuXC
         OZYQ==
X-Gm-Message-State: AJIora/bw5LgYUsIUHBTN0eVy3SiTh+XJ0FseakcXBvSHf2C/Jp/g58Z
        vLY90c5ntFcJonTASG4cO/4edZFyJ0tRdt018Lx+NQ==
X-Google-Smtp-Source: ABdhPJyrfOeRdnBJVarAPxPF8qq+CzWi0JMQggifnrweZOadB0KybCiGeWW4fBj+3mahljtsS5ySOTCTxkA+RYnIn2c=
X-Received: by 2002:a05:6402:2554:b0:42d:ee79:559d with SMTP id
 l20-20020a056402255400b0042dee79559dmr7460933edb.175.1655228230349; Tue, 14
 Jun 2022 10:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220613202852.447738-1-mortonm@chromium.org> <CAJ-EccOhrYG6n6As72R7YzSk+Zzy=oFFJ62hG9476njprpJuvw@mail.gmail.com>
 <202206131643.4FB2340C43@keescook>
In-Reply-To: <202206131643.4FB2340C43@keescook>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 14 Jun 2022 10:36:59 -0700
Message-ID: <CAJ-EccN92u8y46j+h1Vg8tzFfRDynMM=1zRF6zGjx_4qKJ=AbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: SafeSetID: Add setgroups() security policy handling
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 13, 2022 at 4:46 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 13, 2022 at 02:00:03PM -0700, Micah Morton wrote:
> > On Mon, Jun 13, 2022 at 1:28 PM Micah Morton <mortonm@chromium.org> wrote:
> > [...]
> > > +static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old)
> > > +{
> > > +       int i;
> > > +
> > > +       /* Do nothing if there are no setgid restrictions for our old RGID. */
> > > +       if (setid_policy_lookup((kid_t){.gid = old->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
> > > +               return 0;
> > > +
> > > +       get_group_info(new->group_info);
> > > +       for (i = 0; i < new->group_info->ngroups; i++) {
> > > +               if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {
> >
> > Oops, should be:
> >
> > !id_permitted_for_cred(old, (kid_t){.gid = new->group_info->gid[i]}, GID)
> >
> > Guess I won't send a whole new patch just for that one line
>
> This begs the question: are there self-tests for this LSM somewhere?
> It'd be really nice to add them to tool/testing/selftests ...

There actually is tools/testing/selftests/safesetid/ but I haven't
updated it since v1 of SafeSetID that only accommodated UIDs. I've
been relying on integration testing we have out of tree on the Chrome
OS side but I suppose its reasonable to bring the selftest up to date
as well :)

Also both patches are a couple lines off from the ones I was finished
developing/testing with.. some kind of screw up happened when I copied
from my dev machine to another where I could get git-send-email
working properly. I'll just resend these 2 patches along with the
update to the selftest.

Thanks

>
> --
> Kees Cook
