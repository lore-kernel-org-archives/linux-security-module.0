Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F213C47082
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jun 2021 06:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D57D611BD
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jun 2021 06:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFGGZ5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Jun 2021 02:25:57 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4330 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFGGZ4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Jun 2021 02:25:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fz39X2fBVz1BKBc;
        Mon,  7 Jun 2021 14:19:12 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 14:24:01 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 14:24:00 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <john.johansen@canonical.com>, <jmorris@namei.org>,
        <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiaosong2@huawei.com>
Subject: [PATCH -next] apparmor: fix doc warning
Date:   Mon, 7 Jun 2021 14:30:22 +0800
Message-ID: <20210607063022.329320-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix gcc W=1 warning:

security/apparmor/apparmorfs.c:2125: warning: Function parameter or member 'p' not described in '__next_profile'

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 security/apparmor/apparmorfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 5bb9b9910aee..4720b8b9239c 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2114,7 +2114,7 @@ static struct aa_profile *__first_profile(struct aa_ns *root,
 
 /**
  * __next_profile - step to the next profile in a profile tree
- * @profile: current profile in tree (NOT NULL)
+ * @p: current profile in tree (NOT NULL)
  *
  * Perform a depth first traversal on the profile tree in a namespace
  *
-- 
2.25.4

