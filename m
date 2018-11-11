Return-Path: <SRS0=IVjV=NW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FB6C43441
	for <linux-security-module@archiver.kernel.org>; Sun, 11 Nov 2018 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1A621104
	for <linux-security-module@archiver.kernel.org>; Sun, 11 Nov 2018 14:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1A621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeKLATQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:19:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728270AbeKLATQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 11 Nov 2018 19:19:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABET7Xt087498
        for <linux-security-module@vger.kernel.org>; Sun, 11 Nov 2018 09:30:32 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdfd8nxr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Sun, 11 Nov 2018 09:30:32 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 11 Nov 2018 14:30:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 14:30:28 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABEUR5n18940070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 14:30:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46BA4A4057;
        Sun, 11 Nov 2018 14:30:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B06DA404D;
        Sun, 11 Nov 2018 14:30:26 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.88.36])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 14:30:26 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] integrity: support new struct public_key_signature encoding field
Date:   Sun, 11 Nov 2018 09:29:53 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 18111114-0008-0000-0000-000002911242
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111114-0009-0000-0000-000021FB1961
Message-Id: <1541946593-4812-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110139
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On systems with IMA-appraisal enabled with a policy requiring file
signatures, the "good" signature values are stored on the filesystem as
extended attributes (security.ima).  Signature verification failure
would normally be limited to just a particular file (eg. executable),
but during boot signature verification failure could result in a system
hang.

Defining and requiring a new public_key_signature field requires all
callers of asymmetric signature verification to be updated to reflect
the change.  This patch updates the integrity asymmetric_verify()
caller.

Fixes: 82f94f24475c ("KEYS: Provide software public key query function [ver #2]")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Denis Kenzior <denkenz@gmail.com>
---
 security/integrity/digsig_asymmetric.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 6dc075144508..d775e03fbbcc 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -106,6 +106,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 
 	pks.pkey_algo = "rsa";
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
+	pks.encoding = "pkcs1";
 	pks.digest = (u8 *)data;
 	pks.digest_size = datalen;
 	pks.s = hdr->sig;
-- 
2.7.5

