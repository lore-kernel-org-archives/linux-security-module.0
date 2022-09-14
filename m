Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D67FECAAD3
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Sep 2022 07:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiINHtu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Sep 2022 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiINHtt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Sep 2022 03:49:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB746353
        for <linux-security-module@vger.kernel.org>; Wed, 14 Sep 2022 00:49:47 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MSC7B06xcz14QPP;
        Wed, 14 Sep 2022 15:45:42 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 15:49:39 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH] apparmor: make __aa_path_perm() static
Date:   Wed, 14 Sep 2022 15:46:07 +0800
Message-ID: <20220914074607.194838-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make __aa_path_perm() static as it's only used inside apparmor/file.c.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/apparmor/file.c         | 6 +++---
 security/apparmor/include/file.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index e1b7e93602e4..14f7d7ef3f54 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -265,9 +265,9 @@ unsigned int aa_str_perms(struct aa_dfa *dfa, unsigned int start,
 	return state;
 }
 
-int __aa_path_perm(const char *op, struct aa_profile *profile, const char *name,
-		   u32 request, struct path_cond *cond, int flags,
-		   struct aa_perms *perms)
+static int __aa_path_perm(const char *op, struct aa_profile *profile, const char *name,
+			  u32 request, struct path_cond *cond, int flags,
+			  struct aa_perms *perms)
 {
 	int e = 0;
 
diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 029cb20e322d..17dca3502230 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -189,9 +189,6 @@ unsigned int aa_str_perms(struct aa_dfa *dfa, unsigned int start,
 			  const char *name, struct path_cond *cond,
 			  struct aa_perms *perms);
 
-int __aa_path_perm(const char *op, struct aa_profile *profile,
-		   const char *name, u32 request, struct path_cond *cond,
-		   int flags, struct aa_perms *perms);
 int aa_path_perm(const char *op, struct aa_label *label,
 		 const struct path *path, int flags, u32 request,
 		 struct path_cond *cond);
-- 
2.17.1

