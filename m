Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ABC17965E
	for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841724; cv=none; b=R/bwN1CcwwdlHNyaa4JK5Q3vIg3nEtwy2/HStAe5/zA0pXBdTur+gz7ZNmkAf9ilp3jR0+qP/XO+LXLxKkLPo8Q0Qaba1NX2Ej1VbNlm7LpehE34Mcn3v0yC0lWsxxUQKdD9nFqHzSI8GZr+p8gk4bULhO9v1DCN8FOtABPq8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841724; c=relaxed/simple;
	bh=0TpcCaQVajKPKR1TF/gEeRguubkxiLLc8yBaD+3F+nk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tEbyQ5xz0OU92k59IIpJYDu+ZPoni60+fWcUPODTAPgMWOycKl1xofmpnPOiyKizOZ96KCun3pqXSPvVUqbhZkAhKPtYo3OP/xl4DANC173/ZwwkLyUuBtS5/KWUncBsN5J5aKaxYWicq0pZtLfenOWnB1O0OSzojy9InjnWwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0a71b7d90so25449825ab.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 07:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726841722; x=1727446522;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qp6XzQA56PDGgoKcNurhtHBaUeUoIvFh+7efyG07+u0=;
        b=dKopjiWMMA1LKF0uRj7+be1Z1Mkx+fodlZazn+6QIuuRmvD+OnFNcnxHPJ05257qSD
         8TNpQJBJlQW/bAHYtTS4WyoyawaeEJ1mH4oBfXW0jUC5hqqmnC7JRY4dfaHCcOZq8dH5
         iJ6higmt8/N/zAdfeK1ifOx0QUDZPHrB0w/Kd39IiEHJoMLq4JR1/gPDhnZu9y8QStTB
         yAYC2iRx+nWku43etfuQfNyck+XeHfMxj9MOtMe1hy6oNmdnFR9pyDteUF4ftCYERE1H
         aD9Kbe8FZ+yfpPseF2fKJZ95BH030wrh54ScrB0OUurOuzTOijHjPddrJwtniPHbySs6
         mRpA==
X-Forwarded-Encrypted: i=1; AJvYcCUdOWpteoQsev2C4SSoPQ3NTBSiKQN/p9mB96Ls9Br9YNYS89uztg4Mm0mqTPI7KDPd8bv0rkIJ/6Bu4cHuJgXUb8n+k7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLdo4Mme+KkeHpHFQZjfg8RfKvQJKwFp+tg3pp9mXKG61TW9P9
	UVA4xx7U7d3erbcD0dPPGrdZXDgI6p0oCTsdsSl7RxOi9YsJy7JsgcJqHZkpQS9bjqQmAyD77x9
	GxDWFgrv6SKVP4UP77x1X79xVvW5OB1tCQ63XKQSQlsJjPIhX6MW7lrY=
X-Google-Smtp-Source: AGHT+IHkaubN9p/hGCR9S0a+UxFlaGdi4oLmfYMQHgmEauQUyqz+gsZPfOS/DIllLQ/Lf4jjhm/YDegJ0oH8QEaabW6B9PzeXEAt
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:3a0:a385:9128 with SMTP id
 e9e14a558f8ab-3a0c9cf9163mr25882685ab.6.1726841722075; Fri, 20 Sep 2024
 07:15:22 -0700 (PDT)
Date: Fri, 20 Sep 2024 07:15:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed837a.050a0220.29194.0057.GAE@google.com>
Subject: [syzbot] [lsm?] KASAN: slab-use-after-free Read in smk_access
From: syzbot <syzbot+a95cf48b5daf4bb16c29@syzkaller.appspotmail.com>
To: casey@schaufler-ca.com, jmorris@namei.org, john.johansen@canonical.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10469d00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9ab5893ec5191eb
dashboard link: https://syzkaller.appspot.com/bug?extid=a95cf48b5daf4bb16c29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110e6a77980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10cee207980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c27c9d8c6782/disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73c62c975a0c/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/56164e51e333/bzImage-a430d95c.xz

The issue was bisected to:

commit 5f8d28f6d7d568dbbc8c5bce94894474c07afd4f
Author: Casey Schaufler <casey@schaufler-ca.com>
Date:   Wed Jul 10 21:32:26 2024 +0000

    lsm: infrastructure management of the key security blob

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10293fc7980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12293fc7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14293fc7980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a95cf48b5daf4bb16c29@syzkaller.appspotmail.com
Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key security blob")

==================================================================
BUG: KASAN: slab-out-of-bounds in smk_access+0xae/0x4e0 security/smack/smack_access.c:147
Read of size 8 at addr ffff8880202b03c0 by task syz-executor367/5216

CPU: 0 UID: 60928 PID: 5216 Comm: syz-executor367 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 smk_access+0xae/0x4e0 security/smack/smack_access.c:147
 smack_watch_key+0x2f4/0x3a0 security/smack/smack_lsm.c:4656
 security_watch_key+0x86/0x250 security/security.c:4448
 keyctl_watch_key+0x2b7/0x480 security/keys/keyctl.c:1813
 __do_sys_keyctl security/keys/keyctl.c:2021 [inline]
 __se_sys_keyctl+0x106/0xa50 security/keys/keyctl.c:1874
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbebbbc2fe9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbebbb74238 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
RAX: ffffffffffffffda RBX: 00007fbebbc463e8 RCX: 00007fbebbbc2fe9
RDX: 0000000000000004 RSI: 0000000016bf1cf5 RDI: 0000000000000020
RBP: 00007fbebbc463e0 R08: 0000000000000000 R09: 00007fbebbb746c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00676e697279656b
R13: 0000000000000002 R14: 00007ffe798160c0 R15: 00007ffe798161a8
 </TASK>

Allocated by task 5216:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4159 [inline]
 __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4178
 kmemdup_noprof+0x2a/0x60 mm/util.c:133
 key_alloc+0x388/0xff0 security/keys/key.c:282
 __key_create_or_update+0xa55/0xc70 security/keys/key.c:930
 key_create_or_update+0x42/0x60 security/keys/key.c:1018
 __do_sys_add_key security/keys/keyctl.c:134 [inline]
 __se_sys_add_key+0x33f/0x490 security/keys/keyctl.c:74
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880202b03c0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 allocated 5-byte region [ffff8880202b03c0, ffff8880202b03c5)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x202b0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801a841500 ffffea0000bba600 dead000000000002
raw: 0000000000000000 0000000080800080 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 3183568899, free_ts 3069912852
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2319
 allocate_slab+0x5a/0x2f0 mm/slub.c:2482
 new_slab mm/slub.c:2535 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3721
 __slab_alloc+0x58/0xa0 mm/slub.c:3811
 __slab_alloc_node mm/slub.c:3864 [inline]
 slab_alloc_node mm/slub.c:4026 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4171
 kmalloc_noprof include/linux/slab.h:694 [inline]
 kzalloc_noprof include/linux/slab.h:816 [inline]
 acpi_ns_internalize_name+0x419/0x610 drivers/acpi/acpica/nsutils.c:331
 acpi_ns_get_node_unlocked drivers/acpi/acpica/nsutils.c:666 [inline]
 acpi_ns_get_node+0x1b7/0x3c0 drivers/acpi/acpica/nsutils.c:726
 acpi_get_handle+0x19b/0x2a0 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x9e/0xf0 drivers/acpi/utils.c:673
 acpi_bus_get_wakeup_device_flags drivers/acpi/scan.c:1036 [inline]
 acpi_add_single_object+0xe5e/0x1e00 drivers/acpi/scan.c:1902
 acpi_bus_check_add+0x32b/0x980 drivers/acpi/scan.c:2181
 acpi_ns_walk_namespace+0x294/0x4f0
 acpi_walk_namespace+0xeb/0x130 drivers/acpi/acpica/nsxfeval.c:606
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2619
 discard_slab mm/slub.c:2581 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3049
 put_cpu_partial+0x17c/0x250 mm/slub.c:3124
 __slab_free+0x2ea/0x3d0 mm/slub.c:4344
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_remove_cache+0x15d/0x180 mm/kasan/quarantine.c:378
 kmem_cache_shrink+0xd/0x20 mm/slab_common.c:666
 acpi_os_purge_cache+0x15/0x20 drivers/acpi/osl.c:1573
 acpi_purge_cached_objects+0x8f/0xc0 drivers/acpi/acpica/utxface.c:239
 acpi_initialize_objects+0x2e/0xa0 drivers/acpi/acpica/utxfinit.c:250
 acpi_bus_init+0xda/0xbc0 drivers/acpi/bus.c:1367
 acpi_init+0xb4/0x240 drivers/acpi/bus.c:1452
 do_one_initcall+0x248/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580

Memory state around the buggy address:
 ffff8880202b0280: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff8880202b0300: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
>ffff8880202b0380: fa fc fc fc 00 fc fc fc 05 fc fc fc 00 fc fc fc
                                           ^
 ffff8880202b0400: 05 fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
 ffff8880202b0480: 00 fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
