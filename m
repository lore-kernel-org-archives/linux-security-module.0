Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBE37C0F0;
	Mon, 17 Aug 2026 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009590; cv=none; b=qYeNShKk6rphFKbEOLkknMAfLCEbK0qpLDJailQyDp9Qxd/sNgfaIRt7VXE1fOzXcr+dpyyAdvGez+SF8TL2TZSJzqNTDyUH70/Ck0UwSd/c9NeYjH4ihIagVqksDs9JyEKcFhNJEXCQZMztkj6eTbkytfYwNKbwkNJKVrkQWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009590; c=relaxed/simple;
	bh=4VKa0ovl2BzCgFCUn8uqDiOPBuhT1+4TmUMM3lj8HJ4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=t1+ClXaa55le8zGXLCEiqE/i6tsygmJr39HpcG+BK/BZ+L5FAbxoXd9psMeoEBvYzl0coXd5ySaKgXileS4BXe/lIjB6AwcYqiNjhOlIJoUBkRHke7sVWhbPafCz+0PwKj97eFhSYdAxPXavTlXwI6G6rVJ49bsDyIOhzdgt/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nQq90aTo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nQq90aTo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1UaR758599;
	Mon, 17 Aug 2026 23:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2xGT+O
	Py5aZE4e9cOIFHIaSjJaeCm4VCRcfBJEgIBt8=; b=nQq90aTouWkBh2yfdEIaNj
	dDh0CcWbC6y/t+nDbJcyOpEP1Jlip9cWzFR4ASlrxk+hEYmvvmqthc4bcTBSyb0K
	CoeNHyxVpBw/BGEKfISNjgcs7m0kP55+et+3wZZ9AD4oSPvur5Kuo6YtILUgr/lH
	1s0hkZNpIoTNe2QZPgBhJjITlphhAWUPs9hbwb//cnLF1RbximYfCYLyHqavHH6X
	IWSUphHV9tcD03EeVZ5TVWMLHHwORJJ5vEqRhOgWew/ajqCWDofiv1pdr3v5b1hk
	sSRADEU3ydt6A83mIyWtDog8RpK6w8gXo5jPzacdRj2yT01csWqpwO22EcPQN4fw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqmxtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 23:32:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HNQH9S028293;
	Mon, 17 Aug 2026 23:32:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y8315-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 23:32:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HNWjtJ20054630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 23:32:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C04158052;
	Mon, 17 Aug 2026 23:32:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39B4158045;
	Mon, 17 Aug 2026 23:32:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.11.167])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 23:32:44 +0000 (GMT)
Message-ID: <415f81878ac595830e5b5051a5828311c2434e03.camel@linux.ibm.com>
Subject: Re: [syzbot] [lsm?] [integrity?] possible deadlock in
 ima_file_truncate
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>
Cc: syzbot <syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com>,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        roberto.sassu@huawei.com, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
In-Reply-To: <cevxz5bpcfdm5uvjmu3a6qql2qar4477oczd4knffn4wkgojds@ubo47iitdo6k>
References: <6a77c7cd.b50370da.49fe0.0031.GAE@google.com>
	 <cc5bsuwzvdoqrhgggqqb6qgkgh2cxymbupt4ghsi2msnudh4rf@slzwriyjykze>
	 <6045f93f2e2c2ad4f6227509d363e75bf2340510.camel@linux.ibm.com>
	 <cevxz5bpcfdm5uvjmu3a6qql2qar4477oczd4knffn4wkgojds@ubo47iitdo6k>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 19:32:43 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfX3Ic9ZSQSLplX
 GylBTCbNsdFIvbBpGlO9HBeYOLjjyQk88zp6SVfpZCYSlhEkek0TWrinjEaa7ea8XDYkph/BBkA
 4Hrp6SckadfCueVL3ULm7/ddARRa3ciuHeoPsAW0VbPFw8w6Mh4cc+iyuVlacRpYtC6Tu7S2M6k
 6/he57aFlTGGDMjKZaVpvdB1qLKSv0F/E2CViMFmNLlpfaWUhm842w+kcKuf7R0n7LgB4x8nPsO
 43ULyO+59xAzmi4l1JR0HslrYn1aiujvv0SYw0YueSW6mVpu6Df6nYrorYti2yV/fGh66q0Ef7Y
 nexSJewK8x02jmmOe+ycRDIHhJebYbOcViTR76ZOlYAtIQXHnQ0oJEXguH/xZZZzJ5BAcNIiQp5
 bK0MyHMvbvHl5kasEPmoBIFN8QEDg4hF3Vs27pwZtlKwzgiwfKHCgdSZiZMFbdLs7oBVdKKPvnt
 rM5F8e0cz4wpVbKoBCg==
X-Proofpoint-ORIG-GUID: j-SY2fL3Vq0iX_JZbRrYGEsZAjgzBuCS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE4MCBTYWx0ZWRfX6Hx7uoLzUfbP
 I/GH+AsbePpsP5n17peevNrrPuUJKYK51EI5Oa3yHx0mmRPb/QN9DssVpDwobjeGRnmh+QEwy94
 rxY4rFKZUdoLsCzOqOdKN7MFvcmsVDU=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a839a1f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=edf1wS77AAAA:8
 a=3g80flMcAAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=3YjeI9n-X-Ja20jhcPkA:9
 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=QEXdDO2ut3YA:10 a=slFVYn995OdndYK6izCD:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22
 a=-WsGb18yrIRSV60qWLiz:22 a=NWVoK91CQySWRX1oVYDe:22 a=lAIPu-TSoPCgWs-2gwLQ:22
X-Proofpoint-GUID: 9j1D1IXv_-zK-ryOyllecDz3zVIMk19u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170180

On Mon, 2026-08-17 at 17:40 -0500, Frederick Lawler wrote:
> On Mon, Aug 17, 2026 at 06:21:57PM -0400, Mimi Zohar wrote:
> > On Mon, 2026-08-17 at 15:43 -0500, Frederick Lawler wrote:
> > > On Sat, Aug 08, 2026 at 05:20:29PM -0700, syzbot wrote:
> > > > Hello,
> > > >=20
> > > > syzbot found the following issue on:
> > > >=20
> > > > HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.ker=
nel.org..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D113c53b=
9580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D145fa60=
d73086782
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D448c2e24b=
1ceff13ed2a
> > > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils=
 for Debian) 2.44
> > > >=20
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >=20
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7=
fd/disk-c21bb419.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/=
vmlinux-c21bb419.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/28318410=
0427/bzImage-c21bb419.xz
> > > >=20
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > WARNING: possible circular locking dependency detected
> > > > syzkaller #0 Not tainted
> > > > ------------------------------------------------------
> > > > syz.3.857/8643 is trying to acquire lock:
> > > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_=
reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
> > > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_=
reset_action_flags security/integrity/ima/ima_main.c:697 [inline]
> > > > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_=
file_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723
> > > >=20
> > > > but task is already holding lock:
> > > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: do_open fs/namei.c=
:4693 [inline]
> > > > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: path_openat+0x2929=
/0x4280 fs/namei.c:4863
> > > >=20
> > >=20
> > > I had AI whip up a reproducer for this, but it's not mutually exclusi=
ve to the
> > > added patch. Tested by running reproducer, then unapplied patch, stil=
l
> > > reproduced on v7.2-rc4.
> > >=20
> > > I'll need to simplify it before I post it.
> > >=20
> > > #syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in process_m=
easurement (6)
> > >=20
> > > See below for un-applied repro result.
> >=20
> > Hi Fred,
> >=20
> > In response to this syzbot, I responded:
>=20
> Sorry, I must've missed that.
>=20
> > Like other pseudo filesystems, configfs files should not be measured by=
 IMA.  To
> > addresss this particular bug, please add a rule to the builtin
> > dont_measure_rules[] and default_appraise_rule[] policies.
> >=20
> > Without the configfs filesystem being in policy, can you reproduce the =
deadlock?
>=20
> I was not able to.

Do have time to post 2 patches - one to move the configfs magic number to
magic.h and the other to update the IMA builtin policies?

thanks,

Mimi
