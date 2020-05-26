Return-Path: <SRS0=6tJK=7I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDD4C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 26 May 2020 03:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A589C20812
	for <linux-security-module@archiver.kernel.org>; Tue, 26 May 2020 03:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725265AbgEZDqP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 May 2020 23:46:15 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52969 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgEZDqP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 May 2020 23:46:15 -0400
Received: by mail-io1-f71.google.com with SMTP id p8so1009278ios.19
        for <linux-security-module@vger.kernel.org>; Mon, 25 May 2020 20:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FygU0grI+bkcvE0/tZ2c6MWT1VSUmVI/0YBfDJK44v0=;
        b=iV1vhVLRFL6Z0f+7ygJnhy2Hs6pWmB5RsyEzcb8m6ty0osFvpXfVt1+Py74TgUdR7H
         KpDw49SiU7fDpglB5hG9PpeNmEf79xjSREHZ95TJzPFx/LAfdj0oX+4Pmsb8geHPWtkS
         i3YOcmBsxUEmI4Y5w0EEpxYtgFWuUgxiTHr2z0q5yz4lzE4Dg4f4nJqSLN6kiG6vrT3l
         xr/uqJ3VOulYeHAH/5dC+0EN4LRyTq+wr7ocd/urwfcL4E2bwd5lfZpFL2x3ewN2T0UZ
         Vxvr44KZhXp74NcIlH9YtVIhVMWSX29yDmkhc1zdim14idU3rlWrHN9eKbMRbVXV62lI
         NkBQ==
X-Gm-Message-State: AOAM531qv+AeXXDD1TOr1B0L/pvVfTILuSzmCa5CIqtgWBnl1WTp9RUn
        wkizQ9kLlIWpXoCaXPRNvYnXJuFK1P1QMf+pg++Q2eM3E6bS
X-Google-Smtp-Source: ABdhPJyeDYLP4rScU7LxmN0VShaRSdid+cuDEJCi8qeQ9F5DW1VQNshOBs0PXP+3c+FIFj6nI3nukr/ZgLf3ncHl16neANrKhP9c
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f06:: with SMTP id q6mr15497020iow.135.1590464774531;
 Mon, 25 May 2020 20:46:14 -0700 (PDT)
Date:   Mon, 25 May 2020 20:46:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9f3e705a684ef9a@google.com>
Subject: general protection fault in tomoyo_check_acl
From:   syzbot <syzbot+cff8c4c75acd8c6fb842@syzkaller.appspotmail.com>
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

HEAD commit:    d2f8825a Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c55922100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3368ce0cc5f5ace
dashboard link: https://syzkaller.appspot.com/bug?extid=cff8c4c75acd8c6fb842
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cff8c4c75acd8c6fb842@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xe000026660000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000333300000018-0x000033330000001f]
CPU: 0 PID: 12489 Comm: systemd-rfkill Not tainted 5.7.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:tomoyo_check_acl+0xa9/0x3e0 security/tomoyo/domain.c:173
Code: 00 0f 85 2d 03 00 00 49 8b 1c 24 49 39 dc 0f 84 bd 01 00 00 e8 28 65 14 fe 48 8d 7b 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 28 38 d0 7f 08 84 c0 0f 85 a7 02 00 00 44 0f b6 73 18 31
RSP: 0018:ffffc90016987bc8 EFLAGS: 00010246
RAX: 0000066660000003 RBX: 0000333300000000 RCX: ffffffff835ed028
RDX: 0000000000000000 RSI: ffffffff835ecff8 RDI: 0000333300000018
RBP: dffffc0000000000 R08: ffff8880a1cce1c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a72db990
R13: ffffc90016987c80 R14: 0000000000000033 R15: 0000000000000002
FS:  00007f9e4b6ba8c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e4b399e30 CR3: 000000004df8d000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tomoyo_path_number_perm+0x314/0x4d0 security/tomoyo/file.c:733
 security_file_ioctl+0x6c/0xb0 security/security.c:1460
 ksys_ioctl+0x50/0x180 fs/ioctl.c:765
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7f9e4adab80a
Code: ff e9 62 fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 53 49 89 f0 48 63 ff be 01 54 00 00 b8 10 00 00 00 48 83 ec 30 48 89 e2 0f 05 <48> 3d 00 f0 ff ff 77 6e 85 c0 89 c3 75 5c 8b 04 24 8b 54 24 0c 4c
RSP: 002b:00007fffcc16ea20 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f9e4adab80a
RDX: 00007fffcc16ea20 RSI: 0000000000005401 RDI: 0000000000000002
RBP: 0000000000000007 R08: 00007fffcc16ea60 R09: 0000000000000000
R10: 0000000000020d50 R11: 0000000000000202 R12: 000056153471ef90
R13: 00007fffcc16ec30 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 1f05c0d7f6671379 ]---
RIP: 0010:tomoyo_check_acl+0xa9/0x3e0 security/tomoyo/domain.c:173
Code: 00 0f 85 2d 03 00 00 49 8b 1c 24 49 39 dc 0f 84 bd 01 00 00 e8 28 65 14 fe 48 8d 7b 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 <0f> b6 04 28 38 d0 7f 08 84 c0 0f 85 a7 02 00 00 44 0f b6 73 18 31
RSP: 0018:ffffc90016987bc8 EFLAGS: 00010246
RAX: 0000066660000003 RBX: 0000333300000000 RCX: ffffffff835ed028
RDX: 0000000000000000 RSI: ffffffff835ecff8 RDI: 0000333300000018
RBP: dffffc0000000000 R08: ffff8880a1cce1c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a72db990
R13: ffffc90016987c80 R14: 0000000000000033 R15: 0000000000000002
FS:  00007f9e4b6ba8c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f7b8031310 CR3: 000000004df8d000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
