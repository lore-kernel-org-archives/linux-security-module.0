Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4DBC43217
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Oct 2022 14:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJTOsa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Oct 2022 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiJTOs1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Oct 2022 10:48:27 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158751A9938
        for <linux-security-module@vger.kernel.org>; Thu, 20 Oct 2022 07:48:25 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 137so17349054iou.9
        for <linux-security-module@vger.kernel.org>; Thu, 20 Oct 2022 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyEdOXlSndo4uPk0KrVGETvK2q5egPgUditt+XNxMhY=;
        b=OR/n+1S46f9Lbwdl/bgTk3mD6NamxcPNZRk3ZIHZ5tJM3eBKfya/KL7bwJ8DBc02bM
         wy+c1jHW/LJnGfAvqETtwqd8B8V222mpUAPfT8IvsA118iY4NcNnpneGkU19DEfgKab4
         xZrpZ01PcEHUdttIvcdgNJq21ocLQIm4MOvhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyEdOXlSndo4uPk0KrVGETvK2q5egPgUditt+XNxMhY=;
        b=Y736pnHEvFaBtK0FVFvKyfeHBxy5AZqtgvUc8JnkxI5E39tdUoM2JQ3Qir56/VWm1+
         7k4oZ17hot1Qtxyunpjegrz0QQXDs52tT1YLEFhAwVpl7cGoAPemKF8JmYMZadvntYvU
         9IzLSYlJc5lbnNRXFkyf9YVrMCn3TajjML98iIcb6m1ix3KH4F18mGW6AZK4Znmb+Qva
         KgbKpHSOqWYJmvs0c8Q2ZXco6R5Xp1f2ysBu8kF09L0A0ApbgmlTI1SAFtllKxqtlYmS
         allSJKURg9vmxz+nm0GLrf4TH0ZRejO2pgw1wzSDSM4XA2vKg5I4gWKrkuOxOG4HMI6j
         vH7Q==
X-Gm-Message-State: ACrzQf2XKB7Wr/6+XUcM4/9gkLkRqPN4DWAo7Zl/Fbt35SzUsk6Zm8Hl
        bb+ql9ttkrvaZRZre3H4NkZsJA==
X-Google-Smtp-Source: AMsMyM6he7Y1M5zvSAzivZb5Bof1fIpsetVQw2snw3rRtp0M4glmp6g2HZ+ju3wV9Zth78xTjuZsUw==
X-Received: by 2002:a05:6602:134f:b0:6a4:cd04:7842 with SMTP id i15-20020a056602134f00b006a4cd047842mr10252219iov.172.1666277304428;
        Thu, 20 Oct 2022 07:48:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m21-20020a023c15000000b0035a40af60fcsm3350204jaa.86.2022.10.20.07.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 07:48:23 -0700 (PDT)
Message-ID: <8612a1aa-4920-e069-b252-137c51c6b04f@linuxfoundation.org>
Date:   Thu, 20 Oct 2022 08:48:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1] selftests: Use optional USERCFLAGS and USERLDFLAGS
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220909103901.1503436-1-mic@digikod.net>
 <80053942-2e24-b31a-8795-1f81d4b52e67@digikod.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <80053942-2e24-b31a-8795-1f81d4b52e67@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/20/22 08:17, Mickaël Salaün wrote:
> Hi Shuah, what do you think about this patch?
> 

Thanks for the ping.

> On 09/09/2022 12:39, Mickaël Salaün wrote:
>> This change enables to extend CFLAGS and LDFLAGS from command line, e.g.
>> to extend compiler checks: make USERCFLAGS=-Werror USERLDFLAGS=-static
>>
>> USERCFLAGS and USERLDFLAGS are documented in
>> Documentation/kbuild/makefiles.rst and Documentation/kbuild/kbuild.rst
>>
>> This should be backported (down to 5.10) to improve previous kernel
>> versions testing as well.
>>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20220909103901.1503436-1-mic@digikod.net
>> ---
>>   tools/testing/selftests/lib.mk | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>> index d44c72b3abe3..da47a0257165 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -119,6 +119,11 @@ endef
>>   clean:
>>       $(CLEAN)
>> +# Enables to extend CFLAGS and LDFLAGS from command line, e.g.
>> +# make USERCFLAGS=-Werror USERLDFLAGS=-static
>> +CFLAGS += $(USERCFLAGS)
>> +LDFLAGS += $(USERLDFLAGS)
>> +
>>   # When make O= with kselftest target from main level
>>   # the following aren't defined.
>>   #
>>
>> base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179

Sorry for the delay. Looks good to me. I will apply to next to get
some soak time and get this into 6.2.

thanks,
-- Shuah


