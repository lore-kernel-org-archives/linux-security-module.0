Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601135971B;
	Tue, 13 Jan 2026 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286178; cv=none; b=cbPtIBQhmcwxIW29l1caZk6YFwI/D47CDi0Ys4cBw6epJv9V+mn5NOgV5H//QheP4FY4bAgHqOITMBjducfJszMo4ei2AvKf/zog2MPqfSyF4/bkbuMzNnvbGxuuS9ta/QYTGSWPVj8PbcdDi4a86Tg+0gAbU0kxx72j3OuksEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286178; c=relaxed/simple;
	bh=bQIhwrGi/zOfhrtxmK9eFryXAlfnwqWfU2tqWmvEtSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFNT53GMH8XKj6VK9q+j71gr8BNfSZWPxCrA6TB/7KJCWcLox5wc/WkvYS6Bd8Ug5nCfg7BxfjINFDJlO7c3MUINf/TMgbzdLpw+/rqdT/hT4xNfXNE464q1Jxku0k+Yo24/Ph6EO5DDQtVEd0IEehpMYcc0jitAu82Gp6uQnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l1IH19Yf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l1IH19Yf"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1iWEU3333691;
	Tue, 13 Jan 2026 06:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=dPwgNU1TUevkXvllvb7O9KYc6ummv
	ZdnwSByc26fgIo=; b=l1IH19YfNrtRaK5Rex75tQtJivbELwDtfOZS+0mD55SwQ
	pwrM9WkOOlAQ1xqxsKB8/KBriiIYUWF56NBtRyCEU16jrOM/60dLkU6RM8gWMp6Y
	cmt59gJ07pGc3Gth3uFbotylIulbl34N5aBvRpOnszu8eBlaaiNQ0jKhwVq4nEfN
	JmRn1ZBfA8KPTBX9+NE1dC62TX9Vd1ZoAXlVjAHuoe4bZl2WRJB0QgzGtL+Nn7kb
	5fHvEZaBmoUPmQcsXTdnvonAjTVFdWd6EY4DyMq/0phqixblh0QLVepPAgc8QgGE
	s8J0/0Cvknsq8TFM99KYLQ91FVOA2IuiNUPp48zGg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrp8jxrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:36:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D5cq5t000437;
	Tue, 13 Jan 2026 06:36:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7c47t2-1;
	Tue, 13 Jan 2026 06:36:11 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: mic@digikod.net, gnoack@google.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] landlock: Fix unsigned comparison in get_id_range()
Date: Mon, 12 Jan 2026 22:36:10 -0800
Message-ID: <20260113063610.3137213-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130052
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MyBTYWx0ZWRfX1opCqsSHnGwL
 Hc1sv9yfob93oe9X1GZD4sFymZmctSG22KIcb3mxuTj6v8Gvsq/nUgYr0tlA/ctaFHHTVayWiQI
 UNz0fi+MiVTLtZkqvrjgk7x6iBRPVzwfq2ttHjXNdY+q2srYXBIcz37Asz0xZzZhX5keAx4MwEv
 bgTbZZaimSAyJABzleG9CXX1lnuNyLBPbF+F7JzDB4McVfQc1IObS+7O7Ka4FnvZIdzEX+4TLgq
 6xLhMKieVQ4Qc9HDeZLh/ftuEF8b+8Z9zjLLiaddOBru3hbXC+NnSlB3HICW8mgJh9qeTfCoRhO
 AP1DtgCUmS2FRBbCDvm8H8QEcEOzfJCiJEYizcEUmwqS6rRG4l75ce9gYcg+eTL5vMkhXKyXMxD
 +xqZkh+x5OrhsRhJ33JmD6mA+FtfetQdn8EF60wHVy2pmO6Pet8tTrL/0//ROaauRssyQPVbbXj
 Ygv6S5PZ92Rc5VLh8FT9pU5EC/woG/gVkAfDrzpI=
X-Authority-Analysis: v=2.4 cv=YcGwJgRf c=1 sm=1 tr=0 ts=6965e7dc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=YkufF-rjywg7DwWfd38A:9 a=ZXulRonScM0A:10 cc=ntf awl=host:13654
X-Proofpoint-GUID: WiS8Eavp_wCK1fSNF5UQ9T6OLO3VnjZq
X-Proofpoint-ORIG-GUID: WiS8Eavp_wCK1fSNF5UQ9T6OLO3VnjZq

Fix unsigned comparison where size_t variable is compared with '<= 0'.
Change to '== 0' to match the actual intent.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 security/landlock/id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/id.c b/security/landlock/id.c
index 838c3ed7bb82..5424cb3d7ee3 100644
--- a/security/landlock/id.c
+++ b/security/landlock/id.c
@@ -96,7 +96,7 @@ static u64 get_id_range(size_t number_of_ids, atomic64_t *const counter,
 	 * We should return at least 1 ID, and we may need a set of consecutive
 	 * ones (e.g. to generate a set of inodes).
 	 */
-	if (WARN_ON_ONCE(number_of_ids <= 0))
+	if (WARN_ON_ONCE(number_of_ids == 0))
 		number_of_ids = 1;
 
 	/*
-- 
2.50.1

