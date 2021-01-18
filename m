Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF918C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Jan 2021 16:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A6B222BB
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Jan 2021 16:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbhARQu0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:50:26 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:36034 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392837AbhARQs6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Jan 2021 11:48:58 -0500
Received: by mail-io1-f71.google.com with SMTP id x4so29136705ioh.3
        for <linux-security-module@vger.kernel.org>; Mon, 18 Jan 2021 08:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JUuVdTOisvuEkvRCf1xzi+cw44dGW+Nv6pXH3+R3PYk=;
        b=SbL9IYpElXe/W9tulfn0WOpAOTEQ4oFP2GCWRZTaScUmnR0VxmLa2al5YnTTOs3saq
         vY7qnqBP4qjjtLaFdC8su61TEjL9G7WzQTZi8l/S+6pww/rrZyLA8hiE2niqKef6COWs
         uAU5N7o0LdKxlBC7Jk5BTRnoGCnubW/JfuRHPTPb5i/fBEUK+uMKZmyIxUXzK2YmckbI
         5TfmxH2lSeZABLGu0yZWcYvM3CTTF8FSEbo3p7Zv9yeNcZSJHyLvlg1XqZbkwYvkdRQj
         10zck1RTHKVZUhSd9yMxwTCpEhJ4Rrth3qOeFQ7WdonQMnls6PInFsR50GZ/p2AdJR/9
         O7cw==
X-Gm-Message-State: AOAM5307/Fa3FbZSVsKV/dzjIiBuNi0PC82vINPnPQaj1MoYMKxIPlkC
        OTTFI5k8wl3d9pONHMwLwb9twuF0W+n4YnELiZ+bX+ltyyrG
X-Google-Smtp-Source: ABdhPJwTcy4CmoIaSdh7toEt5Efupkuv+RbQyY4cRj3hFH9SvpvjQBIN40esaffLiA3YCG9vu+FL/o6QMF7fxQm5wWWe9jER4hJy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:: with SMTP id f7mr144838ilu.96.1610988497466;
 Mon, 18 Jan 2021 08:48:17 -0800 (PST)
Date:   Mon, 18 Jan 2021 08:48:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020fc9605b92f7de9@google.com>
Subject: WARNING in smk_set_cipso
From:   syzbot <syzbot+438aafc66532f0dba169@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    65f0d241 Merge tag 'sound-5.11-rc4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136656f7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee2266946ed36986
dashboard link: https://syzkaller.appspot.com/bug?extid=438aafc66532f0dba169
compiler:       clang version 11.0.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17499268d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132a5207500000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155dda20d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175dda20d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=135dda20d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+438aafc66532f0dba169@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8454 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Modules linked in:
CPU: 1 PID: 8454 Comm: syz-executor584 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Code: aa 09 00 e9 dd fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c eb fd ff ff 4c 89 ef e8 54 aa 09 00 8b 74 24 18 e9 da fd ff ff <0f> 0b e9 f3 fd ff ff a9 00 00 08 00 75 16 8b 4c 24 1c 89 cb 81 e3
RSP: 0018:ffffc90000e9f900 EFLAGS: 00010246
RAX: ffffc90000e9f980 RBX: ffffc90000e9f980 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90000e9f9a8
RBP: ffffc90000e9fa40 R08: dffffc0000000000 R09: ffffc90000e9f980
R10: fffff520001d3f35 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000012 R14: 1ffff920001d3f2c R15: 0000000000040cc0
FS:  0000000002629880(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f751f4c71a8 CR3: 000000001264e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x40/0x130 mm/slab_common.c:837
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
 kmalloc_large include/linux/slab.h:481 [inline]
 __kmalloc_track_caller+0x246/0x330 mm/slub.c:4457
 memdup_user_nul+0x26/0xf0 mm/util.c:260
 smk_set_cipso+0x18b/0x7e0 security/smack/smackfs.c:859
 vfs_write+0x289/0xc90 fs/read_write.c:603
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440359
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc65526ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440359
RDX: 0000000020014b6f RSI: 0000000020014b00 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000014 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b60
R13: 0000000000401bf0 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
