Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D49319601;
	Thu, 21 May 2026 02:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329283; cv=none; b=XeFxqYdqO0CULAWyiYmB3GScZouE0roww5F7yYVqiCpZ5acDy2Jt3RwGCriF1sBQ6zzODfv8Du7BDT2Y+vBB1sj1TZRBTcv3G2vSI1GWPTeeJ9TvQaAt89kRc+08dk+yLIzlkXfkAMacAaapMU4U1MHskT7rTkqkneA5Q8EK444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329283; c=relaxed/simple;
	bh=vqw1bAHhTOr2QUk6EvDUyoK2Ln7dQd1QaTuNg7SAYhk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UOIuFY/Or+V1jWMvdmMNlel4zSCI0eusJ9KFswjRZSUrv+SE02AkXWfzepmF9aue79NJ8WJ5iWXG7M5YSS5ThSqtRBzyY5JX8SDY67KoWFw9o6feScx1Cq0NwE0jSRCxfspfOnz7shFsM8i5zWVlJbuy92XHfpk2WIBKl93IzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ioLSKPOl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ioLSKPOl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KJZC8C2191659;
	Thu, 21 May 2026 02:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vqw1bA
	HhTOr2QUk6EvDUyoK2Ln7dQd1QaTuNg7SAYhk=; b=ioLSKPOlGN/SffPhxuwRKL
	HIq0gYB4W8QY02xqUKvXKlSxEWjL/P+x8lnumsIoTfuVKxfiJCYew/qzUn6f+JYN
	GSKDCiFaxC+GWz6pKwoVUgVC3MlWCtgajsMsH3YykevkAmz8H3OkWbh+6kuT94PS
	f4WIiTZ8cxSXYc6WR0sYUHq3c00JeLUOHumlahjrXuOUc2oUTK4yR6xLSGE9OXba
	4UtQYiF+VFKIPVhkMWLbC4Jm7pttsuKGEbq4O2djF/nyBzFGkPMrZeXwPaNw5m8Q
	grkqYkGCXV684jdrSCQXOSM1rkQJGl7wb2rOjBe3KOKzHP94pBd4A2Cz60WH5uLQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawbnx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:07:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L1sAxF008029;
	Thu, 21 May 2026 02:07:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w25ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:07:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L27f7L41157336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 02:07:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37F1F58055;
	Thu, 21 May 2026 02:07:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F3AB58043;
	Thu, 21 May 2026 02:07:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 02:07:40 +0000 (GMT)
Message-ID: <82a948ee4ab80e303ed25065a17c96dfc5e9e588.camel@linux.ibm.com>
Subject: Re: [PATCH v5 08/13] ima: Introduce ima_dump_measurement()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-9-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-9-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:07:39 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAxOCBTYWx0ZWRfX60HtXsYQRo06
 Umru3kV/WBv0aWcQhRBJ/3xj0qHFPSlN5MTtKnH/yHumDcjf52S40vqtXgs6XzV5NBd3dYx+dbL
 BXTSPxiwg9S0uPzT7wgbPJko0+hMj0/6LrWzBRUnGHboofZI0drvfdqED/0+iGkg5indCy3voO/
 sFn5OiyzTCevc3pzhZtcveaReLdy64tDushTyigePtwcB5WlKY5TsXxA7lyDC8s4gjkjoQijOFT
 FL20Igq8gxdDxwSzlfIPlNw/PDdOHglVNvL3KDlfS2MJ7DbgxhU7XmD0yddRsIrD86YfuKU7kYr
 /+BVASL1JwC7ylVACLyEdZGeumJNQq+oN5YVGzKSUsZeHe+WAcp/MDVX2bK0CZfN42I4+h8N8hE
 Z0r8C+dI/5Ms8eqqovSNN0EWkevm4IkyOnS6jY9KmxuuJnX5qPlMNErabp5Th+Ovzs95h2UVZ7m
 1Ti66prTL4kQqfXou+g==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0e68ef cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=3t8diSVONHxdbtUu-HYA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: XAY20XtEsyEWjfYTRN5dv2-3Zr1_T8ii
X-Proofpoint-GUID: f7ZKAXmnQKsO_yk6gWOvu0smBSZGt2U3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210018

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce ima_dump_measurement() to simplify the code of
> ima_dump_measurement_list() and to avoid repeating the
> ima_dump_measurement() code block if iteration occurs on multiple lists.
>=20
> No functional change: only code moved to a separate function.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

