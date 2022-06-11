Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD47BC433EF
	for <linux-security-module@archiver.kernel.org>; Sat, 11 Jun 2022 03:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349022AbiFKDY6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Jun 2022 23:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346923AbiFKDY6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jun 2022 23:24:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8899814;
        Fri, 10 Jun 2022 20:24:56 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKjpx6l8rzjX9X;
        Sat, 11 Jun 2022 11:23:53 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 11:24:54 +0800
Subject: Re: [PATCH -next] Revert "evm: Fix memleak in init_desc"
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220527111726.195825-1-xiujianfeng@huawei.com>
 <5842536c5c2bde1e3c2840f7e877becc3282b47c.camel@linux.ibm.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <c41f5f01-69ac-7dcf-5787-56a886db05a0@huawei.com>
Date:   Sat, 11 Jun 2022 11:24:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <5842536c5c2bde1e3c2840f7e877becc3282b47c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


在 2022/6/10 22:20, Mimi Zohar 写道:
> On Fri, 2022-05-27 at 19:17 +0800, Xiu Jianfeng wrote:
>> This reverts commit ccf11dbaa07b328fa469415c362d33459c140a37.
>>
>> Commit ccf11dbaa07b ("evm: Fix memleak in init_desc") said there is
>> memleak in init_desc. That may be incorrect, as we can see, tmp_tfm is
>> saved in one of the two global variables hmac_tfm ohr evm_tfm[hash_algo],
>> then if init_desc is called next time, there is no need to alloc tfm
>> again, so in the error path of kmalloc desc or crypto_shash_init(desc),
>> It is not a problem without freeing tmp_tfm.
>>
>> And also that commit did not reset the global variable to NULL after
>> freeing tmp_tfm and this makes *tfm a dangling pointer which may cause a
>> UAF issue.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> Agreed, thanks.  This was first reported by Guozihua (Scott) <
> guozihua@huawei.com>.  If neither you nor Scott object, I'll add his
> Reported-by tag.
Good for me,  thanks.
>
> thanks,
>
> Mimi
>
>
>
>
>
> .
