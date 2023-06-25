Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E5FC001B1
	for <linux-security-module@archiver.kernel.org>; Sun, 25 Jun 2023 01:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjFYBN6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Jun 2023 21:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjFYBNz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Jun 2023 21:13:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455310E9
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 18:13:53 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QpXzl59dlz1HBhK;
        Sun, 25 Jun 2023 09:13:39 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 09:13:51 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next 03/11] apparmor: Fix kernel-doc warnings in apparmor/domain.c
Date:   Sun, 25 Jun 2023 09:13:41 +0800
Message-ID: <20230625011349.1457810-4-cuigaosheng1@huawei.com>
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

security/apparmor/domain.c:279: warning: Function parameter or
member 'perms' not described in 'change_profile_perms'
security/apparmor/domain.c:380: warning: Function parameter or
member 'bprm' not described in 'find_attach'
security/apparmor/domain.c:380: warning: Function parameter or
member 'head' not described in 'find_attach'
security/apparmor/domain.c:380: warning: Function parameter or
member 'info' not described in 'find_attach'
security/apparmor/domain.c:380: warning: Function parameter or
member 'name' not described in 'find_attach'
security/apparmor/domain.c:558: warning: Function parameter or
member 'info' not described in 'x_to_label'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/domain.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 68598557aef5..7f81502019da 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -265,6 +265,7 @@ static int label_match(struct aa_profile *profile, struct aa_label *label,
  * @stack: whether this is a stacking request
  * @request: requested perms
  * @start: state to start matching in
+ * @perms: Returns computed perms (NOT NULL)
  *
  *
  * Returns: permission set
@@ -359,11 +360,11 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 
 /**
  * find_attach - do attachment search for unconfined processes
- * @bprm - binprm structure of transitioning task
+ * @bprm: binprm structure of transitioning task
  * @ns: the current namespace  (NOT NULL)
- * @head - profile list to walk  (NOT NULL)
- * @name - to match against  (NOT NULL)
- * @info - info message if there was an error (NOT NULL)
+ * @head: profile list to walk  (NOT NULL)
+ * @name: to match against  (NOT NULL)
+ * @info: info message if there was an error (NOT NULL)
  *
  * Do a linear search on the profiles in the list.  There is a matching
  * preference where an exact match is preferred over a name which uses
@@ -545,6 +546,7 @@ struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex,
  * @name: name to lookup (NOT NULL)
  * @xindex: index into x transition table
  * @lookupname: returns: name used in lookup if one was specified (NOT NULL)
+ * @info: info message if there was an error (NOT NULL)
  *
  * find label for a transition index
  *
-- 
2.25.1

