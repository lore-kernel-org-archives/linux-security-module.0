Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA130B53F;
	Wed, 26 Aug 2026 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779270; cv=none; b=VFawm1D/Doe4Eh4yXCCgEVpydLKT1fQ93yRqeIEBa7hbncZV5b1bK4fmp0mSRaGnkcCAKfi0nlfMS8CZ7RJNcc/b/oWw7dGSEcSr6ULUTGqwJSvggUEtDeJfYKlIU/hW+7tqVJSlbrAFLQCSQ3oyTblwKDlkUa3b3rh0OZdg0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779270; c=relaxed/simple;
	bh=JGuIG5i5Y92s24+8rPa8V/P1dNqCQuCOcaXrVrt/5fg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=lmJXYOlHhshUl5y47AyX8iQphe4MIfwcaBfAPaWJxvA3FJganuLhSKKEzXgJjzRKAu7585xkcXmt8+aui6iPccBhx0Sg99AFUqvCHg0uVxJ9Dz5Au1qDa6qcI9lGbVUR+m4ApKA0uYAA0PoyawvbQ2nfstvmDvDm44B5Cdu/1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ClxoFe0u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ClxoFe0u"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QL1atO3280612;
	Wed, 26 Aug 2026 21:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u1B6I0
	VvqWBsOmpPg/36qnO7c8sL93KspNt3IVYf7Tw=; b=ClxoFe0uc1NrQejHgdb8d8
	QY6ueRpK0TDFfhLMYM2SZkoE50X65+7gvOqXLgChbaKywoHhdTQ9AB7Phnstd/2c
	iQ2uD9V1LxOqIiiY+o6dpzS8loPnHNf+jv4bG3KbFZx8X6U8psXPOSosPwz5QvWm
	BdD0wJ6FFte8gk2USh0H+FrSVkzgkmxqvjHjKOcZZ9TDLgTihcd2AniJKP7LDxJk
	Ya1a9Zr8dvznsTGZGqNfzUq+a/CrBo0RQBdSLrY+ChW3JYPeLrpz9bTR+84BczT3
	alseJ2Rqn+sxzrifNeEECZX54XrHU9NEqNYStIOhCxe1ptHYunXCYD4/SRNAJbSA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er18e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 21:21:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QLBKcD018758;
	Wed, 26 Aug 2026 21:20:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhc701-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 21:20:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QLKw0q24969950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 21:20:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0431F58059;
	Wed, 26 Aug 2026 21:20:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C24A58058;
	Wed, 26 Aug 2026 21:20:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.63])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 21:20:56 +0000 (GMT)
Message-ID: <4ea0433a82c219d6efdb83ad0bf267045c91a374.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Singh, Jashandeep" <jashandeep.singh@hpe.com>,
        Roberto Sassu
	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>,
        Jashandeep Singh <jdsw@juniper.net>
In-Reply-To: <20260826191051.219090-1-jashandeep.singh@hpe.com>
References: <20260826191051.219090-1-jashandeep.singh@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:20:56 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9iF5uHHFFbZsqFQ-cgAMpnnZLwk_UIFJ
X-Proofpoint-ORIG-GUID: _bFhKAy0cyr59LBDx18-pG2OiN1BBB5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfX7U4blafBpOtP
 Iwlui++eU7wzKuB9siKcHkgvTEgiU8tw071OKYSWmXGrIWzGjVIgoQBlPbdsxBIilDqm77PGYui
 1mMIG8XQhinMKoUKlxjbCjPSciAh0lDPm97gJcwTFYtBSEqelQNGsMZFmILi84yq2P1vNX2g0KB
 isRhn/fJXf6VGpjskxIN/1OpGSxr+8DXra8iCwH0Id99H96aoQpgruvq6L/s/O8+zr5gH77Q5lx
 Z4EWXhOYqI0dUIUh3NTTPG7Qn3HTlAhZAXNpnfsPtylqfdZfSWNwKsGgHNi79FB+b3ZPBB9/eso
 53lYdlRscV0NRyLE/FqZx4n7ZH6aJSY7NIcQOxjYmj/NHo0u2CEUuhmr7Gvz8Utqftk/K+8RQro
 l/bNO8nSZHt1kPZKt14yhNLmJ/RJ2sA1L26T6R1/2BYqF7FDmhvUqh2/qXkZmUMQhmH6J8JzjLs
 5lA9YTcKpqatK5QT4fQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f58bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=OUXY8nFuAAAA:8
 a=IVkZGz1pcR_h0Quthn8A:9 a=QEXdDO2ut3YA:10 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfX8yGXuNp8XR1p
 y3adfFDvxE14qXgnLzUco4B8MeRcgR10Mh7UUBxJrXibfBJCe+HrOEpDXj3gmdMHmiZGaPLPzf0
 XagpuF/7P4rOn8qQ9sRzZPYQnKc1/q4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260176

On Wed, 2026-08-26 at 19:11 +0000, Singh, Jashandeep wrote:
> From: Jashandeep Singh <jdsw@juniper.net>
>=20
> ima_calc_boot_aggregate() selects a TPM PCR bank matching the
> configured IMA hash algorithm, otherwise falling back to the SHA256
> bank or the SHA1 bank.
>=20
> A TPM 2.0 can be provisioned with only the SHA384 bank enabled, with no
> SHA256 or SHA1 bank. None of the above then matched, selection failed
> with
>=20
>     ima: No suitable TPM algorithm for boot aggregate
>=20
> and the boot aggregate digest was left as zeros, as for TPM bypass,
> making remote attestation impossible.
>=20
> Accept the SHA384 bank as a fallback. The configured IMA hash algorithm
> is still matched first.

FYI, all enabled TPM banks are extended.  Refer to the functions
ima_pcr_extend() and tpm_pcr_extend().

The IMA measurement list contains file data hashes based on the IMA default=
 hash
algorithm.  Similarly, the boot_aggregate hash is calculated using the IMA
default hash algorithm.

If you're seeing "ima: No suitable TPM algorithm for boot aggregate", it
probably means no TPM banks are configured.

Mimi
=20
