Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29618FC9C;
	Thu,  8 Aug 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135389; cv=none; b=EwxVhGxHFmdEzrszHy1Khuv0lBz9Yy9fVn9uK7MbiyBa/S1Iekgmyq+x4vGcr11KhQT6t0AdMWiT0tdiH4/d2aTyagISVEoN0AYX3++gDs9ILVabFOGF7PK8A6objpA2B4zw7uFYm6UotAc5R9bXfFrZh25D8gRX/PXHIfHOfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135389; c=relaxed/simple;
	bh=dHtDfhOsvgIFvdZwp4aXWLwy4SEXbI2Im6ka0NpERbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lt0VXN/CcArBQkh+wow04MkW5atOt0EZo1EinrBUNO62C0eebt7V2PHkHPUZC0beurwiOJIIWTIK9TwEDI6a+7V8Dova3hMEndTJAXie5yqDN0rCUPiGXr0npcPRKf7mhtBUzMv7vQJFG3Ng3uc9+rc1ROnoA/sMCJDt8sdwsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRTYrWN1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRTYrWN1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc56fd4de1so8202555ad.0;
        Thu, 08 Aug 2024 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723135387; x=1723740187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eNrYT8Y4Gw2EVawrdifTxZqwo8X4GHazPDpumhz+hFI=;
        b=bRTYrWN1/HTggECJOsIrLOt+LsMihX+AlNynD2zONUezsakhOv0tkCYTJKJ+wS0V6I
         +y6+10dHEUKCx8V6B/aGV7JkhoS3qI5lXPmkr9LY7oGhQBUmwblq7gfiyffak0JShJxP
         N3/e7i2AYgXo3lPkXsBq6eYiwucnLyVqcEMCvFGGR1N/MGebvDmRKkzTcqJy16sm+rFg
         JB/WpD+CKuq8FcQaVOwHfThWJstt8BFx8AXJfjypHwPL9e1eoBoIAXqPDPcJZ/OXOpRG
         mzpNg+G83ZG4/e59EoseDis5+1q1Kk3zqElo3OaEh+bLuH630S5m0ZM6WHjtXkZbqCGC
         FyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723135387; x=1723740187;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNrYT8Y4Gw2EVawrdifTxZqwo8X4GHazPDpumhz+hFI=;
        b=FQUucKsAGwMelzgvDWN1sON44rIPTNdK/FSCyJ91NIqvTRU6w4d2UkSre9bJaHCBqU
         a0SCdeg/uMEgEEQhURDamg2DPzvb0t4/FHKM7z+7kZCNtOHqJS3nb5X1MYzq6gKyZDqk
         5FKkZsVgCEr51oyyYma4kPtzfF/NAY97to1PWQGoZxE4b1fv1B1XyX8ALZgbI2obcrgi
         6PapOK8A/9w975W3cfLiCf0vFa0cpCXgCuplBB5KWKHxy9PPvaeMyuKkA2h4Se/6/Izx
         Xk9QOPHGEBJAl2Qr+ZHK2e96zQg7A1MyrvDQH1vqdbcGIo3Adsip/QbJlxUSktIw0sDx
         b9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV/WJkoYBIcYbgli/A32V6p05mSK0gDPJhnU6CUJPxjNrV5kkk5GJbCo37bf/Mqqd4WRFY+rJmjMhaUQ8z70bYFksMsHeERMbg+K4dqqSh/vgmSslDnR+5iqVvd+CJ+xW1kOBygFxWzLvBKg1lHa+LiTcOB
X-Gm-Message-State: AOJu0YzacZbLQLfaqtkZYXwlyHXns/1WrCfuWY5I5BDTmVRKUjWXp+DZ
	KIEPcvxxcxa2f9X1S+6FN0bbErpVh+RimcTvV884MetccpUeWldRumNH2g==
X-Google-Smtp-Source: AGHT+IGqd8MXoHFAwKBqFE7HYM2htnk6QT4veGS+QVbxdQ4qh3IjYCCkUTZVBa3rWVNW1OMUNG6bKA==
X-Received: by 2002:a17:902:d48b:b0:1fb:9cbf:b4e3 with SMTP id d9443c01a7336-20096d2f0cfmr44175485ad.22.1723135386633;
        Thu, 08 Aug 2024 09:43:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19e8asm127380265ad.43.2024.08.08.09.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 09:43:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net>
Date: Thu, 8 Aug 2024 09:43:04 -0700
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

This version is much better, except for alpha which still crashes hard
with no log output. It bisects to one of your patches (results below).

Also, there is a backtrace on ppc (also see below), but that is unrelated
to your patches and only seen now because I enabled the security modules
on that architecture. I'll bring that up with ppc maintainers.

Thanks,
Guenter

---
bisect:

# bad: [b92c86ad4f4311706fe436a1545d9a97e6aebcf8] lsm: replace indirect LSM hook calls with static calls
# good: [de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed] Linux 6.11-rc2
git bisect start 'HEAD' 'v6.11-rc2'
# good: [bd2c890317b2d60b4afd89a374a56a7c9a0275bd] kernel: Add helper macros for loop unrolling
git bisect good bd2c890317b2d60b4afd89a374a56a7c9a0275bd
# good: [6a1e94163fc53a4f1b47a8689f416a1a3d0a154a] lsm: count the LSMs enabled at compile time
git bisect good 6a1e94163fc53a4f1b47a8689f416a1a3d0a154a
# first bad commit: [b92c86ad4f4311706fe436a1545d9a97e6aebcf8] lsm: replace indirect LSM hook calls with static calls

---
ppc backtrace:

LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/smp.c:779 smp_call_function_many_cond+0x518/0x9d4
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc2-00127-g2e3e7093e9c8 #1
Hardware name: MPC8544DS e500v2 0x80210030 MPC8544 DS
NIP:  c0172ca8 LR: c01731b0 CTR: 00000000
REGS: c2669d60 TRAP: 0700   Not tainted  (6.11.0-rc2-00127-g2e3e7093e9c8)
MSR:  00021000 <CE,ME>  CR: 24004288  XER: 20000000
GPR00: c002255c c2669e50 c253b5c0 c267b484 00000000 00000000 00000001 c2680000
GPR08: 00000000 00000003 c2680000 00000000 44004288 020a1e18 00000000 00000000
GPR16: 00000000 00000000 00000001 00000000 c0000000 c01731b0 00000000 c267b484
GPR24: c00224fc c0773760 c0770b50 00000000 00000000 00029000 00000000 00000000
NIP [c0172ca8] smp_call_function_many_cond+0x518/0x9d4
LR [c01731b0] smp_call_function+0x3c/0x58
Call Trace:
[c2669eb0] [84000282] 0x84000282
[c2669ec0] [c002255c] flush_tlb_kernel_range+0x2c/0x50
[c2669ed0] [c0023b8c] patch_instruction+0x108/0x1b0
[c2669ef0] [c00188a4] arch_static_call_transform+0x104/0x148
[c2669f10] [c2033ebc] security_add_hooks+0x138/0x24c
[c2669f40] [c2032e24] capability_init+0x24/0x38
[c2669f50] [c203322c] initialize_lsm+0x48/0x90
[c2669f70] [c2033b68] security_init+0x31c/0x538
[c2669fa0] [c2001154] start_kernel+0x5d4/0x81c
[c2669ff0] [c0000478] set_ivor+0x150/0x18c
Code: 91220000 81620004 3d20c209 3929e478 556b103a 7c84582e 7c89202e 81220000 2c040000 3929ffff 91220000 40a2fbb8 <0fe00000> 4bfffbb0 80e20000 2c070000
irq event stamp: 1204
hardirqs last  enabled at (1203): [<c11d85f8>] _raw_spin_unlock_irqrestore+0x70/0xa8
hardirqs last disabled at (1204): [<c0023bcc>] patch_instruction+0x148/0x1b0
softirqs last  enabled at (50): [<c0064b4c>] handle_softirqs+0x348/0x508
softirqs last disabled at (43): [<c0006fd0>] do_softirq_own_stack+0x34/0x4c
---[ end trace 0000000000000000 ]---
landlock: Up and running.
Yama: becoming mindful.
LoadPin: ready to pin (currently not enforcing)

