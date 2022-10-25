Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F3EC38A2D
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Oct 2022 13:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiJYNeF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiJYNeB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Oct 2022 09:34:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCBB1905C7
        for <linux-security-module@vger.kernel.org>; Tue, 25 Oct 2022 06:34:00 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxXr952SjzpTx1;
        Tue, 25 Oct 2022 21:30:33 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 21:33:58 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <serge@hallyn.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <ebiederm@xmission.com>, <brauner@kernel.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-security-module@vger.kernel.org>
Subject: [PATCH v2] security: commoncap: fix potential memleak on error path from vfs_getxattr_alloc
Date:   Tue, 25 Oct 2022 21:33:57 +0800
Message-ID: <20221025133357.2404086-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In cap_inode_getsecurity(), we will use vfs_getxattr_alloc() to
complete the memory allocation of tmpbuf, if we have completed
the memory allocation of tmpbuf, but failed to call handler->get(...),
there will be a memleak in below logic:

  |-- ret = (int)vfs_getxattr_alloc(mnt_userns, ...)  <-- alloc for tmpbuf
    |-- value = krealloc(*xattr_value, error + 1, flags)  <-- alloc memory
    |-- error = handler->get(handler, ...)  <-- if error
    |-- *xattr_value = value <-- xattr_value is &tmpbuf  <-- memory leak

So we will try to free(tmpbuf) after vfs_getxattr_alloc() fails to fix it.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2:
- Update the Fixes tag, from 71bc356f93a1 to 8db6c34f1dbc. Thanks!
 security/commoncap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 5fc8986c3c77..bc751fa5adad 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -401,8 +401,10 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 				      &tmpbuf, size, GFP_NOFS);
 	dput(dentry);
 
-	if (ret < 0 || !tmpbuf)
-		return ret;
+	if (ret < 0 || !tmpbuf) {
+		size = ret;
+		goto out_free;
+	}
 
 	fs_ns = inode->i_sb->s_user_ns;
 	cap = (struct vfs_cap_data *) tmpbuf;
-- 
2.25.1

