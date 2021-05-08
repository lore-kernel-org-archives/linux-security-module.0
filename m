Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDB3C433B4
	for <linux-security-module@archiver.kernel.org>; Sat,  8 May 2021 05:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0646A61458
	for <linux-security-module@archiver.kernel.org>; Sat,  8 May 2021 05:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhEHFGW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 8 May 2021 01:06:22 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42881 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhEHFGU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 8 May 2021 01:06:20 -0400
Received: by mail-il1-f199.google.com with SMTP id d3-20020a9287430000b0290181f7671fa1so8900963ilm.9
        for <linux-security-module@vger.kernel.org>; Fri, 07 May 2021 22:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GUKHVffTroMPkN1GTO/JKiOfk0hWwy68tj5egZoskrM=;
        b=DBSpAXPeOT6aV6gCv4hvXszvA6TaGGhMuSxMRpyvrZR0fI4H9YaXkITCDsH26suv5S
         BzcQtm3p9pQ5F23GQLeEg/ZrokkKZgbYu/0Iq0CUw0wBe6Czk7jz46SnbX4w5r3827b4
         AjAf7YngYeKZDIwH5NeXx8XTFg3G69L/DswbqzbJqUlqwu0UCeRni7ujd+Pr9s0TgpWG
         vTrlGsar2MxKT0n7PqqT2iNAvg8xJmtrGMm/TAXQ5jz9jKb4JwfedIsPGF6MAoI6B9ik
         BUR+tUrB874dcrIhVLUlnAKKLrLvP6v9988MV6HpcOrFr8hrFpYWYFDorOVYeuz5LUDa
         lvZQ==
X-Gm-Message-State: AOAM533YDZ45sg0/so2HWL5xelHbSF005E9pcITWWAvta987OsnakPFl
        ZExsrae/CWPSaPC9E+j56GXod0PNU+mvBNJ0q3lVYiEZLYh3
X-Google-Smtp-Source: ABdhPJxDbbllpGM2AovnnY/H+FneY36oV6L1ODDMbWqJjrOnOH3xdiA/RvBx+ebZq5cQKa5ZS3JnP9tXZrMKkPgL26zmFFpTfdtY
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d7:: with SMTP id w23mr12364812jao.14.1620450319341;
 Fri, 07 May 2021 22:05:19 -0700 (PDT)
Date:   Fri, 07 May 2021 22:05:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a91ed005c1ca7d5a@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in tomoyo_encode2
From:   syzbot <syzbot+dbea9c4c82135d4f5da3@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152ab345d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
dashboard link: https://syzkaller.appspot.com/bug?extid=dbea9c4c82135d4f5da3

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbea9c4c82135d4f5da3@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.12.0-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8304 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
1 lock held by systemd-udevd/11603:
 #0: 
ffffffff8c712b18
 (
tomoyo_ss
){....}-{0:0}
, at: tomoyo_path_perm+0x1c1/0x400 security/tomoyo/file.c:847

stack backtrace:
CPU: 1 PID: 11603 Comm: systemd-udevd Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8304
 might_alloc include/linux/sched/mm.h:197 [inline]
 slab_pre_alloc_hook mm/slab.h:497 [inline]
 slab_alloc_node mm/slub.c:2827 [inline]
 slab_alloc mm/slub.c:2916 [inline]
 __kmalloc+0x26f/0x300 mm/slub.c:4054
 kmalloc include/linux/slab.h:561 [inline]
 kzalloc include/linux/slab.h:686 [inline]
 tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
 tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
 tomoyo_encode+0x28/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x186/0x620 security/tomoyo/realpath.c:288
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
 security_inode_getattr+0xcf/0x140 security/security.c:1295
 vfs_getattr fs/stat.c:131 [inline]
 vfs_statx+0x164/0x390 fs/stat.c:199
 vfs_fstatat fs/stat.c:217 [inline]
 vfs_stat include/linux/fs.h:3380 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:359
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ffa23631295
Code: 00 00 00 e8 5d 01 00 00 48 83 c4 18 c3 0f 1f 84 00 00 00 00 00 83 ff 01 48 89 f0 77 30 48 89 c7 48 89 d6 b8 04 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 03 f3 c3 90 48 8b 15 d1 db 2b 00 f7 d8 64 89
RSP: 002b:00007fff554379b8 EFLAGS: 00000246
 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000558bf63356b0 RCX: 00007ffa23631295
RDX: 00007fff554379c0 RSI: 00007fff554379c0 RDI: 00007fff55437a70
RBP: 00007fff55437ae0 R08: 000000000000c0c0 R09: 0000000000000000
R10: 00007fff55437ac0 R11: 0000000000000246 R12: 00007fff55437af0
R13: 0000000000000001 R14: 0000558bf63353b0 R15: 000000000000000e


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
