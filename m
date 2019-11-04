Return-Path: <SRS0=1/E3=Y4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEAECA9ECF
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Nov 2019 09:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A8F21744
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Nov 2019 09:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN/+HvBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfKDJf5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:35:57 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33907 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfKDJf5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Nov 2019 04:35:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id y23so4059137vso.1
        for <linux-security-module@vger.kernel.org>; Mon, 04 Nov 2019 01:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RjVx+/JFuFUvWdRdey1T7oBKhn9rNQ53dmL/LzvQJ7c=;
        b=JN/+HvBkVf++rgtCnLONJTxPaLdJelmru3usJI7BzpdF3FcQTDhlALGuFnLPEqNOO0
         x91/4+L5i5SAOS1T3KJiCjIEJzEEqKpLmHX1+U5TkvczT56hDHwdLmwzPi9U3rekZOVR
         Cqi4p0LVP8YeAQCfJ/ni5H+Z37y0lPoyNSevfRBmUSRgrBZrEZzL90bXnR5rkekh9NJL
         OgJs9BH0ZKSqvAAHXFODIyE9Ijqb/eUcH7fYpN/7KBTgDTeFpdUtKvzkPP9SkwYclmNm
         iy2og3LH5TO2TZuYJjU77IfAr4MuXSE/9YQ5xShw5fE2CK7AAn3rLmklJPfpxl5qJPSh
         RnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RjVx+/JFuFUvWdRdey1T7oBKhn9rNQ53dmL/LzvQJ7c=;
        b=hpZwB8zVsmDfDrqTNgjDyON1YW9tnnnvXJvbDuUhK2X0mkH8m1VWqnrz0jSXzxQTSL
         o6rHXh0m/qDag0pWUKBQ1SR7V9q2JR4u5lvVZo1brQGCAoenOuLcVhvPoHnpdBZUNrmd
         nznZU4/IAsKMtdhyMP+hPn5I8ZoOLIrrrGNPfDyFoFA/cZlVGFqkkfbrcHvrnJpVgrHj
         47qQxJXgyahCqFuzicMy8EY35YD72gGQBSBdOKPJgeLACeHQJyWhK5GT1GBTaPxNm7E+
         DYA34r2+VGUaN6kYqDl8AbMVlkoMlleKhirphdTtPmufpPM8qzxmRIuyCaN91qlrdGtk
         nWRg==
X-Gm-Message-State: APjAAAWId7ty6FUbK25oE9ZXG/uzGo3LrDSGm0GevjMbw37TBJvEvQQE
        4GsV6RJlIaHp4We963qgLJfizHozQfxtpOApefZFCKNv
X-Google-Smtp-Source: APXvYqx/AFm9rRIRlR03JmaQKK1yCQ2uXDRrGN6y5smBk+3CF6awjOy7Tsc0HmKYUevdBmJy8/2yhhl3kpJ7vjQCRI4=
X-Received: by 2002:a05:6102:109e:: with SMTP id s30mr12313536vsr.175.1572860155670;
 Mon, 04 Nov 2019 01:35:55 -0800 (PST)
MIME-Version: 1.0
References: <CANe=CUmBHF=L8EUVvupGSYKY_m2PH_4aH=pL7Fky57BY4JQdvA@mail.gmail.com>
In-Reply-To: <CANe=CUmBHF=L8EUVvupGSYKY_m2PH_4aH=pL7Fky57BY4JQdvA@mail.gmail.com>
From:   Temp Sha <temp.sha@gmail.com>
Date:   Mon, 4 Nov 2019 15:05:48 +0530
Message-ID: <CANe=CUkHCHUi-rZ3AxzDCN=rJGWfcK6S2eksTC9xOxdyVq-hEg@mail.gmail.com>
Subject: Re: kernel panic while using get_random_bytes
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

hi, can any one help me with this issue?  please let me know if this
is not correct form to ask this question?
thanks

On Mon, Oct 14, 2019 at 1:51 PM Temp Sha <temp.sha@gmail.com> wrote:
>
> hi,
>
> i use get_random_bytes() function for my randomness requirement in
> kernel version 4.14.142
> however is gives panic as soon as I call   get_random_bytes() in my module.
>
>
> Oct 10 07:20:18 BUG: unable to handle kernel paging request at 00007f5563ced000
> IP: chacha20_block+0x24d/0x280
> PGD 800000010f7f8067 P4D 800000010f7f8067 PUD 161316067 PMD 1015a8067 PTE 0
> Oops: 0002 [#1] PREEMPT SMP PTI
> Modules linked in: ipi_hsl(PO) mymod(PO) e1000 ipv6 ftdi_sio usbserial
> xt_tcpudp xt_mark iptable_nat nf_nat_ipv4 nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat xt_connlimit nf_conntrack iptable_filter
> ip_tables x_tables
> CPU: 0 PID: 1841 Comm: hexdump Tainted: P           O    4.14.142-ws-symbol #1
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> task: ffff8881611da000 task.stack: ffffc900504c4000
> RIP: 0010:chacha20_block+0x24d/0x280
> RSP: 0018:ffffc900504c7c70 EFLAGS: 00010886
> RAX: 0000000000000000 RBX: 00000000a88c95b0 RCX: 00007f5563ced000
> RDX: ffff88810f79da00 RSI: 0000000015c4332e RDI: 000000007613f298
> RBP: ffffc900504c7d00 R08: 000000009d39d68d R09: 00000000bfbdb51f
> R10: 00000000ed798a26 R11: 0000000083c184dc R12: 0000000036fc61e0
> R13: 00000000f9004639 R14: 0000000042c0d351 R15: 000000008a6cef0f
> FS:  00007f5563cef700(0000) GS:ffff888167e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5563ced000 CR3: 000000016117c000 CR4: 00000000000006b0
> Call Trace:
>  _extract_crng+0x6d/0xc0
>  extract_crng+0x3a/0x40
>  _get_random_bytes+0x56/0x1c0
>  ? vprintk_func+0x3f/0xd0
>  ? printk+0x3e/0x46
>  get_random_bytes+0x2f/0x40
>  xyz_packets+0x1110/0x11e0 [mymod]
>  proc_reg_read+0x3d/0x60
>  __vfs_read+0x23/0x120
>  ? vm_mmap_pgoff+0x9d/0xd0
>  vfs_read+0x8e/0x110
>  SyS_read+0x48/0xc0
>  do_syscall_64+0x5c/0x260
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> RIP: 0033:0x7f55631f
>
>
> what could be the problem?
>
>
> thanks
