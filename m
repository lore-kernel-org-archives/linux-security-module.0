Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72A1547FB
	for <linux-security-module@vger.kernel.org>; Mon,  5 Aug 2024 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900590; cv=none; b=qz6KPpwyUjZV0X9cWqjJueb9Kusxn+3tkyyakzg6vEUlHll5SXpryLGxMQKHQuIX9AqCyC7wbZrI8Eu3R+uvdWDtshFbRe5QlQM1ed8UOUjrhU8ka0+r9OTpTlyhS9eQy4J0cEqC4tYerPE4ecUNJRl7wUWiHF0vJOFa/FLwvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900590; c=relaxed/simple;
	bh=9KT85ZG8qL1uXywoURq0EUsAItXn13iZ/j5Ob17zV2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQ4t+SHF8u0z7cuFHrzn2LJcokdb8/zDZaDHEVqfIVsw08mBtQa80mSt5jct/+GWLCBS7rClxWJu8cBMH4SvGm4wA9qlauBZuwe8X2niHr09KLm1f8wvHauInl0jrsYERGlGwLUEps0Vuiw+HSn1dwsGMGMYxnVFK5g4FajaljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9s51X0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9s51X0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8DFC4AF49
	for <linux-security-module@vger.kernel.org>; Mon,  5 Aug 2024 23:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900590;
	bh=9KT85ZG8qL1uXywoURq0EUsAItXn13iZ/j5Ob17zV2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J9s51X0G7pUfW6WI1DlWiJRAor+8XR+vrkQk1ApUTpqmyE4KEWXndsSrOyHkcaDAR
	 3pW1KHbTCr4dQViBGJJaJbvrWEgaxBxbtgtsVqq06rlbys1CiXlgFBohxDnBSCE3qf
	 aeAFAgUqXWWqn0azxcKbcNBGH4wgz9jC52iDg8CwXZtLinUPElps69qSGLss6cfSRb
	 sPMa35/KJlST+nZAKkzadAPFLUIVn4ZkUWvDSJ0DElcoCRLuouo+fquH5KfNJZ7CuI
	 YewXmdVHkOEItAUKz4bcV4WhJKxwjyd3Iwr6L1GZFGXVjKEpDT1Ya+d+XLAN52iUln
	 WDrtWgSKvWIIw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so58505a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2024 16:29:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHYp3CU1Gu4hk93YIaWp38ckeb/Csyvif3hpq7moldV9TtpUd03TNt5yYq6q6JEm8bI0tgYygCYvO/IrhiYfwxuulRRJgaQZoGZAYz8Jiv4X2/DTRr
X-Gm-Message-State: AOJu0YzXWjGbmVwGJ8Ijd2QerGbd5q+4DyutFT5GZYL9wF8Qmrj/bJ/B
	IcdQaL5ttZAaxC3gZU/O8Mhxmc+i72XLEqUoiEjSJOp80BkUNKxir/AtmOCwdmh6+BqTYuCM+5E
	lsm0aOgsxDOd8Wmptu4wAjmA+8pb9sV2W2Etg
X-Google-Smtp-Source: AGHT+IEjGsl/3ITwONAitDUlOHRVrs/n8yabTBbhv0A2kzxoIdxl5+KBi6lR5hb76fNvjisl8AT+K0VrKy+i73O8Ofo=
X-Received: by 2002:a50:fb8c:0:b0:57c:9da5:fc09 with SMTP id
 4fb4d7f45d1cf-5b7f5414ee1mr9635832a12.23.1722900588412; Mon, 05 Aug 2024
 16:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
In-Reply-To: <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 6 Aug 2024 01:29:37 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
Message-ID: <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bp@alien8.de, sfr@canb.auug.org.au, peterz@infradead.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 9:58=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> >
> > With LSMs using static calls, early_lsm_init needs to wait for setup_ar=
ch
> > for architecture specific functionality which includes jump tables and
> > static calls to be initialized.
> >
> > This only affects "early LSMs" i.e. only lockdown when
> > CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.
> >
> > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static =
calls")
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  init/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Considering the problems we've had, I'd like to hear more about how

Sure, the first patch I sent while I had enabled
CONFIG_SECURITY_LOCDOWN_EARLY_INIT, I missed setting it in the command
line i.e CONFIG_LSM. Thus I thought the crash was fixed and I did not
check ARM. But then here's what I did and I will paste outputs for
posterity:

kpsingh@kpsingh:~/projects/linux$ cat .config | grep -i LOCKDOWN
CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy
CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,bpf"

I first tested with the commands that Nathan had given me:

kpsingh@kpsingh:~/projects/linux$ make -skj"$(nproc)" ARCH=3Darm
CROSS_COMPILE=3Darm-linux-gnueabi- defconfig repro.config zImage

and I was able to reproduce the issue:

kpsingh@kpsingh:~/projects/linux$ qemu-system-arm       -display none
     -nodefaults       -no-reboot       -machine virt       -append
'console=3DttyAMA0 earlycon'       -kernel arch/arm/boot/zImage
-initrd rootfs.cpio       -m 512m       -serial mon:stdio
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.11.0-rc1-00011-g269d5c03e612
(kpsingh@kpsingh.zrh.corp.google.com) (arm-linux-gnueabi-gcc (Debian
13.2.0-7) 13.2.0, GNU ld (GNU Binutils for Debian) 2.42) #7 SMP Tue
Aug  6 01:20:11 CEST 2024
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199
static_key_enable_cpuslocked+0xb8/0xf4
[    0.000000] static_key_enable_cpuslocked(): static key '0xc1fb4cb0'
used before call to jump_label_init()
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted
6.11.0-rc1-00011-g269d5c03e612 #7
[    0.000000] Call trace:
[    0.000000]  unwind_backtrace from show_stack+0x10/0x14
[    0.000000]  show_stack from dump_stack_lvl+0x54/0x68
[    0.000000]  dump_stack_lvl from __warn+0x78/0x114
[    0.000000]  __warn from warn_slowpath_fmt+0x124/0x18c
[    0.000000]  warn_slowpath_fmt from static_key_enable_cpuslocked+0xb8/0x=
f4
[    0.000000]  static_key_enable_cpuslocked from static_key_enable+0x14/0x=
1c
[    0.000000]  static_key_enable from security_add_hooks+0xc4/0xfc
[    0.000000]  security_add_hooks from lockdown_lsm_init+0x18/0x24
[    0.000000]  lockdown_lsm_init from initialize_lsm+0x44/0x7c
[    0.000000]  initialize_lsm from early_security_init+0x44/0x50
[    0.000000]  early_security_init from start_kernel+0x64/0x6bc
[    0.000000]  start_kernel from 0x0
[    0.000000] ---[ end trace 0000000000000000 ]---

and with my patch:

kpsingh@kpsingh:~/projects/linux$ git lg -1
48ad43fb07be - init/main.c: Initialize early LSMs after arch code
(HEAD -> fix_jump_table_init) (2024-08-01 KP Singh)
kpsingh@kpsingh:~/projects/linux$ qemu-system-arm       -display none
     -nodefaults       -no-reboot       -machine virt       -append
'console=3DttyAMA0 earlycon'       -kernel arch/arm/boot/zImage
-initrd rootfs.cpio       -m 512m       -serial mon:stdio
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.11.0-rc1-00012-g48ad43fb07be
(kpsingh@kpsingh.zrh.corp.google.com) (arm-linux-gnueabi-gcc (Debian
13.2.0-7) 13.2.0, GNU ld (GNU Binutils for Debian) 2.42) #8 SMP Tue
Aug  6 01:22:00 CEST 2024
[    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=3D10c=
5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction ca=
che
[    0.000000] OF: fdt: Machine model: linux,dummy-virt
[    0.000000] random: crng init done
[    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 64 MiB at 0x5c000000 on node -1

Then I went ahead and confirmed this on x86 too:

Before the patch, repro:

/usr/bin/qemu-system-x86_64 -nographic -s -bios qboot.rom -machine q35
-enable-kvm -cpu host -net nic,model=3Dvirtio-net-pci -net
user,hostfwd=3Dtcp::5555-:22 -virtfs
local,path=3D/,mount_tag=3Dhostfs,security_model=3Dnone,multidevs=3Dremap
-append "console=3DttyS0,115200 root=3D/dev/sda rw nokaslr
init=3D/lib/systemd/systemd debug systemd.log_level=3Dinfo
sysctl.vm.dirty_bytes=3D2147483647" -smp 24 -m 64G -drive
file=3D/usr/local/google/home/kpsingh/.vmcli/debian-x86_64.img -qmp
tcp:localhost:4444,server,nowait -serial mon:stdio -kernel
/usr/local/google/home/kpsingh/projects/linux/arch/x86_64/boot/bzImage

[    0.000000] Linux version 6.11.0-rc1-00011-g269d5c03e612
(kpsingh@kpsingh.zrh.corp.google.com) (clang version 19.0.0git
(https://github.com/llvm/llvm-project.git
502e77df1fc4aa859db6709e14e93af6207e4dc4), Debian LLD 16.0.6) #9 SMP
PREEMPT_DYNAMIC Tue Aug  6 01:25:06 CEST 2024
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at
kernel/static_call_inline.c:153 __static_call_update+0x29f/0x310
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted
6.11.0-rc1-00011-g269d5c03e612 #9
[    0.000000] RIP: 0010:__static_call_update+0x29f/0x310
[    0.000000] Code: c1 02 75 9d 80 3d 90 3c 89 03 00 75 94 c6 05 87
3c 89 03 01 48 c7 c7 00 11 0e 83 4c 89 ee e8 c8 d6 c9 ff 0f 0b e9 77
ff ff ff <0f> 0b 48 c7 c7 60 e9 6c 84 e8 b3 24 86 01 e8 0e eb c9 ff 48
c7 44
[    0.000000] RSP: 0000:ffffffff84407d60 EFLAGS: 00010046 ORIG_RAX:
0000000000000000
[    0.000000] RAX: 0000000000000000 RBX: ffffffff8196cf30 RCX: ffffffff82c=
af1c6
[    0.000000] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff844=
07ce0
[    0.000000] RBP: ffffffff84407e60 R08: ffffffff84407ce7 R09: 1ffffffff08=
80f9c
[    0.000000] R10: dffffc0000000000 R11: fffffbfff0880f9d R12: 00000000000=
00010
[    0.000000] R13: ffffffff848157a0 R14: ffffffff83b69cb0 R15: ffffffff82c=
c05e8
[    0.000000] FS:  0000000000000000(0000) GS:ffffffff85403000(0000)
knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffff888000014700 CR3: 0000000005504000 CR4: 00000000000=
000b0
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  ? __warn+0xff/0x2d0
[    0.000000]  ? __static_call_update+0x29f/0x310
[    0.000000]  ? report_bug+0x12f/0x1c0
[    0.000000]  ? early_fixup_exception+0x8a/0x100
[    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
[    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_5+0x8/0x8
[    0.000000]  ? early_idt_handler_common+0x2f/0x40
[    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_5+0x8/0x8
[    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
[    0.000000]  ? __mutex_unlock_slowpath+0x156/0x400
[    0.000000]  ? __static_call_update+0x29f/0x310
[    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
[    0.000000]  ? __pfx_vprintk_emit+0x10/0x10
[    0.000000]  ? __asan_memset+0x22/0x50
[    0.000000]  ? __pfx___static_call_update+0x10/0x10
[    0.000000]  ? _printk+0xd4/0x120
[    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_5+0x8/0x8
[    0.000000]  ? lsm_static_call_init+0x99/0xd0
[    0.000000]  ? security_add_hooks+0x86/0xf0
[    0.000000]  ? lockdown_lsm_init+0x21/0x30
[    0.000000]  ? initialize_lsm+0x48/0x90
[    0.000000]  ? early_security_init+0x52/0x70
[    0.000000]  ? start_kernel+0x6b/0x3d0
[    0.000000]  ? x86_64_start_reservations+0x24/0x30
[    0.000000]  ? x86_64_start_kernel+0xa9/0xb0
[    0.000000]  ? common_startup_64+0x12c/0x137
[    0.000000]  </TASK>
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.000000] hardirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000000] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.000000] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] ------------[ cut here ]------------

and with the patch:

/usr/bin/qemu-system-x86_64 -nographic -s -bios qboot.rom -machine q35
-enable-kvm -cpu host -net nic,model=3Dvirtio-net-pci -net
user,hostfwd=3Dtcp::5555-:22 -virtfs
local,path=3D/,mount_tag=3Dhostfs,security_model=3Dnone,multidevs=3Dremap
-append "console=3DttyS0,115200 root=3D/dev/sda rw nokaslr
init=3D/lib/systemd/systemd debug systemd.log_level=3Dinfo
sysctl.vm.dirty_bytes=3D2147483647" -smp 24 -m 64G -drive
file=3D/usr/local/google/home/kpsingh/.vmcli/debian-x86_64.img -qmp
tcp:localhost:4444,server,nowait -serial mon:stdio -kernel
/usr/local/google/home/kpsingh/projects/linux/arch/x86_64/boot/bzImage

[    0.000000] Linux version 6.11.0-rc1-00012-g48ad43fb07be
(kpsingh@kpsingh.zrh.corp.google.com) (clang version 19.0.0git
(https://github.com/llvm/llvm-project.git
502e77df1fc4aa859db6709e14e93af6207e4dc4), Debian LLD 16.0.6) #10 SMP
PREEMPT_DYNAMIC Tue Aug  6 01:27:35 CEST 2024
[    0.000000] Command line: console=3DttyS0,115200 root=3D/dev/sda rw
nokaslr init=3D/lib/systemd/systemd debug systemd.log_level=3Dinfo
sysctl.vm.dirty_bytes=3D2147483647
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000d0000-0x00000000000effff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007fffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000107fffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active

I then left this VM (well a previous instance, I had to redo the tests
to prove that I did them and save the logs) running and using it for
some of my dev work and did not see any crashes since.

> you've tested this and I'd like to see some reviews/ACKs from some
> arch people too.

This is not the same patch as the previous one, it does not change
anything for arch, rather the decision is LSM okay waiting for arch to
initialize. arch never depended on the LSM code, early LSM was done as
early as possible and now, because of static calls it needs to wait
for setup_arch, it's mostly an LSM decision here.

I guess it would not harm Boris, Nathan and others to look at it as
well and see if it breaks any of their tests.

- KP

>
> > diff --git a/init/main.c b/init/main.c
> > index 206acdde51f5..a0e3f3c720e6 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -922,8 +922,8 @@ void start_kernel(void)
> >         boot_cpu_init();
> >         page_address_init();
> >         pr_notice("%s", linux_banner);
> > -       early_security_init();
> >         setup_arch(&command_line);
> > +       early_security_init();
> >         setup_boot_config();
> >         setup_command_line(command_line);
> >         setup_nr_cpu_ids();
> > --
> > 2.46.0.rc2.264.g509ed76dc8-goog
>
> --
> paul-moore.com
