Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6732D7380;
	Thu, 21 May 2026 02:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329230; cv=none; b=YEMUeov3iLTudOH/SpoEObbQm6Hdpd05vxp8fEmKjV3sMHxOctyWRkznqxIMlsqsBJrnHaGt/XGZgCr7PHEmKCer0mXlMkxLFT58TfjGeGyNYJbtV/D5CPr4Ohhzg/wR0FaXOc24655d5dMGbQo9LuUnXjNjag4BCVML0/+q/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329230; c=relaxed/simple;
	bh=m3f3k5/Tj6B+3Ec9GNkW+3mwyhB+oFz+U09aPIBBTrs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=CIvgYMQvVGErnOGLaB65WkkcVBhOHQ6hZl7j1HWa9sOs02+i+zxw8IH4/Munorhde1/t15vrhl34m5PMS5uCEbyaVf7Q0NqPUbaWxxLvP4FaixtavmtpHyL75aZkAXsOFoLTI/nDkjXTNN+GyoCb06f2VGDH7CubC/wucPnf31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LvdpIWnK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LvdpIWnK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KIpETW271835;
	Thu, 21 May 2026 02:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m3f3k5
	/Tj6B+3Ec9GNkW+3mwyhB+oFz+U09aPIBBTrs=; b=LvdpIWnKTspjS5hpribWK8
	8Nsw7ZLcj31UpRSsoitDQxczjdyXDO0ynhC296NX95N4FL0WiLVrA1K7BrATvZL/
	3P8z2M8F/A4mpeZ+jrmWZSnwTavEhWqSLYjIU/478am6SRBROqYD33HfEegdn+tt
	oRXQda0kG3cVdr/lhAkJ33RyaskVs0yYWGauajkOSQ8SGSV5zOw4jgI9aZ05kSOS
	OJ4cCtmIH+mE9Un/C4I516BygAyVNVi90HgnOK919KpOzI/YdxNTV1bqS0y+Wea5
	CVz/L8jqptBzsqMlkqAyy7E7hARz9iVtvEfUdbshkc9I/XwRAre23Ac2aXRhL++A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h754rhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:06:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L1sJv4015205;
	Thu, 21 May 2026 02:06:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhsycn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:06:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L26jY826935906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 02:06:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B38D5803F;
	Thu, 21 May 2026 02:06:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEEED58054;
	Thu, 21 May 2026 02:06:43 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.83])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 02:06:43 +0000 (GMT)
Message-ID: <7d7054964605eb1c0c69caed1a78b4229488de49.camel@linux.ibm.com>
Subject: Re: [PATCH v5 05/13] ima: Introduce _ima_measurements_start() and
 _ima_measurements_next()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-6-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:06:43 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0e68b8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=3t8diSVONHxdbtUu-HYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _EDgGk8C3Bk3XLsxS2z4GLHvsTrkXuf_
X-Proofpoint-GUID: Ri_Lk6IqXYFZI0m6mzP9JCKVyYLaehJR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAxOCBTYWx0ZWRfXyBC89y/sQ/PY
 C+yI/n4PPq7jssxP/PD1VAiDrcYylWYZTTp8qUABH2pIrjWIH0wLz1j61IG54ma32/1DeZTCvPm
 /OIvrwjAtuvRnNV0PlIn5gG4WjJnIXjCYwqgfr345090DswhISczxRj914rIqv6xO9rcqAz4BF9
 4PNa+YRIJ/1ml530qYi9FHovYtfDw56ukAVxOKbE3XmZqrMyuSowusd/wmApiGfeg6lBKwnwMtp
 7xraxj9XwiLjR7/e5XTwWUmCOVX+fBBuSi7PUJ8K4XsLQFofYJ2uhVnUgU9MiK77zhCCAwLBll5
 HTqm7tXWpQwU84IbVZEUdokscMWtPNMIqFgQtnkZYj0XQRbu21nYuxCJpltsOrJpEitbqqWYljv
 29u8Eg9IpBqcZlTxrNULmvdV8A7bsxsss423TI2IPCaSLTqRDD+YZCV+M3BhuncWHRQSPtG6lgG
 FdxVQbDoRY4d94FabWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210018

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce _ima_measurements_start() and _ima_measurements_next(), renamed
> from ima_measurements_start() and ima_measurements_next(), to include the
> list head as an additional parameter, so that iteration on different list=
s
> can be implemented by calling those functions.
>=20
> No functional change: ima_measurements_start() and ima_measurements_next(=
)
> pass the ima_measurements list head, used before.

ima_measurements_start() and ima_measurments_next() become "wrappers" for t=
he
new functions.

>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
