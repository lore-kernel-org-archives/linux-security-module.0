Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A553C433ED
	for <linux-security-module@archiver.kernel.org>; Sat,  8 May 2021 05:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A7761458
	for <linux-security-module@archiver.kernel.org>; Sat,  8 May 2021 05:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhEHFKn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 8 May 2021 01:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhEHFKn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 8 May 2021 01:10:43 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034DC061574
        for <linux-security-module@vger.kernel.org>; Fri,  7 May 2021 22:09:42 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o27so10712192qkj.9
        for <linux-security-module@vger.kernel.org>; Fri, 07 May 2021 22:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCSLJ5d/RjPqXaL4u8rtSDaM5xO9IxgkbYGilwRs0BY=;
        b=etNFWAVL70q0piRj1eyTBvYhf/ZahVvBLDYPYd5aCOFgSAJpepqb1E74Ne17HeKApV
         AZqY9IZda/RJWTSe34xkvjlJw9RGkfvxMNza+52WcsBQRZRakMIir8s5WTyDda2vx5Y8
         oWq460iC3vOFFVAr75n2uSkSm/ZNuXKCqrfDlduJiFqiOUq1M+CenmcpSzIIy7HE+zGh
         cr1qPWINzEcy+qzUge08B5RLwFP36GAnSgPuMIXFS/QflHcZZUH+J2fug/vI6Jtmr0VG
         d0ToLjSYfxjByhYrAoExa/rWo58Sbq4btZH2su0pfU4KZOq2m6pCwH6A0tBJpPVsr74a
         olKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCSLJ5d/RjPqXaL4u8rtSDaM5xO9IxgkbYGilwRs0BY=;
        b=pBEjLtYKbsWG6t8xBtqMTbgBjnSlnx28sCf5f171gbfN5Lc7ybt6vu8l11j3NpYz/E
         Kh2IJ3MiKnqDhczz7Tw3rZyIGv/osjqeAjOnwXA2P+nO63uCQH7sDr8iP7sQ+yQoSVFa
         rVFlK1u7/r5ClqggkuJcB0z7Zce1cLJGIfvEPZkbTaweZ7OlS49b2V0TS75NMTLOu+9x
         HME+pUyEM8J0R6OIZ1H6UvSmjZyPAHpiHLA/4DBrefVsnmcDmQ5lavBYEGb4YPSkvu7n
         FDFjdab0VoUzCkAbENFBiGSPJEMXVnMG2w384frbz6iVeOBNVufYnL05b9oMLxWz9NUG
         ko1Q==
X-Gm-Message-State: AOAM532quXX/IJqTADURYJDxZuxQC9YAkgDs80p9M5APHQIQSvHu2RLe
        IY8iRqr79uM6A1t3nvhZWvkxOZvBd3uc0PNDmbkmhQ==
X-Google-Smtp-Source: ABdhPJyd8r9cX2SY5Iggl/U1EAQ3BZfa0DpQVU1BFm3gJ0QBwuKyzzlmeA6xmwRw0jy7Im5POzdN7ziFUTIJZgFnFeI=
X-Received: by 2002:ae9:e850:: with SMTP id a77mr8670276qkg.424.1620450581431;
 Fri, 07 May 2021 22:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a91ed005c1ca7d5a@google.com>
In-Reply-To: <000000000000a91ed005c1ca7d5a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 8 May 2021 07:09:30 +0200
Message-ID: <CACT4Y+YFJgeJh1R5hTmBjTVVWY=Wnpk4mMx4Uv+++y0d6sMeNQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in tomoyo_encode2
To:     syzbot <syzbot+dbea9c4c82135d4f5da3@syzkaller.appspotmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 8, 2021 at 7:05 AM syzbot
<syzbot+dbea9c4c82135d4f5da3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=152ab345d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
> dashboard link: https://syzkaller.appspot.com/bug?extid=dbea9c4c82135d4f5da3
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dbea9c4c82135d4f5da3@syzkaller.appspotmail.com

Looks like another false positive caused by concurrent lockdep reports.

#syz fix: rcu: Reject RCU_LOCKDEP_WARN() false positives

[  181.705340][T11603] =============================
[  181.705345][T11603] WARNING: suspicious RCU usage
[  181.705351][T11603] 5.12.0-syzkaller #0 Not tainted
[  181.707688][T11626] ======================================================
[  181.707696][T11626] WARNING: possible circular locking dependency detected
[  181.710012][T11603] -----------------------------
[  181.710018][T11603] kernel/sched/core.c:8304 Illegal context switch
in RCU-bh read-side critical section!
[  181.714836][T11626] 5.12.0-syzkaller #0 Not tainted
[  181.714847][T11626] ------------------------------------------------------
[  181.714852][T11626] syz-executor.5/11626 is trying to acquire lock:
[  181.714863][T11626] ffff88814224c5a0 (&bdev->bd_mutex){+.+.}-{3:3},
at: del_gendisk+0x250/0x9e0



> =============================
> WARNING: suspicious RCU usage
> 5.12.0-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8304 Illegal context switch in RCU-bh read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 0
> 1 lock held by systemd-udevd/11603:
>  #0:
> ffffffff8c712b18
>  (
> tomoyo_ss
> ){....}-{0:0}
> , at: tomoyo_path_perm+0x1c1/0x400 security/tomoyo/file.c:847
>
> stack backtrace:
> CPU: 1 PID: 11603 Comm: systemd-udevd Not tainted 5.12.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8304
>  might_alloc include/linux/sched/mm.h:197 [inline]
>  slab_pre_alloc_hook mm/slab.h:497 [inline]
>  slab_alloc_node mm/slub.c:2827 [inline]
>  slab_alloc mm/slub.c:2916 [inline]
>  __kmalloc+0x26f/0x300 mm/slub.c:4054
>  kmalloc include/linux/slab.h:561 [inline]
>  kzalloc include/linux/slab.h:686 [inline]
>  tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
>  tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
>  tomoyo_encode+0x28/0x50 security/tomoyo/realpath.c:80
>  tomoyo_realpath_from_path+0x186/0x620 security/tomoyo/realpath.c:288
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
>  security_inode_getattr+0xcf/0x140 security/security.c:1295
>  vfs_getattr fs/stat.c:131 [inline]
>  vfs_statx+0x164/0x390 fs/stat.c:199
>  vfs_fstatat fs/stat.c:217 [inline]
>  vfs_stat include/linux/fs.h:3380 [inline]
>  __do_sys_newstat+0x91/0x110 fs/stat.c:359
>  do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7ffa23631295
> Code: 00 00 00 e8 5d 01 00 00 48 83 c4 18 c3 0f 1f 84 00 00 00 00 00 83 ff 01 48 89 f0 77 30 48 89 c7 48 89 d6 b8 04 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 03 f3 c3 90 48 8b 15 d1 db 2b 00 f7 d8 64 89
> RSP: 002b:00007fff554379b8 EFLAGS: 00000246
>  ORIG_RAX: 0000000000000004
> RAX: ffffffffffffffda RBX: 0000558bf63356b0 RCX: 00007ffa23631295
> RDX: 00007fff554379c0 RSI: 00007fff554379c0 RDI: 00007fff55437a70
> RBP: 00007fff55437ae0 R08: 000000000000c0c0 R09: 0000000000000000
> R10: 00007fff55437ac0 R11: 0000000000000246 R12: 00007fff55437af0
> R13: 0000000000000001 R14: 0000558bf63353b0 R15: 000000000000000e
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000a91ed005c1ca7d5a%40google.com.
