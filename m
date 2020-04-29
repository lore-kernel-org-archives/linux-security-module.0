Return-Path: <SRS0=9msM=6N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DD0C83004
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Apr 2020 07:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401F72076B
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Apr 2020 07:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD2HDm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:03:42 -0400
Received: from namei.org ([65.99.196.166]:52998 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgD2HDm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Apr 2020 03:03:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 03T73OrI019827;
        Wed, 29 Apr 2020 07:03:24 GMT
Date:   Wed, 29 Apr 2020 17:03:24 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] Documentation: LSM: Correct the basic LSM description
In-Reply-To: <20200428124436.1c7463ee@lwn.net>
Message-ID: <alpine.LRH.2.21.2004291700110.19446@namei.org>
References: <4c053d72-2d58-612f-6d6b-f04226d0181e.ref@schaufler-ca.com> <4c053d72-2d58-612f-6d6b-f04226d0181e@schaufler-ca.com> <20200428124436.1c7463ee@lwn.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 28 Apr 2020, Jonathan Corbet wrote:

> On Tue, 21 Apr 2020 14:48:34 -0700
> Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> > This is a first pass at updating the basic documentation on
> > Linux Security Modules (LSM), which is frighteningly out of date.
> > Remove untrue statements about the LSM framework. Replace them
> > with true statements where it is convenient to do so. This is
> > the beginnig of a larger effort to bring the LSM documentation
> > up to date.
> > 
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  Documentation/security/lsm.rst | 202 ++++++++++++++---------------------------
> >  1 file changed, 66 insertions(+), 136 deletions(-)
> 
> James, are you planning to pick this up, or should I grab it?

You can grab it, but I don't think this patch ended up on the lsm list for 
review (I only caught it in the moderation queue for lss-pc).


-- 
James Morris
<jmorris@namei.org>

