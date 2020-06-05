Return-Path: <SRS0=NT9g=7S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6982C433E0
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 06:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903BB207ED
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 06:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFEGyB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:54:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgFEGyB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Jun 2020 02:54:01 -0400
Received: from lhreml741-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F35C8D45AE4DD2AEB67E;
        Fri,  5 Jun 2020 07:53:59 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 5 Jun 2020 07:53:59 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 5 Jun 2020 08:53:58 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <syzkaller-bugs@googlegroups.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] ima: Directly free *entry in ima_alloc_init_template() if digests is NULL
Date:   Fri, 5 Jun 2020 08:50:28 +0200
Message-ID: <20200605065028.12464-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

To support multiple template digests, the static array entry->digest has
been replaced with a dynamically allocated array in commit aa724fe18a8a
("ima: Switch to dynamically allocated buffer for template digests"). The
array is allocated in ima_alloc_init_template() and if the returned pointer
is NULL, ima_free_template_entry() is called.

However, (*entry)->template_desc is not yet initialized while it is used by
ima_free_template_entry(). This patch fixes the issue by directly freeing
*entry without calling ima_free_template_entry().

Fixes: aa724fe18a8a ("ima: Switch to dynamically allocated buffer for template digests")
Reported-by: syzbot+223310b454ba6b75974e@syzkaller.appspotmail.com
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 78e0b0a7723e..bf22de8b7ce0 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -55,8 +55,9 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 	digests = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
 			  sizeof(*digests), GFP_NOFS);
 	if (!digests) {
-		result = -ENOMEM;
-		goto out;
+		kfree(*entry);
+		*entry = NULL;
+		return -ENOMEM;
 	}
 
 	(*entry)->digests = digests;
-- 
2.17.1

