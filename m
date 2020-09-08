Return-Path: <SRS0=wBbN=CR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696BC433E2
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Sep 2020 14:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B514621D90
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Sep 2020 14:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgIHORk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Sep 2020 10:17:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729390AbgIHOQY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Sep 2020 10:16:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3615A118C77403F19825;
        Tue,  8 Sep 2020 22:08:27 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 22:08:21 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <paul@paul-moore.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH net-next] netlabel: Fix some kernel-doc warnings
Date:   Tue, 8 Sep 2020 22:05:43 +0800
Message-ID: <20200908140543.25514-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixes the following W=1 kernel build warning(s):

net/netlabel/netlabel_calipso.c:438: warning: Excess function parameter 'audit_secid' description in 'calipso_doi_remove'
net/netlabel/netlabel_calipso.c:605: warning: Excess function parameter 'reg' description in 'calipso_req_delattr'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/netlabel/netlabel_calipso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calipso.c
index 249da67d50a2..1a98247ab148 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -426,7 +426,7 @@ void calipso_doi_free(struct calipso_doi *doi_def)
 /**
  * calipso_doi_remove - Remove an existing DOI from the CALIPSO protocol engine
  * @doi: the DOI value
- * @audit_secid: the LSM secid to use in the audit message
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Removes a DOI definition from the CALIPSO engine.  The NetLabel routines will
@@ -595,7 +595,7 @@ int calipso_req_setattr(struct request_sock *req,
 
 /**
  * calipso_req_delattr - Delete the CALIPSO option from a request socket
- * @reg: the request socket
+ * @req: the request socket
  *
  * Description:
  * Removes the CALIPSO option from a request socket, if present.
-- 
2.17.1

