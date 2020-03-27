Return-Path: <SRS0=iZqy=5M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21452C43331
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 01:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE47A20787
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Mar 2020 01:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgC0BUQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:20:16 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:46887 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbgC0BUQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 21:20:16 -0400
Received: by mail-il1-f198.google.com with SMTP id n18so6694339ilp.13
        for <linux-security-module@vger.kernel.org>; Thu, 26 Mar 2020 18:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nv56BrM1FdW4Prsb3RIkp/NnnWl5NQQVtK5CLTpOTpw=;
        b=Dn6MXPcyb5tcq6JCGH+KH/NH0L6QFSgCgFEYKfU3OHfBexObBg8s0VsMirpbGpqUvz
         8LoA6Ubods6ShpYSetGZVJasDOME5B9apTIAynIN4onCVcjAjPOqRyWDVQO0BJuHvU5R
         WEOXxGIC2CsuBHwblkI5TXq1a+gKJ5B5zDoxDSvF4NGA9lVs1Ubn2lz3wMDQTyJdUpfD
         6n6iAUkkcn7CRedSLl5tPy/j1gCFqh/IvQY9EZ2ui9kUR3a/7xMAWXRpMDSVTxiSAQGb
         JOaNfzKzycs2gC2qGnKFsR2dOclHPdwxvgqxXhu/F6MOGf9OJ370CY66ueAQvQErgEUv
         k8FA==
X-Gm-Message-State: ANhLgQ07ReR7YkyARtlHWXjq/GjajrodhsvCdDnL0aRCuiPy8p7ANNva
        gFrH6xHrQ/AufHTBjc1zL4sBNaTj8/ni7dyc7hMJq3/hQ+XH
X-Google-Smtp-Source: ADFU+vuyE2Uj89wuHmdzL5iE6DwfYqTpSvi2c6V4qPhGOhf+2zjwEaFke3LEHGHY7VJ0+0KBCGa/OIIAcZvCr8E1rRIx8hemG4Yk
MIME-Version: 1.0
X-Received: by 2002:a92:1e02:: with SMTP id e2mr11683358ile.292.1585272014740;
 Thu, 26 Mar 2020 18:20:14 -0700 (PDT)
Date:   Thu, 26 Mar 2020 18:20:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fa25e05a1cbe763@google.com>
Subject: KASAN: slab-out-of-bounds Read in vsscanf
From:   syzbot <syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com>
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

HEAD commit:    1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11044405e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac76c43beddbd9
dashboard link: https://syzkaller.appspot.com/bug?extid=bfdd4a2f07be52351350
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13819303e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13eaed4be00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=150e6ac5e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=170e6ac5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=130e6ac5e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3275
Read of size 1 at addr ffff888093622f42 by task syz-executor055/7117

CPU: 1 PID: 7117 Comm: syz-executor055 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:374
 __kasan_report+0x14b/0x1c0 mm/kasan/report.c:506
 kasan_report+0x25/0x50 mm/kasan/common.c:641
 vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3275
 sscanf+0x6c/0x90 lib/vsprintf.c:3481
 smk_set_cipso+0x1ac/0x6a0 security/smack/smackfs.c:881
 __vfs_write+0xa7/0x710 fs/read_write.c:494
 vfs_write+0x271/0x570 fs/read_write.c:558
 ksys_write+0x115/0x220 fs/read_write.c:611
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4401b9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd20456888 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401b9
RDX: 0000000000000001 RSI: 00000000200005c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401a40
R13: 0000000000401ad0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 7117:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc+0x118/0x1c0 mm/kasan/common.c:515
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc_track_caller+0x249/0x320 mm/slab.c:3671
 memdup_user_nul+0x26/0xf0 mm/util.c:259
 smk_set_cipso+0xff/0x6a0 security/smack/smackfs.c:859
 __vfs_write+0xa7/0x710 fs/read_write.c:494
 vfs_write+0x271/0x570 fs/read_write.c:558
 ksys_write+0x115/0x220 fs/read_write.c:611
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 1:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x12e/0x1e0 mm/kasan/common.c:476
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 tomoyo_path_perm+0x59b/0x740 security/tomoyo/file.c:842
 security_inode_getattr+0xc0/0x140 security/security.c:1254
 vfs_getattr+0x27/0x6e0 fs/stat.c:117
 vfs_statx fs/stat.c:201 [inline]
 vfs_lstat include/linux/fs.h:3277 [inline]
 __do_sys_newlstat fs/stat.c:364 [inline]
 __se_sys_newlstat+0x85/0x140 fs/stat.c:358
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888093622f40
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 2 bytes inside of
 32-byte region [ffff888093622f40, ffff888093622f60)
The buggy address belongs to the page:
page:ffffea00024d8880 refcount:1 mapcount:0 mapping:ffff8880aa4001c0 index:0xffff888093622fc1
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000271b988 ffffea00028ae488 ffff8880aa4001c0
raw: ffff888093622fc1 ffff888093622000 0000000100000039 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888093622e00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
 ffff888093622e80: fb fb fb fb fc fc fc fc 00 00 01 fc fc fc fc fc
>ffff888093622f00: fb fb fb fb fc fc fc fc 02 fc fc fc fc fc fc fc
                                           ^
 ffff888093622f80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888093623000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
