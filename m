Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468242;
	b=YKQEgk4No54wyABa9/SqdhdEt2PyQWhsKq9zdFELIdkfMd2CkPmx27Yw2FabOiLKAcE0
	 q3rAWMPslNKP5wAPOCmmNUQPohNZgUbZzRV6sFA/hHglnMDwGpj/CtxHVFa6AyyO72l6A
	 SXO7Un8JT2tIQ/614eb3KPCp3aDAhEhfr1UZ9EfnoN8y48hN7MrFbCFVm1WTcPqIWk1hT
	 Nn8GlVtdkFtrAUlOjANmseCAKdkB1oAdlaVt+shAAnoEvFMnQvBRczoy3jmqtnDxu0UAe
	 nRl0d97NP7UCYNswkZ6cm1/vNzATi/ToOmR6L1YfZC2INl3/g/+bIBoMBROzjHCn07Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468242;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JSmMfi8nnjAJL+DuEDaO1ThTt7fmHihoQamAsFc9DWs=;
	b=nZsiNmexY5buu625/UlPGigVTm+2nfvPX0Vz7sQPC49kgtNyCUVO2zEHWAaCE/gfYK5U
	 TUsiW2gewuRlTj8thcjBCuozJ4qz+LYpQb5yaluG9kyDYTyoAH9J6tNhdZVQ/1p4vx0Bq
	 +reQYObDuW7MURlFlFXMjSQmyyoIHYu7NwqDAQT+NaWg4HwuBv+fMP8POsvKuu5E9yRau
	 QHLdLM/TcjCgo1hRYHFnN9snJZLU1228AsHT8ltqgpebq89hkSox0rRkhaIhJ+6WTCpUU
	 ldPp8ZC4O+YrujRf/NgWy9a2kVawGYyFndDmr18RJmOmvgcdXF02Zyykz5YwvsvwDgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AGKE+zVd;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7A606A32E;
	Mon, 23 Nov 2026 21:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF7A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AGKE+zVd
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANK4Xl3385067;
	Mon, 23 Nov 2026 21:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JSmMfi
	8nnjAJL+DuEDaO1ThTt7fmHihoQamAsFc9DWs=; b=AGKE+zVdlXxhzRCangPShD
	H70SLj/JhjX7Rw8rAbQZoxs9BSXjB6JU9E1O3wrT9uYmSCXmoRBPUDXgsHZEziam
	LeIurg+kru8/VC6v3Tr1z9YD0XBFV1OCpf+w9O95MF++lDXADqDhy2Esschtmp+M
	Lr+2y/z4p/knkLBtWFAf09ycbPcSiI3gGInwK0Iy3hIi2i8X238KsbBMHNQxTREX
	JUse7SolDPDwCFwO4Q++UejOWbu7gNkuVcHY2ebiSj4xZ39jbEhOYvFxjARvwAn1
	6E/rnMHcDJjHJP1pWOiGz95HAKyMyLKfOxmiQt3AOMnhyJwPQ58oP1Zsv2bZrFYA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkd1eg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 21:10:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANK4Dr21661639;
	Mon, 23 Nov 2026 21:10:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vgd2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 21:10:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANLA1l231064794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 21:10:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C41E358043;
	Mon, 23 Nov 2026 21:10:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 086CE5805E;
	Mon, 23 Nov 2026 21:10:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.1.98])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 21:10:00 +0000 (GMT)
Message-ID: <7cbff903ec83459cb9779246feae1fb7f09f1ff9.camel@linux.ibm.com>
Subject: Re: ima/evm: security.ima and security.evm get written to frozen
 filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>,
        Roberto Sassu
	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>, Jan Kara <jack@suse.cz>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261114-erstmal-vererben-leibhaftig-63db6f0c66ba@brauner>
References: <20261114-erstmal-vererben-leibhaftig-63db6f0c66ba@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 16:10:00 -0500
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4NCBTYWx0ZWRfX7aL3UBut5JMJ
 NPN2isEMouIz7flV5l7vQ1VHSy92kv9dMEYaaPKLPO8iGCRl9BE1pqsffWuUbDXNhbcN4v3NMP0
 b3SXC3rmhdEXTwyN9xnuglUgiZMjJMTSSG6CH3J4f09l8UDld1jYqLP8Ypcnrg589ERdw590Fli
 9XrFVpMXtico+jqckJT2XtEsjs1aORY3tY41+WERZINYel7ZonLINAoy0eQqUo+iWV14RlqUeug
 TJ1UKpCyk6aP5FWF/AZj+SaAzibmdY9md9QyDbM0WzWA7oTilIeVsajT/2ZBgQg/FlgXDdxY/gh
 /Ah1wn0BCcfNk4vHwj0TIm3+OfznaPTK2MtPvom/8K97uyfGJiJMmC+V6zAGZCDL9NiL7nTH5+i
 V76FpgovvST25k1+XxkXJZ1O2FM4bHbXnNQVLheNvS0P799ED65NCM7FQ43us/vuA6ybWprEm5F
 NCwofHTbxPuvTLel8jQ==
X-Proofpoint-ORIG-GUID: kgdlJEV6Rao3rHDc7-Ormnca69SL9eVd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4NCBTYWx0ZWRfX0QfgH4TJX3AG
 1PvnKplWjpfJbs1ZCCTI+JXydrceIR/s1GlOqb8ejl33HHbBiRM83KlvqL8kSoF38lgp0H/u+fP
 f8HW20frj7pG2qXOzJkT0EbugTN+geg=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b04abab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=07d9gI8wAAAA:8
 a=Ob-wfNTW1uyOBEMPRfkA:9 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-GUID: sQjVTpHWstVkW5PTss8mPecRnqURlCvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230084

On Sat, 2026-11-14 at 00:55 +0100, Christian Brauner wrote:
> Hey,
>=20
> I'm working on some freeze protection fixes that plague the tree.
> IMA and EVM update security.ima and security.evm without freeze
> protection. IOW, they modify filesystems that are frozen. On ext4 that
> trips the WARN_ON() in ext4_journal_check_start().
>=20
> The update on the last close:
>=20
> __fput()
> -> security_file_release()
>    -> ima_file_free()
>       -> ima_check_last_writer()                  # iint->mutex
>          -> ima_update_xattr()                    # inode lock
>             -> ima_fix_xattr()
>                -> __vfs_setxattr_noperm(security.ima)
>                   -> evm_inode_post_setxattr()
>                      -> evm_update_evmxattr()
>=20
> Nothing on that path holds sb_writers. Write to a file covered by an
> appraise policy, freeze the filesystem, close the file.
>=20
> The same happens when files are appraised:
>=20
> - fix mode: ima_appraise_measurement() -> ima_fix_xattr() and
>   evm_fix_hmac()
> - evm_verify_hmac() converting a digsig into an HMAC
>=20
> for open, exec, mmap and kernel_read_file(). Only an O_TRUNC open of an
> existing file holds sb_writers there.
>=20
> Reproducer on v7.4-rc1, booted with ima_appraise=3Dfix, ext4 on /dev/vdb:
>=20
>     mount /dev/vdb /mnt
>     echo "appraise fsuuid=3D$(blkid -s UUID -o value /dev/vdb)" > /sys/ke=
rnel/security/ima/policy
>     echo a > /mnt/f; sync
>     exec 3>>/mnt/f; echo b >&3
>     fsfreeze -f /mnt
>     exec 3>&-
>=20
> The close rewrites security.ima on the frozen filesystem:
>=20
>   WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0=
, CPU#0: bash/280
>   Call Trace:
>    __ext4_journal_start_sb+0x7a/0x470
>    ext4_xattr_set+0x20d/0x380
>    __vfs_setxattr+0x10f/0x170
>    __vfs_setxattr_noperm+0xf4/0x5e0
>    ima_update_xattr+0x1bb/0x2a0
>    ima_file_free+0x2a7/0x3c0
>    security_file_release+0x55/0x60
>    __fput+0x2d6/0xab0
>    fput_close_sync+0xf2/0x1c0
>    filp_close_sync+0x5c/0x90
>    __x64_sys_close+0x71/0xe0
>    do_syscall_64+0x10e/0x5e0
>=20
> Removing security.ima from a file and opening it while frozen does the
> same from the appraisal:
>=20
>    __vfs_setxattr_noperm+0xf4/0x5e0
>    ima_appraise_measurement+0x2d2/0x36a0
>    process_measurement+0x15b8/0x2120
>    ima_file_check+0xbc/0x110
>    security_file_post_open+0x3f/0x90
>    path_openat+0x4ab/0x2300
>=20
> I don't think this has a trivial fix. iint->mutex nests inside
> sb_writers: do_open() holds mnt_want_write() for O_TRUNC across
> security_file_post_open() -> ima_file_check() -> process_measurement().
>=20
> So taking sb_start_write() under iint->mutex or under the inode lock
> inverts the order and deadlocks against a pending freeze:
>=20
> - close holds iint->mutex and waits in sb_start_write()
> - an O_TRUNC open holds sb_writers and waits for iint->mutex
> - the freezer waits for the open
>=20
> Skipping the update while frozen isn't great either.
> ima_check_last_writer() has already cleared IMA_UPDATE_XATTR by then and
> nothing redoes the update, so the next open in enforce mode fails with
> -EACCES on the stale hash.
>=20
> For close the only thing I see is taking sb_start_write() before
> iint->mutex when an update may be needed. That makes close() block
> while the filesystem is frozen, which xfs_file_release() goes out of
> its way to avoid.
>=20
> The appraisal-time fixups can use sb_start_write_trylock() and skip when
> frozen since they're best effort anyway.
>=20
> This goes back to 2fe5d6def167 ("ima: integrity appraisal extension").

Hi Christian,

Thanks for the detailed report and reproducer. I only looked at the
ima_file_free() side, since that is where neither blocking in close() nor
dropping the update looks good.

The only option I came up with is to try sb_start_write_trylock() in
ima_update_xattr(), after the hashing and just before the xattr write, and =
if it
fails, defer only that write to a workqueue. Everything that needs the stru=
ct
file, including the hashing, stays synchronous. The worker would take
sb_start_write(), then iint->mutex and inode_lock() (the same order as the =
open
path), and write only if no new writer has appeared and the change cookie s=
till
matches. The EVM update is triggered by the xattr write, so it is deferred =
with
it.

Where this does not work is an open while the filesystem is still frozen. F=
reeze
blocks writers, not read opens, and close has already cleared IMA_DONE_MASK=
, so
I believe the open re-appraises and compares the new hash with the stale on=
-disk
xattr. In enforce mode that is -EACCES. After thaw, an open could flush the
pending update inline before verifying, so only the window during the freez=
e is
affected.

Options for that window:

  1. Accept -EACCES for files closed during a freeze until thaw.

  2. Make the open wait for thaw. That changes behavior for read opens, and
     the wait would have to happen before taking iint->mutex.

  3. Appraise against the digest pending in the iint instead of the
     stale on-disk xattr. This seems workable for IMA alone, but not
     for EVM: security.evm is only recomputed as a side effect of
     writing security.ima, so nothing covers the pending digest.

This is from reading the code and discussing with AI, not from testing.

(For background on fput-time locking in IMA, see LWN, "Toward a safer
fput()", April 2012. [1]).

Thanks,

Mimi

[1] https://lwn.net/Articles/494158/
