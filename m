Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5326CC433E6
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Jan 2021 22:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F173230FE
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Jan 2021 22:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbhASRpd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:45:33 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:37046 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391317AbhASRkB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Jan 2021 12:40:01 -0500
Received: by mail-io1-f69.google.com with SMTP id l22so36817767iom.4
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jan 2021 09:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BrtrFB5BOP2JCJwrDmBx4rTYl4+oGSknnaiU84Ea2LE=;
        b=FR6okTUpFpCQTf8JKUwYvRWVYugjUR0MXnEEDgZ7yXJRB3TIXHyuI7+M7giqbh+49A
         4c5Yfp7JKejxsz3kr/JZ6GavBQJgGNfa5NHhCJoE5GQWVtLfMxtkbfIJLmcwjo9IzYK7
         7RnxpNE7BCmn1tefWj/xiot6DrhK02A+13b+0whPSjpohEyiNL8PU1+DjBZi1XG8xazH
         yyAdlaAE5uomL7DSYyUe3wITbFi6oPuXtigCdo8cUvPO7EpxzhPuioDuCAMq9XiO/oAL
         wpWA1N8zlj/NcQs1H0Fpt9MAHMFm9h4gLX2HFnypjMwWSRZIzaMGQ9LeLigaVTM6Q4ft
         evbg==
X-Gm-Message-State: AOAM531xMeyk2RyOCkd2STFmobsgaUeC+FmhBgLLXZBm4CVTwp/J0Jgd
        Imp6BsA0aD8yNCkFtZc9rkSSQvzw8wjE6yEuQVA5SYu0wySU
X-Google-Smtp-Source: ABdhPJwtTJ+NkPvzVZaOiHx3jIJe9Ij8tMbJQ4dZTSsAjfDKRQtgm7dOB/peCofp0aLhV63O9eKcShjFjGu+X9gomk/jIOoKpEEv
MIME-Version: 1.0
X-Received: by 2002:a6b:2d4:: with SMTP id 203mr3716775ioc.0.1611077960160;
 Tue, 19 Jan 2021 09:39:20 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:39:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000855b9a05b94451de@google.com>
Subject: WARNING in smk_write_net6addr
From:   syzbot <syzbot+10c962a5945f43cca2e8@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    1d94330a Merge tag 'for-5.11/dm-fixes-1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124f589f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee2266946ed36986
dashboard link: https://syzkaller.appspot.com/bug?extid=10c962a5945f43cca2e8
compiler:       clang version 11.0.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c4af7500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168e0858d00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c008e7500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c008e7500000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c008e7500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10c962a5945f43cca2e8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8460 at mm/page_alloc.c:4977 __alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5021
Modules linked in:
CPU: 1 PID: 8460 Comm: syz-executor559 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5021
Code: ab 09 00 e9 dd fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c eb fd ff ff 4c 89 ef e8 f4 aa 09 00 8b 74 24 18 e9 da fd ff ff <0f> 0b e9 f3 fd ff ff a9 00 00 08 00 75 16 8b 4c 24 1c 89 cb 81 e3
RSP: 0018:ffffc900017cf8a0 EFLAGS: 00010246
RAX: ffffc900017cf920 RBX: ffffc900017cf920 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc900017cf948
RBP: ffffc900017cf9e0 R08: dffffc0000000000 R09: ffffc900017cf920
R10: fffff520002f9f29 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000012 R14: 1ffff920002f9f20 R15: 0000000000040cc0
FS:  00000000025fa880(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbe8867e6c0 CR3: 0000000021afc000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x40/0x130 mm/slab_common.c:837
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
 kmalloc_large include/linux/slab.h:481 [inline]
 __kmalloc_track_caller+0x246/0x330 mm/slub.c:4457
 memdup_user_nul+0x26/0xf0 mm/util.c:260
 smk_write_net6addr+0x124/0x25b0 security/smack/smackfs.c:1433
 vfs_write+0x289/0xc90 fs/read_write.c:603
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4403b9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc17e5a7e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004403b9
RDX: 000000002000012e RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000014 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401bc0
R13: 0000000000401c50 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
