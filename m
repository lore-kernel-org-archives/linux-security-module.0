Return-Path: <SRS0=mjdh=7V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CD7C433DF
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Jun 2020 21:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAC52076A
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Jun 2020 21:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgFHV4T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:56:19 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38795 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgFHV4R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jun 2020 17:56:17 -0400
Received: by mail-io1-f69.google.com with SMTP id l19so8696251iol.5
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jun 2020 14:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4+X3ij/RhUTjj3zuUzC0A3I3PVEn21icaXaQpb3cVcM=;
        b=Lcq3PR7Tfm4YJwXjy3STQlra2RCqwLXhmMVoT8Tm51m9xqH6czWCR/39H0J/gfQqi6
         VPG50/0RkulCNUKLWwV2qG0myCOlX64+4iX16NCgO1KgJBxki0T0GGdJENmaIpvDH8Tk
         pehZZFWdUP+9wkV7EQfWONxHax19XH3uR+qh616wZPnf7xSH3N67NCWQjWTLXckxkhTT
         uRkotk+9VFqUTAWf+ZGuvEEcoh5ZBGCfE/jWUN0P009scL0rzjlXOyLzVlr2T3VjYo3i
         n9HD06bnN7aE+7v0eD+LRrx79/MY/Wv7Tgt2FhDWDZwH623EOt/ICwEDOxz15M7bb8GR
         tR2Q==
X-Gm-Message-State: AOAM532vClkmAQuJKfizRJ0GkRkPwBFxEfJ9okl0MEK1rMWgDjQDe42b
        I2Cz1Ki9J/WodTyDEW2ztw9E5h8IFVkHHfmKU8jR9HQzcmgY
X-Google-Smtp-Source: ABdhPJxD4W1SPvCytYKPN5LWWnCV/iFYYNo2JN4qamgKJJFL4q64n5rkWLGI3PmX9isbRfBRwNJfDFJCaOiiXbzuK7E0KB2dcuF/
MIME-Version: 1.0
X-Received: by 2002:a92:d9c1:: with SMTP id n1mr23113253ilq.148.1591653374784;
 Mon, 08 Jun 2020 14:56:14 -0700 (PDT)
Date:   Mon, 08 Jun 2020 14:56:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000279c705a799ae31@google.com>
Subject: KASAN: use-after-free Read in smk_write_relabel_self
From:   syzbot <syzbot+e6416dabb497a650da40@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    acf25aa6 Merge tag 'Smack-for-5.8' of git://github.com/csc..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cd3ea6100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d66e6915128ae67
dashboard link: https://syzkaller.appspot.com/bug?extid=e6416dabb497a650da40
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10654fd2100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107beea6100000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129e16fe100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=119e16fe100000
console output: https://syzkaller.appspot.com/x/log.txt?x=169e16fe100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e6416dabb497a650da40@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in smk_destroy_label_list security/smack/smackfs.c:1975 [inline]
BUG: KASAN: use-after-free in smk_write_relabel_self+0x2f6/0x480 security/smack/smackfs.c:2748
Read of size 8 at addr ffff88809184bec0 by task syz-executor032/6852

CPU: 0 PID: 6852 Comm: syz-executor032 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 smk_destroy_label_list security/smack/smackfs.c:1975 [inline]
 smk_write_relabel_self+0x2f6/0x480 security/smack/smackfs.c:2748
 __vfs_write+0x9c/0x6e0 fs/read_write.c:495
 __kernel_write+0x120/0x350 fs/read_write.c:516
 write_pipe_buf+0xf9/0x150 fs/splice.c:799
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x351/0x8b0 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 default_file_splice_write fs/splice.c:811 [inline]
 do_splice_from fs/splice.c:847 [inline]
 direct_splice_actor+0x1eb/0x2a0 fs/splice.c:1016
 splice_direct_to_actor+0x4a2/0xb60 fs/splice.c:971
 do_splice_direct+0x201/0x340 fs/splice.c:1059
 do_sendfile+0x809/0xfe0 fs/read_write.c:1521
 __do_sys_sendfile64 fs/read_write.c:1582 [inline]
 __se_sys_sendfile64 fs/read_write.c:1568 [inline]
 __x64_sys_sendfile64+0x164/0x1a0 fs/read_write.c:1568
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x446a29
Code: e8 bc b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 ab 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f662054fdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006dbc88 RCX: 0000000000446a29
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000006
RBP: 00000000006dbc80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000100000064 R11: 0000000000000246 R12: 00000000006dbc8c
R13: 00007fffa294e1ef R14: 00007f66205509c0 R15: 0000000000000001

Allocated by task 6850:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 smk_parse_label_list+0xff/0x280 security/smack/smackfs.c:1955
 smk_write_relabel_self+0x190/0x480 security/smack/smackfs.c:2744
 __vfs_write+0x9c/0x6e0 fs/read_write.c:495
 __kernel_write+0x120/0x350 fs/read_write.c:516
 write_pipe_buf+0xf9/0x150 fs/splice.c:799
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x351/0x8b0 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 default_file_splice_write fs/splice.c:811 [inline]
 do_splice_from fs/splice.c:847 [inline]
 direct_splice_actor+0x1eb/0x2a0 fs/splice.c:1016
 splice_direct_to_actor+0x4a2/0xb60 fs/splice.c:971
 do_splice_direct+0x201/0x340 fs/splice.c:1059
 do_sendfile+0x809/0xfe0 fs/read_write.c:1521
 __do_sys_sendfile64 fs/read_write.c:1582 [inline]
 __se_sys_sendfile64 fs/read_write.c:1568 [inline]
 __x64_sys_sendfile64+0x164/0x1a0 fs/read_write.c:1568
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 6850:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 smk_destroy_label_list security/smack/smackfs.c:1976 [inline]
 smk_write_relabel_self+0x302/0x480 security/smack/smackfs.c:2748
 __vfs_write+0x9c/0x6e0 fs/read_write.c:495
 __kernel_write+0x120/0x350 fs/read_write.c:516
 write_pipe_buf+0xf9/0x150 fs/splice.c:799
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x351/0x8b0 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 default_file_splice_write fs/splice.c:811 [inline]
 do_splice_from fs/splice.c:847 [inline]
 direct_splice_actor+0x1eb/0x2a0 fs/splice.c:1016
 splice_direct_to_actor+0x4a2/0xb60 fs/splice.c:971
 do_splice_direct+0x201/0x340 fs/splice.c:1059
 do_sendfile+0x809/0xfe0 fs/read_write.c:1521
 __do_sys_sendfile64 fs/read_write.c:1582 [inline]
 __se_sys_sendfile64 fs/read_write.c:1568 [inline]
 __x64_sys_sendfile64+0x164/0x1a0 fs/read_write.c:1568
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff88809184bec0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 32-byte region [ffff88809184bec0, ffff88809184bee0)
The buggy address belongs to the page:
page:ffffea00024612c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88809184bfc1
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00029a8788 ffffea0002a351c8 ffff8880aa4001c0
raw: ffff88809184bfc1 ffff88809184b000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809184bd80: 00 00 00 fc fc fc fc fc fb fb fb fb fc fc fc fc
 ffff88809184be00: 00 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
>ffff88809184be80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                                           ^
 ffff88809184bf00: fb fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
 ffff88809184bf80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
