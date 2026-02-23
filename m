Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D362246BC5;
	Mon, 23 Feb 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854018; cv=none; b=ZxJFDCn6jr9/+wYK0KNLWx7QKe/04fShi9/2i74F77WD7JWk7DznGMtbZypcUwwCH+HNl82HtgUwYWinbwcaWoPhRzDaFSg4n5IOOi3Zq+62tjCX6MvUNFHrZo2xAm6hcSA/72d8RY+UndXMzw5L36cCZKaQ7mmYVIhZGF08ZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854018; c=relaxed/simple;
	bh=iZ0XcCxmBBYH6KpAWY4sREAqUKNfN0e39tteAnfrA+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwIDOZZk7FPSpUeQVv6RnSDsXxkVDkBi1nzHFS2bJDl+cISmUhfN9zDfYUZCVGbCCAZFW1jiXNYnjZvi7GjC560Gmpc/0nLPNqXzw8ckUbkCNTH3xUm8Cx2a/YZlZu2sz6j6NkqlM3vQdNcRzRYTiV0BhJTT2o73XYDiIcA254Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJIXAFPq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJIXAFPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D912EC116C6;
	Mon, 23 Feb 2026 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771854018;
	bh=iZ0XcCxmBBYH6KpAWY4sREAqUKNfN0e39tteAnfrA+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJIXAFPqZn9O0pN4rWKorOweIL99L2YBIN377oG3v9wlSu+5Ud5UWz8fIOSv+rVRK
	 jLOTfdGd1yIVxcfy/XYOG1kYgFLjo2o6aBt31uTbX6/N9+zmbbOF0LmNn8swVZf8MI
	 Vk25e1cMBrl49+31G5xBBW49DXCjyWRSGs14pukGExk1C6IC9qmaksPrbf6HEfTNvp
	 B4wkwjOkP1dD4/QdU0wkSRoRib6xxiTqwp9mJxaZT5HPNCiiPPjdrEsM8zQh+Rn55H
	 3ixbwj41FXqbBcsg7R0RgqXCsunez2gpYjGhXHK0kZLNi3jcHo/DGLT2Ya15rfpQ+g
	 1CNTLmFI+PwMw==
Date: Mon, 23 Feb 2026 14:40:15 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: syzbot <syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Cc: anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tglx@kernel.org
Subject: Re: [syzbot] [kernel?] INFO: task hung in
 restrict_one_thread_callback
Message-ID: <aZxYv7MxxExj9fjM@localhost.localdomain>
References: <69984159.050a0220.21cd75.01bb.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69984159.050a0220.21cd75.01bb.GAE@google.com>

Le Fri, Feb 20, 2026 at 03:11:21AM -0800, syzbot a écrit :
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    635c467cc14e Add linux-next specific files for 20260213
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1452f6e6580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61690c38d1398936
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e41c02580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15813652580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/78b3d15ca8e6/disk-635c467c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a95f3d108ef4/vmlinux-635c467c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e58086838b24/bzImage-635c467c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> 
> INFO: task syz.0.2812:14643 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.2812      state:D stack:25600 pid:14643 tgid:14643 ppid:13375  task_flags:0x400040 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5295 [inline]
>  __schedule+0x1585/0x5340 kernel/sched/core.c:6907
>  __schedule_loop kernel/sched/core.c:6989 [inline]
>  schedule+0x164/0x360 kernel/sched/core.c:7004
>  schedule_timeout+0xc3/0x2c0 kernel/time/sleep_timeout.c:75
>  do_wait_for_common kernel/sched/completion.c:100 [inline]
>  __wait_for_common kernel/sched/completion.c:121 [inline]
>  wait_for_common kernel/sched/completion.c:132 [inline]
>  wait_for_completion+0x2cc/0x5e0 kernel/sched/completion.c:153
>  restrict_one_thread security/landlock/tsync.c:128 [inline]
>  restrict_one_thread_callback+0x320/0x570 security/landlock/tsync.c:162

Seems to be related to landlock security module.
Cc'ing maintainers for awareness.

Thanks.

>  task_work_run+0x1d9/0x270 kernel/task_work.c:233
>  get_signal+0x11eb/0x1330 kernel/signal.c:2807
>  arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
>  exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
>  do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8d7f19bf79
> RSP: 002b:00007ffe0b192a38 EFLAGS: 00000246 ORIG_RAX: 00000000000000db
> RAX: fffffffffffffdfc RBX: 00000000000389f1 RCX: 00007f8d7f19bf79
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f8d7f41618c
> RBP: 0000000000000032 R08: 3fffffffffffffff R09: 0000000000000000
> R10: 00007ffe0b192b40 R11: 0000000000000246 R12: 00007ffe0b192b60
> R13: 00007f8d7f41618c R14: 0000000000038a23 R15: 00007ffe0b192b40
>  </TASK>
> INFO: task syz.0.2812:14644 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.2812      state:D stack:28216 pid:14644 tgid:14643 ppid:13375  task_flags:0x400040 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5295 [inline]
>  __schedule+0x1585/0x5340 kernel/sched/core.c:6907
>  __schedule_loop kernel/sched/core.c:6989 [inline]
>  schedule+0x164/0x360 kernel/sched/core.c:7004
>  schedule_timeout+0xc3/0x2c0 kernel/time/sleep_timeout.c:75
>  do_wait_for_common kernel/sched/completion.c:100 [inline]
>  __wait_for_common kernel/sched/completion.c:121 [inline]
>  wait_for_common kernel/sched/completion.c:132 [inline]
>  wait_for_completion+0x2cc/0x5e0 kernel/sched/completion.c:153
>  restrict_one_thread security/landlock/tsync.c:128 [inline]
>  restrict_one_thread_callback+0x320/0x570 security/landlock/tsync.c:162
>  task_work_run+0x1d9/0x270 kernel/task_work.c:233
>  get_signal+0x11eb/0x1330 kernel/signal.c:2807
>  arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
>  exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
>  do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8d7f19bf79
> RSP: 002b:00007f8d8007c0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007f8d7f415fa8 RCX: 00007f8d7f19bf79
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f8d7f415fa8
> RBP: 00007f8d7f415fa0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f8d7f416038 R14: 00007ffe0b1927f0 R15: 00007ffe0b1928d8
>  </TASK>
> INFO: task syz.0.2812:14645 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.2812      state:D stack:28648 pid:14645 tgid:14643 ppid:13375  task_flags:0x400140 flags:0x00080006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5295 [inline]
>  __schedule+0x1585/0x5340 kernel/sched/core.c:6907
>  __schedule_loop kernel/sched/core.c:6989 [inline]
>  schedule+0x164/0x360 kernel/sched/core.c:7004
>  schedule_timeout+0xc3/0x2c0 kernel/time/sleep_timeout.c:75
>  do_wait_for_common kernel/sched/completion.c:100 [inline]
>  __wait_for_common kernel/sched/completion.c:121 [inline]
>  wait_for_common kernel/sched/completion.c:132 [inline]
>  wait_for_completion+0x2cc/0x5e0 kernel/sched/completion.c:153
>  landlock_restrict_sibling_threads+0xe9c/0x11f0 security/landlock/tsync.c:539
>  __do_sys_landlock_restrict_self security/landlock/syscalls.c:574 [inline]
>  __se_sys_landlock_restrict_self+0x540/0x810 security/landlock/syscalls.c:482
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8d7f19bf79
> RSP: 002b:00007f8d8005b028 EFLAGS: 00000246 ORIG_RAX: 00000000000001be
> RAX: ffffffffffffffda RBX: 00007f8d7f416090 RCX: 00007f8d7f19bf79
> RDX: 0000000000000000 RSI: 000000000000000e RDI: 0000000000000003
> RBP: 00007f8d7f2327e0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f8d7f416128 R14: 00007f8d7f416090 R15: 00007ffe0b1928d8
>  </TASK>
> INFO: task syz.0.2812:14646 blocked for more than 144 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.2812      state:D stack:28832 pid:14646 tgid:14643 ppid:13375  task_flags:0x400140 flags:0x00080006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5295 [inline]
>  __schedule+0x1585/0x5340 kernel/sched/core.c:6907
>  __schedule_loop kernel/sched/core.c:6989 [inline]
>  schedule+0x164/0x360 kernel/sched/core.c:7004
>  schedule_timeout+0xc3/0x2c0 kernel/time/sleep_timeout.c:75
>  do_wait_for_common kernel/sched/completion.c:100 [inline]
>  __wait_for_common kernel/sched/completion.c:121 [inline]
>  wait_for_common kernel/sched/completion.c:132 [inline]
>  wait_for_completion+0x2cc/0x5e0 kernel/sched/completion.c:153
>  landlock_restrict_sibling_threads+0xe9c/0x11f0 security/landlock/tsync.c:539
>  __do_sys_landlock_restrict_self security/landlock/syscalls.c:574 [inline]
>  __se_sys_landlock_restrict_self+0x540/0x810 security/landlock/syscalls.c:482
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8d7f19bf79
> RSP: 002b:00007f8d8003a028 EFLAGS: 00000246 ORIG_RAX: 00000000000001be
> RAX: ffffffffffffffda RBX: 00007f8d7f416180 RCX: 00007f8d7f19bf79
> RDX: 0000000000000000 RSI: 000000000000000e RDI: 0000000000000003
> RBP: 00007f8d7f2327e0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f8d7f416218 R14: 00007f8d7f416180 R15: 00007ffe0b1928d8
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/31:
>  #0: ffffffff8e9602e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
>  #0: ffffffff8e9602e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
>  #0: ffffffff8e9602e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
> 2 locks held by getty/5581:
>  #0: ffff8880328890a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13c0 drivers/tty/n_tty.c:2211
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
>  __sys_info lib/sys_info.c:157 [inline]
>  sys_info+0x135/0x170 lib/sys_info.c:165
>  check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
>  watchdog+0xfd9/0x1030 kernel/hung_task.c:515
>  kthread+0x388/0x470 kernel/kthread.c:467
>  ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 86 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
> Workqueue: events_unbound nsim_dev_trap_report_work
> RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:26 [inline]
> RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:109 [inline]
> RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:127 [inline]
> RIP: 0010:lock_acquire+0xab/0x2e0 kernel/locking/lockdep.c:5864
> Code: 84 c1 00 00 00 65 8b 05 73 b8 9f 11 85 c0 0f 85 b2 00 00 00 65 48 8b 05 bb 72 9f 11 83 b8 14 0b 00 00 00 0f 85 9d 00 00 00 9c <5b> fa 48 c7 c7 8f a1 02 8e e8 57 40 17 0a 65 ff 05 40 b8 9f 11 45
> RSP: 0018:ffffc9000260f498 EFLAGS: 00000246
> RAX: ffff88801df81e40 RBX: ffffffff818f9166 RCX: 0000000080000002
> RDX: 0000000000000000 RSI: ffffffff8176da62 RDI: 1ffffffff1d2c05c
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffc9000260f638 R11: ffffffff81b11580 R12: 0000000000000002
> R13: ffffffff8e9602e0 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88812510b000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe09b2c1ff8 CR3: 000000000e74c000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
>  rcu_read_lock include/linux/rcupdate.h:850 [inline]
>  class_rcu_constructor include/linux/rcupdate.h:1193 [inline]
>  unwind_next_frame+0xc2/0x23c0 arch/x86/kernel/unwind_orc.c:495
>  arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
>  stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  unpoison_slab_object mm/kasan/common.c:340 [inline]
>  __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
>  kasan_slab_alloc include/linux/kasan.h:253 [inline]
>  slab_post_alloc_hook mm/slub.c:4501 [inline]
>  slab_alloc_node mm/slub.c:4830 [inline]
>  kmem_cache_alloc_node_noprof+0x384/0x690 mm/slub.c:4882
>  __alloc_skb+0x1d0/0x7d0 net/core/skbuff.c:702
>  alloc_skb include/linux/skbuff.h:1383 [inline]
>  nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:819 [inline]
>  nsim_dev_trap_report drivers/net/netdevsim/dev.c:876 [inline]
>  nsim_dev_trap_report_work+0x29a/0xb80 drivers/net/netdevsim/dev.c:922
>  process_one_work+0x949/0x1650 kernel/workqueue.c:3279
>  process_scheduled_works kernel/workqueue.c:3362 [inline]
>  worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
>  kthread+0x388/0x470 kernel/kthread.c:467
>  ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

-- 
Frederic Weisbecker
SUSE Labs
