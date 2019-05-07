Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D87C04A6B
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 03:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748A6206A3
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 03:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfEGD3z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 May 2019 23:29:55 -0400
Received: from namei.org ([65.99.196.166]:37824 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfEGD3y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 May 2019 23:29:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x473TYvL005435;
        Tue, 7 May 2019 03:29:34 GMT
Date:   Tue, 7 May 2019 13:29:34 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PULL] Smack: Repair for 5.2 build issue.
In-Reply-To: <ba1bd79c-2917-2e1a-1380-3ca352178034@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1905071329260.4091@namei.org>
References: <b1d1d0b8-51cb-657b-c8be-aa365a29c8a5@schaufler-ca.com> <c028ab99-c042-191c-8a18-d34b8ecfc3bd@schaufler-ca.com> <alpine.LRH.2.21.1905070730500.29030@namei.org> <ba1bd79c-2917-2e1a-1380-3ca352178034@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 6 May 2019, Casey Schaufler wrote:

> On 5/6/2019 2:31 PM, James Morris wrote:
> > On Mon, 6 May 2019, Casey Schaufler wrote:
> > 
> > > On 4/30/2019 2:29 PM, Casey Schaufler wrote:
> > > 
> > > > James, please pull this repair for a build problem with the last change.
> > > James, did you get this request? It's an important build fix.
> > I pulled this branch, please check next-smack in my repo.
> 
> There was an additional change:
> 	Smack: Fix kbuild reported build error (2019-04-30 14:13:32 -0700)
> 
> that came in on that same branch in response to a kbuild report.

Now applied.

> 
> > 
> > > > The following changes since commit
> > > > b9ef5513c99bf9c8bfd9c9e8051b67f52b2dee1e:
> > > >   ?? smack: Check address length before reading address family
> > > > (2019-04-29
> > > > 17:32:27 -0700)
> > > > are available in the git repository at:
> > > >   ?? https://github.com/cschaufler/next-smack.git smack-for-5.2-b
> > > > for you to fetch changes up to 619ae03e922b65a1a5d4269ceae1e9e13a058d6b:
> > > >   ?? Smack: Fix kbuild reported build error (2019-04-30 14:13:32 -0700)
> > > > ----------------------------------------------------------------
> > > > Casey Schaufler (1):
> > > >   ?????????? Smack: Fix kbuild reported build error
> > > >   ??security/smack/smack_lsm.c | 2 ++
> > > >   ??1 file changed, 2 insertions(+)
> > > > 
> 

-- 
James Morris
<jmorris@namei.org>

