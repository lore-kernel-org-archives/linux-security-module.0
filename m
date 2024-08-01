Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBE13E03E;
	Thu,  1 Aug 2024 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491285; cv=none; b=tiBIc45xmcN+smpiMPZ6SFnoDBXX5UsGV7/UkFYafgybMJ6hJBxsaFR4uwxom0rghorerFwxwc4gecqHTXTbvWRrKVM/7e8WFnB3hkQjYapP14tuxUzRwYzUMpq4z4XYRZRoTIGBId0PR+3/TY4jN4KAdPRfrnXkbEKq+3/RHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491285; c=relaxed/simple;
	bh=P7LaQ8dsnoeFi/TrRvEnBd0x10u1hqJfNA4ljZGmH6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exMgPMPnUmRFs2Lpdihwtpzitkih/md3MJ7DrPn2tLtRzxiGnf6iwSMwsmpeh24Uujd4GmtS9ijtd6eOEtzvCE1v42dgM1k8RSN7YbfYqrx11x8niGnDEelQxECMkwdalAt7/aR8MaQYXsMPVezLzQ8B0mMB5onVFKLfZQK5HuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsWfpbNk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsWfpbNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9F0C4AF0C;
	Thu,  1 Aug 2024 05:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722491284;
	bh=P7LaQ8dsnoeFi/TrRvEnBd0x10u1hqJfNA4ljZGmH6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsWfpbNkhVYs94fw4vLg0qZYrVTvZ2tsiTgyQxzHwoywlE9Bxw6J4n+rSfozrnt06
	 31gRBh2P+6wpQa9a9f+H8ikPlrVK/8gvxoVyYf+Sm+1Skr+cxg0bnBvQq3LmHPmcCz
	 YUFvDFiEPsygSzM2fGbbuNQ79T6i+4hIa1qOVdPvPf1usZ4A72qPiG/c1CsJY/U/WP
	 HtmrZ3zxEn1i5eYrTPhgMabBX83I26FW/01IoDGk94e1RVX0T+jpfb6LA87fiS/AcX
	 JFfS8yiPJ5ic9m1xRoBc4qXeOGicPTH0nGPgbsiYiNeHO8QlQ0IJShZNkeGTYeBj5Q
	 dSInyn8Ed1XFQ==
Date: Wed, 31 Jul 2024 22:48:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, KP Singh <kpsingh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	bp@alien8.de, sfr@canb.auug.org.au
Subject: Re: [PATCH] init/main.c: Do jump_label_init before
 early_security_init
Message-ID: <20240801054802.GA2981775@thelio-3990X>
References: <20240731213429.2244234-1-kpsingh@kernel.org>
 <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQEYutCiAMitEv0JY4PRY4tdLdqEy76qvY1xB5q8Y13mg@mail.gmail.com>

On Wed, Jul 31, 2024 at 09:15:04PM -0400, Paul Moore wrote:
> On Wed, Jul 31, 2024 at 5:34 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > LSM indirect calls being are now replaced by static calls, this requires
> > a jumpt_table_init before early_security_init where LSM hooks and their
> > static calls and keys are initialized.
> >
> > Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  init/main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Does this look okay, static call folks?

For the record, I tested this patch since I noticed the warnings like
Boris did and it appears to break booting for me with certain ARCH=arm
configurations in QEMU.

  $ cat arch/arm/configs/repro.config
  CONFIG_JUMP_LABEL=y
  CONFIG_SECURITY=y
  CONFIG_SECURITY_LOCKDOWN_LSM=y
  CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper defconfig repro.config zImage

  $ qemu-system-arm \
      -display none \
      -nodefaults \
      -no-reboot \
      -machine virt \
      -append 'console=ttyAMA0 earlycon' \
      -kernel arch/arm/boot/zImage \
      -initrd rootfs.cpio \
      -m 512m \
      -serial mon:stdio
  <hangs with no output>

Without this patch, that same configuration works fine (with the warning
from before):

  [    0.000000] Booting Linux on physical CPU 0x0
  [    0.000000] Linux version 6.11.0-rc1-next-20240730 (nathan@m3-large-x86) (arm-linux-gnueabi-gcc (GCC) 14.1.0, GNU ld (GNU Binutils) 2.42) #1 SMP Thu Aug  1 05:44:11 UTC 2024
  [    0.000000] ------------[ cut here ]------------
  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199 static_key_enable_cpuslocked+0xb8/0xf4
  [    0.000000] static_key_enable_cpuslocked(): static key '0xc1fb4930' used before call to jump_label_init()
  [    0.000000] Modules linked in:
  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc1-next-20240730 #1
  [    0.000000] Call trace:
  [    0.000000]  unwind_backtrace from show_stack+0x10/0x14
  [    0.000000]  show_stack from dump_stack_lvl+0x54/0x68
  [    0.000000]  dump_stack_lvl from __warn+0x80/0x114
  [    0.000000]  __warn from warn_slowpath_fmt+0x124/0x18c
  [    0.000000]  warn_slowpath_fmt from static_key_enable_cpuslocked+0xb8/0xf4
  [    0.000000]  static_key_enable_cpuslocked from static_key_enable+0x14/0x1c
  [    0.000000]  static_key_enable from security_add_hooks+0xc4/0xfc
  [    0.000000]  security_add_hooks from lockdown_lsm_init+0x18/0x24
  [    0.000000]  lockdown_lsm_init from initialize_lsm+0x44/0x7c
  [    0.000000]  initialize_lsm from early_security_init+0x44/0x50
  [    0.000000]  early_security_init from start_kernel+0x64/0x6bc
  [    0.000000]  start_kernel from 0x0
  [    0.000000] ---[ end trace 0000000000000000 ]---

I haven't tried to fire up GDB to figure out why it is exploding early
since it is late for me but I figured I would get the report out first.
The rootfs is available from [1] (arm-rootfs.cpio.zst, decompress it
with zstd first); it just shuts down the machine on boot.

Cheers,
Nathan

[1]: https://github.com/ClangBuiltLinux/boot-utils/releases/latest

> > diff --git a/init/main.c b/init/main.c
> > index 206acdde51f5..5bd45af7a49e 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -922,6 +922,8 @@ void start_kernel(void)
> >         boot_cpu_init();
> >         page_address_init();
> >         pr_notice("%s", linux_banner);
> > +       /* LSM and command line parameters use static keys */
> > +       jump_label_init();
> >         early_security_init();
> >         setup_arch(&command_line);
> >         setup_boot_config();
> > @@ -933,8 +935,6 @@ void start_kernel(void)
> >         boot_cpu_hotplug_init();
> >
> >         pr_notice("Kernel command line: %s\n", saved_command_line);
> > -       /* parameters may set static keys */
> > -       jump_label_init();
> >         parse_early_param();
> >         after_dashes = parse_args("Booting kernel",
> >                                   static_command_line, __start___param,
> > --
> > 2.46.0.rc2.264.g509ed76dc8-goog
> 
> -- 
> paul-moore.com
