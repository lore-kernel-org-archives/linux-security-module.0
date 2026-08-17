Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4822D9EFF;
	Mon, 17 Aug 2026 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005341; cv=none; b=Msr2uV9y3nUBRRgmE1lDWyPrTLyOyD7KVxiZv7CHw4EznX86D5RU0ie1zV4X1vkWbz3bsk0n7OqUOHffpCbVLlF48BCB4VFM7891OSq0QAKIi/Ha4X30cwzMyyGlU80pmnbJXRwDgwJLJF4eYto+88nzEHl5N6aOxGYdvwLNFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005341; c=relaxed/simple;
	bh=n973ktAQQQHUHkmEI6VuAthTNpTRJ7eS/bUArlODWco=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=egRYsR1Uh7VTkTrzSl7yWLnCssDb8HLYEdtH2zqDlllm3UXfhX7qv2pJu80M7qSwch+0VPqb8Kw0vItvxAj6BAZEo05WLFUtB3WDjzef2PCxA+wl6JyNCcEm3a6SvsRbg0UH6vCBuoETqK01zEMD6CPz3GyVmgQDsUe5QCKSD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GqxUsnV1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GqxUsnV1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1erS2668944;
	Mon, 17 Aug 2026 22:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rh6WQC
	NlcuOBFHWDGZZkI/HvnYWo6HZ/grlyeERQQXQ=; b=GqxUsnV1+kMqwqYYLeEXBK
	zDakdVmz3S436jQkXl4b3xrsnYK2AeJEUS7asvIvfQafrOIK+UMZu0yIynOOLm3i
	2hJJpVq7d7n3CoQaimKRFUimehsRRbQ0JE3iHtivGujq5ICibWw5g7izTxphLjN5
	u7A6Y9ceZqPsIG1scl/YFjvFqau448gkhds2kLdtaXWAOvdpyzsmTwHSZC4JMGsM
	cAndjE9ZUn1ipf7t9qsaugoAfa0aiXgG92MkNwdpTcvIqpvqMOdDg6zrhdMtzkwh
	HES/PPGPMzr3FPfphZhSb9QfuiiXllPrebTQ54FTJKdoaogFDh+oaAz+a7pEy3lw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt49ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 22:21:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HMBJ6F028320;
	Mon, 17 Aug 2026 22:21:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh026g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 22:21:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HMLKjE7275118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 22:21:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAB135805D;
	Mon, 17 Aug 2026 22:21:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6C6A58059;
	Mon, 17 Aug 2026 22:21:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.11.167])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 22:21:57 +0000 (GMT)
Message-ID: <6045f93f2e2c2ad4f6227509d363e75bf2340510.camel@linux.ibm.com>
Subject: Re: [syzbot] [lsm?] [integrity?] possible deadlock in
 ima_file_truncate
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>,
        syzbot
	 <syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com>
Cc: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        roberto.sassu@huawei.com, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
In-Reply-To: <cc5bsuwzvdoqrhgggqqb6qgkgh2cxymbupt4ghsi2msnudh4rf@slzwriyjykze>
References: <6a77c7cd.b50370da.49fe0.0031.GAE@google.com>
	 <cc5bsuwzvdoqrhgggqqb6qgkgh2cxymbupt4ghsi2msnudh4rf@slzwriyjykze>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 18:21:57 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a838988 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=edf1wS77AAAA:8
 a=3g80flMcAAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=z6WGd-5gti96ELmFajoA:9
 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=QEXdDO2ut3YA:10 a=slFVYn995OdndYK6izCD:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22
 a=-WsGb18yrIRSV60qWLiz:22 a=NWVoK91CQySWRX1oVYDe:22 a=lAIPu-TSoPCgWs-2gwLQ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE2OCBTYWx0ZWRfX4xKQAstcGEPe
 ICSqvFdVbBlziZoGFWrrqqgqVeRGzpOJW7bFWhKMbS9KleoS2KHYCYLPI9FebBFfvT8+wHDwrA1
 22Uq0YIQR+BtMopTkILU6pJIEsh6WPQ=
X-Proofpoint-GUID: gmLff2jDvRCW6kdbM9lElHBh4qAObL9E
X-Proofpoint-ORIG-GUID: _SxEi-FM0GEqj2zeyPUBh1oPJYpvovK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE2OCBTYWx0ZWRfX68s2cSqnGo0M
 anM01dRNe9zy7q7LVAWQsR47ZjUMhjJZosWDK9WVRqGT0HVW7yKrfcIJTUGBLN1SeDkQ/KPIraW
 NDOua+OPbd9kWo/m4n+fDoedoWCrY1zJgA8aZ5aLNQRZszzCjPvkB3o8sC33vxL9vO7dggmv7Lc
 G56MxDlFBS08PfSyNKp9jbJOmidoWrLY+J0koAIsAHxJxaouey2HTm3hu+wGcvTJjkN/Wcy9UxA
 mmmwgKaLjZwp7yeLu3lZPvoKYhmaPXFmLikf6LiTkZd/+wmp+Lqj0FTftOx3B5KuZ+a8xOjX7ci
 MHuARcXKBulPVSJSz5V3RY4WhsQf9uviPkWw1VTvB/pnDxAoXk5YUA4MhTXHIK/rUwHVxhU2LRE
 Tx6fNT+jEY1NG/Xgbn93yb9uxCLMH0km8Xth8jPK9/50ASch9fKJrO+ZugqUrAhJDV4qMwFxAeT
 DIq88J1QJTrnT2dou+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170168

On Mon, 2026-08-17 at 15:43 -0500, Frederick Lawler wrote:
> On Sat, Aug 08, 2026 at 05:20:29PM -0700, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.=
org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D113c53b9580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D145fa60d730=
86782
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D448c2e24b1cef=
f13ed2a
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for=
 Debian) 2.44
> >=20
> > Unfortunately, I don't have any reproducer for this issue yet.
> >=20
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/dde4460fa7fd/d=
isk-c21bb419.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e1fe13568a84/vmli=
nux-c21bb419.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/283184100427=
/bzImage-c21bb419.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz.3.857/8643 is trying to acquire lock:
> > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_rese=
t_action_flags security/integrity/ima/ima_main.c:708 [inline]
> > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_rese=
t_action_flags security/integrity/ima/ima_main.c:697 [inline]
> > ffff888037be2480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_file=
_truncate+0xe6/0x190 security/integrity/ima/ima_main.c:723
> >=20
> > but task is already holding lock:
> > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: do_open fs/namei.c:469=
3 [inline]
> > ffff888035fc0450 (sb_writers#6){.+.+}-{0:0}, at: path_openat+0x2929/0x4=
280 fs/namei.c:4863
> >=20
>=20
> I had AI whip up a reproducer for this, but it's not mutually exclusive t=
o the
> added patch. Tested by running reproducer, then unapplied patch, still
> reproduced on v7.2-rc4.
>=20
> I'll need to simplify it before I post it.
>=20
> #syz dup: [syzbot] [integrity?] [lsm?] possible deadlock in process_measu=
rement (6)
>=20
> See below for un-applied repro result.

Hi Fred,

In response to this syzbot, I responded:

Like other pseudo filesystems, configfs files should not be measured by IMA=
.  To
addresss this particular bug, please add a rule to the builtin
dont_measure_rules[] and default_appraise_rule[] policies.

Without the configfs filesystem being in policy, can you reproduce the dead=
lock?

thanks,

Mimi
