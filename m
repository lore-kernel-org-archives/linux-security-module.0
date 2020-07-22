Return-Path: <SRS0=gxm9=BB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAB2C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Jul 2020 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC2920717
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Jul 2020 18:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgGVScW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:32:22 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:53036 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVScV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Jul 2020 14:32:21 -0400
Received: by mail-il1-f199.google.com with SMTP id o17so1681846ilt.19
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2020 11:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xqaFsWA4S2FWPTXvc0/32O9eUh5hZilXu7bDDZTt/Cc=;
        b=izeSWHpHXJhsz9y4kLM3hftFo+KWaf9lVfXHzOXS+KZQZWhpMfcpwszj2nM2QlIANB
         h/sr1AxFKn8k3WLtP1w35lkJQ/qpquzOhxEqsH9Pa7DRE91ej5QCgtT19U7fxPr3NmjJ
         FFHZa1Dr91WSeYyamtcNUUiJjUHoRsdTUlsflhacZ+tTV/zqv0rkZxWk4i4R7WLKXqYx
         Eg8Tqs2myGFdvNcpVxz/Zqgh5pRVrdwnY3P1lZ/MuOfOZLoytuqWmYnQ5AFozPyIyFo8
         i99wLlpwJVMvaOFIWnEsKTS1HMNDcZYZqZSgFxNWJKFVYuiNXZ/D4bqwHSBObqmigPAA
         3SrQ==
X-Gm-Message-State: AOAM530/biufLGCgyhpq17x+nqBJMNt5udNc46pmC0Ffg7saLn0mHB09
        RLbvsgmUJqo1fune4HkEob7Mp0ck6aJ7CR1tiQPgd56Lregl
X-Google-Smtp-Source: ABdhPJzZSBfQtty9MzAfVgmbdcLKZlsnr22g5NmaKUi2QoXu3cevorIQ758/IWj4bhj6Ih66zU02PmAecRMD3hnM05cLdOwBFbAW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:de6:: with SMTP id m6mr1213270ilj.296.1595442740755;
 Wed, 22 Jul 2020 11:32:20 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:32:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d282bd05ab0bf532@google.com>
Subject: KASAN: slab-out-of-bounds Read in vsscanf (2)
From:   syzbot <syzbot+a22c6092d003d6fe1122@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    f932d58a Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10337320900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e944500a36bc4d55
dashboard link: https://syzkaller.appspot.com/bug?extid=a22c6092d003d6fe1122
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ce6d7d100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1207c827100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a22c6092d003d6fe1122@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3321
Read of size 1 at addr ffff888097d682b8 by task syz-executor980/6804

CPU: 0 PID: 6804 Comm: syz-executor980 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 vsscanf+0x2666/0x2ef0 lib/vsprintf.c:3321
 sscanf+0x6c/0x90 lib/vsprintf.c:3527
 smk_set_cipso+0x374/0x6c0 security/smack/smackfs.c:908
 vfs_write+0x2dd/0xc70 fs/read_write.c:576
 ksys_write+0x11b/0x220 fs/read_write.c:631
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402d9
Code: Bad RIP value.
RSP: 002b:00007ffe89010db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402d9
RDX: 0000000000000037 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000014 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ae0
R13: 0000000000401b70 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6804:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc_track_caller+0x249/0x320 mm/slab.c:3671
 memdup_user_nul+0x26/0xf0 mm/util.c:259
 smk_set_cipso+0xff/0x6c0 security/smack/smackfs.c:859
 vfs_write+0x2dd/0xc70 fs/read_write.c:576
 ksys_write+0x11b/0x220 fs/read_write.c:631
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 4906:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 tomoyo_path_number_perm+0x525/0x690 security/tomoyo/file.c:736
 tomoyo_path_mknod+0x128/0x150 security/tomoyo/tomoyo.c:240
 security_path_mknod+0xdc/0x160 security/security.c:1077
 may_o_create fs/namei.c:2919 [inline]
 lookup_open fs/namei.c:3060 [inline]
 open_last_lookups fs/namei.c:3169 [inline]
 path_openat+0xbe8/0x37f0 fs/namei.c:3357
 do_filp_open+0x191/0x3a0 fs/namei.c:3387
 do_sys_openat2+0x463/0x770 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 ksys_open include/linux/syscalls.h:1388 [inline]
 __do_sys_open fs/open.c:1201 [inline]
 __se_sys_open fs/open.c:1199 [inline]
 __x64_sys_open+0x1af/0x1e0 fs/open.c:1199
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888097d68280
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 56 bytes inside of
 64-byte region [ffff888097d68280, ffff888097d682c0)
The buggy address belongs to the page:
page:ffffea00025f5a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888097d68c80
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000288fe08 ffffea00026f38c8 ffff8880aa400380
raw: ffff888097d68c80 ffff888097d68000 000000010000001e 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888097d68180: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
 ffff888097d68200: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888097d68280: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                                        ^
 ffff888097d68300: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
 ffff888097d68380: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
