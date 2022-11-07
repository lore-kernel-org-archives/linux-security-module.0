Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C02FC433FE
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Nov 2022 01:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiKGBoR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 6 Nov 2022 20:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKGBoO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 Nov 2022 20:44:14 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63CF6D2C3;
        Sun,  6 Nov 2022 17:44:12 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id A7DD11E80D89;
        Mon,  7 Nov 2022 09:41:49 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WwgNVPdpX_TG; Mon,  7 Nov 2022 09:41:47 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9745C1E80D59;
        Mon,  7 Nov 2022 09:41:46 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] integrity: iint: Remove unnecessary (void*) conversions
Date:   Mon,  7 Nov 2022 09:44:02 +0800
Message-Id: <20221107014402.3088-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The iint pointer does not need to cast the type.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 security/integrity/iint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..d66b94c7c8d5 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -160,7 +160,7 @@ void integrity_inode_free(struct inode *inode)
 
 static void init_once(void *foo)
 {
-	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
+	struct integrity_iint_cache *iint = foo;
 
 	memset(iint, 0, sizeof(*iint));
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
-- 
2.18.2

