Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF4368262
	for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923027; cv=none; b=Gn3Si6RqC3MBIFTyDjLelB497zLcjoWOATMNBWaXa0El5NoktsbXDGxK5VFYTpbKHm4hUI9vfD1CEYi5bv4horBffEHnbfdlNxP6Qtv3NAbUAYikukmvHIIYL66KNBGvmseYBvHw54SIBEIuUnRTKDvFmU3chkfI25xH4jKbd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923027; c=relaxed/simple;
	bh=bH5fyWpndAQmO0GqbfKC/2FRD8semd94FLj2YPECnP8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ilNMMZtj1IVWKeWYg6IgRP9GmC7iIdUxxDVXAy5zhvSodU55jMwlPrtlE3IqQoR7jyE5ohNc4X/mXBxeCPnGPUtXyuQfi86MOIGBvIJmUhXnN/HFOwdyQLmM9KW93lGCjl3l14qAzE2/6x334r4uQA+SiKSCu3Rm0RJ1Od5V9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679a47a1febso69012985eaf.3
        for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 00:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771923025; x=1772527825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tU4KeK3bukLdkToVFUU/DYEl43X5BYkLi3LM0va+rMg=;
        b=hMBXSjlplRiuXc9U2Fj4L3COwcaJiZmeNsKOYB1IRhGFn6xOAFiqnAZEx2/gh3eNfL
         AbIOlsA7QGyOi/efI9RVa7b5tFHHY4dPdxuRGedFnYazEDxn2eGAe1xveV9xvO2L9nZK
         35GzUJ4iIZHFbgpwbH7VaH2v4C8lpE5csuMHsHwujTOKK/tunrXioQJqgcorAObrhUok
         itfWPoXxJstI7QP9ZygeW8QcxU12S+4dAoGJiOzU6dc2yYcXdEycM/LP+Jfeq7ax+zi7
         z+2OHfSgODc5o1Iq6E3TiLxT/oVdyE2dF2mX//5p6C3Ge/yUwRWPejhgSJNyjXcZLa6+
         q9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXaZIUpleaK6ERQ8/4tm+cncbSNKmUCddz/HVzeTd92p4AOD1SL4BHh7X/Pbd4F4YPrpIHwXQKGb2HKwj2gtxoqA5RL2I4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiw8v+6AAUN/I0/1gDS4lBhq/ZrjHa9yldjoWZZlHbDXOpH2c4
	wOK868HDWpyL2aPZ/WwL6HhUsir8CrrU1813XxX1S9qMhES8lwbVkmk2kR++zgOzmWnP8QWthnL
	wCKuxRNpSFD8CEuH7imM5D9AEB4AImMNylsFHwVFQRW0lyP3fUm/wVFd57R4=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b0f:b0:662:f91f:4a85 with SMTP id
 006d021491bc7-679c461d225mr6375070eaf.54.1771923025154; Tue, 24 Feb 2026
 00:50:25 -0800 (PST)
Date: Tue, 24 Feb 2026 00:50:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699d6651.050a0220.247d23.03d2.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in sys_rename (8)
From: syzbot <syzbot+1e663068a97140bb66f3@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    44982d352c33 Add linux-next specific files for 20260219
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ef3c02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=51f859f3211496bc
dashboard link: https://syzkaller.appspot.com/bug?extid=1e663068a97140bb66f3
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1177fe52580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/173e988354ac/disk-44982d35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69062373098e/vmlinux-44982d35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3dd3887dc600/bzImage-44982d35.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e663068a97140bb66f3@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P1034/2:b..l P5873/1:b..l
rcu: 	(detected by 1, t=10504 jiffies, g=14085, q=669 ncpus=2)
task:udevd           state:R  running task     stack:23784 pid:5873  tgid:5873  ppid:5200   task_flags:0x400140 flags:0x00080800
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 preempt_schedule_irq+0x4d/0xa0 kernel/sched/core.c:7234
 irqentry_exit+0x599/0x620 kernel/entry/common.c:239
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_acquire+0x20b/0x2e0 kernel/locking/lockdep.c:5872
Code: e9 30 ff ff ff e8 c5 f3 18 0a f7 c3 00 02 00 00 0f 84 38 ff ff ff 65 48 8b 05 41 01 a0 11 48 3b 44 24 30 75 33 fb 48 83 c4 38 <5b> 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 48 8d 3d fe 3b 95
RSP: 0018:ffffc90003f073d8 EFLAGS: 00000286
RAX: a296ff60d4053400 RBX: 0000000000000246 RCX: 0000000000000046
RDX: 00000000112c4056 RSI: ffffffff8e287ccb RDI: ffffffff8c2a0a00
RBP: 0000000000000000 R08: ffffffff8176da45 R09: ffffffff8e9602e0
R10: ffffc90003f07538 R11: ffffffff81b115b0 R12: 0000000000000002
R13: ffffffff8e9602e0 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 rcu_read_lock include/linux/rcupdate.h:850 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1193 [inline]
 unwind_next_frame+0xc2/0x23c0 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5219 [inline]
 __kmalloc_noprof+0x35c/0x760 mm/slub.c:5231
 kmalloc_noprof include/linux/slab.h:966 [inline]
 tomoyo_realpath_from_path+0xe3/0x5d0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path2_perm+0x2c5/0x760 security/tomoyo/file.c:927
 tomoyo_path_rename+0x14e/0x1b0 security/tomoyo/tomoyo.c:300
 security_path_rename+0x248/0x460 security/security.c:1518
 filename_renameat2+0x4c1/0x9c0 fs/namei.c:6139
 __do_sys_rename fs/namei.c:6188 [inline]
 __se_sys_rename+0x55/0x2c0 fs/namei.c:6184
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cd687acc7
RSP: 002b:00007ffec20235f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 000055db72eaa280 RCX: 00007f6cd687acc7
RDX: 000055db72ea2010 RSI: 00007ffec2023610 RDI: 00007ffec2023a10
RBP: 000055db72ebff10 R08: 00000000000001e0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffec2023610
R13: 00007ffec2023a10 R14: 0000000000000000 R15: 000055db6bd089dd
 </TASK>
task:kworker/u8:7    state:R  running task     stack:24416 pid:1034  tgid:1034  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 preempt_schedule_common+0x82/0xd0 kernel/sched/core.c:7091
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __local_bh_enable_ip+0xe1/0x130 kernel/softirq.c:457
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:924 [inline]
 __dev_queue_xmit+0x1e6c/0x38a0 net/core/dev.c:4864
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:246
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xbaa/0x14e0 net/ipv6/ndisc.c:512
 ndisc_send_ns+0xd7/0x160 net/ipv6/ndisc.c:670
 addrconf_dad_work+0xac4/0x14c0 net/ipv6/addrconf.c:4287
 process_one_work+0x949/0x1650 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: rcu_preempt kthread starved for 10573 jiffies! g14085 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27616 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 schedule_timeout+0x158/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x312/0x11d0 kernel/rcu/tree.c:2095
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2297
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6085 Comm: syz.0.27 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:check_kcov_mode kernel/kcov.c:194 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x36/0x90 kernel/kcov.c:314
Code: 28 e9 7b 11 65 8b 0d 49 e9 7b 11 81 e1 00 01 ff 00 74 11 81 f9 00 01 00 00 75 5b 83 ba 54 16 00 00 00 74 52 8b 8a 30 16 00 00 <83> f9 03 75 47 48 8b 8a 38 16 00 00 44 8b 8a 34 16 00 00 49 c1 e1
RSP: 0018:ffffc900025e7a88 EFLAGS: 00000046
RAX: ffffffff81b67144 RBX: ffff8880b8423e40 RCX: 0000000000000000
RDX: ffff88802df49e40 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81b32095 R09: ffffffff9a518508
R10: 0000000000000003 R11: ffffffff81742750 R12: 00000000100006b5
R13: dffffc0000000000 R14: 00000000000001ed R15: 0000000000000020
FS:  00007f9fec4f96c0(0000) GS:ffff888125002000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000058 CR3: 0000000075658000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 clockevents_program_event+0x1d4/0x350 kernel/time/clockevents.c:336
 hrtimer_start_range_ns+0x1687/0x1ff0 kernel/time/hrtimer.c:1331
 __posixtimer_deliver_signal kernel/time/posix-timers.c:314 [inline]
 posixtimer_deliver_signal+0x1ce/0x410 kernel/time/posix-timers.c:340
 dequeue_signal+0x249/0x370 kernel/signal.c:660
 get_signal+0x55d/0x1330 kernel/signal.c:2914
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9feb59c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9fec4f90e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f9feb815fa8 RCX: 00007f9feb59c629
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f9feb815fa8
RBP: 00007f9feb815fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9feb816038 R14: 00007ffda92b66d0 R15: 00007ffda92b67b8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
