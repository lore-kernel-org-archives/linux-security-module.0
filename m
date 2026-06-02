Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C878F2E;
	Tue,  2 Jun 2026 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403717; cv=none; b=TGFh0d2EMzEDq0pb2LGiwgz0muibhRUJUVZOVg/cEyaDSTwwidSDwqNyVtZRpSbxpLs3vaXQbYMhaxYecRfXbjsbkcfXe/qCjD+gxAFgY82gqQB6pzEBz9AzNS84KcRh+SnBTqa59FEs3fiQ1M7UIGAm03mXGcwflZUGtupd8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403717; c=relaxed/simple;
	bh=FDw/n+wS7YDYsm/651Su1VNYnWAmHFxTEeQYEdwSsIg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=NFXqLXiRM4yO5WyELpPe9KAjKNwNG4thgVTgACRyvZErAB4FaXic6Z0GFE3T4Dcu4qU9en8b3vKe5JlMt8NJxkA6l9fGljCI0VOwHh5IMZoF1o/fKN9eSwFEGN72+D2mxWq/NTFp6hy3tjj2jRiK6yi5Y7iEwXaZjfGeBlM0vNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iSShF75z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iSShF75z"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6523Smnc1360394;
	Tue, 2 Jun 2026 12:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FOG7rl
	uINvSrtMUxhwJWeJxtO+eZVEniq2/V9GNbAow=; b=iSShF75zhWa8+wJ2KyXE42
	FcMrxhwfX6LsQJ0JbQMehNL8Kx3BVEtOEqQjkro/o1C9hDpPzWd5esme0l4WxEge
	byWTBLNgLQBaA2R9VcqQ/8v8hEwzv8HsM7HzJjCJVaF5RK8xL6wXuv7IZTRkWNQh
	OCIRsbJ54TfDYXPMVdNgfwqGrWgsyw9PV0Q2Sd5uO409ERtoWG7NcB0Ac4Mrcyij
	DddVRs0I14naoOi9v/j6whpbVC4rDLz2JtaTxkjzCTNkIqktMwA00XY+m0AjWbn3
	GPZpC6+Ybq5J7T0DbZfUZSMTm/YJB6Ppt0vcF6pe572xzAPLGEa1U4M0fZw2zyVA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd45x3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:34:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652CO7Rj011908;
	Tue, 2 Jun 2026 12:34:49 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qbdhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:34:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652CYmeN5440258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 12:34:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 522715805D;
	Tue,  2 Jun 2026 12:34:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBEB258053;
	Tue,  2 Jun 2026 12:34:46 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.48.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 12:34:46 +0000 (GMT)
Message-ID: <5c52effb1b4723c025f478c1c902bf83a9a4d0ed.camel@linux.ibm.com>
Subject: Re: [PATCH v5 3/4] security: ima: rename boot_aggregate when ima
 is initialised at late_sync
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com, roberto.sassu@huaweicloud.com, noodles@earth.li,
        jarkko@kernel.org, sudeep.holla@kernel.org, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        jgg@ziepe.ca, Jonathan McDowell <noodles@meta.com>
In-Reply-To: <20260601142749.3379697-4-yeoreum.yun@arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
	 <20260601142749.3379697-4-yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 08:34:46 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfX1/g8jRMrdEqv
 uNuQEWTLvwXkTguwemDuuHjFSmCo28NRSpxFGZAKfaB40FxGsWQkR07NQSklJd8BqHkgtcRYEWM
 MVABDTJNNUEK3B1I5zKJMLfz5RaSaphs55EzERpFuUdbWsAyfHMllNGWpMY1q49SYrji52IUQrc
 cto/HNPbJkmdAcj1OElbAB1xLNJN5rjT9Tn9ntF+489lemXz6lbrycuPgVkmS2XcRmbj4/J8bCq
 Li6i8FvC4p4k9OQdWBebgIbZ4erBUChfvDpsMY13U5WIh7m7QoRhDSpc6x1T/JVhAuYP1fWrN7Y
 D/aCZTP9oN1Ley8TX6znflnVmZpgxXeLvKDTyDjlonQh8hOap7RjWhIj+RaYWNwZBCT7Rh7wJ97
 tWQKvUBnP7q+qSRLmvuA4gQXDrtx1aJNrkFtDOwJIieHYOnS3fR9yWzz54Iy29AdUswSV3x/YR/
 agsYm42w4A1vqayI4ww==
X-Proofpoint-GUID: elNur2XUZmHeE_jFM2AyFLxQR1gRuSEA
X-Proofpoint-ORIG-GUID: e3S1vITmyF5br7guAq4kaHB0EKSozwiI
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1ecdea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VabnemYjAAAA:8
 a=7CQSdrXTAAAA:8 a=DDGuNG6xrOoNSW4XS2IA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116

On Mon, 2026-06-01 at 15:27 +0100, Yeoreum Yun wrote:
> From: Jonathan McDowell <noodles@meta.com>
>=20
> The Linux IMA (Integrity Measurement Architecture) subsystem used for
> secure boot, file integrity, or remote attestation cannot be a loadable
> module for few reasons listed below:
>=20
>  o Boot-Time Integrity: IMA=E2=80=99s main role is to measure and apprais=
e files
>    before they are used. This includes measuring critical system files
>    during early boot (e.g., init, init scripts, login binaries). If IMA
>    were a module, it would be loaded too late to cover those.
>=20
>  o TPM Dependency: IMA integrates tightly with the TPM to record
>    measurements into PCRs. The TPM must be initialized early (ideally
>    before init_ima()), which aligns with IMA being built-in.
>=20
>  o Security Model: IMA is part of a Trusted Computing Base (TCB). Making
>    it a module would weaken the security model, as a potentially
>    compromised system could delay or tamper with its initialization.
>=20
> IMA must be built-in to ensure it starts measuring from the earliest
> possible point in boot which inturn implies TPM must be initialised and
> ready to use before IMA.
>=20
> Unfortunately some TPM drivers (such as Arm FF-A, or SPI attached TPM
> devices) are not reliably available during the initcall_late stage,
> resulting in a log error:
>=20
>   ima: No TPM chip found, activating TPM-bypass!
>=20
> To address this issue, IMA_INIT_LATE_SYNC is introduced.
> However, a remote attestation service cannot determine when IMA has been
> initialized because the boot_aggregate measurement name remains unchanged=
,
> even though IMA is initialized later at late_initcall_sync when
> IMA_INIT_LATE_SYNC is enabled.
>=20
> Therefore, use a distinct boot_aggregate name when IMA_INIT_LATE_SYNC
> is enabled, allowing the remote attestation service to identify
> when IMA has been initialized.
>=20
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> [yeoreum.yun@arm.com: modified to align with the IMA_INIT_LATE_SYNC chang=
e]

Thanks, Yeoreum. This version requires your Signed-off-by tag as well as
Jonathan's.  Otherwise the patch looks good.

Mimi
