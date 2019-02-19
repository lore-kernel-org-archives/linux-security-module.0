Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF90C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 19:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729382147A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 19:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfBSTGu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:06:50 -0500
Received: from namei.org ([65.99.196.166]:53094 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729602AbfBSTGt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 14:06:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1JJ6iXE001906;
        Tue, 19 Feb 2019 19:06:44 GMT
Date:   Wed, 20 Feb 2019 06:06:44 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [GIT PULL] KEYS: fixes for v5.1
In-Reply-To: <CAHk-=whd_ZMx8bPMQ3vskz8+BHj_rZ38kX62d5=n9J4K3hM4-g@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1902200605500.1614@namei.org>
References: <alpine.LRH.2.21.1902160914180.4453@namei.org> <CAHk-=whd_ZMx8bPMQ3vskz8+BHj_rZ38kX62d5=n9J4K3hM4-g@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 16 Feb 2019, Linus Torvalds wrote:

> On Fri, Feb 15, 2019 at 2:16 PM James Morris <jmorris@namei.org> wrote:
> >
> > Please pull these fixes for the Keys subsystem.
> 
> For 5.0 or early pull request for 5.1? The subject says 5.1..

Sorry, it's for current -rc.



-- 
James Morris
<jmorris@namei.org>

