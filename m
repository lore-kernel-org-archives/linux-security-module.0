Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A9C433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A519420708
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594239910;
	bh=D7k3xvbEWY4or+QblHb+6CiLuYXwy2HOGXpMEAVtPcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cBAI+PECGhnTa83jVuHvheymOAWIXPIgj8XbYkmG0Dg7Vvtl8Ui3x5eBrFV2jRP60
	 byKSHEFY+R5PShFnvzMh2rBsJcWF8AZV0QjjKzaMfn56r9blBeUQE8MWQOeDe51ye6
	 hxfWtJPCUBg+VZxl2k3My619fv5Oa3nugzTZotEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGHUZK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGHUZJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 16:25:09 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DD3206DF;
        Wed,  8 Jul 2020 20:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594239909;
        bh=D7k3xvbEWY4or+QblHb+6CiLuYXwy2HOGXpMEAVtPcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmSbuJXrs6tj7XwmAZC5jPwyChbKk72Zpot4gH4a/O0GulkFwT505sKPfaTeV5Ds4
         ZafoKJFk9+4hL3TYxcoC6T2O7T7kSTQT2u4WHOkiNJ0aXlBvWzajzFhnK9s9r8RwH3
         oAXrxeG6aoCIbSAWd61N96W04rPc8MFJE+wI/sds=
Date:   Wed, 8 Jul 2020 13:25:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     syzbot <syzbot+89731ccb6fec15ce1c22@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel panic: smack: Failed to initialize cipso DOI.
Message-ID: <20200708202507.GA35321@sol.localdomain>
References: <000000000000db448f05a212beea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000db448f05a212beea@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Casey,

On Mon, Mar 30, 2020 at 06:51:18AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14957099e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac76c43beddbd9
> dashboard link: https://syzkaller.appspot.com/bug?extid=89731ccb6fec15ce1c22
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1202c375e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1390bb03e00000
> 
> The bug was bisected to:
> 
> commit a9d2d53a788a9c5bc8a7d1b4ea7857b68e221357
> Author: Ken Cox <jkc@redhat.com>
> Date:   Tue Nov 15 19:00:37 2016 +0000
> 
>     ixgbe: test for trust in macvlan adjustments for VF
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13cb06f3e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=102b06f3e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17cb06f3e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+89731ccb6fec15ce1c22@syzkaller.appspotmail.com
> Fixes: a9d2d53a788a ("ixgbe: test for trust in macvlan adjustments for VF")
> 
> RSP: 002b:00007ffebd499a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffebd499a40 RCX: 00000000004404e9
> RDX: 0000000000000014 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 0000000000000004 R08: 0000000000000001 R09: 00007ffebd490031
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401dd0
> R13: 0000000000401e60 R14: 0000000000000000 R15: 0000000000000000
> Kernel panic - not syncing: smack:  Failed to initialize cipso DOI.
> CPU: 1 PID: 7197 Comm: syz-executor480 Not tainted 5.6.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1e9/0x30e lib/dump_stack.c:118
>  panic+0x264/0x7a0 kernel/panic.c:221
>  smk_cipso_doi+0x4d8/0x4e0 security/smack/smackfs.c:698
>  smk_write_doi+0x123/0x190 security/smack/smackfs.c:1595
>  __vfs_write+0xa7/0x710 fs/read_write.c:494
>  vfs_write+0x271/0x570 fs/read_write.c:558
>  ksys_write+0x115/0x220 fs/read_write.c:611
>  do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4404e9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffebd499a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffebd499a40 RCX: 00000000004404e9
> RDX: 0000000000000014 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 0000000000000004 R08: 0000000000000001 R09: 00007ffebd490031
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401dd0
> R13: 0000000000401e60 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 

This means that writing to /smack/doi will panic the kernel if kmalloc fails.

Why doesn't it handle errors?  Is this really an unrecoverable situation?

- Eric
