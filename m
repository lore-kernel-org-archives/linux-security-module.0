Return-Path: <SRS0=bFgB=VE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0146C5B578
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Jul 2019 02:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A462920836
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Jul 2019 02:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGGCu5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 6 Jul 2019 22:50:57 -0400
Received: from namei.org ([65.99.196.166]:33934 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfGGCu4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jul 2019 22:50:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x672oh0r003937;
        Sun, 7 Jul 2019 02:50:43 GMT
Date:   Sat, 6 Jul 2019 19:50:43 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
In-Reply-To: <alpine.LRH.2.21.1907061944050.2662@namei.org>
Message-ID: <alpine.LRH.2.21.1907061949040.2662@namei.org>
References: <0000000000004f43fa058a97f4d3@google.com> <201906060520.x565Kd8j017983@www262.sakura.ne.jp> <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp> <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp> <20190618204933.GE17978@ZenIV.linux.org.uk>
 <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp> <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp> <alpine.LRH.2.21.1907061944050.2662@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 6 Jul 2019, James Morris wrote:

> On Thu, 4 Jul 2019, Tetsuo Handa wrote:
> 
> > Hello.
> > 
> > Since it seems that Al has no comments, I'd like to send this patch to
> > linux-next.git . What should I do? Do I need to set up a git tree?
> 
> Yes, you can create one at github or similar.

Also notify Stephen Rothwell of the location of your -next branch, so it 
gets pulled into his tree.



-- 
James Morris
<jmorris@namei.org>

