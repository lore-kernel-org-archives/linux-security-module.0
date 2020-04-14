Return-Path: <SRS0=Yj31=56=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19678C2BA19
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 11:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D40206D5
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 11:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439607AbgDNLtQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:49:16 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:49953 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729470AbgDNLtP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Apr 2020 07:49:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TvX41bQ_1586864931;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TvX41bQ_1586864931)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Apr 2020 19:48:52 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com
Subject: [PATCH 1/2] ima: simplify function ima_store_template
Date:   Tue, 14 Apr 2020 19:48:49 +0800
Message-Id: <20200414114850.98622-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414114850.98622-1-tianjia.zhang@linux.alibaba.com>
References: <20200414114850.98622-1-tianjia.zhang@linux.alibaba.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The 'result' here is not necessary, remove redundant code,
the code is more concise.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/integrity/ima/ima_api.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index f6bc00914aa5..9121257c9dc6 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -118,8 +118,7 @@ int ima_store_template(struct ima_template_entry *entry,
 		memcpy(entry->digest, hash.hdr.digest, hash.hdr.length);
 	}
 	entry->pcr = pcr;
-	result = ima_add_template_entry(entry, violation, op, inode, filename);
-	return result;
+	return ima_add_template_entry(entry, violation, op, inode, filename);
 }
 
 /*
-- 
2.17.1

