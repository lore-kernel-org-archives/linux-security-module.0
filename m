Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60C6C433DB
	for <linux-security-module@archiver.kernel.org>; Sat, 16 Jan 2021 07:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7996723A5A
	for <linux-security-module@archiver.kernel.org>; Sat, 16 Jan 2021 07:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbhAPHj5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 16 Jan 2021 02:39:57 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:33086 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbhAPHj4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 16 Jan 2021 02:39:56 -0500
Received: by mail-io1-f71.google.com with SMTP id m3so19031914ioy.0
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jan 2021 23:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=XNO2X9QsJWsMKa6x0kj7dO5GxScLbpJTTbVeJMjwKF0=;
        b=G86rlBSxed4GbhSMpSEFA1pxKy0oKXcTwoosx+o7Ri8YW2nMtsg7RnSxJZ27CyLj8S
         3oAl7pgvCM3zcktdvGXOyxcfE8x0RScPEZl4LFRCBhaKnCdbYqz5lbUJMRzonY2GYbkb
         YMzkSOTBOYgkNxlvxMZjvIzeVBNJVrU4gvNy55ja2vIeGx2wKgk6WGhRfJ24jd4syBYI
         2alv4PcdR5oSdhEfuuaMkXbtYzcAAiUeLR4qRbTgVD0cN/5X+CXmKuAkh77wRBNDFN8b
         paSjwliv2V+JSpa46/8UZI65yLLjb3jmgzIpj9OPJL5FDkLE5na0kBRkjkyrVXsVxc8S
         RC+Q==
X-Gm-Message-State: AOAM532JH6DeMXZ8bis8+TN/oe2lJPGeIWI6tYwUGcbkjAZaEU+oIjdi
        bh4jm6MrBcVttFKPBVwCq7Oa+ZZeb8DrPIMChbKemoT0Fyu6
X-Google-Smtp-Source: ABdhPJxa0rcWUGUhDHoDvxnBVeJm7kaO1d4flGmxk2bqPMwv2znPn0nWNhhfTrtQgnct1KCP1rf7Ubjrv838fDwfJv2sSk/yWZ8P
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11a5:: with SMTP id 5mr2110532ilj.294.1610782755889;
 Fri, 15 Jan 2021 23:39:15 -0800 (PST)
Date:   Fri, 15 Jan 2021 23:39:15 -0800
In-Reply-To: <0000000000003e36df05b8ed6677@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9ab3905b8ff959f@google.com>
Subject: Re: WARNING in smk_write_net4addr
From:   syzbot <syzbot+bf76b4978f531b8e2edb@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot has found a reproducer for the following issue on:

HEAD commit:    f4e087c6 Merge tag 'acpi-5.11-rc4' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161212d0d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee2266946ed36986
dashboard link: https://syzkaller.appspot.com/bug?extid=bf76b4978f531b8e2edb
compiler:       clang version 11.0.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1449f3e0d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a71868d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf76b4978f531b8e2edb@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8454 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Modules linked in:
CPU: 0 PID: 8454 Comm: syz-executor791 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x4e5/0x5a0 mm/page_alloc.c:5020
Code: aa 09 00 e9 dd fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c eb fd ff ff 4c 89 ef e8 54 aa 09 00 8b 74 24 18 e9 da fd ff ff <0f> 0b e9 f3 fd ff ff a9 00 00 08 00 75 16 8b 4c 24 1c 89 cb 81 e3
RSP: 0018:ffffc9000945f940 EFLAGS: 00010246
RAX: ffffc9000945f9c0 RBX: ffffc9000945f9c0 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc9000945f9e8
RBP: ffffc9000945fa80 R08: dffffc0000000000 R09: ffffc9000945f9c0
R10: fffff5200128bf3d R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000012 R14: 1ffff9200128bf34 R15: 0000000000040cc0
FS:  0000000000ffe880(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 000000001c506000 CR4: 00000000001506f0
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
RIP: 0033:0x440249
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff42192178 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440249
RDX: 00000000200001e2 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a50
R13: 0000000000401ae0 R14: 0000000000000000 R15: 0000000000000000

