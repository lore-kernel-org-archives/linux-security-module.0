Return-Path: <SRS0=gWqU=ZN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A5FC432C0
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Nov 2019 07:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D232089D
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Nov 2019 07:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUHVv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:21:51 -0500
Received: from namei.org ([65.99.196.166]:41600 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfKUHVv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Nov 2019 02:21:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xAL7LcGl010409;
        Thu, 21 Nov 2019 07:21:38 GMT
Date:   Thu, 21 Nov 2019 18:21:38 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
In-Reply-To: <d5cbd24b-531d-e9d0-f784-e6447129741d@i-love.sakura.ne.jp>
Message-ID: <alpine.LRH.2.21.1911211818320.3625@namei.org>
References: <0000000000004f43fa058a97f4d3@google.com> <201906060520.x565Kd8j017983@www262.sakura.ne.jp> <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp> <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp> <20190618204933.GE17978@ZenIV.linux.org.uk>
 <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp> <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp> <alpine.LRH.2.21.1907061944050.2662@namei.org> <alpine.LRH.2.21.1907061949040.2662@namei.org> <289ebc65-8444-37e3-e54e-21b55d2c9192@i-love.sakura.ne.jp>
 <a28f2680-bafc-5e23-4eea-6b432f561cd4@i-love.sakura.ne.jp> <A9CE5147-4047-4C42-B772-F0ED510FA283@canb.auug.org.au> <36906718-d2ae-3514-c6b2-371037c98da5@i-love.sakura.ne.jp> <20191003082543.5e1e25dd@canb.auug.org.au> <b175f451-4e76-84aa-48fa-e3ee9490c579@i-love.sakura.ne.jp>
 <d5cbd24b-531d-e9d0-f784-e6447129741d@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 13 Nov 2019, Tetsuo Handa wrote:

> Hello, Andrew and James.
> 
> I have difficulty setting up environments for sending pull request to linux.git
> (nobody around me knows Linux kernel maintainer's workflow at the command line level).
> Can you pick up the following commit via mmotm or linux-security.git tree?

Not sure if your fix is complete.

Are there other potential paths to trigger this via tomoyo_path_perm() ?

e.g. call unlink(2) on /proc/pid/fd/sockfd


-- 
James Morris
<jmorris@namei.org>

