Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F71EB64DD
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jul 2023 19:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjGETsR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjGETsL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 15:48:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8846FC
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 12:48:10 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-57712d00cc1so89039007b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 05 Jul 2023 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688586490; x=1691178490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx1o8rNmUZVCGbhC3KbwWvErawPnLIOygo7Tbf5XlC8=;
        b=HEJNhLyPtIcem/YfqIaTn7yvvENfMbznlNN/cHqcCiKhN5H3ShzSibe143AXamc08U
         XoyDR/CSOi6OKhRE53uY4QOWlbxx8KJmS2+2rZbBjoNk1HWKTze9g6ecJHWFqjLKY6Ke
         miRHaOLztGDtEvl1D/fUWbuBO614lZ8RCOqLQMJzLmwwgZGWbVUFVDyIPlyBiTN2KHy8
         9PZjSCG4QQSsd7zgZUzZEfda4AEYQwM1OEYTdDVFUiirQuAiZjbQuN8vloF5QzJkcM2F
         wf2inbWD7Ob7mnMVU4hWuP824WBy4L4fjBIHkS/dvU1/ytFvxq6A6QQqc5VmMfSGO/nt
         Hnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586490; x=1691178490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fx1o8rNmUZVCGbhC3KbwWvErawPnLIOygo7Tbf5XlC8=;
        b=V+3ChJXeCDY1zvEG9G7b2/RmXPgGBFB7CHeiMDwgBUQo5Q8yuyMIvsDaLI51h75TnW
         JX/4ogTBJ87YunW5sMA97hOwDe59NARJNZsk3v0OneMzfHReiD0oJ03NA4BshuUU0Ewa
         OIGyBqrek2/spG9vDOVCQwJPAJpO+v6CQd+H8LkOrLsNDhOSWfarA6ph2kvTo8Z5h4BX
         J+IEcBtQFGG7B4uSFjPgIB9YGvSnLLUi8MQYC8te0yovpImw8hpIB7qE3/P/YjGeNBP8
         df5BoFaTJXbyxcR+XpE9V1URk/NCxSMLNxw5A47cLLLdnqqCQsDVUNz82rd83yGQhlhp
         ZOlA==
X-Gm-Message-State: ABy/qLZozJeaKfNkmmh3Xl12La9dqEbuR4NJ6WcdzSWfBUADnbwyDz8b
        tkxoyNGawRwD4Dj6tOdRF2XhyX5++vHCGdqnnP1j
X-Google-Smtp-Source: APBJJlGgw66itzSki5X5ujUDMGRFD3yhvyV6b4b881ShGsWRlly4Byua1mWj9qr8QY4Jv2924kYoreTFkj77/sYLEAM=
X-Received: by 2002:a0d:d3c2:0:b0:561:206a:ee52 with SMTP id
 v185-20020a0dd3c2000000b00561206aee52mr19367646ywd.24.1688586489917; Wed, 05
 Jul 2023 12:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230630192526.271084-2-paul@paul-moore.com> <CAJ-EccNa+itDRRwZJo7ukNG4VVXdZUu7h+W=7r4qvV0zSF5-cg@mail.gmail.com>
 <CAHC9VhQ21ef+oamr5m9RdzN_Do38Pfu6Up3M_2vwu564zq5G1w@mail.gmail.com> <20230705194511.GA487163@mail.hallyn.com>
In-Reply-To: <20230705194511.GA487163@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Jul 2023 15:47:59 -0400
Message-ID: <CAHC9VhTsshjLFaQ7B0XCLDBrou=hHkk_hW4BBw7V_wRGGiyHrA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update SafeSetID entry
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 5, 2023 at 3:45=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> w=
rote:
> On Wed, Jul 05, 2023 at 01:03:05PM -0400, Paul Moore wrote:
> > On Tue, Jul 4, 2023 at 2:33=E2=80=AFPM Micah Morton <mortonm@chromium.o=
rg> wrote:
> > > On Fri, Jun 30, 2023 at 12:25=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > >
> > > > Micah Morton, the SafeSetID maintainer, last posted to any of the
> > > > public kernel mailing lists in early August 2022 and has not
> > > > commented on any SafeSetID patches posted since that time.  Attempt=
s
> > > > to contact Micah directly over email have also failed.  Until Micah
> > > > reappears I'll plan to continue accepting SafeSetID patches via the
> > > > LSM tree, but I'm going to mark SafeSetID as "Odd Fixes" for now,
> > > > and add the LSM mailing list to the MAINTAINERS entry so that the
> > > > LSM list will be properly CC'd on any new SafeSetID patches.
> > >
> > > Hi Paul, I've moved on from working on ChromeOS and checking my
> > > @chromium.org email on a regular basis. I was trying to check in once
> > > per month or so but I guess its been a couple months since I've signe=
d
> > > on -- sorry about that. This sounds good to me, I can't necessarily
> > > make any guarantees that I will be a responsive maintainer going
> > > forward (especially since I expect changes to the SafeSetID code to b=
e
> > > very few and far between). I'm good with whatever you think is best
> > > here. Thanks!
> >
> > Thanks for the update Micah.
> >
> > Generally speaking, serving as a maintainer requires checking email on
> > a regular basis.  There isn't a well defined requirement that I'm
> > aware of, but once every couple months, or even once a month, is
> > outside what many expect, myself included.  I know you have moved on
> > from ChromeOS, but do you have a personal desire to continue
> > maintaining SafeSetID?  Linux has a rich history of maintainers who
> > maintain subsystems outside of a paying job, and I would be happy to
> > support you in such a role, but in order to do so I think you would
> > need to check your email at least once a week.  However, if you aren't
> > able to commit to that at this point in time we probably should mark
> > SafeSetID as being in the "Orphan" state, with patches accepted via
> > the LSM tree until a suitable maintainer can be found.
>
> Note also that the email address in MAINTAINERS file can be updated :)
> So if chromium.org email is the sticking point, it doesn't have to be.

Very good point.  People are the important part, not necessarily what
is listed in MAINTAINERS.  We can always find new ways to record
things in MAINTAINERS, finding good maintainers is much more difficult
;)

--=20
paul-moore.com
