Return-Path: <SRS0=f5xb=ZY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81023C432C0
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4151F20718
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Dec 2019 18:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbLwSQlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfLBS3d (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:29:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44604 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfLBS3d (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 13:29:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id x3so341952oto.11
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RMT8z4DghcpYVZCst5GM3UQo7/bXDEcd6I9itVgMBp4=;
        b=rbLwSQlvB5nk3jvI5yJGLq3+ZxkPSiMjZA5koGaj2KyfG4rFoVXpVF7bwqpk4llt1a
         K70jJQ8yQ+SiUIBEe9uBiu4cFD/iTC6bedP3809ABMfHjCxljpszWzM/idtkC9VfB+e6
         cUWMhz8mlI0FBP3nJrj/Nz5ETkGLmCyCQbKz8e3Cwiwylsb0b2HqA5UKJed55odjMJ5M
         DV6fgSvtK5eR6mZceeYe2lqb0oKh8ICuOx4DgottmR5yJNgS/ZHeLYFMtYWgWdPaXqmf
         IjM4Iu5lyTFpERen9Lc83N2NzAyWBUceGChRKa9sCXsP0IAgN3wSfDamGVVnurZIM/Aj
         1ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RMT8z4DghcpYVZCst5GM3UQo7/bXDEcd6I9itVgMBp4=;
        b=AU7aHIhE+mnXY1FARjja6NgGdT2lU9b9oLZKb0q3hBlWLZpWd6Gf1YKn3xf9I7TP7B
         ODv3Gdx/TXoOrXFhA4bm1/B1q/BOfmUccTwFWBX2c/krJUMWL580J38U8z0AUBGNT5g3
         rYToYfuWmnm54iJM3g9Yd4JlyE6HBmy0SttAzqt8CM79l/M+E84EP3ZR7nKKF2qG4c8Q
         Y2o2vRWzMy1cltDODMcEItEpnaqhZEftBm1VnoTScy7WLtU6iL20D6dixKEga0Cr0SxI
         DHmCfwgDk19dUTdz4KFLn8v5JBgnq0PxNNZdX3XMxs/cPtFVHi9e66l2MRVxJJKt05BS
         XkDQ==
X-Gm-Message-State: APjAAAU3QbmqjK1PyNWslQVFFXiUZlSIIdVDnHTAREYlzFZlRilCva+F
        UU1mldfvLMaRGKHa+2HPjek=
X-Google-Smtp-Source: APXvYqwV4y/ABr5ZVqweMtmYxcrqg6WF4imDbMsZntkMRPxJOKrQzkOamUAA6/EG3nLY/t/vTCCgOg==
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr321629otc.295.1575311372180;
        Mon, 02 Dec 2019 10:29:32 -0800 (PST)
Received: from [10.77.0.2] (173-17-41-233.client.mchsi.com. [173.17.41.233])
        by smtp.gmail.com with ESMTPSA id m2sm62008oie.55.2019.12.02.10.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 10:29:31 -0800 (PST)
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
From:   Matt Parnell <mparnell@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, dhowells@redhat.com,
        matthew.garrett@nebula.com
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
 <201911301035.74813D4533@keescook>
 <f415ec28-8440-3b29-176c-50da09247ea3@gmail.com>
 <f988a531-a7f8-cef6-d3b4-6fbd89f5351f@gmail.com>
Autocrypt: addr=mparnell@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <96625b06-3bba-6831-7127-22b690fccf1b@gmail.com>
Date:   Mon, 2 Dec 2019 12:29:05 -0600
MIME-Version: 1.0
In-Reply-To: <f988a531-a7f8-cef6-d3b4-6fbd89f5351f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

After doing some research it appears that for Intel chips, only a single
register needs to be writeable. I'm not sure about AMD etc.

intel-undervolt/blob/master/config.h:

    #define MSR_ADDR_TEMPERATURE 0x1a2
    #define MSR_ADDR_UNITS 0x606
    #define MSR_ADDR_VOLTAGE 0x150

Perhaps add an MSR whitelist to allow writing, if
LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY=Y and
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=Y?

CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is likely what prevents Apparmor or
some other LSM policy manager allow this behavior...

as an option at build time would be more sensible?

On 12/1/19 2:53 PM, Matt Parnell wrote:
> That is, I was intending to use lockdown from boot, which isn't
> changeable after the fact if I'm not mistaken. How possible is granular
> control of what is and is not locked down?
>
> On 11/30/19 1:09 PM, Matt Parnell wrote:
>> I can see how using a policy would be beneficial; I only did this
>> because as I understood it, policy wouldn't be able to change these
>> particular settings since anything attempting to do so would be from
>> userspace.
>>
>> On 11/30/19 12:36 PM, Kees Cook wrote:
>>> On Sat, Nov 30, 2019 at 12:49:48AM -0600, Matt Parnell wrote:
>>>> From 452b8460e464422d268659a8abb93353a182f8c8 Mon Sep 17 00:00:00 2001
>>>> From: Matt Parnell <mparnell@gmail.com>
>>>> Date: Sat, 30 Nov 2019 00:44:09 -0600
>>>> Subject: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access even
>>>>  in confidentiality mode.
>>>>
>>>> For Intel CPUs, some of the MDS mitigations utilize the new "flush" MSR, and
>>>> while this isn't something normally used in userspace, it does cause false
>>>> positives for the "Forshadow" vulnerability.
>>>>
>>>> Additionally, Intel CPUs use MSRs for voltage and frequency controls,
>>>> which in
>>>> many cases is useful for undervolting to avoid excess heat.
>>>>
>>>> Signed-off-by: Matt Parnell <mparnell@gmail.com>
>>> I would expect this to just be implemented via LSM policy, not ifdefs
>>> and Kconfig?
>>>
>>> -Kees
>>>
>>>> ---
>>>>  arch/x86/kernel/msr.c     |  5 ++++-
>>>>  security/lockdown/Kconfig | 12 ++++++++++++
>>>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
>>>> index 1547be359d7f..4adce59455c3 100644
>>>> --- a/arch/x86/kernel/msr.c
>>>> +++ b/arch/x86/kernel/msr.c
>>>> @@ -80,10 +80,11 @@ static ssize_t msr_write(struct file *file, const
>>>> char __user *buf,
>>>>      int err = 0;
>>>>      ssize_t bytes = 0;
>>>>  
>>>> +#if defined(LOCK_DOWN_DENY_RAW_MSR)
>>>>      err = security_locked_down(LOCKDOWN_MSR);
>>>>      if (err)
>>>>          return err;
>>>> -
>>>> +#endif
>>>>      if (count % 8)
>>>>          return -EINVAL;    /* Invalid chunk size */
>>>>  
>>>> @@ -135,9 +136,11 @@ static long msr_ioctl(struct file *file, unsigned
>>>> int ioc, unsigned long arg)
>>>>              err = -EFAULT;
>>>>              break;
>>>>          }
>>>> +#if defined(LOCK_DOWN_DENY_RAW_MSR)
>>>>          err = security_locked_down(LOCKDOWN_MSR);
>>>>          if (err)
>>>>              break;
>>>> +#endif
>>>>          err = wrmsr_safe_regs_on_cpu(cpu, regs);
>>>>          if (err)
>>>>              break;
>>>> diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
>>>> index e84ddf484010..f4fe72c4bf8f 100644
>>>> --- a/security/lockdown/Kconfig
>>>> +++ b/security/lockdown/Kconfig
>>>> @@ -44,4 +44,16 @@ config LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
>>>>       code to read confidential material held inside the kernel are
>>>>       disabled.
>>>>  
>>>> +config LOCK_DOWN_DENY_RAW_MSR
>>>> +    bool "Lock down and deny raw MSR access"
>>>> +    depends on LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
>>>> +    default y
>>>> +    help
>>>> +      Some Intel based systems require raw MSR access to use the flush
>>>> +      MSR for MDS mitigation confirmation. Raw access can also be used
>>>> +      to undervolt many Intel CPUs.
>>>> +
>>>> +      Say Y to prevent access or N to allow raw MSR access for such
>>>> +      cases.
>>>> +
>>>>  endchoice
>>>> -- 
>>>> 2.24.0
>>>>
>>>>
>>>
