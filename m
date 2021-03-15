Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA0C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Mar 2021 12:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A7564EB6
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Mar 2021 12:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhCOMmM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Mar 2021 08:42:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhCOMlt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Mar 2021 08:41:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FCYNeg116163;
        Mon, 15 Mar 2021 08:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=AWUj5QnJ1eCR/ts0f3fygZ/kkYbXG0oc6rIHZFNv8xo=;
 b=MnzpBm7unuw5wOMy7GruS0IMRGY4atz3IPPagpmfJ0xgPcYhogmCjMW2QDegURHEgtxY
 yt8VLPV59lkLvlls9CJClivq968N8PsmoLpkM9VEuMj7NkTaqVbTWS3CFyOVohjn1TPe
 uglEG0yELetB40Bz9sgjnSKNSploPdZo8exWoD7sjLdUNclquUahGOCiFC8gUP5xQRNk
 VvfemhdF8r9ujTR6DEkGxRpuFesakGTiWN9gbsFhWqOW5HOXQWaUZEQQk9cg0Dly+eEi
 bwa5/Z5VUzc/6SxGsjCObzZb0RbOvXZ+9xo3KUmhvF3aMPgp/ivx/O/FXazUN0pimup/ Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 379yhqn8sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 08:41:37 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12FCYaob117137;
        Mon, 15 Mar 2021 08:41:37 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 379yhqn8rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 08:41:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12FCSGqF000892;
        Mon, 15 Mar 2021 12:41:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 378n18huua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 12:41:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12FCfWcn42598718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 12:41:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 698484204C;
        Mon, 15 Mar 2021 12:41:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A206342041;
        Mon, 15 Mar 2021 12:41:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.67.76])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Mar 2021 12:41:29 +0000 (GMT)
Message-ID: <31c4e1863a561c47d38b8e547ec38a0a713bdadc.camel@linux.ibm.com>
Subject: Re: NULL deref in integrity_inode_get
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, d.kasatkin@samsung.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>
Date:   Mon, 15 Mar 2021 08:41:28 -0400
In-Reply-To: <CACT4Y+YBXLi=quMEyBHtLO3-Ef6E3CAN7toFUdTFJWeH+5Y7kg@mail.gmail.com>
References: <CACT4Y+YBXLi=quMEyBHtLO3-Ef6E3CAN7toFUdTFJWeH+5Y7kg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_05:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011 phishscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103150088
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Dmitry,

On Mon, 2021-03-15 at 11:58 +0100, Dmitry Vyukov wrote:
> Hi,
> 
> I am trying to boot 5.12-rc3 with this config:
> https://github.com/google/syzkaller/blob/cc1cff8f1e1a585894796d6eae8c51eef98037e6/dashboard/config/linux/upstream-smack-kasan.config
> 
> in qemu:
> qemu-system-x86_64       -enable-kvm     -machine q35,nvdimm -cpu
> max,migratable=off -smp 4       -m 4G,slots=4,maxmem=16G        -hda
> wheezy.img      -kernel arch/x86/boot/bzImage   -nographic -vga std
>  -soundhw all     -usb -usbdevice tablet  -bt hci -bt device:keyboard
>    -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net
> nic,model=virtio-net-pci   -object
> memory-backend-file,id=pmem1,share=off,mem-path=/dev/zero,size=64M
>   -device nvdimm,id=nvdimm1,memdev=pmem1  -append "console=ttyS0
> root=/dev/sda earlyprintk=serial rodata=n oops=panic panic_on_warn=1
> panic=86400 lsm=smack numa=fake=2 nopcid dummy_hcd.num=8"   -pidfile
> vm_pid -m 2G -cpu host
> 
> But it crashes on NULL deref in integrity_inode_get during boot:
> 
> Run /sbin/init as init process
> BUG: kernel NULL pointer dereference, address: 000000000000001c
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2+ #97
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
> RIP: 0010:kmem_cache_alloc+0x2b/0x370 mm/slub.c:2920
> Code: 57 41 56 41 55 41 54 41 89 f4 55 48 89 fd 53 48 83 ec 10 44 8b
> 3d d9 1f 90 0b 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 <8b> 5f
> 1c 4cf
> RSP: 0000:ffffc9000032f9d8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff888017fc4f00 RCX: 0000000000000000
> RDX: ffff888040220000 RSI: 0000000000000c40 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888019263627
> R10: ffffffff83937cd1 R11: 0000000000000000 R12: 0000000000000c40
> R13: ffff888019263538 R14: 0000000000000000 R15: 0000000000ffffff
> FS:  0000000000000000(0000) GS:ffff88802d180000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000000001c CR3: 000000000b48e000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  integrity_inode_get+0x47/0x260 security/integrity/iint.c:105
>  process_measurement+0x33d/0x17e0 security/integrity/ima/ima_main.c:237
>  ima_bprm_check+0xde/0x210 security/integrity/ima/ima_main.c:474
>  security_bprm_check+0x7d/0xa0 security/security.c:845
>  search_binary_handler fs/exec.c:1708 [inline]
>  exec_binprm fs/exec.c:1761 [inline]
>  bprm_execve fs/exec.c:1830 [inline]
>  bprm_execve+0x764/0x19a0 fs/exec.c:1792
>  kernel_execve+0x370/0x460 fs/exec.c:1973
>  try_to_run_init_process+0x14/0x4e init/main.c:1366
>  kernel_init+0x11d/0x1b8 init/main.c:1477
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Modules linked in:
> CR2: 000000000000001c
> ---[ end trace 22d601a500de7d79 ]---

It looks like integrity_inode_get() fails to alloc memory.   Only on
failure to verify the integrity of a file would an error be returned.  
I think that is what you would want to happen.  Without an "appraise"
policy, this shouldn't happen.

Mimi

