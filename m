Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B89C56202
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Nov 2020 06:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8455A20DD4
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Nov 2020 06:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbgKZGeM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Nov 2020 01:34:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8403 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732690AbgKZGeM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Nov 2020 01:34:12 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ChSdN3y5Sz73qx;
        Thu, 26 Nov 2020 14:33:44 +0800 (CST)
Received: from [10.174.178.154] (10.174.178.154) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 26 Nov
 2020 14:33:56 +0800
Subject: Re: [PATCH] tomoyo: Avoid potential null pointer access
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jmorris@namei.org>,
        <serge@hallyn.com>, <weiyongjun1@huawei.com>
References: <20201125121043.107662-1-zhengzengkai@huawei.com>
 <cfc96d99-adff-6eb9-9685-422587830eb8@i-love.sakura.ne.jp>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <01d29bbf-9d77-c787-b2c2-d88a6a5047f7@huawei.com>
Date:   Thu, 26 Nov 2020 14:33:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cfc96d99-adff-6eb9-9685-422587830eb8@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello, Tetsuo

Got it , Thank you for your explanation.

> Hello, Zheng.
>
> Thank you for a patch, but I won't apply this patch.
> Expected behavior is that tomoyo_warn_oom() is called
> if tomoyo_memory_ok() is called with entry == NULL.
>
> Adding __GFP_NOWARN might be OK, but returning without tomoyo_warn_oom() is NG.
>
> On 2020/11/25 21:10, Zheng Zengkai wrote:
>> Calls to kzalloc() should be null-checked in order to avoid
>> any potential failures or unnecessary code execution.
>> Fix this by adding null checks for _entry_ right after allocation.
>>
>> Fixes: 57c2590fb7fd ("TOMOYO: Update profile structure")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

As your say,  I found the function tomoyo_assign_namespace( )

in security/tomoyo/domain.c has the similar situation,

Can I add __GFP_NOWARN for both and remove the null check for _entry_ in 
tomoyo_assign_namespace( )?

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 4bee32bfe16d..bc54d3c8c70a 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -498,7 +498,7 @@ static struct tomoyo_profile *tomoyo_assign_profile
         ptr = ns->profile_ptr[profile];
         if (ptr)
                 return ptr;
-       entry = kzalloc(sizeof(*entry), GFP_NOFS);
+       entry = kzalloc(sizeof(*entry), GFP_NOFS | __GFP_NOWARN);
         if (mutex_lock_interruptible(&tomoyo_policy_lock))
                 goto out;
         ptr = ns->profile_ptr[profile];
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index dc4ecc0b2038..c6e5cc5cc7cd 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -473,9 +473,7 @@ struct tomoyo_policy_namespace 
*tomoyo_assign_namespace(const char *domainname)
                 return ptr;
         if (len >= TOMOYO_EXEC_TMPSIZE - 10 || 
!tomoyo_domain_def(domainname))
                 return NULL;
-       entry = kzalloc(sizeof(*entry) + len + 1, GFP_NOFS);
-       if (!entry)
-               return NULL;
+       entry = kzalloc(sizeof(*entry) + len + 1, GFP_NOFS | __GFP_NOWARN);
         if (mutex_lock_interruptible(&tomoyo_policy_lock))
                 goto out;
         ptr = tomoyo_find_namespace(domainname, len);

>> ---
>>   security/tomoyo/common.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
>> index 4bee32bfe16d..99b4fafcb100 100644
>> --- a/security/tomoyo/common.c
>> +++ b/security/tomoyo/common.c
>> @@ -499,6 +499,8 @@ static struct tomoyo_profile *tomoyo_assign_profile
>>   	if (ptr)
>>   		return ptr;
>>   	entry = kzalloc(sizeof(*entry), GFP_NOFS);
>> +	if (!entry)
>> +		return NULL;
>>   	if (mutex_lock_interruptible(&tomoyo_policy_lock))
>>   		goto out;
>>   	ptr = ns->profile_ptr[profile];
>>
> .
>
