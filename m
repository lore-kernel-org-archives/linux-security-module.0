Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543B8C433F5
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Nov 2021 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31782610D0
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Nov 2021 16:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhKERBa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhKERB3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Nov 2021 13:01:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A010C061714;
        Fri,  5 Nov 2021 09:58:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gn3so3462829pjb.0;
        Fri, 05 Nov 2021 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Dm/tkXe8vrCYnsbfNrGgeQZgPuQ1rWi9SOlQuOERJiI=;
        b=UlgE/YQSPQJWMfUCwYhCOqMFMyTOzpcRoFGeVLHrFwMjU1iG9rKTvQzHGlDVFkLOif
         nz2oGZJ1mrmILyfc7DAGyBmoFpWLwE0snPV1E61vYv2HKle3i6L0B/nWriJgQhTwrmTl
         TF0QAerEaUNMjLFqoXZRVALTfh9NDSHa1TYrtBzJrspT16kiXkysTx2ZbisaMpJ9RTSz
         IImS8hwU48HL1JpMLXPxI1xKjNop82xMh9LoIIiFRHSnVNOtxVU++8lGU47O9fpN6Mtv
         FVnrIkBVcs0aBL1B+y04O2oLdA70zx0tvk6GMz8LM1cIKWxAQa2O1KD6vDo15qloWAPN
         zbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dm/tkXe8vrCYnsbfNrGgeQZgPuQ1rWi9SOlQuOERJiI=;
        b=otzEm1PISloyZN7zf0gwW2o00zcBBKQ+rs9y1NKaANJq8vIMtw/sGQ85tdkllsK/FH
         i1Ha9ZD4+Gp8f5Nykx4yFX0PMSANHscXf9p+CpOMbrD1ZL43FTgX2Y5RvdQb7uxSL2Fm
         A35CDhkE+5WJ+Xm96DV/LFFvS39mXpiVAHPzIlEEk/D8GWeNLo0hhh1pRe7TYTA8+zgM
         4KACmPESBEiEh6y88DwceTHwInl+8P41a/0vS6Kfvjo88NkBNZYLMZmsszhWyFLmHqOU
         PjWfyobFIGaJA0Y2yH78GvnHebJUK5pT7kOyrbd9VA7D2cbL+2rtWVw5I2iOzR1q8v1g
         Hoyw==
X-Gm-Message-State: AOAM531U1scfbZ03zT/FUHfQ45hUYGb7Rm79XpGbwuSDMFtlzWrIzxcA
        aECn6px0cuKzLzxy59ONBxA=
X-Google-Smtp-Source: ABdhPJxM2R0qJcfJqVo7o/snSZySDmo6F9vZuLLmqo8/DfMX02pan77bXrd9rpIJGITUbEsvFUv7iQ==
X-Received: by 2002:a17:90b:4d84:: with SMTP id oj4mr26973402pjb.90.1636131529539;
        Fri, 05 Nov 2021 09:58:49 -0700 (PDT)
Received: from [192.168.1.194] ([50.39.237.102])
        by smtp.gmail.com with ESMTPSA id mz7sm4659568pjb.7.2021.11.05.09.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 09:58:48 -0700 (PDT)
Message-ID: <136709ac-1fbe-80d0-f49f-8a0399106ad8@gmail.com>
Date:   Fri, 5 Nov 2021 09:58:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] landlock: Initialize kernel stack variables properly
Content-Language: en-US
To:     Austin Kim <austindh.kim@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211103071427.GA13854@raspberrypi>
 <7a71215c-58f4-081b-6a2e-030073f2737e@digikod.net>
 <CADLLry4zYn-NZBtC3pdQpb4c_3vvzNfc71rBrXc-oXqgSZNHaQ@mail.gmail.com>
From:   J Freyensee <why2jjj.linux@gmail.com>
In-Reply-To: <CADLLry4zYn-NZBtC3pdQpb4c_3vvzNfc71rBrXc-oXqgSZNHaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 11/4/21 4:41 AM, Austin Kim wrote:
> 2021년 11월 3일 (수) 오후 9:14, Mickaël Salaün <mic@digikod.net>님이 작성:
>> Hi Austin,
>>
>> On 03/11/2021 08:14, Austin Kim wrote:
>>> In case kernel stack variables are not initialized properly, there might
>>> be a little chance of kernel information disclosure. So it is better for
>>> kernel stack variables to be initialized with null characters.
>>>
>>> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
>>> ---
>>>   security/landlock/syscalls.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
>>> index 32396962f04d..50a6f7091428 100644
>>> --- a/security/landlock/syscalls.c
>>> +++ b/security/landlock/syscalls.c
>>> @@ -320,6 +320,8 @@ SYSCALL_DEFINE4(landlock_add_rule,
>>>        if (rule_type != LANDLOCK_RULE_PATH_BENEATH)
>>>                return -EINVAL;
>>>
>>> +     memset(&path_beneath_attr, 0, sizeof(path_beneath_attr));
>>> +
>> This memset is already done with the copy_from_user() call just below.
>>
> It seems that memset() is done inside copy_from_user().
> Thanks for feedback.

If you are really sensitive of what information may be disclosed in this 
case you can consider memzero_explicit() to use instead:

https://www.kernel.org/doc/htmldocs/kernel-api/API-memzero-explicit.html

Jay

>
> BR,
> Austin Kim
>
>>>        /* Copies raw user space buffer, only one type for now. */
>>>        res = copy_from_user(&path_beneath_attr, rule_attr,
>>>                        sizeof(path_beneath_attr));
>>>

