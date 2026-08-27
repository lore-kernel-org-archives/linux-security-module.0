Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B49484231;
	Thu, 27 Aug 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845816; cv=none; b=DXWw4XQztBm5O6qn3dIIAMWsSuSV9L0P1E1CzY++iF2wKSO8BQeplI7PQT3DCEKd1O0Y3s66i4bRgXjWYPcnCur/dxiTYMRWEflGkCcsefFpNVX5d155FzjI/3vtCG+KiA3IP7jzFBgxs489c7Fisk69MtvunKP7DWzwIQBAcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845816; c=relaxed/simple;
	bh=HPxOQu69spVOes/tRMhJAhpgzpaLImKQDXLe8GLMY44=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gMo4l/IYnt0BNt2ZCGFYCR2rPdCfQZ3c1Yj5LGPsiAhOmY7LvudYj6tT7YWBWLrysOqWCm+q9A6dXpSHHRghgPwudJZyPi+SOhDBr0cV60T4caU0TYuuzmcr0mteha/FQHH0ooxjE+8KQpw2kfUTKfjUko7Ht7Eo80jN0NhS0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gtn9mc4t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gtn9mc4t"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF59WJ3328746;
	Thu, 27 Aug 2026 15:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HPxOQu
	69spVOes/tRMhJAhpgzpaLImKQDXLe8GLMY44=; b=Gtn9mc4t6W3/DPiK4PtYml
	VEDFb998TeNrL6svQWWFrJqhLq4NLCWZuVTv4Nx3Gic1BpFUb4zu+/kB7C+njqWs
	4vTJE0T2a0a8pwPmjNYX3jFVXURhOG9lpj3a51EDofQ3HN1/V443hx3HsyD1VoET
	7gMXwwLsGU+QODiK+8zRgl57mubSh+5H3ECeaWE2PEkRHVI3yd1Zx394WQTa25Cg
	498QEMkSq9r8lR9QZqySVjFUZMqHXBcJVLm7zZbd/13mKVF9vd6dilizMLB3taz1
	5ARLmypQ/YHa8A/lQ0aQQ0A9+ttJX8EScbuGOP3Dn9jg2ON5nuRDNWrL4JrmS4Hg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394edxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:49:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfeiB026711;
	Thu, 27 Aug 2026 15:49:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qh3x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:49:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFnntO50004332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:49:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 904455805C;
	Thu, 27 Aug 2026 15:49:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A62A75805B;
	Thu, 27 Aug 2026 15:49:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.98.69])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:49:48 +0000 (GMT)
Message-ID: <837c208460cd7dae1259bd3fd7b8f176ab3597ba.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        "Singh, Jashandeep"
	 <jashandeep.singh@hpe.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        Jashandeep Singh <jdsw@juniper.net>
In-Reply-To: <d63a007c6d371496780d3577e64e57b4d0e11e1a.camel@huaweicloud.com>
References: <20260826191051.219090-1-jashandeep.singh@hpe.com>
		 <4ea0433a82c219d6efdb83ad0bf267045c91a374.camel@linux.ibm.com>
		 <PH7PR84MB16549E7A6AC842D358493B0F96AE2@PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM>
		 <21bf74a181df485f9daf47f9740972443e31471d.camel@linux.ibm.com>
		 <92bf67810c6ed6bc4764f330d77c3ac2279781eb.camel@huaweicloud.com>
		 <037C125E-9343-464E-A1AF-8078D3B7BA38@hpe.com>
	 <d63a007c6d371496780d3577e64e57b4d0e11e1a.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 11:49:48 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bdYF_4HTd9JB4_Ay2WDWEuvw9VYhOkKe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX4PC3i573lXfA
 X3AAx/QUSNw40FMNC3cXLqoTeIxtcbW++O8QKOlV2H2qksxb9mAUtDumJJjAPBLgW6OS4ni8DVc
 mycnMi73AMeZXKGHKwbgOb7aivTGCqErKukoETqf8Aua1jMvco9AiaKYH6por2NabYp3qccrgra
 gavappeQNLiLyqohcGFrEexitAcKSLPzh4zAThtKleydKBkfctZOC454WQb/yc62tT7xiKFA7vz
 bmRtONdm/w2xjUj1tCHMa8ixvVnDyH0vq3iC0Uv6dl76JxwOcr82WzxnRDFh4x6XndJ3mBznSNc
 AVs5SvhGxHQs6l7DSJ84+K2ubscHCurG9exaI+Q1n79F2QaQGm6hsOUmUsVOmXZDapJK54k8Xdk
 MXbisYOz8miNFltMSG/sWfrPBgjyQfNQ+BmISem2DImIZ2A4BxCyEJ0Cvnoz6l6tEOKjoNuM7UK
 JsXN1HW+iowzLCg5M7g==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a905c9f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=QYWrBf2g2jx3ett7T28A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX5aLbhd4ybU/S
 dUvJteEvqB+LTxf56jHoT489hPA2LNVAyYjGXJAtfAgB6LOI0m90QLF0bNKiMeyLBwGzaO6J5zV
 i2Qdu0f1fKf7V3TAOVTTMcBjqemlbvQ=
X-Proofpoint-ORIG-GUID: _1fm15er21bSjOVzuWxwF5ZwVJI0lRAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

On Thu, 2026-08-27 at 16:56 +0200, Roberto Sassu wrote:
> On Thu, 2026-08-27 at 14:46 +0000, Singh, Jashandeep wrote:
> > Mimi, the patch covers the case where the TPM is provisioned with a sin=
gle PCR
> > bank, SHA-384, while the default IMA hash is configured as SHA-256.
> >=20
> > The SHA-384 bank is present in nr_allocated_banks, but it matches neith=
er the
> > configured default (SHA-256) nor the current hardcoded fallbacks (SHA-2=
56, then
> > SHA-1). As a result, bank_idx remains -1, and we hit "No suitable TPM a=
lgorithm
> > for boot aggregate", leaving the boot aggregate zeroed.
> >=20
> > Roberto, it is not strictly true that the boot aggregate algorithm is a=
lways the
> > same as the default IMA hash algorithm.
> >=20
> > When the bank corresponding to the default hash is not allocated, the e=
xisting
> > SHA-256/SHA-1 fallback logic selects a different bank than the default.
> > Therefore, the boot aggregate can already use a different algorithm fro=
m the
> > configured IMA hash.
> >=20
> > My patch adds SHA-384 as one more fallback for the case where SHA-384 i=
s the
> > only allocated bank. This allows users with such a configuration to hav=
e the
> > boot aggregate computed, without requiring them to change their default=
 IMA
> > hash to SHA-384.
>=20
> That would work for your use case, but what about anyone using a single
> SHA-512 PCR bank?
>=20
> Would it be fine to add a new Kconfig and kernel option to specify a
> custom boot aggregate algorithm?

Yes, I'm fine with defining a new Kconfig and kernel option. =20

Examples:
sha384: <digest> boot_aggregate, where the digest is calculated based on th=
e TPM
384 bank PCRs.
=20
sha512: <digest> boot_aggregate, where the digest is calculated based on th=
e TPM
512 bank PCRs.

Mimi
>=20
