Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D40C433EF
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jan 2022 17:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbiAWRBn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 23 Jan 2022 12:01:43 -0500
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:35840
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233237AbiAWRBm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 23 Jan 2022 12:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1642957302; bh=tqGyQ/2ajlV9I55SdNRjJaryuhkRmOY5V8GlbNyzVDI=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=DHCgadFro+bIUAqMoe52iQ851BxFzz1I9RwN+Vd4Qmip/wMwPpnJSFdySGCKlKBSuQO0mZf3daB6ahW2O/2rOmUlOxUuZxqAGPrQuXUWsTKNuehVa/ZvDaAqb47JEJydhRnXEZN3AxtCjiMOZJI6x4QLcAcjD51LnJzpE68UfWlLyzB/i+dNskHBUyu46raXHtPUKKK0aWPzf3OTmOSvPNDU5BzY4L/FfB4+/g5AGt0RLvB1UO898qRGwOCHDiIk+ZxHjksMYRJ3r1kg0TawKSCHNkZcjxL7EqWN6x3ZFsSw+hcSXe6uWectJT4znBrORbo2hWVB6hSTlUXEAsdxhw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1642957302; bh=8fNNqg2EqPJgChO6QEy0BMGwv5+fVK4VY0zMh7ss+by=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IEo1WMUdV4AnMcB4+6BWDPANny4RcpCyvgDSYbY1Lu0h0/jyGFeAbB+Vl8GEsXqfLn/9jvCUSBs+qV3hySaxHj9Zz52lQHGhK3Vbooa7gOaH4rYcrH/jWYDBDmYCOYK9XwswZnF+IfAS9k9gI+/wL/3i62pZHhH8FERTv1GKCpcaMV7+qggkrlj0n+Tevr0GxTrQdNUtJ0YFHTx5+NYqLNGy2HGhmyrjUcGJKMXmCbnplVOyodQLeTEzeCIIqrRQ4X1p4T60Viwb9o+9P26ZuwhLsfDj+/mcnRIP6HUOcLzAssxSYvcDCrKxc5LvHh0UFJXpvxyQ1C5ucJF/Dqo3lQ==
X-YMail-OSG: almPFiwVM1m9SB.SYFsZnbXRN82aMTUYN8oYWNG4KaKqDX7mF_ln8FbworUrTXm
 c7oI0DrMowPv1xY95qYxdEwDtfqNh.piJvsKldfZb0rYH9vOQRHLxrASKLUmReoiJHePsSn6H_60
 mCTsVka9bzrRFpk2jHnDnjezb7zd2sVDJdRWmjpUJKPKinq6y3AikxkXPmSIWfBPIbujMTqDe1Nr
 MSS1K_TdiLoBSL5wTJC775JRntskmC3hfo0Y0zeNyVu6yT8CHK6gNUJawNcXN5dUHDBOgYXURdy8
 h6xvl22odmT5IK1C_FF.SIpDRVSDOc.weAM1ks4J3dd.N4mdhuHsl_lfP2JWTrKhndSglH8l28bT
 SLClaywj0Ugqnj_uUQY16DrDe3pLakUC3LAGxEa.Elv4Oz02h_C6Ugve7_1OLUYGqNkBk0mqghkY
 nvxyYBbICRUUjPwPb1M0m53nM2Tx3x9XtbNMlW_kY_gpzBqST_vsmOyVsXlGBq16PAqbIWEUFy0Q
 02EIDwNbmLd4FxDw8w0f5jsyAaORcL65bF6H4wNQ0tTG8F5I5anG9f4CHFWdFy1oqzjf9yewSMRi
 HLRzPocDXYVI8T07olud2og6kPiMLTaKy8Frcyvxlw1_KJtV8S4QpHIWFC_pq9fCZENpC.yaWcYU
 ii9j8jGtR2LSwd2V3dOsLMj5zfibO3.eOaR0R0DgurFo2oHzBXw7zwL71HVq422iI.mWyNdK..ke
 ar.51hKlFaUkplOKVYPaZOlVKYpU8ewR.amZ0ioz.Ue60T4.3xtzW.Xu9rOVQLDa.Awd.RxEG1yi
 7nGGeMwugu4XO_8THg3QXlhxNG1NUsKsRhcKZR7EE2Ttn0d7ao3BgfzJnnpWNjQIMo2EM76unz3a
 JklAKGCbRogyEsJ0Wd1OkCr6g.W3sid0YWrgNmc07Px4eoixwcb77B8Bt0_xykyJtuZZhhpkbAzd
 A4pKQleaka48IDQijhCM380uOGt985eD__5tQWXrztXntgs1gxVdm2nOI5BYFfMxxRy57FKD.5bV
 ZH3pWs4ygjKYaPEPNA9QCsgVNrSUTZ9jvQ_mIlomlPvMQsQCd1qtuIAyTeilZV3GOaa6dEGhYz7T
 L_8E4gYpd_ZANW953x.uMscP0Ac_tNv6ymjEZa2Ldcv6hdezaiRjDdZUKPsnacNlVDsNjzPUrdNH
 pjgyBCQYVAb7LAOefG9D0AK1WGXR6LqiasOG7Kh18KI5gh5CXsLkB1.eYQFJsm4AKGHQV4EMxZON
 BDskMCSSXDD_9uAcOifNMUTeiNpUbeC15IEDAgmRX4w.pkfb7sMi_6NsOCb24bkLWN5KnVcIqAuS
 LCUQPWU0mOpxTw5EHXnobckcn0npIqygSZM7MS43etaJvugtgxwIL1bAGc31Yxy7tBtzqQS8wTQd
 GjgBBSIYhmtlrMGqJvH_DDavUYkYAXkJvKoX73Twk4DKa5iPdidXIDcYedJa04p64HbrYqPu1Yp_
 vj0J9wITs3aY55Rr.VBOYJTLIHT_A92UEXlTWz_BihJ73VhQltrcO2.uZtFaCbTaEEnEo5iuBLG8
 Ksu56D1.pKQOlt1QhJAFZ193ea5bJRvw9W0w.JMeK7cHxQIvTBBiEjffW045oJ_Z9m8yAjbFx7ZK
 uIbXeJfrgmvK406tig8lrO4_U6AN5_as5tT3Pig0wqsWv1z8.XLHJ8EjMJ40wkuL4iSuCfWFol6U
 3mT5yBVq0bO3_g68gz7tkCZXcpt_C7dhtYmwyoLuuP4xfn4k.cWxAkYwRWXsEE4m5M1.38mT4nTp
 597Ekz5_9emzbA4FK3ySn5RAn12w6DvSOha8fXqedOR8rW4drwPJc.iPQ5qbcGJr2NA9DB3ilpRe
 zkaHL1XPdTEc2Fu.HiJmffupAgxiBy9cNqtfzvxnXfw4SNBTXMo0j5uOtsr.Hd8q.q7tEvFyneU9
 r5PAUsNP139YvHg03dKRnhqEh70h4Ul2O2hiKVB9suFQc75gjqCjAnsmsQi7PwrN4rtGDvE07aoy
 ID6o6uuY9yWwSdpGeHXwTZShFEkMOmxFB28oaT298jSSL1R2xDknX_PfRkOkyZKuGmGr65H.6DKV
 i29f.7tYCQj2Sw3_fVklMp7ANLh7kTQR8PWX6za7cQtuFxisIA0ONTjtXX24LzDxD__3Hlgy8B8q
 saBR831yWk75JwCuFD6ZnVSlSajbngarZcWsJDd0lcA5tL0ig6D3sqpL1x9xFHwQCo.GwA92JvCU
 gwGroSElo2FErYZpmJTkP_Ct_8rzOUFDcdcVohUehWGv_No032ydsvr5x
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 23 Jan 2022 17:01:42 +0000
Received: by kubenode520.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3a8b391638d5a9fda92ab31db8c6d61d;
          Sun, 23 Jan 2022 17:01:38 +0000 (UTC)
Message-ID: <028166ec-0921-977e-8990-4134b5920cad@schaufler-ca.com>
Date:   Sun, 23 Jan 2022 09:01:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Custom LSM: getting a null pointer dereference when trying to
 access a task security blob
Content-Language: en-US
To:     Denis Obrezkov <denisobrezkov@gmail.com>,
        linux-security-module@vger.kernel.org
References: <c4cbfdb3-f904-b587-d407-268650e6565d@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c4cbfdb3-f904-b587-d407-268650e6565d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/23/2022 7:47 AM, Denis Obrezkov wrote:
> Hello,
>
> I am writing a small LSM similar to SMACK. I've wrote a task blob init hook:
>
> static void init_task_keylock(struct task_keylock *tsp, struct
> keylock_known *task, struct keylock_known *forked)
> {
>          tsp->kl_task = task;
>          tsp->kl_forked = forked;
> }
>
> I predefined one label for the initial task (similar to SMACK's hat,
> floor, etc):
>
> struct keylock_known keylock_known_system = {
>          .label          = "system\n",
>          .kl_mask        = 7,
> };
>
> and I can see that as in SMACK I can get the label from the initial task
> into the inodes:
>
> static int keylock_inode_alloc_security(struct inode *inode)
> {
>          struct keylock_known *skp = kl_of_current();
>          pr_info("KeyLock: skp->label:%s\n", skp->label);
>          init_inode_keylock(inode, skp);
>          return 0;
> }
>
> But after few successful reads I get the kernel null page dereference error:

There's nowhere near enough information here to identify what's
going wrong here. Is the KeyLock code otherwise a copy of Smack?
Have you registered KeyLock correctly with the infrastructure?

>
> [    0.193868] Mount-cache hash table entries: 8192 (order: 4, 65536
> bytes, linear)
> [    0.194860] Mountpoint-cache hash table entries: 8192 (order: 4,
> 65536 bytes, linear)
> [    0.195883] KeyLock: skp->label:system
> [    0.195883]
> [    0.196847] KeyLock: skp->label:system
> [    0.196847]
> [    0.197844] KeyLock: skp->label:system
> [    0.197844]
> [    0.198920] KeyLock: skp->label:system
> [    0.198920]
> [    0.199958] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    0.200911] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.201825] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.202829] Spectre V1 : Mitigation: usercopy/swapgs barriers and
> __user pointer sanitization
> [    0.203825] Spectre V2 : Mitigation: Full generic retpoline
> [    0.204824] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling
> RSB on context switch
> [    0.205824] Spectre V2 : Enabling Restricted Speculation for firmware
> calls
> [    0.206825] Spectre V2 : mitigation: Enabling conditional Indirect
> Branch Prediction Barrier
> [    0.207825] Speculative Store Bypass: Mitigation: Speculative Store
> Bypass disabled via prctl and seccomp
> [    0.208828] SRBDS: Unknown: Dependent on hypervisor status
> [    0.209783] MDS: Mitigation: Clear CPU buffers
> [    0.217907] Freeing SMP alternatives memory: 40K
> [    0.218822] smpboot: CPU0: Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
> (family: 0x6, model: 0x45, stepping: 0x1)
> [    0.218961] Performance Events: Haswell events, Intel PMU driver.
> [    0.219839] ... version:                2
> [    0.220665] ... bit width:              48
> [    0.220827] ... generic registers:      4
> [    0.221660] ... value mask:             0000ffffffffffff
> [    0.221827] ... max period:             000000007fffffff
> [    0.222636] ... fixed-purpose events:   3
> [    0.222827] ... event mask:             000000070000000f
> [    0.223896] rcu: Hierarchical SRCU implementation.
> [    0.224993] smp: Bringing up secondary CPUs ...
> [    0.225771] smp: Brought up 1 node, 1 CPU
> [    0.225828] smpboot: Max logical packages: 1
> [    0.226536] smpboot: Total of 1 processors activated (4789.13 BogoMIPS)
> [    0.227006] BUG: kernel NULL pointer dereference, address:
> 0000000000000030
> [    0.227823] #PF: supervisor read access in kernel mode
> [    0.227823] #PF: error_code(0x0000) - not-present page
> [    0.227823] PGD 0 P4D 0
> [    0.227823] Oops: 0000 [#1] SMP PTI
> [    0.227823] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.17+ #4
> [    0.227823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [    0.227823] RIP: 0010:keylock_inode_alloc_security+0x2b/0x48
> [    0.227823] Code: 65 48 8b 04 25 00 6d 01 00 53 48 8b 90 58 06 00 00
> 48 89 fb 48 c7 c7 6a 7e 23 88 48 63 05 54 2e 80 00 48 8b 52 78 48 8b 2c
> 02 <48> 8b 75 30 e8 72 66 ff ff 48 63 05 44 29
> [    0.227823] RSP: 0000:ffffb50b80013d50 EFLAGS: 00010282
> [    0.227823] RAX: 0000000000000000 RBX: ffffa2bc80144320 RCX:
> 0000000000000020
> [    0.227823] RDX: ffffa2bc8005b0c0 RSI: ffffffff87367cbf RDI:
> ffffffff88237e6a
> [    0.227823] RBP: 0000000000000000 R08: 0000000000000020 R09:
> ffffa2bc8010b080
> [    0.227823] R10: 8e89d572bb4b3d14 R11: 52cbeeedbf187f36 R12:
> ffffa2bc80144320
> [    0.227823] R13: ffffa2bc80144488 R14: 0000000000000000 R15:
> ffffa2bc80149000
> [    0.227823] FS:  0000000000000000(0000) GS:ffffa2bcbbc00000(0000)
> knlGS:0000000000000000
> [    0.227823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.227823] CR2: 0000000000000030 CR3: 000000001b60c001 CR4:
> 0000000000170ef0
> [    0.227823] Call Trace:
> [    0.227823]  security_inode_alloc+0x40/0x80
> [    0.227823]  ? _cond_resched+0x10/0x20
> [    0.227823]  inode_init_always+0xd4/0x1e0
> [    0.227823]  alloc_inode+0x2b/0x90
> [    0.227823]  new_inode_pseudo+0x7/0x50
> [    0.227823]  new_inode+0xe/0x30
> [    0.227823]  shmem_get_inode+0x59/0x240
> [    0.227823]  ? shmem_put_super+0x50/0x50
> [    0.227823]  shmem_fill_super+0x1e4/0x230
> [    0.227823]  vfs_get_super+0x74/0x100
> [    0.227823]  vfs_get_tree+0x20/0xb0
> [    0.227823]  ? shmem_parse_options+0x84/0xc0
> [    0.227823]  fc_mount+0x9/0x30
> [    0.227823]  vfs_kern_mount.part.0+0x6c/0x80
> [    0.227823]  devtmpfs_init+0x47/0x149
> [    0.227823]  driver_init+0x5/0x28
> [    0.227823]  kernel_init_freeable+0xc4/0x1d3
> [    0.227823]  ? rest_init+0xa4/0xa4
> [    0.227823]  kernel_init+0x5/0xfc
> [    0.227823]  ret_from_fork+0x22/0x30
> [    0.227823] Modules linked in:
> [    0.227823] CR2: 0000000000000030
> [    0.227823] ---[ end trace 63f588023014db8e ]---
> [    0.227823] RIP: 0010:keylock_inode_alloc_security+0x2b/0x48
>
> It seems that something happens after smpboot.I assumed that the pointer
> to the initial task struct would be copied to every child task. And that
> stuct keylock_known_system would be always accessible. What could be my
> mistake?
>
