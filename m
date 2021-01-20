Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D6EC433DB
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Jan 2021 02:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBA0230FE
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Jan 2021 02:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbhATCkI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Jan 2021 21:40:08 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:38060 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbhATCkF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Jan 2021 21:40:05 -0500
Received: by mail-io1-f71.google.com with SMTP id k7so14724808ioj.5
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jan 2021 18:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uOOVMaYJOnDj0a+mzim/iJ2rWq1WCzOjMvUsEdd7Bhk=;
        b=UwBJODTXlZivF2XPr43UheusHErOl8PH7zKLIIcj+ejWv8uMeHd6CdY/rpcVZFpj3Z
         GY4sK9N4Bat5CufpnDl5ddGe5SuUaur7u7e5DwQm4hMiCTZ8qHS3bjZ/wNP/sDyJYmVn
         9vHdduFTKgBeGgGX5XPqOPPPD6Z2knPm+yUbulqAOzUzmWNm17/OIO65LbOLaTuKSJtb
         OXXq5BDZIOMnQ6X6cnuzitLbYeb209unr0nF75NwOfWnom2oRWKAA92DrT92pVerQ6Yv
         IIDHdNh5DlA8sIyiszrBMhonJhZrzKFzB1eSiJAoRSOkv1yrRbN4x0UOMrc7q6tDDgTE
         wd3g==
X-Gm-Message-State: AOAM5311JZnsrjLyelCGXUwJVPOXoN2LpLW83sNyELVje2+s282OMtSx
        COeJsgb+63zXe0rP0QCr8Syiv5FDroXM1zdOfn97GVmL2F6q
X-Google-Smtp-Source: ABdhPJyMKlpFB/Tck473QjFwXVvBgyrcx1doEHy6KciF2taU1tvMGYx9AItXodVnjKeDci2Hglr8pWfEBoZI/2knWweUm8lD5EqV
MIME-Version: 1.0
X-Received: by 2002:a92:48ce:: with SMTP id j75mr5974053ilg.160.1611110363621;
 Tue, 19 Jan 2021 18:39:23 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:39:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eaf03c05b94bdc14@google.com>
Subject: WARNING in smk_write_syslog
From:   syzbot <syzbot+f61aa9ae0d663fb8dd9f@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    f4e087c6 Merge tag 'acpi-5.11-rc4' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13442aaf500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee2266946ed36986
dashboard link: https://syzkaller.appspot.com/bug?extid=f61aa9ae0d663fb8dd9f
compiler:       clang version 11.0.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13871868d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fcede0d00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162fbed0d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=152fbed0d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=112fbed0d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f61aa9ae0d663fb8dd9f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8453 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Modules linked in:
CPU: 1 PID: 8453 Comm: syz-executor915 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Code: aa 09 00 e9 dd fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c eb fd ff ff 4c 89 ef e8 54 aa 09 00 8b 74 24 18 e9 da fd ff ff <0f> 0b e9 f3 fd ff ff a9 00 00 08 00 75 16 8b 4c 24 1c 89 cb 81 e3
RSP: 0018:ffffc90001047a60 EFLAGS: 00010246
RAX: ffffc90001047ae0 RBX: ffffc90001047ae0 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90001047b08
RBP: ffffc90001047ba0 R08: dffffc0000000000 R09: ffffc90001047ae0
R10: fffff52000208f61 R11: 0000000000000000 R12: dffffc0000000000
R13: 000000000000000c R14: 1ffff92000208f58 R15: 0000000000040cc0
FS:  0000000000ef8880(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcb9592bf38 CR3: 0000000017fee000 CR4: 00000000001506e0
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
RIP: 0033:0x440249
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdedc36ac8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440249
RDX: 0000000000f0ff7f RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a50
R13: 0000000000401ae0 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
