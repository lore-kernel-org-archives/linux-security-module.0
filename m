Return-Path: <SRS0=E17M=WI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C72C31E40
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Aug 2019 22:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A102067D
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Aug 2019 22:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfHLW3g (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:29:36 -0400
Received: from namei.org ([65.99.196.166]:40112 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfHLW3f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Aug 2019 18:29:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x7CMTXBN016632;
        Mon, 12 Aug 2019 22:29:33 GMT
Date:   Tue, 13 Aug 2019 08:29:33 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH V38 00/29] security: Add support for locking down the
 kernel
In-Reply-To: <alpine.LRH.2.21.1908130339130.14197@namei.org>
Message-ID: <alpine.LRH.2.21.1908130829070.3198@namei.org>
References: <20190808000721.124691-1-matthewgarrett@google.com> <alpine.LRH.2.21.1908101608260.25186@namei.org> <CACdnJusx3N_ZoH4=+tqt85K9J5wmUnC-+bTtG_5qSD_TYu74+A@mail.gmail.com> <alpine.LRH.2.21.1908130339130.14197@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 13 Aug 2019, James Morris wrote:

> On Mon, 12 Aug 2019, Matthew Garrett wrote:
> 
> > On Fri, Aug 9, 2019 at 11:08 PM James Morris <jmorris@namei.org> wrote:
> > > Please verify and test, as I had to make a few minor fixups for my v5.2
> > > base.
> > 
> > Thanks James - there's a few small fixups required, would you like
> > those as separate patches or should I just send you a fixed copy of
> > the original patchset?
> 
> Given there are a few, an updated copy of the patchset will be best.

Actually, that's a lot of patches to resend, just send updates against my 
next-lockdown branch.

-- 
James Morris
<jmorris@namei.org>

