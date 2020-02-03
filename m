Return-Path: <SRS0=n7+0=3X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B032AC35247
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AAD2086A
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 19:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z/wsxvxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgBCTXM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:23:12 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:34370
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgBCTXM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Feb 2020 14:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580757791; bh=m04hdUq0vSJYN7FwmXA5JyxorPmYXrpHS7EBKRIz/1o=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Z/wsxvxcVHfdCwwhY2/JswytE96v3pjZdzgS6XOjqM4lXNsE/ysh6c+krCercFDtnuaJJUz96nzqpCVuX9L83YwNbxl2vOIcxekihl+2jBmR4GS4FHD4F41+4Y9m2YZ6U9nhSTYfj/lzqyzjO+zHlYSWKHA7t2wjlfzEdYxKu60e1R2rBpOMM7+PlrVG0iSiGf5b9uJNNGYfcBOwD+Zxr+06+nv1mMpUsihrTe0Yte7X38qG0Mc5mc3IwnRK4LF8O4gkoy8+WP2zQbC3rFEgiweikCy1qzcXm+Ydi7/hTmlZPjuRFOn19wjK2XDe0VuzavFkq63BKbaDfypXFDDqyQ==
X-YMail-OSG: uaNPZ04VM1lsZadqFPrArJl99cVhgpDq1n7OwJJoOk8Mki8HUOPcvvRi8smDxGi
 ymzom1gHFem5PV3ZNP9FhY_bE.q6g4LlrqWVTxc4WL_BrpG.ZM4wcaqM2UER800C89IM1A6LCWI4
 by4MPaqqgRxf50PPvNq4KA6Llj42Tz1hdQpQT5GjTrWl3Z4mM7QXuzgLmm4EbMzwivtFw2ooSSkK
 ZKnL9XxDjlqp26UBuu0gv2RgCKZhOOGGzkSrqmFtHLvJQIUnesrcF6jbuQ6YVhL1OT4zkBK6S9T3
 Idxq77K7QkjpbBB9U28Fy29zCDYctb2dkyZ0ythqa2sTcI6LEWZiSHC6I3Awzux5fFwsXPBzDMsD
 P8kTtAPcHx.zhu19nwyQDBDR5gU20OWbePQj.hconGXSgTwwW7HNyKnNqu91JdOtbXxQV5pkto8V
 t8B0b19XT.kZLi69BP96Dxc7gx_pXlLlTXHCDaFZljxrKKrL5HsnAisaV.axw7qZVVvIVfixDUbs
 8Ia8gPFI7nzjTiBZfkQON7VcHucUJQ1rB3MRuIPIj1mUTOsyssvja4BMX_kWOcPGgDckslnSuWhB
 CbfOAyirgUyIQI0JMSyez80DCkJ_vinZ7SE2m1q7.buy.ipTSbszbcw.R.e1NfiksUwZUMKMgey4
 EASka3pVitR9LKte8YhvkWr8bUoiADm6k6uOBuSMOx2hEU6lhxEp6B5TIkREfn9O4qOyWCILLZ2k
 X68PvSP4fWBoh2mk1fWayyAeP6s5wnirHQxb4F1i1oHXdbvbhjCdKCiRngeNSbEHHKeDYc06vW0Y
 jicjGbGnZDJYmWGDr0Z4nPHxTomlpFch.SSEwRN_jZ2t_rdAjAt3f6OYL_uhkFItlwWkb61D2_xu
 a5Bk1oR0Ikxqf6wxTUE0_EEKclZipY6lb6LO2AAbb4R722.Fza8evddPX_Dayi3MDRqM0l0v.ggv
 TsGbtveAGnAHVu2obHYAde8tvP1TW8BffF2bP_2FqnZoKKfRV6hcnf4Ycg09.yCyCFM1KjmpC7fP
 PQ1PQRAoWdwW9IsE65_gnqzxiwvjrZgp721ZzQ8gFh5oRtXtdt.SWG6Je.i1tgdr0pGV2nPYMqqX
 LLk4fMDGMS8debrWgbW.OYyouJT79kREDtpWbw9e2cj9SC9ynwfNmegM5omwRMZfq0U2Z40.YGh0
 Q.ZUKVN.fnOp8_.X4Cv2eCanneK4aWyW88tEiLQoXG1wqTZV.pIJAT5cVMDK1RRynSX3SJe5Tp8R
 aHKM59BH3oXAkd1PB6FMAOhtFJwf9PZnRl0YIGVfRrZVVA1FnKo84QrZTTyCH0q.ANmrvMsE1mYq
 7Gx12JSCvP8NoouymnSC7sy.21jYTtvHJQX4w0ffkfReVBKvvmD0RzKijms0CygAu2J67ybrMgbn
 XDgE_4IAmxLVhTv8TkC3YNwdXMqWfjDVDq8k-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Feb 2020 19:23:11 +0000
Received: by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 265c91e734f63aa88ea65da42a7b3d47;
          Mon, 03 Feb 2020 19:23:09 +0000 (UTC)
Subject: Re: [PATCH] security/integrity: Include __func__ in messages for
 easier debug
To:     Joe Perches <joe@perches.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        serge@hallyn.com, mpe@ellerman.id.au, erichte@linux.ibm.com,
        nayna@linux.ibm.com, yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200130020129.15328-1-skhan@linuxfoundation.org>
 <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
 <1580736077.5585.4.camel@linux.ibm.com>
 <475ab05c-300b-fdbe-5de0-6fce8d1a360d@linuxfoundation.org>
 <94cf0aee8fd8b78718e252488458cfea105c0469.camel@perches.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e175a880-637c-20d4-e0dc-bff31287e0dc@schaufler-ca.com>
Date:   Mon, 3 Feb 2020 11:23:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <94cf0aee8fd8b78718e252488458cfea105c0469.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15149 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/3/2020 11:02 AM, Joe Perches wrote:
> On Mon, 2020-02-03 at 11:55 -0700, Shuah Khan wrote:
>> On 2/3/20 6:21 AM, Mimi Zohar wrote:
>>> On Wed, 2020-01-29 at 19:08 -0800, Joe Perches wrote:
>>>> On Wed, 2020-01-29 at 19:01 -0700, Shuah Khan wrote:
>>>>> Change messages to messages to make it easier to debug. The following
>>>>> error message isn't informative enough to figure out what failed.
>>>>> Change messages to include function information.
>>>>>
>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>> ---
>>>>>   .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
>>>>>   security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
>>>>>   2 files changed, 18 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
>>>> perhaps instead add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>> so all the pr_<level> logging is more specific.
>>>>
>>>> This would prefix all pr_<level> output with "integrity: "
>> Joe! Sorry for the delay in getting back to you.
>>
>>> Agreed.  Joe, could you post a patch with a proper patch description
>>> for this?
>>>
>> I have been looking into this a bit more and there is an opportunity
>> here to add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt to integrity.h
>> and get rid of duplicate defines.
> That might work but:
>
> $ git grep --name-only 'integrity\.h' security | xargs grep pr_fmt
> security/integrity/digsig.c:#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> security/integrity/digsig_asymmetric.c:#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> security/integrity/evm/evm_main.c:#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> security/security.c:#define pr_fmt(fmt) "LSM: " fmt
>
> Here security.c already uses "LSM: "
>
> Does anyone care about the LSM: prefix?

Yes. 

