Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CBEC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B23664DD9
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 14:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhA1OZc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:25:32 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54910 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhA1OYt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Jan 2021 09:24:49 -0500
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 10SEO2ih089405;
        Thu, 28 Jan 2021 23:24:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Thu, 28 Jan 2021 23:24:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 10SEO2oI089396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Jan 2021 23:24:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] smackfs: restrict bytes count in smackfs write
 functions
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     andreyknvl@google.com, casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mhocko@suse.com,
        serge@hallyn.com,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
References: <5271074f-930a-46e9-8ece-2cc65d45dc19@i-love.sakura.ne.jp>
 <20210128132721.1111920-1-snovitoll@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8d66b6fd-81d3-38bd-703f-522a2e2d6fca@i-love.sakura.ne.jp>
Date:   Thu, 28 Jan 2021 23:24:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128132721.1111920-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/01/28 22:27, Sabyrzhan Tasbolatov wrote:
>> Doesn't this change break legitimate requests like
>>
>>   char buffer[20000];
>>
>>   memset(buffer, ' ', sizeof(buffer));
>>   memcpy(buffer + sizeof(buffer) - 10, "foo", 3);
>>   write(fd, buffer, sizeof(buffer));
>>
>> ?
> 
> It does, in this case. Then I need to patch another version with
> whitespace stripping before, after label. I just followed the same thing
> that I see in security/selinux/selinuxfs.c sel_write_enforce() etc.
> 
> It has the same memdup_user_nul() and count >= PAGE_SIZE check prior to that.

Since sel_write_enforce() accepts string representation of an integer value, PAGE_SIZE is sufficient.
But since smk_write_onlycap() and smk_write_relabel_self() accept list of space-delimited words,
you need to prove why PAGE_SIZE does not break userspace in your patch.

Also, due to the "too small to fail" memory-allocation rule, memdup_user_nul() for
count < PAGE_SIZE * 8 bytes is "never fails with -ENOMEM unless SIGKILLed by the OOM
killer". Also, memdup_user_nul() for count >= PAGE_SIZE * (1 << MAX_ORDER) - 1 bytes is
"never succeeds". Thus, you can safely add

	if (count >= PAGE_SIZE * (1 << MAX_ORDER) - 1)
		return -EINVAL; // or -ENOMEM if you want compatibility

to smackfs write functions. But it is a strange requirement that the caller of
memdup_user_nul() has to be aware of upper limit in a way that we won't hit

	/*
	 * There are several places where we assume that the order value is sane
	 * so bail out early if the request is out of bound.
	 */
	if (unlikely(order >= MAX_ORDER)) {
		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
		return NULL;
	}

path. memdup_user_nul() side should do

	if (count >= PAGE_SIZE * (1 << MAX_ORDER) - 1)
		return -ENOMEM;

check and return -ENOMEM if memdup_user_nul() does not want to use __GFP_NOWARN.
I still believe that memdup_user_nul() side should be fixed.

