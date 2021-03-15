Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDFCC433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE8B64E31
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Mar 2021 13:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCONHx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhCONHh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Mar 2021 09:07:37 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E75BC06174A
        for <linux-security-module@vger.kernel.org>; Mon, 15 Mar 2021 06:07:37 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id j17so7677327qvo.13
        for <linux-security-module@vger.kernel.org>; Mon, 15 Mar 2021 06:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IM3zY04AmOlCtvAVnSd9iG5x1ewD+6ByijIwRWgL5V8=;
        b=BnYqxhM866S7OSAVje66mLcPnSbKq7XImiRkeGfZno3pjvUPnBR1MrMA6PinWYBy8M
         sQFlHjlzpygxq21VMvPDvfuEwdyEwNqhlhFPJS7qUSJQzOEzQ7Ci0xafNzFFmVmWzc9f
         fftSeKpcP7DJ4/SPdSpB5X1H/wCZwAFYJHD0cHhdBs6GMEVCw5XdluJhJ2twOeRlKsWo
         6oLJXmXOnA/CyGjDKmRHpb0KjxJzb3wwMk0cDl/pv0Bq6Sgsr4MNNsxaffg3TxdXza01
         OTCum00SOZT2gC+PZfH5cihdqejRaIbFRS9wFRZMIA5wN8uZo4a3s2EFyZysRWK/m8ew
         c1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IM3zY04AmOlCtvAVnSd9iG5x1ewD+6ByijIwRWgL5V8=;
        b=BM3P8VEMknclDhmFam9yt6tAa6kriuZQ+hb8v4S83xu750Ev30k2dlAbjeUlJj0yMj
         qbNyt/xm5c6lzFNW009k8SGJ8Y5UQLRX4wmPZMaxXO7u5tkph0NG5Op8vx1vu1PRFEm8
         EINeUcX/qLbwUzWuuEojmZpYCuWMB8BV7oz1FToiCRRjFz/VNW7AsyRC5IBdeWxf5na2
         LCRyLkWTK3oinv+ZlMGZ0O4AEBhbEwgHBBAenYGxfX452eMnSeoa1pwoqmcC1/oPItQY
         /0PsuqLF+BXHUhHbRwqcSfHf0as6+9/aGjWNw1v9Njb5LdalYScVf4Vg/XGU7UPQesD6
         7PWg==
X-Gm-Message-State: AOAM531Gui4LqYxNVAiwcSKpqZYUz8sbsS4ZcoB63WOgQ/UVuzF7T9ym
        pGoMrvTewPbRWIa9f9MlxBtSCxiNwI4NduJohkkeGr+66qA=
X-Google-Smtp-Source: ABdhPJwJbYDM4vf8RRkgFjAw/ezp5E66jTEphKKfCiWUo2N3D3fQbX/zuAV4uxWssANVFHhV8Z2wCW6vutN8X3C2YCU=
X-Received: by 2002:a05:6214:326:: with SMTP id j6mr10679488qvu.13.1615813656317;
 Mon, 15 Mar 2021 06:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YBXLi=quMEyBHtLO3-Ef6E3CAN7toFUdTFJWeH+5Y7kg@mail.gmail.com>
 <31c4e1863a561c47d38b8e547ec38a0a713bdadc.camel@linux.ibm.com>
In-Reply-To: <31c4e1863a561c47d38b8e547ec38a0a713bdadc.camel@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Mar 2021 14:07:23 +0100
Message-ID: <CACT4Y+b8cNr1zv=RFPLXf9vY==BSktM1vb9gOfcWyBEaojZ1-A@mail.gmail.com>
Subject: Re: NULL deref in integrity_inode_get
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, d.kasatkin@samsung.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 15, 2021 at 1:41 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Dmitry,
>
> On Mon, 2021-03-15 at 11:58 +0100, Dmitry Vyukov wrote:
> > Hi,
> >
> > I am trying to boot 5.12-rc3 with this config:
> > https://github.com/google/syzkaller/blob/cc1cff8f1e1a585894796d6eae8c51eef98037e6/dashboard/config/linux/upstream-smack-kasan.config
> >
> > in qemu:
> > qemu-system-x86_64       -enable-kvm     -machine q35,nvdimm -cpu
> > max,migratable=off -smp 4       -m 4G,slots=4,maxmem=16G        -hda
> > wheezy.img      -kernel arch/x86/boot/bzImage   -nographic -vga std
> >  -soundhw all     -usb -usbdevice tablet  -bt hci -bt device:keyboard
> >    -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net
> > nic,model=virtio-net-pci   -object
> > memory-backend-file,id=pmem1,share=off,mem-path=/dev/zero,size=64M
> >   -device nvdimm,id=nvdimm1,memdev=pmem1  -append "console=ttyS0
> > root=/dev/sda earlyprintk=serial rodata=n oops=panic panic_on_warn=1
> > panic=86400 lsm=smack numa=fake=2 nopcid dummy_hcd.num=8"   -pidfile
> > vm_pid -m 2G -cpu host
> >
> > But it crashes on NULL deref in integrity_inode_get during boot:
> >
> > Run /sbin/init as init process
> > BUG: kernel NULL pointer dereference, address: 000000000000001c
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2+ #97
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:kmem_cache_alloc+0x2b/0x370 mm/slub.c:2920
> > Code: 57 41 56 41 55 41 54 41 89 f4 55 48 89 fd 53 48 83 ec 10 44 8b
> > 3d d9 1f 90 0b 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 <8b> 5f
> > 1c 4cf
> > RSP: 0000:ffffc9000032f9d8 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffff888017fc4f00 RCX: 0000000000000000
> > RDX: ffff888040220000 RSI: 0000000000000c40 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888019263627
> > R10: ffffffff83937cd1 R11: 0000000000000000 R12: 0000000000000c40
> > R13: ffff888019263538 R14: 0000000000000000 R15: 0000000000ffffff
> > FS:  0000000000000000(0000) GS:ffff88802d180000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000000001c CR3: 000000000b48e000 CR4: 0000000000750ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  integrity_inode_get+0x47/0x260 security/integrity/iint.c:105
> >  process_measurement+0x33d/0x17e0 security/integrity/ima/ima_main.c:237
> >  ima_bprm_check+0xde/0x210 security/integrity/ima/ima_main.c:474
> >  security_bprm_check+0x7d/0xa0 security/security.c:845
> >  search_binary_handler fs/exec.c:1708 [inline]
> >  exec_binprm fs/exec.c:1761 [inline]
> >  bprm_execve fs/exec.c:1830 [inline]
> >  bprm_execve+0x764/0x19a0 fs/exec.c:1792
> >  kernel_execve+0x370/0x460 fs/exec.c:1973
> >  try_to_run_init_process+0x14/0x4e init/main.c:1366
> >  kernel_init+0x11d/0x1b8 init/main.c:1477
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> > Modules linked in:
> > CR2: 000000000000001c
> > ---[ end trace 22d601a500de7d79 ]---
>
> It looks like integrity_inode_get() fails to alloc memory.   Only on
> failure to verify the integrity of a file would an error be returned.
> I think that is what you would want to happen.  Without an "appraise"
> policy, this shouldn't happen.

It happens at the very boot. I think the cache is NULL.
