Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8F1C0032E
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Oct 2023 16:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjJYQrA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Oct 2023 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYQrA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 12:47:00 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DA129
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 09:46:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SFvd70SLLz9xqwl
        for <linux-security-module@vger.kernel.org>; Thu, 26 Oct 2023 00:33:47 +0800 (CST)
Received: from [10.48.135.27] (unknown [10.48.135.27])
        by APP1 (Coremail) with SMTP id LxC2BwA3Q5RrRjllMzTnAg--.561S2;
        Wed, 25 Oct 2023 17:46:42 +0100 (CET)
Message-ID: <212613fc-6539-4031-94b7-175fd5a2603e@huaweicloud.com>
Date:   Wed, 25 Oct 2023 18:46:33 +0200
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
 <f47097f8-3391-42a7-b8b5-81e1be2d8e68@huaweicloud.com>
 <88f4f464-ac09-4c93-95f4-fe4546b78a08@schaufler-ca.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <88f4f464-ac09-4c93-95f4-fe4546b78a08@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwA3Q5RrRjllMzTnAg--.561S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw18Kry8JFyUZFyDCw1fCrg_yoW8uF18pF
        WrtayjkF4ktw1F93sYya15Za4jk393XFy5X3s8J34Uu34qqryvvrZrJF4Y9a98Gr4Iv34F
        vF4ag34aka4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBF1jj5WEzQABso
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/23/2023 5:48 PM, Casey Schaufler wrote:
> On 10/23/2023 8:20 AM, Roberto Sassu wrote:
>> On 10/20/2023 11:56 PM, Casey Schaufler wrote:
>>> On 10/19/2023 1:08 AM, Roberto Sassu wrote:
>>>> On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
>>>>> When IMA becomes a proper LSM we will reintroduce an appropriate
>>>>> LSM ID, but drop it from the userspace API for now in an effort
>>>>> to put an end to debates around the naming of the LSM ID macro.
>>>>>
>>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>
>>>> This makes sense according to the new goal of making 'ima' and 'evm' as
>>>> standalone LSMs.
>>>>
>>>> Otherwise, if we took existing LSMs, we should have defined
>>>> LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
>>>>
>>>> If we proceed with the new direction, I will add the new LSM IDs as
>>>> soon as IMA and EVM become LSMs.
>>>
>>> This seems right to me. Thank You.
>>
>> Perfect! Is it fine to assign an LSM ID to 'ima' and 'evm' and keep
>> the 'integrity' LSM to reserve space in the security blob without LSM
>> ID (as long as it does not register any hook)?
> 
> That will work, although it makes me wonder if all the data in the 'integrity' blob
> is used by both IMA and EVM. If these are going to be separate LSMs they should probably
> have their own security blobs. If there is data in common then an 'integrity' blob can
> still makes sense.

Question, it might be better to ensure that 'evm' is after 'ima' like 
when function calls were hardcoded.

I'm enforcing 'ima' and 'evm' to be the last.

In this case, since we have:

         /* LSM_ORDER_LAST is always last. */
         for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
                 if (lsm->order == LSM_ORDER_LAST)
                         append_ordered_lsm(lsm, "   last");
         }

and:

obj-$(CONFIG_IMA)                       += ima/
obj-$(CONFIG_EVM)                       += evm/

in the integrity Makefile, can I assume that the order will always be 
'ima', 'evm'?

I tried to invert obj-, and indeed the order is inverted. They are not 
mutable LSMs, their order should not depend on the kernel command line. 
Right?

Thanks

Roberto

