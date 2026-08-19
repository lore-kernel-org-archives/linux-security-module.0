Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD623CF21F;
	Wed, 19 Aug 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164803; cv=none; b=P4ESx98xH5dOvlwJjMC7j4So5KPKTJhAaGsx2kvuP+ryZuQig2+ODci5Pb8qhoCg3k9B7M3Lk1wpTVkkToZ+tfre0UIlCDt3ilkMNC6BZVAuRnCOlLpxv+XM/IpJgPyBRSbTIx0AmUlfNsxTKTxwkk7kjZppVNR5cPM//Ex17+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164803; c=relaxed/simple;
	bh=W27rzD0KmMZ2StOX4G9wyq2nVJe+N5LCbvKi6Atg9X0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=cvcTXFFklhVRnNuidE+mTqn23JeMTRhTlEk7q9eAX8ERqFNASIVkwUK9JRtY/+m3I3XU7n2pWnwbsWkma4D9nVfjONh2A2sRRCDP5niF7uhEhLK0ZY3VeXgkffTJpwgXm6/1/7QMJxJT6dx561eLphNQ8s8AHZ8m+mc2uYsE6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dnvkgKTz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dnvkgKTz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JI1bfI048113;
	Wed, 19 Aug 2026 18:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q8jJrN
	bHKZEadHmwdc4ji9R6KLlhm/F2XVe8xdes3mo=; b=dnvkgKTz9hitYK+dBhGIaj
	HNlyBGo5GKsf+RIRdkDxuSzqghqQSxf0FK445LdQhpQLIZ1XKbtBEXhkqBb/LONf
	gwuiNYHetf5d3X76vMmVP8uvVv/V3IFH2KnK9BEJMWJmDoDYZWUysTJx0iYOsqis
	bIppr/dPKJXsZobHLiRKP/d+qLNcaWHSgznLiE3mj7hMx2wJE3z+kSPB35J9KJIV
	gMFPdkWS4FcgK/2VW2IJV2it171iDhxRudkxveyK6qCAAvQnR8yRlWKC88oxZgCy
	7ktjeDcV3S+jBIUFlKHDMgzaSN3xMddXSfMF5TNVHraq35NaSs4fsFUxtvhwBwMA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu45f4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 18:39:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JIQHkw019219;
	Wed, 19 Aug 2026 18:39:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yj4e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 18:39:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JIdUcN35848684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 18:39:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AB8C58057;
	Wed, 19 Aug 2026 18:39:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 981AB58059;
	Wed, 19 Aug 2026 18:39:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.87.198])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 18:39:29 +0000 (GMT)
Message-ID: <314a73301c4120744d35a20d4e3676b394c35ec3.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima: don't measure/appraise files on configfs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>,
        Andreas Hindborg	
 <a.hindborg@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@cloudflare.com,
        syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
In-Reply-To: <20260818-configfs-v1-2-a2329043cf86@cloudflare.com>
References: <20260818-configfs-v1-0-a2329043cf86@cloudflare.com>
	 <20260818-configfs-v1-2-a2329043cf86@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 14:39:28 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a85f864 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=c92rfblmAAAA:8 a=hSkVLCK3AAAA:8 a=VnNF1IyMAAAA:8
 a=EG7W4yiQAAAA:8 a=7oyq7UN4rplG_8erHfoA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: rkSHv0LO2rMBO1ua8CNGr_oF8cZSjW9r
X-Proofpoint-GUID: AEOjanGe7qKVoccRuXXK98facwaok65O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE0MyBTYWx0ZWRfX10ERyceWpoec
 gkLaVUxgWeIEADLW+BBuGlDKHMRjEGejqrmfECZ982mwXGGpWEkoufL6tD+tZA+uwxeIkpRT38z
 Xo3KK7ZL63Kgn/UoRsVUNunugdwhWDU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE0MyBTYWx0ZWRfXzDg4ACWq2+2A
 7v3zpDKgg1BkwVrNQFwaHek3jzrLJceyse3O3GaheBR2ESWn7gtc9Uy7KabEIvo7n7hcJ4S6i/H
 03SaGCz2dx/SWsJH6ssOzg068wedKCQwTOR67B2opasB0ojWx8ymOtJDpoFINyOf4Szrkp+hJvK
 U6HBCWLNCRCa9TAjKL0rdVRNQzY6PyMvkJjHjrUfI+c03wtFFR1qM7AePu7mwPli8SOLz+j3OtJ
 4WL9Nq76gMg2pT9yBrsGxXBF8obeOYZYkMFgMeeA3Idrgh0oVrxlu1zhYcgsbcUabpSbK3BJC23
 1BZcClHy0LwfEC05Jvr5VjZwFXZK96dGyMbPD5rm5rJ3L+fAELQFfTkc9XARRlZCdPZ3CrcIrn2
 uc/OH4Y9Q/w255IkFdRjw1J/UijxagNvOM+k4Q8J4N0urS3u8Uzl3YIkDv2RL/+qZfQIslLh4yj
 dYLJTit0Ql0MciLHd1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190143

On Tue, 2026-08-18 at 14:35 -0500, Frederick Lawler wrote:
> When IMA appraises/measures a file configfs, it has an opportunity to
> hold onto the ima_iint_mutex while another file from a different file
> system is attempting to appraise/measure. This may cause a cyclical
> lock dependency.

The locking description is off a bit.

Suggested patch desciption from AI:

IMA measurement of a configfs file causes process_measurement() to hold iin=
t-
>mutex while performing a kernel_read() to hash it, which re-enters configf=
s's
own file locking (buffer->mutex, frag_sem).

Separately, opening any file with O_TRUNC now causes ima_file_truncate() to=
 take
iint->mutex to reset the cached action flags, while sb_writers is already h=
eld
for that mount.

When a configfs-backed nvmet namespace is involved, these two independent l=
ock
chains combine into a cycle:

iint->mutex -> configfs locks -> subsys->lock -> sb_writers -> iint->mutex

Add configfs to the builtin don't measure/appraise rules, similarly to othe=
r
pseudo file systems, so IMA never takes iint->mutex for configfs file in th=
e
first place.

>=20
> Add configfs to the default don't measure/appraise lists, similarly to
> other pseudo file systems.
>=20
> Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/6a77c7cd.b50370da.49fe0.0031.GAE@google=
.com/
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

Sashiko is now enabled for the linux-integrity mailing list -
https://sashiko.dev/#/?list=3Dorg.kernel.vger.linux-integrity.   Please add=
ress
Sashiko's 2/2 review.

thanks,

Mimi

> ---
>  security/integrity/ima/ima_policy.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index f79d07bb63c6fc4ba6fe594140de8d59f57e4f0b..68d9a5e6c232ea0678e9f51f1=
05cebecccccb43e 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -165,7 +165,10 @@ static struct ima_rule_entry dont_measure_rules[] __=
ro_after_init =3D {
>  	{.action =3D DONT_MEASURE, .fsmagic =3D CGROUP2_SUPER_MAGIC,
>  	 .flags =3D IMA_FSMAGIC},
>  	{.action =3D DONT_MEASURE, .fsmagic =3D NSFS_MAGIC, .flags =3D IMA_FSMA=
GIC},
> -	{.action =3D DONT_MEASURE, .fsmagic =3D EFIVARFS_MAGIC, .flags =3D IMA_=
FSMAGIC}
> +	{.action =3D DONT_MEASURE, .fsmagic =3D EFIVARFS_MAGIC,
> +	 .flags =3D IMA_FSMAGIC},
> +	{.action =3D DONT_MEASURE, .fsmagic =3D CONFIGFS_MAGIC,
> +	 .flags =3D IMA_FSMAGIC}
>  };
> =20
>  static struct ima_rule_entry original_measurement_rules[] __ro_after_ini=
t =3D {
> @@ -211,6 +214,8 @@ static struct ima_rule_entry default_appraise_rules[]=
 __ro_after_init =3D {
>  	{.action =3D DONT_APPRAISE, .fsmagic =3D EFIVARFS_MAGIC, .flags =3D IMA=
_FSMAGIC},
>  	{.action =3D DONT_APPRAISE, .fsmagic =3D CGROUP_SUPER_MAGIC, .flags =3D=
 IMA_FSMAGIC},
>  	{.action =3D DONT_APPRAISE, .fsmagic =3D CGROUP2_SUPER_MAGIC, .flags =
=3D IMA_FSMAGIC},
> +	{.action =3D DONT_APPRAISE, .fsmagic =3D CONFIGFS_MAGIC,
> +	 .flags =3D IMA_FSMAGIC},
>  #ifdef CONFIG_IMA_WRITE_POLICY
>  	{.action =3D APPRAISE, .func =3D POLICY_CHECK,
>  	.flags =3D IMA_FUNC | IMA_DIGSIG_REQUIRED},
