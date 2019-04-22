Return-Path: <SRS0=pIlI=SY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE1C10F11
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Apr 2019 13:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FC020859
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Apr 2019 13:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDVNG7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:06:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50692 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVNG7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Apr 2019 09:06:59 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3MD6sUs070121;
        Mon, 22 Apr 2019 22:06:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Mon, 22 Apr 2019 22:06:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157095162.bbtec.net [60.157.95.162])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3MD6kis069902
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 22 Apr 2019 22:06:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH (resend)] tomoyo: Add a kernel config option for fuzzing
 testing.
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
References: <1555067094-9861-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <49c5ae17-86fb-e4d3-0e06-c205cf324c1d@I-love.SAKURA.ne.jp>
Date:   Mon, 22 Apr 2019 22:06:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555067094-9861-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

James, will you apply this patch and
"[PATCH 3/3] tomoyo: Check address length before reading address family" and
"[PATCH] tomoyo: Change pathname calculation for read-only filesystems." ?

On 2019/04/12 20:04, Tetsuo Handa wrote:
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
