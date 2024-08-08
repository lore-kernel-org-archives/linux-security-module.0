Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F079C8D1;
	Thu,  8 Aug 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130420; cv=none; b=LZb5Nrw81s1UAv4PevK7Qm/L4TEEDmY3YilhbiDumLxIKFM4WInv7oClMRv6YK6SR8aAZzmNXsp1kVQzRIPQ/EDCuVAxv0uOGtzBL7GCGeJ25VVA42ar9cZohtEL8NkWbw11qbPIsM5NflnW5lUC6gWvvDOwhsviRgqVpevBzq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130420; c=relaxed/simple;
	bh=VbTPRRLG7GBG3v2gahUkUEZHBk533HQG+WvOxgp5Zu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTiZI/etISqpImcnJBH65eleCE0NUM/WG7HDBGcLIdaZiLTYz2jULxMHJH0zXnaZmIbKcgg1ASMmx/8Qj3EIsQm0b9HqA6NtLhrxbxgWsPSQN41TKWs3h9U0J8835Cw5CYdma2yu7MNFFFIwstIX9BPKHx9KimHQjNo2franNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx2PMhEX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx2PMhEX"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7104f939aa7so978449b3a.1;
        Thu, 08 Aug 2024 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723130418; x=1723735218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iuGSgt93O3hQLEDQF9eaFLPOAl8LsWPI52/nBeyWow4=;
        b=Fx2PMhEXTibme1cLx0Fq5b9/4aAkyRXAi+1KnR7z4XIsoa5Wn2+IFhptYtmjDJBV1j
         iGF6UWnihrsH6YKxDtXxcVPIBBwJ23BJb5iBEuF9n5/fFEEV65dQ2qQUpD4DFhTnEFlQ
         J7umT+nALXI1o7FQcY460FBk1YRKN7NFsA2P8WMqmOCtdK6eKyfCDs/ur4MX3Hf0Gzqj
         pJ3m0AlEw3dQLmta80Z6vXwxePbomeaRp7uG/DpUDbMYaeHrk0kzmym7wlFyvUG2hflG
         XZFcGxZK8+LR5qZG8P+Xb1c1E2vsHQDxZtAQgbXNI4ezSsdKQ09U4Pgdq5SN9dpdqCCh
         OqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130418; x=1723735218;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuGSgt93O3hQLEDQF9eaFLPOAl8LsWPI52/nBeyWow4=;
        b=hOmdulsDPX4fTyUMp4y7kJ0kQwx/zZEZ2tUXvlY40njlWzTkbxaf3oRKY13Panb0RN
         JRGG7CDKwLjxgiyf3G5vp3jqiSlza8jVkIsVx6tkBRamJfSI6wp+jqmejrtrU21xwS5d
         H9v+RUX89Km9SU7gcOLT+Ap8MBvmUaPTiO8QFT15qNjfHejPY7mwZhSDiNT6MDZuuVYV
         Jy2/UPC8Srgn6RedHn++Q2sP2cDBJUCAoYwLerCShoPOUzPXWGBPMwxjIUZlGXG8FaER
         7nGr/9kHDZjaJleQ2nREef3+mTvjJMlTe+2r5xI039wiKuQrVft0E+Nn4r5JmxQrclvQ
         5/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUR7yVXgdw5GSB4jp8a77e0zMVtpuXZwfu2zFsGNHBLJrY0pr8q4VafxVWbk9PMEtIi2/RxROEmF7d2R8E762GRg3FNjceDnWQcv4KJvM9+sfv5nWZ1okOwmw4R/8nGs760XE8Q3ZPhLw2rsbXG8UXDOG3m
X-Gm-Message-State: AOJu0YyA2E32KWFykeMDokzlYsH0CEDI8ZpNJIz+lWDRo4W9Aq5viR8N
	yxkjJ7HXnQfjAqk+lmYpqaaZpou4VVW12RJoxAExJJBfx7stulKTAvFjmQ==
X-Google-Smtp-Source: AGHT+IFBLEw46e/7XPeXzb8l+TPtthf6qPIJ2tfjgQMQioLUpMay4nlP1s90q4WkkXzk2uO1CS0snw==
X-Received: by 2002:a05:6a21:3289:b0:1c6:a65f:f013 with SMTP id adf61e73a8af0-1c6fcec8c5amr2312327637.25.1723130417612;
        Thu, 08 Aug 2024 08:20:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb22a4e6sm1245986b3a.75.2024.08.08.08.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 08:20:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6471c2c2-6bdb-458d-8281-1a192dc366ab@roeck-us.net>
Date: Thu, 8 Aug 2024 08:20:14 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Nathan Chancellor <nathan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 bp@alien8.de, sfr@canb.auug.org.au, peterz@infradead.org
References: <20240801171747.3155893-1-kpsingh@kernel.org>
 <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X>
 <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net>
 <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net>
 <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/24 02:57, KP Singh wrote:
> On Thu, Aug 8, 2024 at 6:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 8/7/24 19:13, Guenter Roeck wrote:
>> ...
>>>
>>> I'll need to establish a baseline first to determine if the failures
>>> are caused by newly enabled configuration options or by this patch set.
>>> Below are just early test results.
>>>
>>> [ Though if those are all upstream there seems to be be something seriously
>>>     wrong with the lockdown lsm.
>>> ]
>>>
>>
>> Verdict is that all the messages below are from this patch set.
>>
>> On top of the reports below, alpha images fail completely, and the
>> backtraces are seen with several architectures. Please see the
>> "testing" column at https://kerneltests.org/builders for details.
>>
>> The only unrelated problems are the apparmor unit test failures;
>> those apparently fail on all big endian systems.
>>
>> Guenter
>>
>>> Guenter
>>>
>>> ----
>>> arm:
>>>
>>> [    0.000000] ------------[ cut here ]------------
>>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199 static_key_enable_cpuslocked+0xb0/0xfc
>>> [    0.000000] static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x8' used before call to jump_label_init()
>>> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2-00134-g679d51771510 #1
>>> [    0.000000] Hardware name: Generic DT based system
>>> [    0.000000] Call trace:
>>> [    0.000000]  unwind_backtrace from show_stack+0x18/0x1c
>>> [    0.000000]  show_stack from dump_stack_lvl+0x48/0x74
>>> [    0.000000]  dump_stack_lvl from __warn+0x7c/0x134
>>> [    0.000000]  __warn from warn_slowpath_fmt+0x9c/0xdc
>>> [    0.000000]  warn_slowpath_fmt from static_key_enable_cpuslocked+0xb0/0xfc
>>> [    0.000000]  static_key_enable_cpuslocked from security_add_hooks+0xa0/0x104
>>> [    0.000000]  security_add_hooks from lockdown_lsm_init+0x1c/0x2c
>>> [    0.000000]  lockdown_lsm_init from initialize_lsm+0x44/0x84
>>> [    0.000000]  initialize_lsm from early_security_init+0x3c/0x58
>>> [    0.000000]  early_security_init from start_kernel+0x78/0x748
>>> [    0.000000]  start_kernel from 0x0
>>> [    0.000000] irq event stamp: 0
>>> [    0.000000] hardirqs last  enabled at (0): [<00000000>] 0x0
>>> [    0.000000] hardirqs last disabled at (0): [<00000000>] 0x0
>>> [    0.000000] softirqs last  enabled at (0): [<00000000>] 0x0
>>> [    0.000000] softirqs last disabled at (0): [<00000000>] 0x0
>>> [    0.000000] ---[ end trace 0000000000000000 ]---
>>>
> 
> This seems very odd for especially ARM as I don't see this error when
> I do it on the next branch. Possibly something in setup_arch is
> initializing jump_tables indirectly between v6.11-rc2 and linux-next
> and/or this is a warning that does not immediately splash up on the
> dmesg.
> 

I suspect it is more likely because I have lots of debug options enabled in my tests.

> Both ARM64 and x86 (the architectures I really have access to)
> initializes jump_tables and x86 is the only architecture that does an
> explicit static_call_init is x86 and it's already in the setup_arch
> code.
> 
> https://elixir.bootlin.com/linux/v6.11-rc2/source/arch/arm64/kernel/setup.c#L295
> https://elixir.bootlin.com/linux/v6.11-rc2/source/arch/x86/kernel/setup.c#L783
> 
> Guenter, I have updated my tree, could you give it another run please?
> 

Sure, underway.

Guenter

