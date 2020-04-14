Return-Path: <SRS0=Yj31=56=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E41C2BB85
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 08:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F662074D
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 08:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407063AbgDNINk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:13:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2369 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407062AbgDNINd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Apr 2020 04:13:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28AE9C18D5CA8D2CD2A6;
        Tue, 14 Apr 2020 16:13:31 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 16:13:24 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <takedakn@nttdata.co.jp>, <penguin-kernel@I-love.SAKURA.ne.jp>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] tomoyo: use true for bool variable
Date:   Tue, 14 Apr 2020 16:19:48 +0800
Message-ID: <1586852388-68249-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixes coccicheck warning:

security/tomoyo/common.c:1028:2-13: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 security/tomoyo/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 1b46738..c577525 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -1025,7 +1025,7 @@ static bool tomoyo_select_domain(struct tomoyo_io_buffer *head,
 	if (domain)
 		head->r.domain = &domain->list;
 	else
-		head->r.eof = 1;
+		head->r.eof = true;
 	tomoyo_io_printf(head, "# select %s\n", data);
 	if (domain && domain->is_deleted)
 		tomoyo_io_printf(head, "# This is a deleted domain.\n");
-- 
2.6.2

