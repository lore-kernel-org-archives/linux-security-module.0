Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8138AC76;
	Thu, 16 Apr 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354059; cv=none; b=cj5JMUw0jsipblGZa682m1CAEkwciCrDU9gZORd25UVWmmQOIagHmBdPFeQZ6qTkg1yHn3VFguHExrs5JQ6SK/mi2mdyDaYfK/4WDj+6iayDDewhvbVehw95Qkl8OmqN3n6fZeqoxjJhEuaoz6zu+yFwyjqEE+D7k0KB7lTWk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354059; c=relaxed/simple;
	bh=KSW3oXd5KG4BXMp266u00qlZVulV/X7WE2gh+sk401w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zgw6cXIDPPo3CXOYsAu0nGa+ZRVQtMpuE+pROzB/A+vdnhkDQE+f3UBgzcx0539/qok729qgzTmPVN91XxvywxC1rF7NcHnWmOy4Q42eQ80hbfxtqZl0RxsIFliFlF/3BzwPrKDxkk2mBXcWXvmiUrLklIRmTaJRIuFPj18miSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DtIfO9jT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DtIfO9jT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G7kMM02130871;
	Thu, 16 Apr 2026 15:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BLQSW5ONXGVxURJ29
	ktDSRluzzqwNUlSpl3meSRiUfo=; b=DtIfO9jTl5iFIxsDS84e142JZJM5EWN/T
	DIpBJZpt3gYq3GHdBhTUgdWtFE8VhsO92Oer1zY5suXLJ0iUPAWNAB9l25qZiSzR
	GROal13jZDRb+EpOVz1oNeudffg0cw2YVmde/8WW4MeiEhyMeOTCzrsjroFkYj7X
	wF8ePcqajwQMPo0OuiQEHn9uX9Ba5ysg6vmX/9tYGo4e/cXtKHW8J7ekI1LCVnFN
	OoWz3qIHINQB2RV2UG84mBCDfCfFf90tRqHFohc88g2M9ySEHNTB4nDO3HxZr4/7
	sxtYdlqA23eOZxN+LMYmj+eh2Jy7Df4QSpS8SAOMoyq8F9eh1Corg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89npaad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GEj8Ij031240;
	Thu, 16 Apr 2026 15:40:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10ykkv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GFejM16161100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 15:40:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FAF65803F;
	Thu, 16 Apr 2026 15:40:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3C1058054;
	Thu, 16 Apr 2026 15:40:44 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 15:40:44 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 1/4] integrity: Check for NULL returned by asymmetric_key_public_key
Date: Thu, 16 Apr 2026 11:40:36 -0400
Message-ID: <20260416154039.1648083-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416154039.1648083-1-stefanb@linux.ibm.com>
References: <20260416154039.1648083-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UZMjdfT4mqU9tO9zBHQQezglrTPPa_89
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0NiBTYWx0ZWRfXw7rsenU5mfub
 y3LCvkqNO6JS1sizpkNjN4MnjtLw/LPnF61whiWlXGf9OeVAfhMLzuILvzEJph2za7w4pM8hKsw
 dZuCSQE20HI+i3dRXMniX1ogzCpsi/OOGy1XjkZDLpYhkMCsR259pl+twRN4YGcf42bol41r2oE
 Z7OOvop5rpFRihXhC346/CD4juyMuuUPIp26Ou6E798+yGH22X6SYNCnOqvf6ZWxuEvX3eZR4wO
 zBmwJyqDUsQJqBMDZLD+WbeN2cVq3WHLo1stVH8XrwnvxXokyXhT6/TNo3DjGW+wiU/8vKbANZD
 fVYqtuE9SOUWlhbZQdSd52QnxAKrkvqDKS4S3wDQCGOPzhNQ/9akxJqqZqOX7RthPIBFrZZFOFy
 u21zrZGoM7/kNWo67Ji649mUjtnHw5p9JXtw4QKabnAHWu1gygKHxfTlGPTsFjoLmZ9zMex9jRD
 nzoWSGfg0xyCTqpg44w==
X-Proofpoint-ORIG-GUID: UZMjdfT4mqU9tO9zBHQQezglrTPPa_89
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e10300 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=2XTCyd9mqVENZwl6Km4A:9
 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160146

Check for a NULL pointer returned by asymmetric_key_public_key and return
-ENOKEY in this case.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/digsig_asymmetric.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 6e68ec3becbd..a791ad43b3fb 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -108,6 +108,10 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
 
 	pk = asymmetric_key_public_key(key);
+	if (!pk) {
+		ret = -ENOKEY;
+		goto out;
+	}
 	pks.pkey_algo = pk->pkey_algo;
 	if (!strcmp(pk->pkey_algo, "rsa")) {
 		pks.encoding = "pkcs1";
-- 
2.53.0

