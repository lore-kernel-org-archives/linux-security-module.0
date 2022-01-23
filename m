Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B62DC433EF
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jan 2022 15:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiAWPrz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 23 Jan 2022 10:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiAWPrz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 23 Jan 2022 10:47:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE20C06173B
        for <linux-security-module@vger.kernel.org>; Sun, 23 Jan 2022 07:47:54 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ba4so9113620wrb.4
        for <linux-security-module@vger.kernel.org>; Sun, 23 Jan 2022 07:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:content-transfer-encoding;
        bh=Omj77Qgqr4YhlFthNfmhxEdDHpDEi7T7hGQ0WTgxhYQ=;
        b=j/ZTdNZvn0X+H2+usSYt139hl4QL6EoIx/tk6TK15igmOF/s50xF9TWLXgRY0rJGss
         9ADBBq0hhDu0F7q8gVCpB7bPIseci8wBnFy+O/9e+6ct0MZApF1cjgOSUMLybThz8F30
         oXFD59VTLI2M0J/fk3NRoofQl5Is+FzexDgjmea2u12bkJZh+7YvGYe6tmk8YrczdXn6
         PUrTOn/gGlmVMJOeQwQf6Uz1qA+wMsbei/v1DrX0EVWHi0p7zN9g4Y+cRyGEC2Jj4qll
         8Z6nL/r5vgbDr8wC/f+7EoD4t1rQRcKrvyb/dYpc/swNhHgBtfxqRr7tfkKJFEpEKMK5
         rX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:content-transfer-encoding;
        bh=Omj77Qgqr4YhlFthNfmhxEdDHpDEi7T7hGQ0WTgxhYQ=;
        b=xwlaEEZcOgch8p8vN05b4Zg9Wm4vc9UsdvF14PSIBBnXGE5k1o30ZIEXWw7xDo/nEL
         wZZmC8avtw7U8jgIOB5sWORhSdwitbUbyGZP9BWWu2v49Q9PeyXjillLS7beX1S3bFF1
         AI4+Ho4pTkEMgllc/XsY2yygGTkXiQwp7xEPRAkHnoPRR9Nscf7fR8LVX0mMFezu4rt2
         SRpqttByFbIY2UnAjPGq3uKevYM1mTeV152sOfjI3nmVVJV+hf+23CsXqx7awPpQLotE
         3Vmmb4THZtyEcBqfsAFtbReLqS0wT05vxTbirZfpk4Rt+Zb0peQ5Gf976Fl7LyCkdZ1M
         KVOg==
X-Gm-Message-State: AOAM530cqVvPGJ3Li3IgyMJyN3DQmfCk8G23hpcvJ3ZwcN0aZeZT+ixp
        B0faeLqW0MjrSKUQ0nqkvHuwwl23/1o=
X-Google-Smtp-Source: ABdhPJxvryPa4Tsoy2c4ZZCa6y6kVaOuaMy8E2tFxc6AyadJ3hRUg5GDjJNFgu8y+0Q7xDEMw0/nbA==
X-Received: by 2002:a5d:428f:: with SMTP id k15mr11393862wrq.347.1642952872886;
        Sun, 23 Jan 2022 07:47:52 -0800 (PST)
Received: from [192.168.1.164] (i577BC8ED.versanet.de. [87.123.200.237])
        by smtp.gmail.com with ESMTPSA id p17sm11784543wrf.111.2022.01.23.07.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 07:47:52 -0800 (PST)
Message-ID: <c4cbfdb3-f904-b587-d407-268650e6565d@gmail.com>
Date:   Sun, 23 Jan 2022 16:47:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Denis Obrezkov <denisobrezkov@gmail.com>
Subject: Custom LSM: getting a null pointer dereference when trying to access
 a task security blob
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

I am writing a small LSM similar to SMACK. I've wrote a task blob init hook:

static void init_task_keylock(struct task_keylock *tsp, struct
keylock_known *task, struct keylock_known *forked)
{
        tsp->kl_task = task;
        tsp->kl_forked = forked;
}

I predefined one label for the initial task (similar to SMACK's hat,
floor, etc):

struct keylock_known keylock_known_system = {
        .label          = "system\n",
        .kl_mask        = 7,
};

and I can see that as in SMACK I can get the label from the initial task
into the inodes:

static int keylock_inode_alloc_security(struct inode *inode)
{
        struct keylock_known *skp = kl_of_current();
        pr_info("KeyLock: skp->label:%s\n", skp->label);
        init_inode_keylock(inode, skp);
        return 0;
}

But after few successful reads I get the kernel null page dereference error:

[    0.193868] Mount-cache hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    0.194860] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
[    0.195883] KeyLock: skp->label:system
[    0.195883]
[    0.196847] KeyLock: skp->label:system
[    0.196847]
[    0.197844] KeyLock: skp->label:system
[    0.197844]
[    0.198920] KeyLock: skp->label:system
[    0.198920]
[    0.199958] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.200911] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.201825] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.202829] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.203825] Spectre V2 : Mitigation: Full generic retpoline
[    0.204824] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling
RSB on context switch
[    0.205824] Spectre V2 : Enabling Restricted Speculation for firmware
calls
[    0.206825] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.207825] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    0.208828] SRBDS: Unknown: Dependent on hypervisor status
[    0.209783] MDS: Mitigation: Clear CPU buffers
[    0.217907] Freeing SMP alternatives memory: 40K
[    0.218822] smpboot: CPU0: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
(family: 0x6, model: 0x45, stepping: 0x1)
[    0.218961] Performance Events: Haswell events, Intel PMU driver.
[    0.219839] ... version:                2
[    0.220665] ... bit width:              48
[    0.220827] ... generic registers:      4
[    0.221660] ... value mask:             0000ffffffffffff
[    0.221827] ... max period:             000000007fffffff
[    0.222636] ... fixed-purpose events:   3
[    0.222827] ... event mask:             000000070000000f
[    0.223896] rcu: Hierarchical SRCU implementation.
[    0.224993] smp: Bringing up secondary CPUs ...
[    0.225771] smp: Brought up 1 node, 1 CPU
[    0.225828] smpboot: Max logical packages: 1
[    0.226536] smpboot: Total of 1 processors activated (4789.13 BogoMIPS)
[    0.227006] BUG: kernel NULL pointer dereference, address:
0000000000000030
[    0.227823] #PF: supervisor read access in kernel mode
[    0.227823] #PF: error_code(0x0000) - not-present page
[    0.227823] PGD 0 P4D 0
[    0.227823] Oops: 0000 [#1] SMP PTI
[    0.227823] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.17+ #4
[    0.227823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[    0.227823] RIP: 0010:keylock_inode_alloc_security+0x2b/0x48
[    0.227823] Code: 65 48 8b 04 25 00 6d 01 00 53 48 8b 90 58 06 00 00
48 89 fb 48 c7 c7 6a 7e 23 88 48 63 05 54 2e 80 00 48 8b 52 78 48 8b 2c
02 <48> 8b 75 30 e8 72 66 ff ff 48 63 05 44 29
[    0.227823] RSP: 0000:ffffb50b80013d50 EFLAGS: 00010282
[    0.227823] RAX: 0000000000000000 RBX: ffffa2bc80144320 RCX:
0000000000000020
[    0.227823] RDX: ffffa2bc8005b0c0 RSI: ffffffff87367cbf RDI:
ffffffff88237e6a
[    0.227823] RBP: 0000000000000000 R08: 0000000000000020 R09:
ffffa2bc8010b080
[    0.227823] R10: 8e89d572bb4b3d14 R11: 52cbeeedbf187f36 R12:
ffffa2bc80144320
[    0.227823] R13: ffffa2bc80144488 R14: 0000000000000000 R15:
ffffa2bc80149000
[    0.227823] FS:  0000000000000000(0000) GS:ffffa2bcbbc00000(0000)
knlGS:0000000000000000
[    0.227823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.227823] CR2: 0000000000000030 CR3: 000000001b60c001 CR4:
0000000000170ef0
[    0.227823] Call Trace:
[    0.227823]  security_inode_alloc+0x40/0x80
[    0.227823]  ? _cond_resched+0x10/0x20
[    0.227823]  inode_init_always+0xd4/0x1e0
[    0.227823]  alloc_inode+0x2b/0x90
[    0.227823]  new_inode_pseudo+0x7/0x50
[    0.227823]  new_inode+0xe/0x30
[    0.227823]  shmem_get_inode+0x59/0x240
[    0.227823]  ? shmem_put_super+0x50/0x50
[    0.227823]  shmem_fill_super+0x1e4/0x230
[    0.227823]  vfs_get_super+0x74/0x100
[    0.227823]  vfs_get_tree+0x20/0xb0
[    0.227823]  ? shmem_parse_options+0x84/0xc0
[    0.227823]  fc_mount+0x9/0x30
[    0.227823]  vfs_kern_mount.part.0+0x6c/0x80
[    0.227823]  devtmpfs_init+0x47/0x149
[    0.227823]  driver_init+0x5/0x28
[    0.227823]  kernel_init_freeable+0xc4/0x1d3
[    0.227823]  ? rest_init+0xa4/0xa4
[    0.227823]  kernel_init+0x5/0xfc
[    0.227823]  ret_from_fork+0x22/0x30
[    0.227823] Modules linked in:
[    0.227823] CR2: 0000000000000030
[    0.227823] ---[ end trace 63f588023014db8e ]---
[    0.227823] RIP: 0010:keylock_inode_alloc_security+0x2b/0x48

It seems that something happens after smpboot.I assumed that the pointer
to the initial task struct would be copied to every child task. And that
stuct keylock_known_system would be always accessible. What could be my
mistake?

-- 
Regards, Denis Obrezkov
