Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD13B42FD
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422678; cv=none; b=lA1LK3pcPkoq5/W/9WY98+Qzo8/W8OP/K1L9P4TrzBKFTaMYgf2BNlGJw6fCyw8NlCdZRUnHzXQxevxRCX8zHRORemjgI6T9lg0CSxZeABRhGCQi+zYV2cAzR8E3uROlnN4Bo6TO7i7VVXGrgSNKBLcmSVeyLWGY8U2IGUxlNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422678; c=relaxed/simple;
	bh=/cU/rXoqPmij/0icEQ/WL6PzuBlibn1NvZix5YNhZnM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OCGM/wJWkg7l/tQ2E1Bi3BkcPGje/1nIyxShuiuvnxPji8w/eRmHX+u1DSxBDOobOkomFAxmgQfFX653Y4EXh+7Wh131rxLHBRIM5594S702n92GMSGI85J6IJwSfCTRMjRyHz7f1iI6/JqmGkV7Y6EUIk0AWWnenivS64ZET5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6b34e02c466so769947eaf.1
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 01:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422675; x=1789027475;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EdIlJpPWXX+y9INBx3cKuIwPRg7+iB8XVRejihaUQ1A=;
        b=Al7UqYwhe2i4QA0Cd3+kargpnO4RlHx2hglO5Bwqk0Kmj/7WMbxQz9YN2cYwPDj+/z
         yy1wKERDa8V5OfuPRIdzpqCTnaRTmR23WQIYEWsoUie3j1maWi0wL1HHNZeC2uuIYD6i
         eVeZJgTO9hGQu6+VaIUGx9IeUfsF1lgV6Ane1KIT8Hy0tx95adcsHBB2DR2sTKZHy+aw
         nLLWMK4nrYAuRvvqRU7QeP2UTdWJFgwuGR+6m1b7xF4K6KZDdkyF5bL3msfsPrkGwF7f
         qpAcp3n+5J5eNb0dXiLYy1C+6c0BmCkos8oI8wn961jBCttyovW2Mx+LWc59Jx/lyFyX
         9UAw==
X-Forwarded-Encrypted: i=1; AKwUvBxODTj2pBNMVOPFenTe+2DxVt1pqLekNuPrT8tYHzOA2S4g1otk0QtFPTVRNI1hTOjU+73ktWcn3C45CWlDSkXXatiHAds=@vger.kernel.org
X-Gm-Message-State: AFuF++lpF2vwVcKcL98HsrDf621JZbUaUJgan1SLeFo+L8QyKZf1Ziis
	jlGK8Bjt9p1W3/Q49n0KcdQtTbIjKlKSPdRuVAMrCywG3MWV3Or/0+EYwCe56wsN1WGeHkPTUAp
	/aGYSmgIY1KBbSL66UrvVYslrVNfEU/ctBNIUpH6ymLPiwhMbmxntMzmudsY=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e90a:0:b0:6b4:117e:53a with SMTP id
 006d021491bc7-6b58679127dmr2800558eaf.20.1788422675173; Thu, 03 Sep 2026
 01:04:35 -0700 (PDT)
Date: Thu, 03 Sep 2026 01:04:35 -0700
In-Reply-To: <6a698f41.d9e86bb5.297b12.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a992a13.f03f19fe.169578.0004.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in configfs_read_iter
From: syzbot <syzbot+d2085ac2d653b9e383e2@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    940de590b839 Merge tag 'hardening-v7.3-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164270f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=d2085ac2d653b9e383e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e850f9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114270f9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-940de590.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64f87fb4f049/vmlinux-940de590.xz
kernel image: https://storage.googleapis.com/syzbot-assets/917bd28bbd2d/bzImage-940de590.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2085ac2d653b9e383e2@syzkaller.appspotmail.com

nvmet: adding nsid 1 to subsystem testsubsys
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/5927 is trying to acquire lock:
ffff88802cf0e080 (&buffer->mutex){+.+.}-{4:4}, at: configfs_read_iter+0x79/0x6f0 fs/configfs/file.c:86

but task is already holding lock:
ffff88802405fe48 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319
       ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xc4/0x210 security/security.c:2755
       do_open fs/namei.c:4839 [inline]
       path_openat+0x5cd/0x2440 fs/namei.c:5000
       do_file_open+0x20e/0x430 fs/namei.c:5029
       file_open_name+0x1c3/0x3e0 fs/open.c:1375
       filp_open+0x2e/0x50 fs/open.c:1392
       nvmet_file_ns_enable+0x95/0x420 drivers/nvme/target/io-cmd-file.c:41
       nvmet_ns_enable+0x35f/0x5d0 drivers/nvme/target/core.c:596
       nvmet_ns_enable_store+0x11e/0x160 drivers/nvme/target/configfs.c:737
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&subsys->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       nvmet_ns_device_path_store+0x57/0x1c0 drivers/nvme/target/configfs.c:538
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&p->frag_sem){.+.+}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       flush_write_buffer fs/configfs/file.c:205 [inline]
       configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&buffer->mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
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
       do_open fs/namei.c:4839 [inline]
       path_openat+0x5cd/0x2440 fs/namei.c:5000
       do_file_open+0x20e/0x430 fs/namei.c:5029
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_openat fs/open.c:1439 [inline]
       __se_sys_openat fs/open.c:1434 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1434
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &buffer->mutex --> &subsys->lock --> &ima_iint_mutex_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ima_iint_mutex_key[depth]);
                               lock(&subsys->lock);
                               lock(&ima_iint_mutex_key[depth]);
  lock(&buffer->mutex);

 *** DEADLOCK ***

locks held by syz.0.17/5927: 1, last CPU#3:
 #0: ffff88802405fe48 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319

stack backtrace:
CPU: 3 UID: 0 PID: 5927 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2059
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2191
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
 lock_acquire kernel/locking/lockdep.c:5908 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
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
 do_open fs/namei.c:4839 [inline]
 path_openat+0x5cd/0x2440 fs/namei.c:5000
 do_file_open+0x20e/0x430 fs/namei.c:5029
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f57f139e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd81407e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f57f1625fa0 RCX: 00007f57f139e159
RDX: 0000000000000002 RSI: 0000200000000240 RDI: ffffffffffffff9c
RBP: 00007f57f1435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f57f1625fac R14: 00007f57f1625fa0 R15: 00007f57f1625fa0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
