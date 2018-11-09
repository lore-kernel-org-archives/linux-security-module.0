Return-Path: <SRS0=fuo0=NU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0241CC0044C
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 06:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C506F2086C
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 06:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C506F2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeKIPjO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:39:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727518AbeKIPjO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Nov 2018 10:39:14 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA95wXqL129967
        for <linux-security-module@vger.kernel.org>; Fri, 9 Nov 2018 01:00:14 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nn3vx97rn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 09 Nov 2018 01:00:14 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 9 Nov 2018 06:00:12 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Nov 2018 06:00:09 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA9608tL65273986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 06:00:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCB16A406B;
        Fri,  9 Nov 2018 06:00:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27BE7A4065;
        Fri,  9 Nov 2018 06:00:07 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.106.24])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Nov 2018 06:00:07 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH] KEYS: revert requiring signature "encoding"
Date:   Fri,  9 Nov 2018 00:59:26 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 18110906-0008-0000-0000-00000290013A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110906-0009-0000-0000-000021FA00F8
Message-Id: <1541743166-5036-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811090056
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Attempting to verify IMA signatures fail causing the system to hang.

Fixes: commit 82f94f24475c ("KEYS: Provide software public key query
       function [ver #2]")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 crypto/asymmetric_keys/public_key.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index f5d85b47fcc6..f90360122090 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -239,9 +239,17 @@ int public_key_verify_signature(const struct public_key *pkey,
 	BUG_ON(!sig);
 	BUG_ON(!sig->s);
 
-	ret = software_key_determine_akcipher(sig->encoding,
-					      sig->hash_algo,
-					      pkey, alg_name);
+	if (!sig->digest)
+		return -ENOPKG;
+
+	if (!(sig->encoding) && strcmp(pkey->pkey_algo, "rsa") == 0)
+		ret = software_key_determine_akcipher("pkcs1",
+						      sig->hash_algo,
+						      pkey, alg_name);
+	else
+		ret = software_key_determine_akcipher(sig->encoding,
+						      sig->hash_algo,
+						      pkey, alg_name);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.5

