Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD87CC43333
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Mar 2021 23:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961FE64F5B
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Mar 2021 23:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCCX7p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Mar 2021 18:59:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13112 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352239AbhCCDaF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Mar 2021 22:30:05 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DqzvL66Bdz16F4S;
        Wed,  3 Mar 2021 11:27:10 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Mar 2021 11:28:45 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dmitry.kasatkin@gmail.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <yangjihong1@huawei.com>,
        <zhangjinhao2@huawei.com>, <lihuafei1@huawei.com>
Subject: [PATCH] ima: Fix the error code for restoring the PCR value
Date:   Wed, 3 Mar 2021 11:28:24 +0800
Message-ID: <20210303032824.124112-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In ima_restore_measurement_list(), hdr[HDR_PCR].data is pointing to a
buffer of type u8, which contains the dumped 32-bit pcr value.
Currently, only the least significant byte is used to restore the pcr
value. We should convert hdr[HDR_PCR].data to a pointer of type u32
before fetching the value to restore the correct pcr value.

Fixes: 47fdee60b47f ("ima: use ima_parse_buf() to parse measurements headers")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 security/integrity/ima/ima_template.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index e22e510ae92d..4e081e650047 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -494,8 +494,8 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 			}
 		}
 
-		entry->pcr = !ima_canonical_fmt ? *(hdr[HDR_PCR].data) :
-			     le32_to_cpu(*(hdr[HDR_PCR].data));
+		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :
+			     le32_to_cpu(*(u32 *)(hdr[HDR_PCR].data));
 		ret = ima_restore_measurement_entry(entry);
 		if (ret < 0)
 			break;
-- 
2.17.1

