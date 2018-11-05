Return-Path: <SRS0=P2kJ=NQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9048BC46475
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Nov 2018 16:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0E32081D
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Nov 2018 16:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0E32081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeKFCMi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:12:38 -0500
Received: from namei.org ([65.99.196.166]:51196 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbeKFCMi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Nov 2018 21:12:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wA5GplqP006239;
        Mon, 5 Nov 2018 16:51:47 GMT
Date:   Tue, 6 Nov 2018 03:51:47 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Yangtao Li <tiny.windzz@gmail.com>, takedakn@nttdata.co.jp,
        serge@hallyn.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tomoyo: fix small typo
In-Reply-To: <4712c089-3fbf-2753-dc42-4db5f8ef771a@i-love.sakura.ne.jp>
Message-ID: <alpine.LRH.2.21.1811060351390.6007@namei.org>
References: <20181101155508.23383-1-tiny.windzz@gmail.com> <4712c089-3fbf-2753-dc42-4db5f8ef771a@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 2 Nov 2018, Tetsuo Handa wrote:

> On 2018/11/02 0:55, Yangtao Li wrote:
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

