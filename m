Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE80196DA1;
	Tue, 30 Jul 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347043; cv=none; b=gyDxyo1hLIm6kYwKYnN7wG28QwDHfPgca2bmPdhtZ1PN6uzdC1mh2N906KTCcUmpABpny+v8sb+zZ9vJDiHK3Xe2Vojj87ijWD1wvvFLo6YNtGbb3O/zXDHLlAiGI/bZBvLQjMrWc3OX+JAci+eEpeYHoN9ARgiLYK36mISjDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347043; c=relaxed/simple;
	bh=j8W+lKM7JtAyWLDBaPVItmBBqdA2UN9WmhIaX8pqxro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tti/Vi44kSJiNNyH/oO+QI22oBGXE7pFu2utwQhaFT59GyS2OsTm0IifquKN6eLUyDDmpie4F+OwA/IOePtBNyhDzbg7vblYc8Ws/e4+moshvnOS55/v58XuiiG/UT58PbPmdzVmmYpDvJwe5BICZ+1rMFbHBddvL8j1T6i+wWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZdgHDFsK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZdgHDFsK"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE46F40E019C;
	Tue, 30 Jul 2024 13:43:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vNfPju7FdLVL; Tue, 30 Jul 2024 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722347036; bh=xgg/DjPuw/MS1d8+SeLJnsNngEP4ksZOGNZkonl9XNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdgHDFsKk0ViYk5WB/k9sB2gzXb23Bu2yK+nbKmC09CY/ifLVVlFr5uO/jByAOQxD
	 Y/hpVrAmdn3/yF9OnVZgwWLVD1xJFLwm9wo+lhVi3PeXYZou+b2mp9A6eqikgkNgHT
	 /eikMbBVuHf2cSJRE9IFhO6/6YK+I6+5+j2C7CQ/JcjKPj7W18YOAqaFMH57pU2wCG
	 M4tEvs/T1HtMTHttzbsUSGnxR8q9PR850sc3dYmSZnLMTK18kS+16rz+Q57P3GKHSy
	 h8RsVxLPkIHX9Asy1sxYjmxCfk0nBpstxgvbRaclgQdwAnxY2DqyFamKoEj5vHi2+b
	 dMR6trauTlyCHEQL+aJYIOE/J9GFh9bXObvoptlk2tm42mkV+Cx1PSX8NpxF/+wKaJ
	 BBWrtdXIeAtYesor+PCwDeA23MgFPmW+EPh92Gja62MlMrObjn6Y8YVJkAAFhwT+pL
	 bPXmi3AC1bpGeN16wVMaoXEdaumCDQVNmIqJ01d2vHaaCoeFUGSP3VBPYCYx4lWHLj
	 DtnLbsrjBEOKPSwCHqcga4orfIr06Lj+jQ3oWAdOYtV59uNC4nXF7FAjzU/UmPRRwM
	 g4WhwbA/PmN4dm3ipcXH8M2i+90w5DndK5KNBYbTX6b3uE1u9yifRN0Fvm13DL9dmw
	 0gQuKVJu+EYZghuOdCj68qh4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BABA540E01B3;
	Tue, 30 Jul 2024 13:43:50 +0000 (UTC)
Date: Tue, 30 Jul 2024 15:43:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Narasimhan V <Narasimhan.V@amd.com>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: static_key_enable_cpuslocked(): static key
 'security_hook_active_locked_down_0+0x0/0x10' used before call to
 jump_label_init()
Message-ID: <20240730134344.GDZqjuEIsVTbIyRXAY@fat_crate.local>
References: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local>

On Tue, Jul 30, 2024 at 01:34:19PM +0200, Borislav Petkov wrote:
> Hi,
> 
> this is with today's linux-next:
> 
> ...
> 
> 09:44:13  [console-expect]#kexec -e
> 09:44:13  kexec -e
> 09:44:16  ^[[?2004l^M[    0.000000] Linux version 6.11.0-rc1-next-20240730-1722324631886 (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 SMP PREEMPT_DYNAMIC Tue Jul 30 07:40:55 UTC 2024
> 09:44:16  [    0.000000] ------------[ cut here ]------------
> 09:44:16  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/static_call_inline.c:153 __static_call_update+0x1c6/0x220
> 09:44:16  [    0.000000] Modules linked in:
> 09:44:16  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc1-next-20240730-1722324631886 #1
> 09:44:16  [    0.000000] RIP: 0010:__static_call_update+0x1c6/0x220
> 09:44:16  [    0.000000] Code: 87 5b eb d9 00 a8 01 0f 85 6c ff ff ff 4c 89 ee 48 c7 c7 e0 fb a2 8c c6 05 44 63 2b 02 01 e8 b1 00 d9 ff 0f 0b e9 4f ff ff ff <0f> 0b 48 c7 c7 40 fc 40 8d e8 dc 52 e1 00 e8 a7 23 d9 ff 48 8b 45
> 09:44:16  [    0.000000] RSP: 0000:ffffffff8d203dd0 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
> 09:44:16  [    0.000000] RAX: 0000000000000000 RBX: ffffffff8b7e3250 RCX: 000000006690cbe9
> 09:44:16  [    0.000000] RDX: 0000000000000000 RSI: ffffffff8dbae58c RDI: ffffffff8d2867a0
> 09:44:16  [    0.000000] RBP: ffffffff8d203e38 R08: 00000000ff6690cb R09: 2035353a30343a37
> 09:44:16  [    0.000000] R10: 3230322043545520 R11: 35353a30343a3730 R12: ffffffff8c17a180
> 09:44:16  [    0.000000] R13: ffffffff8c48db10 R14: ffffffff8d4c7030 R15: 0000000000000000
> 09:44:16  [    0.000000] FS:  0000000000000000(0000) GS:ffffffff8d69c000(0000) knlGS:0000000000000000
> 09:44:16  [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 09:44:16  [    0.000000] CR2: ff1100007047d000 CR3: 00000000745c2000 CR4: 00000000000010b0
> 09:44:16  [    0.000000] Call Trace:
> 09:44:16  [    0.000000]  <TASK>
> 09:44:16  [    0.000000]  ? show_regs+0x6d/0x80
> 09:44:16  [    0.000000]  ? __warn+0x91/0x140
> 09:44:16  [    0.000000]  ? __static_call_update+0x1c6/0x220
> 09:44:16  [    0.000000]  ? report_bug+0x193/0x1a0
> 09:44:16  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> 09:44:16  [    0.000000]  ? early_fixup_exception+0xa6/0xd0
> 09:44:16  [    0.000000]  ? do_early_exception+0x27/0x70
> 09:44:16  [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_11+0x8/0x8
> 09:44:17  [    0.000000]  ? early_idt_handler_common+0x2f/0x3a
> 09:44:17  [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_11+0x8/0x8
> 09:44:17  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> 09:44:17  [    0.000000]  ? __static_call_update+0x1c6/0x220
> 09:44:17  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> 09:44:17  [    0.000000]  ? vprintk_emit+0xb5/0x410
> 09:44:17  [    0.000000]  security_add_hooks+0xbd/0x150
> 09:44:17  [    0.000000]  lockdown_lsm_init+0x25/0x30
> 09:44:17  [    0.000000]  initialize_lsm+0x38/0x90
> 09:44:17  [    0.000000]  early_security_init+0x36/0x70
> 09:44:17  [    0.000000]  start_kernel+0x5f/0xb50
> 09:44:17  [    0.000000]  x86_64_start_reservations+0x1c/0x30
> 09:44:17  [    0.000000]  x86_64_start_kernel+0xbf/0x110
> 09:44:17  [    0.000000]  ? setup_ghcb+0x12/0x130
> 09:44:17  [    0.000000]  common_startup_64+0x13e/0x141
> 09:44:17  [    0.000000]  </TASK>
> 09:44:17  [    0.000000] ---[ end trace 0000000000000000 ]---
> 09:44:17  [    0.000000] ------------[ cut here ]------------
> 09:44:17  [    0.000000] static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x10' used before call to jump_label_init()

It says so directly here:


start_kernel:

	....

        early_security_init();		<----
        setup_arch(&command_line);
        setup_boot_config();
        setup_command_line(command_line);
        setup_nr_cpu_ids();
        setup_per_cpu_areas();
        smp_prepare_boot_cpu(); /* arch-specific boot-cpu hooks */
        early_numa_node_init();
        boot_cpu_hotplug_init();

        pr_notice("Kernel command line: %s\n", saved_command_line);
        /* parameters may set static keys */
        jump_label_init();		<---


That can't work this way.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
