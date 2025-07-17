Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598271DF75B
	for <linux-security-module@vger.kernel.org>; Thu, 17 Jul 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771762; cv=none; b=P4Wy3RyTEb45EGCORFBcVvPJfU+lG/w+6Z2GkDtDLC3sWX/c6+XcmVJwZS2Qn5uE5jM2t35w2WEKTCn6Oyi1zlGhQsEsR8YtUMiJmSIleYBs/QkaXkRIswh2HJ8IWJO2gmONWfqXSQlIpcfcuYqqqpYmkAnzPR7n9Seks9ooXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771762; c=relaxed/simple;
	bh=zSfutpzvLONFzLcN6KA/2TfmscaVVXktHre+v+V2C4E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DnuZ4ToXmCtEpzcCgdeA4Gl0SrIu2Q6WyBbyWiX2kwyDXgfSrPqZkA65qzvhYPTP9MfQlZgcqbd7dR95QSnBvLtyvB3ut4dz2HsQsozsHw4aGuVHJPe9+Ay+5tq1/cq/AVs3UWZobxf/bnZ7J8ee16fOVx6TZ2GgZHQFg9Izgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86f4f032308so179265339f.1
        for <linux-security-module@vger.kernel.org>; Thu, 17 Jul 2025 10:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752771759; x=1753376559;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s11QnQsS0K5+3krpl7bPykAdjgGyy4EsLU8W7Fl55/U=;
        b=rjwErc+9ykFNuRvdE+/Yg0WnEH7XiI4fn9K8tyFCamSng88U0rkMH9yV41Ax05Swx4
         ge7zjKXd/PwRoGa5gFOunAUZE+1xmhCMxVSyK66nERql8EWAAsDMLxm9hS8bc0ztNWGw
         qw3nD0SLwpnEnOJeLoXKvyRqM1tCM6h1MUm4wxRvD1hvb/oAwT294bJw8f65067tlGUh
         44EBszQgogX9vUysE6rgVnYce1QhwdYwO3RigMaMilW2w0AP+FuiFf2T0f0OreOlHcXY
         UQrCbuu/gnNVXEOZjjYh6jAbmuyUeZ2R78CHGis8Zbo9iYYxy6LF03xDGbwvTrdZQpAG
         C5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUui862Vm4v0L84n4/qZYkNpmfe6NlPY6E6iWZInbIvWgk3bj1v7aKbDBXLCKsVnHrSMn5DrEnSZ9e+mnyXf/odp11Icxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvkLSr6cA5jVOa+2QYM0UeedsFsdzpsJMXRdToF+TTmrWvVog
	VYlPTyNBuC4r7p4fFhYLra97pAtBzdC/3KUClqQsgND75Sr6CjxG5lAKDLNcNr0w9Y5A1G+LqxE
	MHwjeIdgNwMfo+AmKjNZCpGbjSFIlJ38f4Lu0tG+sRzXKMhkzaWIp/Go/Nms=
X-Google-Smtp-Source: AGHT+IEjnS6LO5zm2ft98pzzWESc9vwZQfvmL1EOOyvGIpykGKQyciK57DxSvxZ1TxQsVC7Zgs+y9u5lPMUp89T5gyrfs+x+63pu
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1614:b0:86c:f893:99da with SMTP id
 ca18e2360f4ac-879c07c9b1cmr963701339f.0.1752771759261; Thu, 17 Jul 2025
 10:02:39 -0700 (PDT)
Date: Thu, 17 Jul 2025 10:02:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68792caf.a70a0220.693ce.004d.GAE@google.com>
Subject: [syzbot] [lsm?] INFO: rcu detected stall in msr_read (2)
From: syzbot <syzbot+418ad593325950ed83b0@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115bce8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d07ca2d7b9951a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=418ad593325950ed83b0
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e03df5af7c87/disk-3f31a806.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57092d50ad29/vmlinux-3f31a806.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2cb038abbd25/bzImage-3f31a806.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+418ad593325950ed83b0@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 GPs behind) idle=75a4/1/0x4000000000000000 softirq=69821/69822 fqs=0
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P14774/1:b..l P14776/1:b..l
rcu: 	(detected by 0, t=10506 jiffies, g=60297, q=147 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 14769 Comm: syz.0.2443 Not tainted 6.16.0-rc5-syzkaller-00266-g3f31a806a62e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4858 [inline]
RIP: 0010:__lock_acquire+0x249/0x1c90 kernel/locking/lockdep.c:5190
Code: 3d 2e 3f 14 0f 83 1e 05 00 00 48 8d 04 80 48 8d 04 80 48 8d 04 c5 20 99 d7 95 44 0f b6 b0 c4 00 00 00 4c 89 ef e8 77 b0 ff ff <44> 0f b6 b8 c5 00 00 00 45 84 f6 0f 84 02 01 00 00 41 0f b6 4d 21
RSP: 0000:ffffc90000a08bf8 EFLAGS: 00000047
RAX: ffffffff95d79920 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88804942af58
RBP: ffff88804942a440 R08: 0000000000080000 R09: 0000000000000001
R10: 0000000000000028 R11: 0000000000000001 R12: ffff88804942af30
R13: ffff88804942af58 R14: 0000000000000002 R15: ffffffff9b050e80
FS:  00007fcfda9856c0(0000) GS:ffff888124813000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f68aaee1000 CR3: 0000000028ace000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 debug_object_deactivate+0x135/0x3a0 lib/debugobjects.c:873
 debug_hrtimer_deactivate kernel/time/hrtimer.c:450 [inline]
 debug_deactivate kernel/time/hrtimer.c:490 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1729 [inline]
 __hrtimer_run_queues+0x46f/0xad0 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x397/0x8e0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0x10b/0x3f0 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch.isra.0+0x22a/0xc10 kernel/sched/core.c:5265
Code: fb 09 00 00 44 8b 05 09 cb 1f 0f 45 85 c0 0f 85 be 01 00 00 4c 89 e7 e8 a4 f6 ff ff e8 df d5 39 00 fb 65 48 8b 1d be e2 46 12 <48> 8d bb 18 16 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0000:ffffc9000452f6f8 EFLAGS: 00000202
RAX: 0000000000001fa1 RBX: ffff88804942a440 RCX: ffffffff81c3c22f
RDX: 0000000000000000 RSI: ffffffff8de32e47 RDI: ffffffff8c158f60
RBP: ffffc9000452f740 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90a98657 R11: 0000000000000001 R12: ffff8880b853a2c0
R13: ffff888030ee0000 R14: 0000000000000001 R15: ffff8880b853b130
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1172/0x5de0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6879
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x2ff/0x4e0 kernel/sched/completion.c:116
 rdmsr_safe_on_cpu+0x1dc/0x210 arch/x86/lib/msr-smp.c:181
 msr_read+0x19d/0x250 arch/x86/kernel/msr.c:66
 vfs_read+0x1e1/0xc60 fs/read_write.c:570
 ksys_read+0x12a/0x250 fs/read_write.c:715
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcfd9b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcfda985038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fcfd9db5fa0 RCX: 00007fcfd9b8e929
RDX: 0000000000018ff8 RSI: 0000200000019680 RDI: 0000000000000003
RBP: 00007fcfd9c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcfd9db5fa0 R15: 00007fff37717d08
 </TASK>
task:syz.5.2442      state:R  running task     stack:26352 pid:14776 tgid:14767 ppid:8781   task_flags:0x10400140 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x116a/0x5de0 kernel/sched/core.c:6786
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7109
 irqentry_exit+0x36/0x90 kernel/entry/common.c:307
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_pc+0x56/0x70 kernel/kcov.c:222
Code: 00 f0 00 75 35 8b 82 3c 16 00 00 85 c0 74 2b 8b 82 18 16 00 00 83 f8 02 75 20 48 8b 8a 20 16 00 00 8b 92 1c 16 00 00 48 8b 01 <48> 83 c0 01 48 39 d0 73 07 48 89 01 48 89 34 c1 c3 cc cc cc cc 0f
RSP: 0018:ffffc9000432f658 EFLAGS: 00000246
RAX: 0000000000066894 RBX: 0000000000000001 RCX: ffffc9001d954000
RDX: 0000000000080000 RSI: ffffffff84c43393 RDI: 0000000000000001
RBP: 00fff00000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000040
R13: 0000000000000000 R14: ffffea0001a74540 R15: 00fff00000000000
 blkcg_css block/blk-cgroup.c:107 [inline]
 blk_cgroup_congested+0x53/0x270 block/blk-cgroup.c:2256
 __folio_throttle_swaprate+0xa8/0x2f0 mm/swapfile.c:3913
 folio_throttle_swaprate include/linux/swap.h:636 [inline]
 folio_prealloc mm/memory.c:1077 [inline]
 alloc_anon_folio mm/memory.c:5014 [inline]
 do_anonymous_page mm/memory.c:5071 [inline]
 do_pte_missing mm/memory.c:4249 [inline]
 handle_pte_fault mm/memory.c:6069 [inline]
 __handle_mm_fault+0x2f78/0x5490 mm/memory.c:6212
 handle_mm_fault+0x589/0xd10 mm/memory.c:6381
 faultin_page mm/gup.c:1186 [inline]
 __get_user_pages+0x589/0x3b80 mm/gup.c:1488
 __get_user_pages_locked mm/gup.c:1754 [inline]
 __gup_longterm_locked+0x5e7/0x1840 mm/gup.c:2517
 pin_user_pages+0x13c/0x160 mm/gup.c:3537
 xdp_umem_pin_pages net/xdp/xdp_umem.c:105 [inline]
 xdp_umem_reg net/xdp/xdp_umem.c:230 [inline]
 xdp_umem_create+0x73c/0x1270 net/xdp/xdp_umem.c:263
 xsk_setsockopt+0x5b2/0x840 net/xdp/xsk.c:1405
 do_sock_setsockopt+0x221/0x470 net/socket.c:2296
 __sys_setsockopt+0x1a0/0x230 net/socket.c:2321
 __do_sys_setsockopt net/socket.c:2327 [inline]
 __se_sys_setsockopt net/socket.c:2324 [inline]
 __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa0b438e929
RSP: 002b:00007fa0b51db038 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fa0b45b6080 RCX: 00007fa0b438e929
RDX: 0000000000000004 RSI: 000000000000011b RDI: 0000000000000009
RBP: 00007fa0b4410b39 R08: 000000000000001c R09: 0000000000000000
R10: 00002000000000c0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa0b45b6080 R15: 00007ffc9ac981f8
 </TASK>
task:syz.2.2444      state:R  running task     stack:26224 pid:14774 tgid:14773 ppid:5845   task_flags:0x400140 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x116a/0x5de0 kernel/sched/core.c:6786
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7109
 irqentry_exit+0x36/0x90 kernel/entry/common.c:307
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find+0x86/0xf0 arch/x86/kernel/unwind_orc.c:102
Code: f2 48 d1 fa 48 8d 5c 95 00 48 89 da 48 c1 ea 03 0f b6 34 0a 48 89 da 83 e2 07 83 c2 03 40 38 f2 7c 05 40 84 f6 75 4b 48 63 13 <48> 01 da 49 39 d5 73 af 4c 8d 63 fc 49 39 ec 73 b2 4d 29 f7 49 c1
RSP: 0018:ffffc900053d76a0 EFLAGS: 00000246
RAX: ffffffff91af4b08 RBX: ffffffff9105a1e4 RCX: dffffc0000000000
RDX: fffffffff69fda98 RSI: 0000000000000000 RDI: ffffffff9105a1e4
RBP: ffffffff9105a1e4 R08: ffffffff91af4b0e R09: 0000000000000000
R10: 0000000000000000 R11: 000000000006a57d R12: ffffffff9105a1e4
R13: ffffffff87a57d46 R14: ffffffff9105a1e4 R15: ffffffff9105a1e4
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x2ec/0x20a0 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 dummy_alloc_request+0xa9/0x1b0 drivers/usb/gadget/udc/dummy_hcd.c:669
 usb_ep_alloc_request+0x66/0x2a0 drivers/usb/gadget/udc/core.c:195
 gadget_bind+0xe7/0x760 drivers/usb/gadget/legacy/raw_gadget.c:293
 gadget_bind_driver+0x286/0xc40 drivers/usb/gadget/udc/core.c:1610
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __driver_attach+0x283/0x580 drivers/base/dd.c:1215
 bus_for_each_dev+0x13e/0x1d0 drivers/base/bus.c:370
 bus_add_driver+0x2e9/0x690 drivers/base/bus.c:678
 driver_register+0x15c/0x4b0 drivers/base/driver.c:249
 usb_gadget_register_driver_owner+0x132/0x330 drivers/usb/gadget/udc/core.c:1700
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:595 [inline]
 raw_ioctl+0x17d0/0x2c30 drivers/usb/gadget/legacy/raw_gadget.c:1306
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f68aab8e52b
RSP: 002b:00007f68aba8af10 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f68aab8e52b
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000009
RBP: 00007f68aba8bfe0 R08: 0000000000000000 R09: 00322e6364755f79
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f68aba8afb0 R14: 0000200000000180 R15: 00007f68aaee0b88
 </TASK>
rcu: rcu_preempt kthread starved for 10506 jiffies! g60297 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28264 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x116a/0x5de0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6879
 schedule_timeout+0x123/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1ea/0xb00 kernel/rcu/tree.c:2054
 rcu_gp_kthread+0x270/0x380 kernel/rcu/tree.c:2256
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 14737 Comm: syz.6.2435 Not tainted 6.16.0-rc5-syzkaller-00266-g3f31a806a62e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:csd_lock_wait kernel/smp.c:340 [inline]
RIP: 0010:smp_call_function_many_cond+0xd7b/0x1510 kernel/smp.c:885
Code: e8 6a 19 0c 00 45 85 ed 74 46 48 8b 14 24 49 89 d6 49 89 d5 49 c1 ee 03 41 83 e5 07 4d 01 e6 41 83 c5 03 e8 07 1e 0c 00 f3 90 <41> 0f b6 06 41 38 c5 7c 08 84 c0 0f 85 6f 05 00 00 8b 43 08 31 ff
RSP: 0018:ffffc90005017858 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b853fe20 RCX: ffffffff81afd49d
RDX: ffff888035792440 RSI: ffffffff81afd479 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000003 R14: ffffed10170a7fc5 R15: ffff8880b843b580
FS:  000055558db88500(0000) GS:ffff888124713000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2b9b35 CR3: 000000003c139000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1052
 on_each_cpu include/linux/smp.h:71 [inline]
 smp_text_poke_sync_each_cpu arch/x86/kernel/alternative.c:2691 [inline]
 smp_text_poke_batch_finish+0x27b/0xdb0 arch/x86/kernel/alternative.c:2901
 __static_call_transform+0x33b/0x740 arch/x86/kernel/static_call.c:111
 arch_static_call_transform+0xb6/0xc0 arch/x86/kernel/static_call.c:163
 __static_call_update+0xef/0x670 kernel/static_call_inline.c:147
 tracepoint_update_call kernel/tracepoint.c:271 [inline]
 tracepoint_remove_func kernel/tracepoint.c:394 [inline]
 tracepoint_probe_unregister+0xb10/0xd70 kernel/tracepoint.c:504
 bpf_raw_tp_link_release+0x35/0x70 kernel/bpf/syscall.c:3635
 bpf_link_free+0xe9/0x390 kernel/bpf/syscall.c:3157
 bpf_link_put_direct kernel/bpf/syscall.c:3200 [inline]
 bpf_link_release+0x5d/0x80 kernel/bpf/syscall.c:3207
 __fput+0x3ff/0xb70 fs/file_table.c:465
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:114
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8cf398e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda28007e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f8cf3bb7ba0 RCX: 00007f8cf398e929
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f8cf3bb7ba0 R08: 00000000000001f4 R09: 0000001ea2800adf
R10: 00007f8cf3bb7ac0 R11: 0000000000000246 R12: 000000000009aeea
R13: 00007f8cf3bb6080 R14: ffffffffffffffff R15: 00007ffda2800900
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
