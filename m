Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78834BA5C
	for <linux-security-module@vger.kernel.org>; Tue,  7 Oct 2025 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856920; cv=none; b=IC9h6QWkJaabojmnnpZOXmLhb/9AIr132p8wclhQor6V8PcMGaR5qHNWXvLtN4BiePxbp5Uhy10f8G0Z7t+FyaR37RQs2KxDsZOrLI1TUB0Ab7M0PPd+S+uCb9bEHnrLyHgWr0PjkMRcLqTe2PnRSuTIX9gG9fel1SYs5n3cfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856920; c=relaxed/simple;
	bh=mHg/lcZAg4bzBvAsvRX//PP45eEWLaRFZOv7QncEwsA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EaFzChysMiviueoi9WzkOhSaZ2Geiu/vjrnLGN5BLavdwRUt6BTwfGj6HLl179WRKofKm4txy/ju8zdJbGJrntW067m0bTJPbj7i90gNvMgb/F97Meumd9Tn4B9UEkmG7SLu+syUNRwZRoPpx122aRcTvazfZvwaewQzd6CyamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42f6639fb22so48630715ab.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Oct 2025 10:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759856918; x=1760461718;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwaF+8wKesGhhLt3G48mndVQcMV9tkM5le1+HU/JbcA=;
        b=h84U9EfwRQBm5t734ieYxiwct2RjnRMWXpr2HcFDX9oi6R+EchsnkZ3ZEBbE9ONNLO
         75Nn/4nFSt2/AWXT0zJ8wUb5ZKychDCpDRyR4sutyhDVb/6wQ3hBk3cdoKyyefeBsBQI
         g8jFUP4dKvTuIZ480NtzX3J/MG2DsqlyN9XsE+xXHHlGbaaj0bgLZLQ87IW1Ue5u3hxF
         8Wej1OsJDOnaHz0okoUZfJ3K3tAglJz6lXkgZzO14Bg/VZaDYkBR953iU2U647HBtS86
         /p0hZH0EMEFdzvkfDiERhgJbR6mdF0CWtr/M0RUgFs5l8nyIL9XDfpCuEokVXhnOKwUA
         ebjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4NedxCLqSpxK4B/y3Ds7q6wXHWGKkbgPfoBiUzu7wYjU0EvsHZxhJpxb9gN8K8cSQBKkjPlrq7KkIqCegMaMCJHNQsYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpQZzffLlXzghsJkcMZWldPlNZfJX37DRS2RWj1ydTRzSwM24
	qBTyY4YIk0U1AKRQ2Dcrj2ufSDtZGdZrxsewtcNLb9FEXJFy2xg34p75i1KYappH0mdg8e5xz/S
	J7Tec9xbtrBzJHcER0O8RCkLa/LpGxdZmH/NYbXTI2qIzEhVr02kica/DPow=
X-Google-Smtp-Source: AGHT+IGKGADES496kPG8zXKUj/TDnmWONV9xl4qZNsngOapTD95ggxb+DmOPtYvK4j1mzIr7rD8U2KI4LYQ4sERHbplE99f+QKeV
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2704:b0:42e:712e:528c with SMTP id
 e9e14a558f8ab-42f873df5bamr852345ab.19.1759856917663; Tue, 07 Oct 2025
 10:08:37 -0700 (PDT)
Date: Tue, 07 Oct 2025 10:08:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e54915.a00a0220.298cc0.0480.GAE@google.com>
Subject: [syzbot] [keyrings?] [lsm?] possible deadlock in keyring_clear (3)
From: syzbot <syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cbf33b8e0b36 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1036c458580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b4263e12240e6e1
dashboard link: https://syzkaller.appspot.com/bug?extid=f55b043dacf43776b50c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cbf33b8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54786e46ef23/vmlinux-cbf33b8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd6f88ce083b/bzImage-cbf33b8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/74 is trying to acquire lock:
ffff8880420f4098 (&type->lock_class){+.+.}-{4:4}, at: keyring_clear+0xaf/0x240 security/keys/keyring.c:1658

but task is already holding lock:
ffffffff8de44f40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:7015 [inline]
ffffffff8de44f40 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x951/0x2800 mm/vmscan.c:7389

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4897 [inline]
       slab_alloc_node mm/slub.c:5221 [inline]
       __kmalloc_cache_noprof+0x40/0x6f0 mm/slub.c:5719
       kmalloc_noprof include/linux/slab.h:957 [inline]
       kzalloc_noprof include/linux/slab.h:1094 [inline]
       assoc_array_insert+0x92/0x2f90 lib/assoc_array.c:980
       __key_link_begin+0xd6/0x1f0 security/keys/keyring.c:1317
       __key_create_or_update+0x41a/0xa30 security/keys/key.c:877
       key_create_or_update+0x42/0x60 security/keys/key.c:1021
       x509_load_certificate_list+0x145/0x280 crypto/asymmetric_keys/x509_loader.c:31
       do_one_initcall+0x233/0x820 init/main.c:1283
       do_initcall_level+0x104/0x190 init/main.c:1345
       do_initcalls+0x59/0xa0 init/main.c:1361
       kernel_init_freeable+0x334/0x4b0 init/main.c:1593
       kernel_init+0x1d/0x1d0 init/main.c:1483
       ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&type->lock_class){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       keyring_clear+0xaf/0x240 security/keys/keyring.c:1658
       fscrypt_put_master_key+0xca/0x190 fs/crypto/keyring.c:80
       put_crypt_info+0x26d/0x310 fs/crypto/keysetup.c:573
       fscrypt_put_encryption_info+0xf6/0x140 fs/crypto/keysetup.c:787
       ext4_clear_inode+0x170/0x2f0 fs/ext4/super.c:1527
       ext4_evict_inode+0xa67/0xee0 fs/ext4/inode.c:321
       evict+0x504/0x9c0 fs/inode.c:810
       dispose_list fs/inode.c:852 [inline]
       prune_icache_sb+0x21b/0x2c0 fs/inode.c:1000
       super_cache_scan+0x39b/0x4b0 fs/super.c:224
       do_shrink_slab+0x6ef/0x1110 mm/shrinker.c:437
       shrink_slab_memcg mm/shrinker.c:550 [inline]
       shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
       shrink_one+0x28a/0x7c0 mm/vmscan.c:4955
       shrink_many mm/vmscan.c:5016 [inline]
       lru_gen_shrink_node mm/vmscan.c:5094 [inline]
       shrink_node+0x315d/0x3780 mm/vmscan.c:6081
       kswapd_shrink_node mm/vmscan.c:6941 [inline]
       balance_pgdat mm/vmscan.c:7124 [inline]
       kswapd+0x147c/0x2800 mm/vmscan.c:7389
       kthread+0x70e/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&type->lock_class);
                               lock(fs_reclaim);
  lock(&type->lock_class);

 *** DEADLOCK ***

2 locks held by kswapd0/74:
 #0: ffffffff8de44f40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:7015 [inline]
 #0: ffffffff8de44f40 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x951/0x2800 mm/vmscan.c:7389
 #1: ffff8880115840e0 (&type->s_umount_key#31){++++}-{4:4}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff8880115840e0 (&type->s_umount_key#31){++++}-{4:4}, at: super_cache_scan+0x91/0x4b0 fs/super.c:197

stack backtrace:
CPU: 0 UID: 0 PID: 74 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 keyring_clear+0xaf/0x240 security/keys/keyring.c:1658
 fscrypt_put_master_key+0xca/0x190 fs/crypto/keyring.c:80
 put_crypt_info+0x26d/0x310 fs/crypto/keysetup.c:573
 fscrypt_put_encryption_info+0xf6/0x140 fs/crypto/keysetup.c:787
 ext4_clear_inode+0x170/0x2f0 fs/ext4/super.c:1527
 ext4_evict_inode+0xa67/0xee0 fs/ext4/inode.c:321
 evict+0x504/0x9c0 fs/inode.c:810
 dispose_list fs/inode.c:852 [inline]
 prune_icache_sb+0x21b/0x2c0 fs/inode.c:1000
 super_cache_scan+0x39b/0x4b0 fs/super.c:224
 do_shrink_slab+0x6ef/0x1110 mm/shrinker.c:437
 shrink_slab_memcg mm/shrinker.c:550 [inline]
 shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
 shrink_one+0x28a/0x7c0 mm/vmscan.c:4955
 shrink_many mm/vmscan.c:5016 [inline]
 lru_gen_shrink_node mm/vmscan.c:5094 [inline]
 shrink_node+0x315d/0x3780 mm/vmscan.c:6081
 kswapd_shrink_node mm/vmscan.c:6941 [inline]
 balance_pgdat mm/vmscan.c:7124 [inline]
 kswapd+0x147c/0x2800 mm/vmscan.c:7389
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
