Return-Path: <SRS0=u3U2=QA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05EC282C3
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jan 2019 22:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018512082C
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jan 2019 22:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfAXWxZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:53:25 -0500
Received: from namei.org ([65.99.196.166]:48266 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAXWxZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Jan 2019 17:53:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0OMrGsn002399;
        Thu, 24 Jan 2019 22:53:16 GMT
Date:   Fri, 25 Jan 2019 09:53:16 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] tomoyo: Coding style fix.
In-Reply-To: <1548322656-9212-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.21.1901250952350.1596@namei.org>
References: <1548322656-9212-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 24 Jan 2019, Tetsuo Handa wrote:

> Follow many of recommendations by scripts/checkpatch.pl, and follow
> "lift switch variables out of switches" by Kees Cook.
> This patch makes no functional change.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Both applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

