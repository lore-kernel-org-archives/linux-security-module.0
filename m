Return-Path: <SRS0=mnxl=Y5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E76C49EAB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Nov 2019 09:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F019217F4
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Nov 2019 09:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUpxcoTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKEJNJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:13:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48805 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbfKEJNJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Nov 2019 04:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572945188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=es3ibXEWfBX2Wo53B2Y5Wst1KzBKrF8wLUYc4wkbz3k=;
        b=OUpxcoTUZUIHT6BMeAMN2bn5JjR0g50EvAx96RY4tzdccXe1wrMJJZApMZ1LpI4ij0BPo9
        G7vuFlBk3tcaosyFA+uyahQxAm6YuIIRmLvURTUEcBlslSYohaY0Li60LZu3LlNvaMIM7i
        J9ONerK2UVTIBp4ZJCpT+A2ReA49JKI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-yA4AD9TsM5Kx3pNV86zceg-1; Tue, 05 Nov 2019 04:13:05 -0500
Received: by mail-ot1-f72.google.com with SMTP id a3so10424969otl.20
        for <linux-security-module@vger.kernel.org>; Tue, 05 Nov 2019 01:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/pty1zkorvoLtGzMYlKnFYT1XSg0ZRvi1T5dD1Zkms=;
        b=TXRH/E4OsFx2/cenUQExAIAXLNwA+cg+xkchi1NjEM5sdkyt+/IHXvaHvJraFgBQ/C
         /OEYMla6PoflzJjYeWRBdBrst/1BF8SxzRC7jqbNQ3fVZ00fjrXWU7gNz/Wj9iXjYWAM
         GfqrzIckkNqY4NmFTzzlyNvQBssqZ/vWMwYPLrXHLUxv8hl8pybBwuPxo8cDCrlJGEMD
         phUKm6A7AIji256ffi7ftYFB9JOD9UIqd32Ia08/GAFauiIhoulUZ7SoGxqzjWr7CdL2
         R5xB8dT21POSW0mYvc9sgRX1pjN6GOYpJj9japKP/MiPbdW9urzVAJxFF6UDlA0qmkh0
         B3pQ==
X-Gm-Message-State: APjAAAXUvZzcWZE2XGsi7Hio+YzIgKNxbQE74o13dDCHyn6QGc0vh9y3
        Wct1r5rwgVhzpNqsrbmf/oY4aFuHloCOQZKsQ1w7lat5DN2FtpaXmYQzTxjKpNCm6WAL8kxkXE9
        6gZZTfnt56wfGHPGdOZIbktid0HdCDkjryFpOiZw99Nqm7AQhPle3
X-Received: by 2002:aca:7595:: with SMTP id q143mr3201968oic.103.1572945184100;
        Tue, 05 Nov 2019 01:13:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0WEzUysjSL7R5MwBit61h0HVfQE9MRqWZTO4rd/YWyzE/JovKZ4uEL/DNkomKamd4bSw4Tr8UwKp8xBCI3gE=
X-Received: by 2002:aca:7595:: with SMTP id q143mr3201945oic.103.1572945183717;
 Tue, 05 Nov 2019 01:13:03 -0800 (PST)
MIME-Version: 1.0
References: <CANe=CUmBHF=L8EUVvupGSYKY_m2PH_4aH=pL7Fky57BY4JQdvA@mail.gmail.com>
In-Reply-To: <CANe=CUmBHF=L8EUVvupGSYKY_m2PH_4aH=pL7Fky57BY4JQdvA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 5 Nov 2019 10:12:52 +0100
Message-ID: <CAFqZXNvOHsrfqcz3BZLn52aS1vWu3PJ-kB0_Snzm9MhiYeYpjA@mail.gmail.com>
Subject: Re: kernel panic while using get_random_bytes
To:     Temp Sha <temp.sha@gmail.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-crypto@vger.kernel.org
X-MC-Unique: yA4AD9TsM5Kx3pNV86zceg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Temp,

On Mon, Oct 14, 2019 at 10:21 AM Temp Sha <temp.sha@gmail.com> wrote:
>
> hi,
>
> i use get_random_bytes() function for my randomness requirement in
> kernel version 4.14.142
> however is gives panic as soon as I call   get_random_bytes() in my modul=
e.
>
>
> Oct 10 07:20:18 BUG: unable to handle kernel paging request at 00007f5563=
ced000
> IP: chacha20_block+0x24d/0x280
> PGD 800000010f7f8067 P4D 800000010f7f8067 PUD 161316067 PMD 1015a8067 PTE=
 0
> Oops: 0002 [#1] PREEMPT SMP PTI
> Modules linked in: ipi_hsl(PO) mymod(PO) e1000 ipv6 ftdi_sio usbserial
> xt_tcpudp xt_mark iptable_nat nf_nat_ipv4 nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat xt_connlimit nf_conntrack iptable_filter
> ip_tables x_tables
> CPU: 0 PID: 1841 Comm: hexdump Tainted: P           O    4.14.142-ws-symb=
ol #1
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/=
2006
> task: ffff8881611da000 task.stack: ffffc900504c4000
> RIP: 0010:chacha20_block+0x24d/0x280
> RSP: 0018:ffffc900504c7c70 EFLAGS: 00010886
> RAX: 0000000000000000 RBX: 00000000a88c95b0 RCX: 00007f5563ced000
> RDX: ffff88810f79da00 RSI: 0000000015c4332e RDI: 000000007613f298
> RBP: ffffc900504c7d00 R08: 000000009d39d68d R09: 00000000bfbdb51f
> R10: 00000000ed798a26 R11: 0000000083c184dc R12: 0000000036fc61e0
> R13: 00000000f9004639 R14: 0000000042c0d351 R15: 000000008a6cef0f
> FS:  00007f5563cef700(0000) GS:ffff888167e00000(0000) knlGS:0000000000000=
000
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

Since no one else is replying, I'll try to give you some hints. First,
you are posting on the wrong list - linux-security-module@ is for
Linux Security Modules (see Documentation/security/lsm.rst [1]).
Random number generation is more relevant for linux-crypto@ (now in
Cc). Second, the most likely explanation for why you are getting the
crash is that you pass invalid buffer/length to the function. Please
double-check the code in your module whether the pointer and length is
valid. If you fail to find any issue with your code, then ideally post
the full source of you module if possible so people can try to
reproduce and investigate the issue. You could also try to reproduce
the issue with a recent mainline kernel to see if it is an issue that
has been already fixed. If it works with the new kernel then the
stable 4.14 branch you are using likely lacks a backport of the fix.

Hope that helps,

[1] https://www.kernel.org/doc/html/latest/security/lsm.html

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

