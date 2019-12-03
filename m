Return-Path: <SRS0=ehTW=ZZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2945BC432C0
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Dec 2019 02:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F9F20684
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Dec 2019 02:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw/kK2rD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfLCCBw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:01:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39124 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLCCBw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 21:01:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id g1so2092166qtj.6
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 18:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lN/QbEKrp8RMam9ImAEWUVwUB5whWtiQoOQ9SsPHB7I=;
        b=Yw/kK2rDzPZllt8OfJbV8CHsIsH7XjcuVGBWZoIPgZLGj6YkpkrbppLkBXH2xpuafF
         TQQTKno8RuWQu/p21oflENt7c2lgL2Qp044iFYzf3cOrMMC7nG7JAF0tpHzoWbXFqMkq
         za9elKW0fV1+K9sGulT+fPnlJiYZqgp1PhPUmkATje8t0K+t4CZLTvUPZS1dViRgsLq4
         4EoXiOpEB/Tc4JLPj0ZAaP94igeRhhan+xiASFhhTWmJV87ZZUwDKQniE840p5TorIMX
         Bio0dbn70q60fqSovJ53R/k8lAgBwaWJqOnKjkixMXPgNh9Pz5/YNpzOOMBJMbRqFfE0
         Yf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lN/QbEKrp8RMam9ImAEWUVwUB5whWtiQoOQ9SsPHB7I=;
        b=NCp/5u6a9apUyK6wllZZdT2NV6S50pPtPaMcxgCuMiHAzYPdsqavA44o3BG/VKuh6X
         Pqqtai65irm+6NuhLa5C4cHh+FNg5/4yabNr4vgurkD3fggPTD8pVA/Skt5uHlQ0QPls
         koS48CIOi5wAyZtIoVK1GvHwJ5e9idCe7oRR4fbAsUCpnzJXyCvt2/oQDJBW/tYz4LI1
         9e14euhVE7gpj/jv9m5A/9UNozkxD3RaPOT27A4kXqwreDMckj3p1586axyXCIHRE45m
         ctVVgosrLP9j+H/5L1vX4ACksFHaZpX+8aTwB2/EHU9GFprkCexH+5BzzuQN4VK4/UWT
         vwsA==
X-Gm-Message-State: APjAAAUkg3T4kv87srNmuGN1j/gUlXo/hFA8cZXn3HjQ0y2j8C0RZ7bj
        JsKzJ5lCZ7DH3cY7hkQIrNM=
X-Google-Smtp-Source: APXvYqzFdYZ0ZyssjGyKenXgLwq5VfFwwnUgsOBNmTyQcjzPTzNhLTLo0zQceiKhx1C+urt6IwSYpA==
X-Received: by 2002:ac8:91:: with SMTP id c17mr2994963qtg.222.1575338510842;
        Mon, 02 Dec 2019 18:01:50 -0800 (PST)
Received: from [192.168.2.190] (173-17-41-233.client.mchsi.com. [173.17.41.233])
        by smtp.gmail.com with ESMTPSA id r12sm92645qke.106.2019.12.02.18.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 18:01:50 -0800 (PST)
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, dhowells@redhat.com,
        matthew.garrett@nebula.com
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
 <201911301035.74813D4533@keescook>
From:   Matt Parnell <mparnell@gmail.com>
Autocrypt: addr=mparnell@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <62ccc074-ac6d-edea-10c6-925f99dfc592@gmail.com>
Date:   Mon, 2 Dec 2019 20:13:06 -0600
MIME-Version: 1.0
In-Reply-To: <201911301035.74813D4533@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I should also mention the kernel itself thinks it is vulnerable with the
MSRs locked down:

[    7.367922] L1TF CPU bug present and SMT on, data leak possible. See
CVE-2018-3646 and
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for
details.

On 11/30/19 12:36 PM, Kees Cook wrote:
> On Sat, Nov 30, 2019 at 12:49:48AM -0600, Matt Parnell wrote:
>> From 452b8460e464422d268659a8abb93353a182f8c8 Mon Sep 17 00:00:00 2001
>> From: Matt Parnell <mparnell@gmail.com>
>> Date: Sat, 30 Nov 2019 00:44:09 -0600
>> Subject: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access even
>>  in confidentiality mode.
>>
>> For Intel CPUs, some of the MDS mitigations utilize the new "flush" MSR, and
>> while this isn't something normally used in userspace, it does cause false
>> positives for the "Forshadow" vulnerability.
>>
>> Additionally, Intel CPUs use MSRs for voltage and frequency controls,
>> which in
>> many cases is useful for undervolting to avoid excess heat.
>>
>> Signed-off-by: Matt Parnell <mparnell@gmail.com>
> I would expect this to just be implemented via LSM policy, not ifdefs
> and Kconfig?
>
> -Kees
>
>> ---
>>  arch/x86/kernel/msr.c     |  5 ++++-
>>  security/lockdown/Kconfig | 12 ++++++++++++
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
>> index 1547be359d7f..4adce59455c3 100644
>> --- a/arch/x86/kernel/msr.c
>> +++ b/arch/x86/kernel/msr.c
>> @@ -80,10 +80,11 @@ static ssize_t msr_write(struct file *file, const
>> char __user *buf,
>>      int err = 0;
>>      ssize_t bytes = 0;
>>  
>> +#if defined(LOCK_DOWN_DENY_RAW_MSR)
>>      err = security_locked_down(LOCKDOWN_MSR);
>>      if (err)
>>          return err;
>> -
>> +#endif
>>      if (count % 8)
>>          return -EINVAL;    /* Invalid chunk size */
>>  
>> @@ -135,9 +136,11 @@ static long msr_ioctl(struct file *file, unsigned
>> int ioc, unsigned long arg)
>>              err = -EFAULT;
>>              break;
>>          }
>> +#if defined(LOCK_DOWN_DENY_RAW_MSR)
>>          err = security_locked_down(LOCKDOWN_MSR);
>>          if (err)
>>              break;
>> +#endif
>>          err = wrmsr_safe_regs_on_cpu(cpu, regs);
>>          if (err)
>>              break;
>> diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
>> index e84ddf484010..f4fe72c4bf8f 100644
>> --- a/security/lockdown/Kconfig
>> +++ b/security/lockdown/Kconfig
>> @@ -44,4 +44,16 @@ config LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
>>       code to read confidential material held inside the kernel are
>>       disabled.
>>  
>> +config LOCK_DOWN_DENY_RAW_MSR
>> +    bool "Lock down and deny raw MSR access"
>> +    depends on LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
>> +    default y
>> +    help
>> +      Some Intel based systems require raw MSR access to use the flush
>> +      MSR for MDS mitigation confirmation. Raw access can also be used
>> +      to undervolt many Intel CPUs.
>> +
>> +      Say Y to prevent access or N to allow raw MSR access for such
>> +      cases.
>> +
>>  endchoice
>> -- 
>> 2.24.0
>>
>>
>
>
>
