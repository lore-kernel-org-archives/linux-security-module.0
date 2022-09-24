Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E93C32771
	for <linux-security-module@archiver.kernel.org>; Sat, 24 Sep 2022 09:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiIXJN4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Sep 2022 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiIXJNz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Sep 2022 05:13:55 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0493610D650
        for <linux-security-module@vger.kernel.org>; Sat, 24 Sep 2022 02:13:53 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E9C7D3F03B;
        Sat, 24 Sep 2022 09:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664010832;
        bh=WqD3Nqg+RxygQ1TzlePWCLEXa+NNkFviT4SLOi+36Qw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GO7j1sQlVBKsXfIt4yarDzl+caFODDR5k2vkecNqoBqVf9rXF0LOWdwgpATowmpzP
         GWHy9xoyRKxJSDJxcfXUW/44ZQR9zj8sSRvmSnP+sFuKqU6rMeuSnYhh7WLHameYgL
         su3sH+yLUF66FG/RFSuJD5fGIIoWUm/erfNZfvXkvX/3TeW2Y1dCicChFiNF4oh1RF
         XVFZGz7LkiwqTVxkdBlXCHX6ihlwdbMLH/sn6vEvxxTWx/vMFdsQjyS0MGv/cs8AHa
         RKcEoYH+iwheSF7l7iF05LJU1+e1SgnKfUklG6tbAyBzRLXazelH7IeFNOGSTtI+WQ
         Ry0j8QGhZJt1A==
Message-ID: <e34af4da-30dc-6be7-af81-3fb0201eb2d1@canonical.com>
Date:   Sat, 24 Sep 2022 02:13:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] apparmor: Simply obtain the newest label on a cred
Content-Language: en-US
To:     cuigaosheng <cuigaosheng1@huawei.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
References: <20220922030024.1282700-1-cuigaosheng1@huawei.com>
 <20220922145612.GA23772@mail.hallyn.com>
 <9a193f21-5f78-d045-762a-8f04caae7e2d@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <9a193f21-5f78-d045-762a-8f04caae7e2d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/23/22 02:29, cuigaosheng wrote:
>> On Thu, Sep 22, 2022 at 11:00:24AM +0800, Gaosheng Cui wrote:
>>> aa_get_newest_cred_label(__task_cred(task)) can do the same things as
>>> aa_get_newest_label(__aa_task_raw_label(task)), so we can replace it
>>> and remove __aa_task_raw_label() to simply code.
>> nitpick -
>>
>> "to simplify the code".
>>
> Thanks for taking the time to review this patch, I have made a patch v2 and submitted it.
> 
> link: https://patchwork.kernel.org/project/linux-security-module/list/?series=679790
> 

thanks
Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> On 2022/9/22 22:56, Serge E. Hallyn wrote:
>> On Thu, Sep 22, 2022 at 11:00:24AM +0800, Gaosheng Cui wrote:
>>> aa_get_newest_cred_label(__task_cred(task)) can do the same things as
>>> aa_get_newest_label(__aa_task_raw_label(task)), so we can replace it
>>> and remove __aa_task_raw_label() to simply code.
>> nitpick -
>>
>> "to simplify the code".
>>
>>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>>> ---
>>>   security/apparmor/include/cred.h | 13 -------------
>>>   security/apparmor/task.c         |  2 +-
>>>   2 files changed, 1 insertion(+), 14 deletions(-)
>>>
>>> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
>>> index 0b9ae4804ef7..58fdc72af664 100644
>>> --- a/security/apparmor/include/cred.h
>>> +++ b/security/apparmor/include/cred.h
>>> @@ -63,19 +63,6 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
>>>       return aa_get_newest_label(aa_cred_raw_label(cred));
>>>   }
>>> -/**
>>> - * __aa_task_raw_label - retrieve another task's label
>>> - * @task: task to query  (NOT NULL)
>>> - *
>>> - * Returns: @task's label without incrementing its ref count
>>> - *
>>> - * If @task != current needs to be called in RCU safe critical section
>>> - */
>>> -static inline struct aa_label *__aa_task_raw_label(struct task_struct *task)
>>> -{
>>> -    return aa_cred_raw_label(__task_cred(task));
>>> -}
>>> -
>>>   /**
>>>    * aa_current_raw_label - find the current tasks confining label
>>>    *
>>> diff --git a/security/apparmor/task.c b/security/apparmor/task.c
>>> index 503dc0877fb1..0a8f9fa7ca0a 100644
>>> --- a/security/apparmor/task.c
>>> +++ b/security/apparmor/task.c
>>> @@ -31,7 +31,7 @@ struct aa_label *aa_get_task_label(struct task_struct *task)
>>>       struct aa_label *p;
>>>       rcu_read_lock();
>>> -    p = aa_get_newest_label(__aa_task_raw_label(task));
>>> +    p = aa_get_newest_cred_label(__task_cred(task));
>>>       rcu_read_unlock();
>>>       return p;
>>> -- 
>>> 2.25.1
>> .

