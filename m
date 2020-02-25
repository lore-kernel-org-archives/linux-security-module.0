Return-Path: <SRS0=WY9+=4N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28535C35E03
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Feb 2020 14:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D8921744
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Feb 2020 14:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZHgAtt+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgBYOU5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:20:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42910 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbgBYOU4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Feb 2020 09:20:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so16392302edv.9
        for <linux-security-module@vger.kernel.org>; Tue, 25 Feb 2020 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0DDJv++iHMwFovcTSUdqNPnf7WFz++klT2C8MF2YAk=;
        b=ZHgAtt+ZWNZuRLCOtkQ+cnzsMFKlWKGsHwIWalC0ewkaUXugyhDoTqYEH9X4i0GGZv
         orFXRyBhjJf0ltZGcarH36Nnhr4EWIvzKdVUKjBvlY5hUGC9NWUG4mIXYJGxCmZj4hax
         jx489NWyobGvzkLEmJDQXdvShmP0IgX1nzbjjaKHmIhjgw3l2N8Iszwq7QMxK6iA/Ulf
         muQzUDLQTE2obbByzg766pxkaheuuqcG4bb9N49Nb2xKEvSaa8QpFgSFuh6+H36LI965
         UXD1VCiKR39dD1YCe1MiDdMu/YOAtPmIQbkCHWGssJkQZEPQQnP8duIrt5gAhOZKpNes
         WB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0DDJv++iHMwFovcTSUdqNPnf7WFz++klT2C8MF2YAk=;
        b=rBxfYeHKI1RZp9p8EnANaXJ9mO8RZ5yQHJZVf6Le9ywV+S1u415pLISfcAe+qRbUFk
         uBuDDKbWu2HYOWOvDVf05rL24Ax9wR/yArNY5J+fRTUephV+M43i3R4PqnqmDK4b8RPs
         0DhGoigch3ulNyB8nfpElkaNiHfwxhTtjW+chqW3JnsgeM9qDIsRcpibyfoiYTPXQGQX
         wtWwA+/H3xi0hecCNYZytNqnCWE3v8z7KzJpOsUKUqP444fDtKYqgR0aHNq+sGnkEnSb
         tTL3fsxXEIMxF0JjZxXjZ9Ffkj3K783Igvy6PtRcFa3vCB7OYuMNEV2Zo0h8mlPKdSaw
         tbTw==
X-Gm-Message-State: APjAAAXFECtN8wOnZwYTqMDIRy+hCT+DjjqjHwgQzs2kNZMMc3vmrM3O
        +TO57lCu5ynrjq3LNSjS+fUYuVrdmhA5mPzqLQkA
X-Google-Smtp-Source: APXvYqwWKX3jUx2E5vy+abrEsYm2bW9GwEripUqXhbnIh2aKLOWYSU7BVwy2dpskrNrYbYThDA/eBzwYY572UgTANug=
X-Received: by 2002:a50:e108:: with SMTP id h8mr49416136edl.196.1582640455132;
 Tue, 25 Feb 2020 06:20:55 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a719a9059f62246e@google.com>
In-Reply-To: <000000000000a719a9059f62246e@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Feb 2020 09:20:44 -0500
Message-ID: <CAHC9VhTh6s1m7YBZp-3XO3q2EcjtMKUTcXwRzDTj_LSJd+cHTA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in cipso_v4_sock_setattr
To:     syzbot <syzbot+f4dfece964792d80b139@syzkaller.appspotmail.com>
Cc:     cpaasch@apple.com, davem@davemloft.net, dcaratti@redhat.com,
        fw@strlen.de, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        matthieu.baerts@tessares.net, netdev@vger.kernel.org,
        pabeni@redhat.com, peter.krystad@linux.intel.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 25, 2020 at 3:19 AM syzbot
<syzbot+f4dfece964792d80b139@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    ca7e1fd1 Merge tag 'linux-kselftest-5.6-rc3' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=179f0931e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a61f2164c515c07f
> dashboard link: https://syzkaller.appspot.com/bug?extid=f4dfece964792d80b139
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fdfdede00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17667de9e00000
>
> The bug was bisected to:
>
> commit 2303f994b3e187091fd08148066688b08f837efc
> Author: Peter Krystad <peter.krystad@linux.intel.com>
> Date:   Wed Jan 22 00:56:17 2020 +0000
>
>     mptcp: Associate MPTCP context with TCP socket
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fbec81e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=16fbec81e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12fbec81e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f4dfece964792d80b139@syzkaller.appspotmail.com
> Fixes: 2303f994b3e1 ("mptcp: Associate MPTCP context with TCP socket")
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD 8e171067 P4D 8e171067 PUD 93fa2067 PMD 0
> Oops: 0010 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8984 Comm: syz-executor066 Not tainted 5.6.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:0x0
> Code: Bad RIP value.
> RSP: 0018:ffffc900020b7b80 EFLAGS: 00010246
> RAX: 1ffff110124ba600 RBX: 0000000000000000 RCX: ffff88809fefa600
> RDX: ffff8880994cdb18 RSI: 0000000000000000 RDI: ffff8880925d3140
> RBP: ffffc900020b7bd8 R08: ffffffff870225be R09: fffffbfff140652a
> R10: fffffbfff140652a R11: 0000000000000000 R12: ffff8880925d35d0
> R13: ffff8880925d3140 R14: dffffc0000000000 R15: 1ffff110124ba6ba
> FS:  0000000001a0b880(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 00000000a6d6f000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  cipso_v4_sock_setattr+0x34b/0x470 net/ipv4/cipso_ipv4.c:1888
>  netlbl_sock_setattr+0x2a7/0x310 net/netlabel/netlabel_kapi.c:989
>  smack_netlabel security/smack/smack_lsm.c:2425 [inline]
>  smack_inode_setsecurity+0x3da/0x4a0 security/smack/smack_lsm.c:2716
>  security_inode_setsecurity+0xb2/0x140 security/security.c:1364
>  __vfs_setxattr_noperm+0x16f/0x3e0 fs/xattr.c:197
>  vfs_setxattr fs/xattr.c:224 [inline]
>  setxattr+0x335/0x430 fs/xattr.c:451
>  __do_sys_fsetxattr fs/xattr.c:506 [inline]
>  __se_sys_fsetxattr+0x130/0x1b0 fs/xattr.c:495
>  __x64_sys_fsetxattr+0xbf/0xd0 fs/xattr.c:495
>  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Netdev folks, I'm not very familiar with the multipath TCP code so I
was wondering if you might help me out a bit with this report.  Based
on the stack trace above it looks like for a given AF_INET sock "sk",
inet_sk(sk)->is_icsk is true but inet_csk(sk) is NULL; should this be
possible under normal conditions or is there an issue somewhere?

-- 
paul moore
www.paul-moore.com
