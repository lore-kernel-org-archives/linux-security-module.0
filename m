Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759DEC433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Jan 2021 22:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40390221EB
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Jan 2021 22:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbhAYWpA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Jan 2021 17:45:00 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55318 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbhAYWoR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Jan 2021 17:44:17 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 10PMgEK6033580;
        Tue, 26 Jan 2021 07:42:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Tue, 26 Jan 2021 07:42:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 10PMgEOw033569
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jan 2021 07:42:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] smackfs: restrict bytes count in smackfs write functions
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com, andreyknvl@google.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com,
        Michal Hocko <mhocko@suse.com>
References: <20210124143627.582115-1-snovitoll@gmail.com>
 <3f33d3a2-c84c-081f-c1c4-424e5eeeb8d2@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3c35f7cc-1c8d-2fa0-6bc9-bde4e96017ce@i-love.sakura.ne.jp>
Date:   Tue, 26 Jan 2021 07:42:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3f33d3a2-c84c-081f-c1c4-424e5eeeb8d2@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/01/26 3:08, Casey Schaufler wrote:
> On 1/24/2021 6:36 AM, Sabyrzhan Tasbolatov wrote:
>> syzbot found WARNINGs in several smackfs write operations where
>> bytes count is passed to memdup_user_nul which exceeds
>> GFP MAX_ORDER. Check count size if bigger SMK_LONGLABEL,
>> for smk_write_syslog if bigger than PAGE_SIZE - 1.
>>
>> Reported-by: syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> 
> Thank you for the patch. Unfortunately, SMK_LONGLABEL isn't
> the right value in some of these cases. 
> 

Since it uses sscanf(), I think that whitespaces must be excluded from upper limit
check. I'm proposing adding __GFP_NOWARM on the memdup_user_nul() side at
https://lkml.kernel.org/r/20210120103436.11830-1-penguin-kernel@I-love.SAKURA.ne.jp .
