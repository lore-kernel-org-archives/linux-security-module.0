Return-Path: <SRS0=SHQt=5T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E101DC43331
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Apr 2020 06:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC44206E9
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Apr 2020 06:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgDCGTd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:19:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730889AbgDCGTd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Apr 2020 02:19:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0461C8CD493A6EBC2088;
        Fri,  3 Apr 2020 14:17:29 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Apr 2020
 14:17:21 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] integrity: make integrity_add_key() static
Date:   Fri, 3 Apr 2020 14:15:57 +0800
Message-ID: <20200403061557.19630-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix the following sparse warning:

security/integrity/digsig.c:145:12: warning: symbol 'integrity_add_key'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 security/integrity/digsig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e9cbadade74b..8cdda97bd196 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -142,8 +142,8 @@ int __init integrity_init_keyring(const unsigned int id)
 	return __integrity_init_keyring(id, perm, restriction);
 }
 
-int __init integrity_add_key(const unsigned int id, const void *data,
-			     off_t size, key_perm_t perm)
+static int __init integrity_add_key(const unsigned int id, const void *data,
+				    off_t size, key_perm_t perm)
 {
 	key_ref_t key;
 	int rc = 0;
-- 
2.17.2

