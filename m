Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C47AC07E96
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Jul 2021 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591C961369
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Jul 2021 18:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhGMSKP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:10:15 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:53979 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbhGMSKP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Jul 2021 14:10:15 -0400
Received: by mail-il1-f198.google.com with SMTP id j6-20020a926e060000b02901f2f7ba704aso15280097ilc.20
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jul 2021 11:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hx45N4k+4Z2tVC49Axkuc3Q0IugSpxdue/FcmmF4DmI=;
        b=CPQUAxit+APEklthGWCytzT6h9lBoPYXKlA6KY0EVq+7CsNBHmRg9mNBLNK12gJREi
         s+8KykkwhO0kIEo0j13+6cd+HXnLoN2V/hThBRmjKn4t51wF4wM+CIUtkP8aG+qH7/UI
         JMsfYpA+Qp8QyP14O8byHlt1yIUHo7OgM2iQyIDxLmxUcO81lNmO8JktZGvgvIdTpNiW
         2EYA29aWEGLJ+cClADSEaPWaWLk8i2S5wjLeR12zDnKIbtWWIw2faxDEOIYvA8EcKqU6
         vq8KKMYGKcVnWIiKLu+nDX5dmiCBora5PO/4DZ9TDGmieGq3JjZ7omLTiPFO1+G2b5Mb
         dZNg==
X-Gm-Message-State: AOAM530AWuD6/YcHLncgoTpIAiRl3JgUqa24q1Y+2FBm5VmG5kHXeDl4
        FIT/w+RWyAMeGBoRrwlBTBgESt1VlZSgLE/0yEYeT+lW5u3H
X-Google-Smtp-Source: ABdhPJwakdCmZ54yFmPNoCDulm1hLgI0er72w8b8WJITPiulr6TdM7TldoP9jp+MAsHlQZyYmybsawg2/18l4SJ52vzbL2iQ16di
MIME-Version: 1.0
X-Received: by 2002:a05:6638:618:: with SMTP id g24mr5239391jar.16.1626199644520;
 Tue, 13 Jul 2021 11:07:24 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:07:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002545e805c7051ce0@google.com>
Subject: [syzbot] memory leak in dev_exception_add
From:   syzbot <syzbot+988c8a25ad1677559236@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1518cffc300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55ac6a927d7e3fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=988c8a25ad1677559236
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1500e772300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+988c8a25ad1677559236@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810d3a4300 (size 64):
  comm "systemd", pid 1, jiffies 4294938536 (age 1351.150s)
  hex dump (first 32 bytes):
    01 00 00 00 03 00 00 00 02 00 07 00 00 00 00 00  ................
    10 04 2b 0d 81 88 ff ff 22 01 00 00 00 00 ad de  ..+.....".......
  backtrace:
    [<ffffffff81479633>] kmemdup+0x23/0x50 mm/util.c:128
    [<ffffffff8217485f>] kmemdup include/linux/fortify-string.h:270 [inline]
    [<ffffffff8217485f>] dev_exception_add+0x2f/0x160 security/device_cgroup.c:94
    [<ffffffff82175812>] devcgroup_update_access security/device_cgroup.c:734 [inline]
    [<ffffffff82175812>] devcgroup_access_write+0x8c2/0x9e0 security/device_cgroup.c:764
    [<ffffffff813198bd>] cgroup_file_write+0x10d/0x260 kernel/cgroup/cgroup.c:3814
    [<ffffffff81690535>] kernfs_fop_write_iter+0x1b5/0x270 fs/kernfs/file.c:296
    [<ffffffff81560eb7>] call_write_iter include/linux/fs.h:2114 [inline]
    [<ffffffff81560eb7>] new_sync_write+0x1d7/0x2b0 fs/read_write.c:518
    [<ffffffff81564531>] vfs_write+0x351/0x400 fs/read_write.c:605
    [<ffffffff8156481d>] ksys_write+0x9d/0x160 fs/read_write.c:658
    [<ffffffff8439b235>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8439b235>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810d2b0400 (size 64):
  comm "systemd", pid 1, jiffies 4294938537 (age 1351.140s)
  hex dump (first 32 bytes):
    01 00 00 00 05 00 00 00 02 00 07 00 00 00 00 00  ................
    90 ac 3b 0d 81 88 ff ff 22 01 00 00 00 00 ad de  ..;.....".......
  backtrace:
    [<ffffffff81479633>] kmemdup+0x23/0x50 mm/util.c:128
    [<ffffffff8217485f>] kmemdup include/linux/fortify-string.h:270 [inline]
    [<ffffffff8217485f>] dev_exception_add+0x2f/0x160 security/device_cgroup.c:94
    [<ffffffff82175812>] devcgroup_update_access security/device_cgroup.c:734 [inline]
    [<ffffffff82175812>] devcgroup_access_write+0x8c2/0x9e0 security/device_cgroup.c:764
    [<ffffffff813198bd>] cgroup_file_write+0x10d/0x260 kernel/cgroup/cgroup.c:3814
    [<ffffffff81690535>] kernfs_fop_write_iter+0x1b5/0x270 fs/kernfs/file.c:296
    [<ffffffff81560eb7>] call_write_iter include/linux/fs.h:2114 [inline]
    [<ffffffff81560eb7>] new_sync_write+0x1d7/0x2b0 fs/read_write.c:518
    [<ffffffff81564531>] vfs_write+0x351/0x400 fs/read_write.c:605
    [<ffffffff8156481d>] ksys_write+0x9d/0x160 fs/read_write.c:658
    [<ffffffff8439b235>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8439b235>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810d3bac80 (size 64):
  comm "systemd", pid 1, jiffies 4294938537 (age 1351.140s)
  hex dump (first 32 bytes):
    01 00 00 00 07 00 00 00 02 00 07 00 00 00 00 00  ................
    50 84 31 0d 81 88 ff ff 22 01 00 00 00 00 ad de  P.1.....".......
  backtrace:
    [<ffffffff81479633>] kmemdup+0x23/0x50 mm/util.c:128
    [<ffffffff8217485f>] kmemdup include/linux/fortify-string.h:270 [inline]
    [<ffffffff8217485f>] dev_exception_add+0x2f/0x160 security/device_cgroup.c:94
    [<ffffffff82175812>] devcgroup_update_access security/device_cgroup.c:734 [inline]
    [<ffffffff82175812>] devcgroup_access_write+0x8c2/0x9e0 security/device_cgroup.c:764
    [<ffffffff813198bd>] cgroup_file_write+0x10d/0x260 kernel/cgroup/cgroup.c:3814
    [<ffffffff81690535>] kernfs_fop_write_iter+0x1b5/0x270 fs/kernfs/file.c:296
    [<ffffffff81560eb7>] call_write_iter include/linux/fs.h:2114 [inline]
    [<ffffffff81560eb7>] new_sync_write+0x1d7/0x2b0 fs/read_write.c:518
    [<ffffffff81564531>] vfs_write+0x351/0x400 fs/read_write.c:605
    [<ffffffff8156481d>] ksys_write+0x9d/0x160 fs/read_write.c:658
    [<ffffffff8439b235>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8439b235>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88810d318440 (size 64):
  comm "systemd", pid 1, jiffies 4294938537 (age 1351.140s)
  hex dump (first 32 bytes):
    01 00 00 00 08 00 00 00 02 00 07 00 00 00 00 00  ................
    d0 aa 3b 0d 81 88 ff ff 22 01 00 00 00 00 ad de  ..;.....".......
  backtrace:
    [<ffffffff81479633>] kmemdup+0x23/0x50 mm/util.c:128
    [<ffffffff8217485f>] kmemdup include/linux/fortify-string.h:270 [inline]
    [<ffffffff8217485f>] dev_exception_add+0x2f/0x160 security/device_cgroup.c:94
    [<ffffffff82175812>] devcgroup_update_access security/device_cgroup.c:734 [inline]
    [<ffffffff82175812>] devcgroup_access_write+0x8c2/0x9e0 security/device_cgroup.c:764
    [<ffffffff813198bd>] cgroup_file_write+0x10d/0x260 kernel/cgroup/cgroup.c:3814
    [<ffffffff81690535>] kernfs_fop_write_iter+0x1b5/0x270 fs/kernfs/file.c:296
    [<ffffffff81560eb7>] call_write_iter include/linux/fs.h:2114 [inline]
    [<ffffffff81560eb7>] new_sync_write+0x1d7/0x2b0 fs/read_write.c:518
    [<ffffffff81564531>] vfs_write+0x351/0x400 fs/read_write.c:605
    [<ffffffff8156481d>] ksys_write+0x9d/0x160 fs/read_write.c:658
    [<ffffffff8439b235>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8439b235>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

[ 1363.912106][    C1]


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
