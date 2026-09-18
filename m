Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890352B1D3;
	Fri, 18 Sep 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768209; cv=none; b=jTFKExPnN4C4iMs2jDSHX2zNI6L6wZxkl/TCiNhBoKpxxuG/oXnsT4MgNpvwXsizOpy7WtscZ5fhYXoYipzDCXOY+I+L8JseWY3UAtVBvL9cGeiPlX5teFrIwE9uJts03ZY0oDQ04pfbwtX3TI7R1K+fsr3VPdkpIK8I7whPtwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768209; c=relaxed/simple;
	bh=Cko9Zwq3Vh7ZcfuOeKNRCO4UyO3g4kNbUEW/7FT5nns=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PWx5/ueOXBu7yDgwJjBllEux1ubMLDcn6gBqwkBz4cjW057CSrbPNgaWfF31vSW0Zz+CJ+1R79g0znHhRQbc6p9RGwiteryNuWFM8+W6GAdiVsxSz9yLN6bdKJE3HMJt5tCihrcjAeo8gPtFFCEyDHQrWXcspnBTZ/KM5TWaHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Av/RJSfR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Av/RJSfR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IKVhiC1094215;
	Fri, 18 Sep 2026 21:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=37ntVI
	DIWX9UKzB+TsdGFUb+iaRVQhISSLkL9LJYvrQ=; b=Av/RJSfRAUdJeRi+8xO0bL
	TMgrFF8izryjQ2KM/Lu3nHKNWr4fcCHPZEb7vUaJAzd68M/wkbawGT3UGIi/GuQ4
	bFb6xtwQQcOganPb7NIntcQj0RLX+35C6w4luUhFQ6xKG4sMC4CjgoEarIOC1877
	BUorOroOdOAyP/Sa6TwNpGuNee2jbSBOkpOEQ+V0PB6BhcmhC84aU3HJva1qISuh
	8nWqsikXwVLWr2e99/We90BaB7M4o12odZJ+6enD80/3twWmP5UCS+FpdfyokLOr
	hgDnH66cLU4stF5640smNqlBLa85bYp2dcNXXk6pITaInxhbR+lTKMZZdJFs0c4w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5ehx0v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 21:49:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IKK5v81234619;
	Fri, 18 Sep 2026 21:49:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56qa3jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 21:49:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ILnjjA8192640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 21:49:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 388835803F;
	Fri, 18 Sep 2026 21:49:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 289AC58054;
	Fri, 18 Sep 2026 21:49:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.133.121])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 21:49:44 +0000 (GMT)
Message-ID: <4086ad937c14946de11dcd01ce6d46c0e1458620.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] integrity: Replace integrity_audit_message()
 with integrity_audit_msg()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
In-Reply-To: <20260916-report-hash-error-v3-2-73e5d95e9efe@cloudflare.com>
References: <20260916-report-hash-error-v3-0-73e5d95e9efe@cloudflare.com>
	 <20260916-report-hash-error-v3-2-73e5d95e9efe@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:49:43 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDMxMSBTYWx0ZWRfX2l+YI1sEkM4t
 IoDfOZ7Ff5C+9hQinuopmSqW52VEOtfBLAW5ZfIR0eDiPz9JxzsThpSvllZPHukGGxJJkGCwvXx
 sZdWLC+YK4XN9J4dO2LiRPKWcA4L1kWtmq86B6NTMm07E0Zxcd8cXL0nVpy2GUFicohG4bTVEPx
 XlMxAArktCiKSDjvjlMiodIoVSKxhtWgmv4N72cv1jigJaQsPpCmqCY/j8houcdTxJLG2qARtU7
 DnB9fwLp2aeEAj43NAIQsZw/sSo7rtkjo4f3gdIpRqfl7LSCQv5vncaI7I1fK5kMNHMafGeuHBJ
 Txf6czzrBX3EBuBwHu0BvdntRzehzQpiUUitPZiWRGTq1bcdfove9Xi2mGsQJwwlwEgyJFkxsWY
 YlobSS9uWpbY7kh3r3cI38pmXEaEL3rTtlUbwTIoBh+n11Hv8hCbWBTo3t5xcu7fEiPIxe5M5OT
 y7842gMWOFKVSpIM2mQ==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aadb1fa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=EG7W4yiQAAAA:8
 a=KUfPkIi8R2PQVBz8DpUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6--v3iu37kEqKOUMuRmLZDAcreEhe69N
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDMxMSBTYWx0ZWRfXyMJhwbIC7Us+
 JBff6eHf+dL5yZeQ8/2ZP+15hJ+1ed5BPrpELfCXOWdM/5KLrmYgeUH879cRE7I5Ihd387cWHag
 BP6FXczMi2Vo0h6+vRFF+aP6XcrPa+g=
X-Proofpoint-GUID: QkOwZOtJYh65AHxg1MNbWxz0N8ip1kA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_06,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180311

Hi Fred,

On Wed, 2026-09-16 at 16:36 -0500, Frederick Lawler wrote:
> integrity_audit_msg() wraps integrity_audit_message(). Replace remaining
> call sites with the truncated function name. Then remove it since there
> are no more callers.
>=20
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

I agree with Enrico on the 1/2 patch description.  This patch description
similarly should say something like:

Now that integrity_audit_msg() accepts an errno parameter, it is equivalent=
 to
integrity_audit_message(). Convert the couple of integrity_audit_message()
callers to integrity_audit_msg() and remove integrity_audit_message().

Mimi


