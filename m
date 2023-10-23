Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7E2C004C0
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Oct 2023 15:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjJWPUa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Oct 2023 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjJWPU3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Oct 2023 11:20:29 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9029FFD
        for <linux-security-module@vger.kernel.org>; Mon, 23 Oct 2023 08:20:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SDdl42z2wz9v7cD
        for <linux-security-module@vger.kernel.org>; Mon, 23 Oct 2023 23:04:32 +0800 (CST)
Received: from [10.206.134.65] (unknown [10.206.134.65])
        by APP1 (Coremail) with SMTP id LxC2BwCH4JEmjzZl7QTGAg--.12433S2;
        Mon, 23 Oct 2023 16:20:11 +0100 (CET)
Message-ID: <f47097f8-3391-42a7-b8b5-81e1be2d8e68@huaweicloud.com>
Date:   Mon, 23 Oct 2023 17:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
References: <20231018215032.348429-2-paul@paul-moore.com>
 <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
 <1764a96f-6d24-4585-a24b-667a5ea075c3@schaufler-ca.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <1764a96f-6d24-4585-a24b-667a5ea075c3@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCH4JEmjzZl7QTGAg--.12433S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4DWryUuFyUZw17XrWkWFg_yoW8ur43pr
        n8KFW7tFWUZF17Cw4Iv3ZxAw17CFWkJr17W34Uuw4Uta1FyF97trs2gF4akrn0qr4vyrWr
        KFnFq345u3srArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj5FfcAAAsa
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/20/2023 11:56 PM, Casey Schaufler wrote:
> On 10/19/2023 1:08 AM, Roberto Sassu wrote:
>> On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
>>> When IMA becomes a proper LSM we will reintroduce an appropriate
>>> LSM ID, but drop it from the userspace API for now in an effort
>>> to put an end to debates around the naming of the LSM ID macro.
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> This makes sense according to the new goal of making 'ima' and 'evm' as
>> standalone LSMs.
>>
>> Otherwise, if we took existing LSMs, we should have defined
>> LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
>>
>> If we proceed with the new direction, I will add the new LSM IDs as
>> soon as IMA and EVM become LSMs.
> 
> This seems right to me. Thank You.

Perfect! Is it fine to assign an LSM ID to 'ima' and 'evm' and keep the 
'integrity' LSM to reserve space in the security blob without LSM ID (as 
long as it does not register any hook)?

Thanks

Roberto

>> Roberto
>>
>>> ---
>>>   include/uapi/linux/lsm.h | 15 +++++++--------
>>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>>> index eeda59a77c02..f0386880a78e 100644
>>> --- a/include/uapi/linux/lsm.h
>>> +++ b/include/uapi/linux/lsm.h
>>> @@ -54,14 +54,13 @@ struct lsm_ctx {
>>>   #define LSM_ID_SELINUX		101
>>>   #define LSM_ID_SMACK		102
>>>   #define LSM_ID_TOMOYO		103
>>> -#define LSM_ID_IMA		104
>>> -#define LSM_ID_APPARMOR		105
>>> -#define LSM_ID_YAMA		106
>>> -#define LSM_ID_LOADPIN		107
>>> -#define LSM_ID_SAFESETID	108
>>> -#define LSM_ID_LOCKDOWN		109
>>> -#define LSM_ID_BPF		110
>>> -#define LSM_ID_LANDLOCK		111
>>> +#define LSM_ID_APPARMOR		104
>>> +#define LSM_ID_YAMA		105
>>> +#define LSM_ID_LOADPIN		106
>>> +#define LSM_ID_SAFESETID	107
>>> +#define LSM_ID_LOCKDOWN		108
>>> +#define LSM_ID_BPF		109
>>> +#define LSM_ID_LANDLOCK		110
>>>   
>>>   /*
>>>    * LSM_ATTR_XXX definitions identify different LSM attributes

