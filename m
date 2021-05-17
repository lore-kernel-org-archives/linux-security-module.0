Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5F4C433B4
	for <linux-security-module@archiver.kernel.org>; Mon, 17 May 2021 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78016044F
	for <linux-security-module@archiver.kernel.org>; Mon, 17 May 2021 11:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhEQLIq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 May 2021 07:08:46 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55117 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbhEQLIp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 May 2021 07:08:45 -0400
Received: by mail-io1-f70.google.com with SMTP id a13-20020a5d958d0000b029043aa4f99980so2991874ioo.21
        for <linux-security-module@vger.kernel.org>; Mon, 17 May 2021 04:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cTLRQjPkzS7cACXegb+CR/rCoBBrLiDkg8hvMlIUUe8=;
        b=td3ceEeVwAH58SkihYK16QgaqIH3Zcz1lhB/VssFFd1dzvEuvwUafYAm4GOym3iDJj
         b03O8qRQZ7DyG53l5ITfFXJf+qoyy94HAqS9xmtkAAj6hzNqb4zbb7XRi8qjtT9L5TVd
         CxPUULWC6Qy8kbOSDVhWaeDm3ZXTEyLsZGnc6MBjWpjXYmlLmgrkDozJq8xpsdvRsqT9
         ymEHw3WUxbGhMMlQS40SO2sR0maGbJf9iJsCixs0qCZWB/EE4xV+ctIze87NbIZf9d/1
         gIU2vgT9thHAirLQb44rz7TXehyM7iqmonmJZD3gDavBjqT6i/gOkbTgtaoc4/pp1xCu
         dvVA==
X-Gm-Message-State: AOAM532vSOy+Z1/Oc3jAs1RkEJrKW+5/N1EBCSFL2YN6GAgV/faeP6Bm
        guriyZxA5sUfyK45jTlmivIDcdxyGMoG9cXJVDoCpnKXqHoy
X-Google-Smtp-Source: ABdhPJy1zOQ2diScEVHRELlo+rN2wavHM54fQ8XWYXsblGzktlW5uXJtyx5FpDrcWyUiqM5MNkRAM2DPvGRA22ki6NnFrblezZgG
MIME-Version: 1.0
X-Received: by 2002:a02:b718:: with SMTP id g24mr1212559jam.16.1621249645683;
 Mon, 17 May 2021 04:07:25 -0700 (PDT)
Date:   Mon, 17 May 2021 04:07:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039294c05c2849966@google.com>
Subject: [syzbot] general protection fault in tomoyo_check_acl (2)
From:   syzbot <syzbot+750652790d29f243bd16@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    5d869070 net: phy: marvell: don't use empty switch default..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=120c7ffed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c0b14609f12d53
dashboard link: https://syzkaller.appspot.com/bug?extid=750652790d29f243bd16

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+750652790d29f243bd16@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xe0000299dffffd43: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x000034ceffffea18-0x000034ceffffea1f]
CPU: 0 PID: 8406 Comm: systemd-udevd Not tainted 5.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:tomoyo_check_acl+0xac/0x450 security/tomoyo/domain.c:173
Code: 00 0f 85 69 03 00 00 49 8b 5d 00 49 39 dd 0f 84 fa 01 00 00 e8 f5 28 e2 fd 48 8d 7b 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 28 38 d0 7f 08 84 c0 0f 85 f7 02 00 00 44 0f b6 73 18 31
RSP: 0018:ffffc900016df760 EFLAGS: 00010246
RAX: 00000699dffffd43 RBX: 000034ceffffea00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8391cd6b RDI: 000034ceffffea18
RBP: dffffc0000000000 R08: 00000000e906028c R09: 0000000000000000
R10: ffffffff8391ce18 R11: 0000000000000000 R12: ffffc900016df858
R13: ffff888011f22a10 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f6b153858c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b141a003f CR3: 00000000134a1000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tomoyo_path_permission security/tomoyo/file.c:586 [inline]
 tomoyo_path_permission+0x1ff/0x3a0 security/tomoyo/file.c:573
 tomoyo_check_open_permission+0x33e/0x380 security/tomoyo/file.c:777
 tomoyo_file_open security/tomoyo/tomoyo.c:313 [inline]
 tomoyo_file_open+0xa3/0xd0 security/tomoyo/tomoyo.c:308
 security_file_open+0x52/0x4f0 security/security.c:1589
 do_dentry_open+0x358/0x11b0 fs/open.c:813
 do_open fs/namei.c:3367 [inline]
 path_openat+0x1c0e/0x27e0 fs/namei.c:3500
 do_filp_open+0x190/0x3d0 fs/namei.c:3527
 do_sys_openat2+0x16d/0x420 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_open fs/open.c:1211 [inline]
 __se_sys_open fs/open.c:1207 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1207
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6b144cb840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffdefb36b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffdefb370b0 RCX: 00007f6b144cb840
RDX: 000055b3f19c7f40 RSI: 0000000000000002 RDI: 000055b3eff01ad8
RBP: 000055b3f19c86b0 R08: 000000000000fefc R09: 0000000000000070
R10: 0000000000000018 R11: 0000000000000246 R12: 0000000000000010
R13: 0000000000000012 R14: 000055b3f19c7f10 R15: 00007ffdefb38680
Modules linked in:
---[ end trace c6274c8e09aa7141 ]---
RIP: 0010:tomoyo_check_acl+0xac/0x450 security/tomoyo/domain.c:173
Code: 00 0f 85 69 03 00 00 49 8b 5d 00 49 39 dd 0f 84 fa 01 00 00 e8 f5 28 e2 fd 48 8d 7b 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 28 38 d0 7f 08 84 c0 0f 85 f7 02 00 00 44 0f b6 73 18 31
RSP: 0018:ffffc900016df760 EFLAGS: 00010246
RAX: 00000699dffffd43 RBX: 000034ceffffea00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8391cd6b RDI: 000034ceffffea18
RBP: dffffc0000000000 R08: 00000000e906028c R09: 0000000000000000
R10: ffffffff8391ce18 R11: 0000000000000000 R12: ffffc900016df858
R13: ffff888011f22a10 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f6b153858c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005559ae2660f8 CR3: 00000000134a1000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
