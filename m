Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA641A2C22
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351781; cv=none; b=Dw8XgoYkxb+/4FJMyDYq+FzC3PS/3oHZQD+PFOHIJWpdAy9msuQ23CxiPNR8zhgPaox6oh44skgE9e4aafrq28FQVkNNn60Q+oLBtUUFuFLrRvBSJVn9iLUceJ6jCa7TZR1pIDrXPyMORiAVjkx9N8u4y4lLveofmO9vFNWILak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351781; c=relaxed/simple;
	bh=Kvz0S0BHRbDFlJwZNURDVUw3Q1B42X8VFglsFK5Av6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkbTN1gjqrSl06ILIEUItFxRXSIdD7dYtrLimcVY7VRebfNFOxTMa6WQ8kvhT8lIuAmL3wk1Zs+9RpVJzZ5LxktxpAUQQ2kCk1aX7uzpmRh6ZaWCKeigwD9MK26otxhZRVv/KYV4JBPpcKsOO35S0Qdpv0u1bk3YnW8WNU77KR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aD8AeLlT; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aD8AeLlT"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260209df55dso2834908fac.2
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722351779; x=1722956579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyNVBjzp4HYk0fUKTChnbLf6J/cRv5yWOrsUWw7gJw8=;
        b=aD8AeLlTmggZlHAd6j6WVb8111fLsbUrNruYN97h8vIjub0hXo5vOyVJ4oj89eP3hl
         /6friFqI9nvw67oacQicXD6q9GUpmmrYKqf5xgdIvHOgQCzwYLfF3Jc1Ciua58Huv40s
         W5xS62P2j6QXeekfjokRU57dlmXyGmLewY6zEzHDgT8JH5nCogsEc1G2RbAtVPXmfuwG
         VFQJuMKUxpFprOnk2/ChvLVE8dsH9oaHtmtAuoBmqqCdYSllPenlguRLEq0irZOfFXdI
         q1fJqAuTJg+UmtOU1dHIwCIraD8yFBV2iWA75pwgzfGRG2EnPzJTToPzxHtR4FwBr1UV
         uVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351779; x=1722956579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyNVBjzp4HYk0fUKTChnbLf6J/cRv5yWOrsUWw7gJw8=;
        b=BNbslFzKug/+AEzvA6RW6Pz+Gw3Y0Tk69GXD46jGD4T1XFOVRQJxH1yy2fyZuS8LCH
         S3b6i+DxIpf1CSw5BBisK7WJ7NeeQmSbC8tCksuWTNd+ER7Vz7ofeXXYMjfKqo2P3KUt
         OoLb7DdEj4wX87u348x176Y/Z5uoFbHPfrZSeorG0boeLYcPnlK0qf3+tPWZiV9SXfh2
         zNBmYsRQkkjMDPCXNSmuUy336RWm6VwB0sdSx13+e99u50N08MS4GdNjZv7GyMTbdsZA
         54nYrFp7eVFwR9RbwMPivosRr5DtsWIZmnNRvTxujYgA2kazoeIT622ljgt5fxvx1lbk
         /vHg==
X-Gm-Message-State: AOJu0YzBIB3Mg9anbs2gvu7r1pM03dbMYr1IWgVeFlISzwPie/091f+d
	Vpr1PNINOPWEEmurV5yI57NU4EFctdF0CjjZ9b1vl3ZnoNuXrKxKkUuJ2ft9Rn93+lP01D9xomI
	DWZNgsC18c/udjRaO8odpd/SY0PixC37uVZS7
X-Google-Smtp-Source: AGHT+IFM+Qonezywd9cZNFTgsAh8oTmU2zQYIWUj4VkECnKvST3KaJBs9JCnjHNY1IevRXhaBRSL4I9ZlYa0K4ZfamI=
X-Received: by 2002:a05:6870:e391:b0:260:f50e:9242 with SMTP id
 586e51a60fabf-267d4f5806amr15601441fac.41.1722351778614; Tue, 30 Jul 2024
 08:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local>
In-Reply-To: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jul 2024 11:02:47 -0400
Message-ID: <CAHC9VhRnq81v=DYC3SC=oD2onittYTQbZqp5uoeU2MWuCh0-SA@mail.gmail.com>
Subject: Re: static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x10'
 used before call to jump_label_init()
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	lkml <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:34=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> Hi,
>
> this is with today's linux-next:
>
> ...
>
> 09:44:13  [console-expect]#kexec -e
> 09:44:13  kexec -e
> 09:44:16  ^[[?2004l^M[    0.000000] Linux version 6.11.0-rc1-next-2024073=
0-1722324631886 (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Bin=
utils for Ubuntu) 2.38) #1 SMP PREEMPT_DYNAMIC Tue Jul 30 07:40:55 UTC 2024
> 09:44:16  [    0.000000] ------------[ cut here ]------------
> 09:44:16  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/static_call_inl=
ine.c:153 __static_call_update+0x1c6/0x220
> 09:44:16  [    0.000000] Modules linked in:
> 09:44:16  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6=
.11.0-rc1-next-20240730-1722324631886 #1
> 09:44:16  [    0.000000] RIP: 0010:__static_call_update+0x1c6/0x220
> 09:44:16  [    0.000000] Code: 87 5b eb d9 00 a8 01 0f 85 6c ff ff ff 4c =
89 ee 48 c7 c7 e0 fb a2 8c c6 05 44 63 2b 02 01 e8 b1 00 d9 ff 0f 0b e9 4f =
ff ff ff <0f> 0b 48 c7 c7 40 fc 40 8d e8 dc 52 e1 00 e8 a7 23 d9 ff 48 8b 4=
5
> 09:44:16  [    0.000000] RSP: 0000:ffffffff8d203dd0 EFLAGS: 00010046 ORIG=
_RAX: 0000000000000000
> 09:44:16  [    0.000000] RAX: 0000000000000000 RBX: ffffffff8b7e3250 RCX:=
 000000006690cbe9
> 09:44:16  [    0.000000] RDX: 0000000000000000 RSI: ffffffff8dbae58c RDI:=
 ffffffff8d2867a0
> 09:44:16  [    0.000000] RBP: ffffffff8d203e38 R08: 00000000ff6690cb R09:=
 2035353a30343a37
> 09:44:16  [    0.000000] R10: 3230322043545520 R11: 35353a30343a3730 R12:=
 ffffffff8c17a180
> 09:44:16  [    0.000000] R13: ffffffff8c48db10 R14: ffffffff8d4c7030 R15:=
 0000000000000000
> 09:44:16  [    0.000000] FS:  0000000000000000(0000) GS:ffffffff8d69c000(=
0000) knlGS:0000000000000000
> 09:44:16  [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> 09:44:16  [    0.000000] CR2: ff1100007047d000 CR3: 00000000745c2000 CR4:=
 00000000000010b0
> 09:44:16  [    0.000000] Call Trace:
> 09:44:16  [    0.000000]  <TASK>
> 09:44:16  [    0.000000]  ? show_regs+0x6d/0x80
> 09:44:16  [    0.000000]  ? __warn+0x91/0x140
> 09:44:16  [    0.000000]  ? __static_call_update+0x1c6/0x220
> 09:44:16  [    0.000000]  ? report_bug+0x193/0x1a0
> 09:44:16  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> 09:44:16  [    0.000000]  ? early_fixup_exception+0xa6/0xd0
> 09:44:16  [    0.000000]  ? do_early_exception+0x27/0x70
> 09:44:16  [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_11+0=
x8/0x8
> 09:44:17  [    0.000000]  ? early_idt_handler_common+0x2f/0x3a
> 09:44:17  [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_11+0=
x8/0x8
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
> 09:44:17  [    0.000000] static_key_enable_cpuslocked(): static key 'secu=
rity_hook_active_locked_down_0+0x0/0x10' used before call to jump_label_ini=
t()
> 09:44:17  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:19=
9 static_key_enable_cpuslocked+0x99/0xb0
> 09:44:17  [    0.000000] Modules linked in:
> 09:44:17  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G   =
     W          6.11.0-rc1-next-20240730-1722324631886 #1
> 09:44:17  [    0.000000] Tainted: [W]=3DWARN
> 09:44:17  [    0.000000] RIP: 0010:static_key_enable_cpuslocked+0x99/0xb0
> 09:44:17  [    0.000000] Code: ff ff ff ff 48 89 df e8 45 fd ff ff c7 03 =
01 00 00 00 eb d5 48 89 da 48 c7 c6 e0 0a 44 8c 48 c7 c7 b8 00 a3 8c e8 87 =
f6 d6 ff <0f> 0b eb 8e 0f 0b eb 9c 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 4=
0
> 09:44:17  [    0.000000] RSP: 0000:ffffffff8d203e10 EFLAGS: 00010086 ORIG=
_RAX: 0000000000000000
> 09:44:17  [    0.000000] RAX: 0000000000000000 RBX: ffffffff8dd6aaf0 RCX:=
 0000000000000084
> 09:44:17  [    0.000000] RDX: ffffffff8d349400 RSI: 00000000ffffe02c RDI:=
 ffffffff8d203cb0
> 09:44:17  [    0.000000] RBP: ffffffff8d203e20 R08: 000000000000007e R09:=
 6562616c5f706d75
> 09:44:17  [    0.000000] R10: 6a206f74206c6c61 R11: 632065726f666562 R12:=
 0000000000000000
> 09:44:17  [    0.000000] R13: ffffffff8c48db10 R14: ffffffff8cb0e2f8 R15:=
 0000000000000000
> 09:44:17  [    0.000000] FS:  0000000000000000(0000) GS:ffffffff8d69c000(=
0000) knlGS:0000000000000000
> 09:44:17  [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> 09:44:17  [    0.000000] CR2: ff1100007047d000 CR3: 00000000745c2000 CR4:=
 00000000000010b0
> 09:44:17  [    0.000000] Call Trace:
> 09:44:17  [    0.000000]  <TASK>
> 09:44:17  [    0.000000]  ? show_regs+0x6d/0x80
> 09:44:17  [    0.000000]  ? __warn+0x91/0x140
> 09:44:17  [    0.000000]  ? static_key_enable_cpuslocked+0x99/0xb0
> 09:44:17  [    0.000000]  ? report_bug+0x193/0x1a0
> 09:44:17  [    0.000000]  ? fixup_exception+0x2b/0x340
> 09:44:17  [    0.000000]  ? early_fixup_exception+0xa6/0xd0
> 09:44:17  [    0.000000]  ? do_early_exception+0x27/0x70
> 09:44:17  [    0.000000]  ? early_idt_handler_common+0x2f/0x3a
> 09:44:17  [    0.000000]  ? static_key_enable_cpuslocked+0x99/0xb0
> 09:44:17  [    0.000000]  static_key_enable+0x1f/0x30
> 09:44:17  [    0.000000]  security_add_hooks+0xce/0x150
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

KP, please take a look at this as soon as you can (lore link below for
those who aren't on the list).  One obvious first thing to look at is
simply moving the call to early_security_init(), but that requires
some code audit to make sure it is safe and doesn't break something
else.  Of course, if we can do something with how we setup/use static
calls that is even better.  I'll take a look at it myself later today,
but I'm busy with meetings for the next several hours.

If we can't resolve this in the next day or two I'm going to
bounce/revert the LSM static-call patchset from lsm/dev; not ideal,
but we can't break linux-next.

https://lore.kernel.org/linux-security-module/20240730113419.GBZqjPu6SdAt5q=
ZKnh@fat_crate.local/

--=20
paul-moore.com
