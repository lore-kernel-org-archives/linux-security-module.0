Return-Path: <SRS0=PFxj=WK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A454CC32753
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856C0208C2
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Aug 2019 18:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfHNSYJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:24:09 -0400
Received: from namei.org ([65.99.196.166]:40426 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbfHNSYJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Aug 2019 14:24:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x7EIO744031783;
        Wed, 14 Aug 2019 18:24:07 GMT
Date:   Thu, 15 Aug 2019 04:24:07 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 0/6] lockdown fixups
In-Reply-To: <CACdnJuvXpJoai+H7WeM_TNk2cjqr8evAm082aJgBRGvsUyaAVw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1908150423100.31503@namei.org>
References: <20190813192126.122370-1-matthewgarrett@google.com> <alpine.LRH.2.21.1908141503240.27654@namei.org> <CACdnJuvXpJoai+H7WeM_TNk2cjqr8evAm082aJgBRGvsUyaAVw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 14 Aug 2019, Matthew Garrett wrote:

> On Tue, Aug 13, 2019 at 10:06 PM James Morris <jmorris@namei.org> wrote:
> > Which kernel version are these against?
> 
> Crap. Sorry, these ended up derived from HEAD. Let me fix that up and
> resend. Sorry about that!

Do you have an upstream dependency on Mimi's code in -rc?

If so, just tell me which commit it is and I'll find the next good merge 
point.


-- 
James Morris
<jmorris@namei.org>

