Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313436194F;
	Mon, 24 Aug 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583669; cv=none; b=qyC5jtvsy/vVM1hJJvSBUjzcxX4Bl80zcM/FhKYi4SJQMAq3k2U+Xfjbwu8yz3THi724i9iJ8gh9586kKQtSkK8r9cErhmeBWDbBfuuQ9es5dcwtEo0xqDe4+SV/H6D7TSFZuxA4dl0e43d2j1XqIT43ZUgIJ87vuKfg5Veqk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583669; c=relaxed/simple;
	bh=9PJyneQN1rbkLHUOBUDcMYW9ibOosIrOyUZx+jZFhRA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=MYIVayDSkGS7BNVFi8WgYHlBEcLRt4yV3vwoVQIE5g3UX8X+5cIjBwjCVobCl3bDWbyBVTF5akm+jfg/oI7O7L9PX+NQrMdqMo4kaN/we692fTAGGBa2XrmiewVHb4cQf0OpgS4LkCO66+nypPPxSsqBP0WKrrVwGQjs4ImwvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CuFNvatk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CuFNvatk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1YbA1935893;
	Mon, 24 Aug 2026 15:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9PJyne
	QN1rbkLHUOBUDcMYW9ibOosIrOyUZx+jZFhRA=; b=CuFNvatk1OmkTflkXMVCKC
	56cGrtFrHBpAzOU7SmhZD6cgFTRF07EyZsFnhxbjXH6bWLOe9yyz0Cnp6RpA7tp3
	omnq44XmPznW9x5iuQoDaYcVJtONWy+e8/Uppq7IhfUhQP5rDZeZEZNTwF6U+8vW
	EaTFOykdt+jNAPAY6txPbohz8g6uY7rqNMEzOLFNWc3SLF5Gss4QFr0I720zmdrF
	WMdXo2GQU04vyg/LkEnFyejFtwyTRLQ3TP1OuWaRfUm//p0J6j04uY8fNQ/Qwhr3
	XHE5jJlU7Ws0UuzMwlJxcJEO/CELkGGbMWYYQypXnmpxv4127dKyRSsJeKW2niBw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393t632-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 15:00:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEuJKS005182;
	Mon, 24 Aug 2026 15:00:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jpp76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 15:00:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OF0pDI11338398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 15:00:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 321DE58063;
	Mon, 24 Aug 2026 15:00:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33D6258043;
	Mon, 24 Aug 2026 15:00:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.99.227])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 15:00:50 +0000 (GMT)
Message-ID: <ca87a913bece92019d04ffb2f795f8365fde4a87.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: clean up IMA_MEASURE_PCR_IDX in Kconfig
From: Mimi Zohar <zohar@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260822001545.354195-1-julianbraha@gmail.com>
References: <20260822001545.354195-1-julianbraha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:00:52 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: lSIC-83PxmPB0rmylq3bvUStF9kSzhmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX4KX+wKYWgL1e
 ErtEjw5opoCmWx48wFVa6NjypulM00b8UgrXjRjCERgohSfow+VFdDEbfD4n1+POHSceDAxL3AK
 PGgQ/uQgoHUBAJh2o0rq1QPswmqGDqpRj8q1ODR00vjvu5Hfoqu5kpOhEy3QkPHrgrT9mNK8Ltz
 hYmEjcngMFUQ1vib7EZzEcyUh0KOgQjcDjch48fP7nhgNFjdgLbw1D/ntU8nFu0gKfW2F03oej+
 kr24mMFYIgeubb0fDadxx1Oe6B2yEg/CzYNnM8WJ56n6Wi30BcU95iPLSsjFDmTaj/wJ/nX/OEB
 lGhZZcsI9+oN9qnobRdWMdVrfWqqPy0ZXfUi+7WRHj5P3OuSkbYOBanmi1UMy1LdevRkcQYbNr8
 RL97NqqoKxmaLzTx2dhZKgueHtxfzNjcLs/xMdHjQT9mye4DfSQcOwmFzVM3G7ivzkZ6B/ruIdt
 beQUECS+qbsuYWvsV2w==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c5ca6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=d3y6Pl4EezBHqMEs6AAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX33qnKY50u3T9
 41ctrPYVjJQtKKoaP1DdWhAdtLs/dRptRHa8/rlNFOFRE3JlB7WX8G2yzDLIJVDE91wORIyhDnO
 Aw5FelxTgDxlNnq+lnlUs9Cc0q+yOOw=
X-Proofpoint-ORIG-GUID: 8JRHElZUXz9OTOyZaODC-rsvKCX3W2eh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

On Sat, 2026-08-22 at 01:15 +0100, Julian Braha wrote:
> The IMA_MEASURE_PCR_IDX option is not visible for users to set, so it
> always uses its default, 10. This means that the 'range 8 14' is dead
> code, and the "If unsure, use the default 10" in the help text is
> misleading because the user *has no other choice*.
>=20
> During the first patch submission to add this option in 2008 [1],
> the submitter originally gave this option a prompt:
>=20
> "PCR for Aggregate (8 <=3D Index <=3D 14)"
>=20
> then later removed it in the revision, without adjusting the rest of the
> option accordingly [2].
>=20
> Let's clean up this of this IMA_MEASURE_PCR_IDX config option to be
> consistent with its current, non-visible state.
>=20
> This dead range was found by kconfirm, a static analysis tool for Kconfig=
.
>=20
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

The PCR index can be specified as a Kconfig IMA_MEASURE_PCR_IDX and on
individual policy records via the "pcr=3D" option.

Mimi
