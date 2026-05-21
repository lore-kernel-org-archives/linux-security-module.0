Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F27217555;
	Thu, 21 May 2026 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328961; cv=none; b=PSxXRczvO3Iac4bdDgh7yNVxP4jPiL6GYrBn+lNQztOwlhwo2CDmwVa6WUyoaxHLIS6wOCWnZ+xhDGWtzyGWTLOiHy+xKXCP8RKshAJmgXoizMMhgJITb1MrmoZijJaiAm0ZKre8ZCmQjTGML+459sZp2aX8Uw5UEI9+KFnGpo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328961; c=relaxed/simple;
	bh=xaDH7r5wz2FNtVm+Zdzxosg+2AztLAsp1nywotLDtEg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=QosiDpq3MtduT/qPGnhiCePV/Um7UbuVkAJBNWsF/rVW7GzJlbpBdoMb4KPOnOLPG4J1oga6p2QWAxhea3Yk8I0wHUHp3ZadSnJE0G6eBk+r0aGa7+ove87kX0qu1wX7qp6V5LN838j3KaI6tFvCyTifuGF7fYFj89DLZUPCcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nI9c5SIu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nI9c5SIu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KIaR2B709576;
	Thu, 21 May 2026 02:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zVBuga
	HWtQ53g0hZ5T3aHloUw5myu0rBlE6vJ3zS8+o=; b=nI9c5SIufK0PbaqMLTQLTu
	ZYRJCU4pWnT3gcIkQcQzdNv1lOOWfnCuBLqTP17wKtnUVH1JbbHWmNBJzIDePzF0
	U7gwte/s2YS/W2YkWQkNjhFgs0+RjzzO40Kgc7zBmVmbpI7RI5N6xcUb8vcL7ejl
	hCGIVK7MCN+JrZwDFGpdke9edbSJrLLpmkD+8pjO99yC5MGvhd2NVI712AVV6wKC
	8xlhblB3Yck6El6AtzVxbd+COF06C7MVF9P2/jPTxv0PSEiRJNdJpHh9c2uqqVkf
	ezmEqnGiQONF/lLe3SFMK8meM0ULT3ucIuGJwmuXY0i89S3buaKrOeqX/wRffo/g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h754r52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:02:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L1sLCf025392;
	Thu, 21 May 2026 02:02:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wka1bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:02:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L228sF30343848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 02:02:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 993CE58059;
	Thu, 21 May 2026 02:02:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EBBA58057;
	Thu, 21 May 2026 02:02:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.83])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 02:02:07 +0000 (GMT)
Message-ID: <c5d8efb1832ed140e38a3b449dab17ed2f1465d4.camel@linux.ibm.com>
Subject: Re: [PATCH v5 00/13] ima: Introduce staging mechanism
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:02:07 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0e67a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=i0EeH86SAAAA:8
 a=fv3Zbqo8pTZ8U2gEJioA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1Z3me4yVwJakz14vsPn95WkFPA9Qz1jb
X-Proofpoint-GUID: --aJXFcmkz5FWRGVsU-HIhotGWfMVQt4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAwOCBTYWx0ZWRfX55rdM0qKWIh8
 +vVZrs7sDnTzogB1Q3AxnlgclZyBJFQhYj9KsE+7SmHfOJMwIrLaQfj8+IpKb0wCpY1/kBuZ66u
 IRwf6U9DixotAUAksJMpjeGnT6E5Ydig4ApEjfSGPIKhH7ZnBTjvc4bHqvlmzCqXG0HGwra55cd
 pGek9LxIQU+DVPHK0ry67ZwPkHwNLXnxx4scbASZ0dZ4O9pOzRFxfH8pxl4gNmZj3WcGWdNcVXL
 9DVobiI3khrV/BeaH9a8ErAFn8Qd7OiIut/vnPvl/NwNUmDPjrUgywoLMDz0dG7oC+1J7Jd04GJ
 HgBvHWx3z4QMF8//vaeGDWAkmgmqHQSVAk4WvtUIHmWeg2KrY1KZ6i2WBz8zb6jybtx/sU/8G5x
 GvVxT7c3YX+4mDgeaFbXj6aEv+C2QZZXf+5LeD9Q/sTb3sY01MyBK0HHK0KR/KiMjaAcGK2SZ5X
 Xu0jImNl+mD//YyNyWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210008

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The IMA measurements list is currently stored in the kernel memory.
> Memory occupation grows linearly with the number of entries, and can
> become a problem especially in environments with reduced resources.
>=20
> While there is an advantage in keeping the IMA measurements list in
> kernel memory, so that it is always available for reading from the
> securityfs interfaces, storing it elsewhere would make it possible to
> free precious memory for other kernel components.

-> for other kernel usage.


Prefix the following paragraph with:
The IMA measurement list needs to be retained and safely stored for new
attestation servers to validate the entire measurement list.  Assuming the =
IMA
measurement list is properly saved, storing ...

> Storing the IMA measurements list outside the kernel does not introduce
> security issues, since its integrity is anyway protected by the TPM.
>=20
> Hence, the new IMA staging mechanism is introduced to allow user space
> to remove the desired portion of the measurements list from the kernel.

"desired portion" could be misconstrued as any subset of the measurement li=
st.

-> to remove the entire or a portion of the measurement list ...

>=20
> Usage
> =3D=3D=3D=3D=3D

> The IMA staging mechanism can be enabled from the kernel configuration
> with the CONFIG_IMA_STAGING option.

Continue with:
This option prevents inadvertently removing the IMA measurement list on sys=
tems
which do not properly save it.

>=20
> If it is enabled, IMA duplicates the current measurements interfaces

-> duplicates the current securityfs measurement list interfaces

> (both binary and ASCII), by adding the _staged file suffix. Both the
> original and the staging interfaces gain the write permission for the
> root user and group, but require the process to have CAP_SYS_ADMIN set.
>=20
> The staging mechanism supports two flavors.
>=20
> Staging with prompt
> ~~~~~~~~~~~~~~~~~~~
>=20
> The current measurements list is moved to a temporary staging area, and
> staged measurements are deleted upon confirmation.

-> The current measurement list is moved to a temporary staging area, allow=
ing
it to be saved to external storage, before being deleted upon confirmation.
>=20
> This staging process is achieved with the following steps.
>=20
>   1.  echo A > <original interface>: the user requests IMA to stage the
>       entire measurements list;
>   2.  cat <_staged interface>: the user reads the staged measurements;
>   3.  echo D > <_staged interface>: the user requests IMA to delete
>       staged measurements.
>=20
> Staging and deleting
> ~~~~~~~~~~~~~~~~~~~~
>=20
> N measurements are staged to a temporary staging area, and immediately
> deleted without further confirmation.
>=20
> This staging process is achieved with the following steps.
>=20
>   1.  cat <original interface>: the user reads the current measurements
>       list and determines what the value N for staging should be;
>   2.  echo N > <original interface>: the user requests IMA to delete N
>       measurements from the current measurements list.
>=20
>=20
> Management of Staged Measurements
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Since with the staging mechanism measurement entries are removed from
> the kernel, the user needs to save the staged ones in a storage and
> concatenate them together, so that it can present them to remote
> attestation agents as if staging was never done.

"the user needs to save the staged ones" -> the staged measurements need to=
 be
saved ....

Please mention this could be a system service.

thanks,

Mimi

