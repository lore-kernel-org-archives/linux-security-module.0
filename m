Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F794FA3743
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Oct 2022 08:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJ1IhO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Oct 2022 04:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJ1IhN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Oct 2022 04:37:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114721C4ED5;
        Fri, 28 Oct 2022 01:37:11 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MzG4Y6DyGz15MGy;
        Fri, 28 Oct 2022 16:32:13 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 16:36:56 +0800
Message-ID: <11716411-e143-ab1f-3b1e-d5d35f2a590a@huawei.com>
Date:   Fri, 28 Oct 2022 16:36:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
Content-Language: en-US
From:   "Guozihua (Scott)" <guozihua@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
 <20220921125804.59490-3-guozihua@huawei.com>
 <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
 <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
 <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
 <7ac3e330-e77c-95d8-7d3b-29e243b57251@huawei.com>
 <5e304b17fe709d2b2f30b991d5ffc4711d27a075.camel@linux.ibm.com>
 <2f032b6c-ecf2-5a41-dc38-e6ab0a2d7885@huawei.com>
 <90f8940cff5eeef7917e2b11a07e41b32b207ffa.camel@linux.ibm.com>
 <38d5fd39-ead2-e954-5901-b35ef6ec96b6@huawei.com>
In-Reply-To: <38d5fd39-ead2-e954-5901-b35ef6ec96b6@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022/10/19 15:17, Guozihua (Scott) wrote:
> On 2022/10/19 9:07, Mimi Zohar wrote:
>> On Tue, 2022-10-18 at 16:43 +0800, Guozihua (Scott) wrote:
>>> On 2022/9/28 22:11, Mimi Zohar wrote:
>>>>
>>>> After reviewing this patch set again, the code looks fine.  The commit
>>>> message is still a bit off, but I've pushed the patch set out to next-
>>>> integrity-testing, waiting for some Reviewed-by/Tested-by tags.
>>>>
>>>
>>> Hi Mimi,
>>>
>>> How's this patch going? I see Roberto is replying with a Reviewed-by.
>>
>> I'd really like to see a "Tested-by" tag as well.
>>
>> Are you able to force the scenario?
>>
> 
> It's a race condition which could be hard to reproduce easily and in a 
> stable manner. I'll give it a try.

Hi Mimi,

I managed to re-produce this issue with the help of the following two 
scripts:

read_tmp_measurement.sh:
> #!/bin/bash
> 
> while true
> do
>         cat /root/tmp.txt > /dev/null
>         measurement=`cat /sys/kernel/security/ima/ascii_runtime_measurements | grep "tmp\.txt" | wc -l`
>         if [ "${measurement}" == "1" ]; then
>                 echo "measurement found"
>                 exit 1
>         fi
> done

test.sh:
> #!/bin/bash
> 
> echo "measure obj_user=system_u obj_role=object_r obj_type=unlabeled_t" > /sys/kernel/security/ima/policy
> 
> cat /root/tmp2.txt
> measurement=`cat /sys/kernel/security/ima/ascii_runtime_measurements | grep "tmp2\.txt" | wc -l`
> [ "$measurement" == "1" ] && echo "measurement for tmp2 found"
> 
> cat /root/tmp.txt
> measurement=`cat /sys/kernel/security/ima/ascii_runtime_measurements | grep "tmp\.txt" | wc -l`
> [ "$measurement" == "1" ] && echo "measurement for tmp found, preparation failed!" && exit 1
> 
> ./read_tmp_measurement.sh &
> pid=$!
> 
> cd /usr/share/selinux/default
> semodule -i clock.pp.bz2
> semodule -r clock
> 
> kill ${pid}

I created two files tmp.txt and tmp2.txt, assign them with type 
user_home_t and unlabeled_t respectively and then run test.sh.
On a multi-core environment, I managed to reproduce this issue pretty 
easily and tested that once the solution is merged, the issue stops 
happening.

-- 
Best
GUO Zihua

