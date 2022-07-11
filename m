Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB57C43334
	for <linux-security-module@archiver.kernel.org>; Mon, 11 Jul 2022 16:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGKQfe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGKQfd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Jul 2022 12:35:33 -0400
Received: from mail.namei.org (namei.org [65.99.196.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BCA2C648
        for <linux-security-module@vger.kernel.org>; Mon, 11 Jul 2022 09:35:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 39D58550;
        Mon, 11 Jul 2022 16:16:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 39D58550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1657556207; bh=z8KKeizWkRRLfC2I4ImWOU7+VtkxxZvr8w7o1Y6pweE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HrsLYjWzOKds2x1qXaHPOL6X5IjOmxQY29C7v1EiUApRFuynvrDkRJUbdmJ5WtVg0
         OdMDAdVd2WmPScdjvIYR0HxL3KIKWZ44TXaDsmPAjjwBFP9qZOTSlAQDP17PDfUGrY
         Qnx/+l3GcknS0QS+nz2bEanOsM2uGxJpQRp0W5lc=
Date:   Tue, 12 Jul 2022 02:16:47 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update the LSM maintainer info
In-Reply-To: <CAHC9VhSowtGrY=Crgk85Yf6G+o-4SsWgDMJc_T_Jpw7yPx8zkg@mail.gmail.com>
Message-ID: <2afda16b-2661-6e93-cb6c-eda673e0c3c1@namei.org>
References: <165731248606.335227.15503387932450699761.stgit@olly> <4c33604f-25ee-c1e7-4a4c-afe95b3dba15@namei.org> <CAHC9VhSowtGrY=Crgk85Yf6G+o-4SsWgDMJc_T_Jpw7yPx8zkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 10 Jul 2022, Paul Moore wrote:

> On Fri, Jul 8, 2022 at 5:19 PM James Morris <jmorris@namei.org> wrote:
> > On Fri, 8 Jul 2022, Paul Moore wrote:
> > > After many years of shepherding the LSM layer, and Linux kernel
> > > access control in general, James has decided to take a small step
> > > away from his technical role and has asked me to assume the
> > > day-to-day maintenance tasks for the LSM.  This patch makes the
> > > necessary updates to the MAINTAINERS file.
> > >
> > > Thanks for all you patience and stewardship over the years James,
> > > I promise to do my best not to screw it all up :)
> > >
> > > Cc: linux-security-module@vger.kernel.org
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Acked-by: James Morris <jamorris@linux.microsoft.com>
> 
> James, are you planning to send this up to Linus during the next merge
> window or should I?

Feel free to send it directly.


-- 
James Morris
<jmorris@namei.org>

