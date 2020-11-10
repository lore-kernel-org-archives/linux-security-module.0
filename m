Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85708C2D0A3
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 03:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477252065E
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 03:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKJDIb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Nov 2020 22:08:31 -0500
Received: from namei.org ([65.99.196.166]:39776 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgKJDIb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Nov 2020 22:08:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AA38Qti032185;
        Tue, 10 Nov 2020 03:08:26 GMT
Date:   Tue, 10 Nov 2020 14:08:26 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 2/2] tomoyo: Fixed typo in documentation
In-Reply-To: <7d214f98-90bb-563e-fbc1-e812e31f3b71@i-love.sakura.ne.jp>
Message-ID: <alpine.LRH.2.21.2011101408220.30138@namei.org>
References: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com> <1604737451-19082-2-git-send-email-jrdr.linux@gmail.com> <f5ed0413-315c-d5d0-e33f-c2b247a28da2@nvidia.com> <CAFqt6zaRP56DPRHTGMNiY3KpdOKPB_SeeuFagUbkmQKQ6mKD2A@mail.gmail.com>
 <7c60a6f5-414f-99e8-68c3-ca3b60fe89e9@nvidia.com> <7d214f98-90bb-563e-fbc1-e812e31f3b71@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 9 Nov 2020, Tetsuo Handa wrote:

> On 2020/11/09 13:17, John Hubbard wrote:
> > On 11/8/20 7:41 PM, Souptick Joarder wrote:
> >> John, as patch[1/2] is dropped, can we take this patch forward with some more
> >> updates in documentations ?
> >>
> > 
> > That's really up to the folks who work on this code. Personally I would rarely
> > post a patch *just* for this, but on the other hand it is a correction. Either
> > way is fine with me of course.
> 
> Xiaoming Ni has posted a patch for fixing spelling errors in security/ directory
> at https://lkml.kernel.org/r/20200822030534.2577-1-nixiaoming@huawei.com .
> 
> James, can we apply that patch? Or, should we split that patch into each subsystem?
> 

Probably easiest to go via my tree, the author should resend and include 
me on the To: line.

-- 
James Morris
<jmorris@namei.org>

