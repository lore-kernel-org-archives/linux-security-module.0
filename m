Return-Path: <SRS0=08hy=RP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC7C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 20:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BCA213A2
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 20:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCLU4r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:56:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:17400 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfCLU4r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Mar 2019 16:56:47 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2CKuamv089989;
        Wed, 13 Mar 2019 05:56:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Wed, 13 Mar 2019 05:56:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2CKuVQT089960
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 13 Mar 2019 05:56:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing testing.
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
References: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.LRH.2.21.1903130519440.27366@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5b69c819-eed4-1825-9e67-fff1206e9e3f@i-love.sakura.ne.jp>
Date:   Wed, 13 Mar 2019 05:56:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1903130519440.27366@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/03/13 3:21, James Morris wrote:
> On Thu, 28 Feb 2019, Tetsuo Handa wrote:
> 
>> syzbot is reporting kernel panic triggered by memory allocation fault
>> injection before loading TOMOYO's policy [1]. To make the fuzzing tests
>> useful, we need to assign a profile other than "disabled" (no-op) mode.
>> Therefore, let's allow syzbot to load TOMOYO's built-in policy for
>> "learning" mode using a kernel config option. This option must not be
>> enabled for kernels built for production system, for this option also
>> disables domain/program checks when modifying policy configuration via
>> /sys/kernel/security/tomoyo/ interface.
> 
> I don't understand the logic here. If the cause of this is no policy 
> loaded combined with running out of memory, shouldn't the no-policy issue 
> be dealt with earlier?
> 

This patch is for automatically loading minimal policy at boot time
in order to address the no-policy issue. By applying this patch, syzbot
can test TOMOYO module without modifying userspace to load TOMOYO's policy
when /sbin/init starts.
