Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1970C6FA82
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 09:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiIWJbM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiIWJad (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 05:30:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ABF1183B
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 02:29:47 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYmwV5RZRzWgwL;
        Fri, 23 Sep 2022 17:25:46 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:29:44 +0800
Subject: Re: [PATCH] apparmor: Simply obtain the newest label on a cred
To:     "Serge E. Hallyn" <serge@hallyn.com>
CC:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
References: <20220922030024.1282700-1-cuigaosheng1@huawei.com>
 <20220922145612.GA23772@mail.hallyn.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <9a193f21-5f78-d045-762a-8f04caae7e2d@huawei.com>
Date:   Fri, 23 Sep 2022 17:29:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220922145612.GA23772@mail.hallyn.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> On Thu, Sep 22, 2022 at 11:00:24AM +0800, Gaosheng Cui wrote:
>> aa_get_newest_cred_label(__task_cred(task)) can do the same things as
>> aa_get_newest_label(__aa_task_raw_label(task)), so we can replace it
>> and remove __aa_task_raw_label() to simply code.
> nitpick -
>
> "to simplify the code".
>
Thanks for taking the time to review this patch, I have made a patch v2 and submitted it.

link: https://patchwork.kernel.org/project/linux-security-module/list/?series=679790

On 2022/9/22 22:56, Serge E. Hallyn wrote:
> On Thu, Sep 22, 2022 at 11:00:24AM +0800, Gaosheng Cui wrote:
>> aa_get_newest_cred_label(__task_cred(task)) can do the same things as
>> aa_get_newest_label(__aa_task_raw_label(task)), so we can replace it
>> and remove __aa_task_raw_label() to simply code.
> nitpick -
>
> "to simplify the code".
>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   security/apparmor/include/cred.h | 13 -------------
>>   security/apparmor/task.c         |  2 +-
>>   2 files changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
>> index 0b9ae4804ef7..58fdc72af664 100644
>> --- a/security/apparmor/include/cred.h
>> +++ b/security/apparmor/include/cred.h
>> @@ -63,19 +63,6 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
>>   	return aa_get_newest_label(aa_cred_raw_label(cred));
>>   }
>>   
>> -/**
>> - * __aa_task_raw_label - retrieve another task's label
>> - * @task: task to query  (NOT NULL)
>> - *
>> - * Returns: @task's label without incrementing its ref count
>> - *
>> - * If @task != current needs to be called in RCU safe critical section
>> - */
>> -static inline struct aa_label *__aa_task_raw_label(struct task_struct *task)
>> -{
>> -	return aa_cred_raw_label(__task_cred(task));
>> -}
>> -
>>   /**
>>    * aa_current_raw_label - find the current tasks confining label
>>    *
>> diff --git a/security/apparmor/task.c b/security/apparmor/task.c
>> index 503dc0877fb1..0a8f9fa7ca0a 100644
>> --- a/security/apparmor/task.c
>> +++ b/security/apparmor/task.c
>> @@ -31,7 +31,7 @@ struct aa_label *aa_get_task_label(struct task_struct *task)
>>   	struct aa_label *p;
>>   
>>   	rcu_read_lock();
>> -	p = aa_get_newest_label(__aa_task_raw_label(task));
>> +	p = aa_get_newest_cred_label(__task_cred(task));
>>   	rcu_read_unlock();
>>   
>>   	return p;
>> -- 
>> 2.25.1
> .
