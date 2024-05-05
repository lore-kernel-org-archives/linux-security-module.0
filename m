Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2D63A5;
	Sun,  5 May 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948775; cv=none; b=PBe+YDDduHVVGYD20B25aZoz6IudZ3dGpYMtMdXcLojGogZFDE4beWALPdup3UY/hzRN5gT069KDY8hkGmGFj5/fH18maTaYwPHSKDK0a9jGLlrJZL3CgUyISDnOmSvNredI6rn+0DscGpslZ2YwRQ6Xt4B4rRlLZHV4jo3OY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948775; c=relaxed/simple;
	bh=msCXC6FXGfqOt4+YBWsjlLnrZNao9NIJfJB292l8HCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=MCJL9ygHTrv9S8yGdU0uD/a6u8iTmloQAvdHhCob9HCGEKbbewQFoKKwyBHA+brqoC13pcpKOHmfe/ywDPaCrE2VeUBxTxGY3fAeNMsWGTUqQw4BCPhd0lpPdYEBz4V+TtlDR5otN3+0iiJamt2WJG7Ej0GQj0sI71zLOCiWyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QtS1v1Me; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QtS1v1Me"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 445MTQZW018412;
	Sun, 5 May 2024 22:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=pN4
	SsWcLrBu42o1mEuYtcoxgTa4sqbLDWl+4lNo8NLY=; b=QtS1v1Meie3ys0H7NEN
	paYgHgtnTXjzx2l7vGDUvy1EPG152OwVPOdxX3NKC13W+MemMLNlSzL4/VPLLiOt
	wSoM65iw3wHAF6lReiwAdL30NfSqJ+bG49cCzW670YBdi6f3o7tgkUibqzARU8o7
	5Dzx7T2VwUovafNQ2IRqIHGypQUsUqH/BkKt32H0W+6jv+usJjVLk1kV96mbKx6x
	FcRXJCUm2rluZclrZvNIvOggQd0ryDZcSOXDKSpN1yYPU7HtNk61Mcw9ogseeTJl
	KkEvf8Wtl7DB/n58mIC7i8U2moob85+kI3/HccU1y+e0xMuDCjy6OznFrFqrlidI
	hDw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwcbpj8rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 May 2024 22:39:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 445MdJne011415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 5 May 2024 22:39:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 5 May 2024
 15:39:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 5 May 2024 15:39:17 -0700
Subject: [PATCH] apparmor: fix apparmor_socket_post_create() kernel-doc
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240505-apparmor_socket_post_create-kdoc-v1-1-1fd88e546e92@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJQKOGYC/x3NQQrCMBBA0auUWRuIxRD1KiJhOhltKE3CTChC6
 d2NLt/m/x2UJbHCfdhBeEuaSu44nwagGfObTYrdMNrxYp11BmtFWYsELbRwC7VoCySMjc0SC5n
 rzZPH6KK1HnqmCr/S5794PLsnVDaTYKb5F15RGwscxxfbsfYCiwAAAA==
To: John Johansen <john.johansen@canonical.com>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aK6l2xpoyo5uGV8PABLUO-CrPkQcv4cv
X-Proofpoint-GUID: aK6l2xpoyo5uGV8PABLUO-CrPkQcv4cv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_14,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 mlxlogscore=903 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405050093

make C=1 reports:

security/apparmor/lsm.c:1138: warning: Function parameter or struct member 'protocol' not described in 'apparmor_socket_post_create'

Fix this by correcting the misspelling of 'protocol'.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index cef8c466af80..d0485fb0ed63 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1124,7 +1124,7 @@ static int apparmor_socket_create(int family, int type, int protocol, int kern)
  * @sock: socket that is being setup
  * @family: family of socket being created
  * @type: type of the socket
- * @ptotocol: protocol of the socket
+ * @protocol: protocol of the socket
  * @kern: socket is a special kernel socket
  *
  * Note:

---
base-commit: 2c4d8e19cf060744a9db466ffbaea13ab37f25ca
change-id: 20240505-apparmor_socket_post_create-kdoc-897c7ad5d007

