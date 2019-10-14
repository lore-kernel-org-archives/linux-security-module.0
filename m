Return-Path: <SRS0=8Vjb=YH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AEBECE587
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Oct 2019 08:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4D220663
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Oct 2019 08:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q94TPx9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfJNIVp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:21:45 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40197 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfJNIVp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Oct 2019 04:21:45 -0400
Received: by mail-vs1-f68.google.com with SMTP id v10so10261501vsc.7
        for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2019 01:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qkwYhsUckf7+4PwNb5NLbq4ut4I6iHnrpcqJjRVh4Co=;
        b=Q94TPx9mwCbFfuj+46CEZV5V/OtvL7+M331PFGXXsnZ/866GBQiqzvmCa7AJnB6W5t
         4+GIZMfiXxqYuV1gAyoX1nX+qg4se72WmcvI2cgRhEgQxnquDfgMz+bqRKePdqmPZHOZ
         XNeDOIXBHHLw1EFcPWGADYT4D0b7+zl1FQwpHeweGQmAPx3e3qfUol2FB9JBQzZ4qn4l
         8OzdRYvF5j6Ool8dzQG1OIEyBVt3vpwckhteZWbHbrIDL+aNRz9AtyFc4zq+O+JN2tSe
         T38JzPz/wmRJ5hBSASoywlOvL+amlBmHqebn2qOt6YralK3yKZqIDmwj+HGBLPpPZKCo
         XF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qkwYhsUckf7+4PwNb5NLbq4ut4I6iHnrpcqJjRVh4Co=;
        b=bWuVXmld9Sfz2uCKOo13HuSu1dZIcmuO3g9A5gPRqeJirg2erIfEFMIylaWrBWiJ8A
         8aj35s6bzQpnO+zShhf2ZMZUxT5mJK9xwVjGVQ3bznKV7JJrYdZBfjNr+qpa0JCwGChC
         8jzT3+bbti9bme7wQN6HYeU2Zs0Q3+mMSKU6rk6+j9TZT5tuakEhfxr0gZHKxv/DHtaD
         xcnn7X4zjRNFutB5K7c1meyT1+Yhlq9EBJaqAf7fFVr/BvWCxmjzsUI0x2JuxRtjSZun
         riWVAvG7m7Fq69ft8EQ25WPsLZqbXQDyFwDoMUtsZr0374KIU2xHk5OFm3UlkqHDrw44
         lN6w==
X-Gm-Message-State: APjAAAXD+ui1amhf1l2dLsmtoI644muwDM0XJE3RLdXzBfeMC6ufL3U1
        GLwfZM0bhOPoKym0RxSiIeaWb4/LTczWrZ6ktr0U4n6o
X-Google-Smtp-Source: APXvYqwMu8oYztNIGZ0RkeWKz0iAgcwbzwiMFaNTb30+Z/+wiHJtgJ2b4/2JW2oTZ5vYaji31ko6X3DWc662HE8AkQY=
X-Received: by 2002:a67:f288:: with SMTP id m8mr16248667vsk.223.1571041304470;
 Mon, 14 Oct 2019 01:21:44 -0700 (PDT)
MIME-Version: 1.0
From:   Temp Sha <temp.sha@gmail.com>
Date:   Mon, 14 Oct 2019 13:51:31 +0530
Message-ID: <CANe=CUmBHF=L8EUVvupGSYKY_m2PH_4aH=pL7Fky57BY4JQdvA@mail.gmail.com>
Subject: kernel panic while using get_random_bytes
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

hi,

i use get_random_bytes() function for my randomness requirement in
kernel version 4.14.142
however is gives panic as soon as I call   get_random_bytes() in my module.


Oct 10 07:20:18 BUG: unable to handle kernel paging request at 00007f5563ced000
IP: chacha20_block+0x24d/0x280
PGD 800000010f7f8067 P4D 800000010f7f8067 PUD 161316067 PMD 1015a8067 PTE 0
Oops: 0002 [#1] PREEMPT SMP PTI
Modules linked in: ipi_hsl(PO) mymod(PO) e1000 ipv6 ftdi_sio usbserial
xt_tcpudp xt_mark iptable_nat nf_nat_ipv4 nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat xt_connlimit nf_conntrack iptable_filter
ip_tables x_tables
CPU: 0 PID: 1841 Comm: hexdump Tainted: P           O    4.14.142-ws-symbol #1
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
task: ffff8881611da000 task.stack: ffffc900504c4000
RIP: 0010:chacha20_block+0x24d/0x280
RSP: 0018:ffffc900504c7c70 EFLAGS: 00010886
RAX: 0000000000000000 RBX: 00000000a88c95b0 RCX: 00007f5563ced000
RDX: ffff88810f79da00 RSI: 0000000015c4332e RDI: 000000007613f298
RBP: ffffc900504c7d00 R08: 000000009d39d68d R09: 00000000bfbdb51f
R10: 00000000ed798a26 R11: 0000000083c184dc R12: 0000000036fc61e0
R13: 00000000f9004639 R14: 0000000042c0d351 R15: 000000008a6cef0f
FS:  00007f5563cef700(0000) GS:ffff888167e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5563ced000 CR3: 000000016117c000 CR4: 00000000000006b0
Call Trace:
 _extract_crng+0x6d/0xc0
 extract_crng+0x3a/0x40
 _get_random_bytes+0x56/0x1c0
 ? vprintk_func+0x3f/0xd0
 ? printk+0x3e/0x46
 get_random_bytes+0x2f/0x40
 xyz_packets+0x1110/0x11e0 [mymod]
 proc_reg_read+0x3d/0x60
 __vfs_read+0x23/0x120
 ? vm_mmap_pgoff+0x9d/0xd0
 vfs_read+0x8e/0x110
 SyS_read+0x48/0xc0
 do_syscall_64+0x5c/0x260
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7f55631f


what could be the problem?


thanks
