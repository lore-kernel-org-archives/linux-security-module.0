Return-Path: <SRS0=S0ZR=RH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B1C43381
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 13:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266B20661
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 13:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCDNgB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:36:01 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:47987 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfCDNgB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Mar 2019 08:36:01 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x24DZup7054343;
        Mon, 4 Mar 2019 22:35:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Mon, 04 Mar 2019 22:35:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x24DZpRH054313
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 4 Mar 2019 22:35:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing testing.
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
References: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <19e3dbac-d3ac-53b2-6e98-faf927bc72b3@i-love.sakura.ne.jp>
Date:   Mon, 4 Mar 2019 22:35:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

James, please include this patch for 5.1-rc1, for failing to include
this patch will prevent various trees (SELinux/Smack/AppArmor) from
proper testing due to this problem because syzbot is enabling both
TOMOYO and one of SELinux/Smack/AppArmor via lsm= boot parameter.

By including this patch and building kernels with this config option
enabled, syzbot will be able to continue proper testing.

On 2019/02/28 23:06, Tetsuo Handa wrote:
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
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/tomoyo/Kconfig  | 10 ++++++++++
>  security/tomoyo/common.c | 13 ++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
