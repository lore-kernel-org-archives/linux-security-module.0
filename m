Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B541C04A95
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Sep 2022 02:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiIZC2o (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 25 Sep 2022 22:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiIZC2n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 25 Sep 2022 22:28:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580DC27B35
        for <linux-security-module@vger.kernel.org>; Sun, 25 Sep 2022 19:28:42 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbRQL6XCjzHtjK;
        Mon, 26 Sep 2022 10:23:54 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 10:28:40 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH] apparmor: remove useless static inline functions
Date:   Mon, 26 Sep 2022 10:28:39 +0800
Message-ID: <20220926022839.1504520-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Remove the following useless static inline functions:

1. label_is_visible() is a static function in
security/apparmor/label.c, and it's not used, aa_ns_visible()
can do the same things as it, so it's redundant.

2. is_deleted() is a static function in security/apparmor/file.c,
and it's not used since commit aebd873e8d3e ("apparmor: refactor
path name lookup and permission checks around labels"), so it's
redundant.

They are redundant, so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/file.c  | 13 -------------
 security/apparmor/label.c |  6 ------
 2 files changed, 19 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index e1b7e93602e4..ee43c48b9c3f 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -141,19 +141,6 @@ int aa_audit_file(struct aa_profile *profile, struct aa_perms *perms,
 	return aa_audit(type, profile, &sa, file_audit_cb);
 }
 
-/**
- * is_deleted - test if a file has been completely unlinked
- * @dentry: dentry of file to test for deletion  (NOT NULL)
- *
- * Returns: true if deleted else false
- */
-static inline bool is_deleted(struct dentry *dentry)
-{
-	if (d_unlinked(dentry) && d_backing_inode(dentry)->i_nlink == 0)
-		return true;
-	return false;
-}
-
 static int path_name(const char *op, struct aa_label *label,
 		     const struct path *path, int flags, char *buffer,
 		     const char **name, struct path_cond *cond, u32 request)
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 0f36ee907438..cd2d0242df91 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1254,12 +1254,6 @@ struct aa_label *aa_label_merge(struct aa_label *a, struct aa_label *b,
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
2.25.1

