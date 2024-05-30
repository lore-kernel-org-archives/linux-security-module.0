Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35DEEAF9;
	Thu, 30 May 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032110; cv=none; b=uz0YA49sWDwiOXG1rKZLNBo6fX7MYq6nzN/TP2d0vnBnGybvqBjQkBhyzg237k4ZARNAvz3DOHevRbEyd/5gDdkSkYRXospj5dBTVBtnr36N7WXwACYjnFS6nd5Ikla7aOVJ/GE8WwI+5vg4t1FsSDW9M7d9qHd5jNXq0/japfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032110; c=relaxed/simple;
	bh=7gnFWVIb+2a9Vv/GMea6v3APcZyg0PBlhE8G0c+9jbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=K/l7hTtJKtYiQcpR3qZiGXe5/RICO6L+8h/s+4NM0cZ+joKkQG2mbaLL2+nl4QmZkzP0/oYKAz0nb7U0FKe1i65yfmLks9SxVCH6SXCsc/OWWJFqBWLUO5iTB6GVJQdUWp7JcQuf3CE7Ez6CmW4kWUBDUZurEgyjMHBX45dx4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gw8B3Qdu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gw8B3Qdu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TJW7x7003995;
	Thu, 30 May 2024 01:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hLw8LTLUY06aaa/krLxxhC
	GK18FxFHjoY1EHtEAqxTc=; b=Gw8B3QdugBd4YQm5w7hrEn2muQVZTZWVWTiXeD
	3A0tcRG13VsfESa+lAKHi62IDaq8tZDxIfG1IkduqiH+wPapzhW1Qeh7An5f00XR
	wPSRktik0MGbQ2Q6aCqFjGKUWKj4FcyTNsyGOJV2v09wVflS5noysW4DqXJofb8Y
	ZZZ8Zgu179amOy/hJ1TO/Nc78zEa/Cjt+hXliA9W92VwE/KIGSGbXt6IiDfAX9Fu
	HdENmcmphugRmFYF6SebDV5Is8cZnAOKEpu0iS17X4L7XH2RWk/dPxLZcg2zvfMe
	0dFOShBj2m+K0IK6FT8UrM/pWwWM9/lahM24PvUZejAThgEQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0xaqyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 01:21:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44U1LeUt031484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 01:21:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 18:21:40 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 29 May 2024 18:21:39 -0700
Subject: [PATCH] apparmor: test: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-md-apparmor_policy_unpack_test-v1-1-9efc582078c4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKLUV2YC/x3NQQqDMBBA0avIrBswohV7lVLCGMc6VGOYicUi3
 r1pl2/z/wFKwqRwKw4QerPyGjLspQA/YXiS4SEbqrKqy6bqzDIYjBFlWcXFdWb/cVuI6F8ukSb
 TXpvW16O1TWchR6LQyPt/cH9k96hkesHgp1925rDtZkFNJHCeX4Ys6AmPAAAA
To: John Johansen <john.johansen@canonical.com>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Sc2rEgDu9uJAX7lqnREIIO22Uh8y3tl2
X-Proofpoint-ORIG-GUID: Sc2rEgDu9uJAX7lqnREIIO22Uh8y3tl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=808 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405300008

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in security/apparmor/apparmor_policy_unpack_test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 security/apparmor/policy_unpack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 5c9bde25e56d..874fcf97794e 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -604,4 +604,5 @@ static struct kunit_suite apparmor_policy_unpack_test_module = {
 
 kunit_test_suite(apparmor_policy_unpack_test_module);
 
+MODULE_DESCRIPTION("KUnit tests for AppArmor's policy unpack");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240529-md-apparmor_policy_unpack_test-7657c4f11591

