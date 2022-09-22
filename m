Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366BCC32771
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Sep 2022 03:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiIVDAa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Sep 2022 23:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIVDA3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Sep 2022 23:00:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E626716E
        for <linux-security-module@vger.kernel.org>; Wed, 21 Sep 2022 20:00:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MY0Km34GCzWgrl;
        Thu, 22 Sep 2022 10:56:28 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 11:00:24 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH] apparmor: Simply obtain the newest label on a cred
Date:   Thu, 22 Sep 2022 11:00:24 +0800
Message-ID: <20220922030024.1282700-1-cuigaosheng1@huawei.com>
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

aa_get_newest_cred_label(__task_cred(task)) can do the same things as
aa_get_newest_label(__aa_task_raw_label(task)), so we can replace it
and remove __aa_task_raw_label() to simply code.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/include/cred.h | 13 -------------
 security/apparmor/task.c         |  2 +-
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index 0b9ae4804ef7..58fdc72af664 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -63,19 +63,6 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
 	return aa_get_newest_label(aa_cred_raw_label(cred));
 }
 
-/**
- * __aa_task_raw_label - retrieve another task's label
- * @task: task to query  (NOT NULL)
- *
- * Returns: @task's label without incrementing its ref count
- *
- * If @task != current needs to be called in RCU safe critical section
- */
-static inline struct aa_label *__aa_task_raw_label(struct task_struct *task)
-{
-	return aa_cred_raw_label(__task_cred(task));
-}
-
 /**
  * aa_current_raw_label - find the current tasks confining label
  *
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index 503dc0877fb1..0a8f9fa7ca0a 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -31,7 +31,7 @@ struct aa_label *aa_get_task_label(struct task_struct *task)
 	struct aa_label *p;
 
 	rcu_read_lock();
-	p = aa_get_newest_label(__aa_task_raw_label(task));
+	p = aa_get_newest_cred_label(__task_cred(task));
 	rcu_read_unlock();
 
 	return p;
-- 
2.25.1

