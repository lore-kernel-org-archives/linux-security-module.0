Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF31C6FA82
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 14:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiIWObr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiIWOb2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 10:31:28 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D858813EEA2
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 07:31:25 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id g12so240006ilj.5
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 07:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HGCf2CEH8Pze7w6/yHjPsApA3KSaCMjYFuFN/oMe1oY=;
        b=COf4mUkCy0J/hewdcFUot+/GptzPuCtGrmUOOSuIET0uLNlUSmhQW5R/5K6aCcAuDS
         Boeerq18H9HPShuMX4r8Kpm3nozSvzzIDtHvIKJPwl67AKZ7vpnFjt9Ylj8MPZZbRP/3
         2+6Zjczk0/PxHue8RsLCnj0AtZwPwD2YzIGsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HGCf2CEH8Pze7w6/yHjPsApA3KSaCMjYFuFN/oMe1oY=;
        b=t/u4x8QFJneYdPk1l2ubJsrTTuBVWKY+WB3UL8l2IxdaGqqKbfARGFbv0rmsz/7J2G
         gYWZGvC3FRB/sLcYL913A7vLZnDZcZmO7RAFLeg/9L3moXaMUTEedzlLLSuZj7/ZCKd6
         qmeAk3TMR+ttutBRDz7CATzbRi/L5u0IOGZ5D9GoULFm/T/CByVVDLSBI2uRP5V4WRbv
         7gULeUe6fjG/iUpKWdz8rXEDBXLQ4BFJjnExYnVYXVz8TtmzViVcaoGyXsqKx80FlllQ
         7iHcXbdjtUPRE/9QUv6dImlA/fKepK6JHUXVexPT4lxQQB+eOlU747Z00dGclaK0DuZK
         mYrA==
X-Gm-Message-State: ACrzQf0FMcxLVxHmejjyhOBLZNVUfPcWPL7xFoK698JmN9dDlQJ/C49N
        C+wmS6qa+jriLugm2XcxMZVs4w==
X-Google-Smtp-Source: AMsMyM6tXJVRa8Ovs7CGzDxQ/BOFGz+7XqZt8CHp4EsyF8+4qZpAiKek3gXenARMzODcfNx5yMo7tA==
X-Received: by 2002:a92:730c:0:b0:2f5:7dd7:45f7 with SMTP id o12-20020a92730c000000b002f57dd745f7mr4279062ilc.12.1663943485147;
        Fri, 23 Sep 2022 07:31:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c37-20020a023b25000000b0034a56f2f120sm3378709jaa.155.2022.09.23.07.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:31:24 -0700 (PDT)
Message-ID: <0d7e2c9d-dffc-d68e-c475-7933806d3ffa@linuxfoundation.org>
Date:   Fri, 23 Sep 2022 08:31:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] selftests/landlock: Fix out-of-tree builds
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220909103402.1501802-1-mic@digikod.net>
 <5e288153-ca6b-a91d-a3fd-cd2b1e102b3e@digikod.net>
 <21feac5f-27d1-60ca-0c06-6605f3f27474@digikod.net>
 <2879477f-82d9-9d39-13b6-9cc60a3f14c7@digikod.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2879477f-82d9-9d39-13b6-9cc60a3f14c7@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/22/22 03:18, Mickaël Salaün wrote:
> I plan to push it to Linus tomorrow, I'd like to get some feedback by then though.
> 
> 
> On 14/09/2022 16:43, Mickaël Salaün wrote:
>> I took the liberty to pushed it in -next with my tree:
>> https://git.kernel.org/mic/c/a52540522c9541bfa3e499d2edba7bc0ca73a4ca
>>
>> Please let me know when you can take it in your tree to include it in
>> the next -rc.
>>
>> Regards,
>>    Mickaël
>>

Looks good to me. Thanks for doing this. Linux Plumbers travel and
subsequent being under the weather caused the delay in a response
to this patch.

I also saw your pull request to Linus.

thanks,
-- Shuah
