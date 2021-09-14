Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268EAC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AD16113B
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 09:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhINJyh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:54:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9040 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhINJyd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 05:54:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7zCg1fbPzVwhs;
        Tue, 14 Sep 2021 17:52:15 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 17:53:14 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 14
 Sep 2021 17:53:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <john.johansen@canonical.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <trix@redhat.com>, <yuehaibing@huawei.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] apparmor: Remove unused inline function label_is_visible()
Date:   Tue, 14 Sep 2021 17:53:12 +0800
Message-ID: <20210914095313.11496-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/apparmor/label.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 6222fdfebe4e..a86ac938ca88 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1255,12 +1255,6 @@ struct aa_label *aa_label_merge(struct aa_label *a, struct aa_label *b,
 	return label;
 }
 
-static inline bool label_is_visible(struct aa_profile *profile,
-				    struct aa_label *label)
-{
-	return aa_ns_visible(profile->ns, labels_ns(label), true);
-}
-
 /* match a profile and its associated ns component if needed
  * Assumes visibility test has already been done.
  * If a subns profile is not to be matched should be prescreened with
-- 
2.17.1

