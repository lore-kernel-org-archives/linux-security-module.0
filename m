Return-Path: <SRS0=n7+0=3X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B9C35247
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 19:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4EB2082E
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 19:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580757634;
	bh=GTEEXcLQZg3VEEvzYVd/GqVV9VtGzYLXf4pAj9YF4C4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zy+NASRw0jbeQDdtFhosb/rwBveePPk/g94xIUN6AfMy10SxpUUQ5HL99zqAjM5ZO
	 TX2adVCRrIV3B6A8VSW/Z7GzcuU4dRNbJTmcL76Nc4U4aDpQmFcGDts/zeHk1xXVit
	 a+DiFX/h39aWmATa4GLz8VWuBfYdJ5NKT1FUIzDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgBCTUe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:20:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55375 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgBCTUe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Feb 2020 14:20:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so519628wmj.5
        for <linux-security-module@vger.kernel.org>; Mon, 03 Feb 2020 11:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1iYbXocdYEH5oXypfZqt5PJlhBuoAhxQfxeB0+Xy080=;
        b=FAdsYDdZy/1yVlA4TnSFFPrIm2korvILQmMzZsUShxMMlQGhr/ZdcH1TQ6UyIfTLa1
         f/dY5ZzaGo/SS61bFP/sHBavu9M7SqJ9fsl69n+AgVgRyc9gVzaKynBVEk1wqhyNkdSD
         ebYvs+EpTvcDdBMHyZSgUadxDzOhZE2VT6neI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1iYbXocdYEH5oXypfZqt5PJlhBuoAhxQfxeB0+Xy080=;
        b=pfrX1GiwBX0a1ZZbt9Xww8V6bqv22YibaWvGUEfog37lemqNE3FYZxE7+jdbcTQWIR
         bZkb9sCExWerqNL3SHsL5caa4WQKRWldwJPan79Ftsjd2/DDMvyy3gCt8c/GFMHwrwVk
         0R7VeFcACVLF24ibyo+FGloGO0Gqvdhj+giusmOXm+q7gtqRTRHkHJdVE0qXur2RzDXo
         oa9fZFmVshgpnEZPiG5Pq/2n7BXjXA5FVBaQ9eqIQP3VzMCk6uMak4e75/Svek82AOM9
         dmvXFL8P27iZJRb8OtIr0k+hT1xGxI2TlF1zDPeMOIaVAOoP3RxfOsv71x4yiPGOuGYL
         5kAQ==
X-Gm-Message-State: APjAAAWW7LaIE59UdF4RAFeMG5u54c3LV9ZiH1gL5nLuIS1r8IVAPMdK
        Psg6fgj8U/6va4kMIM/zswgIiw==
X-Google-Smtp-Source: APXvYqx4wh9pQL32uf2/HGgfn5z5nunD70oC5Stic6BGQcQOQAPj7Bk8NvVlChCU6i+olA+oPc+7gw==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr543964wmk.124.1580757632086;
        Mon, 03 Feb 2020 11:20:32 -0800 (PST)
Received: from [172.16.13.174] (host81-133-38-158.in-addr.btopenworld.com. [81.133.38.158])
        by smtp.gmail.com with ESMTPSA id 21sm453824wmo.8.2020.02.03.11.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 11:20:31 -0800 (PST)
Subject: Re: [PATCH] security/integrity: Include __func__ in messages for
 easier debug
To:     Joe Perches <joe@perches.com>, Mimi Zohar <zohar@linux.ibm.com>,
        jmorris@namei.org, serge@hallyn.com, mpe@ellerman.id.au,
        erichte@linux.ibm.com, nayna@linux.ibm.com, yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200130020129.15328-1-skhan@linuxfoundation.org>
 <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
 <1580736077.5585.4.camel@linux.ibm.com>
 <475ab05c-300b-fdbe-5de0-6fce8d1a360d@linuxfoundation.org>
 <94cf0aee8fd8b78718e252488458cfea105c0469.camel@perches.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ea69b0a9-cb8e-a894-dea6-bd7ab30b9dc5@linuxfoundation.org>
Date:   Mon, 3 Feb 2020 12:20:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <94cf0aee8fd8b78718e252488458cfea105c0469.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/3/20 12:02 PM, Joe Perches wrote:
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
>>>>>    .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
>>>>>    security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
>>>>>    2 files changed, 18 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
>>>>
>>>> perhaps instead add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>> so all the pr_<level> logging is more specific.
>>>>
>>>> This would prefix all pr_<level> output with "integrity: "
>>
>> Joe! Sorry for the delay in getting back to you.
>>
>>> Agreed.  Joe, could you post a patch with a proper patch description
>>> for this?
>>>
>>
>> I have been looking into this a bit more and there is an opportunity
>> here to add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt to integrity.h
>> and get rid of duplicate defines.
> 
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
> 
> 

What I have in mind is replace the ones under security/integrity/
adding the define to  integrity.h is under security/integrity.

I would leave the security/security.c:#define pr_fmt(fmt) "LSM: " fmt
alone and just replace the ones under security/integrity/ in which case
KBUILD_MODNAME will show integrity as the module.

thanks,
-- Shuah




