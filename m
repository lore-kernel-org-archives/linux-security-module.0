Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F0FC43460
	for <linux-security-module@archiver.kernel.org>; Mon, 10 May 2021 13:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258EE61288
	for <linux-security-module@archiver.kernel.org>; Mon, 10 May 2021 13:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbhEJNdj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 May 2021 09:33:39 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48831 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344802AbhEJMUX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 May 2021 08:20:23 -0400
Received: by mail-il1-f198.google.com with SMTP id h4-20020a926c040000b0290192f4fa4c3bso13569707ilc.15
        for <linux-security-module@vger.kernel.org>; Mon, 10 May 2021 05:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LIsysw+22kJoVtdEn0ARG+JVEdMdBtBx51RjL3I2/Tk=;
        b=NJtw/kdRjIjIbo5OGK5Df6pkIMRhVIZD8q9St8uHoxDFT2+7OrP4Ydk80OKN2HguEm
         lqvN9XdmSt44s6EAJ+i7uoGhoaGYkfEifdjRQxqn99zzggkaTGzi5mq+0GqmCxnpWaIm
         bBzq0J0xVLvZuW5FhpTxEr3NX8Z6p9AOlJjnsGzP2tUPZhKgt8jK4x2Ly95cLD1jaY6T
         8n+86gYj1LX/e/c/+YKiSL1a3PlXqXP5gSdsDmoOcfnmLrTM80353Kt2G/7XaWQQgPSk
         ddmsLEo7DMdhWjgRXfVnMTSruf73iJNZh5y27OuyGxeSRaVASjiUJrv+eED/LNYWkvmy
         j2MA==
X-Gm-Message-State: AOAM530PYY+DmMUaYGI4p8izWOPJM0/iDroqa0ib9AozRLROjd2Bucdy
        ECZTR/kJxoQHAo1zX7teFRl2527pOquJez6TnCi1AeWhsqZ9
X-Google-Smtp-Source: ABdhPJwiqnW7Qb1We7cNl8N28tyshNYYabZIjlibGO6iNBPyJmQU/lUn76wY7epMNeYvZ48V9/OSJgb7NToOHS37ma24vqhZuAHn
MIME-Version: 1.0
X-Received: by 2002:a92:2a0a:: with SMTP id r10mr21447954ile.274.1620649158133;
 Mon, 10 May 2021 05:19:18 -0700 (PDT)
Date:   Mon, 10 May 2021 05:19:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000604ea605c1f8c9af@google.com>
Subject: [syzbot] possible deadlock in process_measurement (3)
From:   syzbot <syzbot+ccfcdc8958f74084f16d@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

syzbot found the following issue on:

HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f425b3d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
dashboard link: https://syzkaller.appspot.com/bug?extid=ccfcdc8958f74084f16d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16079d1ed00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12280d95d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccfcdc8958f74084f16d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.12.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor167/10873 is trying to acquire lock:
ffff8880162d0bc0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3a8/0x17e0 security/integrity/ima/ima_main.c:253

but task is already holding lock:
ffff888147e2e460 (sb_writers#5){.+.+}-{0:0}, at: do_open fs/namei.c:3354 [inline]
ffff888147e2e460 (sb_writers#5){.+.+}-{0:0}, at: path_openat+0x1ad9/0x27e0 fs/namei.c:3494

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sb_writers#5){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1765 [inline]
       sb_start_write include/linux/fs.h:1835 [inline]
       mnt_want_write+0x6e/0x3e0 fs/namespace.c:375
       ovl_maybe_copy_up+0x11f/0x190 fs/overlayfs/copy_up.c:995
       ovl_open+0xba/0x270 fs/overlayfs/file.c:149
       do_dentry_open+0x4b9/0x11b0 fs/open.c:826
       vfs_open fs/open.c:940 [inline]
       dentry_open+0x132/0x1d0 fs/open.c:956
       ima_calc_file_hash+0x2d2/0x4b0 security/integrity/ima/ima_crypto.c:557
       ima_collect_measurement+0x4ca/0x570 security/integrity/ima/ima_api.c:252
       process_measurement+0xd1c/0x17e0 security/integrity/ima/ima_main.c:330
       ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:499
       do_open fs/namei.c:3363 [inline]
       path_openat+0x15b5/0x27e0 fs/namei.c:3494
       do_filp_open+0x190/0x3d0 fs/namei.c:3521
       do_sys_openat2+0x16d/0x420 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1207
       do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&iint->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2938 [inline]
       check_prevs_add kernel/locking/lockdep.c:3061 [inline]
       validate_chain kernel/locking/lockdep.c:3676 [inline]
       __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4902
       lock_acquire kernel/locking/lockdep.c:5512 [inline]
       lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
       __mutex_lock_common kernel/locking/mutex.c:949 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
       process_measurement+0x3a8/0x17e0 security/integrity/ima/ima_main.c:253
       ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:499
       do_open fs/namei.c:3363 [inline]
       path_openat+0x15b5/0x27e0 fs/namei.c:3494
       do_filp_open+0x190/0x3d0 fs/namei.c:3521
       do_sys_openat2+0x16d/0x420 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1207
       do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#5);
                               lock(&iint->mutex);
                               lock(sb_writers#5);
  lock(&iint->mutex);

 *** DEADLOCK ***

1 lock held by syz-executor167/10873:
 #0: ffff888147e2e460 (sb_writers#5){.+.+}-{0:0}, at: do_open fs/namei.c:3354 [inline]
 #0: ffff888147e2e460 (sb_writers#5){.+.+}-{0:0}, at: path_openat+0x1ad9/0x27e0 fs/namei.c:3494

stack backtrace:
CPU: 1 PID: 10873 Comm: syz-executor167 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2129
 check_prev_add kernel/locking/lockdep.c:2938 [inline]
 check_prevs_add kernel/locking/lockdep.c:3061 [inline]
 validate_chain kernel/locking/lockdep.c:3676 [inline]
 __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4902
 lock_acquire kernel/locking/lockdep.c:5512 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
 __mutex_lock_common kernel/locking/mutex.c:949 [inline]
 __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
 process_measurement+0x3a8/0x17e0 security/integrity/ima/ima_main.c:253
 ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:499
 do_open fs/namei.c:3363 [inline]
 path_openat+0x15b5/0x27e0 fs/namei.c:3494
 do_filp_open+0x190/0x3d0 fs/namei.c:3521
 do_sys_openat2+0x16d/0x420 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_open fs/open.c:1211 [inline]
 __se_sys_open fs/open.c:1207 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1207
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446119
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff688b472f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00000000004cb4c0 RCX: 0000000000446119
RDX: 0000000000000000 RSI: 0000000000000300 RDI: 0000000020000040
RBP: 000000000049b06c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 3d72696472657070 R14: 0079616c7265766f R15: 00000000004cb4c8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
