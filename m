Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5183C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 18:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEB0207DD
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 18:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgFOSDn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:03:43 -0400
Received: from namei.org ([65.99.196.166]:38236 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFOSDn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 14:03:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 05FI3XCm010205;
        Mon, 15 Jun 2020 18:03:33 GMT
Date:   Tue, 16 Jun 2020 04:03:33 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
In-Reply-To: <CAJ-EccO+4s8Dd=wj75ckfp4ZLhppt7uCgg2chf4SvTOxzqbgPw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2006160403190.9951@namei.org>
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com> <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com> <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com> <alpine.LRH.2.21.2006151517230.9003@namei.org>
 <CAJ-EccO+4s8Dd=wj75ckfp4ZLhppt7uCgg2chf4SvTOxzqbgPw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 15 Jun 2020, Micah Morton wrote:

> On Sun, Jun 14, 2020 at 10:21 PM James Morris <jmorris@namei.org> wrote:
> >
> > On Sun, 14 Jun 2020, Micah Morton wrote:
> >
> > > This patch was sent to the security mailing list and there were no objections.
> >
> > Standard practice for new or modified LSM hooks is that they are reviewed
> > and acked by maintainers of major LSMs (SELinux, AppArmor, and Smack, at
> > least).
> >
> > "No objections" should be considered "not reviewed".
> >
> > Can you add your tree to linux-next?
> > https://www.kernel.org/doc/man-pages/linux-next.html
> 
> Sure, I can do that. I should just send an email to Stephen Rothwell
> asking him to include the -next branch from my tree?

Yep, thanks.

> 
> >
> > --
> > James Morris
> > <jmorris@namei.org>
> >
> 

-- 
James Morris
<jmorris@namei.org>

