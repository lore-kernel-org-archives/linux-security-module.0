Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468232;
	b=e3AiZnk+KlpyHPC6XRevVndwOq0zvAJbWyfwq2u+lSJXO9LD3yAX5mVcSN6ajMF266uv
	 453nFVfcyG2RZMWoJNUzH7AKSa+2mquQJyodU+lawJ5E7LMfnOliq4slsRd5IET1sfQOp
	 bPvRhczuFTjm53bN69jZoA2rSHwONCO0+9MZy/J/PYJ2GVKBdOwMUGRvpjG++Au6aQOt0
	 xQ/1RYbWXrI1gxZ+p+VLsz5PdE8w1X6IGmvm28+j8gSh6s8fDTKt65JNpUzGOUzoRZeme
	 YkxNFcBWp8PRx7v9seEJXQ3Kz5oyBVe5x85DHpVQaTXDUJ6LcU4EF8ix7dasi17MrMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468232;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RYqHloZOoqYHrt+p089L6+UfWTI0BWuSW7P7NblgWDA=;
	b=nBNVPKgtS2jqeFy1bVKNXimzIiMejFNeAP9TGmcbIUSwBjQS7ezdQkwfHVuwnaqK8URU
	 vx/wRHrkIdCJRvzkezG2JMelGjv2ZpMnDnRCl2fWnMnfQ5+wS3FqLJSG8sE2MbX7KJkLT
	 BmRZFeNrodxx2XLXynjIoMXXIN9tqlPCTd2SoxpmZhyiv+OXtFBZ/fO/HBjaDF57m6xtM
	 +QzjjYs+tah3kEkelXxLUb4MW/bUPsNtC2QGuAhcYGwdVk7Xim5NQw5L9EY/S7JRM41hA
	 t4Byeu4Net+raXufCWaxMu6U26xKtIE8/hN5s9gsE3lyr4cv+BGLnLIgZwXGABFlIHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K9oR1neg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A5606A31E;
	Mon, 23 Nov 2026 21:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E91A5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K9oR1neg
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANK4sBv344853;
	Mon, 23 Nov 2026 21:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RYqHlo
	ZOoqYHrt+p089L6+UfWTI0BWuSW7P7NblgWDA=; b=K9oR1negl3KVb7HP4HctCV
	LITCIsXecuraOiHj6aAZR+TMnqA0W2YGdBWFe8Rfde+GbS9kxaGWX6vnsmprzY4/
	XyUg6YoG285apTRGH//Gbgu1gABGx8jbMxzjlZnlCJf9cF86QdWQ9GbhjS+3zxpY
	x+nopHcOUe7/udEKRcDyduHaJjGuEboMIshIh3ihSYiMyJMmw3ec6kfXPMVljFnB
	ZRb8/ImSA61oiC3HA7OEVvybg9f+mcjNSkYEwaD2Dw9PJv6eXAomqtgtZLoH/aFk
	mYMo9ENbclYn/7s0jLDzs7ydoVPaUcUXGB63tzECKpqsyBQ/TZxkKkyZPQPlC/Yg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv4qx7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 21:10:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANK4Ejc2413837;
	Mon, 23 Nov 2026 21:10:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3rayfy6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 21:10:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANLA2c514287370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 21:10:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8C9E5805D;
	Mon, 23 Nov 2026 21:10:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2303658055;
	Mon, 23 Nov 2026 21:10:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.1.98])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 21:10:02 +0000 (GMT)
Message-ID: <d97e7b9c48b38c59023b8a8b18779b5c3318af2f.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix out-of-bounds read in ima_read_policy()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, fabrice.derepas@canonical.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20261112143029.4159022-1-roberto.sassu@huaweicloud.com>
References: <2e59cc97ad2e6fe5b9b5a5b5988668da29155703.camel@huaweicloud.com>
	 <20261112143029.4159022-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 15:33:11 -0500
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b04abac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=DfNHnWVPAAAA:8 a=i0EeH86SAAAA:8 a=LuCgsL7vg7nrgWYQqVIA:9 a=QEXdDO2ut3YA:10
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4NCBTYWx0ZWRfX8W22NsrcSgqU
 7bAo9a8DAIfIuWEn7H+6LXbVApaxVgZ2alC7QQNEAumyug/5OTicCfr0rQ3iIlvqfxqtlqN13Xz
 s0VnYNCVAz1OdgdKDUQkGUV/iUesjhQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4NCBTYWx0ZWRfX782F53epakLb
 jL5EK5qg3kXYquCM6evrpKkuNyAsuNzGQ8rLIVyyrPJChn/NJTmxqimN3akWms8fbnlok/fcjG/
 EavGp4aR04Ynky//vnhD6otJyXn+zhKif7izxfK5OhkcmzPG3juk4VUNQGx4knYdfKzcOUczBxp
 FDG7rYB/HrTlLhhjxovzJknvXFdL7SYrOlVkpNmMr2NdGnJ4wV260X8OU/Jnvgp3+Z/YwIZFKNk
 pddlFF6b+ABNT3DBiqz+xdfOImtSESZm/cFoot34xfXw/tN7yGIp27A+XOzOQdSDs/78jiasXFJ
 mapi5ikDvI2nIj1fJJ+OQ4eGoEeuKZkBPgAH4W7hdkVrYr6Cupu9S191ZXKBdXFsDn6vEsoinL6
 XfYcB6D0KnlxIHft6A8tFhyofkiQe/PeBlQuu1FZHDk6SEHll56URNo76MELD1TR9VYv5voVyli
 O43BbiKavj9ZKoSLihQ==
X-Proofpoint-ORIG-GUID: dSvMPstp7ygo1fQFFX0sbQIUO_m-5eVc
X-Proofpoint-GUID: mbe4kp3MqS-e1RO02-6p3H6D-_l-D318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230084

On Thu, 2026-11-12 at 15:30 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> ima_read_policy() reads the policy file with kernel_read_file_from_path()
> and splits it into rules with strsep(). However, the buffer allocated by
> kernel_read_file_from_path() is exactly the size of the file and is not
> NUL-terminated. If the policy file does not end with a newline, strsep()
> scans past the end of the buffer while looking for the next separator. If
> the file size is a multiple of PAGE_SIZE, the scan reaches the vmalloc
> guard page and the kernel oopses.
>=20
> If the last byte of the policy is not a newline, parse a NUL-terminated
> copy of the buffer obtained with kmemdup_nul() instead, and account for
> the NUL terminator in the remaining size, since ima_parse_add_rule()
> counts it in the length of the last rule.
>=20
> As a side effect, a policy whose last rule is not followed by a newline
> is now loaded, instead of being rejected with -EINVAL due to the
> terminator being counted in the length of the last rule but not in the
> file size.
>=20
> Fixes: 7429b092811f ("ima: load policy using path")
> Reported-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> Closes: https://lore.kernel.org/linux-integrity/20260814085443.1211989-1-=
fabrice.derepas@canonical.com/
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_fs.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 2a0bca554316..6d5e061f88c2 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -528,7 +528,7 @@ static const struct file_operations ima_ascii_measure=
ments_staged_ops =3D {
>  static ssize_t ima_read_policy(char *path)
>  {
>  	void *data =3D NULL;
> -	char *datap;
> +	char *datap, *buf =3D NULL;
>  	size_t size;
>  	int rc, pathlen =3D strlen(path);
> =20
> @@ -548,6 +548,23 @@ static ssize_t ima_read_policy(char *path)
>  	rc =3D 0;
> =20
>  	datap =3D data;
> +
> +	/*
> +	 * kernel_read_file_from_path() does not NUL-terminate the buffer.
> +	 * If the policy does not end with a newline, parse a NUL-terminated
> +	 * copy, so that strsep() does not scan past the end of the buffer.
> +	 */
> +	if (size && datap[size - 1] !=3D '\n') {

Hi Roberto,=20

Why allocate a copy rather than reject the file when the last byte is neith=
er
'\n' nor '\0'?

if (size && datap[size - 1] !=3D '\n' && datap[size - 1] !=3D '\0') {
	vfree(data);
	return -EINVAL;
}

That avoids the out-of-bounds read with no allocation, and it keeps the cur=
rent
behavior, since a policy with an unterminated last rule is already rejected=
 with
-EINVAL. Is accepting a policy with no trailing newline an intended change,=
 or
just a side effect of the fix?

Thanks,

Mimi

> +		buf =3D kmemdup_nul(data, size, GFP_KERNEL);
> +		if (!buf) {
> +			vfree(data);
> +			return -ENOMEM;
> +		}
> +		datap =3D buf;
> +		/* Count the NUL terminator, included in ima_parse_add_rule(). */
> +		size++;
> +	}
> +
>  	while (size > 0 && (p =3D strsep(&datap, "\n"))) {
>  		pr_debug("rule: %s\n", p);
>  		rc =3D ima_parse_add_rule(p);
> @@ -557,6 +574,7 @@ static ssize_t ima_read_policy(char *path)
>  	}
> =20
>  	vfree(data);
> +	kfree(buf);
>  	if (rc < 0)
>  		return rc;
>  	else if (size)
