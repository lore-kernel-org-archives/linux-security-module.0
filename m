Return-Path: <SRS0=WgAi=AD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F22C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jun 2020 23:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995642075A
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jun 2020 23:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgFVXOP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:14:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730985AbgFVXOO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 19:14:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MN1AJi056068;
        Mon, 22 Jun 2020 19:14:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31tyrxk9fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 19:14:00 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05MN1v4N059847;
        Mon, 22 Jun 2020 19:13:59 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31tyrxk9ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 19:13:59 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05MMk4Zo005614;
        Mon, 22 Jun 2020 22:49:00 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 31sa38jynt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 22:49:00 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05MMmxx528770752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 22:48:59 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82C77C6055;
        Mon, 22 Jun 2020 22:48:59 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A083C6057;
        Mon, 22 Jun 2020 22:48:58 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.160.111.155])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jun 2020 22:48:58 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     zohar@linux.ibm.com
Cc:     Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, maurizio.drocco@ibm.com,
        mdrocco@linux.vnet.ibm.com, roberto.sassu@huawei.com,
        serge@hallyn.com
Subject: [PATCH] ima: extend boot_aggregate with kernel measurements
Date:   Mon, 22 Jun 2020 00:50:19 -0400
Message-Id: <20200622045019.1636-1-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1592856871.4987.21.camel@linux.ibm.com>
References: <1592856871.4987.21.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_15:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 cotscore=-2147483648 suspectscore=1 mlxlogscore=999 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220148
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

IMA is not considering TPM registers 8-9 when calculating the boot
aggregate. When registers 8-9 are used to store measurements of the
kernel and its command line (e.g., grub2 bootloader with tpm module
enabled), IMA should include them in the boot aggregate. Registers
8-9 are only included in non-SHA1 boot_aggregate digests to avoid
ambiguity.

Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
---
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df93ac258e01..9d94080bdad8 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -30,7 +30,7 @@
 
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
-enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
+enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 /* digest size for IMA, fits SHA1 or MD5 */
 #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 220b14920c37..d02917d85033 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -823,13 +823,26 @@ static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
 	if (rc != 0)
 		return rc;
 
-	/* cumulative sha1 over tpm registers 0-7 */
+	/* cumulative digest over tpm registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);
 		/* now accumulate with current aggregate */
 		rc = crypto_shash_update(shash, d.digest,
 					 crypto_shash_digestsize(tfm));
 	}
+	/*
+	 * extend cumulative digest over tpm registers 8-9, which contain
+	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
+	 * in a typical PCR allocation. Registers 8-9 are only included in
+	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
+	 */
+	if (alg_id != TPM_ALG_SHA1) {
+		for (i = TPM_PCR8; i < TPM_PCR10; i++) {
+			ima_pcrread(i, &d);
+			rc = crypto_shash_update(shash, d.digest,
+						crypto_shash_digestsize(tfm));
+		}
+	}
 	if (!rc)
 		crypto_shash_final(shash, digest);
 	return rc;
-- 
2.17.1

