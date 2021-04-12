Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3DFC433ED
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Apr 2021 07:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646196121F
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Apr 2021 07:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhDLHAd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:00:33 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47845 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbhDLHAc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Apr 2021 03:00:32 -0400
Received: by mail-il1-f199.google.com with SMTP id e15so2255534ilr.14
        for <linux-security-module@vger.kernel.org>; Mon, 12 Apr 2021 00:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=a8MjXdSruPWsNT6YKlOq40bkg1Bt0LxN86WBiQWj0DY=;
        b=JPerJA6uxlYVDNqvKruWg2ljjkoRCFWyJIGTJmyrBLiM4+kysrwKMf8KZGNDaEcRso
         m4HOeWksC3vRzZ8vIK+27kdX5LPRssEft9sB8GgCjGKO5p7qFhIUl7pD6z+QtV9jjyDt
         KkezPtzbflDS/uBfK/+Ed4HU85qbH6xTv6yAjtiDy/+jdgfmcS1ykRqv9oQOBfXc+Vh2
         VflJQC6bOOxfmKQjUPs0yFkQgxMz1ZmHXjE4wp30QhW+PfNRe2Q3wOI3R9EOqQkiFzPr
         5jKlsj6EjXO4ISrZYy/7wh2gOFdW5MI9Mkud683xkLuVHtYnv6WV28apR1Kovd4SqFEf
         S3lA==
X-Gm-Message-State: AOAM530Wmpv+6MfZlMsXqWV/d3C4axwhx+6uYqLvh5ooUaFBr0QtSIoa
        xJdXAzrb5QZFmPUwzE+OYHR+a6znXU9AcWDZWzizwV3BPdEo
X-Google-Smtp-Source: ABdhPJyYX7RRly5jRUCsB2jM4ji+pnoUuRRRuQXwlLySlY5Ug0xTtFw36aUjVAVKNxphyrVzmWPvkAoAlrCvbIl9aKgF0DHkB4iu
MIME-Version: 1.0
X-Received: by 2002:a5e:cb4c:: with SMTP id h12mr20880277iok.183.1618210815240;
 Mon, 12 Apr 2021 00:00:15 -0700 (PDT)
Date:   Mon, 12 Apr 2021 00:00:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d06f2605bfc110e4@google.com>
Subject: [syzbot] WARNING in smk_set_cipso (2)
From:   syzbot <syzbot+77c53db50c9fff774e8e@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    7d900724 Merge tag 'for-5.12-rc6-tag' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1462c619d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f91155ccddaf919c
dashboard link: https://syzkaller.appspot.com/bug?extid=77c53db50c9fff774e8e
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132c59a1d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13acf5e9d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77c53db50c9fff774e8e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8372 at mm/page_alloc.c:4985 __alloc_pages_nodemask+0x44e/0x500 mm/page_alloc.c:5029
Modules linked in:
CPU: 1 PID: 8372 Comm: syz-executor118 Not tainted 5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x44e/0x500 mm/page_alloc.c:5029
Code: 00 48 ba 00 00 00 00 00 fc ff df e9 fb fd ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 06 fe ff ff e8 97 67 09 00 e9 fc fd ff ff <0f> 0b e9 15 fe ff ff 44 89 ed a9 00 00 08 00 75 11 81 e5 7f ff ff
RSP: 0018:ffffc90001e2fba0 EFLAGS: 00010246
RAX: ffffc90001e2fba8 RBX: ffffc90001e2fbd4 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90001e2fbd0
RBP: 0000000000000000 R08: dffffc0000000000 R09: ffffc90001e2fba8
R10: fffff520003c5f7a R11: 0000000000000000 R12: 0000000000f0ff80
R13: 0000000000040cc0 R14: 1ffff920003c5f7a R15: 000000000000000c
FS:  0000000001eb9300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020003314 CR3: 0000000012ba3000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages include/linux/gfp.h:561 [inline]
 kmalloc_order+0x41/0x170 mm/slab_common.c:902
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:918
 kmalloc_large include/linux/slab.h:483 [inline]
 __kmalloc_track_caller+0x26d/0x390 mm/slub.c:4554
 memdup_user_nul+0x26/0xf0 mm/util.c:260
 smk_set_cipso+0xff/0x6f0 security/smack/smackfs.c:859
 vfs_write+0x220/0xab0 fs/read_write.c:603
 ksys_write+0x11b/0x220 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43ee59
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffddac6bda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043ee59
RDX: 0000000000f0ff7f RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000402e40 R08: 0000000000000000 R09: 0000000000400488
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402ed0
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
