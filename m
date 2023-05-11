Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E48FC77B7D
	for <linux-security-module@archiver.kernel.org>; Thu, 11 May 2023 01:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjEKB1V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 May 2023 21:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjEKB1T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 May 2023 21:27:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53094EE8
        for <linux-security-module@vger.kernel.org>; Wed, 10 May 2023 18:27:17 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QGvJs0lWczTkZp;
        Thu, 11 May 2023 09:22:37 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 09:27:15 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <linux-security-module@vger.kernel.org>
Subject: [PATCH -next] capability: fix kernel-doc warnings in capability.c
Date:   Thu, 11 May 2023 09:27:15 +0800
Message-ID: <20230511012715.3692211-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix all kernel-doc warnings in capability.c:

kernel/capability.c:477: warning: Function parameter or member 'idmap'
not described in 'privileged_wrt_inode_uidgid'
kernel/capability.c:493: warning: Function parameter or member 'idmap'
not described in 'capable_wrt_inode_uidgid'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/capability.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/capability.c b/kernel/capability.c
index 3e058f41df32..1a2795102ae4 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -467,6 +467,7 @@ EXPORT_SYMBOL(file_ns_capable);
 /**
  * privileged_wrt_inode_uidgid - Do capabilities in the namespace work over the inode?
  * @ns: The user namespace in question
+ * @idmap: idmap of the mount @inode was found from
  * @inode: The inode in question
  *
  * Return true if the inode uid and gid are within the namespace.
@@ -481,6 +482,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
 
 /**
  * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
+ * @idmap: idmap of the mount @inode was found from
  * @inode: The inode in question
  * @cap: The capability in question
  *
-- 
2.25.1

