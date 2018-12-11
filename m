Return-Path: <SRS0=nZhg=OU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBE3C67839
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 08:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC6A20849
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Dec 2018 08:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC6A20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeLKIbp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:31:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbeLKIbp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Dec 2018 03:31:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE73CAF09;
        Tue, 11 Dec 2018 08:31:43 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     zohar@linux.vnet.ibm.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] ima: Use inode_is_open_for_write
Date:   Tue, 11 Dec 2018 10:31:40 +0200
Message-Id: <20181211083140.21430-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use the aptly named function rather than open coding the check. No
functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1b88d58e1325..05fbf8a2fa42 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -103,7 +103,7 @@ static void ima_rdwr_violation_check(struct file *file,
 	} else {
 		if (must_measure)
 			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
-		if ((atomic_read(&inode->i_writecount) > 0) && must_measure)
+		if (inode_is_open_for_write(inode) && must_measure)
 			send_writers = true;
 	}
 
-- 
2.17.1

