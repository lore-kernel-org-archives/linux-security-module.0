Return-Path: <SRS0=VGHz=ZW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B904C432C0
	for <linux-security-module@archiver.kernel.org>; Sat, 30 Nov 2019 19:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF46C2075C
	for <linux-security-module@archiver.kernel.org>; Sat, 30 Nov 2019 19:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J52a9Ag6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfK3TKH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:10:07 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36938 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3TKH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 30 Nov 2019 14:10:07 -0500
Received: by mail-yb1-f194.google.com with SMTP id q7so12822008ybk.4
        for <linux-security-module@vger.kernel.org>; Sat, 30 Nov 2019 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VeLIDXvMnEHV7JzlmXtVikjlVuVe/F+MTZF2UhHrXcY=;
        b=J52a9Ag6ktMT0Uf/1qHsIVv3BLB2+kofXBzw+Y2ubAvNK55s93mta4BEhsTiFCotSf
         OKeAbjzvzLyN2hLknvAboLDeldPUgeK54vKpmV+e8qfly66QlP9pKc475wbZPhZAorrh
         gjwsw+pr7PG/D8yfx2cyJFFHnPN2uY5r4QVo0n6l6T+IzTMc1Zv+70tHln4+KSmODD9X
         3N5GZNG/S/v4gB3g0vrIOCw/qUJQHLM9/o1BkIdBmMhbhovMRSEPGT/Q6YCyTyKZiJjS
         JDmtSHgtHFZ6NlQ29JHDIx/52QCXHU/kOFf9RhJO2ZZm7SuFmQjAlTf+0aXB06ahMLuM
         wWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VeLIDXvMnEHV7JzlmXtVikjlVuVe/F+MTZF2UhHrXcY=;
        b=URq3x4jI0jKAgk/N7q7O6ncJm+pDSeg1eCPOGdf2AJOjzYPalUt2j9O95XGFpMe8k6
         sSIAMYosT+2aTBEzzMG8SzU4A3fHhj/WiylGnbqjbxdyGwFN0ong44IkEnsuqUOcby/z
         rlPRi5estosEKcjf/rESUf35c+6HCFa9hZDpP4Jb0Uxs1YUm/eaXFyky4Ph36D8Ul0NI
         hZ/PX5Wyt9M+LV/pNLeFRL/W2AeNOlIPAJudN4MKk0A1zjwovopbcoy5PuUJJCvM2/ad
         aj1ENqHNXBz58lFzOQDII/TZ5g5n8JvsS+uYuuVxX5Rw0ALIFyBy6b2hPRHu1KcGdH+E
         ZEkg==
X-Gm-Message-State: APjAAAV3+Ovwv55hBjzd7ebqIcR5UK8WsENXz7sgR64dTuENMOt1k9Ay
        qU5vgKOw6oonxcVaPinqoyk=
X-Google-Smtp-Source: APXvYqzAdJR5agBdycPqKrwERdCPVBnWCzWD6rhJDdCBHvriFo1n9AuU8vc1xhqrff1fOSvLQ2UlEQ==
X-Received: by 2002:a25:1087:: with SMTP id 129mr45038769ybq.399.1575141004692;
        Sat, 30 Nov 2019 11:10:04 -0800 (PST)
Received: from [192.168.2.191] (173-17-41-233.client.mchsi.com. [173.17.41.233])
        by smtp.gmail.com with ESMTPSA id y186sm11597783ywe.97.2019.11.30.11.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 11:10:04 -0800 (PST)
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
Message-ID: <f415ec28-8440-3b29-176c-50da09247ea3@gmail.com>
Date:   Sat, 30 Nov 2019 13:09:37 -0600
MIME-Version: 1.0
In-Reply-To: <201911301035.74813D4533@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I can see how using a policy would be beneficial; I only did this
because as I understood it, policy wouldn't be able to change these
particular settings since anything attempting to do so would be from
userspace.

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
