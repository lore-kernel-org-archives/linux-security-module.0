Return-Path: <SRS0=wBbN=CR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F803C433E2
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Sep 2020 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AC12076C
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Sep 2020 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgIHTXl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:23:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731098AbgIHQBZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Sep 2020 12:01:25 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 391D41D57D88F13E8D13;
        Tue,  8 Sep 2020 22:02:04 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 22:01:56 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <paul@paul-moore.com>, <davem@davemloft.net>,
        <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH net-next] cipso: fix 'audit_secid' kernel-doc warning in cipso_ipv4.c
Date:   Tue, 8 Sep 2020 21:59:15 +0800
Message-ID: <20200908135915.22039-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixes the following W=1 kernel build warning(s):

net/ipv4/cipso_ipv4.c:510: warning: Excess function parameter 'audit_secid' description in 'cipso_v4_doi_remove'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/ipv4/cipso_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 2eb71579f4d2..471d33a0d095 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -498,7 +498,7 @@ static void cipso_v4_doi_free_rcu(struct rcu_head *entry)
 /**
  * cipso_v4_doi_remove - Remove an existing DOI from the CIPSO protocol engine
  * @doi: the DOI value
- * @audit_secid: the LSM secid to use in the audit message
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Removes a DOI definition from the CIPSO engine.  The NetLabel routines will
-- 
2.17.1

