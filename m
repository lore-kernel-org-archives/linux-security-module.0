Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9845D1BD;
	Mon, 24 Aug 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587272; cv=none; b=ceQx9qCWL/4+BWwpwPtucFqfmbEEvRYOaqcT5jK0FJsUt+HRvsZRQ8xPwxL8rqnqyTS8F7WchZt4g0bsD0ERvL3CtUEXPTZVPmVDKeiodUu8at3S+VS0MlE0dH8/xoF9S6hRqKIZ0YqTTAz3MiigySm6AyyyX7S9wzEBrwRDtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587272; c=relaxed/simple;
	bh=/Fy+jklDGXhVumqnTQdLFNGeOxoj8UCDmZr7ekxMMb8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Y2AGDxyLbVMa8yAOdLGQk4XqXxd4sZDce1998etKnunHRW/S6V7RS4Rq1W0uSjj115/G5YqUM4hy1SogTpIP0fwEBP9V7DnDn9GwoBDzC0OJuCSIoFOAyRSrMloAWxkHh46+NevQrharzXXuZAb2NQoNz+yDnBsNoEZtS+bRla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jiiFYlTG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jiiFYlTG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1WqY1935720;
	Mon, 24 Aug 2026 16:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DOR50t
	gX95jPgMPYAW5VH6EElKxgCToXNppLseRtADQ=; b=jiiFYlTGEBFkiEDxWYi566
	UdAlkvEKYbWtJN7xN/OowgHsWiby3pCLU/+M0eU0Eu2D2v6IelnIxCLQRJaziTEy
	8i4Xe5Y+NfEtx6UTSpZTm387XzD3DjD5PRCPrSj1HdWaaL9JY63kpb7NFDl4KRoa
	3YPUlh4DKlM7A4583eI+3ZHZ8dk3/ozspwrcsOJK8KiThM+hFEc426dSrPZ+T1YQ
	5EMvLM0c1o6+TlD3HWL7xfZZ8yHviQSeEGR1MZSpulPQVBL/VBHKuiyIaUHRWiCJ
	L9Whbh2uETE1T2jkEfqQulGFfv1rU5czq/0l40CrZPIv0rrwMGqpvlkcYuEiyJZQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393tgqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 16:00:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OFudFm031445;
	Mon, 24 Aug 2026 16:00:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag6say-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 16:00:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OG0JCe22348292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 16:00:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEB2458067;
	Mon, 24 Aug 2026 16:00:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E05B58055;
	Mon, 24 Aug 2026 16:00:19 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.99.227])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 16:00:19 +0000 (GMT)
Message-ID: <0aed6bb22776b2bf9e9e11edd18dd559f71e5186.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: reject modsig if detached data cannot be supplied
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?J=E9r=E9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260822082434.489470-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260822082434.489470-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:00:18 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1cZtj96qTT1sPpg87bGNdHe9zxtpGPZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzMSBTYWx0ZWRfXzT/3hY+fw4CQ
 RANeJqcWiRx6pWvnDE+xEFq0y4xTiIQONoW/5Bd1tI3lNG4frrbUGNlhH9AGiRmTzthYuYLV7Z0
 ynwiWNY83HrRuusn4FBRVWdkaUjaq4R96Fzv/wyJfQp1BQdbLh3215rfwQzq8HkdUm7Sk6D3lEy
 faEOm6xAJUn+DXhMNr52abywkMhwSAr1CJTpeYQXCkdPqgp0vindNd6epnN6vTSwZJ2va7ACUYa
 SEtNSSAvvq+hF32o+p+9HtMauesz7LC6VZD19yyJFqSWYPeZ3b+qRvCCy0JRQNcHNuseM7mrqPW
 wXILoNIXX4QNc0AyaWVY7283bTjhHoHc7AWT86/WIw/EW5Yr+sPuRCllflYRnOaCEGlzpZ1E0wW
 ZjDI7ezFg4k8mn5FIqu7ZTN0dtGtg56iFUMPHN3KNOMJbH1nrwT6JD6iaqy3nT2XcHqGz6hYnqx
 oghEtcoXM4L1+zUMb2Q==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c6a95 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=42dKGh1qNE93IMdUcxEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzMSBTYWx0ZWRfX4y/nbQXjwcmO
 RLQBLgWfUYQZZYxEIy9vD1f7YMqYXud6QgPyJpxExPUmElNfg/Xn65nBnst03MIbclB6vgQ0bvT
 j8LyhTWkVJ+P4G6GVVM4UT4XuedJke8=
X-Proofpoint-ORIG-GUID: 05mAN24rWDKiXFrmFBHWM66eYUxkA-so
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240131

On Sat, 2026-08-22 at 08:24 +0000, J=C3=A9r=C3=A9my Jean wrote:
> ima_collect_modsig() binds the file being appraised to the parsed PKCS#7
> message with pkcs7_supply_detached_data().  If the message already contai=
ns
> embedded data, the helper returns -EINVAL.  However, ima_collect_modsig()
> silently returns because its return type is void.
>=20
> ima_modsig_verify() subsequently calls verify_pkcs7_message_sig() with a
> NULL data pointer.  That verifies the embedded PKCS#7 data instead of the
> file being appraised.  An attacker can therefore take a valid
> detached signature, insert the original signed bytes as embedded content
> without the private key, and append the resulting message to an unrelated
> file.  IMA accepts the unrelated file.
>=20
> This bypasses the module authenticity boundary when an IMA modsig apprais=
al
> rule is enforced while CONFIG_MODULE_SIG is disabled.
>=20
> Return detached-data binding errors and stop measurement collection when
> binding fails.  Keep digest extraction optional because algorithms such a=
s
> ML-DSA can verify the message directly.  Appraisal then rejects the file
> rather than reaching verification with embedded content active.
>=20
> Fixes: 15588227e086 ("ima: Collect modsig")
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Assisted-by: Codex:gpt-5
> ---
>  security/integrity/ima/ima.h        |  7 ++++---
>  security/integrity/ima/ima_api.c    |  7 +++++--
>  security/integrity/ima/ima_modsig.c |  9 +++++++--
>  3 files changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 10214f73ca1e..ac1d593a42c1 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -559,7 +559,7 @@ static inline void __init init_ima_appraise_lsm(const=
 struct lsm_id *lsmid)
>  #ifdef CONFIG_IMA_APPRAISE_MODSIG
>  int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len=
,
>  		    struct modsig **modsig);
> -void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t s=
ize);
> +int ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t si=
ze);
>  int ima_get_modsig_digest(const struct modsig *modsig, enum hash_algo *a=
lgo,
>  			  const u8 **digest, u32 *digest_size);
>  int ima_get_raw_modsig(const struct modsig *modsig, const void **data,
> @@ -572,9 +572,10 @@ static inline int ima_read_modsig(enum ima_hooks fun=
c, const void *buf,
>  	return -EOPNOTSUPP;
>  }
> =20
> -static inline void ima_collect_modsig(struct modsig *modsig, const void =
*buf,
> -				      loff_t size)
> +static inline int ima_collect_modsig(struct modsig *modsig, const void *=
buf,
> +				     loff_t size)
>  {
> +	return -EOPNOTSUPP;
>  }
> =20
>  static inline int ima_get_modsig_digest(const struct modsig *modsig,
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index 122d127e108d..e2b167f24778 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -262,8 +262,11 @@ int ima_collect_measurement(struct ima_iint_cache *i=
int, struct file *file,
>  	 * the file digest without collecting the modsig in a previous
>  	 * measurement rule.
>  	 */
> -	if (modsig)
> -		ima_collect_modsig(modsig, buf, size);
> +	if (modsig) {
> +		result =3D ima_collect_modsig(modsig, buf, size);
> +		if (result)
> +			goto out;
> +=09

The normal processing of getting the xattr needs to continue even if the
appended signatures doesn't exist.  Exiting here is too early. Consider sav=
ing
the result as a different variable and returning an error later, if needed.

Mimi

> =20
>  	if (iint->flags & IMA_COLLECTED)
>  		goto out;
> diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima=
/ima_modsig.c
> index 632c746fd81e..57dc8dc43b55 100644
> --- a/security/integrity/ima/ima_modsig.c
> +++ b/security/integrity/ima/ima_modsig.c
> @@ -96,8 +96,10 @@ int ima_read_modsig(enum ima_hooks func, const void *b=
uf, loff_t buf_len,
>   * Since the modsig is part of the file contents, the hash used in its s=
ignature
>   * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
>   * calculates a separate one for signature verification.
> + *
> + * Return: 0 if the file data was supplied, error code otherwise.
>   */
> -void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t s=
ize)
> +int ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t si=
ze)
>  {
>  	int rc;
> =20
> @@ -109,11 +111,14 @@ void ima_collect_modsig(struct modsig *modsig, cons=
t void *buf, loff_t size)
>  		sizeof(struct module_signature);
>  	rc =3D pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
>  	if (rc)
> -		return;
> +		return rc;
> =20
>  	/* Ask the PKCS7 code to calculate the file hash. */
>  	rc =3D pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
>  			      &modsig->digest_size, &modsig->hash_algo);
> +
> +	/* Some signature algorithms operate on the message without a digest. *=
/
> +	return 0;
>  }
> =20
>  int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
