Return-Path: <SRS0=855y=VV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0805DC7618B
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Jul 2019 05:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD68227BF
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Jul 2019 05:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563944432;
	bh=4qlljs09rpgALdvcWFh3jS7Ew6ewa47qANZ0vqx2k0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TRPnTRMNOPMItJBR6lN2UA8jvRi+UYGrnDqS/h2CseYZsZNapE1x/PJyBobvqYmyo
	 s320tS3T6C7U1Ik9nn2XuAw+iDVkehU77zKBS52D/E1N4khWBmUMpjMTSOOVWUftEd
	 fZLvkkZUqqmnrIICME2zSwszzxUR/XJkkFGWNcX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfGXFAc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfGXFAc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Jul 2019 01:00:32 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC3B218DA;
        Wed, 24 Jul 2019 05:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563944431;
        bh=4qlljs09rpgALdvcWFh3jS7Ew6ewa47qANZ0vqx2k0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vT/7OMIxMsGZLbsE7mk3XbCjXZNfqTAAQFz155uSCN0tSLW88cryzqibycjNUaPqc
         g75Rjum79NYS37ExBD8YwKlYBHD8+6OYf4r176O4HhQt4zE17djBCDVs0bhzI8hBha
         uYhI5d4ckIdP23nMyOg9s3L6tC1YQREBo5V+AGxU=
Date:   Tue, 23 Jul 2019 22:00:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: Reminder: 2 open syzbot bugs in "security/tomoyo" subsystem
Message-ID: <20190724050029.GD643@sol.localdomain>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <20190724024251.GF643@sol.localdomain>
 <7800c28f-bf1c-56cd-c82e-b1ff174ccbc8@i-love.sakura.ne.jp>
 <20190724043450.GZ643@sol.localdomain>
 <737a46de-cfb0-6220-c796-563ffd3ff325@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <737a46de-cfb0-6220-c796-563ffd3ff325@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 24, 2019 at 01:54:40PM +0900, Tetsuo Handa wrote:
> On 2019/07/24 13:34, Eric Biggers wrote:
> > On Wed, Jul 24, 2019 at 12:18:47PM +0900, Tetsuo Handa wrote:
> >>> --------------------------------------------------------------------------------
> >>> Title:              KASAN: invalid-free in tomoyo_realpath_from_path
> >>> Last occurred:      57 days ago
> >>> Reported:           56 days ago
> >>> Branches:           net-next
> >>> Dashboard link:     https://syzkaller.appspot.com/bug?id=e9e5a1d41c3fb5d0f79aeea0e4cd535f160a6702
> >>> Original thread:    https://lkml.kernel.org/lkml/000000000000785e9d0589ec359a@google.com/T/#u
> >>
> >> This cannot be a TOMOYO's bug. We are waiting for a reproducer but
> >> no crash occurred since then. Maybe it is time to close as invalid.
> > 
> > Maybe.  Did you check for stack buffer overflows in the functions that
> > tomoyo_realpath_from_path() calls?  Perhaps something is corrupting the 'buf'
> > variable in the parent's stack frame.
> > 
> 
> What do you mean? If this crash were a stack buffer overflow, this crash
> should have already occurred again.
> 

Well not necessarily, it could be very rare.

That being said, it was only seen on net-next and only once; so it could have
been caused by some broken patch elsewhere in the kernel that was only present
for a short time.

So if you aren't going to do anything else with this, please just go ahead and
invalidate it.

> Since the "buf" variable is a local variable, it cannot be shared between
> two threads. Since "buf" is assigned as
> 
>   buf = kmalloc(buf_len, GFP_NOFS);
> 
> and nobody else is reassigning "buf",
> 
>   kfree(buf);
> 
> can't become an invalid free.
> 

- Eric
