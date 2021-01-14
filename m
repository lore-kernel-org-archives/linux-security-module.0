Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47789C4332B
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jan 2021 16:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2459523B2A
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jan 2021 16:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhANQRP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:17:15 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:54871 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbhANQQ7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jan 2021 11:16:59 -0500
Received: by mail-io1-f72.google.com with SMTP id w26so9133195iox.21
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jan 2021 08:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oKRYaFHIzRW8a/LJ+hEDSk8C4TL34dpHsdSSXCrYJqM=;
        b=TQDM81lPf1qGe8Cmc2E46QXj4HW3zKuT+/9r1va573GnwI71tCuYlWKK5sLreEVW7K
         bGp3MjZl4MImnfkYPGQuMWqpI5fIW6cjbYe5KDleMzv/CJMT2bLfXKBBgbR6ylVVrvsd
         VSkIFW9gnD2zqQ+hAbgK1mJMlldukLOldehZsm7yrKdyW+OAn08ksuUNIIsQEUiRXQ6u
         3gQb99lns7EIe8qb7RUj2qrSE3n9h4bFI9wBPOvvroXj86HOD4MoRv3DONAxepEmkbHW
         jKWRiHJ9WhGDRf0rghm3S8vu6j6HBRnc/k2j969TFI3ig6oMYLwlCAgqqzHsp3npuf+6
         q61w==
X-Gm-Message-State: AOAM532wJIyJj0CqYHSFJRe8n3sQ2b/ygmp2iq+cqvcXFf8Jm4wnuqCZ
        aC19kkC0rHlrivfNXPvvbidoSElsNQyq58UbkagQCGpCDddT
X-Google-Smtp-Source: ABdhPJwFgQUDEYptyv9C5bMTwmhL12kGkEqXWKfEycMBsRaDBwnoBSsVNR137Kal0X2WXL9XGIeq9+RCgM0S0J6CBCks/h6yQW4t
MIME-Version: 1.0
X-Received: by 2002:a02:a88a:: with SMTP id l10mr6992659jam.95.1610640978402;
 Thu, 14 Jan 2021 08:16:18 -0800 (PST)
Date:   Thu, 14 Jan 2021 08:16:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060e1fe05b8de93e5@google.com>
Subject: WARNING in memdup_user_nul
From:   syzbot <syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11753ee0d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee2266946ed36986
dashboard link: https://syzkaller.appspot.com/bug?extid=a71a442385a0b2815497
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152fba3f500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176728e7500000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cf2548d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11cf2548d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16cf2548d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8449 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Modules linked in:
CPU: 0 PID: 8449 Comm: syz-executor564 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Code: aa 09 00 e9 dd fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c eb fd ff ff 4c 89 ef e8 54 aa 09 00 8b 74 24 18 e9 da fd ff ff <0f> 0b e9 f3 fd ff ff a9 00 00 08 00 75 16 8b 4c 24 1c 89 cb 81 e3
RSP: 0018:ffffc90000ebfa60 EFLAGS: 00010246
RAX: ffffc90000ebfae0 RBX: ffffc90000ebfae0 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90000ebfb08
RBP: ffffc90000ebfba0 R08: dffffc0000000000 R09: ffffc90000ebfae0
R10: fffff520001d7f61 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000012 R14: 1ffff920001d7f58 R15: 0000000000040cc0
FS:  0000000002595880(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000015a93000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x40/0x130 mm/slab_common.c:837
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
 kmalloc_large include/linux/slab.h:481 [inline]
 __kmalloc_track_caller+0x246/0x330 mm/slub.c:4457
 memdup_user_nul+0x26/0xf0 mm/util.c:260
 smk_write_syslog+0x29/0x90 security/smack/smackfs.c:2651
 vfs_write+0x289/0xc90 fs/read_write.c:603
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440289
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffe1057358 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440289
RDX: 00000000200000cb RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a90
R13: 0000000000401b20 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
