Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4FC25BAB6
	for <linux-security-module@vger.kernel.org>; Wed,  5 Mar 2025 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211248; cv=none; b=bu4+i8jOR6MLD3EvXcDvRX8yns+g4Ko+WLZAabSKzrIQ5LFy7+9Dl0Z1QoLnffUxnnzvbTSh5k/xid7cWJG5jw85Bk15eFvqPcF8wM4lUxV/2U3qF63FVJE9/1fXQxTctapo7Anb9PlfiRkZn+bntAZay7DGj/CkJ6y2b+IYVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211248; c=relaxed/simple;
	bh=+Pckg+O4htSf3P/VZ9cVurdSKyUgse3OWOVFQPu8WQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6/Tswh/leKJVBbzi8HIZ36zRmGkSp+S0IYPs0VruD2PzZmmAGg7GsKLFFxFIFoAitlFIy2ZGKA+ImAFNBmX1E6emksO88XY6AVXPi42mZJIoDIv7H+G7Rqlc3Nuo2Isewp0qm5vgbl03LHYz0naHVHXyZwt2gpUFLOT8y2bCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=Rw3iokJE; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=ebX4EDsO; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=U6oG1pSj; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=ZJkCLmrM; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="Rw3iokJE";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="ebX4EDsO";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="U6oG1pSj";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="ZJkCLmrM"
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:ac25:bb2b:5052:fd88])
	by mail.tnxip.de (Postfix) with ESMTPS id 8C2CA208AD;
	Wed,  5 Mar 2025 22:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1741211236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Pckg+O4htSf3P/VZ9cVurdSKyUgse3OWOVFQPu8WQ4=;
	b=Rw3iokJEi/zJMhmrWKKh7wfVU23pu9OWNTTP6gTJYhFHTh3s9cGrELIhbmjH1993lrzSy/
	mt/sXbVOr4tVtLLOERHCmpLsczNJng9MI5iuGpgyzp9XfVSBQD0jLqM2I7KphYmkubH8ga
	AiGiBeLyA+9nqTOa0jdklgwiSGmpIyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1741211237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Pckg+O4htSf3P/VZ9cVurdSKyUgse3OWOVFQPu8WQ4=;
	b=ebX4EDsORetcatL72tN/9ftAqu9tBXdn2GQ6o72ZmQFmenVEte1DZd+1zgeefeAmOaBYw6
	qcdWs85PfXvIJYAQ==
Received: from [IPV6:2a04:4540:8c01:b800:5e07:ab1e:bea6:9161] (unknown [IPv6:2a04:4540:8c01:b800:5e07:ab1e:bea6:9161])
	by gw.tnxip.de (Postfix) with ESMTPSA id A9EC768000000003ADCAC;
	Wed, 05 Mar 2025 22:47:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1741211235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Pckg+O4htSf3P/VZ9cVurdSKyUgse3OWOVFQPu8WQ4=;
	b=U6oG1pSjYb2dtXStckCzC2ykHjNAFioceGIUZz4g1jAoE/DbpVbHp0yjRneY+WOyq+r/fb
	Shl3yIAOecG3XmzKr3ga1rzc+gnOMN2q5+5R68Zh9vhJ6h/I5DvzIfWwDcZDN5IoARDND9
	cmodyvOYIos+w4th4TMeKrK5tpp3pO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1741211235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Pckg+O4htSf3P/VZ9cVurdSKyUgse3OWOVFQPu8WQ4=;
	b=ZJkCLmrMDnBcoZEv34j+6tU6mIqjQxvQpvGtu+QFdQOkcej+VaLU0532geUHM09EOXl4Xd
	QebZywQNISQHvnCw==
Message-ID: <465d1d23-3b36-490e-b0dd-74889d17fa4c@tnxip.de>
Date: Wed, 5 Mar 2025 22:47:09 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: apparmor NULL pointer dereference on resume
To: Ryan Lee <ryan.lee@canonical.com>
Cc: linux-security-module@vger.kernel.org,
 apparmor <apparmor@lists.ubuntu.com>
References: <e54e6a2f-1178-4980-b771-4d9bafc2aa47@tnxip.de>
 <CAKCV-6s3_7RzDfo_yGQj9ndf4ZKw_Awf8oNc6pYKXgDTxiDfjw@mail.gmail.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <CAKCV-6s3_7RzDfo_yGQj9ndf4ZKw_Awf8oNc6pYKXgDTxiDfjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2025 20:22, Ryan Lee wrote:
> On Wed, Mar 5, 2025 at 11:11 AM Malte Schröder <malte.schroeder@tnxip.de> wrote:
>> Hi,
>>
>> I hope this is the right place to report this. Since 6.14-rc1 ff. resume
>> from hibernate does not work anymore. Now I finally managed to get dmesg
>> from when this happens (Console is frozen, but managed to login via
>> network). If I read that trace correctly there seems to be some
>> interaction with apparmor. I retried with apparmor disabled and the
>> issue didn't trigger.
> Also CC'ing the AppArmor-specific mailing list in this reply.
>
>> I am happy to provide more data if required.
> Could you try to reproduce this NULL pointer dereference with a clean
> kernel with debug info (that I'd be able to access the source code of)
> and send a symbolized stacktrace processed with
> scripts/decode_stacktrace.sh?

Sure. Result using plain v6.14-rc5:

[  142.014428] BUG: kernel NULL pointer dereference, address:
0000000000000018
[  142.014429] #PF: supervisor read access in kernel mode
[  142.014431] #PF: error_code(0x0000) - not-present page
[  142.014432] PGD 0 P4D 0
[  142.014433] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  142.014436] CPU: 4 UID: 0 PID: 6833 Comm: systemd-sleep Not tainted
6.14.0-rc5 #1
[  142.014437] Hardware name: To Be Filled By O.E.M. X570 Extreme4/X570
Extreme4, BIOS P5.60 01/18/2024
[  142.014439] RIP: 0010:apparmor_file_open (./include/linux/mount.h:78
(discriminator 2) ./include/linux/fs.h:2781 (discriminator 2)
security/apparmor/lsm.c:483 (discriminator 2))
[ 142.014442] Code: c5 00 08 00 00 0f 85 4b 01 00 00 4c 89 e9 31 c0 f6
c1 02 0f 85 fd 00 00 00 48 8b 87 88 00 00 00 4c 8d b7 88 00 00 00 48 89
fd <48> 8b 40 18 48 8b 4f 70 0f b7 11 48 89 c7 66 89 54 24 04 48 8b 51
All code
========
   0:    c5 00 08                 (bad)
   3:    00 00                    add    %al,(%rax)
   5:    0f 85 4b 01 00 00        jne    0x156
   b:    4c 89 e9                 mov    %r13,%rcx
   e:    31 c0                    xor    %eax,%eax
  10:    f6 c1 02                 test   $0x2,%cl
  13:    0f 85 fd 00 00 00        jne    0x116
  19:    48 8b 87 88 00 00 00     mov    0x88(%rdi),%rax
  20:    4c 8d b7 88 00 00 00     lea    0x88(%rdi),%r14
  27:    48 89 fd                 mov    %rdi,%rbp
  2a:*    48 8b 40 18              mov    0x18(%rax),%rax        <--
trapping instruction
  2e:    48 8b 4f 70              mov    0x70(%rdi),%rcx
  32:    0f b7 11                 movzwl (%rcx),%edx
  35:    48 89 c7                 mov    %rax,%rdi
  38:    66 89 54 24 04           mov    %dx,0x4(%rsp)
  3d:    48                       rex.W
  3e:    8b                       .byte 0x8b
  3f:    51                       push   %rcx

Code starting with the faulting instruction
===========================================
   0:    48 8b 40 18              mov    0x18(%rax),%rax
   4:    48 8b 4f 70              mov    0x70(%rdi),%rcx
   8:    0f b7 11                 movzwl (%rcx),%edx
   b:    48 89 c7                 mov    %rax,%rdi
   e:    66 89 54 24 04           mov    %dx,0x4(%rsp)
  13:    48                       rex.W
  14:    8b                       .byte 0x8b
  15:    51                       push   %rcx
[  142.014443] RSP: 0018:ffffb9ef7189bc50 EFLAGS: 00010246
[  142.014445] RAX: 0000000000000000 RBX: ffff95eb5e555b00 RCX:
0000000000000300
[  142.014446] RDX: ffff95f838227538 RSI: 00000000002ba677 RDI:
ffff95e992be2a00
[  142.014447] RBP: ffff95e992be2a00 R08: ffff95f838227520 R09:
0000000000000002
[  142.014447] R10: ffff95ea72241d00 R11: 0000000000000001 R12:
0000000000000010
[  142.014448] R13: 0000000000000300 R14: ffff95e992be2a88 R15:
ffff95e95a6034e0
[  142.014449] FS:  00007f74ab6cf880(0000) GS:ffff95f838200000(0000)
knlGS:0000000000000000
[  142.014450] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  142.014451] CR2: 0000000000000018 CR3: 00000002473b6000 CR4:
0000000000f50ef0
[  142.014452] PKRU: 55555554
[  142.014453] Call Trace:
[  142.014454]  <TASK>
[  142.014456] ? __die_body (arch/x86/kernel/dumpstack.c:421)
[  142.014459] ? page_fault_oops (arch/x86/mm/fault.c:710)
[  142.014460] ? __lock_acquire (kernel/locking/lockdep.c:?
kernel/locking/lockdep.c:5174)
[  142.014462] ? local_lock_acquire
(./include/linux/local_lock_internal.h:29 (discriminator 1))
[  142.014465] ? do_user_addr_fault (arch/x86/mm/fault.c:?)
[  142.014467] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37
./arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1488
arch/x86/mm/fault.c:1538)
[  142.014468] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
[  142.014471] ? apparmor_file_open (./include/linux/mount.h:78
(discriminator 2) ./include/linux/fs.h:2781 (discriminator 2)
security/apparmor/lsm.c:483 (discriminator 2))
[  142.014472] security_file_open (security/security.c:?)
[  142.014474] do_dentry_open (fs/open.c:934)
[  142.014476] kernel_file_open (fs/open.c:1201)
[  142.014477] efivarfs_pm_notify (fs/efivarfs/super.c:505)
[  142.014479] ? __cfi_efivarfs_actor (fs/efivarfs/super.c:404)
[  142.014480] ? fw_pm_notify (./include/linux/workqueue.h:?
drivers/base/firmware_loader/main.c:1585
drivers/base/firmware_loader/main.c:1615)
[  142.014482] notifier_call_chain.llvm.227730641462406920
(kernel/notifier.c:?)
[  142.014485] blocking_notifier_call_chain (kernel/notifier.c:381)
[  142.014486] hibernate (kernel/power/hibernate.c:850)
[  142.014488] state_store (kernel/power/main.c:?)
[  142.014490] kernfs_fop_write_iter.llvm.8178385953439778559
(fs/kernfs/file.c:334)
[  142.014492] vfs_write (fs/read_write.c:587 (discriminator 1))
[  142.014494] ksys_write (fs/read_write.c:732)
[  142.014496] do_syscall_64 (arch/x86/entry/common.c:?)
[  142.014498] ? irqentry_exit_to_user_mode
(./arch/x86/include/asm/processor.h:722
./arch/x86/include/asm/entry-common.h:100
./include/linux/entry-common.h:365 kernel/entry/common.c:233)
[  142.014499] entry_SYSCALL_64_after_hwframe
(arch/x86/entry/entry_64.S:130)
[  142.014501] RIP: 0033:0x7f74ab09fe56
[ 142.014503] Code: 89 df e8 7d bd 00 00 8b 93 08 03 00 00 59 5e 48 83
f8 fc 75 15 83 e2 39 83 fa 08 75 0d e8 32 ff ff ff 66 90 48 8b 45 10 0f
05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
All code
========
   0:    89 df                    mov    %ebx,%edi
   2:    e8 7d bd 00 00           call   0xbd84
   7:    8b 93 08 03 00 00        mov    0x308(%rbx),%edx
   d:    59                       pop    %rcx
   e:    5e                       pop    %rsi
   f:    48 83 f8 fc              cmp    $0xfffffffffffffffc,%rax
  13:    75 15                    jne    0x2a
  15:    83 e2 39                 and    $0x39,%edx
  18:    83 fa 08                 cmp    $0x8,%edx
  1b:    75 0d                    jne    0x2a
  1d:    e8 32 ff ff ff           call   0xffffffffffffff54
  22:    66 90                    xchg   %ax,%ax
  24:    48 8b 45 10              mov    0x10(%rbp),%rax
  28:    0f 05                    syscall
  2a:*    48 8b 5d f8              mov    -0x8(%rbp),%rbx        <--
trapping instruction
  2e:    c9                       leave
  2f:    c3                       ret
  30:    0f 1f 40 00              nopl   0x0(%rax)
  34:    f3 0f 1e fa              endbr64
  38:    55                       push   %rbp
  39:    48 89 e5                 mov    %rsp,%rbp
  3c:    48 83 ec 08              sub    $0x8,%rsp

Code starting with the faulting instruction
===========================================
   0:    48 8b 5d f8              mov    -0x8(%rbp),%rbx
   4:    c9                       leave
   5:    c3                       ret
   6:    0f 1f 40 00              nopl   0x0(%rax)
   a:    f3 0f 1e fa              endbr64
   e:    55                       push   %rbp
   f:    48 89 e5                 mov    %rsp,%rbp
  12:    48 83 ec 08              sub    $0x8,%rsp
[  142.014504] RSP: 002b:00007ffcbaa60170 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[  142.014505] RAX: ffffffffffffffda RBX: 00007f74ab6cf880 RCX:
00007f74ab09fe56
[  142.014506] RDX: 0000000000000005 RSI: 000056105b899c30 RDI:
0000000000000007
[  142.014507] RBP: 00007ffcbaa60180 R08: 0000000000000000 R09:
0000000000000000
[  142.014507] R10: 0000000000000000 R11: 0000000000000202 R12:
0000000000000005
[  142.014508] R13: 000056105b899c30 R14: 000056105b88e2a0 R15:
00007f74ab1f4ea0
[  142.014510]  </TASK>
[  142.014510] Modules linked in: rfcomm bnep snd_seq_dummy snd_hrtimer
snd_seq nct6775 hwmon_vid nct6775_core btusb btrtl btmtk btbcm btintel
bluetooth snd_usb_audio snd_ump snd_usbmidi_lib snd_rawmidi
snd_seq_device snd_hda_codec_realtek snd_hda_scodec_component
snd_hda_codec_generic kvm_amd snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_hda_codec snd_hwdep cfg80211 kvm wmi_bmof rfkill
snd_pcsp snd_hda_core snd_ctxfi nfnetlink ip_tables x_tables
hid_roccat_kone hid_roccat hid_logitech_hidpp hid_logitech_dj amdgpu
drm_panel_backlight_quirks cec mfd_core drm_buddy drm_suballoc_helper
video drm_exec drm_display_helper gpu_sched amdxcp drm_client_lib
drm_ttm_helper drm_kms_helper ttm wmi uhid snd_aloop snd_pcm snd_timer
snd soundcore videodev mc
[  142.014533] CR2: 0000000000000018
[  142.014534] ---[ end trace 0000000000000000 ]---
[  142.023833] mlx4_en: 0000:04:00.0: Port 1: Using 32 TX rings
[  142.023836] mlx4_en: 0000:04:00.0: Port 1: Using 16 RX rings
[  142.031513] mlx4_en: 0000:04:00.0: Port 1: Initializing port
[  142.031932] mlx4_en 0000:04:00.0: registered PHC clock
[  142.078775] mlx4_en: eth0: Link Up
[  142.157707] RIP: 0010:apparmor_file_open (./include/linux/mount.h:78
(discriminator 2) ./include/linux/fs.h:2781 (discriminator 2)
security/apparmor/lsm.c:483 (discriminator 2))
[ 142.157711] Code: c5 00 08 00 00 0f 85 4b 01 00 00 4c 89 e9 31 c0 f6
c1 02 0f 85 fd 00 00 00 48 8b 87 88 00 00 00 4c 8d b7 88 00 00 00 48 89
fd <48> 8b 40 18 48 8b 4f 70 0f b7 11 48 89 c7 66 89 54 24 04 48 8b 51
All code
========
   0:    c5 00 08                 (bad)
   3:    00 00                    add    %al,(%rax)
   5:    0f 85 4b 01 00 00        jne    0x156
   b:    4c 89 e9                 mov    %r13,%rcx
   e:    31 c0                    xor    %eax,%eax
  10:    f6 c1 02                 test   $0x2,%cl
  13:    0f 85 fd 00 00 00        jne    0x116
  19:    48 8b 87 88 00 00 00     mov    0x88(%rdi),%rax
  20:    4c 8d b7 88 00 00 00     lea    0x88(%rdi),%r14
  27:    48 89 fd                 mov    %rdi,%rbp
  2a:*    48 8b 40 18              mov    0x18(%rax),%rax        <--
trapping instruction
  2e:    48 8b 4f 70              mov    0x70(%rdi),%rcx
  32:    0f b7 11                 movzwl (%rcx),%edx
  35:    48 89 c7                 mov    %rax,%rdi
  38:    66 89 54 24 04           mov    %dx,0x4(%rsp)
  3d:    48                       rex.W
  3e:    8b                       .byte 0x8b
  3f:    51                       push   %rcx

Code starting with the faulting instruction
===========================================
   0:    48 8b 40 18              mov    0x18(%rax),%rax
   4:    48 8b 4f 70              mov    0x70(%rdi),%rcx
   8:    0f b7 11                 movzwl (%rcx),%edx
   b:    48 89 c7                 mov    %rax,%rdi
   e:    66 89 54 24 04           mov    %dx,0x4(%rsp)
  13:    48                       rex.W
  14:    8b                       .byte 0x8b
  15:    51                       push   %rcx
[  142.157713] RSP: 0018:ffffb9ef7189bc50 EFLAGS: 00010246
[  142.157714] RAX: 0000000000000000 RBX: ffff95eb5e555b00 RCX:
0000000000000300
[  142.157715] RDX: ffff95f838227538 RSI: 00000000002ba677 RDI:
ffff95e992be2a00
[  142.157716] RBP: ffff95e992be2a00 R08: ffff95f838227520 R09:
0000000000000002
[  142.157717] R10: ffff95ea72241d00 R11: 0000000000000001 R12:
0000000000000010
[  142.157718] R13: 0000000000000300 R14: ffff95e992be2a88 R15:
ffff95e95a6034e0
[  142.157719] FS:  00007f74ab6cf880(0000) GS:ffff95f838200000(0000)
knlGS:0000000000000000
[  142.157720] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  142.157720] CR2: 0000000000000018 CR3: 00000002473b6000 CR4:
0000000000f50ef0
[  142.157721] PKRU: 55555554

>
>> Regards
>>
>> /Malte
>>
>> ...
>> <snip old backtrace>
>> ...
>>
>>
> Ryan
