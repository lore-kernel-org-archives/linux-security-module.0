Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53A18E045
	for <linux-security-module@vger.kernel.org>; Thu,  1 Aug 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722513196; cv=none; b=umHPXoA9AR/xOLux+tgsH6etJ5OOOzVbVOrzaU/K9As8t6MYmyS5V3EFnrWNnNHAEJTIxwJAJGOcgakOHCp+wXdLzxe4RlDAWnOCU+l6MRi4P0yCnBKnbo0fgV53k2KT3TiISO7ekBA/e+TKA2VLV18RRr6FfUvx9jogS22JMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722513196; c=relaxed/simple;
	bh=2JkqGG3u9AoeaPoPfCeIk9B0Az23APwzzZX2UAtuk+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0fU4gr+jLBmC44WP22+77A3d4lpsmQSkvFgwJhZ6CNi+SEZWNvhT0lU/ryEF2cdsxkpCDTGj7u7zPb1Kn9hZnZ27NubLHdkWJu7rYKVfSpqlM/tvmm2mhoqdSu1z2B2JyNE7dhMPqK1Qp/YN/Fh4QmuWPU93wkpAvn4IVKtnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFE5spZ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFE5spZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2741AC4AF0A
	for <linux-security-module@vger.kernel.org>; Thu,  1 Aug 2024 11:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722513196;
	bh=2JkqGG3u9AoeaPoPfCeIk9B0Az23APwzzZX2UAtuk+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WFE5spZ+nWKOHlOi94arSQeXJJAEvchDqbeypZvuPGjvo1l9O4qqT4YZqylaNLyix
	 zGzeFUw25hmf7H7X+ahudy7YQ9Y6qDBrvZN1pm+hwv5E65I24JL0S0vTBR1zNMKmLf
	 mE2ObR+4GbiBp0iXPeymTWCqA109qObVSQSj1d1lKwzMu2yXEZhZWKCUEm0SVgPWc9
	 e/OwgZcEJVoD/0k232iKzfGXkX6foSkyWemV32XiBlXgGE8hFtCyoW18a9vncxCUi7
	 yKlgVmY06nCb7idS4UgHXCPkfFaYqc2ExnLPZLVGh7d65+ZLIunfbq3N/E1dB7H4h+
	 0+TqVsBTzLb7w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f04150796so11299148e87.3
        for <linux-security-module@vger.kernel.org>; Thu, 01 Aug 2024 04:53:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBxdvZPRvYxxOWRI3VdYzjjtfI2O313pkzsA2WE5z6mZjEi8yLSZb7F3OEkcDCwi7C8pQlIkTsDrVXJlorzUDhwd3hlG9mE3sWrWx0TvY6QYbJ8V0x
X-Gm-Message-State: AOJu0YxIXq9AQTyMmPzrc+BOM8JXMlUBSCBfjq1NVjDv4ItD2dNyhDXz
	ObnBNcafrJnh0hBZKF9TyTro6TMZ9ENIoorqtigXr17O+NXjHBhF17KUEpbODiSBdffLUKJETn8
	WOehHZOhQhmpf0RAMTbEPEQJ/w+rGUUibE8Bw
X-Google-Smtp-Source: AGHT+IEq6m8RQQVSGlwv3gyJwDZFa2POPcCKdqpo1X4lBSEmPi7tbxXZsLSPYYrJfwEdey/t3PnWIo7tRZLsNWWv7GU=
X-Received: by 2002:a05:6512:b99:b0:530:ad8b:de0a with SMTP id
 2adb3069b0e04-530b61a49f9mr1539199e87.9.1722513194446; Thu, 01 Aug 2024
 04:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731213429.2244234-1-kpsingh@kernel.org> <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>
 <20240801054802.GA2981775@thelio-3990X> <20240801061441.GB2981775@thelio-3990X>
In-Reply-To: <20240801061441.GB2981775@thelio-3990X>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 1 Aug 2024 13:53:03 +0200
X-Gmail-Original-Message-ID: <CACYkzJ56T1pe3hWFxCp5mOgo1qHOK6CNteH57JRR6Sds+41LmQ@mail.gmail.com>
Message-ID: <CACYkzJ56T1pe3hWFxCp5mOgo1qHOK6CNteH57JRR6Sds+41LmQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Do jump_label_init before early_security_init
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 8:14=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Wed, Jul 31, 2024 at 10:48:06PM -0700, Nathan Chancellor wrote:
> > On Wed, Jul 31, 2024 at 09:15:04PM -0400, Paul Moore wrote:
> > > On Wed, Jul 31, 2024 at 5:34=E2=80=AFPM KP Singh <kpsingh@kernel.org>=
 wrote:
> > > >
> > > > LSM indirect calls being are now replaced by static calls, this req=
uires
> > > > a jumpt_table_init before early_security_init where LSM hooks and t=
heir
> > > > static calls and keys are initialized.
> > > >
> > > > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with sta=
tic calls")
> > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > > ---
> > > >  init/main.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Does this look okay, static call folks?
> >
> > For the record, I tested this patch since I noticed the warnings like
> > Boris did and it appears to break booting for me with certain ARCH=3Dar=
m
> > configurations in QEMU.
> >
> >   $ cat arch/arm/configs/repro.config
> >   CONFIG_JUMP_LABEL=3Dy
> >   CONFIG_SECURITY=3Dy
> >   CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
> >   CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy
> >
> >   $ make -skj"$(nproc)" ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- m=
rproper defconfig repro.config zImage
> >
> >   $ qemu-system-arm \
> >       -display none \
> >       -nodefaults \
> >       -no-reboot \
> >       -machine virt \
> >       -append 'console=3DttyAMA0 earlycon' \
> >       -kernel arch/arm/boot/zImage \
> >       -initrd rootfs.cpio \
> >       -m 512m \
> >       -serial mon:stdio
> >   <hangs with no output>
> >
> > Without this patch, that same configuration works fine (with the warnin=
g
> > from before):
> >
> >   [    0.000000] Booting Linux on physical CPU 0x0
> >   [    0.000000] Linux version 6.11.0-rc1-next-20240730 (nathan@m3-larg=
e-x86) (arm-linux-gnueabi-gcc (GCC) 14.1.0, GNU ld (GNU Binutils) 2.42) #1 =
SMP Thu Aug  1 05:44:11 UTC 2024
> >   [    0.000000] ------------[ cut here ]------------
> >   [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199 stat=
ic_key_enable_cpuslocked+0xb8/0xf4
> >   [    0.000000] static_key_enable_cpuslocked(): static key '0xc1fb4930=
' used before call to jump_label_init()
> >   [    0.000000] Modules linked in:
> >   [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-=
rc1-next-20240730 #1
> >   [    0.000000] Call trace:
> >   [    0.000000]  unwind_backtrace from show_stack+0x10/0x14
> >   [    0.000000]  show_stack from dump_stack_lvl+0x54/0x68
> >   [    0.000000]  dump_stack_lvl from __warn+0x80/0x114
> >   [    0.000000]  __warn from warn_slowpath_fmt+0x124/0x18c
> >   [    0.000000]  warn_slowpath_fmt from static_key_enable_cpuslocked+0=
xb8/0xf4
> >   [    0.000000]  static_key_enable_cpuslocked from static_key_enable+0=
x14/0x1c
> >   [    0.000000]  static_key_enable from security_add_hooks+0xc4/0xfc
> >   [    0.000000]  security_add_hooks from lockdown_lsm_init+0x18/0x24
> >   [    0.000000]  lockdown_lsm_init from initialize_lsm+0x44/0x7c
> >   [    0.000000]  initialize_lsm from early_security_init+0x44/0x50
> >   [    0.000000]  early_security_init from start_kernel+0x64/0x6bc
> >   [    0.000000]  start_kernel from 0x0
> >   [    0.000000] ---[ end trace 0000000000000000 ]---
> >
> > I haven't tried to fire up GDB to figure out why it is exploding early
> > since it is late for me but I figured I would get the report out first.
> > The rootfs is available from [1] (arm-rootfs.cpio.zst, decompress it
> > with zstd first); it just shuts down the machine on boot.
> >

Thank you so much Nathan! I finally had the time to debug and it seems
like we need setup_arch before early_security_init. I will update my
patch and send it for review.

> > Cheers,
> > Nathan
> >
> > [1]: https://github.com/ClangBuiltLinux/boot-utils/releases/latest
>
> Also, looking at my build logs, this patch does not appear to resolve
> the static call warning I see with certain x86_64 distribution
> configurations such as Fedora's (not sure if it was or not):
>
> https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-x86_64-fed=
ora.config
>
> [    0.000000] Linux version 6.11.0-rc1-next-20240730-dirty (nathan@m3-la=
rge-x86) (x86_64-linux-gcc (GCC) 14.1.0, GNU ld (GNU Binutils) 2.42) #1 SMP=
 PREEMPT_DYNAMIC Thu Aug  1 06:09:54 UTC 2024
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/static_call_inline.c:153 =
__static_call_update+0x18c/0x1f0
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc1-=
next-20240730-dirty #1
> [    0.000000] RIP: 0010:__static_call_update+0x18c/0x1f0
> [    0.000000] Code: 80 3d b6 7b 49 02 00 0f 85 7b ff ff ff 4c 89 f6 48 c=
7 c7 90 3b bc 8b c6 05 9f 7b 49 02 01 e8 2b 5c da ff 0f 0b e9 5e ff ff ff <=
0f> 0b 48 c7 c7 40 f2 5f 8c e8 36 72 e4 00 48 8b 44 24 28 65 48 2b
> [    0.000000] RSP: 0000:ffffffff8c403e28 EFLAGS: 00010046 ORIG_RAX: 0000=
000000000000
> [    0.000000] RAX: 0000000000000000 RBX: ffffffff8b19cd60 RCX: 000000005=
e199be9
> [    0.000000] RDX: 0000000000000000 RSI: ffffffff8d302a70 RDI: ffffffff8=
c472500
> [    0.000000] RBP: ffffffff8c6a01a0 R08: 00000000ff5e199b R09: fffffffff=
ffbf82b
> [    0.000000] R10: 0000000000000000 R11: 0000000000013f90 R12: ffffffff8=
b4d0cb0
> [    0.000000] R13: 0000000000000001 R14: ffffffff8a77e700 R15: 000000000=
00147d0
> [    0.000000] FS:  0000000000000000(0000) GS:ffffffff8ce3e000(0000) knlG=
S:0000000000000000
> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.000000] CR2: ffff8880000147d0 CR3: 000000000af46000 CR4: 000000000=
00000b0
> [    0.000000] Call Trace:
> [    0.000000]  <TASK>
> [    0.000000]  ? __static_call_update+0x18c/0x1f0
> [    0.000000]  ? __warn.cold+0x93/0xed
> [    0.000000]  ? __static_call_update+0x18c/0x1f0
> [    0.000000]  ? report_bug+0xff/0x140
> [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> [    0.000000]  ? early_fixup_exception+0x5d/0xb0
> [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_7+0x8/0x8
> [    0.000000]  ? early_idt_handler_common+0x2f/0x3a
> [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_7+0x8/0x8
> [    0.000000]  ? __static_call_update+0x18c/0x1f0
> [    0.000000]  ? __static_call_update+0x7e/0x1f0
> [    0.000000]  ? sort_r+0x112/0x390
> [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> [    0.000000]  ? security_add_hooks+0xb8/0x120
> [    0.000000]  ? lockdown_lsm_init+0x21/0x30
> [    0.000000]  ? initialize_lsm+0x34/0x60
> [    0.000000]  ? early_security_init+0x3d/0x50
> [    0.000000]  ? start_kernel+0x6b/0xa00
> [    0.000000]  ? x86_64_start_reservations+0x24/0x30
> [    0.000000]  ? x86_64_start_kernel+0xed/0xf0
> [    0.000000]  ? common_startup_64+0x13e/0x141
> [    0.000000]  </TASK>
> [    0.000000] ---[ end trace 0000000000000000 ]---
>
> Seems like the same problem.
>
> > > > diff --git a/init/main.c b/init/main.c
> > > > index 206acdde51f5..5bd45af7a49e 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -922,6 +922,8 @@ void start_kernel(void)
> > > >         boot_cpu_init();
> > > >         page_address_init();
> > > >         pr_notice("%s", linux_banner);
> > > > +       /* LSM and command line parameters use static keys */
> > > > +       jump_label_init();
> > > >         early_security_init();
> > > >         setup_arch(&command_line);
> > > >         setup_boot_config();
> > > > @@ -933,8 +935,6 @@ void start_kernel(void)
> > > >         boot_cpu_hotplug_init();
> > > >
> > > >         pr_notice("Kernel command line: %s\n", saved_command_line);
> > > > -       /* parameters may set static keys */
> > > > -       jump_label_init();
> > > >         parse_early_param();
> > > >         after_dashes =3D parse_args("Booting kernel",
> > > >                                   static_command_line, __start___pa=
ram,
> > > > --
> > > > 2.46.0.rc2.264.g509ed76dc8-goog
> > >
> > > --
> > > paul-moore.com
