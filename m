Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A483C47082
	for <linux-security-module@archiver.kernel.org>; Sat, 29 May 2021 08:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AA46128D
	for <linux-security-module@archiver.kernel.org>; Sat, 29 May 2021 08:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhE2Imh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 29 May 2021 04:42:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2529 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhE2Imf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 29 May 2021 04:42:35 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsZh86Vl5zYr3L;
        Sat, 29 May 2021 16:38:16 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 16:40:58 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 16:40:58 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-security-module@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] apparmor: Remove the repeated declaration
Date:   Sat, 29 May 2021 16:40:48 +0800
Message-ID: <1622277648-27803-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Function 'aa_labelset_destroy' and 'aa_labelset_init' are declared
twice, so remove the repeated declaration and unnecessary blank line.

Cc: John Johansen <john.johansen@canonical.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 security/apparmor/include/label.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 1e90384b1523..18b290f73b8b 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -77,10 +77,6 @@ struct aa_labelset {
 #define __labelset_for_each(LS, N) \
 	for ((N) = rb_first(&(LS)->root); (N); (N) = rb_next(N))
 
-void aa_labelset_destroy(struct aa_labelset *ls);
-void aa_labelset_init(struct aa_labelset *ls);
-
-
 enum label_flags {
 	FLAG_HAT = 1,			/* profile is a hat */
 	FLAG_UNCONFINED = 2,		/* label unconfined only if all */
-- 
2.7.4

