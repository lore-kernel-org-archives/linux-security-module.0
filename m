Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A616DC26;
	Thu,  1 Aug 2024 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492883; cv=none; b=rF0Rqbuoihw3S7xzGbwSeQ4/JSgdewQB5ymwSWIFnpOzmfNdo7P+gbDqVGLpedF2QVQbCs2szUXFqK7dNFwZrKO9c8930eAzl45nLlP8K4zke469slarWmAzqlr6h7bsXhi2fT7DLr4JFYCGJ91caqdLhNFLxiyk+1qmNkomZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492883; c=relaxed/simple;
	bh=1/LkbCzWs7IPH0fuAhmtMESKc8nxEAc9nXP5PcNCCbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EES7AcX28sgL5L4/jMDa6G7J474lSl0JwOQLPvj5HW+puWP/18Qy1gzWznYcMSnD75DgVzy1B9ru5HUpOQ3VYBqMogBcuGcnsuTN48bpFxKHKTjF+srWjRf7n1+/H0uL+rzvcE8ivEXn3eR1hSvGCwiWJw8co4fZiuqmd6Djnj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbDqstCd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbDqstCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB138C4AF09;
	Thu,  1 Aug 2024 06:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492883;
	bh=1/LkbCzWs7IPH0fuAhmtMESKc8nxEAc9nXP5PcNCCbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbDqstCdZvS3ZS2Lt7pVBXfe9EwTWH1ZGgLVtTeSoBpzB3HNaHdUEnQzMUOR4u+yB
	 R6CJQCprTSu3MRyty6O7toT0ofJEYbb/MchoaK0Xj5y9LX+WFS7lAqetuAUFeE+ri0
	 IonSIUzRAtZcEaDqMrml9IybNJWihkmsdOINoVTVk2t/uy/jxNPH0cObe2erVwS2MQ
	 dPHkEq9JSISgrdtDxZIKPz/OHssCa03T0vu0Gkv39Y3UpQYnx+epRNtand5eDPliEy
	 UGiaPbIUHJHlmYlqXaMUKfSln5SXOnHASp6P47hPY/ZaeH7tmoTetfnleoc2/CEkQc
	 IOSMr14tA27Eg==
Date: Wed, 31 Jul 2024 23:14:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, KP Singh <kpsingh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	bp@alien8.de, sfr@canb.auug.org.au
Subject: Re: [PATCH] init/main.c: Do jump_label_init before
 early_security_init
Message-ID: <20240801061441.GB2981775@thelio-3990X>
References: <20240731213429.2244234-1-kpsingh@kernel.org>
 <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>
 <20240801054802.GA2981775@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801054802.GA2981775@thelio-3990X>

On Wed, Jul 31, 2024 at 10:48:06PM -0700, Nathan Chancellor wrote:
> On Wed, Jul 31, 2024 at 09:15:04PM -0400, Paul Moore wrote:
> > On Wed, Jul 31, 2024 at 5:34 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > LSM indirect calls being are now replaced by static calls, this requires
> > > a jumpt_table_init before early_security_init where LSM hooks and their
> > > static calls and keys are initialized.
> > >
> > > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  init/main.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Does this look okay, static call folks?
> 
> For the record, I tested this patch since I noticed the warnings like
> Boris did and it appears to break booting for me with certain ARCH=arm
> configurations in QEMU.
> 
>   $ cat arch/arm/configs/repro.config
>   CONFIG_JUMP_LABEL=y
>   CONFIG_SECURITY=y
>   CONFIG_SECURITY_LOCKDOWN_LSM=y
>   CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
> 
>   $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper defconfig repro.config zImage
> 
>   $ qemu-system-arm \
>       -display none \
>       -nodefaults \
>       -no-reboot \
>       -machine virt \
>       -append 'console=ttyAMA0 earlycon' \
>       -kernel arch/arm/boot/zImage \
>       -initrd rootfs.cpio \
>       -m 512m \
>       -serial mon:stdio
>   <hangs with no output>
> 
> Without this patch, that same configuration works fine (with the warning
> from before):
> 
>   [    0.000000] Booting Linux on physical CPU 0x0
>   [    0.000000] Linux version 6.11.0-rc1-next-20240730 (nathan@m3-large-x86) (arm-linux-gnueabi-gcc (GCC) 14.1.0, GNU ld (GNU Binutils) 2.42) #1 SMP Thu Aug  1 05:44:11 UTC 2024
>   [    0.000000] ------------[ cut here ]------------
>   [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199 static_key_enable_cpuslocked+0xb8/0xf4
>   [    0.000000] static_key_enable_cpuslocked(): static key '0xc1fb4930' used before call to jump_label_init()
>   [    0.000000] Modules linked in:
>   [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc1-next-20240730 #1
>   [    0.000000] Call trace:
>   [    0.000000]  unwind_backtrace from show_stack+0x10/0x14
>   [    0.000000]  show_stack from dump_stack_lvl+0x54/0x68
>   [    0.000000]  dump_stack_lvl from __warn+0x80/0x114
>   [    0.000000]  __warn from warn_slowpath_fmt+0x124/0x18c
>   [    0.000000]  warn_slowpath_fmt from static_key_enable_cpuslocked+0xb8/0xf4
>   [    0.000000]  static_key_enable_cpuslocked from static_key_enable+0x14/0x1c
>   [    0.000000]  static_key_enable from security_add_hooks+0xc4/0xfc
>   [    0.000000]  security_add_hooks from lockdown_lsm_init+0x18/0x24
>   [    0.000000]  lockdown_lsm_init from initialize_lsm+0x44/0x7c
>   [    0.000000]  initialize_lsm from early_security_init+0x44/0x50
>   [    0.000000]  early_security_init from start_kernel+0x64/0x6bc
>   [    0.000000]  start_kernel from 0x0
>   [    0.000000] ---[ end trace 0000000000000000 ]---
> 
> I haven't tried to fire up GDB to figure out why it is exploding early
> since it is late for me but I figured I would get the report out first.
> The rootfs is available from [1] (arm-rootfs.cpio.zst, decompress it
> with zstd first); it just shuts down the machine on boot.
> 
> Cheers,
> Nathan
> 
> [1]: https://github.com/ClangBuiltLinux/boot-utils/releases/latest

Also, looking at my build logs, this patch does not appear to resolve
the static call warning I see with certain x86_64 distribution
configurations such as Fedora's (not sure if it was or not):

https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-x86_64-fedora.config

[    0.000000] Linux version 6.11.0-rc1-next-20240730-dirty (nathan@m3-large-x86) (x86_64-linux-gcc (GCC) 14.1.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT_DYNAMIC Thu Aug  1 06:09:54 UTC 2024
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/static_call_inline.c:153 __static_call_update+0x18c/0x1f0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc1-next-20240730-dirty #1
[    0.000000] RIP: 0010:__static_call_update+0x18c/0x1f0
[    0.000000] Code: 80 3d b6 7b 49 02 00 0f 85 7b ff ff ff 4c 89 f6 48 c7 c7 90 3b bc 8b c6 05 9f 7b 49 02 01 e8 2b 5c da ff 0f 0b e9 5e ff ff ff <0f> 0b 48 c7 c7 40 f2 5f 8c e8 36 72 e4 00 48 8b 44 24 28 65 48 2b
[    0.000000] RSP: 0000:ffffffff8c403e28 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
[    0.000000] RAX: 0000000000000000 RBX: ffffffff8b19cd60 RCX: 000000005e199be9
[    0.000000] RDX: 0000000000000000 RSI: ffffffff8d302a70 RDI: ffffffff8c472500
[    0.000000] RBP: ffffffff8c6a01a0 R08: 00000000ff5e199b R09: fffffffffffbf82b
[    0.000000] R10: 0000000000000000 R11: 0000000000013f90 R12: ffffffff8b4d0cb0
[    0.000000] R13: 0000000000000001 R14: ffffffff8a77e700 R15: 00000000000147d0
[    0.000000] FS:  0000000000000000(0000) GS:ffffffff8ce3e000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffff8880000147d0 CR3: 000000000af46000 CR4: 00000000000000b0
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  ? __static_call_update+0x18c/0x1f0
[    0.000000]  ? __warn.cold+0x93/0xed
[    0.000000]  ? __static_call_update+0x18c/0x1f0
[    0.000000]  ? report_bug+0xff/0x140
[    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
[    0.000000]  ? early_fixup_exception+0x5d/0xb0
[    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_7+0x8/0x8
[    0.000000]  ? early_idt_handler_common+0x2f/0x3a
[    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
[    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_7+0x8/0x8
[    0.000000]  ? __static_call_update+0x18c/0x1f0
[    0.000000]  ? __static_call_update+0x7e/0x1f0
[    0.000000]  ? sort_r+0x112/0x390
[    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
[    0.000000]  ? security_add_hooks+0xb8/0x120
[    0.000000]  ? lockdown_lsm_init+0x21/0x30
[    0.000000]  ? initialize_lsm+0x34/0x60
[    0.000000]  ? early_security_init+0x3d/0x50
[    0.000000]  ? start_kernel+0x6b/0xa00
[    0.000000]  ? x86_64_start_reservations+0x24/0x30
[    0.000000]  ? x86_64_start_kernel+0xed/0xf0
[    0.000000]  ? common_startup_64+0x13e/0x141
[    0.000000]  </TASK>
[    0.000000] ---[ end trace 0000000000000000 ]---

Seems like the same problem.

> > > diff --git a/init/main.c b/init/main.c
> > > index 206acdde51f5..5bd45af7a49e 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -922,6 +922,8 @@ void start_kernel(void)
> > >         boot_cpu_init();
> > >         page_address_init();
> > >         pr_notice("%s", linux_banner);
> > > +       /* LSM and command line parameters use static keys */
> > > +       jump_label_init();
> > >         early_security_init();
> > >         setup_arch(&command_line);
> > >         setup_boot_config();
> > > @@ -933,8 +935,6 @@ void start_kernel(void)
> > >         boot_cpu_hotplug_init();
> > >
> > >         pr_notice("Kernel command line: %s\n", saved_command_line);
> > > -       /* parameters may set static keys */
> > > -       jump_label_init();
> > >         parse_early_param();
> > >         after_dashes = parse_args("Booting kernel",
> > >                                   static_command_line, __start___param,
> > > --
> > > 2.46.0.rc2.264.g509ed76dc8-goog
> > 
> > -- 
> > paul-moore.com
