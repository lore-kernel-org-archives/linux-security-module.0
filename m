Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACC3C6FA82
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 09:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiIWJVX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 05:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIWJVX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 05:21:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFDB10F71E
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 02:21:21 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYmkY2QnXzlXDr;
        Fri, 23 Sep 2022 17:17:09 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:21:18 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v2] apparmor: Simplify obtain the newest label on a cred
Date:   Fri, 23 Sep 2022 17:21:18 +0800
Message-ID: <20220923092118.515552-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In aa_get_task_label(), aa_get_newest_cred_label(__task_cred(task))
can do the same things as aa_get_newest_label(__aa_task_raw_label(task)),
so we can replace it and remove __aa_task_raw_label() to simplify the code.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2:
- Fix the commit message, change simply to simplify. Thanks!
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

