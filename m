Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDC3955CA;
	Wed, 26 Aug 2026 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787786071; cv=none; b=u5bfTsn8yMih8qo9DKHI8ty7r8uBpqzacIBWkDjk78qbg6uFbmhujFGIzJwoLmGiHBEn+vLr91LuUHcLKqzf1Ffz6nQEe/5FqEktpNwSrN9DKHK1cVBvvLFPAOrwUtHBmpd8tUjVaum9h4NUOCSbSGvy5QMInvSdQWsgKKtY2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787786071; c=relaxed/simple;
	bh=r4Q+9FRjTXyHrCbuzgzJZEne8FbiCn4ajw263KnS9Xw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Qo32aHRJb4BVn9StPieIg8NY68Iu6t1fig6mqXr/SS51MyOqSPv0APozyyC/DvGPUF2Sn/HVd/NlIuWaV+ElZozUH6IYll8qv2bWK/VnDd6bSG4EJN+Xm37H79ygIf9o06gnpCU0ybDhrAmBfq6IjQRj5kIpIw1Ai+J/PNFZjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z9pptXh6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z9pptXh6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QL1Ynk3280523;
	Wed, 26 Aug 2026 23:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lcAJfX
	iOPQp6Qh0jISwkxyBYW5KhBfvBU3njyOUt4q4=; b=Z9pptXh6tzy8hqEhXoJG64
	JM5DKPclJ0roBJIcwpfDKGXiWdxMY+nSpjo8xMhgB7FymI5e6I2qeYbne+dsZFXk
	MjRFacsJq2cCHTPkWXwanzgD4x1hiaksHeXkvf+vJo7Z6imBSGdmj83MbfQlCmJ0
	94eBRnh3jmCisKyCaEmAnAEaKskptAOp6sx1JU1U78WhT4XMjxBgxBtnmBcZe5OY
	YYZUD1QybmI3iCvmBh//G8xfxmu6v20UaiYe3+vEm5Cg9l9ABHUWqVsxk3NuDKKr
	gyqLVBswloPepVqihOil3jEVj6btyTrIMtyDYk1o/lRPl8VDOkOpVFMTQYoIuBwA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er1nes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 23:14:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QNBFKE021876;
	Wed, 26 Aug 2026 23:14:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragmj06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 23:14:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QNEJMc19399202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 23:14:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F4885805E;
	Wed, 26 Aug 2026 23:14:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70D3F58051;
	Wed, 26 Aug 2026 23:14:18 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.63])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 23:14:18 +0000 (GMT)
Message-ID: <21bf74a181df485f9daf47f9740972443e31471d.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Singh, Jashandeep" <jashandeep.singh@hpe.com>,
        Roberto Sassu
	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        Jashandeep Singh <jdsw@juniper.net>
In-Reply-To: <PH7PR84MB16549E7A6AC842D358493B0F96AE2@PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM>
References: <20260826191051.219090-1-jashandeep.singh@hpe.com>
	 <4ea0433a82c219d6efdb83ad0bf267045c91a374.camel@linux.ibm.com>
	 <PH7PR84MB16549E7A6AC842D358493B0F96AE2@PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 19:14:17 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: wNikh9eYVxmC-4eVOCiDDOryJYocVdrX
X-Proofpoint-ORIG-GUID: StecVo8jO5gnhUsJ4qYZWkyE-TgWwa0b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfX4VThMTaynoE8
 rtrMk3wyOQ6pY1uiO9RikrB42l88rFQ7+PY7aMXOepUngS2OakpU7onk91tr0jLEYfcEhHxVTdu
 ThQ075TA+p3Og/gV0DsLPF6oA1M3JNwUb8Yts41rKyLk+IxMAitelQtklSNNrpO/WgorvaPxlUp
 XY2kQcJLIRT29qULZ8kOmUAovoUWasgH+mnHQ4cVT/uW4XXhxg3uI2ytEPLZiNIx07pLLDYDrrK
 HmV9o232M2H322tWqwcTnui/7vgFHJZqpmxROMjadv333XceOcibJf4TuzaAPulCs6d4g9lGksW
 X775EnZBW4tP1ZSXI0cwCfJQEZ9K/Db0jV9Y/bnv1BGZjlFsZVmhLfksst9HiP0g9+wtPNKa5In
 7jtpuspiNwLrd79HzrxqFn/OVhuCP+O5xl/JSgD+BRaSXDoKadlFhMxlbOwFUr9JzXhmFzfsx6G
 DIgCqVvzTCChn7z5+Jw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f734c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=tfP5eB9Pq6O3CzWxs5kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfX80Pc8yKdOK/b
 Vn7ppxk8VfhNKMU/UKe6CskKvyLUJnUvQvz6dPCsTBfwdJfQXTniAQGtzLl8JVrAl+KX8vt4R9/
 Xivtx+jWWTPEuDrjAdtcs946UkeLjH8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260194

Hi Jashan,

Mail to the kernel mailing lists are in plain text. Please refer to
https://docs.kernel.org/process/submitting-patches.html#no-mime-no-links-no=
-compression-no-attachments-just-plain-text

On Wed, 2026-08-26 at 22:35 +0000, Singh, Jashandeep wrote:
> Thanks Mimi.
>=20
>=20
> Agreed that all allocated banks are extended via tpm_pcr_extend() - but t=
hat's
> the PCR-extend (write) path. The failure is in ima_calc_boot_aggregate(),=
 which
> reads PCRs 0-9 from a *single* selected bank.
>=20
>=20
> The issue is that a TPM can be provisioned with *only* the SHA-384 bank e=
nabled,
> while the default IMA hash algorithm is SHA-256. In this configuration, t=
he
> current selection logic only matches the configured IMA default, then SHA=
-256,
> and then SHA-1 - it never considers SHA-384.

It's walking the list of allocated TPM banks and, if allocated, sets bank_i=
dx.

        for (i =3D 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
                crypto_id =3D ima_tpm_chip->allocated_banks[i].crypto_id;
                if (crypto_id =3D=3D hash->algo) {
                        bank_idx =3D i;
                        break;
                }

The question is why isn't the sha384 bank found in the list of
nr_allocated_banks?

Mimi

>=20
> Adding a SHA-384 match allows the boot aggregate to be computed correctly
> (sha384:...) instead of returning 0 and logging "No suitable TPM algorith=
m for
> boot aggregate". The fact that the SHA-384 bank can be selected and the b=
oot
> aggregate computed also confirms that the SHA-384 bank is recognized and
> allocated, rather than being missing.
