Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6281C4332B
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jan 2021 09:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D855238D7
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jan 2021 09:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbhAOJ6V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Jan 2021 04:58:21 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:55076 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbhAOJ6F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jan 2021 04:58:05 -0500
Received: by mail-io1-f69.google.com with SMTP id w26so13479314iox.21
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jan 2021 01:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CynjJtdaBwqxBrHsapSXcl0vG2PdK6CbxbTLdsQExGc=;
        b=Y2WnK/rnlHKupNSNMK5N1JXagrSWHqiJ92QcVk2SvjELBXLVcfencqsMpp6huIBETE
         WM9wkxsHo2jowoHZX4hxs1/zslCGYk11r217F7CCt5E2GSaJINVJUpkUqgUsB+2J69yf
         jR7VeRAzMBnaRUSUz4xy1OeC7Tc6O82L3ZpOO/ULyQjA7nb7Sd1rNTr+so59MyCQH6j1
         8gksD2qQM4miOROPB5awS3t8sMkj5Sosz8ByLczFCOU2fGDvsT7i5ApgDCJxqaSsv3I1
         mUSLQzrw8tY7F378z5SLhH1jx9h+wE9e0j3JuzOIb6wOnCSzqrYlI2a06xzehGlJZq4s
         p7hQ==
X-Gm-Message-State: AOAM5311xuzd8aOS4zN+4n5yKEZ8tLxblOE2bJrlahUX2yE4bmr9z7VS
        FG99gGJI0vOMm9ITBcOs6bQCedcZObBDHOfr2YzL9ekcjgWF
X-Google-Smtp-Source: ABdhPJzrXEwtRNW9Z+lSu7TMx/frVUXeZ/EV9AOvYNYqdLW1dkPpLZXrbNKg94kYp5HelnUAPRsLjl74raS5s9LhM/JFAhtRZxLK
MIME-Version: 1.0
X-Received: by 2002:a92:d40a:: with SMTP id q10mr10310261ilm.20.1610704645661;
 Fri, 15 Jan 2021 01:57:25 -0800 (PST)
Date:   Fri, 15 Jan 2021 01:57:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e36df05b8ed6677@google.com>
Subject: WARNING in smk_write_net4addr
From:   syzbot <syzbot+bf76b4978f531b8e2edb@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    5ee88057 Merge tag 'drm-fixes-2021-01-15' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a7c8f0d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee2266946ed36986
dashboard link: https://syzkaller.appspot.com/bug?extid=bf76b4978f531b8e2edb
compiler:       clang version 11.0.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf76b4978f531b8e2edb@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 14430 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Modules linked in:
CPU: 0 PID: 14430 Comm: syz-executor.0 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Code: aa 09 00 e9 dd fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c eb fd ff ff 4c 89 ef e8 54 aa 09 00 8b 74 24 18 e9 da fd ff ff <0f> 0b e9 f3 fd ff ff a9 00 00 08 00 75 16 8b 4c 24 1c 89 cb 81 e3
RSP: 0018:ffffc900177bf940 EFLAGS: 00010246
RAX: ffffc900177bf9c0 RBX: ffffc900177bf9c0 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc900177bf9e8
RBP: ffffc900177bfa80 R08: dffffc0000000000 R09: ffffc900177bf9c0
R10: fffff52002ef7f3d R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000012 R14: 1ffff92002ef7f34 R15: 0000000000040cc0
FS:  00007fb08b0ef700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f434a519010 CR3: 0000000011d3e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x40/0x130 mm/slab_common.c:837
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
 kmalloc_large include/linux/slab.h:481 [inline]
 __kmalloc_track_caller+0x246/0x330 mm/slub.c:4457
 memdup_user_nul+0x26/0xf0 mm/util.c:260
 smk_write_net4addr+0xde/0x13d0 security/smack/smackfs.c:1173
 vfs_write+0x289/0xc90 fs/read_write.c:603
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb08b0eec68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045e219
RDX: 00000000200000d6 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 000000000119bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007ffdff98265f R14: 00007fb08b0ef9c0 R15: 000000000119bf8c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
