Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A6FC2D0E4
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Nov 2020 10:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6FA20853
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Nov 2020 10:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgK0Kwn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:52:43 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61243 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgK0Kwn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Nov 2020 05:52:43 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0ARAqF1s032568;
        Fri, 27 Nov 2020 19:52:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Fri, 27 Nov 2020 19:52:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0ARAqEiA032564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Nov 2020 19:52:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Avoid potential null pointer access
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        weiyongjun1@huawei.com
References: <20201125121043.107662-1-zhengzengkai@huawei.com>
 <cfc96d99-adff-6eb9-9685-422587830eb8@i-love.sakura.ne.jp>
 <01d29bbf-9d77-c787-b2c2-d88a6a5047f7@huawei.com>
 <59e0abdd-88a9-6269-9cd1-0f65792784ec@i-love.sakura.ne.jp>
 <dfb6829e-0fb6-7dbc-5dfa-9707b2f0ae16@huawei.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <dc7db429-1461-a372-df09-cd6595fc2dd4@i-love.sakura.ne.jp>
Date:   Fri, 27 Nov 2020 19:52:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <dfb6829e-0fb6-7dbc-5dfa-9707b2f0ae16@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/11/27 16:17, Zheng Zengkai wrote:
> Hello Tetsuo,
>> On 2020/11/26 15:33, Zheng Zengkai wrote:
>>> As your say,  I found the function tomoyo_assign_namespace( )
>>>
>>> in security/tomoyo/domain.c has the similar situation,
>>>
>>> Can I add __GFP_NOWARN for both and remove the null check for _entry_ in tomoyo_assign_namespace( )?
>>>
>> Good catch. Yes, please send as a patch.
>> .
> 
> I have resent a patch, thanks!
> 

Applied to tomoyo-test1.git tree. Thank you.

By the way, since some people automatically backport patches with Fixes: tag,
I think we don't need to add Fixes: tag for patches like this one.
