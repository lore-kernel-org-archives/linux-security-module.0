Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A81A2C21
	for <linux-security-module@vger.kernel.org>; Sat,  2 Nov 2024 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560879; cv=none; b=Ly3OOr45kHhDsUmF4l9UiPtmZlxI3Y2IlFZyR5hsrkDHu/vZ9JKjqNlvrEMWMxjKYkZooZ5pEJO+524MdQlsVr8wDLCIWV4e9B2TQauv23ED1SHVZTVQ5d4752gUU5baJT74iLJu1j1bWL46QEKJ6ziWnKGvTLvovKcuoM0Q854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560879; c=relaxed/simple;
	bh=TDJb0NpseC+P4YEb5y++bQupy6S5/ldU15mgJDlJsSU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r+b64vOVlxrE8Y55DS5hdgCAjrG+dKscrrnuDPS5yUSCsgsuEBZVsHaXQHcKeDcnaspk+SRSUzt9/0cXOYkN7cb6aaRd1cyjiHPttOtoPMdWOwIwOiJPOqqb8Hw+Z27JMOuxLKy2x3QtXwVif7WYNy6g0k1Ddft94vYtUI9wEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6c01d8df2so4081385ab.1
        for <linux-security-module@vger.kernel.org>; Sat, 02 Nov 2024 08:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730560877; x=1731165677;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mS1EZv8tKnHllK5w7UYrymDgh7QiAcoeNCY5a8WVYQ=;
        b=NXgbEYFqlZQbsiiAYmxLN3xsTG8n0GVytP0XOdyTi9e16Fa2NlyR3I/LhINmFpID39
         5VvXNa76lmECrKITHeVXNOncuxh/YVKP71sZkVNNnkiubV76vgAMjiwaZH5DqRov+VGS
         l1SrzH3DDhVrsMeu6ogADvaizzE04PY0Vf3OkO6psEIeGuAyc165dKOAJcwn1L8dUljZ
         Q2txdfE+EIVbBcbj/vHDUDeH+z15TlzDKQpacS03UPw+gP4zfso6JCmluTp00ZOKWKSO
         yqw8pjHDiaSlts7kBG1uE9m5gDPOT8nGnBPP9HY62PTtz4yFiBI4WM1p8l6dsYMvbPeN
         A36g==
X-Forwarded-Encrypted: i=1; AJvYcCWYqNYvORcgP5oKoDAopOZ4y7csgwh0ZrcsNR87lEZleOw3BB57cE5SWFJLVorqAawuvTMIghf5pBFGiOGTHrYDpfKMyfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvIvRbJs+9grwEwC6dO4mjZs1AEMpRFGTPicStUoWdcyY0hwz
	XHKjK6OVttRlS+YmZ8lvpfKSzV5l9Y3CN/1vC69thcVwDwfqSW19dOOSBGneJK0bwSSzarzmke4
	n5A+f2mUkGWZegZ1/wUY4RFYU+nEbIizbi2J6BrxK2W5jrzO2L6KQc/w=
X-Google-Smtp-Source: AGHT+IG5GYzTP8HGRo46WO7wFdGqLPgeubh8U11Q3Pr9laRvypwXf/fhMbbj8Uf8x/QIB/soke8tzpCb85UfVIMF0f9Ri4MWmBeC
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca5:b0:39f:5def:a23d with SMTP id
 e9e14a558f8ab-3a6afec7f93mr57509365ab.5.1730560877361; Sat, 02 Nov 2024
 08:21:17 -0700 (PDT)
Date: Sat, 02 Nov 2024 08:21:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6726436d.050a0220.529b6.02d2.GAE@google.com>
Subject: [syzbot] [integrity?] [lsm?] [erofs?] INFO: task hung in
 ima_file_free (4)
From: syzbot <syzbot+8036326eebe7d0140944@syzkaller.appspotmail.com>
To: chao@kernel.org, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, linux-erofs@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e42b1a9a2557 Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150d4a30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15901ca7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fc815f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e42b1a9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e2253169da8/vmlinux-e42b1a9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9d2f5008f24/bzImage-e42b1a9a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bc2284f99b09/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8036326eebe7d0140944@syzkaller.appspotmail.com

INFO: task syz-executor688:5342 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor688 state:D stack:25920 pid:5342  tgid:5342  ppid:5339   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x18af/0x4bd0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 ima_check_last_writer security/integrity/ima/ima_main.c:166 [inline]
 ima_file_free+0x17f/0x4d0 security/integrity/ima/ima_main.c:205
 security_file_release+0x92/0x140 security/security.c:2873
 __fput+0x1ae/0x880 fs/file_table.c:425
 __do_sys_close fs/open.c:1567 [inline]
 __se_sys_close fs/open.c:1552 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1552
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd7dd29cdda
RSP: 002b:00007ffd572b6bd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fd7dd29cdda
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000032 R08: 0000000000000000 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fd7dd32560c
R13: 0000000000000009 R14: 0000000000040e1f R15: 0000000000040e51
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
2 locks held by getty/5108:
 #0: ffff88801fa510a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor688/5342:
 #0: ffff88803f594398 (&ima_iint_mutex_key[depth]#2){+.+.}-{3:3}, at: ima_check_last_writer security/integrity/ima/ima_main.c:166 [inline]
 #0: ffff88803f594398 (&ima_iint_mutex_key[depth]#2){+.+.}-{3:3}, at: ima_file_free+0x17f/0x4d0 security/integrity/ima/ima_main.c:205
1 lock held by syz-executor688/5343:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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
