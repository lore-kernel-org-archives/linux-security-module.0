Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3846AF21
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084891; cv=none; b=Jg+vwJnoaM3Sd8fcreYij+lqEgDAZfhO9OBQ0TQg8jKfm8noRFrEHh6N38djADT4CL3wiB9jUYqOzl4w056zWkjIunYOi/57cGX0eMBlsdOs6htWVi6J1ocJ22B4dix4d5yXB6BxmX2fbvYbXeGRDdAWYgkQxnKQYIr94kqFYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084891; c=relaxed/simple;
	bh=XOorCn3CmkJYCFVz9vZieIMlrLw1oDb0DwARxVrsZLU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qwMB3jsJZotAOXUkBKbdsPcevkprDsff8zbauqHGda42i6rpUjZs6Akgnbh5uHS6BDrXxshCgp19mYsDVO7SfA4ntqBYaw8C5qyllL0LMOh1QO0YzXZb3WccYDI9+9FvPd3Da5bi4aSPZZvjNQ2u69NIkImgoEqMb8rPtlO6Vms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4859b1525c7so6003652b6e.2
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084888; x=1780689688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/dgYb5MRzQ4YT9WvLkhzPkNeBW2jJE3smZaS9ham44=;
        b=K4uv8HlZ12AjGp2J3GLIgSdjPRoyHgkYxzssp0U9jqWm8SoL1Ajzp60jGauMpVTnZJ
         7IRJ0iIL1j1mZ3RcRWVXjbXwWHDBRsY/M03dDPpHuFo0+NsT9tQ8FqjgfNpCiSpw4WlM
         qdNalqF8ctziYHKPjJ5uhK9gzMDt9+qsDKXG+VlvzUChPibYza1/gnVdT+nGO+gi5XWO
         R35iTCJKtYJ0NNCBq6/RbaRiQD0NAsps0R30XIs0wiNI0YcQg9w7LbKeI1JaJa9gOdM2
         sK9QyLzTTf1DpOmJU2AWG6mpbLzTjck8UtSAfNTw1TiMQqF2f1EP0wcW+olF72tHWkRj
         LXmQ==
X-Forwarded-Encrypted: i=1; AFNElJ91fisnrjmT+k/a4n9KGUGQr61F5pj3xcx3EWbXLUFupTKLFbq75+ln392I3u+tfZpuZoFGrfgeJ/nEDk4nOz9R202HzO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIpw2Assh7gu46Mr+MUilHQBbfqe7eMxXjYzIvD8RQKCkkfRR
	w3J+KQsdRbKdpL4sZEEhC42q4rlTCy8HEmSkZULQLhndjpUzi/k9aTPbaF1RUCQs5STQf5SR7qV
	4xNf+0AEaDIbP0lhsRX8MLkli0kw9esAEyesG7r6kGf5T/ImET1LZY76hhlM=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1587:b0:46a:c98c:bfe9 with SMTP id
 5614622812f47-485fbcff974mr442728b6e.40.1780084888519; Fri, 29 May 2026
 13:01:28 -0700 (PDT)
Date: Fri, 29 May 2026 13:01:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a19f098.abb04025.19af7b.0004.GAE@google.com>
Subject: [syzbot] [lsm?] KASAN: slab-use-after-free Read in security_inode_follow_link
From: syzbot <syzbot+0962e3a1af6d5e26a52c@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb3f4b7426cf Merge tag 'nfsd-7.1-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dae52e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8118209836970b54
dashboard link: https://syzkaller.appspot.com/bug?extid=0962e3a1af6d5e26a52c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14427ed2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109e452e580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-eb3f4b74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1406171f5cf6/vmlinux-eb3f4b74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19b8bb9b727a/bzImage-eb3f4b74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0962e3a1af6d5e26a52c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in security_inode_follow_link+0x277/0x280 security/security.c:1819
Read of size 4 at addr ffff8880393e0004 by task syz.0.594/8610

CPU: 3 UID: 0 PID: 8610 Comm: syz.0.594 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1d0 mm/kasan/report.c:595
 security_inode_follow_link+0x277/0x280 security/security.c:1819
 pick_link+0x433/0x13c0 fs/namei.c:2049
 step_into_slowpath+0x9ba/0xf90 fs/namei.c:2123
 step_into fs/namei.c:2148 [inline]
 walk_component fs/namei.c:2284 [inline]
 link_path_walk+0xf28/0x1cc0 fs/namei.c:2652
 path_parentat fs/namei.c:2856 [inline]
 __filename_parentat+0x213/0x740 fs/namei.c:2880
 filename_parentat fs/namei.c:2898 [inline]
 filename_unlinkat+0xf7/0x730 fs/namei.c:5537
 __do_sys_unlinkat fs/namei.c:5597 [inline]
 __se_sys_unlinkat fs/namei.c:5589 [inline]
 __x64_sys_unlinkat+0xc0/0x130 fs/namei.c:5589
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f60b0f9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f60b1dc9028 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007f60b1215fa0 RCX: 00007f60b0f9ce59
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000006
RBP: 00007f60b1032d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f60b1216038 R14: 00007f60b1215fa0 R15: 00007ffddfc81a28
 </TASK>

Allocated by task 8610:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 kmem_cache_alloc_lru_noprof+0x246/0x6e0 mm/slub.c:4918
 alloc_inode+0x183/0x250 fs/inode.c:347
 new_inode+0x22/0x1c0 fs/inode.c:1179
 bpf_get_inode kernel/bpf/inode.c:117 [inline]
 bpf_get_inode kernel/bpf/inode.c:102 [inline]
 bpf_symlink+0x69/0x240 kernel/bpf/inode.c:391
 vfs_symlink fs/namei.c:5643 [inline]
 vfs_symlink+0x178/0x4d0 fs/namei.c:5622
 filename_symlinkat+0x2a6/0x560 fs/namei.c:5668
 __do_sys_symlinkat fs/namei.c:5688 [inline]
 __se_sys_symlinkat fs/namei.c:5683 [inline]
 __x64_sys_symlinkat+0x9c/0xe0 fs/namei.c:5683
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8611:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kmem_cache_free+0x127/0x6c0 mm/slub.c:6378
 destroy_inode+0xcb/0x1c0 fs/inode.c:394
 evict+0x599/0xad0 fs/inode.c:865
 iput_final fs/inode.c:1960 [inline]
 iput.part.0+0x605/0xf50 fs/inode.c:2009
 iput+0x35/0x40 fs/inode.c:1975
 filename_unlinkat+0x466/0x730 fs/namei.c:5572
 __do_sys_unlinkat fs/namei.c:5597 [inline]
 __se_sys_unlinkat fs/namei.c:5589 [inline]
 __x64_sys_unlinkat+0xc0/0x130 fs/namei.c:5589
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880393e0000
 which belongs to the cache inode_cache of size 1088
The buggy address is located 4 bytes inside of
 freed 1088-byte region [ffff8880393e0000, ffff8880393e0440)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x393e0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88803ce9f201
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888100090000 dead000000000100 dead000000000122
raw: 0000000000000000 00000008001a001a 00000000f5000000 ffff88803ce9f201
head: 00fff00000000040 ffff888100090000 dead000000000100 dead000000000122
head: 0000000000000000 00000008001a001a 00000000f5000000 ffff88803ce9f201
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5753, tgid 5753 (syz-execprog), ts 103858448509, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x11a6/0x3410 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x27c/0x2bc0 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab mm/slub.c:3467 [inline]
 new_slab+0xa6/0x6c0 mm/slub.c:3525
 refill_objects+0x277/0x420 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x375/0x650 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 kmem_cache_alloc_lru_noprof+0x485/0x6e0 mm/slub.c:4918
 alloc_inode+0x183/0x250 fs/inode.c:347
 iget_locked+0x1d9/0x6d0 fs/inode.c:1474
 kernfs_get_inode+0x46/0x470 fs/kernfs/inode.c:252
 kernfs_iop_lookup+0x1a7/0x2d0 fs/kernfs/dir.c:1274
 lookup_open.isra.0+0x631/0x11b0 fs/namei.c:4484
 open_last_lookups fs/namei.c:4611 [inline]
 path_openat+0xa98/0x31a0 fs/namei.c:4855
 do_file_open+0x20e/0x430 fs/namei.c:4887
 do_sys_openat2+0x10d/0x1e0 fs/open.c:1364
 do_sys_open fs/open.c:1370 [inline]
 __do_sys_openat fs/open.c:1386 [inline]
 __se_sys_openat fs/open.c:1381 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1381
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880393dff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880393dff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880393e0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880393e0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880393e0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
