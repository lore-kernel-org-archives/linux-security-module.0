Return-Path: <SRS0=f5xb=ZY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FCBC432C0
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 23:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E782206F0
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 23:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCWx7HCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfLBXNm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:13:42 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36698 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBXNl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 18:13:41 -0500
Received: by mail-yw1-f67.google.com with SMTP id u133so552574ywb.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 15:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WfJr7IhB1Dobimakhp5eRl+/x8wWrFx8tg842PP7G1E=;
        b=jCWx7HCDfDfadewE/0tEGCwzp3l86CHb5wzgLhNXii57cf9YMc4EE5DuzOldC+5mPw
         wP0EEZRh6/m21UZZfoEDb2IivQQMwdQKez4xn8CM1kHXNfXuFoMCftqRgxHbJWJOW063
         45R1JxWXDIebYzbOdxBQ9Pt3FY5ebcj9brqi6xjWJNlo0XtRDjdsVnqbAbs2YudXQP2c
         p8C93l3DJfYBezshgtMb5U+XGbRrLj6rwdDfjH8j2j1gWajui9neMkamRjvkTwPGO6MT
         1GLdvxIjq6EhvRcU8m37hsVj6OU6I6DrnfylGvmi4AJvNfcO2HVb2UvfKBvlyYs/JEX6
         fRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WfJr7IhB1Dobimakhp5eRl+/x8wWrFx8tg842PP7G1E=;
        b=THP5W7yPHnYtlgt63UaOQqnWHk3AnauIBP8E9GNhQLY4LKeKDqWNwpjbtWwSe60Ttl
         bk8MHXRgzt1OpQpRCPNp9CboB07wTzN9GYNMK4GU3k15pULetlFt/XjSF3qQ34jChf+V
         gRglsNNKefD6RZScBOmZ9Iq28zh82M4GkVYAj1+ZM+CYymqxDffBBrPzgeHQPPzLLmte
         ZmljQRYx3XzXSZwgmW2SSZgv4oA3SjBGhXKURW/RG5HWByWGPYxo0kQHKepKVuTEJVnM
         dqnzOkog7d3aAJg07ZFTCmQBk0mySOfqprsgYCHbJuViX/yAnSLFU6Xv7Xo4a0rxKaF8
         jGQA==
X-Gm-Message-State: APjAAAXKEcFnhObqPbgjIqtpliIoGbO4Bjce2NvbmSGwIePYbF13GVTy
        ZOPy39ePcLqS4QhorQTd4lI=
X-Google-Smtp-Source: APXvYqyRxJXZ9aqmWLl3vlYnAPGXspTILf0Mkbf9B1L4Kn2B7p0yBGxpT1zYpSJh1Pu6LQhVzZ5+Xg==
X-Received: by 2002:a0d:c9c7:: with SMTP id l190mr1108258ywd.193.1575328420415;
        Mon, 02 Dec 2019 15:13:40 -0800 (PST)
Received: from [192.168.92.133] ([64.22.231.226])
        by smtp.gmail.com with ESMTPSA id d138sm602459ywb.3.2019.12.02.15.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 15:13:39 -0800 (PST)
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
 <201911301035.74813D4533@keescook>
 <f415ec28-8440-3b29-176c-50da09247ea3@gmail.com>
 <f988a531-a7f8-cef6-d3b4-6fbd89f5351f@gmail.com>
 <96625b06-3bba-6831-7127-22b690fccf1b@gmail.com>
 <-uRGQFmc8hMANlmvOpPXEib39VyGsx15MXwgVf-vripxhDcjILDfe5O17fyf5MXoZflmIE4avp7SqW4ijO1kHPqgHJMCqg1fWtXeGylu2uc=@protonmail.ch>
From:   Matt Parnell <mparnell@gmail.com>
Autocrypt: addr=mparnell@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c355cc94-3ea6-a0fb-af25-8871aae311aa@gmail.com>
Date:   Mon, 2 Dec 2019 17:13:12 -0600
MIME-Version: 1.0
In-Reply-To: <-uRGQFmc8hMANlmvOpPXEib39VyGsx15MXwgVf-vripxhDcjILDfe5O17fyf5MXoZflmIE4avp7SqW4ijO1kHPqgHJMCqg1fWtXeGylu2uc=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I am not presently in a position to check this as I tend to use the
ondemand cpu scheduler, and not userspace tools to manage CPU power
consumption, and get decent battery life doing so because of the built
in settings in the bios.

I can say with certainty that the second option is true, though, however
it should be noted that it is not just for power adjustments that the
MSRs need, at least in many cases to be readable -
spectre-meltdown-checker, for example, relies on checking an MSR to
determine if the foreshadow exploit is mitigated or not.

https://github.com/speed47/spectre-meltdown-checker

On 12/2/19 4:55 PM, Jordan Glover wrote:
> On Monday, December 2, 2019 6:29 PM, Matt Parnell <mparnell@gmail.com> wrote:
>
>> After doing some research it appears that for Intel chips, only a single
>> register needs to be writeable. I'm not sure about AMD etc.
>>
>> intel-undervolt/blob/master/config.h:
>>
>>     #define MSR_ADDR_TEMPERATURE 0x1a2
>>     #define MSR_ADDR_UNITS 0x606
>>     #define MSR_ADDR_VOLTAGE 0x150
>>
>> Perhaps add an MSR whitelist to allow writing, if
>> LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY=Y and
>> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=Y?
>>
>> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is likely what prevents Apparmor or
>> some other LSM policy manager allow this behavior...
>>
>> as an option at build time would be more sensible?
>>
>> On 12/1/19 2:53 PM, Matt Parnell wrote:
>>
>>> That is, I was intending to use lockdown from boot, which isn't
>>> changeable after the fact if I'm not mistaken. How possible is granular
>>> control of what is and is not locked down?
>>> On 11/30/19 1:09 PM, Matt Parnell wrote:
>>>
>>>> I can see how using a policy would be beneficial; I only did this
>>>> because as I understood it, policy wouldn't be able to change these
>>>> particular settings since anything attempting to do so would be from
>>>> userspace.
>>>> On 11/30/19 12:36 PM, Kees Cook wrote:
>>>>
>>>>> On Sat, Nov 30, 2019 at 12:49:48AM -0600, Matt Parnell wrote:
>>>>>
>>>>>> From 452b8460e464422d268659a8abb93353a182f8c8 Mon Sep 17 00:00:00 2001
>>>>>> From: Matt Parnell mparnell@gmail.com
>>>>>> Date: Sat, 30 Nov 2019 00:44:09 -0600
>>>>>> Subject: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access even
>>>>>>  in confidentiality mode.
>>>>>> For Intel CPUs, some of the MDS mitigations utilize the new "flush" MSR, and
>>>>>> while this isn't something normally used in userspace, it does cause false
>>>>>> positives for the "Forshadow" vulnerability.
>>>>>> Additionally, Intel CPUs use MSRs for voltage and frequency controls,
>>>>>> which in
>>>>>> many cases is useful for undervolting to avoid excess heat.
> Could you clarify if blocking msr breaks internal power management of intel
> cpu or it only prevents manual tinkering with it by user? If the latter then
> I think it's ok to keep it as is.
>
> Jordan
