Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF133C1D6E;
	Fri, 16 Oct 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180449; cv=none; b=bLUhcDpbrQYqvp+cz5ytqsZJM3x0bvx20oUG93NKauI+JfC+h2HnCOj6A8kokhKb5NXTP78nEYPi/b09hlUFRXhDj+OCEeNENOzs+m37x3P4tJ1Kivu2RvjmRwfwjzRurJpT+itWuRP1SS4NFIW73CsviB3nr9HbRSP3C7E2t10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180449; c=relaxed/simple;
	bh=CbB7gk7woWckBGJxjC/itGv5QbaRbne6C33zMxrW59o=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=NQ1nrS0RsMbHFGodMtqOG6ONobF6H9w8cxjsZI5GITEJzVArw1P9fOAeDG9wtzFhQrP6vqX0J9+/vpTIokxraKDzCQWGF6zZX///ezKv5C1PAdA576bN3lbCDeM1fbvtCiC3xxFDeAAw+nZ9xddMw57FJ9pBzq5C2qi7PsVCUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M1k1aDO8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M1k1aDO8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GJiMfa620810;
	Fri, 16 Oct 2026 19:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RFBShW
	KoniR0gJjL5m62pm4yyuITX5L4tvbyqJwkNsI=; b=M1k1aDO8Cv2L7zX2Qdye0G
	x8Sx1P1MDVl87YZflXltfBkb2thqbTmL+HA4B751OVZWNWHBOYShF1d6Rv1jQN/k
	Yrffjf2nk6OiEJ9zxn09BHqLoX9T6Yj25htMhHNyOOs+KPPl6H6ut60DWt4WVz8s
	V9MZMzeQWy28ZO8nPuX5fjNcuRHY9H12m7oyjEVtwbcWRKtJoQXTxoo3ZVcsispk
	o/lYAe0Nb6J1SuIWQq+MeTmMO8BfILLAMPeqBB5cFLY7EqT1QH5UpIuF8THf+Kf/
	8OCQ9M1mz8wOUak0wu9XmaHrCLiGkx+xUwTOYGGdpsbAK0Z7m38BiYwmAd5nNXQw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7duh19ew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 19:53:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69GJo1Nx4137896;
	Fri, 16 Oct 2026 19:53:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hb34mn1ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 19:53:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69GJrD4N13042210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 19:53:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFD0D58056;
	Fri, 16 Oct 2026 19:53:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66CD358052;
	Fri, 16 Oct 2026 19:53:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.29.48])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 19:53:13 +0000 (GMT)
Message-ID: <3d3fc94b377125df87c02b6a73ef664b35fa37c1.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: reject modsig if detached data cannot be supplied
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?J=E9r=E9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0aed6bb22776b2bf9e9e11edd18dd559f71e5186.camel@linux.ibm.com>
References: <20260822082434.489470-2-Jeremy.Jean@oss.cyber.gouv.fr>
	 <0aed6bb22776b2bf9e9e11edd18dd559f71e5186.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 15:53:13 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ad280ac cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=QIHSJJ-3zAWbNeOQCx0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xXoM4z8W5eH9G0W5Do3OE8AvzScVC5G8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3OCBTYWx0ZWRfXyAUTBCwsRoCz
 K5KZ0c8mc8so9YEHhTQhflF/DjpRDFI2KZHewkTLGhbPLKjjQSjgdVI2nGUiCcjtvoN7L7xtpoi
 nmdH5bsQcg2BYUeN6lp4t8OlEc6zDZlWKVI4D8yOO7+bKaLN1Zn8mhHPIHsFLX520r3SwCXEHWe
 i0dPC/W2xd3g13sDkkzW++7Pe6EQqIlQPkPvKeoVN2dcbCGVjb+5k9bfGgDdVHgyzrnNpUHk/nl
 ZSnoB/f5WIwHiWzFT88bOVyLLtMb+DxuQWOLWSbM4qWBpMzOYuyvkytfm3Dvhs2jn0+8kAfAlBR
 FJ1e6bT54JTC+MppY7X17kNQnTq1xlLjr7UxSB8KVL5crjqxIeTMY+VKnYs8cu/PJyhHtjfLI6D
 8cDflznYBxNktpdAh4+/gKVF/xT2ZoODdXa0Q0ZH2h+CZ6Y8HrQTHgHKbcCfHfKp1TcuV4ioVJ6
 VbOMKhIVMh+7kHN321A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3OCBTYWx0ZWRfX7NI+mJgR/h9G
 C/cf0NT51L1HnwY9mE1TXXm29lXA5zY3b2CORXJeLtIgDAo4e1YOwLm4kNfAcpMxf3Q2C9GdWLC
 +V71qXLSAFkCHl+xZ+NXdW0Ga5dJjHQ=
X-Proofpoint-ORIG-GUID: qBbL1uEwXR67GjR4B0gC-Kkig0cIT0bK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160078

On Mon, 2026-08-24 at 12:00 -0400, Mimi Zohar wrote:
> On Sat, 2026-08-22 at 08:24 +0000, J=C3=A9r=C3=A9my Jean wrote:
> > ima_collect_modsig() binds the file being appraised to the parsed PKCS#=
7
> > message with pkcs7_supply_detached_data().  If the message already cont=
ains
> > embedded data, the helper returns -EINVAL.  However, ima_collect_modsig=
()
> > silently returns because its return type is void.
> >=20
> > ima_modsig_verify() subsequently calls verify_pkcs7_message_sig() with =
a
> > NULL data pointer.  That verifies the embedded PKCS#7 data instead of t=
he
> > file being appraised.  An attacker can therefore take a valid
> > detached signature, insert the original signed bytes as embedded conten=
t
> > without the private key, and append the resulting message to an unrelat=
ed
> > file.  IMA accepts the unrelated file.
> >=20
> > This bypasses the module authenticity boundary when an IMA modsig appra=
isal
> > rule is enforced while CONFIG_MODULE_SIG is disabled.
> >=20
> > Return detached-data binding errors and stop measurement collection whe=
n
> > binding fails.  Keep digest extraction optional because algorithms such=
 as
> > ML-DSA can verify the message directly.  Appraisal then rejects the fil=
e
> > rather than reaching verification with embedded content active.
> >=20
> > Fixes: 15588227e086 ("ima: Collect modsig")
> > Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> > Assisted-by: Codex:gpt-5
> > ---

[...]
=20
> >  static inline int ima_get_modsig_digest(const struct modsig *modsig,
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/=
ima_api.c
> > index 122d127e108d..e2b167f24778 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -262,8 +262,11 @@ int ima_collect_measurement(struct ima_iint_cache =
*iint, struct file *file,
> >  	 * the file digest without collecting the modsig in a previous
> >  	 * measurement rule.
> >  	 */
> > -	if (modsig)
> > -		ima_collect_modsig(modsig, buf, size);
> > +	if (modsig) {
> > +		result =3D ima_collect_modsig(modsig, buf, size);
> > +		if (result)
> > +			goto out;
> > +=09
>=20
> The normal processing of getting the xattr needs to continue even if the
> appended signatures doesn't exist.  Exiting here is too early. Consider s=
aving
> the result as a different variable and returning an error later, if neede=
d.

By going to "out", the file will not be properly measured, nor would the fi=
le be
appraised based on security.ima xattr.  A better solution would be to free
modsig and continue as if there wasn't an appended signature.

thanks,

Mimi
