Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85BA3176EE;
	Wed,  2 Sep 2026 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310509; cv=none; b=PYDnXrugmMMgOs7DQwXauGoXmHMj+I2I095qUdiapYLUvvcfBeif5DdNgFqV+wtTpJouKo3d0SCn7EHmnjcvvkfoPcf6aY9OgCVBNzxAf4xCAT6yd+6+ERk7+M2MYcO4PKg88gdf6wOpTH8g1B4aOy7x5jqyj+/lqyZUtP25sHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310509; c=relaxed/simple;
	bh=rQQWXROtXEPolbL3+WmQ76ec5bRrNQnToMx7O28pmXE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PFES8+czhYu/bPYecAH3YwoA20HSoPkhe/7ZkvOl8lWajVGB53yt/OArz/a/AT7EpfLuQ6PHbqqhWccA1BTnVIvcfIbG21rC8scGVfDIVVZYyTTwKsKHasdidnusYIb0h1S/8R+EQNTofzcHcCukh3GsI087qBXpyhwsYJS6YPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S+VOXujc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S+VOXujc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWWT9354836;
	Wed, 2 Sep 2026 00:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BCSQKB
	VO5LU27JLC1hpqQFvXR9CV1TehM4jZhukoXTA=; b=S+VOXujcw9DjXIc9CAiBPf
	IfF0KfmbS6ZheS5sfxd/prbi6ggjZb2Jwet/pRd/BGAV0MnDY/77OdKw1d0km2HQ
	c8PFbso4YYgkAWDxctyzNsKU4wQenjo/HV5RhEMQbaOxm9qc79+6cLy4jENZ8yop
	wDpEr/NlGojpIxWlEyzEWUFqZzkYNKA2YjKS2w67lbsYgbIKg8qXKik7p7lsihup
	zeN1FTBv/+T+xT2ZvSdu13KZJKvBKcIAyRDIADbist7Mgacw9T+QIRZ34DGlIYI+
	VpazB2rLROhHvdnMn3nHzPxUOUX4wonIxzrOHc09RXMZAOBnsjgMT/moGVezvcvw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rbdmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 00:54:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6820QKSK026824;
	Wed, 2 Sep 2026 00:54:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4w6yhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 00:54:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6820sloR13042200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 00:54:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F4C958050;
	Wed,  2 Sep 2026 00:54:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3974658045;
	Wed,  2 Sep 2026 00:54:46 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.87.106])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 00:54:46 +0000 (GMT)
Message-ID: <35ae5c9fd60874127d15f5fedb84c0a90e56eca4.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: allow users to specify the pcr index with
 IMA_MEASURE_PCR_IDX
From: Mimi Zohar <zohar@linux.ibm.com>
To: Julian Braha <julianbraha@gmail.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260824162215.1572367-1-julianbraha@gmail.com>
References: <20260824162215.1572367-1-julianbraha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 20:54:45 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9773d9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=cuzdW0VFpDOfPp0CwCYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAwMyBTYWx0ZWRfX6bhuzGfolJq0
 /RB2Syow7w1TDWIorthN3CY73kKLPhQ59eNxVDx3WpMVk+eh+yfIauhnBA60W7gvbyAp4gmjp3i
 BlrDLvlz6KhvEnC1o2hv/5FGwNqh0jg6ynqH7f/+JTV4FB+BpLFiRhTosYB7xivjclug8FsdWdD
 W/YyWAAIclPUcaFHjVQEIe8hCi8Z38rRsY7GJtqFIwVxaJk43vC8tjaf3+XPMrA11EOUEB9pwGF
 xI1hY+E9Ka2PvwMNH+k/nLpis131PSpamDE9MZakqMnVMM3nzukbJd1xslWPDKcXJrLoWjXqoDv
 rXm3zZxDPKf8orwBILw/Q7WWhGXmCnqcJF1ChCizQKGXzB7l6fdmmLX9NRbkErssjf3GuMV/7D8
 zFqdzPIZkf2JpC+DZawffbtcY37aDcLI8ESWG4nfUQxh/3cz7l70XT0FDX7GLG73Pa+TAFZnoN7
 hyAfOR9iuvg6V+bMGTA==
X-Proofpoint-GUID: sny8BGHa00BGvO7ry_uvDL7XDYIGxeaR
X-Proofpoint-ORIG-GUID: btMsHG92T1r6fmUTgAshUvsd9mkuXLeg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAwMyBTYWx0ZWRfX1F4uml2URZOk
 49a+Nq5KxupP07u8QYD0iyjelfJjjBuPNAn0yMvdtJpxQPpYkL2c8FxbmleUj1t2+iG+Ppe58pt
 zoXeOGFFH20uqPJRPbETwWJ3ZM6mqLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020003

On Mon, 2026-08-24 at 17:22 +0100, Julian Braha wrote:
> The IMA_MEASURE_PCR_IDX option is currently not visible in the kconfig
> frontend, so it always uses its default, 10. This means that the
> 'range 8 14' is dead code, and users are unable to specify the pcr index
> value.
>=20
> In a previous discussion, Mimi explained that users should be able to use
> this config option to specify the pcr index. [1]
>=20
> Let's add a prompt for users to specify the pcr index, when EXPERT is
> enabled.
>=20
> This dead range was found by kconfirm, a static analysis tool for Kconfig=
.
>=20
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> Link: https://lore.kernel.org/all/1feff118-4afa-4b9c-86f1-271a7a88208f@gm=
ail.com/T/#mc4efa2491b4937eb7c9e532c29ffba516a70e662 [1]
> ---
>  security/integrity/ima/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index b3a9f86809b0..2d5bb19ea6ac 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -46,6 +46,7 @@ config IMA_KEXEC
> =20
>  config IMA_MEASURE_PCR_IDX
>  	int
> +	prompt "PCR Index for Aggregate" if EXPERT
>  	range 8 14
>  	default 10
>  	help

Thanks, Julian.  The existing Help says, "If unsure, use the default 10."  =
Could
we make this recommendation stronger?  AI suggested:

	  IMA_MEASURE_PCR_IDX determines the TPM PCR register index
	  that IMA uses to maintain the integrity aggregate of the
	  measurement list. Most attestation tooling expects PCR 10.

	  The default is almost always what you want. Only change
	  this if you know what you are doing.

Thanks,

Mimi
