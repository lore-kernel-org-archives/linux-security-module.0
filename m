Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700A187340;
	Tue, 30 Jul 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339281; cv=none; b=bsQrv+Zm6J15s7v4kHdypA/4v7GR4hEz7OCyRChGs8PMOJ228cK2jTxkZlrhwSqpPlZ8EBYYugFTzS/xKiOyLKMaZIZvtdSCbbqJwq06qpExM/ovMsr2eu6i1uKzZLZmZwW4FBC5mDLgAnHB1s9XAFkc5WetGoQlQ0c3fPRt8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339281; c=relaxed/simple;
	bh=a/K2SrYzy1yPes3unN4a5mZP9ihrCOdoEUZtu/mNdFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CA8Xowfu1BxmaeiHf2JDZWUx0Gc/aA/AW2G4X2tuS+wu/+lM5ucE+lhR3FeiycEIMRZFCdKgZNgtEmyM1OpX8FpxXDqKcYVI12FYuQm0uZ0d+PnafUjYe7UYFVpXSV3RTZ5mAkzUgmPK522WNpFbggE750UJROmlogXwdr94t08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GnPrJSJ6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GnPrJSJ6"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5102440E01B3;
	Tue, 30 Jul 2024 11:34:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Bh0dKN8dxo4u; Tue, 30 Jul 2024 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722339273; bh=2wFHuj+T12sSvdrDW5QZArPdPdVCyXj7fZ4YEuwTacM=;
	h=Date:From:To:Cc:Subject:From;
	b=GnPrJSJ6glIReM6vuNyXPrwDBzMd43awGG0IUlNr2cnF13KxfDaKAgM8GeTKFrdBm
	 fuGdqfah/WbmsvDiSDg3hrS1BmYNJYr8Cq/de8NwdwErUqUiTbBvlc2cQnE+ezwtQs
	 lhOSfPEqyIUWJBR4W2zimxw4I3Hr9G7c+ILrePZO/yVBQ2gnW2ekUM7he184mmEj+w
	 xZs9gpD+Loe1wAf4d7Dtqqe2rJ1usS8i9quw4P5MuBRywH0g9QAgVLBVEgwMaPwOm4
	 uxT/afFvCMsNpFudZdrTfey3UADjMp3m5IEjK3XqE7OZ2uv5SADXMTaGp2tU/sgVF0
	 5ga0COmhJEZzZSo6kJCPLXcXQx9QFvJjy31ewkAaNkpOUo4WSFGQeqFoIagOiU0NBX
	 XUTSXBgPVWKBgYQbQgeIjN1EYAdbliBp4hmz4eNp6CQNFpjDwGV4ErhR6e7znv1x3Z
	 FgW6YTbm8LyKtZZn3MgKkurTPKboH94Ikd6DxSmvWbKRW4IjV7YkYRf9Kqy1sQG6xX
	 3gRLKhemx7nUa7/SMCjoOFHd4kQIFsqurtOIQKvznI2NYkpUMdYQJcodCyOtLRTWwV
	 6P9hE1jPXx6+iQ3Tb/JaVk5a3wHSaZ81NfRDwUyJKg5Em8p+Du4rSdTh8afXETpXlt
	 FtMlq7BdnpiUzTvDbrpuIPo4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D95D640E01A8;
	Tue, 30 Jul 2024 11:34:26 +0000 (UTC)
Date: Tue, 30 Jul 2024 13:34:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Narasimhan V <Narasimhan.V@amd.com>,
	lkml <linux-kernel@vger.kernel.org>
Subject: static_key_enable_cpuslocked(): static key
 'security_hook_active_locked_down_0+0x0/0x10' used before call to
 jump_label_init()
Message-ID: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

this is with today's linux-next:

...

09:44:13  [console-expect]#kexec -e
09:44:13  kexec -e
09:44:16  ^[[?2004l^M[    0.000000] Linux version 6.11.0-rc1-next-20240730-1722324631886 (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1 SMP PREEMPT_DYNAMIC Tue Jul 30 07:40:55 UTC 2024
09:44:16  [    0.000000] ------------[ cut here ]------------
09:44:16  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/static_call_inline.c:153 __static_call_update+0x1c6/0x220
09:44:16  [    0.000000] Modules linked in:
09:44:16  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc1-next-20240730-1722324631886 #1
09:44:16  [    0.000000] RIP: 0010:__static_call_update+0x1c6/0x220
09:44:16  [    0.000000] Code: 87 5b eb d9 00 a8 01 0f 85 6c ff ff ff 4c 89 ee 48 c7 c7 e0 fb a2 8c c6 05 44 63 2b 02 01 e8 b1 00 d9 ff 0f 0b e9 4f ff ff ff <0f> 0b 48 c7 c7 40 fc 40 8d e8 dc 52 e1 00 e8 a7 23 d9 ff 48 8b 45
09:44:16  [    0.000000] RSP: 0000:ffffffff8d203dd0 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
09:44:16  [    0.000000] RAX: 0000000000000000 RBX: ffffffff8b7e3250 RCX: 000000006690cbe9
09:44:16  [    0.000000] RDX: 0000000000000000 RSI: ffffffff8dbae58c RDI: ffffffff8d2867a0
09:44:16  [    0.000000] RBP: ffffffff8d203e38 R08: 00000000ff6690cb R09: 2035353a30343a37
09:44:16  [    0.000000] R10: 3230322043545520 R11: 35353a30343a3730 R12: ffffffff8c17a180
09:44:16  [    0.000000] R13: ffffffff8c48db10 R14: ffffffff8d4c7030 R15: 0000000000000000
09:44:16  [    0.000000] FS:  0000000000000000(0000) GS:ffffffff8d69c000(0000) knlGS:0000000000000000
09:44:16  [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
09:44:16  [    0.000000] CR2: ff1100007047d000 CR3: 00000000745c2000 CR4: 00000000000010b0
09:44:16  [    0.000000] Call Trace:
09:44:16  [    0.000000]  <TASK>
09:44:16  [    0.000000]  ? show_regs+0x6d/0x80
09:44:16  [    0.000000]  ? __warn+0x91/0x140
09:44:16  [    0.000000]  ? __static_call_update+0x1c6/0x220
09:44:16  [    0.000000]  ? report_bug+0x193/0x1a0
09:44:16  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
09:44:16  [    0.000000]  ? early_fixup_exception+0xa6/0xd0
09:44:16  [    0.000000]  ? do_early_exception+0x27/0x70
09:44:16  [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_11+0x8/0x8
09:44:17  [    0.000000]  ? early_idt_handler_common+0x2f/0x3a
09:44:17  [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_11+0x8/0x8
09:44:17  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
09:44:17  [    0.000000]  ? __static_call_update+0x1c6/0x220
09:44:17  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
09:44:17  [    0.000000]  ? vprintk_emit+0xb5/0x410
09:44:17  [    0.000000]  security_add_hooks+0xbd/0x150
09:44:17  [    0.000000]  lockdown_lsm_init+0x25/0x30
09:44:17  [    0.000000]  initialize_lsm+0x38/0x90
09:44:17  [    0.000000]  early_security_init+0x36/0x70
09:44:17  [    0.000000]  start_kernel+0x5f/0xb50
09:44:17  [    0.000000]  x86_64_start_reservations+0x1c/0x30
09:44:17  [    0.000000]  x86_64_start_kernel+0xbf/0x110
09:44:17  [    0.000000]  ? setup_ghcb+0x12/0x130
09:44:17  [    0.000000]  common_startup_64+0x13e/0x141
09:44:17  [    0.000000]  </TASK>
09:44:17  [    0.000000] ---[ end trace 0000000000000000 ]---
09:44:17  [    0.000000] ------------[ cut here ]------------
09:44:17  [    0.000000] static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x10' used before call to jump_label_init()
09:44:17  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:199 static_key_enable_cpuslocked+0x99/0xb0
09:44:17  [    0.000000] Modules linked in:
09:44:17  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G        W          6.11.0-rc1-next-20240730-1722324631886 #1
09:44:17  [    0.000000] Tainted: [W]=WARN
09:44:17  [    0.000000] RIP: 0010:static_key_enable_cpuslocked+0x99/0xb0
09:44:17  [    0.000000] Code: ff ff ff ff 48 89 df e8 45 fd ff ff c7 03 01 00 00 00 eb d5 48 89 da 48 c7 c6 e0 0a 44 8c 48 c7 c7 b8 00 a3 8c e8 87 f6 d6 ff <0f> 0b eb 8e 0f 0b eb 9c 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
09:44:17  [    0.000000] RSP: 0000:ffffffff8d203e10 EFLAGS: 00010086 ORIG_RAX: 0000000000000000
09:44:17  [    0.000000] RAX: 0000000000000000 RBX: ffffffff8dd6aaf0 RCX: 0000000000000084
09:44:17  [    0.000000] RDX: ffffffff8d349400 RSI: 00000000ffffe02c RDI: ffffffff8d203cb0
09:44:17  [    0.000000] RBP: ffffffff8d203e20 R08: 000000000000007e R09: 6562616c5f706d75
09:44:17  [    0.000000] R10: 6a206f74206c6c61 R11: 632065726f666562 R12: 0000000000000000
09:44:17  [    0.000000] R13: ffffffff8c48db10 R14: ffffffff8cb0e2f8 R15: 0000000000000000
09:44:17  [    0.000000] FS:  0000000000000000(0000) GS:ffffffff8d69c000(0000) knlGS:0000000000000000
09:44:17  [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
09:44:17  [    0.000000] CR2: ff1100007047d000 CR3: 00000000745c2000 CR4: 00000000000010b0
09:44:17  [    0.000000] Call Trace:
09:44:17  [    0.000000]  <TASK>
09:44:17  [    0.000000]  ? show_regs+0x6d/0x80
09:44:17  [    0.000000]  ? __warn+0x91/0x140
09:44:17  [    0.000000]  ? static_key_enable_cpuslocked+0x99/0xb0
09:44:17  [    0.000000]  ? report_bug+0x193/0x1a0
09:44:17  [    0.000000]  ? fixup_exception+0x2b/0x340
09:44:17  [    0.000000]  ? early_fixup_exception+0xa6/0xd0
09:44:17  [    0.000000]  ? do_early_exception+0x27/0x70
09:44:17  [    0.000000]  ? early_idt_handler_common+0x2f/0x3a
09:44:17  [    0.000000]  ? static_key_enable_cpuslocked+0x99/0xb0
09:44:17  [    0.000000]  static_key_enable+0x1f/0x30
09:44:17  [    0.000000]  security_add_hooks+0xce/0x150
09:44:17  [    0.000000]  lockdown_lsm_init+0x25/0x30
09:44:17  [    0.000000]  initialize_lsm+0x38/0x90
09:44:17  [    0.000000]  early_security_init+0x36/0x70
09:44:17  [    0.000000]  start_kernel+0x5f/0xb50
09:44:17  [    0.000000]  x86_64_start_reservations+0x1c/0x30
09:44:17  [    0.000000]  x86_64_start_kernel+0xbf/0x110
09:44:17  [    0.000000]  ? setup_ghcb+0x12/0x130
09:44:17  [    0.000000]  common_startup_64+0x13e/0x141
09:44:17  [    0.000000]  </TASK>
09:44:17  [    0.000000] ---[ end trace 0000000000000000 ]---
...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
