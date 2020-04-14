Return-Path: <SRS0=Yj31=56=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA37C2BA19
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 11:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A282072D
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 11:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgDNLtO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:49:14 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37041 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728426AbgDNLtM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Apr 2020 07:49:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TvWiAKo_1586864932;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TvWiAKo_1586864932)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Apr 2020 19:48:52 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com
Subject: [PATCH 2/2] ima: simplify function process_buffer_measurement
Date:   Tue, 14 Apr 2020 19:48:50 +0800
Message-Id: <20200414114850.98622-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414114850.98622-1-tianjia.zhang@linux.alibaba.com>
References: <20200414114850.98622-1-tianjia.zhang@linux.alibaba.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Remove duplicate judgment code to make it more suitable for linux
code style.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/integrity/ima/ima_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9d0abedeae77..55cbbe97ce6e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -750,15 +750,15 @@ void process_buffer_measurement(const void *buf, int size,
 		goto out;
 
 	ret = ima_store_template(entry, violation, NULL, buf, pcr);
-
-	if (ret < 0)
-		ima_free_template_entry(entry);
-
-out:
 	if (ret < 0)
-		pr_devel("%s: failed, result: %d\n", __func__, ret);
+		goto out_free_entry;
 
 	return;
+
+out_free_entry:
+	ima_free_template_entry(entry);
+out:
+	pr_devel("%s: failed, result: %d\n", __func__, ret);
 }
 
 /**
-- 
2.17.1

