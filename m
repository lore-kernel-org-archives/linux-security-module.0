Return-Path: <SRS0=08hy=RP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7392C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748AE2087C
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 18:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCLSWA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:22:00 -0400
Received: from namei.org ([65.99.196.166]:56666 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfCLSWA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Mar 2019 14:22:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x2CILqeg028844;
        Tue, 12 Mar 2019 18:21:52 GMT
Date:   Wed, 13 Mar 2019 05:21:52 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     linux-security-module@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing
 testing.
In-Reply-To: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.21.1903130519440.27366@namei.org>
References: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 28 Feb 2019, Tetsuo Handa wrote:

> syzbot is reporting kernel panic triggered by memory allocation fault
> injection before loading TOMOYO's policy [1]. To make the fuzzing tests
> useful, we need to assign a profile other than "disabled" (no-op) mode.
> Therefore, let's allow syzbot to load TOMOYO's built-in policy for
> "learning" mode using a kernel config option. This option must not be
> enabled for kernels built for production system, for this option also
> disables domain/program checks when modifying policy configuration via
> /sys/kernel/security/tomoyo/ interface.

I don't understand the logic here. If the cause of this is no policy 
loaded combined with running out of memory, shouldn't the no-policy issue 
be dealt with earlier?


-- 
James Morris
<jmorris@namei.org>

