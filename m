Return-Path: <SRS0=Lv+b=6A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B9DC2BA2B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Apr 2020 22:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23DA6218AC
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Apr 2020 22:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgDPWFS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:05:18 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:41140 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgDPWFQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Apr 2020 18:05:16 -0400
Received: by mail-il1-f200.google.com with SMTP id y2so546554ilm.8
        for <linux-security-module@vger.kernel.org>; Thu, 16 Apr 2020 15:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=t94OE0w+w7k6OaH2ej/qCaib3DJVNZtB6q/8wxE75iQ=;
        b=APVMlyO1J/pFFSxZAHRZM0xcZXev30Ryj44O449ZH4vpsiSiMJEFCO1rltdqSJi/si
         FZSbANKxq1NdJYPcHZi9UaCsB/OTkRYKpXHAkj50pyhJS3DaA0CzTxjfKCwNloNhWHLA
         rotjFioqtP94E56/fC/ATYnftvzABJ6G423Xm68WXYs0OE3WSyhuTqy0quQXvOeWH1WG
         QZTX0ccUY8u2baHooh9U9O2jA04psrbMkfeiPqPyb8sepyecytlPonet8ztYX2hBqGjw
         UcKrsl/Ccoxw9/eCghYBG44zmSlXwvON7utu33Tu5Ntbe9f6g5tZbpoOqFofWdg8hgBW
         ELAg==
X-Gm-Message-State: AGi0PuaJ2Y2e11G9l0R6ibkLG6S09OCyeq24rQU74HkAvCihT21yfxAQ
        MmVmg7R+CMiq9gh806EaF1Fe0sHi41oZi90b65hptPF7emhE
X-Google-Smtp-Source: APiQypJw4VEz7a7ZK6kPE6sSsJOCqcuC22BtBrPpJPQexqa9LMleUwiBkxlpyGS6A6L7N5GhN5ONllJ72gMHfjw7/b/j8UC4fjlw
MIME-Version: 1.0
X-Received: by 2002:a92:a183:: with SMTP id b3mr8712ill.74.1587074715380; Thu,
 16 Apr 2020 15:05:15 -0700 (PDT)
Date:   Thu, 16 Apr 2020 15:05:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a475ac05a36fa01e@google.com>
Subject: WARNING: locking bug in tomoyo_supervisor
From:   syzbot <syzbot+1c36440b364ea3774701@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    4f8a3cc1 Merge tag 'x86-urgent-2020-04-12' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1599027de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bfbde87e8e65624
dashboard link: https://syzkaller.appspot.com/bug?extid=1c36440b364ea3774701
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150733cde00000

Bisection is inconclusive: the first bad commit could be any of:

9211bfbf netfilter: add missing IS_ENABLED(CONFIG_BRIDGE_NETFILTER) checks to header-file.
47e640af netfilter: add missing IS_ENABLED(CONFIG_NF_TABLES) check to header-file.
a1b2f04e netfilter: add missing includes to a number of header-files.
0abc8bf4 netfilter: add missing IS_ENABLED(CONFIG_NF_CONNTRACK) checks to some header-files.
bd96b4c7 netfilter: inline four headers files into another one.
43dd16ef netfilter: nf_tables: store data in offload context registers
78458e3e netfilter: add missing IS_ENABLED(CONFIG_NETFILTER) checks to some header-files.
20a9379d netfilter: remove "#ifdef __KERNEL__" guards from some headers.
bd8699e9 netfilter: nft_bitwise: add offload support
2a475c40 kbuild: remove all netfilter headers from header-test blacklist.
7e59b3fe netfilter: remove unnecessary spaces
1b90af29 ipvs: Improve robustness to the ipvs sysctl
5785cf15 netfilter: nf_tables: add missing prototypes.
0a30ba50 netfilter: nf_nat_proto: make tables static
e84fb4b3 netfilter: conntrack: use shared sysctl constants
10533343 netfilter: connlabels: prefer static lock initialiser
8c0bb787 netfilter: synproxy: rename mss synproxy_options field
c162610c Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10aacf5de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1c36440b364ea3774701@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8602 at kernel/locking/lockdep.c:873 look_up_lock_class+0x207/0x280 kernel/locking/lockdep.c:863
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8602 Comm: syz-executor.5 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 __warn+0x102/0x210 kernel/panic.c:574
 look_up_lock_class+0x207/0x280 kernel/locking/lockdep.c:863
 __warn+0x209/0x210 kernel/panic.c:582
 look_up_lock_class+0x207/0x280 kernel/locking/lockdep.c:863
 report_bug+0x1ac/0x2d0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 do_error_trap+0xca/0x1c0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 look_up_lock_class+0x207/0x280 kernel/locking/lockdep.c:863
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:look_up_lock_class+0x207/0x280 kernel/locking/lockdep.c:863
Code: 3d 91 8c 12 08 00 0f 85 35 ff ff ff 31 db 48 c7 c7 19 59 e5 88 48 c7 c6 03 ea e6 88 31 c0 e8 10 18 ec ff 0f 0b e9 7b ff ff ff <0f> 0b e9 74 ff ff ff 48 c7 c1 30 4d 55 8b 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90006017a98 EFLAGS: 00010002
RAX: ffffffff8ab05460 RBX: ffffffff8ad678f8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888096695860
RBP: ffff888096695878 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff12d7735 R11: 0000000000000000 R12: 1ffff11012cd2b0c
R13: ffffffff89063ea9 R14: ffff888096695860 R15: dffffc0000000000
 register_lock_class+0x97/0x10d0 kernel/locking/lockdep.c:1220
 tomoyo_supervisor+0x13d/0x1310 security/tomoyo/common.c:2076
 __lock_acquire+0x102/0x2c30 kernel/locking/lockdep.c:4234
 rcu_lock_release+0x5/0x20 include/linux/rcupdate.h:212
 srcu_read_unlock include/linux/srcu.h:181 [inline]
 tomoyo_read_unlock security/tomoyo/common.h:1123 [inline]
 tomoyo_inet_entry security/tomoyo/network.c:487 [inline]
 tomoyo_check_inet_address+0x661/0x8e0 security/tomoyo/network.c:532
 lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4934
 spin_lock_bh include/linux/spinlock.h:358 [inline]
 lock_sock_nested+0x43/0x110 net/core/sock.c:2959


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
