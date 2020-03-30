Return-Path: <SRS0=K480=5P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD936C2D0EE
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Mar 2020 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3EF2073B
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Mar 2020 13:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgC3NvV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:51:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55187 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgC3NvU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Mar 2020 09:51:20 -0400
Received: by mail-io1-f72.google.com with SMTP id f20so16160786iof.21
        for <linux-security-module@vger.kernel.org>; Mon, 30 Mar 2020 06:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YLVvaNavGqJEhh5fkSr20jBs4zDVUyraFKS4RYYWOFg=;
        b=Dz0LrcFRTugiSX9K1YR9Ix3cpX43vKrkWFFC8DtHPF6+zmaxjyH+8Bx4zI/Q6ZuixH
         +ME0n67LeV9gxjpr+Diw7jurrp3Hab8SFE54V/k2th3Scip8WfjU22NFb4SD4AxyBueu
         38ZLkdEfrcbVBibUpdVVfzeBcut87Us9VT66yTHNj1NXuiZ4eIUS1RT4rlR6Pr0sl97Q
         i/QaU8o1tNZht1ywdp9X9WH7WSUPRt0z0tLQTAod51Gvq+JhNi8zFVjSuP0u+TNeSNGG
         OJUZKZZxBMlEvbtgsYndLbDLJRjbgJ41Z+QQfmdKHd7yhH7XohcLgWYjeDjd46K+D5X2
         eb8g==
X-Gm-Message-State: ANhLgQ3O//4aPjzlyJbi+Ox5+dlN4hX6cefliYbYRLCVFImL14EGiVgk
        GNaeoYDmBrlTM96RRUyBl7yYNch92SHy28CfsCwqNvZG0hGA
X-Google-Smtp-Source: ADFU+vsvxrmg4/EclKDmQeQf7Px0e7WNMnWZw5YOLVczE+DTyccrmmhsFybMffejJ0apRQDnvqMQVt+gHn8fKmDptiqTTYNCnRja
MIME-Version: 1.0
X-Received: by 2002:a6b:b4c1:: with SMTP id d184mr10497100iof.85.1585576278701;
 Mon, 30 Mar 2020 06:51:18 -0700 (PDT)
Date:   Mon, 30 Mar 2020 06:51:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db448f05a212beea@google.com>
Subject: kernel panic: smack: Failed to initialize cipso DOI.
From:   syzbot <syzbot+89731ccb6fec15ce1c22@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        casey@schaufler-ca.com, davem@davemloft.net,
        intel-wired-lan@lists.osuosl.org, jeffrey.t.kirsher@intel.com,
        jkc@redhat.com, jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, serge@hallyn.com, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14957099e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac76c43beddbd9
dashboard link: https://syzkaller.appspot.com/bug?extid=89731ccb6fec15ce1c22
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1202c375e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1390bb03e00000

The bug was bisected to:

commit a9d2d53a788a9c5bc8a7d1b4ea7857b68e221357
Author: Ken Cox <jkc@redhat.com>
Date:   Tue Nov 15 19:00:37 2016 +0000

    ixgbe: test for trust in macvlan adjustments for VF

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13cb06f3e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=102b06f3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17cb06f3e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+89731ccb6fec15ce1c22@syzkaller.appspotmail.com
Fixes: a9d2d53a788a ("ixgbe: test for trust in macvlan adjustments for VF")

RSP: 002b:00007ffebd499a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffebd499a40 RCX: 00000000004404e9
RDX: 0000000000000014 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000000000000001 R09: 00007ffebd490031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401dd0
R13: 0000000000401e60 R14: 0000000000000000 R15: 0000000000000000
Kernel panic - not syncing: smack:  Failed to initialize cipso DOI.
CPU: 1 PID: 7197 Comm: syz-executor480 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 smk_cipso_doi+0x4d8/0x4e0 security/smack/smackfs.c:698
 smk_write_doi+0x123/0x190 security/smack/smackfs.c:1595
 __vfs_write+0xa7/0x710 fs/read_write.c:494
 vfs_write+0x271/0x570 fs/read_write.c:558
 ksys_write+0x115/0x220 fs/read_write.c:611
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4404e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffebd499a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffebd499a40 RCX: 00000000004404e9
RDX: 0000000000000014 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000000000000001 R09: 00007ffebd490031
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401dd0
R13: 0000000000401e60 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
