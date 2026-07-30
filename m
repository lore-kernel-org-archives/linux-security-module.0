Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810CA2E92BA
	for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370781; cv=none; b=A8oqgOzZIHPgn8PJ/YcyEUF1K390NnDBz1oXXeUaCNfB8eShitTP9ETqXfDHQOZtDRDJ/PHMqELkLovp4ASLrUaEhOc6WCi/2NuTdkJorZ0gUnTP/QoT6uCtgyGaiSN580/DDEVkfbhJiZfnGcYcnbizl1xvjbCeYmfk2+Dr+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370781; c=relaxed/simple;
	bh=ApugaKjy7Z3lOQC453BYpXWdbvZqX3dOB1LFO6Amc2s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=asdpXDuio5VhAEg4qUEQDfC62Z9TrCRI0vLY4u1PiQNJGXWq5yiB+9BgLfWichsrgVeh3RjbVm1YtR3XBGY8f+osi/C9K/WQQyy0rXeQeMLnoDAMJoqJL8TbmutOQrmJTYKsZRW2VpPeJlhtF8iZN0Qu574Ugk7YCM5DywS1cxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4a5a66f375dso803728b6e.1
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2026 17:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785370773; x=1785975573;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cq6Fz8pEp3yuvqZZItQIu6F1JfQ6LrRlopbikR2yVps=;
        b=TnTBPVQxyXj07MMSifoETMacDEXAgqxI2ueGIzSOnRfltqgFBQ1JiqpOoRh0S0Z7bD
         oEEFY13shXy+ZtZGm7HIBRsDaeCP0vCo/ohzqg0vPDDzNuSpBIdWo7zJ1Jt5efwEodGd
         Xut0tnFyOSwv8zkrIMBuiRhrDeazFECj3X+PJnFFeDdP2nHhBD7I+fHYLE1k/ObsIkFx
         aadpAH31AoqixqMV128hromVVKTWzdB/39655fs3nfSLSGfpWu/ACw/YiUsH98tbME82
         WhcG7YiijHH0iw7x3czMXhOsB3lLA+zuLbjdChTxqCEyrjl+MPxGP4I/Le0iVh5Gh2/U
         YjLw==
X-Forwarded-Encrypted: i=1; AHgh+RoHGBfty4Ee0jNGfLPHlXCLm0vSIZ0N1FHih+c+BNc4vqwfUqZtVn9WFN2jTqeaufXn5x9XU7gCvRLL+6U98qYnuV8eiH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOsLta4ZdlpKQTe4GPmiImwAKFvUCxtWB5GUFNVgSfuwp8PIf
	CTWNBICw4zmmxzWH02fjedGhRQLSVV6PqfIgVMGB6Jj8rdXwCcyrDMmjrrPTXJlhg1Avltc0pRA
	tHC6VdqXwImNj4jpGgS8p5EAXv3G7dnaXw8pVIAzVWrLtMN+4GHCE0tKrT2g=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:159a:b0:487:530f:5754 with SMTP id
 5614622812f47-4ad878c7c62mr335180b6e.20.1785370773046; Wed, 29 Jul 2026
 17:19:33 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:19:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6a9895.7eebbf3c.214d51.000d.GAE@google.com>
Subject: [syzbot] [integrity?] [lsm?] possible deadlock in process_measurement (6)
From: syzbot <syzbot+c0bfa7a9a227036e8454@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f5098b6bae76 Linux 7.2-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141ef2ea580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=c0bfa7a9a227036e8454
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f5098b6b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5cb9b4ace7bc/vmlinux-f5098b6b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b85acfa194b/bzImage-f5098b6b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0bfa7a9a227036e8454@syzkaller.appspotmail.com

i2c i2c-1: dtv_property_process_set: SET cmd 0x00000000 undefined
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.8.1213/10652 is trying to acquire lock:
ffff888012fc32f0 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319

but task is already holding lock:
ffff888034594920 (&common->filesem){++++}-{4:4}, at: fsg_store_file+0x193/0x450 drivers/usb/gadget/function/storage_common.c:452

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&common->filesem){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       fsg_show_file+0x20/0x180 drivers/usb/gadget/function/storage_common.c:339
       fill_read_buffer fs/configfs/file.c:68 [inline]
       configfs_read_iter+0x426/0x6f0 fs/configfs/file.c:88
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
       process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319
       ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xc4/0x210 security/security.c:2755
       do_open fs/namei.c:4702 [inline]
       path_openat+0x985/0x4280 fs/namei.c:4863
       do_file_open+0x20e/0x430 fs/namei.c:4892
       file_open_name+0x1c3/0x3e0 fs/open.c:1326
       filp_open+0x2e/0x50 fs/open.c:1343
       fsg_lun_open+0x6b/0x7b0 drivers/usb/gadget/function/storage_common.c:194
       fsg_store_file+0x1e7/0x450 drivers/usb/gadget/function/storage_common.c:455
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ima_iint_mutex_key[depth] --> &p->frag_sem --> &common->filesem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&common->filesem);
                               lock(&p->frag_sem);
                               lock(&common->filesem);
  lock(&ima_iint_mutex_key[depth]);

 *** DEADLOCK ***

5 locks held by syz.8.1213/10652:
 #0: ffff88802cc5c630 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff888023b3a450 (sb_writers#20){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff888023a0da80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x76/0x4e0 fs/configfs/file.c:226
 #3: ffff88802df78b70 (&p->frag_sem){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #3: ffff88802df78b70 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229
 #4: ffff888034594920 (&common->filesem){++++}-{4:4}, at: fsg_store_file+0x193/0x450 drivers/usb/gadget/function/storage_common.c:452

stack backtrace:
CPU: 2 UID: 0 PID: 10652 Comm: syz.8.1213 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
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
 process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319
 ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
 security_file_post_open+0xc4/0x210 security/security.c:2755
 do_open fs/namei.c:4702 [inline]
 path_openat+0x985/0x4280 fs/namei.c:4863
 do_file_open+0x20e/0x430 fs/namei.c:4892
 file_open_name+0x1c3/0x3e0 fs/open.c:1326
 filp_open+0x2e/0x50 fs/open.c:1343
 fsg_lun_open+0x6b/0x7b0 drivers/usb/gadget/function/storage_common.c:194
 fsg_store_file+0x1e7/0x450 drivers/usb/gadget/function/storage_common.c:455
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3ee959de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3eea385028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3ee9825fa0 RCX: 00007f3ee959de99
RDX: 0000000000000005 RSI: 0000200000000f00 RDI: 0000000000000005
RBP: 00007f3ee9633eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3ee9826038 R14: 00007f3ee9825fa0 R15: 00007ffd69933148
 </TASK>
mass_storage.usb0/lun.0: file too small: file0


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
