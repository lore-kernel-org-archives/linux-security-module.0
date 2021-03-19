Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD00C433DB
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Mar 2021 20:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC86F61949
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Mar 2021 20:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCSUXP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:23:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229974AbhCSUWu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Mar 2021 16:22:50 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JK2nQc039737;
        Fri, 19 Mar 2021 16:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fvDOE5GPv+JKcowSF8ox2nWujEkH+8ZN2jopckY08Hc=;
 b=B5GEMDykYvb+LkBj3fjkj4QAWBDH6Fbm1yBkb5zTR7Mu6OBo2A9/0TpP6SfE5ru/IYes
 GtPYE36fO/uO3890Gm4YjsIsW48FICjpX+IDtH02055qEq+ciP9dJCR5ily4IG6H6pts
 afg8yfvTLQFClzAcHBsSocvspG5VPBkFJoqtZStSAr+yqkWdKCIX2kxh2rF0asjAeLjM
 8IQBQhohcw+gq9c5eDpMjJuIMpNRnzlyX5zSHouXd9VCfbO7u0I9jvQD2mhbq7GKZ/B6
 ykv1YnV8/xkGZLFlFy00fetmnJKDqDP8t+WbPqXLESYs3eZcuDrFl7ifWpXFc87xF+cb jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37cw5at1pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 16:22:43 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12JKLeX4111818;
        Fri, 19 Mar 2021 16:22:43 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37cw5at1ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 16:22:43 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12JKInmC026509;
        Fri, 19 Mar 2021 20:22:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 378n18b769-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 20:22:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12JKMLW837093676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 20:22:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59F8B42045;
        Fri, 19 Mar 2021 20:22:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39D654203F;
        Fri, 19 Mar 2021 20:22:36 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.66.110])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Mar 2021 20:22:35 +0000 (GMT)
Message-ID: <e804b6031eea8c35a71f39c44d409c902a6e2e8b.camel@linux.ibm.com>
Subject: Re: NULL deref in integrity_inode_get
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, d.kasatkin@samsung.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>
Date:   Fri, 19 Mar 2021 16:22:35 -0400
In-Reply-To: <CACT4Y+YCJ3CPR4LHqY8j_g3=vM6-iKoCc96d8OJuZ-N9KKeZkg@mail.gmail.com>
References: <CACT4Y+YBXLi=quMEyBHtLO3-Ef6E3CAN7toFUdTFJWeH+5Y7kg@mail.gmail.com>
         <31c4e1863a561c47d38b8e547ec38a0a713bdadc.camel@linux.ibm.com>
         <CACT4Y+b8cNr1zv=RFPLXf9vY==BSktM1vb9gOfcWyBEaojZ1-A@mail.gmail.com>
         <dbf9e31ca38b36b757c71bcc8fa17cb1ae392f1c.camel@linux.ibm.com>
         <CACT4Y+YCJ3CPR4LHqY8j_g3=vM6-iKoCc96d8OJuZ-N9KKeZkg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_10:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103190135
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2021-03-18 at 07:53 +0100, Dmitry Vyukov wrote:
> On Thu, Mar 18, 2021 at 3:18 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Mon, 2021-03-15 at 14:07 +0100, Dmitry Vyukov wrote:
> > > On Mon, Mar 15, 2021 at 1:41 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > >
> > > > On Mon, 2021-03-15 at 11:58 +0100, Dmitry Vyukov wrote:
> > > > > Hi,
> > > > >
> > > > > I am trying to boot 5.12-rc3 with this config:
> > > > > https://github.com/google/syzkaller/blob/cc1cff8f1e1a585894796d6eae8c51eef98037e6/dashboard/config/linux/upstream-smack-kasan.config
> > > > >
> > > > > in qemu:
> > > > > qemu-system-x86_64       -enable-kvm     -machine q35,nvdimm -cpu
> > > > > max,migratable=off -smp 4       -m 4G,slots=4,maxmem=16G        -hda
> > > > > wheezy.img      -kernel arch/x86/boot/bzImage   -nographic -vga std
> > > > >  -soundhw all     -usb -usbdevice tablet  -bt hci -bt device:keyboard
> > > > >    -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net
> > > > > nic,model=virtio-net-pci   -object
> > > > > memory-backend-file,id=pmem1,share=off,mem-path=/dev/zero,size=64M
> > > > >   -device nvdimm,id=nvdimm1,memdev=pmem1  -append "console=ttyS0
> > > > > root=/dev/sda earlyprintk=serial rodata=n oops=panic panic_on_warn=1
> > > > > panic=86400 lsm=smack numa=fake=2 nopcid dummy_hcd.num=8"   -pidfile
> > > > > vm_pid -m 2G -cpu host
> > > > >
> > > > > But it crashes on NULL deref in integrity_inode_get during boot:
> > > > >
> > > > > Run /sbin/init as init process
> > > > > BUG: kernel NULL pointer dereference, address: 000000000000001c
> > > > > #PF: supervisor read access in kernel mode
> > > > > #PF: error_code(0x0000) - not-present page
> > > > > PGD 0 P4D 0
> > > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > > CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2+ #97
> > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > > > rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
> > > > > RIP: 0010:kmem_cache_alloc+0x2b/0x370 mm/slub.c:2920
> > > > > Code: 57 41 56 41 55 41 54 41 89 f4 55 48 89 fd 53 48 83 ec 10 44 8b
> > > > > 3d d9 1f 90 0b 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 <8b> 5f
> > > > > 1c 4cf
> > > > > RSP: 0000:ffffc9000032f9d8 EFLAGS: 00010246
> > > > > RAX: 0000000000000000 RBX: ffff888017fc4f00 RCX: 0000000000000000
> > > > > RDX: ffff888040220000 RSI: 0000000000000c40 RDI: 0000000000000000
> > > > > RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888019263627
> > > > > R10: ffffffff83937cd1 R11: 0000000000000000 R12: 0000000000000c40
> > > > > R13: ffff888019263538 R14: 0000000000000000 R15: 0000000000ffffff
> > > > > FS:  0000000000000000(0000) GS:ffff88802d180000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 000000000000001c CR3: 000000000b48e000 CR4: 0000000000750ee0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > PKRU: 55555554
> > > > > Call Trace:
> > > > >  integrity_inode_get+0x47/0x260 security/integrity/iint.c:105
> > > > >  process_measurement+0x33d/0x17e0 security/integrity/ima/ima_main.c:237
> > > > >  ima_bprm_check+0xde/0x210 security/integrity/ima/ima_main.c:474
> > > > >  security_bprm_check+0x7d/0xa0 security/security.c:845
> > > > >  search_binary_handler fs/exec.c:1708 [inline]
> > > > >  exec_binprm fs/exec.c:1761 [inline]
> > > > >  bprm_execve fs/exec.c:1830 [inline]
> > > > >  bprm_execve+0x764/0x19a0 fs/exec.c:1792
> > > > >  kernel_execve+0x370/0x460 fs/exec.c:1973
> > > > >  try_to_run_init_process+0x14/0x4e init/main.c:1366
> > > > >  kernel_init+0x11d/0x1b8 init/main.c:1477
> > > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> > > > > Modules linked in:
> > > > > CR2: 000000000000001c
> > > > > ---[ end trace 22d601a500de7d79 ]---
> > > >
> > > > It looks like integrity_inode_get() fails to alloc memory.   Only on
> > > > failure to verify the integrity of a file would an error be returned.
> > > > I think that is what you would want to happen.  Without an "appraise"
> > > > policy, this shouldn't happen.
> > >
> > > It happens at the very boot. I think the cache is NULL.
> >
> > An IMA policy had to have been loaded in order for
> > integrity_inode_get() to have been called.   If this is happening on
> > boot, it's too early for a custom policy to have been loaded by
> > userspace, but I don't see the builtin policy defined on the boot
> > command line either.
> >
> > Any additional information would be much appreciated.
> 
> Hi Mimi,
> 
> I provided kernel config and qemu command line. What other information
> are you looking for? Can you reproduce it on your side?

Yes, finally I was able to reproduce the NULL deref.  I just posted two
patches as an RFC.  As described in the 2/2 patch description, it's
unclear why the iint_cache would not be initialized, yet an IMA policy
is loaded.  If the kmem_cache_alloc() for the iint_cache failed, it
would have panic'ed.  Perhaps you have some insights as to how this
might happen.

Once reviewed/tested, I'll re-post a proper patch (fixing the patch
author).

thanks,

Mimi

