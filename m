Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B42DEB64DA
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jul 2023 19:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjGETph (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjGETpf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 15:45:35 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E9198D
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jul 2023 12:45:13 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 581A1A46; Wed,  5 Jul 2023 14:45:11 -0500 (CDT)
Date:   Wed, 5 Jul 2023 14:45:11 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update SafeSetID entry
Message-ID: <20230705194511.GA487163@mail.hallyn.com>
References: <20230630192526.271084-2-paul@paul-moore.com>
 <CAJ-EccNa+itDRRwZJo7ukNG4VVXdZUu7h+W=7r4qvV0zSF5-cg@mail.gmail.com>
 <CAHC9VhQ21ef+oamr5m9RdzN_Do38Pfu6Up3M_2vwu564zq5G1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ21ef+oamr5m9RdzN_Do38Pfu6Up3M_2vwu564zq5G1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 05, 2023 at 01:03:05PM -0400, Paul Moore wrote:
> On Tue, Jul 4, 2023 at 2:33 PM Micah Morton <mortonm@chromium.org> wrote:
> > On Fri, Jun 30, 2023 at 12:25 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > Micah Morton, the SafeSetID maintainer, last posted to any of the
> > > public kernel mailing lists in early August 2022 and has not
> > > commented on any SafeSetID patches posted since that time.  Attempts
> > > to contact Micah directly over email have also failed.  Until Micah
> > > reappears I'll plan to continue accepting SafeSetID patches via the
> > > LSM tree, but I'm going to mark SafeSetID as "Odd Fixes" for now,
> > > and add the LSM mailing list to the MAINTAINERS entry so that the
> > > LSM list will be properly CC'd on any new SafeSetID patches.
> >
> > Hi Paul, I've moved on from working on ChromeOS and checking my
> > @chromium.org email on a regular basis. I was trying to check in once
> > per month or so but I guess its been a couple months since I've signed
> > on -- sorry about that. This sounds good to me, I can't necessarily
> > make any guarantees that I will be a responsive maintainer going
> > forward (especially since I expect changes to the SafeSetID code to be
> > very few and far between). I'm good with whatever you think is best
> > here. Thanks!
> 
> Thanks for the update Micah.
> 
> Generally speaking, serving as a maintainer requires checking email on
> a regular basis.  There isn't a well defined requirement that I'm
> aware of, but once every couple months, or even once a month, is
> outside what many expect, myself included.  I know you have moved on
> from ChromeOS, but do you have a personal desire to continue
> maintaining SafeSetID?  Linux has a rich history of maintainers who
> maintain subsystems outside of a paying job, and I would be happy to
> support you in such a role, but in order to do so I think you would
> need to check your email at least once a week.  However, if you aren't
> able to commit to that at this point in time we probably should mark
> SafeSetID as being in the "Orphan" state, with patches accepted via
> the LSM tree until a suitable maintainer can be found.

Note also that the email address in MAINTAINERS file can be updated :)
So if chromium.org email is the sticking point, it doesn't have to be.

-serge
