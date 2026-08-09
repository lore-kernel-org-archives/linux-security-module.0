Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DAB1E1E16
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786234832; cv=none; b=tSeqqTUNt16PTRnK5Cd2o4kLhfImlq15g30PNZZ+9V5TtCOBBYYP3a6eU2/ipWnhJ9RluTpIwpL9GlTb10Ggnlz97YyLjuwYsTsgDJGJ9bGaRcwexRqvez4zFYKSn63D1uP/dXVXBnDuYmgE6KhwL4uJflJ+rNfo5Fai9JuN76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786234832; c=relaxed/simple;
	bh=ivoXILn/bOVVyrdWZIYuW9j3P76rlsgPYTO2OZY+LFg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hW1Z1UgluuZd+MyhAuhtE/tFIu7aM826nYPX8tHXOkcyj/gmbf9p+L46uAS7rfhR929Nj5KkIFw/9uoRfzwtfhHqvDABOTk3//GWcQEaM3ZPk3dMeSesfUpIFmjhulNXmcoTQ9Aq7UM3bB4WVwyjEcKGG6mYu7UeyUFyBr4JH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4ab4ca7ce3fso578410b6e.0
        for <linux-security-module@vger.kernel.org>; Sat, 08 Aug 2026 17:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786234829; x=1786839629;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfypjNMIaYwwS17MrECqzmvkWAUZkC8M/oY73fQWl0U=;
        b=Hq64U8ZjA8e+b1NuEVeq3UQ/nUn69xaxYui6yaLo6wvjrjcSBMDOQmgvhOyaKvRzej
         1J7PeS/MuWVrtP89V6iLzG/4o3X4H22Iikh/zdOL8dUUiPBrFe9CIF25GqSy1B6SbrKz
         BcnhBGJXbbKHY8VKtz9LgUztE07Nr+NDuq+ZYTvShfJaCW//POr2ouXxATKDMmuI5g6s
         OpstysZ4pigv2SyAb+vBH5MO3m/FkoKVZRWJi1pi5m9P6PMYp1ejzADzSxf7nitDNDrP
         PQNLTBLC0Cx7b3dUn0ldxK85lJY6u6mt2gZc0nSFBWtpFMBZ1SSoeriJgMS9v5OFJXtl
         uXwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnTbNjTrbrqJT8pRVnybKBKXmcKbW+FBuGPEY+FBsz5mqaOJosauxhgzoUxlZ/Ea95XeS8GlJVxpb2cSNFSlCUyg0xQKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBtsqmdjHTSR52JXDsmBd0qvWf6tfGbTbT8dAj7+uM/pW7Exv
	R7It/LQz2FfB5Spy/OQ/sayV/m5msgCXQQxwPlYc1WTrPrW1WNbvadzm3g7gCFENOGl7u6ZLCti
	k3cdIS6uv/UwFmPKKQ/u29GK/q4e3UTl027QHeD9YegF1ySST8KLppybwKXc=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3508:b0:495:f8a6:81f8 with SMTP id
 5614622812f47-4afae0db125mr18192441b6e.13.1786234829031; Sat, 08 Aug 2026
 17:20:29 -0700 (PDT)
Date: Sat, 08 Aug 2026 17:20:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a77c7cd.b50370da.49fe0.0031.GAE@google.com>
Subject: [syzbot] [lsm?] [integrity?] possible deadlock in ima_file_truncate
From: syzbot <syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113c53b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=448c2e24b1ceff13ed2a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7fd/disk-c21bb419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/vmlinux-c21bb419.xz
kernel image: https://storage.googleapis.com/syzbot-assets/283184100427/bzImage-c21bb419.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.3.857/8643 is trying to acquire lock:
ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:697 [inline]
ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_file_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723

but task is already holding lock:
ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: do_open fs/namei.c:4693 [inline]
ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: path_openat+0x2929/0x4280 fs/namei.c:4863

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (sb_writers#6){.+.+}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write include/linux/fs/super.h:125 [inline]
       mnt_want_write+0x6f/0x410 fs/namespace.c:494
       open_last_lookups fs/namei.c:4597 [inline]
       path_openat+0xad9/0x4280 fs/namei.c:4860
       do_file_open+0x20e/0x430 fs/namei.c:4892
       file_open_name+0x1c3/0x3e0 fs/open.c:1326
       filp_open+0x2e/0x50 fs/open.c:1343
       nvmet_file_ns_enable+0x95/0x420 drivers/nvme/target/io-cmd-file.c:41
       nvmet_ns_enable+0x35f/0x5d0 drivers/nvme/target/core.c:596
       nvmet_ns_enable_store+0x11e/0x160 drivers/nvme/target/configfs.c:735
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&subsys->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       nvmet_ns_device_path_store+0x57/0x1c0 drivers/nvme/target/configfs.c:536
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&p->frag_sem){.+.+}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       fill_read_buffer fs/configfs/file.c:66 [inline]
       configfs_read_iter+0x346/0x6f0 fs/configfs/file.c:88
       __kernel_read+0x397/0xad0 fs/read_write.c:532
       integrity_kernel_read+0x7e/0xb0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm+0x25e/0x350 security/integrity/ima/ima_crypto.c:222
       ima_calc_file_hash+0x1e3/0x380 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x94f/0xb30 security/integrity/ima/ima_api.c:300
       process_measurement+0xdfe/0x2350 security/integrity/ima/ima_main.c:425
       ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xc4/0x210 security/security.c:2755
       do_open fs/namei.c:4702 [inline]
       path_openat+0x985/0x4280 fs/namei.c:4863
       do_file_open+0x20e/0x430 fs/namei.c:4892
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&buffer->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       configfs_read_iter+0x79/0x6f0 fs/configfs/file.c:86
       __kernel_read+0x397/0xad0 fs/read_write.c:532
       integrity_kernel_read+0x7e/0xb0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm+0x25e/0x350 security/integrity/ima/ima_crypto.c:222
       ima_calc_file_hash+0x1e3/0x380 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x94f/0xb30 security/integrity/ima/ima_api.c:300
       process_measurement+0xdfe/0x2350 security/integrity/ima/ima_main.c:425
       ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xc4/0x210 security/security.c:2755
       do_open fs/namei.c:4702 [inline]
       path_openat+0x985/0x4280 fs/namei.c:4863
       do_file_open+0x20e/0x430 fs/namei.c:4892
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
       ima_reset_action_flags security/integrity/ima/ima_main.c:697 [inline]
       ima_file_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723
       security_file_truncate+0xf9/0x1e0 security/security.c:2771
       handle_truncate fs/namei.c:4303 [inline]
       do_open fs/namei.c:4704 [inline]
       path_openat+0x3584/0x4280 fs/namei.c:4863
       do_file_open+0x20e/0x430 fs/namei.c:4892
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ima_iint_mutex_key[depth] --> &subsys->lock --> sb_writers#6

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#6);
                               lock(&subsys->lock);
                               lock(sb_writers#6);
  lock(&ima_iint_mutex_key[depth]);

 *** DEADLOCK ***

1 lock held by syz.3.857/8643:
 #0: ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: do_open fs/namei.c:4693 [inline]
 #0: ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: path_openat+0x2929/0x4280 fs/namei.c:4863

stack backtrace:
CPU: 1 UID: 0 PID: 8643 Comm: syz.3.857 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
 ima_reset_action_flags security/integrity/ima/ima_main.c:697 [inline]
 ima_file_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723
 security_file_truncate+0xf9/0x1e0 security/security.c:2771
 handle_truncate fs/namei.c:4303 [inline]
 do_open fs/namei.c:4704 [inline]
 path_openat+0x3584/0x4280 fs/namei.c:4863
 do_file_open+0x20e/0x430 fs/namei.c:4892
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e7519e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e7611c028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f3e75426090 RCX: 00007f3e7519e0d9
RDX: 0000000000162e02 RSI: 0000200000000080 RDI: ffffffffffffff9c
RBP: 00007f3e75235024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3e75426128 R14: 00007f3e75426090 R15: 00007ffc1113bee8
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
