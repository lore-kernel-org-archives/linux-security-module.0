Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5619C433E6
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jan 2021 11:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E7B238E8
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jan 2021 11:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAOLoJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:44:09 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:38400 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOLoI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jan 2021 06:44:08 -0500
Received: by mail-io1-f71.google.com with SMTP id q140so14086869iod.5
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jan 2021 03:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hpftx0jAbEhydpZgk9H3QZlGfFkysavuEi8adv7RKds=;
        b=l9t0/r6SKZ+xdXn1vSbE3LitDLLQj1JTUsEpqC3lVY9Wd1XrG/O38U5t0bpKmAVQbx
         JzGAVybLX4+BLthHuhXpqlkvJpblmwGffWtJRLFkbaflIiMNd0KIDasONoMLS0KQ1eiW
         EyOJpAskDRGnUF37mpEWhHOxz/1iY3nNIDBfrcWBkpfo5MVILrn78wc7c1juhEof/rKf
         PiAzqKSdekgNPyHCsD1PU+FLHu8p2A3rUdV/vU8TytFeG1ipgbMaHyBICh4HPedGv3Rk
         w7MygEpRgP6jDJP7/+8vVyzzxta/tYzSt31GaNnmX0t8iRIDk+rsSd4eda5xH8iQiq9y
         hoDA==
X-Gm-Message-State: AOAM531+l8txzmvIz1ECnriX8fvYyOkfA0rlmZBZ6jfngl/0jA4/yBA6
        PjqHG4fDlYM1d1kml6Kv4zhOSJZNHbghyk8dtVUOBTSQCaNc
X-Google-Smtp-Source: ABdhPJwjmrFwQlb+qBOZ4wN2CHp7/cgF51rpj0BMoV9EtlktQh2agcShFwn5uuexu5w0lSeAfNKLkN66mJghx+oA5rrFkXV6oj4n
MIME-Version: 1.0
X-Received: by 2002:a92:b6ca:: with SMTP id m71mr10328318ill.232.1610711007730;
 Fri, 15 Jan 2021 03:43:27 -0800 (PST)
Date:   Fri, 15 Jan 2021 03:43:27 -0800
In-Reply-To: <00000000000077819e05b8e0acc8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073a06905b8eee114@google.com>
Subject: Re: WARNING in smk_write_relabel_self
From:   syzbot <syzbot+670d1a1e6b6face0440a@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot has found a reproducer for the following issue on:

HEAD commit:    5ee88057 Merge tag 'drm-fixes-2021-01-15' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a68ee7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee2266946ed36986
dashboard link: https://syzkaller.appspot.com/bug?extid=670d1a1e6b6face0440a
compiler:       clang version 11.0.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ec309f500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d8889f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+670d1a1e6b6face0440a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8457 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Modules linked in:
CPU: 0 PID: 8457 Comm: syz-executor864 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Code: aa 09 00 e9 dd fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c eb fd ff ff 4c 89 ef e8 54 aa 09 00 8b 74 24 18 e9 da fd ff ff <0f> 0b e9 f3 fd ff ff a9 00 00 08 00 75 16 8b 4c 24 1c 89 cb 81 e3
RSP: 0018:ffffc900012ef9a0 EFLAGS: 00010246
RAX: ffffc900012efa20 RBX: ffffc900012efa20 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc900012efa48
RBP: ffffc900012efae0 R08: dffffc0000000000 R09: ffffc900012efa20
R10: fffff5200025df49 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000012 R14: 1ffff9200025df40 R15: 0000000000040cc0
FS:  00000000023a2880(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8e9dc94000 CR3: 0000000014b8a000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x40/0x130 mm/slab_common.c:837
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
 kmalloc_large include/linux/slab.h:481 [inline]
 __kmalloc_track_caller+0x246/0x330 mm/slub.c:4457
 memdup_user_nul+0x26/0xf0 mm/util.c:260
 smk_write_relabel_self+0x17a/0x510 security/smack/smackfs.c:2748
 vfs_write+0x289/0xc90 fs/read_write.c:603
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440389
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd61b9f558 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440389
RDX: 0000000020000398 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b90
R13: 0000000000401c20 R14: 0000000000000000 R15: 0000000000000000

