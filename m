Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215C12DD88;
	Thu,  8 Aug 2024 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090034; cv=none; b=f/Gm3v7LwR6WO1LU0lxB14IyYD74cMWrOFoG2R+oekdTRSsVe57vLLtOPSjA689neQ6ECShU4YaN63ARKZjCB/5v+NCjB03DelOMVhfIAmgBGn4rdlhiiOCmWFR/Hvvf0+LzFJWkpso3GhmFXO0qGLWlpgq2A/1kq1c5em3I4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090034; c=relaxed/simple;
	bh=mObcmv4jIaMYgfUZOGGn2grVWPOdSmaLoOEbjE1pi74=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jCkThsbo/522bLR9sgm8iQ5VDUl+UtOq/r6KpSwPd7WXIwugx8lm/EN8cI/teckT5JUaYzOpEcYGbpxXEvF352jUf0xC3GjRNTWxGnOFwOfP23YatLRle3TZCLuH1UP9xwqFdjXK2UHohwT2YL+/6JjgVUda3zAnC5OwKFJxPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbwWtaUK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbwWtaUK"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso404463a12.2;
        Wed, 07 Aug 2024 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723090031; x=1723694831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8C6ryQS49bSQo4FYdG87wd9RmPx+xp1m/yXRduLXu8E=;
        b=TbwWtaUKcP+jU+mu9aZWweOAB0SW6g7v6FjZzeRkJrFeO3W2DNpqrV6qATobJB7nnB
         qDemoBKxnVlvSDBg5zygO65VXxUAZPGbrXnhLpfJxAXtYhWvq4y+DWxT8mIMF4rgOus9
         FhWxNw/beJSBFtWJwH3hKLPW3pZqyr7r7JUwBIP6XzoCj1freG7PwNjMy+raIMJ+zGu+
         M1AfayUdEJjLPKrkKub4W3sfHpAOxUM3qdQmxiS2Eol7Cl5JVRLBgfKRlXf5TT9n4qNm
         08c/RMyAiv7JXCnU6X5fj0bHtpW7tELZoIl/cFPQilzCaHv523PRDPKuT836ic0Q5yDI
         A6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723090031; x=1723694831;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C6ryQS49bSQo4FYdG87wd9RmPx+xp1m/yXRduLXu8E=;
        b=Vb5z0JwgtGCh0wjY4oeD5IYjg2Tb3pXBGFNsQ35R6j6ThSMqJB306zYs/C26izJ4+1
         EEpePoRgMPg7GQdhwB/fblOZmjxhKYzX1Ks+DFExGE83A5Am/Wss29NxYpSHKS/9oUSP
         oIyK0rROALFhYFk5Jcb5orehhlcw83kRUWvxLXuiOQHeR+5lgejl75wPdXxgsdrfcGgp
         zn7OrjypYXtGhMixW5RX5eFieXy+lmW/Jja8Qco7AEwKuNJ+dqkTfY4cKRLXDlZiemCz
         Je0H7JB56QWxdEWb/ZdRKtFTNre2MWW4a0dgsd+DyqSdWkVHl+S+rcpnXiv+8HDwriB/
         Mqww==
X-Forwarded-Encrypted: i=1; AJvYcCXthaCsk2MiH6SNVccENqvsIq0Guug78/nlu6sYGl6Tvt4ZKCT9YMuJ2FALvOdLZ1+cWsgXhBrrO4WznYZmV4vKWdKw/a+wQxUhCa2Vic30pA10YtAzztfqKd7OUxj+C14JrxzZ+s1G69D5yxbjm1dhN6zx
X-Gm-Message-State: AOJu0YyZe1bAN+26cco5Uqs07bIvEwEPibsFNj6h5s2wmyMuViQ/boNr
	+efHuSNSR1lu1ceQp6ADFIKchFX7j55BepBV3qpxjNovrGXyJD5i
X-Google-Smtp-Source: AGHT+IFdswFMzn4/gCvD2KURfnAlo5UH1QSpzCh7Bq3DZYO6eTsgzyJNmi1acMpUAuw9fQRO/cwjjQ==
X-Received: by 2002:a05:6a21:8199:b0:1c4:c449:41e6 with SMTP id adf61e73a8af0-1c6fcf15ad7mr573534637.31.1723090031258;
        Wed, 07 Aug 2024 21:07:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c5d6a1sm83038a91.6.2024.08.07.21.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 21:07:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
Date: Wed, 7 Aug 2024 21:07:08 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
From: Guenter Roeck <linux@roeck-us.net>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
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
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 19:13, Guenter Roeck wrote:
...
> 
> I'll need to establish a baseline first to determine if the failures
> are caused by newly enabled configuration options or by this patch set.
> Below are just early test results.
> 
> [ Though if those are all upstream there seems to be be something seriously
>    wrong with the lockdown lsm.
> ]
> 

Verdict is that all the messages below are from this patch set.

On top of the reports below, alpha images fail completely, and the
backtraces are seen with several architectures. Please see the
"testing" column at https://kerneltests.org/builders for details.

The only unrelated problems are the apparmor unit test failures;
those apparently fail on all big endian systems.

Guenter

> Guenter
> 
> ----
> arm:
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199 static_key_enable_cpuslocked+0xb0/0xfc
> [    0.000000] static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x8' used before call to jump_label_init()
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2-00134-g679d51771510 #1
> [    0.000000] Hardware name: Generic DT based system
> [    0.000000] Call trace:
> [    0.000000]  unwind_backtrace from show_stack+0x18/0x1c
> [    0.000000]  show_stack from dump_stack_lvl+0x48/0x74
> [    0.000000]  dump_stack_lvl from __warn+0x7c/0x134
> [    0.000000]  __warn from warn_slowpath_fmt+0x9c/0xdc
> [    0.000000]  warn_slowpath_fmt from static_key_enable_cpuslocked+0xb0/0xfc
> [    0.000000]  static_key_enable_cpuslocked from security_add_hooks+0xa0/0x104
> [    0.000000]  security_add_hooks from lockdown_lsm_init+0x1c/0x2c
> [    0.000000]  lockdown_lsm_init from initialize_lsm+0x44/0x84
> [    0.000000]  initialize_lsm from early_security_init+0x3c/0x58
> [    0.000000]  early_security_init from start_kernel+0x78/0x748
> [    0.000000]  start_kernel from 0x0
> [    0.000000] irq event stamp: 0
> [    0.000000] hardirqs last  enabled at (0): [<00000000>] 0x0
> [    0.000000] hardirqs last disabled at (0): [<00000000>] 0x0
> [    0.000000] softirqs last  enabled at (0): [<00000000>] 0x0
> [    0.000000] softirqs last disabled at (0): [<00000000>] 0x0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> 
> m68k:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at include/linux/jump_label.h:322 security_add_hooks+0xc4/0x12c
> static_key_enable(): static key '0x6e5860' used before call to jump_label_init()
> Modules linked in:
> CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2-mac-00134-g679d51771510 #1
> Stack from 0065df00:
>          0065df00 005ff98d 005ff98d 00000000 00000009 00000009 004aa710 005ff98d
>          0049f87a 005c9849 00000142 0063f5ec 004cbd3e 0049f8f8 005c9849 00000142
>          0075ac3e 00000009 00000000 0065df60 00000000 00000040 00000000 00000000
>          005c980c 0065df7c 0075ac3e 005c9849 00000142 00000009 005c980c 004c9f98
>          006e5860 00000000 00782b50 00000000 00000000 0075b7ba 0063f5ec 00000001
>          004cbd3e 0075a62e 00782b50 0075a79e 00782b50 00782b50 0049feb6 00749d4c
> Call Trace: [<004aa710>] dump_stack+0xc/0x10
>   [<0049f87a>] __warn+0x7e/0xb4
>   [<0049f8f8>] warn_slowpath_fmt+0x48/0x66
>   [<0075ac3e>] security_add_hooks+0xc4/0x12c
>   [<0075ac3e>] security_add_hooks+0xc4/0x12c
>   [<0075b7ba>] lockdown_lsm_init+0x16/0x1e
>   [<0075a62e>] initialize_lsm+0x32/0x5c
>   [<0075a79e>] early_security_init+0x30/0x38
>   [<0049feb6>] _printk+0x0/0x18
>   [<00749d4c>] start_kernel+0x60/0x600
>   [<00748414>] _sinittext+0x414/0xae0
> ---[ end trace 0000000000000000 ]---
> 
> Microblaze:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at include/linux/jump_label.h:322 security_add_hooks+0x124/0x21c
> static_key_enable(): static key 'security_hook_active_locked_down_0+0x0/0x4' used before call to jump_label_init()
> Modules linked in:
> CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2-00134-g679d51771510 #1
> Kernel Stack:
> (ptrval): c0999390 c0f4c9ec 00000000 00000000 ffffffff a589f3a9 c0984c20 00000000
> (ptrval): c0c51ef8 00000009 c0984c30 00000000 00000000 c0c51ef8 00000000 c0c51ef8
> (ptrval): 00000009 c0984cf8 c09bad94 00000000 00000000 c0a30c10 00000142 c0d19e10
> (ptrval): c0a30bd0 c0a30c10 00000000 c0d19e10 c09bade4 00000142 00000009 c0a30bd0
> (ptrval): c0a30ca0 c0f58820 c0a30bd0 c0c51f28 00000142 00000009 c0d19e10 c0a37340
> (ptrval): c0c190c0 c0d1b1d0 00000000 00000000 00000000 c0a30bd0 c0a30ca0 c0f58820
> (ptrval): c0d42b20 c0d35464 c0d42b38 00000000 00000000 00000000 00000000 00000000
> (ptrval): 00100000 00000280 c0d196e8 c0d04ed0 00000000 c098465c 00000000 00000000
> (ptrval): c0d19778 c0d19784 00000000 00000000 c0d0488c c09b8e40 c09b9b24 c0d42b20
> (ptrval): c0d42b38 c0d00898 4883e4b3 00000000 c0d0088c 00000280 00000000 00000000
> (ptrval): 00000000 00000000 00000000 c0984194 c09b7208 c0b125f8 c0f5d59c 00000000
> (ptrval): 00000002 00000000 c00002e0 91a86e08 c0d33f7c 00000000 00000000 00000000
> (ptrval): 00000000 00000000 00000000 00000000
> Call Trace:
> [<c0003168>] microblaze_unwind+0x64/0x80
> [<c0984548>] show_stack+0x128/0x180
> [<c0999330>] dump_stack_lvl+0x44/0x94
> [<c099938c>] dump_stack+0xc/0x24
> [<c0984c2c>] __warn+0xac/0xfc
> [<c0984cf4>] warn_slowpath_fmt+0x78/0x98
> [<c0d19e0c>] security_add_hooks+0x120/0x21c
> [<c0d1b1cc>] lockdown_lsm_init+0x18/0x34
> [<c0d196e4>] initialize_lsm+0x44/0x94
> [<c0d19780>] early_security_init+0x4c/0x74
> [<c0d00894>] start_kernel+0x90/0x8ac
> [<c0984190>] machine_shutdown+0x1c/0x20
> no locks held by swapper/0.
> ---[ end trace 0000000000000000 ]---
> 
> mips:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at include/linux/jump_label.h:322 security_add_hooks+0xf8/0x1bc
> static_key_enable(): static key 'security_hook_active_locked_down_0+0x0/0x4' used before call to jump_label_init()
> Modules linked in:
> CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2-00134-g679d51771510 #1
> Hardware name: mti,malta
> Stack : 00000000 811eedd8 00000000 00000000 00000000 00000000 00000000 00000000
>          00000000 00000000 00000000 00000000 00000000 00000001 81257cd8 00000000
>          81257d70 00000000 00000000 00000000 00000038 80e549c4 00000000 ffffffff
>          00000000 00000000 00000000 00040000 00000000 00000000 81174584 81280000
>          00000000 00000142 00000000 00000000 00000000 00000000 0a0a0b0b bbe00cfc
>          ...
> Call Trace:
> [<8010a0a8>] show_stack+0x60/0x154
> [<80e731d8>] dump_stack_lvl+0xbc/0x138
> [<8012f908>] __warn+0x9c/0x1f8
> [<8012fc20>] warn_slowpath_fmt+0x1bc/0x1cc
> [<8138a184>] security_add_hooks+0xf8/0x1bc
> [<8138a5fc>] lockdown_lsm_init+0x20/0x30
> [<813899e8>] initialize_lsm+0x44/0x80
> [<81389be0>] early_security_init+0x50/0x6c
> [<8136c82c>] start_kernel+0xa8/0x7dc
> irq event stamp: 0
> hardirqs last  enabled at (0): [<00000000>] 0x0
> hardirqs last disabled at (0): [<00000000>] 0x0
> softirqs last  enabled at (0): [<00000000>] 0x0
> softirqs last disabled at (0): [<00000000>] 0x0
> ---[ end trace 0000000000000000 ]---
> 
> Loongarch (crash):
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x10' used before call to jump_label_init()
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
> [    0.000000] Caught reserved exception 12 on pid:0 [swapper] - should not happen
> [    0.000000] do_reserved exception[#1]:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2+ #1
> [    0.000000] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> [    0.000000] pc 9000000004cf9334 ra 9000000004cf9334 tp 9000000006cc8000 sp 9000000006ccbc10
> [    0.000000] a0 000000000000002d a1 9000000006df7830 a2 0000000000000000 a3 9000000006ccba28
> [    0.000000] a4 0000000000000001 a5 0000000000000000 a6 9000000006175570 a7 0000000000000005
> [    0.000000] t0 0000000000000000 t1 0000000000000000 t2 0000000000000001 t3 0000000000000001
> [    0.000000] t4 0000000000000004 t5 0000000000000094 t6 0000000000000023 t7 0000000000000030
> [    0.000000] t8 ffffffff8dcb3998 u0 9000000006a45388 s9 000000000f5ea330 s0 9000000006230788
> [    0.000000] s1 9000000006265c70 s2 0000000000000001 s3 0000000000000001 s4 9000000006cfaa80
> [    0.000000] s5 000000000f75dad8 s6 000000000a5b0000 s7 000000000f75db30 s8 000000000eee5b18
> [    0.000000]    ra: 9000000004cf9334 lockdep_hardirqs_on_prepare+0x200/0x208
> [    0.000000]   ERA: 9000000004cf9334 lockdep_hardirqs_on_prepare+0x200/0x208
> [    0.000000]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
> [    0.000000]  PRMD: 00000000 (PPLV0 -PIE -PWE)
> [    0.000000]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> [    0.000000]  ECFG: 00070800 (LIE=11 VS=7)
> [    0.000000] ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
> [    0.000000]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
> [    0.000000] Modules linked in:
> [    0.000000] Process swapper (pid: 0, threadinfo=(____ptrval____), task=(____ptrval____))
> [    0.000000] Stack : 0000000000000001 9000000006265c70 9000000006169c58 9000000004dd9ba8
> [    0.000000]         9000000006ccbc70 0000000000000000 9000000006ccbc70 9000000006169c58
> [    0.000000]         00000000000000b0 90000000074f08b8 9000000008616478 9000000007ad1924
> [    0.000000]         0000000000000000 9000000004e95fa8 9000000006cc8000 9000000006ccbdb0
> [    0.000000]         000000000000007e 9000000006df7830 0000000000000000 9000000006ccbbc8
> [    0.000000]         0000000000000001 0000000000000001 90000000073f6e58 9000000006175570
> [    0.000000]         0000000000000000 0000000000000000 0000000000000001 0000000000000001
> [    0.000000]         0000000000000000 0000000000000092 0000000000000001 0000000000006000
> [    0.000000]         ffffffff8dcb3998 9000000006a6bed8 000000000f5ea330 9000000008616478
> [    0.000000]         90000000074f08b8 0000000000000001 0000000000000001 9000000006cfaa80
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] [<9000000004cf9334>] lockdep_hardirqs_on_prepare+0x200/0x208
> [    0.000000] [<9000000004dd9ba4>] trace_hardirqs_on+0x54/0x70
> [    0.000000] [<9000000006169c54>] do_reserved+0x1c/0xcc
> [    0.000000] [<9000000004c52560>] handle_bp+0x120/0x1c0
> [    0.000000] [<9000000004e95fa8>] static_key_enable_cpuslocked+0xdc/0xec
> [    0.000000] [<9000000004e960b8>] static_key_enable+0x18/0x2c
> [    0.000000] [<90000000061a9154>] security_add_hooks+0xbc/0x12c
> [    0.000000] [<90000000061aa880>] lockdown_lsm_init+0x20/0x34
> [    0.000000] [<90000000061a8a80>] initialize_lsm+0x3c/0x6c
> [    0.000000] [<90000000061a8c34>] early_security_init+0x44/0x68
> [    0.000000] [<9000000006180830>] start_kernel+0xa0/0x84c
> [    0.000000] [<900000000616d0f0>] kernel_entry+0xf0/0xf8
> 
> 

