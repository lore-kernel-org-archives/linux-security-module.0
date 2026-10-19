Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422182;
	b=QidnZ6st5YXL6tcI5fih2UFAa8O0xEKY84fUQ7yMezhwL7g/RkqbBkKP3mHsIvDgvWgs
	 JikohdmFYSklj6Qrhb82whwdXfZU66UfhVMquSmBTazCxjFPEICTh6lipjVfbxbS3QGc3
	 NnFShXhJbnJbvWQThlzzkCkexEEkARTR6i0aRROG7zoLhF7YoOXxOtCTa4wA/X8WZmn7G
	 vIuNjf6T3SJ7u2QEHnq1w0SdCPVI6aCmyjxdO5dDcuWorfg5bOsYX0aq+sw7jQYOOalVv
	 PV4N2LqazEg3DnNw56h2kC9wqxX+kuKfOq6cGwHdLq9uTkxhbXIKm3s/JCIOAymCcpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422182;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Rq4MAL1fQzRXP47VmHrMlaeZyrntTtbpzmgafG5g2JU=;
	b=MBYxIAVQDidSJq9lrdOFk2NF9dUlxu4T+vBIgrQKSA6oYMphWB4oJ7He5zqDTiCBa1yp
	 Qps/0beMv4XL5fgAVno57t3k0u3SZouzEtjcWsIE7q4CeNeNGUTaSxcrgqkpbchNZ9OsU
	 L9I8SbOqbes1gKswwZQGn2vr3ZDUSh/+SFA9sfMRbd1d94O93/q/odb70Otk1SSqGUEqz
	 hIqZ7vyF6sJEgn67/ExfuvB/5xIvYhwxqvo8y1bQQUsfElCBvOtG9Dyhh2Q5q7giOVk/J
	 PiFNXYhmXZI9IUPCYGJ3+A/HCd8UWGIKlI4RB417SLQDYFYa/D3HFwqrD07sYJnLJ2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KMvz5Aug;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11526607BF3C;
	Mon, 19 Oct 2026 15:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11526607BF3C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KMvz5Aug
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JEEmAh4015228;
	Mon, 19 Oct 2026 15:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rq4MAL
	1fQzRXP47VmHrMlaeZyrntTtbpzmgafG5g2JU=; b=KMvz5Aug2n2vRkVcGW3/ru
	Sfgfc3WNb+26owQYZ1VW4hhvcwDZjrzlKI4gwk9SuQR80pmQmiZLiMvt82RsRMIX
	/2lNuNdZLeqwdBFGn+ZUreRWICZjiE9LTk/niDZjUQLbBN5jrfikQL87YGr8me2M
	5L2E4Dmdn/1WvbpI861pAXULQh3LgtVFvrjf/woVw9vTjE4WZwlcdu8Tfy1HTwa0
	FeMMHwJ61B4LowszuDzc9wjdzqbi4AN+xePEfDueu9yQPBu/yaeE1J2YGrQ60C67
	uS+y4QJvMkioIoKATyQQE8BXH0kWM6iZ5uvWMzcnRfquFHNQZ6AzcWXB/KeQPDeg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7kv7b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 15:02:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE4sQE3023650;
	Mon, 19 Oct 2026 15:02:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgx0gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 15:02:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JF22gM27722114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 15:02:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC31E58069;
	Mon, 19 Oct 2026 15:02:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 516BA5805D;
	Mon, 19 Oct 2026 15:02:02 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.112.91])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 15:02:02 +0000 (GMT)
Message-ID: <8fc08e24ab4941f6b5e130ce46b7f31b89bed0c4.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: discard modsig on detached-data binding failure
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?J=E9r=E9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260924085516.3111521-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260924085516.3111521-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 11:03:21 -0400
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfXyQLMxI+d7h6u
 ZrxYQActJQnL1GF1ZmkPY6cegryhEFx7I7ZUnNUz0f0NK2vUn+hszbf+W3cFi6mQCdPpoZKIVHm
 i0xmK876sxQCOHcE7meKtFZiLPEAMY4=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad630ec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=OPNBBWazzn5nCynDWsEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX9JzuUlcI1Xfe
 ro+Ajz9ppyB0jzIw4hWY9AjVs4idZ9wjkaRldGnKS8xmlbewDfi431EWYZ+ria/WkZSSjCmkSMl
 DHLzZ3saN/Q5r6r3GWSaAG+/BXjRCBXblx7wv87aEuaPa3lo5a2qWSobTiwh64qEUNozI1RbJSx
 APoRTG8Mfp2tl20pMgDvk1GDZBAALxAyMzkF/s52zY+H18KQEDJJk5E5J+R+O/ujMkmI/tgtyHi
 t8eoR1apF2/cQkSiX8JoxnfmODEgXpQprLL6iTts7L3ZhsoagUATAcnZailqZ7NykZct0l757Ht
 KMO2xsPkwDjdDzibtvo4wPFKEXnxuL4fgOqV0dOd4nPQDWBXFUgFXNbFLJpPhgWReGrIR0bJ70h
 v1HGxwNqVEwG5BPqg2K/f7Z8xrUh9CDT+6dQNGXi9CZLxQ4idKn784k5oVnEDqrU/uG9960fl3q
 k2sMDmbgOdjCs+PIt3w==
X-Proofpoint-GUID: OO2VOubz8564iKspuNSSO0ODDnqxq84C
X-Proofpoint-ORIG-GUID: ryqVHJYewvubwaD0dafVEAzl5VVkg6KE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190058

Hi J=C3=A9r=C3=A9my,

I'm so sorry for the delay in reviewing v2.  Somehow I missed it.

On Thu, 2026-09-24 at 08:55 +0000, J=C3=A9r=C3=A9my Jean wrote:
> ima_collect_modsig() supplies the file contents to the parsed PKCS#7
> message as detached data. If the message already contains embedded data,
> pkcs7_supply_detached_data() returns -EINVAL, but IMA discards the error.
> ima_modsig_verify() subsequently verifies that embedded data instead of
> the file being appraised.

Returning the ima_collect_modsig() error code isn't necessary to fix the bu=
g,
but is needed to emit an audit message.  In terms of backporting, maybe onl=
y the
bug fix should be backported.

>=20
> Return binding errors and discard the modsig on failure, preserving
> ordinary hashing and security.ima appraisal. Keep digest export optional:
> ML-DSA and multiple-signer messages can still verify without it. Leave
> d-modsig empty when unavailable instead of dropping the measurement.
> Audit binding errors separately so O_DIRECT does not hide their cause.

Is "binding errors" something that AI suggested?  I'm not familiar with thi=
s
terminology.  Please reword the sentence.

>=20
> Fixes: 15588227e086 ("ima: Collect modsig")
> Assisted-by: LLM

At the recent "maintainers summit" it was decided to remove "Assisted-by".

> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Other than splitting the patch, it looks good.

thanks,

Mimi
