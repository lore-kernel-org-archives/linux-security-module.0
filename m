Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CA6EB64DC
	for <linux-security-module@archiver.kernel.org>; Sun, 25 Jun 2023 01:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjFYBN7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Jun 2023 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFYBNz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Jun 2023 21:13:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ABE10EA
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 18:13:54 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QpXz55rw9zTkxp;
        Sun, 25 Jun 2023 09:13:05 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 09:13:52 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next 07/11] apparmor: Fix kernel-doc warnings in apparmor/match.c
Date:   Sun, 25 Jun 2023 09:13:45 +0800
Message-ID: <20230625011349.1457810-8-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230625011349.1457810-1-cuigaosheng1@huawei.com>
References: <20230625011349.1457810-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix kernel-doc warnings:

security/apparmor/match.c:148: warning: Function parameter or member
'tables' not described in 'verify_table_headers'
security/apparmor/match.c:289: warning: Excess function parameter
'kr' description in 'aa_dfa_free_kref'
security/apparmor/match.c:289: warning: Function parameter or member
'kref' not described in 'aa_dfa_free_kref'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/match.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index b97ef5e1db73..7bdcca2aed7d 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -136,7 +136,7 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
 
 /**
  * verify_table_headers - verify that the tables headers are as expected
- * @tables - array of dfa tables to check (NOT NULL)
+ * @tables: array of dfa tables to check (NOT NULL)
  * @flags: flags controlling what type of accept table are acceptable
  *
  * Assumes dfa has gone through the first pass verification done by unpacking
@@ -283,7 +283,7 @@ static void dfa_free(struct aa_dfa *dfa)
 
 /**
  * aa_dfa_free_kref - free aa_dfa by kref (called by aa_put_dfa)
- * @kr: kref callback for freeing of a dfa  (NOT NULL)
+ * @kref: kref callback for freeing of a dfa  (NOT NULL)
  */
 void aa_dfa_free_kref(struct kref *kref)
 {
-- 
2.25.1

