Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033A329E7E;
	Wed,  8 Apr 2026 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670147; cv=none; b=u3PAzpZNQZMn0LomiZ22wVoHP4Zi0tLlXqQUX0UCQ9u5DXc5KHegKQMqKTUr8o75LiDbrdm6lyNklsu0sgiO8diFiPVkF0MwEBORiHCceYaDsYgMSLF2pm5oWioUKRKTDZ0w6Hnu05JvvBhUTWE3NPdS7YRLkCH1yYOrV0qJvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670147; c=relaxed/simple;
	bh=QKhfaVrGVmdrXbrLLj2iP8/XD+V31Y0f3zismflaVKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fj+Zqqz/UTIzssJaPZrymsCMvT9mGsLrbx7wy7e7rX2ZPvrXG2BWW22h91zz+GvCyQ63IXzMkofcGy+hORuAJeNLN8Yi45H5yAQ8n2yS8aP4sfl164W/+eTDcKZOdp/+tO4ijJCgz5wT490gTysgjMD4D5wGvvxHlZq0shhSVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLQ707k5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLQ707k5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386FPKB2302400;
	Wed, 8 Apr 2026 17:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=12EH+nI7fe0R+Jio2jfGRGUQxajHEf/n3XgmUzwz+
	6M=; b=dLQ707k5ajNrNozldugOPdjTcRG/arDy3GQ/93BB7d5j0T5WIm219Yl8H
	bwoKxiOdBR65MDMQ1QEveKsmPYnlkrB00VIHVZpMh6r4hLKhFs4MgtRN2DzbP5C1
	W7+inu+O2Bh6obqDOcibFMF7UQovjWe23Pw3ziUEfyeiSOSi1XeTNMDDLhLG6+YE
	wTvl532/d9+ftUSLfQa91xEcYMLMx9mOmZ/4Vm+sdeDjXFKl423mb6VotaWURtna
	7eePvbWmAvbyUyjqCiKvm686NFl6v7FHFuUNnC1MFHDPVgjZZ97IU6BLfNJFd6wp
	72NZYCIXrIDbvP/HnuzKYOjbaixuw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fh94b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 17:41:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638GEF4r013844;
	Wed, 8 Apr 2026 17:41:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf48c6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 17:41:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 638HfuLl5112758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 17:41:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8EF05805A;
	Wed,  8 Apr 2026 17:41:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50ABB58051;
	Wed,  8 Apr 2026 17:41:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 17:41:56 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/2] Add support for ML-DSA signature for EVM and IMA
Date: Wed,  8 Apr 2026 13:41:52 -0400
Message-ID: <20260408174154.139606-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE2MSBTYWx0ZWRfX6BDk0F15s6LN
 EAkp2x8TJ7TLZWtwie2akQJNNdL9QMod8YdcwCaZphsylH74rZuqhN3xmjgpuCXvxb6Yqu/aCFj
 Cj14xmSxx+mwBE1WmpZ68tAww0/mB50DlLAOlKt7IkD4jtGCsgf2fCw88fi15tok3vGaQ0EeoMR
 8Tqo2xexUI+l+0X619Yzo0aA6LQFN95KnfZwfxjE6ZXK/mS9TxGTSJPT1P6U9QwZcgUGLQ2K3t+
 XV/bg+Z1pYTyHp3eB8vKQ9q6GE6r54G6fQ74iQOAKBKKxaQ1OA/n9mZyqd3vEt/iqH0hf7/OQ7Y
 bGz0C5GXyv6Rv6pFIz0PXoegcakBr4snVDF1QM4V1JwfR1PqNXeKvgckMVGE4Q1aL9hMDb0M0Qf
 ob22dGPVA9x9a813AQh1U0tJTwdFI7KMeB8sjmsbHwAuvWP+tGvUfCg72W57HOcJbNHya6GeokI
 nsN8K5hC88OC/tSzhlQ==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d69367 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=vnXIO8GFCSn4u5VWM2oA:9 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 4G2p2iCUWU3x4t8MHWeDZLI2V4QGb3_Q
X-Proofpoint-GUID: 4G2p2iCUWU3x4t8MHWeDZLI2V4QGb3_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080161

Based on IMA sigv3 type of signatures, add support for ML-DSA signature
for EVM and IMA. Use the existing ML-DSA hashless signing mode (pure mode).

   Stefan

v2:
  - Dropped 1/3
  - Using "none" as hash_algo in 2/2

Stefan Berger (2):
  integrity: Refactor asymmetric_verify for reusability
  integrity: Add support for sigv3 verification using ML-DSA keys

 security/integrity/digsig_asymmetric.c | 126 +++++++++++++++++++++----
 1 file changed, 107 insertions(+), 19 deletions(-)


base-commit: 82bbd447199ff1441031d2eaf9afe041550cf525
-- 
2.53.0

