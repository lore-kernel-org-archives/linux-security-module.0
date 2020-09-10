Return-Path: <SRS0=OzCb=CT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF989C433E2
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 06:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B31207EA
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 06:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIJG0a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:26:30 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:33690 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgIJG0Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Sep 2020 02:26:16 -0400
Received: by mail-il1-f208.google.com with SMTP id c11so3843682ilm.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2020 23:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KtI7zCGAfmR7j9D5AmBqtrbK4m+XAkYeujT7FJKCF9Q=;
        b=ly63FY4x2OtZ8amn4QDnlgTWFkylbSPo4vrWVzf6Dnsq5k8pSugF8TATvRXyDmmZIY
         Nphhlv6LrjvoQIKzwsKA4WkfLG7TY/hNlPG8j6MF99gDogJ2WG5e3UO2H3Ee+CKqAcSf
         tV/qrquHHNQWX6AXJosGis6q+s5NG7zwtCI1nH0PQ+K3V9CYKpiPWAqPalbUCzfk9FDY
         TU4BlWTlrTnA8O+TEN2WW/BXh7CXoFtLo2sFT3OPVP2kaA5+6Z60E4Gxtqyq86tddwXU
         aoZMdhS5BhWexv4eD1hQgQg0J34OAqvob42eQ/tpYizKyQZeDh7iJD7EJc3e1RG8hN9/
         oXjQ==
X-Gm-Message-State: AOAM531lec66CbAENZQeoHvX4bpmaJye4b7yY6yzSNJuTXWoCr7Z4MIQ
        fXjcffRBMsPFRXNolcCUoW1hKb6Zg6krY9HshcpQfCe+ofZr
X-Google-Smtp-Source: ABdhPJyZlROu+4aHcckA8yVJ35pUpxIXpu/0oAsd5lMnu/tuMH2dH5fJWwr+WvzmrzsFkQ/WfZtvOHK9dpiZ9p+2TSsjLzoDZxGx
MIME-Version: 1.0
X-Received: by 2002:a92:1b85:: with SMTP id f5mr6751390ill.201.1599719175712;
 Wed, 09 Sep 2020 23:26:15 -0700 (PDT)
Date:   Wed, 09 Sep 2020 23:26:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035772805aeefa526@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in
 qlist_free_all (8)
From:   syzbot <syzbot+4bba137eaf7cc94b57ca@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    34d4ddd3 Merge tag 'linux-kselftest-5.9-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147c760d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=4bba137eaf7cc94b57ca
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bba137eaf7cc94b57ca@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000080
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 4bbac067 P4D 4bbac067 PUD 9468a067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3936 Comm: syz-executor.0 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:qlink_to_object mm/kasan/quarantine.c:137 [inline]
RIP: 0010:qlink_free mm/kasan/quarantine.c:142 [inline]
RIP: 0010:qlist_free_all+0x36/0x170 mm/kasan/quarantine.c:168
Code: 53 48 83 ec 10 48 8b 37 48 85 f6 0f 84 36 01 00 00 49 bf 00 00 00 00 00 fc ff df 48 85 ed 49 89 fd 48 89 ef 0f 84 97 00 00 00 <48> 63 87 80 00 00 00 4c 8b 26 48 29 c6 48 83 3d 75 e5 01 08 00 0f
RSP: 0018:ffffc90004dd7a10 EFLAGS: 00010246
RAX: ffffea0000000000 RBX: 0000000000000282 RCX: ffffea0000000007
RDX: 0000000000000000 RSI: ffff888000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8c5f5a77
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888000000000
R13: ffffc90004dd7a58 R14: 0000000000000200 R15: dffffc0000000000
FS:  0000000003563940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000080 CR3: 000000003d19c000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 quarantine_reduce+0x17e/0x200 mm/kasan/quarantine.c:261
 __kasan_kmalloc.constprop.0+0x9e/0xd0 mm/kasan/common.c:442
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc mm/slab.c:3312 [inline]
 __do_kmalloc mm/slab.c:3653 [inline]
 __kmalloc+0x178/0x310 mm/slab.c:3664
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
 tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
 tomoyo_encode+0x28/0x50 security/tomoyo/realpath.c:80
 tomoyo_path_perm+0x35f/0x3f0 security/tomoyo/file.c:831
 tomoyo_path_symlink+0x94/0xe0 security/tomoyo/tomoyo.c:200
 security_path_symlink+0xdf/0x150 security/security.c:1109
 do_symlinkat+0x123/0x2c0 fs/namei.c:3984
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d2e7
Code: 0f 1f 00 b8 5c 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 1d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 fd b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:000000000169fda8 EFLAGS: 00000202 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000045d2e7
RDX: 000000000169fe43 RSI: 00000000004c30cd RDI: 000000000169fe30
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000013
R10: 0000000000000075 R11: 0000000000000202 R12: 0000000000000000
R13: 000000000169fde0 R14: 0000000000000000 R15: 000000000169fdf0
Modules linked in:
CR2: 0000000000000080
---[ end trace 9fd83eee6918f461 ]---
RIP: 0010:qlink_to_object mm/kasan/quarantine.c:137 [inline]
RIP: 0010:qlink_free mm/kasan/quarantine.c:142 [inline]
RIP: 0010:qlist_free_all+0x36/0x170 mm/kasan/quarantine.c:168
Code: 53 48 83 ec 10 48 8b 37 48 85 f6 0f 84 36 01 00 00 49 bf 00 00 00 00 00 fc ff df 48 85 ed 49 89 fd 48 89 ef 0f 84 97 00 00 00 <48> 63 87 80 00 00 00 4c 8b 26 48 29 c6 48 83 3d 75 e5 01 08 00 0f
RSP: 0018:ffffc90004dd7a10 EFLAGS: 00010246
RAX: ffffea0000000000 RBX: 0000000000000282 RCX: ffffea0000000007
RDX: 0000000000000000 RSI: ffff888000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8c5f5a77
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888000000000
R13: ffffc90004dd7a58 R14: 0000000000000200 R15: dffffc0000000000
FS:  0000000003563940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000749198 CR3: 000000003d19c000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
