Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57171155757
	for <linux-security-module@vger.kernel.org>; Mon, 22 Dec 2025 03:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766375311; cv=none; b=PRSsSdKy4c3VzxETlCA4/Pf64X/fh0tlC2BC8xme1vK9atjwDkBRBDFTQMWwfcKiN52TDoPy+CekIzpqejkpdzmBBVz5hrtqTyzWjvdOCKXQ8roAHt1A2aqpCatS34VJ7xklwp7xkBhxXmeBeDZg+9nGHuAaKIDMSG3v9h050ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766375311; c=relaxed/simple;
	bh=KVaKQ81mbJBXdvk/UbvYDDz7h7cMKud+nTsj1J6ekCE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Aa5WP7j8CLN6trv8wiI10HXxvwkd8lsk70JqRIsLeD/frjIj77kCcdWty0KFZ/9oyJe/74HPPEJokGFUu8CwiJryUwYHXTyql0yKNddXQjhb6BMzDyv/4Ru1kwEzc7Ibim4XCjx6vAX6VK9gy6FubwII1P6ar+N8LzgkCdDvsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6574d564a9eso6290837eaf.2
        for <linux-security-module@vger.kernel.org>; Sun, 21 Dec 2025 19:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766375308; x=1766980108;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJA07a07liZblpJBhg7XvJrBqGLeculdtujgTcOdXjs=;
        b=HsH3ScJH1povMqUCTsAs46UG/YMYYzssckoo3KsMlZxGvL8KFiAe9+PvK0hZuVZqy0
         eK1WZnNsPXgLS7cn48ZIFvOd2O7X+Phu4y5P7GqY7AJX9kqYls22/hCuV3PKOTIgMook
         +Km7cXt6xEGw3u+YqJqGjP0GfYOHTvZcLUMAdVj/RYeiSlsi7qwfrtDN6EMP7ndcK861
         dyRtgNc4yoLe6rcDuyICKWiKUE0AZm7kfedyc8U6g2Djim2wx270rT+3MqEdpmS6FEQp
         n6sofkDKXf1E4vb6IdfO+zo7qvFWmLpz3doFpjzCU7RLeOZWSfztMXK7DPlFL19zxs66
         zr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVxuNOCVFnXg6p+/B3yPRD1ZTw/wGGsDyYqZITyTbgFRMVDvF9Gc0B8qH8c+g1BIfQnCyLrc11Dbw/WazQaEaKqVNHFIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcB/kMwGEMphele+DNeJacLNTebODAjo9qeTERR1UithQmcDA
	zbT8dvcwikAAJ6HaPQ8TlyR/qv4I2IB4inT7X6TQoPcRJQVkOShjgIyt+vnOk/EJ55G6e8B3LHN
	y3lhErwHEKmp/PJfy8COZdcyOoSlBYB0kXlBeU4e9Sc6W21hz3cIpUYNCYeg=
X-Google-Smtp-Source: AGHT+IGbzVJ607gESXPYbhG5hho8qrQLZDAS1oMVh9aezr3pY6F1cpSguyWBVXiSuqRYJokCnuyOcK2wAGzyOemQxx7O/FoVe/Y3
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:330d:b0:65d:762:749a with SMTP id
 006d021491bc7-65d0e94d689mr3139229eaf.7.1766375308236; Sun, 21 Dec 2025
 19:48:28 -0800 (PST)
Date: Sun, 21 Dec 2025 19:48:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6948bf8c.050a0220.1b4e0c.0030.GAE@google.com>
Subject: [syzbot] [tomoyo?] [mm?] INFO: rcu detected stall in sys_newfstat (4)
From: syzbot <syzbot+5fb7dcd004f42cb418d7@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-users_en@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    12b95d29eb97 Add linux-next specific files for 20251217
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16bbd31a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b53f0e28d100777
dashboard link: https://syzkaller.appspot.com/bug?extid=5fb7dcd004f42cb418d7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11355d92580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0264b4454f47/disk-12b95d29.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72a383625b53/vmlinux-12b95d29.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6499b25d444f/bzImage-12b95d29.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fb7dcd004f42cb418d7@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5966/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=13749, q=681 ncpus=2)
task:udevd           state:R  running task     stack:24376 pid:5966  tgid:5966  ppid:5200   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7193
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_acquire+0x16c/0x340 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 74 3f 25 11 <48> 3b 44 24 58 0f 85 e5 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc900035174d8 EFLAGS: 00000206
RAX: 550ae36b7d32a800 RBX: 0000000000000000 RCX: 550ae36b7d32a800
RDX: 0000000002aa642d RSI: ffffffff8dc9133e RDI: ffffffff8be243e0
RBP: ffffffff81746f85 R08: ffffffff81746f85 R09: ffffffff8e33f8a0
R10: ffffc90003517698 R11: ffffffff81addf20 R12: 0000000000000002
R13: ffffffff8e33f8a0 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xc2/0x23d0 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kfree+0x1c0/0x660 mm/slub.c:6882
 tomoyo_realpath_from_path+0x598/0x5d0 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x213/0x4b0 security/tomoyo/file.c:822
 security_inode_getattr+0x12f/0x330 security/security.c:1869
 vfs_getattr fs/stat.c:259 [inline]
 vfs_fstat fs/stat.c:281 [inline]
 __do_sys_newfstat fs/stat.c:555 [inline]
 __se_sys_newfstat fs/stat.c:550 [inline]
 __x64_sys_newfstat+0xfc/0x200 fs/stat.c:550
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf92911ad7
RSP: 002b:00007ffe4ab44048 EFLAGS: 00000246 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 00005558e4439050 RCX: 00007fcf92911ad7
RDX: 0000000000000000 RSI: 00007ffe4ab44090 RDI: 0000000000000009
RBP: 0000000000000001 R08: 0000000000000620 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00005558ba62e95f
R13: 00005558ba63f660 R14: 0000000000000000 R15: 0000000000000009
 </TASK>
rcu: rcu_preempt kthread starved for 10446 jiffies! g13749 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27728 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 __schedule_loop kernel/sched/core.c:6948 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6963
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 be 21 00 f3 0f 1e fa fb f4 <e9> 48 ee 02 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8e007d80 EFLAGS: 000002c6
RAX: da29ab50f81b1900 RBX: ffffffff8197c88a RCX: da29ab50f81b1900
RDX: 0000000000000001 RSI: ffffffff8daa76bd RDI: ffffffff8be243e0
RBP: ffffffff8e007ea8 R08: ffff8880b86336db R09: 1ffff110170c66db
R10: dffffc0000000000 R11: ffffed10170c66dc R12: ffffffff8fc3b070
R13: 1ffffffff1c129b8 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881259e1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31163fff CR3: 0000000077280000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x1ea/0x520 kernel/sched/idle.c:332
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:430
 rest_init+0x2de/0x300 init/main.c:757
 start_kernel+0x3a7/0x400 init/main.c:1206
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x147
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
