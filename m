Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB142BE033;
	Wed, 14 Oct 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791937478; cv=none; b=q3ccpaxdDKwTfVXzMhQzQ+sH3nIm3sxumIFETVkww7SaF+l0EAQHYsnzq7D0sELn7uEzBCMDH7iNQdQEaeAzgI/v05g5dJdyohtygk/OQX07Dg1IQtzMLkFFfUU13UVJAaBG8aKI/1wfZKxVgxwAsbRTt59a5eAEOhZ+vLBMoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791937478; c=relaxed/simple;
	bh=Dg3KB7kBk/4vBj6qfoHrHBN15RCoTW+CTZPxpFdNFuU=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=QBSk2bDCYPCxHSk4Qg5CUQQJJxMIs+6MMWeVGq9V5aC5TyzAm9dsH1SWJMeSrLo+Yz0UbKDnsVt1ty4IAz7bTqo/bb/2N5Pf7K3WiW34B0eRnjdb8rd7SIQzqNkJ82SI9bApudw1bpzifBPvOdKiLBw/mkjg18qsDf+0e9B8ryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GEsnc5GL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GEsnc5GL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DLw7Wd1891312;
	Wed, 14 Oct 2026 00:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BiQoby
	PmHJeqRhPWVPsiOxkpJu2a4cSyjS6m6NvPhN8=; b=GEsnc5GLQjHCBmPlL4KkO4
	lt/mhoxYI/8mHCO/rFHMdsJ8GYzOXi5PVNlmFjnPdVZobvnc7IJq2LD25sEkAc9u
	xNxUi6bKHaslzMfAqPZpJEYn8a01Wi17AKogYC9/wBAeo61FmDuNEFA6KiqCvN6q
	CQ47GgDVFduTNkS1Loxj8gIyP3plDMlntzNKm+U72+vn+vaigPQCGNf0z+OtOGo3
	YllQJfBYdHxAg65pDyWSR8vwfvNi1fXgpgDaD6xFrAHxwdBBFl+jQf2gqtQEEBxC
	7Nu9+Qp+DQ2REA+XhILMdjgZ79ROTgjX55l/3pfOhCLsDpf/La+3j8/zxhTfme0Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3hkkn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 00:24:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DL5lkC3303974;
	Wed, 14 Oct 2026 00:24:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6tda3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 00:24:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E0OPLQ40829642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 00:24:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38BE25805D;
	Wed, 14 Oct 2026 00:24:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A251658052;
	Wed, 14 Oct 2026 00:24:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.95.51])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 00:24:24 +0000 (GMT)
Message-ID: <d30a02a4624c8570c005e0d7e7db808de7eacfaa.camel@linux.ibm.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 __configfs_open_file (2)
From: Mimi Zohar <zohar@linux.ibm.com>
To: syzbot <syzbot+c87014f645f2fd24312e@syzkaller.appspotmail.com>,
        a.hindborg@kernel.org, leitao@debian.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
In-Reply-To: <6aceaf21.8cdf6287.1eb53.0174.GAE@google.com>
References: <6aceaf21.8cdf6287.1eb53.0174.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:24:24 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qhtC-pk2dxjAPZixsyK1xNdoKqmeMj9_
X-Proofpoint-ORIG-GUID: qhtC-pk2dxjAPZixsyK1xNdoKqmeMj9_
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acecbbb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=edf1wS77AAAA:8
 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=9UXA8gvBw8XVqFqs_TcA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwMCBTYWx0ZWRfX+jDRAWbQ+XYo
 Y1qMpbmjYyl17nNuVGTYc3wzUDpd+bSZgkqo3t2/LAmW59g5nKOP+g1Wbos/o6xiF869eqqbzC2
 NbgFXKHP4euGNlnXd1s8EOWVL9QZac8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwMCBTYWx0ZWRfXxEm1eecCxU48
 B3xuEovCwHXaMHokM4mNv7IOM/O0mKXIKtypQv5ixp2P07jFhvLDhoRISB3MKLD570bqt3YfOtV
 Aqka8MkimqE7sUqz0yTy1o3ipRX1nW9axoKjsi2JfLjc0JIJ5DYmXt2ktjR8M7gMt1g2Jag2CvI
 hlInncua7iNi/r//VWUaOsVrT1CcdZH+AvNl3tTsWVTDRlLKSnWu6pa50C+6kWYzAesLtnNl8Oa
 EETv2gLySBmQRcZD9rnA3CixCEwyFdWF1kT9wu9o+wU4ceOf5UnIjTAfQxTGiJUincdePNlvmeL
 +hEaX//zocn2eqpphIIgkQ580bArL4gHmWgHpp732GmjggIwCzlnIqedR95rGOATQTZ2eOUGIRj
 Bcvl25678fLLzq3v3c11LFdD6DZTTtdRG6zhY36cizVzCE82eBI0+q7eQkw0wgf4UCXl5Ff7+jU
 3gtRxHRi7wXU7B4gQYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140000

On Tue, 2026-10-13 at 15:22 -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>=20
> HEAD commit:    24a19b953e2a Linux 7.3-rc7
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D165f3c3558000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D129d675874dbf=
896
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc87014f645f2fd2=
4312e
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for D=
ebian) 2.44
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10cf93d158000=
0
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c87014f645f2fd24312e@syzkaller.appspotmail.com
>=20

Commits 8e22ce504f8a ("ima: don't measure/appraise files on configfs") and
ab84c314417e ("configfs: move CONFIGFS_MAGIC definition to magic.h") addres=
sed
this or a similar issue for the builtin IMA policies. If you're using a cus=
tom
IMA policy, it needs a configfs dont_measure and/or dont_appraise rule.

Please provide the IMA policy.

Mimi


> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor387/5997 is trying to acquire lock:
> ffff888035be1570 (&p->frag_sem){.+.+}-{4:4}, at: __configfs_open_file+0xe=
8/0x9c0 fs/configfs/file.c:304
>=20
> but task is already holding lock:
> ffffffff91d84848 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlin=
k/genetlink.c:1217
>=20
> which lock already depends on the new lock.
>=20
>=20
> the existing dependency chain (in reverse order) is:
>=20
> -> #3 (cb_lock){++++}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
>        genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
>        netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
>        netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1364
>        netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1919
>        sock_sendmsg_nosec net/socket.c:800 [inline]
>        __sock_sendmsg net/socket.c:815 [inline]
>        sock_sendmsg+0x394/0x410 net/socket.c:838
>        splice_to_socket+0xb3c/0x11a0 fs/splice.c:884
>        do_splice_from fs/splice.c:936 [inline]
>        do_splice+0x109c/0x1fa0 fs/splice.c:1349
>        __do_splice+0x33b/0x370 fs/splice.c:1431
>        __do_sys_splice fs/splice.c:1634 [inline]
>        __se_sys_splice fs/splice.c:1616 [inline]
>        __x64_sys_splice+0x187/0x250 fs/splice.c:1616
>        do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>        do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> -> #2 (&pipe->mutex){+.+.}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        __mutex_lock_common kernel/locking/mutex.c:646 [inline]
>        __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
>        fifo_open+0x139/0xb40 fs/pipe.c:1235
>        do_dentry_open+0x6ab/0x14d0 fs/open.c:996
>        vfs_open+0x82/0x3f0 fs/open.c:1101
>        do_open fs/namei.c:4866 [inline]
>        path_openat+0x19fa/0x2440 fs/namei.c:5029
>        do_file_open+0x20e/0x430 fs/namei.c:5058
>        file_open_name+0x1c3/0x3e0 fs/open.c:1375
>        filp_open+0x2e/0x50 fs/open.c:1392
>        fsg_lun_open+0x6b/0x7b0 drivers/usb/gadget/function/storage_common=
.c:194
>        fsg_store_file+0x1e7/0x450 drivers/usb/gadget/function/storage_com=
mon.c:455
>        flush_write_buffer fs/configfs/file.c:207 [inline]
>        configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
>        new_sync_write fs/read_write.c:595 [inline]
>        vfs_write+0x6af/0x1050 fs/read_write.c:687
>        ksys_write+0x12a/0x250 fs/read_write.c:739
>        do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>        do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> -> #1 (&common->filesem){+.+.}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
>        fsg_store_file+0x264/0x450 drivers/usb/gadget/function/storage_com=
mon.c:452
>        flush_write_buffer fs/configfs/file.c:207 [inline]
>        configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
>        new_sync_write fs/read_write.c:595 [inline]
>        vfs_write+0x6af/0x1050 fs/read_write.c:687
>        ksys_write+0x12a/0x250 fs/read_write.c:739
>        do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>        do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> -> #0 (&p->frag_sem){.+.+}-{4:4}:
>        check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
>        check_prevs_add kernel/locking/lockdep.c:3328 [inline]
>        validate_chain kernel/locking/lockdep.c:3952 [inline]
>        __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
>        __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304
>        do_dentry_open+0x6ab/0x14d0 fs/open.c:996
>        vfs_open+0x82/0x3f0 fs/open.c:1101
>        do_open fs/namei.c:4866 [inline]
>        path_openat+0x19fa/0x2440 fs/namei.c:5029
>        do_file_open+0x20e/0x430 fs/namei.c:5058
>        file_open_name+0x1c3/0x3e0 fs/open.c:1375
>        filp_open+0x2e/0x50 fs/open.c:1392
>        kernel_read_file_from_path_initns+0xec/0x240 fs/kernel_read_file.c=
:159
>        fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549=
 [inline]
>        _request_firmware+0x733/0x13c0 drivers/base/firmware_loader/main.c=
:873
>        request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:948
>        reg_reload_regdb+0x85/0x460 net/wireless/reg.c:1067
>        genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
>        genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
>        genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
>        netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2575
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>        netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
>        netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1364
>        netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1919
>        sock_sendmsg_nosec net/socket.c:800 [inline]
>        __sock_sendmsg net/socket.c:815 [inline]
>        sock_sendmsg+0x394/0x410 net/socket.c:838
>        splice_to_socket+0xb3c/0x11a0 fs/splice.c:884
>        do_splice_from fs/splice.c:936 [inline]
>        do_splice+0x109c/0x1fa0 fs/splice.c:1349
>        __do_splice+0x33b/0x370 fs/splice.c:1431
>        __do_sys_splice fs/splice.c:1634 [inline]
>        __se_sys_splice fs/splice.c:1616 [inline]
>        __x64_sys_splice+0x187/0x250 fs/splice.c:1616
>        do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>        do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> other info that might help us debug this:
>=20
> Chain exists of:
>   &p->frag_sem --> &pipe->mutex --> cb_lock
>=20
>  Possible unsafe locking scenario:
>=20
>        CPU0                    CPU1
>        ----                    ----
>   rlock(cb_lock);
>                                lock(&pipe->mutex);
>                                lock(cb_lock);
>   rlock(&p->frag_sem);
>=20
>  *** DEADLOCK ***
>=20
> locks held by syz-executor387/5997: 2, last CPU#0:
>  #0: ffff888035fc7860 (&pipe->mutex){+.+.}-{4:4}, at: pipe_lock fs/pipe.c=
:91 [inline]
>  #0: ffff888035fc7860 (&pipe->mutex){+.+.}-{4:4}, at: pipe_lock+0x69/0x80=
 fs/pipe.c:88
>  #1: ffffffff91d84848 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/n=
etlink/genetlink.c:1217
>=20
> stack backtrace:
> CPU: 0 UID: 0 PID: 5997 Comm: syz-executor387 Not tainted syzkaller #0 PR=
EEMPT(full)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
>  check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
>  check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
>  check_prevs_add kernel/locking/lockdep.c:3328 [inline]
>  validate_chain kernel/locking/lockdep.c:3952 [inline]
>  __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
>  lock_acquire kernel/locking/lockdep.c:5942 [inline]
>  lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>  down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
>  __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304
>  do_dentry_open+0x6ab/0x14d0 fs/open.c:996
>  vfs_open+0x82/0x3f0 fs/open.c:1101
>  do_open fs/namei.c:4866 [inline]
>  path_openat+0x19fa/0x2440 fs/namei.c:5029
>  do_file_open+0x20e/0x430 fs/namei.c:5058
>  file_open_name+0x1c3/0x3e0 fs/open.c:1375
>  filp_open+0x2e/0x50 fs/open.c:1392
>  kernel_read_file_from_path_initns+0xec/0x240 fs/kernel_read_file.c:159
>  fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inli=
ne]
>  _request_firmware+0x733/0x13c0 drivers/base/firmware_loader/main.c:873
>  request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:948
>  reg_reload_regdb+0x85/0x460 net/wireless/reg.c:1067
>  genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
>  genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
>  genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
>  netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2575
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>  netlink_unicast_kernel net/netlink/af_netlink.c:1338 [inline]
>  netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1364
>  netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1919
>  sock_sendmsg_nosec net/socket.c:800 [inline]
>  __sock_sendmsg net/socket.c:815 [inline]
>  sock_sendmsg+0x394/0x410 net/socket.c:838
>  splice_to_socket+0xb3c/0x11a0 fs/splice.c:884
>  do_splice_from fs/splice.c:936 [inline]
>  do_splice+0x109c/0x1fa0 fs/splice.c:1349
>  __do_splice+0x33b/0x370 fs/splice.c:1431
>  __do_sys_splice fs/splice.c:1634 [inline]
>  __se_sys_splice fs/splice.c:1616 [inline]
>  __x64_sys_splice+0x187/0x250 fs/splice.c:1616
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7180644b5e
> Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4=
d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41=
 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
> RSP: 002b:00007f717cde6f18 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
> RAX: ffffffffffffffda RBX: 00007f717cde76c0 RCX: 00007f7180644b5e
> RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000011
> RBP: 00007f717cde6fe0 R08: 0000000000000014 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000012
> R13: 00007f717cde6f80 R14: 000000000000017e R15: 0000000000000010
>  </TASK>
> faux_driver regulatory: loading /lib/firmware/regulatory.db failed with e=
rror -26
> faux_driver regulatory: Direct firmware load for regulatory.db failed wit=
h error -26
> faux_driver regulatory: Falling back to sysfs fallback for: regulatory.db
>=20
>=20
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
