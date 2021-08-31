Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B65C432BE
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 10:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254F360F92
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 10:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbhHaKec (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:34:32 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39764 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbhHaKeT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Aug 2021 06:34:19 -0400
Received: by mail-il1-f198.google.com with SMTP id y8-20020a92c748000000b00224811cb945so10994046ilp.6
        for <linux-security-module@vger.kernel.org>; Tue, 31 Aug 2021 03:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tnQtiquwrcj+POtE1ovPDFm3cHHjlmHVPG4G/aqMhg4=;
        b=tfVHSSjz/fWtzebHzF1lFhmIZow0nWQKaBTz3KROdukBAxtmBv+rJ1fDhe8s2ZjvHh
         spy0AN/aHWtcmg8FgxkVRisaRV4Vb0K+BLCKP9kRjVXVzXHYFrPdeiPZ9nF8p1cYH/MN
         suBv2y55TiWcqhRyAob1xb1+ZiwmsWRZ7R5v9zpk1VfWgfwuAwCTcr2mFovh15FTHhaw
         GTpLywIMlG4GLAankeEHODjrNYCzDgOAUAz9Nk3yFPgcDmcjLlvfUj689f9pB/WqeuGy
         M4UO+0ma/MtA6JmI6C+pJzqhsHQ6F65AnMZeaXTYQRwzvVNdHZbQf88Ubgv/akPuqyhA
         K9lQ==
X-Gm-Message-State: AOAM531xMXQWB7079PKIAQiok0VTUv9u5+znE6npIIT6EONaFJadnOeX
        8PQchcwrRJmvWmHMMILO8hZ26UZHHvegAsgS9MrTR3Ox/aSf
X-Google-Smtp-Source: ABdhPJx+7nuFkVm9OJPFEubbAGNlQpyf9/ZUPh2ZiCaN8J9vzEaL86R38LPxkOiWc6/fAAVetdqRJEzEpVcg99vHDqGt2Ysb8Mv2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f08:: with SMTP id x8mr18891667ilj.92.1630406004366;
 Tue, 31 Aug 2021 03:33:24 -0700 (PDT)
Date:   Tue, 31 Aug 2021 03:33:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bae2cf05cad87aff@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in tomoyo_encode2
From:   syzbot <syzbot+eee04f9a4a45fabcebef@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    7d2a07b76933 Linux 5.14
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12dfff03300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=113c5df900d8cf12
dashboard link: https://syzkaller.appspot.com/bug?extid=eee04f9a4a45fabcebef
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eee04f9a4a45fabcebef@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 00000000001b7e20
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4861 Comm: systemd-udevd Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:slab_alloc_node mm/slub.c:2943 [inline]
RIP: 0010:slab_alloc mm/slub.c:2967 [inline]
RIP: 0010:__kmalloc+0x1ab/0x390 mm/slub.c:4111
Code: 84 11 01 00 00 48 83 78 10 00 0f 84 06 01 00 00 48 8b 7d 00 40 f6 c7 0f 0f 85 a7 01 00 00 45 84 c0 0f 84 a0 01 00 00 8b 45 28 <49> 8b 5c 05 00 48 89 d1 48 83 c1 08 4c 89 e8 65 48 0f c7 0f 0f 94
RSP: 0018:ffffc90000e4f8e0 EFLAGS: 00010202
RAX: 0000000000000020 RBX: 0000000000000d40 RCX: 0000000000000000
RDX: 000000000083bf29 RSI: 0000000000000040 RDI: 0000000000054e70
RBP: ffff888011041640 R08: dffffc0000000001 R09: fffffbfff1b74f1e
R10: fffffbfff1b74f1e R11: 0000000000000000 R12: 0000000000000032
R13: 00000000001b7e00 R14: 0000000000000032 R15: 0000000000000d40
FS:  00007f39d836f8c0(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000001b7e20 CR3: 000000001caf9000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kmalloc include/linux/slab.h:596 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 tomoyo_encode2+0x25a/0x560 security/tomoyo/realpath.c:45
 tomoyo_encode security/tomoyo/realpath.c:80 [inline]
 tomoyo_realpath_from_path+0x5c3/0x610 security/tomoyo/realpath.c:288
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x201/0x650 security/tomoyo/file.c:822
 security_inode_getattr+0xc0/0x140 security/security.c:1333
 vfs_getattr fs/stat.c:139 [inline]
 vfs_fstat fs/stat.c:164 [inline]
 __do_sys_newfstat fs/stat.c:404 [inline]
 __se_sys_newfstat+0xba/0x820 fs/stat.c:401
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f39d71e12e2
Code: 48 8b 05 b9 db 2b 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 83 ff 01 77 33 48 63 fe b8 05 00 00 00 48 89 d6 0f 05 <48> 3d 00 f0 ff ff 77 06 f3 c3 0f 1f 40 00 48 8b 15 81 db 2b 00 f7
RSP: 002b:00007ffd97de9338 EFLAGS: 00000246 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f39d71e12e2
RDX: 00007ffd97de9350 RSI: 00007ffd97de9350 RDI: 000000000000000e
RBP: 00007ffd97de94f0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000080000 R11: 0000000000000246 R12: 0000558889f0be90
R13: 0000558889ef8010 R14: 0000558889efb450 R15: 00007ffd97de94b0
Modules linked in:
CR2: 00000000001b7e20
----------------
Code disassembly (best guess):
   0:	84 11                	test   %dl,(%rcx)
   2:	01 00                	add    %eax,(%rax)
   4:	00 48 83             	add    %cl,-0x7d(%rax)
   7:	78 10                	js     0x19
   9:	00 0f                	add    %cl,(%rdi)
   b:	84 06                	test   %al,(%rsi)
   d:	01 00                	add    %eax,(%rax)
   f:	00 48 8b             	add    %cl,-0x75(%rax)
  12:	7d 00                	jge    0x14
  14:	40 f6 c7 0f          	test   $0xf,%dil
  18:	0f 85 a7 01 00 00    	jne    0x1c5
  1e:	45 84 c0             	test   %r8b,%r8b
  21:	0f 84 a0 01 00 00    	je     0x1c7
  27:	8b 45 28             	mov    0x28(%rbp),%eax
* 2a:	49 8b 5c 05 00       	mov    0x0(%r13,%rax,1),%rbx <-- trapping instruction
  2f:	48 89 d1             	mov    %rdx,%rcx
  32:	48 83 c1 08          	add    $0x8,%rcx
  36:	4c 89 e8             	mov    %r13,%rax
  39:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3e:	0f                   	.byte 0xf
  3f:	94                   	xchg   %eax,%esp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
