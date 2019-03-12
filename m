Return-Path: <SRS0=08hy=RP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D31C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 21:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D092147C
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 21:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCLVYG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:24:06 -0400
Received: from namei.org ([65.99.196.166]:56710 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfCLVYF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Mar 2019 17:24:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2CLO0fB002408;
        Tue, 12 Mar 2019 21:24:00 GMT
Date:   Wed, 13 Mar 2019 08:24:00 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-security-module@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing
 testing.
In-Reply-To: <5b69c819-eed4-1825-9e67-fff1206e9e3f@i-love.sakura.ne.jp>
Message-ID: <alpine.LRH.2.21.1903130821250.2172@namei.org>
References: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <alpine.LRH.2.21.1903130519440.27366@namei.org> <5b69c819-eed4-1825-9e67-fff1206e9e3f@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 13 Mar 2019, Tetsuo Handa wrote:

> > I don't understand the logic here. If the cause of this is no policy 
> > loaded combined with running out of memory, shouldn't the no-policy issue 
> > be dealt with earlier?
> > 
> 
> This patch is for automatically loading minimal policy at boot time
> in order to address the no-policy issue. By applying this patch, syzbot
> can test TOMOYO module without modifying userspace to load TOMOYO's policy
> when /sbin/init starts.

If syzbot is trying to test Tomoyo and this requires policy to be loaded, 
shouldn't it do that?

And again, I think the no-policy situation needs to be detected before 
you start trying to apply memory policies to running processes. Surely 
there is some much earlier point during initialization that you will 
detect that there is no policy?

-- 
James Morris
<jmorris@namei.org>

