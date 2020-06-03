Return-Path: <SRS0=cN3+=7Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A3C433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 21:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6560D206E6
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 21:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFCV1V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:27:21 -0400
Received: from namei.org ([65.99.196.166]:40800 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgFCV1V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Jun 2020 17:27:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 053LRKem003771;
        Wed, 3 Jun 2020 21:27:20 GMT
Date:   Thu, 4 Jun 2020 07:27:20 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL][Security] lockdown: Allow unprivileged users to see
 lockdown status
In-Reply-To: <CAHk-=wj5hZ8BPKMAK4OhXCrRNvZ=43gE8j=LGX_urGUgbdcqqg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2006040726580.3735@namei.org>
References: <alpine.LRH.2.21.2006021212490.12446@namei.org> <CAHk-=wj5hZ8BPKMAK4OhXCrRNvZ=43gE8j=LGX_urGUgbdcqqg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2 Jun 2020, Linus Torvalds wrote:

> On Mon, Jun 1, 2020 at 7:15 PM James Morris <jmorris@namei.org> wrote:
> >
> > Just one update for the security subsystem: allows unprivileged users to
> > see the status of the lockdown feature. From Jeremy Cline.
> 
> Hmm.
> 
> That branch seems to have sprouted another commit just today.

Oops, sorry, I thought it was already pulled.

> 
> I ended up taking that too as trivial, but it shows how you seem to
> basically send me a pointer to a live branch. Please don't do that.
> When you make changes to that branch, I now get those changes that you
> may not have meant to send me (and that I get upset for being
> surprised by).
> 
> An easy solution to that is to send me a signed tag instead of a
> pointer to a branch. Then you can continue to update the branch, while
> the tag stays stable.
> 
> Plus we've been encouraging signed tags for pull requests anyway.

Ok.

-- 
James Morris
<jmorris@namei.org>

