Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C70EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Jul 2023 18:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGJSP4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGJSPz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Jul 2023 14:15:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA112A
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jul 2023 11:15:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6ef64342aso76080001fa.3
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jul 2023 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689012952; x=1691604952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obEXN3njb2tRvEUx4NF53qbQiI2SHdR+RdEXNR8E958=;
        b=hsd4Qrzx8dtuMA6hosTHtGoQD0COYzG0ts4fUEqoDLpQMt77XJR6Y9stGxJQF+6Ezd
         vmY3xVbwqW5MOSfyyZvP5FwWeV2tGFRHtOsmWBnEnKnPzvzxaNg5Fv8cXIBxB14Wsd17
         X1ORCO+WbvHl5pTSDrd2tQUtcoyMJeT6nFOQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012952; x=1691604952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obEXN3njb2tRvEUx4NF53qbQiI2SHdR+RdEXNR8E958=;
        b=iIWPLZqpYYSvMp051IRV5TYWqKhLPjoriMag8JT119sd9uKrVoUerqdTWDSnUCUPGn
         wHGPgc7mqgv7YtgBjXJ44iiTFxu/QOiOG+oyYeQxeL7CH89ksJJfMv37wyZ0SZhHcfU9
         9tJqUvbyNlwvZqTEpDIQgaWPvXBvxt9N+UME703stmTxsV7J3rIM6c+3nJfwA1ppra+m
         RnDplrvsty1XhqJDlimawoqdaSp2WD7o3/A7X1uEn11LJ0tdWuF3H+dQGCY0MupwYD8V
         wWM/Sxa3PsHXo850kNpkdhjky0Ech42Zh9BB9raJofKqjKKILrXTgnCktCsN+Lo6ukfT
         +dUQ==
X-Gm-Message-State: ABy/qLZV9zoRaYJugXRGFMmQoqUJTFdaxGMCJgzP+NW7/z/f7aneXavs
        mDeD4BdDnHyfBmd579y+iF/+VZHITLKq0CcS+/p8PW5UoAWTT+Rb
X-Google-Smtp-Source: APBJJlEPuECMss0Pg42J481iWHvcdaWnChCHB2Deanb9Cyyzj6UngafJgzjpPbfMB3FgJiPCkQV5N0NtU78z0pqD0Jk=
X-Received: by 2002:a2e:8eca:0:b0:2b6:a827:164f with SMTP id
 e10-20020a2e8eca000000b002b6a827164fmr10875093ljl.10.1689012952100; Mon, 10
 Jul 2023 11:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230630192526.271084-2-paul@paul-moore.com> <CAJ-EccNa+itDRRwZJo7ukNG4VVXdZUu7h+W=7r4qvV0zSF5-cg@mail.gmail.com>
 <CAHC9VhQ21ef+oamr5m9RdzN_Do38Pfu6Up3M_2vwu564zq5G1w@mail.gmail.com>
 <20230705194511.GA487163@mail.hallyn.com> <CAHC9VhTsshjLFaQ7B0XCLDBrou=hHkk_hW4BBw7V_wRGGiyHrA@mail.gmail.com>
In-Reply-To: <CAHC9VhTsshjLFaQ7B0XCLDBrou=hHkk_hW4BBw7V_wRGGiyHrA@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 10 Jul 2023 11:15:40 -0700
Message-ID: <CAJ-EccMeGBM6qn08kXtT=bT7BNqZAU1yQuACMSoFwCikyrvNrw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update SafeSetID entry
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 5, 2023 at 12:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jul 5, 2023 at 3:45=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> > On Wed, Jul 05, 2023 at 01:03:05PM -0400, Paul Moore wrote:
> > > On Tue, Jul 4, 2023 at 2:33=E2=80=AFPM Micah Morton <mortonm@chromium=
.org> wrote:
> > > > On Fri, Jun 30, 2023 at 12:25=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > >
> > > > > Micah Morton, the SafeSetID maintainer, last posted to any of the
> > > > > public kernel mailing lists in early August 2022 and has not
> > > > > commented on any SafeSetID patches posted since that time.  Attem=
pts
> > > > > to contact Micah directly over email have also failed.  Until Mic=
ah
> > > > > reappears I'll plan to continue accepting SafeSetID patches via t=
he
> > > > > LSM tree, but I'm going to mark SafeSetID as "Odd Fixes" for now,
> > > > > and add the LSM mailing list to the MAINTAINERS entry so that the
> > > > > LSM list will be properly CC'd on any new SafeSetID patches.
> > > >
> > > > Hi Paul, I've moved on from working on ChromeOS and checking my
> > > > @chromium.org email on a regular basis. I was trying to check in on=
ce
> > > > per month or so but I guess its been a couple months since I've sig=
ned
> > > > on -- sorry about that. This sounds good to me, I can't necessarily
> > > > make any guarantees that I will be a responsive maintainer going
> > > > forward (especially since I expect changes to the SafeSetID code to=
 be
> > > > very few and far between). I'm good with whatever you think is best
> > > > here. Thanks!
> > >
> > > Thanks for the update Micah.
> > >
> > > Generally speaking, serving as a maintainer requires checking email o=
n
> > > a regular basis.  There isn't a well defined requirement that I'm
> > > aware of, but once every couple months, or even once a month, is
> > > outside what many expect, myself included.  I know you have moved on
> > > from ChromeOS, but do you have a personal desire to continue
> > > maintaining SafeSetID?  Linux has a rich history of maintainers who
> > > maintain subsystems outside of a paying job, and I would be happy to
> > > support you in such a role, but in order to do so I think you would
> > > need to check your email at least once a week.  However, if you aren'=
t
> > > able to commit to that at this point in time we probably should mark
> > > SafeSetID as being in the "Orphan" state, with patches accepted via
> > > the LSM tree until a suitable maintainer can be found.

I think setting a calendar reminder once per week to check this
mailing list for any SafeSetID related patches/mail sounds reasonable
and something I can commit to. Keeping the same @chromium.org email
for me is fine, I'll let you guys know if I lose access or have
trouble logging in at some point and we can get the email updated, but
I don't anticipate that happening.

Thanks,
Micah

> >
> > Note also that the email address in MAINTAINERS file can be updated :)
> > So if chromium.org email is the sticking point, it doesn't have to be.
>
> Very good point.  People are the important part, not necessarily what
> is listed in MAINTAINERS.  We can always find new ways to record
> things in MAINTAINERS, finding good maintainers is much more difficult
> ;)
>
> --
> paul-moore.com
