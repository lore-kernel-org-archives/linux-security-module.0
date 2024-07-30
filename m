Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D39189902
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361225; cv=none; b=BJQTmdLpXoq/ZKkdsLRSanH0Lk/AARCs9kKgjEluxD4LDW+9OnZZKr72ik3LIaAV2WjvoNOLqYSPNEcpdbMUkclvu/zOO96IhQrdPHdYAG92oEqYe24rzGUpSNMeELxrDVJdTovx9DKnA7dSLS6e9xMQA+LXPR8RQ7ngnHl7mAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361225; c=relaxed/simple;
	bh=kfBmAxE6sYXkfs3UxGp78hCRPohAQNAU+9I0EupMnzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcLgmij9iHJB0J0ARYsbcqfe4wsg5St7hNbEJOM0EwvBQF9Aef4tEFcMEaButwE4ndG/2NXyTxXLTmcobYW0VmrrmRr3KZyp0btEaVzs9SSQDklfecJQ9xlNnWw9QRChaUI2uBeQYl0olrMsvGD8/1VquHLJ8Aq0efd0x6SJPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZze2T/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZze2T/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF41C4AF0E
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722361224;
	bh=kfBmAxE6sYXkfs3UxGp78hCRPohAQNAU+9I0EupMnzI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SZze2T/f2hduhHS8uerw87tHXukFbKgUT29ST/UhJRcoWpdoQzvJ42RYBwa/ohH1z
	 j7TdFxQoDx9dniXfep4AFzBTtpJNl/kZ1dFa8yQ6Ym1keDlD+ki7sd7/yBMO/gdNWk
	 Br472zKQm09tcUtJo9P/PNrTxMvuHmN0+wp/9JZodwr/06G71JmJjWPvXdTTqa5zz2
	 OMjlrerQC8O7y2G8h+aJv/+7iPfl2p27QyuZHDzKr5QymAbXVDDuELz4cbRwjgFIZC
	 xzKv/5HoHemYdVpBK11JZEaqM9hnKYKdY4h8RDxB4AMu1Zl2/uWNG63W6Qmab2CKuH
	 +nbplYboBd+SQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so76140411fa.0
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jul 2024 10:40:24 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw/bDz4IYdHF1r3BlhlrtnxZiw/88hnr39CLCGP3N6kfgf/uxep
	l8k9CRJSxWuVYHb6HHm8Piyehx+mB0XifIW470eUPWDCKw1+HQNKzsokMVCLZu3L8rbW8TmhfIu
	fTjOWnG2WEIHHsUG2pA/62/TnMXiufAbaqEa0
X-Google-Smtp-Source: AGHT+IHW9Qzz2jqs05G0QaVCouBTZ42SOehjjTrhWyaTw9imvyJ0ZBR+DZxmiFHA4PswFpx4tWoR4H1mETFkrjwT+cM=
X-Received: by 2002:a2e:800f:0:b0:2f0:27e4:3a43 with SMTP id
 38308e7fff4ca-2f12edfd2d2mr75226101fa.11.1722361222998; Tue, 30 Jul 2024
 10:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730113419.GBZqjPu6SdAt5qZKnh@fat_crate.local> <CAHC9VhRnq81v=DYC3SC=oD2onittYTQbZqp5uoeU2MWuCh0-SA@mail.gmail.com>
In-Reply-To: <CAHC9VhRnq81v=DYC3SC=oD2onittYTQbZqp5uoeU2MWuCh0-SA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 30 Jul 2024 19:40:11 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6TUki=14-gPBCQL3wcFGvZF2STTzDzZ_Hfd-G_2V5sEw@mail.gmail.com>
Message-ID: <CACYkzJ6TUki=14-gPBCQL3wcFGvZF2STTzDzZ_Hfd-G_2V5sEw@mail.gmail.com>
Subject: Re: static_key_enable_cpuslocked(): static key 'security_hook_active_locked_down_0+0x0/0x10'
 used before call to jump_label_init()
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	lkml <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Jul 30, 2024 at 7:34=E2=80=AFAM Borislav Petkov <bp@alien8.de> wr=
ote:
> >
> > Hi,
> >
> > this is with today's linux-next:
> >
> > ...
> >
> > 09:44:13  [console-expect]#kexec -e
> > 09:44:13  kexec -e
> > 09:44:16  ^[[?2004l^M[    0.000000] Linux version 6.11.0-rc1-next-20240=
730-1722324631886 (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU B=
inutils for Ubuntu) 2.38) #1 SMP PREEMPT_DYNAMIC Tue Jul 30 07:40:55 UTC 20=
24
> > 09:44:16  [    0.000000] ------------[ cut here ]------------
> > 09:44:16  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/static_call_i=
nline.c:153 __static_call_update+0x1c6/0x220
> > 09:44:16  [    0.000000] Modules linked in:
> > 09:44:16  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted=
 6.11.0-rc1-next-20240730-1722324631886 #1
> > 09:44:16  [    0.000000] RIP: 0010:__static_call_update+0x1c6/0x220
> > 09:44:16  [    0.000000] Code: 87 5b eb d9 00 a8 01 0f 85 6c ff ff ff 4=
c 89 ee 48 c7 c7 e0 fb a2 8c c6 05 44 63 2b 02 01 e8 b1 00 d9 ff 0f 0b e9 4=
f ff ff ff <0f> 0b 48 c7 c7 40 fc 40 8d e8 dc 52 e1 00 e8 a7 23 d9 ff 48 8b=
 45
> > 09:44:16  [    0.000000] RSP: 0000:ffffffff8d203dd0 EFLAGS: 00010046 OR=
IG_RAX: 0000000000000000
> > 09:44:16  [    0.000000] RAX: 0000000000000000 RBX: ffffffff8b7e3250 RC=
X: 000000006690cbe9
> > 09:44:16  [    0.000000] RDX: 0000000000000000 RSI: ffffffff8dbae58c RD=
I: ffffffff8d2867a0
> > 09:44:16  [    0.000000] RBP: ffffffff8d203e38 R08: 00000000ff6690cb R0=
9: 2035353a30343a37
> > 09:44:16  [    0.000000] R10: 3230322043545520 R11: 35353a30343a3730 R1=
2: ffffffff8c17a180
> > 09:44:16  [    0.000000] R13: ffffffff8c48db10 R14: ffffffff8d4c7030 R1=
5: 0000000000000000
> > 09:44:16  [    0.000000] FS:  0000000000000000(0000) GS:ffffffff8d69c00=
0(0000) knlGS:0000000000000000
> > 09:44:16  [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> > 09:44:16  [    0.000000] CR2: ff1100007047d000 CR3: 00000000745c2000 CR=
4: 00000000000010b0
> > 09:44:16  [    0.000000] Call Trace:
> > 09:44:16  [    0.000000]  <TASK>
> > 09:44:16  [    0.000000]  ? show_regs+0x6d/0x80
> > 09:44:16  [    0.000000]  ? __warn+0x91/0x140
> > 09:44:16  [    0.000000]  ? __static_call_update+0x1c6/0x220
> > 09:44:16  [    0.000000]  ? report_bug+0x193/0x1a0
> > 09:44:16  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> > 09:44:16  [    0.000000]  ? early_fixup_exception+0xa6/0xd0
> > 09:44:16  [    0.000000]  ? do_early_exception+0x27/0x70
> > 09:44:16  [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_11=
+0x8/0x8
> > 09:44:17  [    0.000000]  ? early_idt_handler_common+0x2f/0x3a
> > 09:44:17  [    0.000000]  ? __SCT__lsm_static_call_bpf_token_capable_11=
+0x8/0x8
> > 09:44:17  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> > 09:44:17  [    0.000000]  ? __static_call_update+0x1c6/0x220
> > 09:44:17  [    0.000000]  ? __pfx_lockdown_is_locked_down+0x10/0x10
> > 09:44:17  [    0.000000]  ? vprintk_emit+0xb5/0x410
> > 09:44:17  [    0.000000]  security_add_hooks+0xbd/0x150
> > 09:44:17  [    0.000000]  lockdown_lsm_init+0x25/0x30
> > 09:44:17  [    0.000000]  initialize_lsm+0x38/0x90
> > 09:44:17  [    0.000000]  early_security_init+0x36/0x70
> > 09:44:17  [    0.000000]  start_kernel+0x5f/0xb50
> > 09:44:17  [    0.000000]  x86_64_start_reservations+0x1c/0x30
> > 09:44:17  [    0.000000]  x86_64_start_kernel+0xbf/0x110
> > 09:44:17  [    0.000000]  ? setup_ghcb+0x12/0x130
> > 09:44:17  [    0.000000]  common_startup_64+0x13e/0x141
> > 09:44:17  [    0.000000]  </TASK>
> > 09:44:17  [    0.000000] ---[ end trace 0000000000000000 ]---
> > 09:44:17  [    0.000000] ------------[ cut here ]------------
> > 09:44:17  [    0.000000] static_key_enable_cpuslocked(): static key 'se=
curity_hook_active_locked_down_0+0x0/0x10' used before call to jump_label_i=
nit()
> > 09:44:17  [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:=
199 static_key_enable_cpuslocked+0x99/0xb0
> > 09:44:17  [    0.000000] Modules linked in:
> > 09:44:17  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G =
       W          6.11.0-rc1-next-20240730-1722324631886 #1
> > 09:44:17  [    0.000000] Tainted: [W]=3DWARN
> > 09:44:17  [    0.000000] RIP: 0010:static_key_enable_cpuslocked+0x99/0x=
b0
> > 09:44:17  [    0.000000] Code: ff ff ff ff 48 89 df e8 45 fd ff ff c7 0=
3 01 00 00 00 eb d5 48 89 da 48 c7 c6 e0 0a 44 8c 48 c7 c7 b8 00 a3 8c e8 8=
7 f6 d6 ff <0f> 0b eb 8e 0f 0b eb 9c 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f=
 40
> > 09:44:17  [    0.000000] RSP: 0000:ffffffff8d203e10 EFLAGS: 00010086 OR=
IG_RAX: 0000000000000000
> > 09:44:17  [    0.000000] RAX: 0000000000000000 RBX: ffffffff8dd6aaf0 RC=
X: 0000000000000084
> > 09:44:17  [    0.000000] RDX: ffffffff8d349400 RSI: 00000000ffffe02c RD=
I: ffffffff8d203cb0
> > 09:44:17  [    0.000000] RBP: ffffffff8d203e20 R08: 000000000000007e R0=
9: 6562616c5f706d75
> > 09:44:17  [    0.000000] R10: 6a206f74206c6c61 R11: 632065726f666562 R1=
2: 0000000000000000
> > 09:44:17  [    0.000000] R13: ffffffff8c48db10 R14: ffffffff8cb0e2f8 R1=
5: 0000000000000000
> > 09:44:17  [    0.000000] FS:  0000000000000000(0000) GS:ffffffff8d69c00=
0(0000) knlGS:0000000000000000
> > 09:44:17  [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> > 09:44:17  [    0.000000] CR2: ff1100007047d000 CR3: 00000000745c2000 CR=
4: 00000000000010b0
> > 09:44:17  [    0.000000] Call Trace:
> > 09:44:17  [    0.000000]  <TASK>
> > 09:44:17  [    0.000000]  ? show_regs+0x6d/0x80
> > 09:44:17  [    0.000000]  ? __warn+0x91/0x140
> > 09:44:17  [    0.000000]  ? static_key_enable_cpuslocked+0x99/0xb0
> > 09:44:17  [    0.000000]  ? report_bug+0x193/0x1a0
> > 09:44:17  [    0.000000]  ? fixup_exception+0x2b/0x340
> > 09:44:17  [    0.000000]  ? early_fixup_exception+0xa6/0xd0
> > 09:44:17  [    0.000000]  ? do_early_exception+0x27/0x70
> > 09:44:17  [    0.000000]  ? early_idt_handler_common+0x2f/0x3a
> > 09:44:17  [    0.000000]  ? static_key_enable_cpuslocked+0x99/0xb0
> > 09:44:17  [    0.000000]  static_key_enable+0x1f/0x30
> > 09:44:17  [    0.000000]  security_add_hooks+0xce/0x150
> > 09:44:17  [    0.000000]  lockdown_lsm_init+0x25/0x30
> > 09:44:17  [    0.000000]  initialize_lsm+0x38/0x90
> > 09:44:17  [    0.000000]  early_security_init+0x36/0x70
> > 09:44:17  [    0.000000]  start_kernel+0x5f/0xb50
> > 09:44:17  [    0.000000]  x86_64_start_reservations+0x1c/0x30
> > 09:44:17  [    0.000000]  x86_64_start_kernel+0xbf/0x110
> > 09:44:17  [    0.000000]  ? setup_ghcb+0x12/0x130
> > 09:44:17  [    0.000000]  common_startup_64+0x13e/0x141
> > 09:44:17  [    0.000000]  </TASK>
> > 09:44:17  [    0.000000] ---[ end trace 0000000000000000 ]---
>
> KP, please take a look at this as soon as you can (lore link below for
> those who aren't on the list).  One obvious first thing to look at is
> simply moving the call to early_security_init(), but that requires
> some code audit to make sure it is safe and doesn't break something
> else.  Of course, if we can do something with how we setup/use static
> calls that is even better.  I'll take a look at it myself later today,
> but I'm busy with meetings for the next several hours.
>
> If we can't resolve this in the next day or two I'm going to

Thanks for the ping.

Taking a look, yeah it's possible that we need to move jump_label_init
before early_security_init / inside it.

I will do a repro and test my change and reply back.

- KP

> bounce/revert the LSM static-call patchset from lsm/dev; not ideal,
> but we can't break linux-next.
>
> https://lore.kernel.org/linux-security-module/20240730113419.GBZqjPu6SdAt=
5qZKnh@fat_crate.local/
>
> --
> paul-moore.com
