Return-Path: <SRS0=32Xp=S7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E86C43219
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 20:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2C92075E
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 20:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfD2UHJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:07:09 -0400
Received: from namei.org ([65.99.196.166]:36472 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfD2UHJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 16:07:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3TK734s026057;
        Mon, 29 Apr 2019 20:07:03 GMT
Date:   Tue, 30 Apr 2019 06:07:03 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     linux-security-module@vger.kernel.org,
        syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzbot <syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com>,
        syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
Subject: Re: [PATCH (resend)] tomoyo: Add a kernel config option for fuzzing
 testing.
In-Reply-To: <1555067094-9861-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.21.1904300606410.20645@namei.org>
References: <1555067094-9861-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 12 Apr 2019, Tetsuo Handa wrote:

> syzbot is reporting kernel panic triggered by memory allocation fault
> injection before loading TOMOYO's policy [1]. To make the fuzzing tests
> useful, we need to assign a profile other than "disabled" (no-op) mode.
> Therefore, let's allow syzbot to load TOMOYO's built-in policy for
> "learning" mode using a kernel config option. This option must not be
> enabled for kernels built for production system, for this option also
> disables domain/program checks when modifying policy configuration via
> /sys/kernel/security/tomoyo/ interface.
> 
> [1] https://syzkaller.appspot.com/bug?extid=29569ed06425fcf67a95
> 
> Reported-by: syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/tomoyo/Kconfig  | 10 ++++++++++
>  security/tomoyo/common.c | 13 ++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tomoyo


-- 
James Morris
<jmorris@namei.org>

