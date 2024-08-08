Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577A1891DA
	for <linux-security-module@vger.kernel.org>; Thu,  8 Aug 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111040; cv=none; b=bm0WxGVfg4/8dEbZ2bRNw/rzU009UKajSrOKL/8A8j/HpyfxOW+Z33qrnuO3Fbrjtj7Dnfk26YfzL3V8Mj9v15VAt4Dxy/mWsq/mJvuFLGoWr+7+UaCdH01Ld0ahHdy1+p2bTm0qv70LMLHyfcyb+Pb/fDYud9qVNIjm/FbsGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111040; c=relaxed/simple;
	bh=u177nhYLIu3Nax7qYSEq2sI2wQoIWJKdFtYmZZ/neoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3GXwlJDWgVsItdSRc0GBRkmTfPFY9vngOychomGy+Hu51AusZfSG80jKbBTKQFSk5L1135eEtVA8pyH9JZmSSgGNvBouP7UACG+GCSN4RLvHSte8UlLpw+dvCc84K9Ej+ZEp7d0jOqoxYon6qb8a5r19zpeSJTWpcQUpD9lgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLcCQR0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLcCQR0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D550C4AF10
	for <linux-security-module@vger.kernel.org>; Thu,  8 Aug 2024 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723111040;
	bh=u177nhYLIu3Nax7qYSEq2sI2wQoIWJKdFtYmZZ/neoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bLcCQR0iTFhNhHOTZ0E0knJ1J5wbLo2ucmIB8wwuOkxZT2h+Zf59lydAgOumjEBX+
	 fU5dNUR+JOJpDOmSjDKd8oZBGo6dsGOO78l0d3pH775YjZH3/ifxzHuNtYp9v6F7sC
	 9Nm9Ije/scUDGrX13xOJFDehxuhgRhiHUmShaNNdYp3nvM9kYCTQO0Uk3KQoxrjSva
	 pVUvt8Tv6d93tC7/Y0szQ/Xmy0p7UMzKfH5Owm8yb+Z1qt/Gdp3IidrT4km9KdnwDF
	 MmErJz4e1Q1ihdLfh90J2+qUqXHRS5154bxHHDVgo/UG44DSSEHuAmyXdCz7iBetmt
	 ZX8kSGWZLvKpQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6117aso289735a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Aug 2024 02:57:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCo9nnZTHhLEqVSKmAj6Ts2StMjEGG5jQGBkAhBGbNnXF96ulIdOdemuRl2GbRICH5q1LDKuYWMp5KdG+NTbyc5wAwNDyZYLsVDq3wliJHS+7gt6YK
X-Gm-Message-State: AOJu0YwuR+iSLQ2rRF95LQ+uJVlHvM6Mifs5OZ6Q6zclN3pLJndRTe+c
	T41YqdgxnqZ6YEl6K3wcYQ5Q9F8OKPciQPLb91Opj5x56OVbS0ma9CYHTFJGs8FzvwtTZCKqG00
	hrstCMawel6e4kFdso/dTy0AcMAsbGDu1hCW5
X-Google-Smtp-Source: AGHT+IERDWOqOazZm2yzAO4Ur+305d9i1Y7BIeJPcI41VKREQadNM47jdcRYaVfL+JxfMjr/LEJY9Zjrzsmxqj0yjJg=
X-Received: by 2002:a05:6402:5308:b0:5a2:2b56:e06e with SMTP id
 4fb4d7f45d1cf-5bbb24be6d4mr1069377a12.36.1723111038763; Thu, 08 Aug 2024
 02:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
In-Reply-To: <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 8 Aug 2024 11:57:07 +0200
X-Gmail-Original-Message-ID: <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
Message-ID: <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Moore <paul@paul-moore.com>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:07=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 8/7/24 19:13, Guenter Roeck wrote:
> ...
> >
> > I'll need to establish a baseline first to determine if the failures
> > are caused by newly enabled configuration options or by this patch set.
> > Below are just early test results.
> >
> > [ Though if those are all upstream there seems to be be something serio=
usly
> >    wrong with the lockdown lsm.
> > ]
> >
>
> Verdict is that all the messages below are from this patch set.
>
> On top of the reports below, alpha images fail completely, and the
> backtraces are seen with several architectures. Please see the
> "testing" column at https://kerneltests.org/builders for details.
>
> The only unrelated problems are the apparmor unit test failures;
> those apparently fail on all big endian systems.
>
> Guenter
>
> > Guenter
> >
> > ----
> > arm:
> >
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199 static=
_key_enable_cpuslocked+0xb0/0xfc
> > [    0.000000] static_key_enable_cpuslocked(): static key 'security_hoo=
k_active_locked_down_0+0x0/0x8' used before call to jump_label_init()
> > [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc=
2-00134-g679d51771510 #1
> > [    0.000000] Hardware name: Generic DT based system
> > [    0.000000] Call trace:
> > [    0.000000]  unwind_backtrace from show_stack+0x18/0x1c
> > [    0.000000]  show_stack from dump_stack_lvl+0x48/0x74
> > [    0.000000]  dump_stack_lvl from __warn+0x7c/0x134
> > [    0.000000]  __warn from warn_slowpath_fmt+0x9c/0xdc
> > [    0.000000]  warn_slowpath_fmt from static_key_enable_cpuslocked+0xb=
0/0xfc
> > [    0.000000]  static_key_enable_cpuslocked from security_add_hooks+0x=
a0/0x104
> > [    0.000000]  security_add_hooks from lockdown_lsm_init+0x1c/0x2c
> > [    0.000000]  lockdown_lsm_init from initialize_lsm+0x44/0x84
> > [    0.000000]  initialize_lsm from early_security_init+0x3c/0x58
> > [    0.000000]  early_security_init from start_kernel+0x78/0x748
> > [    0.000000]  start_kernel from 0x0
> > [    0.000000] irq event stamp: 0
> > [    0.000000] hardirqs last  enabled at (0): [<00000000>] 0x0
> > [    0.000000] hardirqs last disabled at (0): [<00000000>] 0x0
> > [    0.000000] softirqs last  enabled at (0): [<00000000>] 0x0
> > [    0.000000] softirqs last disabled at (0): [<00000000>] 0x0
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> >

This seems very odd for especially ARM as I don't see this error when
I do it on the next branch. Possibly something in setup_arch is
initializing jump_tables indirectly between v6.11-rc2 and linux-next
and/or this is a warning that does not immediately splash up on the
dmesg.

Both ARM64 and x86 (the architectures I really have access to)
initializes jump_tables and x86 is the only architecture that does an
explicit static_call_init is x86 and it's already in the setup_arch
code.

https://elixir.bootlin.com/linux/v6.11-rc2/source/arch/arm64/kernel/setup.c=
#L295
https://elixir.bootlin.com/linux/v6.11-rc2/source/arch/x86/kernel/setup.c#L=
783

Guenter, I have updated my tree, could you give it another run please?

Thanks!
- KP

> > m68k:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at include/linux/jump_label.h:322 security_add_h=
ooks+0xc4/0x12c
> > static_key_enable(): static key '0x6e5860' used before call to jump_lab=
el_init()
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2-mac-00134-g67=
9d51771510 #1
> > Stack from 0065df00:
> >          0065df00 005ff98d 005ff98d 00000000 00000009 00000009 004aa710=
 005ff98d
> >          0049f87a 005c9849 00000142 0063f5ec 004cbd3e 0049f8f8 005c9849=
 00000142
> >          0075ac3e 00000009 00000000 0065df60 00000000 00000040 00000000=
 00000000
> >          005c980c 0065df7c 0075ac3e 005c9849 00000142 00000009 005c980c=
 004c9f98
> >          006e5860 00000000 00782b50 00000000 00000000 0075b7ba 0063f5ec=
 00000001
> >          004cbd3e 0075a62e 00782b50 0075a79e 00782b50 00782b50 0049feb6=
 00749d4c
> > Call Trace: [<004aa710>] dump_stack+0xc/0x10
> >   [<0049f87a>] __warn+0x7e/0xb4
> >   [<0049f8f8>] warn_slowpath_fmt+0x48/0x66
> >   [<0075ac3e>] security_add_hooks+0xc4/0x12c
> >   [<0075ac3e>] security_add_hooks+0xc4/0x12c
> >   [<0075b7ba>] lockdown_lsm_init+0x16/0x1e
> >   [<0075a62e>] initialize_lsm+0x32/0x5c
> >   [<0075a79e>] early_security_init+0x30/0x38
> >   [<0049feb6>] _printk+0x0/0x18
> >   [<00749d4c>] start_kernel+0x60/0x600
> >   [<00748414>] _sinittext+0x414/0xae0
> > ---[ end trace 0000000000000000 ]---
> >
> > Microblaze:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at include/linux/jump_label.h:322 security_add_h=
ooks+0x124/0x21c
> > static_key_enable(): static key 'security_hook_active_locked_down_0+0x0=
/0x4' used before call to jump_label_init()
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2-00134-g679d51=
771510 #1
> > Kernel Stack:
> > (ptrval): c0999390 c0f4c9ec 00000000 00000000 ffffffff a589f3a9 c0984c2=
0 00000000
> > (ptrval): c0c51ef8 00000009 c0984c30 00000000 00000000 c0c51ef8 0000000=
0 c0c51ef8
> > (ptrval): 00000009 c0984cf8 c09bad94 00000000 00000000 c0a30c10 0000014=
2 c0d19e10
> > (ptrval): c0a30bd0 c0a30c10 00000000 c0d19e10 c09bade4 00000142 0000000=
9 c0a30bd0
> > (ptrval): c0a30ca0 c0f58820 c0a30bd0 c0c51f28 00000142 00000009 c0d19e1=
0 c0a37340
> > (ptrval): c0c190c0 c0d1b1d0 00000000 00000000 00000000 c0a30bd0 c0a30ca=
0 c0f58820
> > (ptrval): c0d42b20 c0d35464 c0d42b38 00000000 00000000 00000000 0000000=
0 00000000
> > (ptrval): 00100000 00000280 c0d196e8 c0d04ed0 00000000 c098465c 0000000=
0 00000000
> > (ptrval): c0d19778 c0d19784 00000000 00000000 c0d0488c c09b8e40 c09b9b2=
4 c0d42b20
> > (ptrval): c0d42b38 c0d00898 4883e4b3 00000000 c0d0088c 00000280 0000000=
0 00000000
> > (ptrval): 00000000 00000000 00000000 c0984194 c09b7208 c0b125f8 c0f5d59=
c 00000000
> > (ptrval): 00000002 00000000 c00002e0 91a86e08 c0d33f7c 00000000 0000000=
0 00000000
> > (ptrval): 00000000 00000000 00000000 00000000
> > Call Trace:
> > [<c0003168>] microblaze_unwind+0x64/0x80
> > [<c0984548>] show_stack+0x128/0x180
> > [<c0999330>] dump_stack_lvl+0x44/0x94
> > [<c099938c>] dump_stack+0xc/0x24
> > [<c0984c2c>] __warn+0xac/0xfc
> > [<c0984cf4>] warn_slowpath_fmt+0x78/0x98
> > [<c0d19e0c>] security_add_hooks+0x120/0x21c
> > [<c0d1b1cc>] lockdown_lsm_init+0x18/0x34
> > [<c0d196e4>] initialize_lsm+0x44/0x94
> > [<c0d19780>] early_security_init+0x4c/0x74
> > [<c0d00894>] start_kernel+0x90/0x8ac
> > [<c0984190>] machine_shutdown+0x1c/0x20
> > no locks held by swapper/0.
> > ---[ end trace 0000000000000000 ]---
> >
> > mips:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at include/linux/jump_label.h:322 security_add_h=
ooks+0xf8/0x1bc
> > static_key_enable(): static key 'security_hook_active_locked_down_0+0x0=
/0x4' used before call to jump_label_init()
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2-00134-g679d51=
771510 #1
> > Hardware name: mti,malta
> > Stack : 00000000 811eedd8 00000000 00000000 00000000 00000000 00000000 =
00000000
> >          00000000 00000000 00000000 00000000 00000000 00000001 81257cd8=
 00000000
> >          81257d70 00000000 00000000 00000000 00000038 80e549c4 00000000=
 ffffffff
> >          00000000 00000000 00000000 00040000 00000000 00000000 81174584=
 81280000
> >          00000000 00000142 00000000 00000000 00000000 00000000 0a0a0b0b=
 bbe00cfc
> >          ...
> > Call Trace:
> > [<8010a0a8>] show_stack+0x60/0x154
> > [<80e731d8>] dump_stack_lvl+0xbc/0x138
> > [<8012f908>] __warn+0x9c/0x1f8
> > [<8012fc20>] warn_slowpath_fmt+0x1bc/0x1cc
> > [<8138a184>] security_add_hooks+0xf8/0x1bc
> > [<8138a5fc>] lockdown_lsm_init+0x20/0x30
> > [<813899e8>] initialize_lsm+0x44/0x80
> > [<81389be0>] early_security_init+0x50/0x6c
> > [<8136c82c>] start_kernel+0xa8/0x7dc
> > irq event stamp: 0
> > hardirqs last  enabled at (0): [<00000000>] 0x0
> > hardirqs last disabled at (0): [<00000000>] 0x0
> > softirqs last  enabled at (0): [<00000000>] 0x0
> > softirqs last disabled at (0): [<00000000>] 0x0
> > ---[ end trace 0000000000000000 ]---
> >
> > Loongarch (crash):
> >
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] static_key_enable_cpuslocked(): static key 'security_hoo=
k_active_locked_down_0+0x0/0x10' used before call to jump_label_init()
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
> > [    0.000000] Caught reserved exception 12 on pid:0 [swapper] - should=
 not happen
> > [    0.000000] do_reserved exception[#1]:
> > [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc=
2+ #1
> > [    0.000000] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/=
06/2015
> > [    0.000000] pc 9000000004cf9334 ra 9000000004cf9334 tp 9000000006cc8=
000 sp 9000000006ccbc10
> > [    0.000000] a0 000000000000002d a1 9000000006df7830 a2 0000000000000=
000 a3 9000000006ccba28
> > [    0.000000] a4 0000000000000001 a5 0000000000000000 a6 9000000006175=
570 a7 0000000000000005
> > [    0.000000] t0 0000000000000000 t1 0000000000000000 t2 0000000000000=
001 t3 0000000000000001
> > [    0.000000] t4 0000000000000004 t5 0000000000000094 t6 0000000000000=
023 t7 0000000000000030
> > [    0.000000] t8 ffffffff8dcb3998 u0 9000000006a45388 s9 000000000f5ea=
330 s0 9000000006230788
> > [    0.000000] s1 9000000006265c70 s2 0000000000000001 s3 0000000000000=
001 s4 9000000006cfaa80
> > [    0.000000] s5 000000000f75dad8 s6 000000000a5b0000 s7 000000000f75d=
b30 s8 000000000eee5b18
> > [    0.000000]    ra: 9000000004cf9334 lockdep_hardirqs_on_prepare+0x20=
0/0x208
> > [    0.000000]   ERA: 9000000004cf9334 lockdep_hardirqs_on_prepare+0x20=
0/0x208
> > [    0.000000]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -W=
E)
> > [    0.000000]  PRMD: 00000000 (PPLV0 -PIE -PWE)
> > [    0.000000]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> > [    0.000000]  ECFG: 00070800 (LIE=3D11 VS=3D7)
> > [    0.000000] ESTAT: 000c0000 [BRK] (IS=3D ECode=3D12 EsubCode=3D0)
> > [    0.000000]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
> > [    0.000000] Modules linked in:
> > [    0.000000] Process swapper (pid: 0, threadinfo=3D(____ptrval____), =
task=3D(____ptrval____))
> > [    0.000000] Stack : 0000000000000001 9000000006265c70 9000000006169c=
58 9000000004dd9ba8
> > [    0.000000]         9000000006ccbc70 0000000000000000 9000000006ccbc=
70 9000000006169c58
> > [    0.000000]         00000000000000b0 90000000074f08b8 90000000086164=
78 9000000007ad1924
> > [    0.000000]         0000000000000000 9000000004e95fa8 9000000006cc80=
00 9000000006ccbdb0
> > [    0.000000]         000000000000007e 9000000006df7830 00000000000000=
00 9000000006ccbbc8
> > [    0.000000]         0000000000000001 0000000000000001 90000000073f6e=
58 9000000006175570
> > [    0.000000]         0000000000000000 0000000000000000 00000000000000=
01 0000000000000001
> > [    0.000000]         0000000000000000 0000000000000092 00000000000000=
01 0000000000006000
> > [    0.000000]         ffffffff8dcb3998 9000000006a6bed8 000000000f5ea3=
30 9000000008616478
> > [    0.000000]         90000000074f08b8 0000000000000001 00000000000000=
01 9000000006cfaa80
> > [    0.000000]         ...
> > [    0.000000] Call Trace:
> > [    0.000000] [<9000000004cf9334>] lockdep_hardirqs_on_prepare+0x200/0=
x208
> > [    0.000000] [<9000000004dd9ba4>] trace_hardirqs_on+0x54/0x70
> > [    0.000000] [<9000000006169c54>] do_reserved+0x1c/0xcc
> > [    0.000000] [<9000000004c52560>] handle_bp+0x120/0x1c0
> > [    0.000000] [<9000000004e95fa8>] static_key_enable_cpuslocked+0xdc/0=
xec
> > [    0.000000] [<9000000004e960b8>] static_key_enable+0x18/0x2c
> > [    0.000000] [<90000000061a9154>] security_add_hooks+0xbc/0x12c
> > [    0.000000] [<90000000061aa880>] lockdown_lsm_init+0x20/0x34
> > [    0.000000] [<90000000061a8a80>] initialize_lsm+0x3c/0x6c
> > [    0.000000] [<90000000061a8c34>] early_security_init+0x44/0x68
> > [    0.000000] [<9000000006180830>] start_kernel+0xa0/0x84c
> > [    0.000000] [<900000000616d0f0>] kernel_entry+0xf0/0xf8
> >
> >
>
