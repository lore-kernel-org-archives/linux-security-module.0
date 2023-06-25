Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D01FEB64DA
	for <linux-security-module@archiver.kernel.org>; Sun, 25 Jun 2023 01:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjFYBOK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Jun 2023 21:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjFYBNz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Jun 2023 21:13:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB0E54
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 18:13:55 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QpXz62m7JzTlBq;
        Sun, 25 Jun 2023 09:13:06 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 09:13:53 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next 09/11] apparmor: Fix kernel-doc warnings in apparmor/policy_unpack.c
Date:   Sun, 25 Jun 2023 09:13:47 +0800
Message-ID: <20230625011349.1457810-10-cuigaosheng1@huawei.com>
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

security/apparmor/policy_unpack.c:1173: warning: Function parameter
or member 'table_size' not described in 'verify_dfa_accept_index'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 694fb7a09962..d2d740bb5618 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1167,7 +1167,7 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
 /**
  * verify_dfa_accept_index - verify accept indexes are in range of perms table
  * @dfa: the dfa to check accept indexes are in range
- * table_size: the permission table size the indexes should be within
+ * @table_size: the permission table size the indexes should be within
  */
 static bool verify_dfa_accept_index(struct aa_dfa *dfa, int table_size)
 {
-- 
2.25.1

