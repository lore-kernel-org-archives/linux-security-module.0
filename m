Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA3EEB64DA
	for <linux-security-module@archiver.kernel.org>; Sun, 25 Jun 2023 01:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjFYBN7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Jun 2023 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFYBNz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Jun 2023 21:13:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B9BB8
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 18:13:54 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QpXz53YdYzTkfy;
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
Subject: [PATCH -next 06/11] apparmor: Fix kernel-doc warnings in apparmor/lib.c
Date:   Sun, 25 Jun 2023 09:13:44 +0800
Message-ID: <20230625011349.1457810-7-cuigaosheng1@huawei.com>
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

security/apparmor/lib.c:33: warning: Excess function parameter
'str' description in 'aa_free_str_table'
security/apparmor/lib.c:33: warning: Function parameter or member
't' not described in 'aa_free_str_table'
security/apparmor/lib.c:94: warning: Function parameter or
member 'n' not described in 'skipn_spaces'
security/apparmor/lib.c:390: warning: Excess function parameter
'deny' description in 'aa_check_perms'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index a630c951bb3b..8e1073477c09 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -27,7 +27,7 @@ struct aa_perms allperms = { .allow = ALL_PERMS_MASK,
 
 /**
  * aa_free_str_table - free entries str table
- * @str: the string table to free  (MAYBE NULL)
+ * @t: the string table to free  (MAYBE NULL)
  */
 void aa_free_str_table(struct aa_str_table *t)
 {
@@ -85,6 +85,7 @@ char *aa_split_fqname(char *fqname, char **ns_name)
 /**
  * skipn_spaces - Removes leading whitespace from @str.
  * @str: The string to be stripped.
+ * @n: length of str to parse, will stop at \0 if encountered before n
  *
  * Returns a pointer to the first non-whitespace character in @str.
  * if all whitespace will return NULL
@@ -371,7 +372,6 @@ int aa_profile_label_perm(struct aa_profile *profile, struct aa_profile *target,
  * @profile: profile being checked
  * @perms: perms computed for the request
  * @request: requested perms
- * @deny: Returns: explicit deny set
  * @sa: initialized audit structure (MAY BE NULL if not auditing)
  * @cb: callback fn for type specific fields (MAY BE NULL)
  *
-- 
2.25.1

