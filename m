Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495555;
	b=ZmfKjMCzNwmP6ayP/ABrrMKzPJti/bKzHvg2FvFf1XzY7a5J7Jd1pyIjNMCZkK1T5+vJ
	 /RPw+OC0rvM0bEyTGa1ktx8/5FQtuP5hnEcjXmGNDZ3afzhTA8nB0sLC9dYzFLIsxGwFX
	 CaVAZ6EeMZ9Kuk1MjgtzcLTBKoah+kYJJVfPsfl39IvpZOxzYc0WPcpj0KhNg029ug/es
	 fniPeiWKQaSoxiehAYi0LnerGDbvDhfoOrPpCEFXMtieU0gJk+38ysSgEuXYSOz135yCz
	 GUZoZQc9T++bycYUg1U4SIH7jv78AyPrkyuYl2pWSQ7SpqH39vZnjv6a2+q5JL9t8Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495555;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=uyV6ROrO1CtSDtUiRySsm1MrJZ9iaX3jNj12OZgR3iU=;
	b=A5rWhAsvGtsUiV4UkGOv5f2Df35K47xsZcaN3bdAEO3PGR5qysKP8kZ4eF0fRLlW1AiC
	 fr1mI4lM3tYn4QLyK8mMTHWUeOVAoF8+exd14FPWy4DaAxBdMTai1ZZ6uSC5WWpXfQ+gV
	 iF7bbEF/WuDyVhnkIK/L5I1B2U/sNl6kJGN9Xbov2sAIodjD5hqkMCof1XlOYoPOWRrgh
	 6svzTSUbo/xhPMA4pW7Gj9v2QHvegfvnFelK6FfucJ8GN2owwA0H1sVp69Rj7W5XwIn5Y
	 UMtC5ci5QRUzQrsx9f47AThc9Kft8Pu8M7AwgMRGQj9A1181JAbAZugr7wYnEQz5XXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EC606A326
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 04:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F12EC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c7f887ac6bso7651673b6e.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 20:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795495554; x=1796100354;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uyV6ROrO1CtSDtUiRySsm1MrJZ9iaX3jNj12OZgR3iU=;
        b=PbP6gdwSqrcGD2r79v/P0pp1YdOOWE6E6W6caOBN0/UbGBgqvob4WnegeDl4Zlw+rB
         bP7tWzL3KXm/ALl8YSFOBdidHFtEwqmektX87JIjtxNh/1TSWsfP8mjImhfi4Qm7LQAa
         XkM3nTL/LHiUocCgV+UPZ0nXmxp5iy+guyYIhZnlXQj7aBxFgMs6FTOXjzfs1n8C8bBY
         RNujE4fcG4GRzfF/87CAMaCD5GRfBcqQWK9BwtqtRm0zqwB09zQm86kFwsEEqEbcaSQj
         quxQa5ZTViF1Yvi89r1LmiG6A6VpuYr09+Y7QfdsC5UNYmb7bPCALLXqX+pHWm9OIRWH
         j7Zw==
X-Forwarded-Encrypted: i=1; AL+hErEv/1u3Lb5yMZjgKcTtAREu87qI6v5x28FgbHAFrRRkvC8PWTlFpDS4bYsPZ7T0yHFC8qTxUTkE6UY7LDp8dceiZBiM3eQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hHitn+Gge1ZBAA76o1D/yNpR3pl+OMaLxqm0liXXzVIQOvaKB
	XnjfGiwRNP33oqy4/Zcael49qEDZu34vA/kqCa/voGtjOr6BPeIOK7Y7vWFw/o0lLihc0PA33Mw
	ElNEvJo0whs3byK5Csg41CPSCYZ+lFBVFR3FaPjG/XsvykUM7bxLue1oyXS0=
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f07:b0:4cb:f21b:6f91 with SMTP id
 5614622812f47-57a0a719e9bmr15482730b6e.36.1795495554014; Mon, 23 Nov 2026
 20:45:54 -0800 (PST)
Date: Mon, 23 Nov 2026 20:45:53 -0800
In-Reply-To: <673fdc18.050a0220.363a1b.012c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b051681.58b41460.7037.0590.GAE@google.com>
Subject: Re: [syzbot] [tomoyo?] [mm?] INFO: rcu detected stall in
 security_file_ioctl (9)
From: syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net, jack@suse.cz, 
	jmorris@namei.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-users_en@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3896ae4adf5f tun: complete the zerocopy buffer of packets ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16305bbe580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d44b06612b68f56
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f8640465bdf47ca708
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1740f363580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11305bbe580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca6f81eb80f4/disk-3896ae4a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e88582fee6d7/vmlinux-3896ae4a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a978638f7ba7/bzImage-3896ae4a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (10499 ticks this GP) idle=f474/1/0x4000000000000000 softirq=18751/18751 fqs=4770
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:     5264          0            0
rcu: 	cputime:      138      52351           25   ==> 52490(ms)
rcu: 	(t=10500 jiffies g=18789 q=10129 ncpus=2)
CPU: 0 UID: 0 PID: 5837 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:211 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x47/0x80 kernel/locking/spinlock.c:221
Code: f7 e8 3d d4 99 f5 f7 c3 00 02 00 00 74 05 e8 10 79 c6 f5 9c 58 a9 00 02 00 00 75 29 f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> c4 c4 8a f5 65 48 8b 05 8c 0d d7 08 48 85 c0 74 18 5b 41 5e e9
RSP: 0018:ffffc90000007e18 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000287 RCX: 0000000000000101
RDX: 0000000000000003 RSI: ffffffff8e6a85cd RDI: 0000000000000001
RBP: ffff88807ed35538 R08: ffffffff91be1bbf R09: 1ffffffff237c377
R10: dffffc0000000000 R11: fffffbfff237c378 R12: ffff8880b8228600
R13: ffffffff89fd0480 R14: ffff8880b8228600 R15: 1ffff1101704514a
FS:  000055557acc5500(0000) GS:ffff8881233ff000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005612e0743768 CR3: 0000000077760000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:2075 [inline]
 __hrtimer_run_queues+0x2bf/0xa10 kernel/time/hrtimer.c:2136
 hrtimer_run_softirq+0x1e3/0x2e0 kernel/time/hrtimer.c:2153
 handle_softirqs+0x265/0x8d0 kernel/softirq.c:669
 __do_softirq kernel/softirq.c:703 [inline]
 invoke_softirq kernel/softirq.c:542 [inline]
 __irq_exit_rcu+0xc6/0x220 kernel/softirq.c:786
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x232/0x350 kernel/locking/lockdep.c:5947
Code: ff ff ff e8 50 07 64 0a f7 44 24 10 00 02 00 00 0f 84 38 ff ff ff 65 48 8b 05 12 e1 3d 13 48 3b 44 24 50 75 33 fb 48 83 c4 58 <5b> 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 48 8d 3d 37 27 1d
RSP: 0018:ffffc9000326f700 EFLAGS: 00000296
RAX: 3c7ff0ca9698f600 RBX: 0000000000000000 RCX: 0000000000000046
RDX: 000000000e8f2ff9 RSI: ffffffff8e936150 RDI: ffffffff8c8e9880
RBP: ffff8880281e8000 R08: ffffffff817889cf R09: 0000000000000000
R10: ffffc9000326f838 R11: ffffffff81b3b880 R12: ffffffff9015a2e0
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 unwind_next_frame+0xac/0x2550 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3f/0x90 mm/kasan/common.c:79
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:599
 poison_slab_object mm/kasan/common.c:267 [inline]
 __kasan_slab_free+0x70/0x90 mm/kasan/common.c:299
 kasan_slab_free include/linux/kasan.h:239 [inline]
 slab_free_hook mm/slub.c:2780 [inline]
 slab_free mm/slub.c:6637 [inline]
 kfree+0x1c7/0x650 mm/slub.c:6930
 tomoyo_path_number_perm+0x4ba/0x5f0 security/tomoyo/file.c:741
 security_file_ioctl+0xc3/0x2a0 security/security.c:2534
 __do_sys_ioctl fs/ioctl.c:592 [inline]
 __se_sys_ioctl+0x47/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2e4e9a91ab
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007fffff379100 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f2e4e9a91ab
RDX: 00007fffff379160 RSI: 0000000000008933 RDI: 0000000000000005
RBP: 00007f2e4ea394f3 R08: 0000000000000000 R09: 00007fffff379470
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007f2e4f764620 R14: 0000000000000006 R15: 0000000000000000
 </TASK>
sched: DL replenish lagged too much
