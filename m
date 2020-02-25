Return-Path: <SRS0=WY9+=4N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4958C35DF9
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Feb 2020 08:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C812176D
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Feb 2020 08:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgBYITP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:19:15 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:40665 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbgBYITP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Feb 2020 03:19:15 -0500
Received: by mail-io1-f71.google.com with SMTP id m24so19694956iol.7
        for <linux-security-module@vger.kernel.org>; Tue, 25 Feb 2020 00:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JnIpG0/J61WLiO1q3oM1jxlRNVDltdBX+u0kfHknrM0=;
        b=YJ1ayAwukLAgdEMiZMeb/HWol3qodp1Bg6LrlRGGHVadn5K2Zb5vDk4WyHb6da7Ybe
         nEyY2fdfhnN9aQHVaXiyQJb4U/qhp1lp+PjNxdGFqqySGqVrn8fi1AeD6rRHoKNFCREd
         jUKyI3iqOf4OLKXYt88Wpg1PtNQVvqOM2pqZYf0sKrTZi4JXkzm6K1hEt8VfeP7c/yKj
         zjSxR3EPcpsxdDRbg6s0R4QlCDU4ac8Wy5g5/v9LuyPIqV76wxsybnWwW4Z00vwjKGwC
         ZuD+uVzxspTpf2/Sg5J00ybSHYsYRvDqXlhF9kcy4fyqYfhsadWNy3bhI7OwprR97nOF
         kO9g==
X-Gm-Message-State: APjAAAULbyDOVq2gjKtVLSFpYkTEn8TqpFfcc4F/5iENBe00S6oXdpIA
        axPtPJz4ZbUC8fzI1O9x0LlAAP0jB8ltdJ7tIy0CXcl+vBh5
X-Google-Smtp-Source: APXvYqwdgK4/CB1G+y2zoTGVO2dnzPpAkdWqc/vppUT1sAz5Si0TeFiOlyF2DMYMfya2tZy2jf2ZxRpyPS0GWUZbY+QD6OcnYT1N
MIME-Version: 1.0
X-Received: by 2002:a92:cb8c:: with SMTP id z12mr65405884ilo.5.1582618754093;
 Tue, 25 Feb 2020 00:19:14 -0800 (PST)
Date:   Tue, 25 Feb 2020 00:19:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a719a9059f62246e@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in cipso_v4_sock_setattr
From:   syzbot <syzbot+f4dfece964792d80b139@syzkaller.appspotmail.com>
To:     cpaasch@apple.com, davem@davemloft.net, dcaratti@redhat.com,
        fw@strlen.de, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        matthieu.baerts@tessares.net, netdev@vger.kernel.org,
        pabeni@redhat.com, paul@paul-moore.com,
        peter.krystad@linux.intel.com, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    ca7e1fd1 Merge tag 'linux-kselftest-5.6-rc3' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179f0931e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a61f2164c515c07f
dashboard link: https://syzkaller.appspot.com/bug?extid=f4dfece964792d80b139
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fdfdede00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17667de9e00000

The bug was bisected to:

commit 2303f994b3e187091fd08148066688b08f837efc
Author: Peter Krystad <peter.krystad@linux.intel.com>
Date:   Wed Jan 22 00:56:17 2020 +0000

    mptcp: Associate MPTCP context with TCP socket

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fbec81e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16fbec81e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12fbec81e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f4dfece964792d80b139@syzkaller.appspotmail.com
Fixes: 2303f994b3e1 ("mptcp: Associate MPTCP context with TCP socket")

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 8e171067 P4D 8e171067 PUD 93fa2067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8984 Comm: syz-executor066 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc900020b7b80 EFLAGS: 00010246
RAX: 1ffff110124ba600 RBX: 0000000000000000 RCX: ffff88809fefa600
RDX: ffff8880994cdb18 RSI: 0000000000000000 RDI: ffff8880925d3140
RBP: ffffc900020b7bd8 R08: ffffffff870225be R09: fffffbfff140652a
R10: fffffbfff140652a R11: 0000000000000000 R12: ffff8880925d35d0
R13: ffff8880925d3140 R14: dffffc0000000000 R15: 1ffff110124ba6ba
FS:  0000000001a0b880(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000a6d6f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 cipso_v4_sock_setattr+0x34b/0x470 net/ipv4/cipso_ipv4.c:1888
 netlbl_sock_setattr+0x2a7/0x310 net/netlabel/netlabel_kapi.c:989
 smack_netlabel security/smack/smack_lsm.c:2425 [inline]
 smack_inode_setsecurity+0x3da/0x4a0 security/smack/smack_lsm.c:2716
 security_inode_setsecurity+0xb2/0x140 security/security.c:1364
 __vfs_setxattr_noperm+0x16f/0x3e0 fs/xattr.c:197
 vfs_setxattr fs/xattr.c:224 [inline]
 setxattr+0x335/0x430 fs/xattr.c:451
 __do_sys_fsetxattr fs/xattr.c:506 [inline]
 __se_sys_fsetxattr+0x130/0x1b0 fs/xattr.c:495
 __x64_sys_fsetxattr+0xbf/0xd0 fs/xattr.c:495
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440199
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcadc19e48 EFLAGS: 00000246 ORIG_RAX: 00000000000000be
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440199
RDX: 0000000020000200 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000003 R09: 00000000004002c8
R10: 0000000000000009 R11: 0000000000000246 R12: 0000000000401a20
R13: 0000000000401ab0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 0000000000000000
---[ end trace 9bbc7bb8e1061a42 ]---
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc900020b7b80 EFLAGS: 00010246
RAX: 1ffff110124ba600 RBX: 0000000000000000 RCX: ffff88809fefa600
RDX: ffff8880994cdb18 RSI: 0000000000000000 RDI: ffff8880925d3140
RBP: ffffc900020b7bd8 R08: ffffffff870225be R09: fffffbfff140652a
R10: fffffbfff140652a R11: 0000000000000000 R12: ffff8880925d35d0
R13: ffff8880925d3140 R14: dffffc0000000000 R15: 1ffff110124ba6ba
FS:  0000000001a0b880(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000a6d6f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
