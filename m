Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9A6C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 06:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAA364EB9
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 06:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCRGyL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Mar 2021 02:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCRGyF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Mar 2021 02:54:05 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB68C06175F
        for <linux-security-module@vger.kernel.org>; Wed, 17 Mar 2021 23:54:05 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s2so3325583qtx.10
        for <linux-security-module@vger.kernel.org>; Wed, 17 Mar 2021 23:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwKZTf6r3qzoagkUEIVvYx7G9KpwCcqS8Mu1ZCGxzNs=;
        b=ZebnEmf/Bz5Q56X7DmHK+C5I08ViRHdMMps46MVGoY72WqrjNChTaIkhAVobSPFgCS
         BSAbuY1vWJhcK5yRKzxeOCHk99HlreEJIB1gAKbdQzPWTuMK7VyzvQRu5vtJ6l6E/wZp
         IgMeUjm/g7cU+glU87dkO09ud52IdFiEh2m1QUnWGWTTCmfbgKUcUqUGkFv/Okfw/43k
         BxVdT6WvibizijldFK1urBUyj5YmL3L0kGiHH5QZ/7LHaaqChynw3PKpqFyWMIEzz+iT
         5WSOU3Q6KcVCoiuHpfty/D56T4WloAkEAEhuMlvlR0XQctfTH969EhHXSx3SKFRfSXaj
         idmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwKZTf6r3qzoagkUEIVvYx7G9KpwCcqS8Mu1ZCGxzNs=;
        b=oJr0abf2ppiplL8i7pbgIUc7SvkpLGfblW8MdMwQuSuovZBQ9EAZcvc90z8fmcsXne
         yKhiY17VfwJEewlQ6o1ijI1yAGhNJSa9107Wx90zyuCO5kz/Gxne6bZXX3zXOMp9F4kl
         PT7er6eRd3HyniItngL28Rg4GrJlixg6T92rUh8MWs1Os5yzA6LsZDGhxTEHVhdjCtQC
         vnwnGevbGEL96chCDCyjBJGTtiSiSKkBFsfqawVGJTorm8FSSMV2q08SnHHzEGrDeZ1V
         Yz7H3gZZWB03AjxUedUH0iNGjIQaj5FIVVLujJ9u++gP6VAcnd5s1DE6oyH1c7tQFW0K
         L4SA==
X-Gm-Message-State: AOAM5332p6nDMwCWL0XECch4xDJmTe3se0v0x7c++xZfxoXKyNm2JbIh
        Vheyg4tieK1dycqsVsxVdrvut7QBU2FjrZGGjjMhFQ==
X-Google-Smtp-Source: ABdhPJzuY0N9To0KWW1Et2NZ910MBoeACeoc8B4OQCX7VbYCN4QgEEDKP+dDVR8D1TYET+qqNiT0lKHw4/Rzc2kCO3Y=
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr2376224qtw.43.1616050444158;
 Wed, 17 Mar 2021 23:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YBXLi=quMEyBHtLO3-Ef6E3CAN7toFUdTFJWeH+5Y7kg@mail.gmail.com>
 <31c4e1863a561c47d38b8e547ec38a0a713bdadc.camel@linux.ibm.com>
 <CACT4Y+b8cNr1zv=RFPLXf9vY==BSktM1vb9gOfcWyBEaojZ1-A@mail.gmail.com> <dbf9e31ca38b36b757c71bcc8fa17cb1ae392f1c.camel@linux.ibm.com>
In-Reply-To: <dbf9e31ca38b36b757c71bcc8fa17cb1ae392f1c.camel@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 07:53:53 +0100
Message-ID: <CACT4Y+YCJ3CPR4LHqY8j_g3=vM6-iKoCc96d8OJuZ-N9KKeZkg@mail.gmail.com>
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

On Thu, Mar 18, 2021 at 3:18 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Dmitry,
>
> On Mon, 2021-03-15 at 14:07 +0100, Dmitry Vyukov wrote:
> > On Mon, Mar 15, 2021 at 1:41 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > On Mon, 2021-03-15 at 11:58 +0100, Dmitry Vyukov wrote:
> > > > Hi,
> > > >
> > > > I am trying to boot 5.12-rc3 with this config:
> > > > https://github.com/google/syzkaller/blob/cc1cff8f1e1a585894796d6eae8c51eef98037e6/dashboard/config/linux/upstream-smack-kasan.config
> > > >
> > > > in qemu:
> > > > qemu-system-x86_64       -enable-kvm     -machine q35,nvdimm -cpu
> > > > max,migratable=off -smp 4       -m 4G,slots=4,maxmem=16G        -hda
> > > > wheezy.img      -kernel arch/x86/boot/bzImage   -nographic -vga std
> > > >  -soundhw all     -usb -usbdevice tablet  -bt hci -bt device:keyboard
> > > >    -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net
> > > > nic,model=virtio-net-pci   -object
> > > > memory-backend-file,id=pmem1,share=off,mem-path=/dev/zero,size=64M
> > > >   -device nvdimm,id=nvdimm1,memdev=pmem1  -append "console=ttyS0
> > > > root=/dev/sda earlyprintk=serial rodata=n oops=panic panic_on_warn=1
> > > > panic=86400 lsm=smack numa=fake=2 nopcid dummy_hcd.num=8"   -pidfile
> > > > vm_pid -m 2G -cpu host
> > > >
> > > > But it crashes on NULL deref in integrity_inode_get during boot:
> > > >
> > > > Run /sbin/init as init process
> > > > BUG: kernel NULL pointer dereference, address: 000000000000001c
> > > > #PF: supervisor read access in kernel mode
> > > > #PF: error_code(0x0000) - not-present page
> > > > PGD 0 P4D 0
> > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2+ #97
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > > rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
> > > > RIP: 0010:kmem_cache_alloc+0x2b/0x370 mm/slub.c:2920
> > > > Code: 57 41 56 41 55 41 54 41 89 f4 55 48 89 fd 53 48 83 ec 10 44 8b
> > > > 3d d9 1f 90 0b 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 <8b> 5f
> > > > 1c 4cf
> > > > RSP: 0000:ffffc9000032f9d8 EFLAGS: 00010246
> > > > RAX: 0000000000000000 RBX: ffff888017fc4f00 RCX: 0000000000000000
> > > > RDX: ffff888040220000 RSI: 0000000000000c40 RDI: 0000000000000000
> > > > RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888019263627
> > > > R10: ffffffff83937cd1 R11: 0000000000000000 R12: 0000000000000c40
> > > > R13: ffff888019263538 R14: 0000000000000000 R15: 0000000000ffffff
> > > > FS:  0000000000000000(0000) GS:ffff88802d180000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 000000000000001c CR3: 000000000b48e000 CR4: 0000000000750ee0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > PKRU: 55555554
> > > > Call Trace:
> > > >  integrity_inode_get+0x47/0x260 security/integrity/iint.c:105
> > > >  process_measurement+0x33d/0x17e0 security/integrity/ima/ima_main.c:237
> > > >  ima_bprm_check+0xde/0x210 security/integrity/ima/ima_main.c:474
> > > >  security_bprm_check+0x7d/0xa0 security/security.c:845
> > > >  search_binary_handler fs/exec.c:1708 [inline]
> > > >  exec_binprm fs/exec.c:1761 [inline]
> > > >  bprm_execve fs/exec.c:1830 [inline]
> > > >  bprm_execve+0x764/0x19a0 fs/exec.c:1792
> > > >  kernel_execve+0x370/0x460 fs/exec.c:1973
> > > >  try_to_run_init_process+0x14/0x4e init/main.c:1366
> > > >  kernel_init+0x11d/0x1b8 init/main.c:1477
> > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> > > > Modules linked in:
> > > > CR2: 000000000000001c
> > > > ---[ end trace 22d601a500de7d79 ]---
> > >
> > > It looks like integrity_inode_get() fails to alloc memory.   Only on
> > > failure to verify the integrity of a file would an error be returned.
> > > I think that is what you would want to happen.  Without an "appraise"
> > > policy, this shouldn't happen.
> >
> > It happens at the very boot. I think the cache is NULL.
>
> An IMA policy had to have been loaded in order for
> integrity_inode_get() to have been called.   If this is happening on
> boot, it's too early for a custom policy to have been loaded by
> userspace, but I don't see the builtin policy defined on the boot
> command line either.
>
> Any additional information would be much appreciated.

Hi Mimi,

I provided kernel config and qemu command line. What other information
are you looking for? Can you reproduce it on your side?
