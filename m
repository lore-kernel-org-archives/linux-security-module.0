Return-Path: <SRS0=LsZi=RQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354D8C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Mar 2019 10:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B82F214AE
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Mar 2019 10:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfCMK3a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:29:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:27581 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMK3a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Mar 2019 06:29:30 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2DATH04056556;
        Wed, 13 Mar 2019 19:29:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Wed, 13 Mar 2019 19:29:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2DATCOG056536
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 13 Mar 2019 19:29:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing testing.
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
References: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.LRH.2.21.1903130519440.27366@namei.org>
 <5b69c819-eed4-1825-9e67-fff1206e9e3f@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1903130821250.2172@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8c586ed0-e9ee-a450-df06-3257cdf657ad@i-love.sakura.ne.jp>
Date:   Wed, 13 Mar 2019 19:29:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1903130821250.2172@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/03/13 6:24, James Morris wrote:
> On Wed, 13 Mar 2019, Tetsuo Handa wrote:
> 
>>> I don't understand the logic here. If the cause of this is no policy 
>>> loaded combined with running out of memory, shouldn't the no-policy issue 
>>> be dealt with earlier?
>>>
>>
>> This patch is for automatically loading minimal policy at boot time
>> in order to address the no-policy issue. By applying this patch, syzbot
>> can test TOMOYO module without modifying userspace to load TOMOYO's policy
>> when /sbin/init starts.
> 
> If syzbot is trying to test Tomoyo and this requires policy to be loaded, 
> shouldn't it do that?

SELinux has disabled/permissive/enforcing modes.
And syzbot is testing SELinux in permissive mode, isn't it?

TOMOYO has disabled/learning/permissive/enforcing modes.
And syzbot will test TOMOYO in learning mode.

This patch is required for telling TOMOYO to run in learning mode, by
loading minimal policy, without asking userspace to run policy loader.
This patch is easier than asking syzbot users to update their filesystem
images in order to embed policy loader and minimal policy into their
filesystem images.

> 
> And again, I think the no-policy situation needs to be detected before 
> you start trying to apply memory policies to running processes. Surely 
> there is some much earlier point during initialization that you will 
> detect that there is no policy?

TOMOYO is already detecting no-policy situation. TOMOYO is calling panic()
due to "memory allocation failure before loading minimal policy".

This patch avoids panic() by automatically loading minimal policy which is
embedded into the kernel.

