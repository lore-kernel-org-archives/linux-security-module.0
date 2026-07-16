Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440143C3C0F;
	Thu, 16 Jul 2026 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222782; cv=none; b=pYutCFtrIhAODzCrmBaxbg/VBkg1XCvdCsJSrZmjkb6zN5i/YhcT8fSAGSbo9t0vXsetqTcJjUuL/qHBjoyuxzqL85/8BhZU34qRfCsgNIPbSflE1gQAHlOhC3ryUVR5TnpFmOQMhSMySZxPjUdBtURZJAoRdSk9kO1VPcK+jfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222782; c=relaxed/simple;
	bh=kxrGdZ/pA2KYieSxgOwFbEEnJfAK8e7HHUUK1lHHbdU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=H2RQPDygNb29w5JMpi5ywgLN05jduTjKFx8f9wYffbF+z4E1oZPr0yiNxth43Qm+IffkyYwCRocLLRxhhuQ+w+byPAVFpi+M7t9UcRFGexsZVwCKUAVwQelCzOl8eNa/Bb6aPpQNK2+xBiEzSMwLBTv98dRoyaDY2KjQWOy/pRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fsJcQwXG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fsJcQwXG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GGfxTg3741669;
	Thu, 16 Jul 2026 17:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rfCrBs
	tEu1mUBLmvY4OaK5CLwpZDJTT3HdYfgWY0jXA=; b=fsJcQwXG1x3fx5sUMldgGC
	xglyViSfKzQ29j7IBvnPS4ta/49r0JZz8FwYpNKeHuV+JT58M5zvoaZhx2eyV3qL
	dYbyaSDBw3Iv12PjL7Uq+k46FG2OS4yPz56gxVQEckPG3n3vKwALmmIc2lgAOpc6
	UaR7UmjSaMUtJ3CgcjAQvn26pftZze1MDcYKxXNvwQzGcmG77ueKcRIPdkbrLgaX
	1uCCoduMpaF6l2UCl60AvR7IArEASIGyG7J91DYz3CYHa/p43Jd1WvZIb4E8g0vF
	xd03wcN853ayLRFpj8W8YD/zRNtOMwHu2u/KZmm1h+OMW2nxaDP3HO33scJabQ7Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc1ct8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:25:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GHJhIF000517;
	Thu, 16 Jul 2026 17:25:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k60u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:25:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GHPp1g30868064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 17:25:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 245AF58043;
	Thu, 16 Jul 2026 17:25:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87E2858055;
	Thu, 16 Jul 2026 17:25:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.108.66])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 17:25:50 +0000 (GMT)
Message-ID: <8feef400ca036688573e57725b2ec71a58416486.camel@linux.ibm.com>
Subject: Re: [PATCH -next,v2] ima: add cond_resched() in
 ima_calc_file_hash_tfm loop
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Gaosheng Cui	
 <cuigaosheng1@huawei.com>, lujialin4@huawei.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <f6ecaaf1-e226-42a5-91f9-37ecce66a5d4@huaweicloud.com>
References: <20260714091708.2802272-1-cuigaosheng1@huawei.com>
	 <e6270a062ebfdbc6d9e50ffe80ee5e77b4f0678c.camel@huaweicloud.com>
	 <f6ecaaf1-e226-42a5-91f9-37ecce66a5d4@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:25:50 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a591420 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=i0EeH86SAAAA:8
 a=EwewYPVBWNK7Zu7IW1sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE3NiBTYWx0ZWRfX/KRykf7e/ycs
 5VeWZdEwtiaXDNCFZLa+tSeQB4YygBTf77S2aRw43VY7z26DYWt6mDSBOeGaIvG+CdLutCyA+dZ
 JxxdXKcaFFNeyBlRNJpFxDflmNvJMX6diEiwmS6pNJmgfxqe5jgg2KT+IJ9HDvU+4fR6V0BTCts
 XXba/QLBdMCYb8gOjpOlTRDqrlUzmECXybFA7DibkxhySIF5dKV44wID8/X5hVMryArc1dh5uIs
 QScwJOn2dDgW0E3R18i1haXD9Ozj8Dg8n16q6kvhvhDmMXnRFaadOxyBfG8ApNt1QAP4CqCUxSk
 3tscJgvbrN8bo+AN5EmQLJHREQ5NAvlqKatiAUlT4mf3UoW7hBK81LmiDMI0wnILLt5H7ADUd4F
 jL3MKnX0fbkK5NdbKuPM4eLFQOq8QQunl0FmvXGUwu71GqnQ80gCkZIR6BE/XCz/jkhzBLfxpkN
 ePm2Q1Xq3dNYpq+BTUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE3NiBTYWx0ZWRfX3zNNgEUaupoe
 OMDxy1RQ8MBaCaytXga9d8QjKo4AGX3IDhDJWQu1c8zehH7/uZJK+j/DWaXnj7t1/YkdtuV4nSh
 4P8H6Tsf/KZcgkTt2E+nMbCTkV3mzik=
X-Proofpoint-GUID: ActN8sxOfHNqUFiDWHNUShXUFnuOtYr2
X-Proofpoint-ORIG-GUID: U5xkoKAFNG3rsn-dnxqCsMdZLF3chSVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160176

On Thu, 2026-07-16 at 09:29 +0200, Roberto Sassu wrote:
> On 7/14/2026 11:26 AM, Roberto Sassu wrote:
> > On Tue, 2026-07-14 at 17:17 +0800, Gaosheng Cui wrote:
> > > When hashing large files, the while loop in ima_calc_file_hash_tfm
> > > processes PAGE_SIZE chunks without any scheduling point, which can
> > > cause soft lockup warnings:
> > > watchdog: BUG: soft lockup - CPU#0 stuck for 50s!
> > > Call Trace:
> > >    _sha256_update+0x12d/0x1a0
> > >    ima_calc_file_hash_tfm+0xfb/0x150
> > >    ima_calc_file_hash+0x6e/0x160
> > >    ima_collect_measurement+0x202/0x340
> > >    process_measurement+0x3a9/0xb30
> > >    ima_file_check+0x56/0xa0
> > >    do_open+0x11b/0x250
> > >    path_openat+0x10b/0x1d0
> > >    do_filp_open+0xa9/0x150
> > >    do_sys_openat2+0x223/0x2a0
> > >    __x64_sys_openat+0x54/0xa0
> > >    do_syscall_64+0x59/0x110
> > >    entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > >=20
> > > Call cond_resched() every 4MB to yield the CPU when needed, rather
> > > than at every loop iteration, to reduce overhead.
> > >=20
> > > Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider=
")
> > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> >=20
> > Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Actually, as Sashiko pointed out, alignment does not work well, since=20
> __kernel_read() can return fewer than PAGE_SIZE bytes, causing the=20
> offset to be always misaligned.

It would be interesting to know if short reads are a generic concern across=
 all
filesystems or whether it is limited to remote or FUSE filesystems. The pat=
ch
probably won't change, but please update the patch description with more
details.

Mimi

> Instead, we can keep a variable with the=20
> number of bytes read since last cond_resched(), which we reset when we=
=20
> hit 4 MB.
>=20
> Sashiko also noted that the same mechanism could apply for=20
> calc_buffer_shash_tfm(), but we can add it later if we have a warning=20
> (note that in this case we already have the buffer, we are not doing
> I/O).
>=20
> Thanks
>=20
> Roberto
>=20
> > Thanks
> >=20
> > Roberto
> >=20
> > > ---
> > > v2: call cond_resched() every 4MB to yield the CPU when needed
> > >   security/integrity/ima/ima_crypto.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity=
/ima/ima_crypto.c
> > > index 0d72b48249ee..aab2349c0c33 100644
> > > --- a/security/integrity/ima/ima_crypto.c
> > > +++ b/security/integrity/ima/ima_crypto.c
> > > @@ -233,6 +233,9 @@ static int ima_calc_file_hash_tfm(struct file *fi=
le,
> > >   		rc =3D crypto_shash_update(shash, rbuf, rbuf_len);
> > >   		if (rc)
> > >   			break;
> > > +
> > > +		if (IS_ALIGNED(offset, SZ_4M))
> > > +			cond_resched();
> > >   	}
> > >   	kfree(rbuf);
> > >   out:
> >=20
>=20
