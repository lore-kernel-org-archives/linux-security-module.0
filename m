Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9328DC4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 01:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKBBmP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBBmO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Nov 2022 21:42:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B672B1C3;
        Tue,  1 Nov 2022 18:42:12 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N28g16J2pzpW5t;
        Wed,  2 Nov 2022 09:38:37 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 09:42:10 +0800
Message-ID: <b2949b3d-c370-8a41-fe7c-9f175abd4f71@huawei.com>
Date:   Wed, 2 Nov 2022 09:42:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
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
 <11716411-e143-ab1f-3b1e-d5d35f2a590a@huawei.com>
 <db821df65b7ff7319c657a1de65f5ba903599fc4.camel@linux.ibm.com>
Content-Language: en-US
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <db821df65b7ff7319c657a1de65f5ba903599fc4.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Mimi,

On 2022/11/2 6:15, Mimi Zohar wrote:
> Hi Scott,
> 
> On Fri, 2022-10-28 at 16:36 +0800, Guozihua (Scott) wrote:
>>
>> I managed to re-produce this issue with the help of the following two
>> scripts:
>>
>> read_tmp_measurement.sh:
>>> #!/bin/bash
>>>
>>> while true
>>> do
>>>          cat /root/tmp.txt > /dev/null
>>>          measurement=`cat /sys/kernel/security/ima/ascii_runtime_measurements | grep "tmp\.txt" | wc -l`
>>>          if [ "${measurement}" == "1" ]; then
>>>                  echo "measurement found"
>>>                  exit 1
>>>          fi
>>> done
>>
>> test.sh:
>>> #!/bin/bash
>>>
>>> echo "measure obj_user=system_u obj_role=object_r obj_type=unlabeled_t" > /sys/kernel/security/ima/policy
>>>
>>> cat /root/tmp2.txt
>>> measurement=`cat /sys/kernel/security/ima/ascii_runtime_measurements | grep "tmp2\.txt" | wc -l`
>>> [ "$measurement" == "1" ] && echo "measurement for tmp2 found"
>>>
>>> cat /root/tmp.txt
>>> measurement=`cat /sys/kernel/security/ima/ascii_runtime_measurements | grep "tmp\.txt" | wc -l`
>>> [ "$measurement" == "1" ] && echo "measurement for tmp found, preparation failed!" && exit 1
>>>
>>> ./read_tmp_measurement.sh &
>>> pid=$!
>>>
>>> cd /usr/share/selinux/default
>>> semodule -i clock.pp.bz2
>>> semodule -r clock
>>>
>>> kill ${pid}
> 
> Are you loading/unloading any selinux policy or specifically clock? If
> specifically clock, what is special about it?

No there are nothing special about clock. Any selinux policy should do,.
> 
>> I created two files tmp.txt and tmp2.txt, assign them with type
>> user_home_t and unlabeled_t respectively and then run test.sh.
>> On a multi-core environment, I managed to reproduce this issue pretty
>> easily and tested that once the solution is merged, the issue stops
>> happening.
> 
> As I only see an IMA measurement policy rule being loaded for
> "unlabeled_t" and not "user_home_t", should I assume that an IMA
> measurement rule already exists for "user_home_t"?

There wasn't a rule for user_home_t. These scripts demonstrate that 
during a selinux policy reload, IMA would measure files that is not in 
the range of it's LSM based rules. Which is the issue I am trying to fix.

In this test, we only have one rule for measuring files of type 
unlabeled_t. However, during selinux policy reload, file of user_home_t 
is also measured.
> 
> thanks,
> 
> Mimi
> 

-- 
Best
GUO Zihua

