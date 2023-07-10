Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0870BEB64DA
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Jul 2023 18:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjGJSdz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGJSdw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Jul 2023 14:33:52 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBBCAB
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jul 2023 11:33:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b75637076eso4244143a34.2
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jul 2023 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689014030; x=1691606030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfED6ss74jQy5oCTIdbAOBTZVTQDC65TrLyJJcG77ks=;
        b=FTwfzsX3n8sKBKFbntDHiEWDxAhvma1vajkMIgCdr5lu+Qpw2qqtylVRGafzWYzkni
         Pap4XMbwj7ZyYRfYXhKPbjE44qpv43tNE2TYfZC5ox9mX3cUIqrd4ZuCN1C9CN/6MB+G
         +W8nhsgMtiFXv+7d6Yk5fvI32wC4IrPM/SHSIm2vxoLHpc0ZkJJXGmeWejuFzGpP96gS
         i5mU7tY1DwZT6HyVGASBGz/YulM+AIv3GhfFRHzENGiMmoJe2mGAsohCLIwrca54ZdES
         R2dSX+4xc/3RPwqpiTjrIg6jsobia1Hll2NVmI3QLVs3H2YGCzpW81lco2VH1eSGXeHO
         02BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014030; x=1691606030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfED6ss74jQy5oCTIdbAOBTZVTQDC65TrLyJJcG77ks=;
        b=Opq8w4WsOi4IP+p51I8lra0lUT9ZiBR7Pq5upV+vGIXNWnh2uhmqfgFfxz1ds9FUWM
         3Gm09GIKSXzOihkRSGNEKGcjI7bKIEwC8wdpWpoewnnidDD+v3+bT7z425fPXNtKKhAD
         1R23sNF6d8q6xpzyI4Y/sbkB3Z1Zgn5UrPsqOHw2/IvWhdLXZbLLaaO3WyuDSMWUl+7j
         nCANYKRyEtnnUA6UL7G0YLMMdO6vpX2O1wnMADIp+2hZFNMib+skKP7MgIcs/1r3LRMl
         ZVsvul4WAIl6hE9CSAIMqHjnjvOHz3bxkcznkkrOup5Tkb3AQqYYhEJlM5Yt9HGoxgr4
         iL8w==
X-Gm-Message-State: ABy/qLZWdIPcP1c9M+DAESMaM4bbe6dF+MTt6obaMbenK/c+3CMDU71n
        UXhjaZ9Y88UgnIsZ3oSy0FSuHjnr/FJhlEluU7CmmTCB3QQv1Mc=
X-Google-Smtp-Source: APBJJlE+Gs6o0zpYO3ULhtecy53PhYuY02tOcDLHN3TLIFIxP8PHSO06bKaBLJJSv8hZgBfPgH8YeHM86hnoos+94Ns=
X-Received: by 2002:a05:6870:fb91:b0:1b3:b8b4:4aba with SMTP id
 kv17-20020a056870fb9100b001b3b8b44abamr14720340oab.1.1689014030380; Mon, 10
 Jul 2023 11:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230630192526.271084-2-paul@paul-moore.com> <CAJ-EccNa+itDRRwZJo7ukNG4VVXdZUu7h+W=7r4qvV0zSF5-cg@mail.gmail.com>
 <CAHC9VhQ21ef+oamr5m9RdzN_Do38Pfu6Up3M_2vwu564zq5G1w@mail.gmail.com>
 <20230705194511.GA487163@mail.hallyn.com> <CAHC9VhTsshjLFaQ7B0XCLDBrou=hHkk_hW4BBw7V_wRGGiyHrA@mail.gmail.com>
 <CAJ-EccMeGBM6qn08kXtT=bT7BNqZAU1yQuACMSoFwCikyrvNrw@mail.gmail.com>
In-Reply-To: <CAJ-EccMeGBM6qn08kXtT=bT7BNqZAU1yQuACMSoFwCikyrvNrw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jul 2023 14:33:39 -0400
Message-ID: <CAHC9VhR6N8zQaw4Vjq2c5ogsNoSZo-Tvi3xp7FW8PWy-b2A9Bw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update SafeSetID entry
To:     Micah Morton <mortonm@chromium.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 10, 2023 at 2:15=E2=80=AFPM Micah Morton <mortonm@chromium.org>=
 wrote:
> On Wed, Jul 5, 2023 at 12:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Jul 5, 2023 at 3:45=E2=80=AFPM Serge E. Hallyn <serge@hallyn.co=
m> wrote:
> > > On Wed, Jul 05, 2023 at 01:03:05PM -0400, Paul Moore wrote:
> > > > On Tue, Jul 4, 2023 at 2:33=E2=80=AFPM Micah Morton <mortonm@chromi=
um.org> wrote:
> > > > > On Fri, Jun 30, 2023 at 12:25=E2=80=AFPM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > > > >
> > > > > > Micah Morton, the SafeSetID maintainer, last posted to any of t=
he
> > > > > > public kernel mailing lists in early August 2022 and has not
> > > > > > commented on any SafeSetID patches posted since that time.  Att=
empts
> > > > > > to contact Micah directly over email have also failed.  Until M=
icah
> > > > > > reappears I'll plan to continue accepting SafeSetID patches via=
 the
> > > > > > LSM tree, but I'm going to mark SafeSetID as "Odd Fixes" for no=
w,
> > > > > > and add the LSM mailing list to the MAINTAINERS entry so that t=
he
> > > > > > LSM list will be properly CC'd on any new SafeSetID patches.
> > > > >
> > > > > Hi Paul, I've moved on from working on ChromeOS and checking my
> > > > > @chromium.org email on a regular basis. I was trying to check in =
once
> > > > > per month or so but I guess its been a couple months since I've s=
igned
> > > > > on -- sorry about that. This sounds good to me, I can't necessari=
ly
> > > > > make any guarantees that I will be a responsive maintainer going
> > > > > forward (especially since I expect changes to the SafeSetID code =
to be
> > > > > very few and far between). I'm good with whatever you think is be=
st
> > > > > here. Thanks!
> > > >
> > > > Thanks for the update Micah.
> > > >
> > > > Generally speaking, serving as a maintainer requires checking email=
 on
> > > > a regular basis.  There isn't a well defined requirement that I'm
> > > > aware of, but once every couple months, or even once a month, is
> > > > outside what many expect, myself included.  I know you have moved o=
n
> > > > from ChromeOS, but do you have a personal desire to continue
> > > > maintaining SafeSetID?  Linux has a rich history of maintainers who
> > > > maintain subsystems outside of a paying job, and I would be happy t=
o
> > > > support you in such a role, but in order to do so I think you would
> > > > need to check your email at least once a week.  However, if you are=
n't
> > > > able to commit to that at this point in time we probably should mar=
k
> > > > SafeSetID as being in the "Orphan" state, with patches accepted via
> > > > the LSM tree until a suitable maintainer can be found.
>
> I think setting a calendar reminder once per week to check this
> mailing list for any SafeSetID related patches/mail sounds reasonable
> and something I can commit to. Keeping the same @chromium.org email
> for me is fine, I'll let you guys know if I lose access or have
> trouble logging in at some point and we can get the email updated, but
> I don't anticipate that happening.

That's great news Micah, thanks!

--=20
paul-moore.com
