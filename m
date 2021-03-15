Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD54C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Mar 2021 10:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7552664E81
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Mar 2021 10:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCOK66 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Mar 2021 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCOK60 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Mar 2021 06:58:26 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F5AC061574
        for <linux-security-module@vger.kernel.org>; Mon, 15 Mar 2021 03:58:26 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id m186so14488301qke.12
        for <linux-security-module@vger.kernel.org>; Mon, 15 Mar 2021 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=t7xy6zeaJAsJPXI+1JuOYJP82SO0w/hyJQujyPzx7sQ=;
        b=GiIzTz2riciYNs5yRUZ+/7oI/l4i+oi8y8XyI3p+Q+PjIebZwSqYdW0caUNDK5wL1A
         Wd7hsznl76jhobiS2CiUIC6mVq4cTjYsXs1y24NGsJ5Ka0h6UB3zb8wccWDSbyx8AY7Z
         kCbQh1Sxxcgh9d08nP3EkXiO6QWU+2PwtBvr8ngC84quW6+wc6pjMInGaCPgcpmcF5Hl
         ywSgYNjjL+JsKGlytcvhPsGax0vc4pg+5U1yi+A1aF7+/7C4tlBsk0lhHwOtVXwmqvlk
         ckG9nuJYnaH8NijRbMJvmw5tVPcsA3E3Zo9UDNkxaHXpIIRNV3czJcNoJmTg5OsfJg3O
         AVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t7xy6zeaJAsJPXI+1JuOYJP82SO0w/hyJQujyPzx7sQ=;
        b=lPm6CtG5zZ1KFtcbJOcnIgE5Szo79tU3kBgA/z9qJO/XkxCcEonz9poIErSMqnO9EU
         7lKO0aHAhFOq9FspA5lzFYSvlhZXeSTijjvAth5b9bdtIPPNfFe+1W7TPpwA1PEhv5eo
         kNMUJObL8fmPgXLb1GGAQMv5uxGghDQjxLSnEO5SmC6gXD9i7cvKBJTm9oL9hdCflgeF
         frxPXbDKedIv3BYwtnkLmMVbM0eyugzPVd0CkdRGcUyY02z7gOUIU4Lc1KSDcxelQj+K
         foy+AdIq2VYK/isxaPmjgPqaByf6dbxk6Gmb5fpw7mlUVMoqdpmM0NW4GNBJaYbSoS1I
         Wy0w==
X-Gm-Message-State: AOAM532TodInzN/6K9mOTp+J6IMAgNuOi2MTABT5GXnWWNpk8jFlvidw
        V3dtO45Ta9ULl4Od+yYZYKUNoXXKoCRVachP9Cx75TmKrZBZKw==
X-Google-Smtp-Source: ABdhPJyt24kW0t7rN9C+7UBuhpQqczNrqgYCLw5B+a95p6Kl4fSlHXEmRbDixvPpdKWR6Vywg2O6wcZfrVVgj5nJLOU=
X-Received: by 2002:a37:a7cb:: with SMTP id q194mr723540qke.350.1615805905482;
 Mon, 15 Mar 2021 03:58:25 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Mar 2021 11:58:14 +0100
Message-ID: <CACT4Y+YBXLi=quMEyBHtLO3-Ef6E3CAN7toFUdTFJWeH+5Y7kg@mail.gmail.com>
Subject: NULL deref in integrity_inode_get
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, d.kasatkin@samsung.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

I am trying to boot 5.12-rc3 with this config:
https://github.com/google/syzkaller/blob/cc1cff8f1e1a585894796d6eae8c51eef98037e6/dashboard/config/linux/upstream-smack-kasan.config

in qemu:
qemu-system-x86_64       -enable-kvm     -machine q35,nvdimm -cpu
max,migratable=off -smp 4       -m 4G,slots=4,maxmem=16G        -hda
wheezy.img      -kernel arch/x86/boot/bzImage   -nographic -vga std
 -soundhw all     -usb -usbdevice tablet  -bt hci -bt device:keyboard
   -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net
nic,model=virtio-net-pci   -object
memory-backend-file,id=pmem1,share=off,mem-path=/dev/zero,size=64M
  -device nvdimm,id=nvdimm1,memdev=pmem1  -append "console=ttyS0
root=/dev/sda earlyprintk=serial rodata=n oops=panic panic_on_warn=1
panic=86400 lsm=smack numa=fake=2 nopcid dummy_hcd.num=8"   -pidfile
vm_pid -m 2G -cpu host

But it crashes on NULL deref in integrity_inode_get during boot:

Run /sbin/init as init process
BUG: kernel NULL pointer dereference, address: 000000000000001c
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2+ #97
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
RIP: 0010:kmem_cache_alloc+0x2b/0x370 mm/slub.c:2920
Code: 57 41 56 41 55 41 54 41 89 f4 55 48 89 fd 53 48 83 ec 10 44 8b
3d d9 1f 90 0b 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 <8b> 5f
1c 4cf
RSP: 0000:ffffc9000032f9d8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888017fc4f00 RCX: 0000000000000000
RDX: ffff888040220000 RSI: 0000000000000c40 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888019263627
R10: ffffffff83937cd1 R11: 0000000000000000 R12: 0000000000000c40
R13: ffff888019263538 R14: 0000000000000000 R15: 0000000000ffffff
FS:  0000000000000000(0000) GS:ffff88802d180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000001c CR3: 000000000b48e000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 integrity_inode_get+0x47/0x260 security/integrity/iint.c:105
 process_measurement+0x33d/0x17e0 security/integrity/ima/ima_main.c:237
 ima_bprm_check+0xde/0x210 security/integrity/ima/ima_main.c:474
 security_bprm_check+0x7d/0xa0 security/security.c:845
 search_binary_handler fs/exec.c:1708 [inline]
 exec_binprm fs/exec.c:1761 [inline]
 bprm_execve fs/exec.c:1830 [inline]
 bprm_execve+0x764/0x19a0 fs/exec.c:1792
 kernel_execve+0x370/0x460 fs/exec.c:1973
 try_to_run_init_process+0x14/0x4e init/main.c:1366
 kernel_init+0x11d/0x1b8 init/main.c:1477
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
CR2: 000000000000001c
---[ end trace 22d601a500de7d79 ]---
