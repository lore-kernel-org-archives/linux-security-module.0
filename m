Return-Path: <SRS0=n7+0=3X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907D6C35249
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 18:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B31B2086A
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580756128;
	bh=aU6fT25DxtRCHhfhKhLA3qZuJBIi/kULcOFBgTIdv+s=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GgEe/33nWaxfFjFLEekCeinoW0Bfp6WmELp5G6ZO2D63lP6kvu5/KW7Hh4Ry+0wmO
	 gKs/fktU4gYVkemeBykozIavA5DJ7XkNndHutYzRbRG8cYceg+CehdDKrkb5T2DSpA
	 Mjb8wIVFJEM+M2G8LuU3slVmOVMnS+frR5V+MW6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBCSz1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:55:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38828 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbgBCSz0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Feb 2020 13:55:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so537813wmj.3
        for <linux-security-module@vger.kernel.org>; Mon, 03 Feb 2020 10:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ie8CpiNgWDcburcuPjt9H+F+5SRbzWgUOwncPrTzNjY=;
        b=VaUcSm01GK2R+CNaS7gDPrQciZt9PkQZViXyJJN1yKtmv5CEpy6eHLWR7NHgUXiP+w
         NGdJdKcjqITXZ6FgRLg/5ib+Sf7Fzhrg+IZjXvecsrs29ShnFPdpitU2qpYIcs6TnE7m
         coHz6yHHPGGVS3TQrMNKlpHbYs14wOtYBtq2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ie8CpiNgWDcburcuPjt9H+F+5SRbzWgUOwncPrTzNjY=;
        b=PlbdR+2QtRySrfIeVv+cGlfe0ZHX9rBkEgA11WvkS86904fDi6p7YOvH8UamAh08XT
         H0KuwgXrg7ZnSYJGa2yqijQ1xS9M2ec+mlv8edlUceeqwWltOw4EXKLWk4qW5v5F8r3C
         IpmITgkCzZ1HFF0v6OJ5AwxMV0hq7uaqEnyQGrLX8fNxN4zokIrr2vG7EGusgTaVXtT5
         x1KzXRkFDYsNwBWONRIjxUwfmDDpv4tzDyUy+xVqk4hNjhXndxg5nr+mCqJhzhWxpppU
         kCFejZmGUaonJtG7I2NbGQW3hJwJcrVYO3ZbXgOdClleYNgB1Or854Pf5LIYupYjUe65
         1vXQ==
X-Gm-Message-State: APjAAAUo+npouN7fW72VeK4TJffGSvKYazwPoSyvz9CFF7GSPBUVPCTM
        NYeVK2PQDM7OZaJPrS8+ZYvbDw==
X-Google-Smtp-Source: APXvYqy0iI5mT5cFrZRL2s+mHaug6jkUnHE10yjltHvFAP0FlmSRkbUXH7Jq571mpmoVVFVJjqUibQ==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr461827wmi.17.1580756124265;
        Mon, 03 Feb 2020 10:55:24 -0800 (PST)
Received: from [172.16.13.174] (host81-133-38-158.in-addr.btopenworld.com. [81.133.38.158])
        by smtp.gmail.com with ESMTPSA id h10sm24728152wre.3.2020.02.03.10.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 10:55:23 -0800 (PST)
Subject: Re: [PATCH] security/integrity: Include __func__ in messages for
 easier debug
To:     Mimi Zohar <zohar@linux.ibm.com>, Joe Perches <joe@perches.com>,
        jmorris@namei.org, serge@hallyn.com, mpe@ellerman.id.au,
        erichte@linux.ibm.com, nayna@linux.ibm.com, yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200130020129.15328-1-skhan@linuxfoundation.org>
 <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
 <1580736077.5585.4.camel@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <475ab05c-300b-fdbe-5de0-6fce8d1a360d@linuxfoundation.org>
Date:   Mon, 3 Feb 2020 11:55:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580736077.5585.4.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/3/20 6:21 AM, Mimi Zohar wrote:
> On Wed, 2020-01-29 at 19:08 -0800, Joe Perches wrote:
>> On Wed, 2020-01-29 at 19:01 -0700, Shuah Khan wrote:
>>> Change messages to messages to make it easier to debug. The following
>>> error message isn't informative enough to figure out what failed.
>>> Change messages to include function information.
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>> ---
>>>   .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
>>>   security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
>>>   2 files changed, 18 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
>>
>> perhaps instead add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> so all the pr_<level> logging is more specific.
>>
>> This would prefix all pr_<level> output with "integrity: "
> 

Joe! Sorry for the delay in getting back to you.

> Agreed.  Joe, could you post a patch with a proper patch description
> for this?
> 

I have been looking into this a bit more and there is an opportunity
here to add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt to integrity.h
and get rid of duplicate defines.

thanks,
-- Shuah



