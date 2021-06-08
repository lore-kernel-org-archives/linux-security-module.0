Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD904C47082
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 01:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9234C61263
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 01:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFHBQP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Jun 2021 21:16:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4385 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFHBQP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jun 2021 21:16:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzXGv0mBMz6vLY;
        Tue,  8 Jun 2021 09:10:31 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:14:21 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:14:20 +0800
Subject: Re: [PATCH -next] capability: fix doc warnings in capability.c
To:     "Serge E. Hallyn" <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <yangjihong1@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
References: <20210605062602.678602-1-libaokun1@huawei.com>
 <20210607230913.GA12581@mail.hallyn.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <83a6dfaa-80ef-62ba-313b-fff03efc6d9d@huawei.com>
Date:   Tue, 8 Jun 2021 09:14:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210607230913.GA12581@mail.hallyn.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thank you for your advice.

I didn't notice the order of the parameters.

I'm about to send a patch v2 with the changes suggested by you.

ÔÚ 2021/6/8 7:09, Serge E. Hallyn Ð´µÀ:
> On Sat, Jun 05, 2021 at 02:26:02PM +0800, Baokun Li wrote:
>> Fixes the following W=1 kernel build warning(s):
>>
>> kernel/capability.c:490: warning: Function parameter or
>>   member 'mnt_userns' not described in 'privileged_wrt_inode_uidgid'
>> kernel/capability.c:506: warning: Function parameter or
>>   member 'mnt_userns' not described in 'capable_wrt_inode_uidgid'
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   kernel/capability.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/capability.c b/kernel/capability.c
>> index 46a361dde042..27a959aa897f 100644
>> --- a/kernel/capability.c
>> +++ b/kernel/capability.c
>> @@ -480,6 +480,7 @@ EXPORT_SYMBOL(file_ns_capable);
>>   /**
>>    * privileged_wrt_inode_uidgid - Do capabilities in the namespace work over the inode?
>>    * @ns: The user namespace in question
>> + * @mnt_userns: User namespace of the mount the inode was found from
>>    * @inode: The inode in question
>>    *
>>    * Return true if the inode uid and gid are within the namespace.
>> @@ -495,6 +496,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
>>   /**
>>    * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
>>    * @inode: The inode in question
>> + * @mnt_userns: User namespace of the mount the inode was found from
> The mnt_userns comes before the inode in this fn.
>
>>    * @cap: The capability in question
>>    *
>>    * Return true if the current task has the given capability targeted at
>> -- 
>> 2.31.1
> .
