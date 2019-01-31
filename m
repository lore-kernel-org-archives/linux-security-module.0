Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E548FC169C4
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42A920881
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 18:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfAaSCP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:02:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbfAaSCP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Jan 2019 13:02:15 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VHsVFV019580
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 13:02:12 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qc4xmuafc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 13:02:11 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Jan 2019 18:02:10 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 18:02:07 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VI260r1507638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 18:02:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FBD211C05C;
        Thu, 31 Jan 2019 18:02:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5114A11C05B;
        Thu, 31 Jan 2019 18:02:05 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.91.214])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 18:02:05 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-security-module@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH] ima: remove CREDS_CHECK fall through
Date:   Thu, 31 Jan 2019 13:01:26 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19013118-0008-0000-0000-000002B97615
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013118-0009-0000-0000-0000222579E8
Message-Id: <1548957686-534-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310137
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch fixes the CREDS_CHECK fall through as annotated in the
 "security mark expected switch fall-throughs" patch.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Matthew Garrett <mjg59@google.com>
---
 security/integrity/ima/ima_appraise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a2baa85ea2f5..5fb7127bbe68 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -114,6 +114,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 		break;
 	case CREDS_CHECK:
 		iint->ima_creds_status = status;
+		break;
 	case FILE_CHECK:
 	case POST_SETATTR:
 		iint->ima_file_status = status;
-- 
2.7.5

