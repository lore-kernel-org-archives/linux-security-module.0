Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8D1EB64DD
	for <linux-security-module@archiver.kernel.org>; Sun, 25 Jun 2023 01:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFYBOB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Jun 2023 21:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFYBNz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Jun 2023 21:13:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF13D180
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 18:13:54 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QpXz618rhzTl98;
        Sun, 25 Jun 2023 09:13:06 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 09:13:52 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH -next 08/11] apparmor: Fix kernel-doc warnings in apparmor/resource.c
Date:   Sun, 25 Jun 2023 09:13:46 +0800
Message-ID: <20230625011349.1457810-9-cuigaosheng1@huawei.com>
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

security/apparmor/resource.c:111: warning: Function parameter or
member 'label' not described in 'aa_task_setrlimit'
security/apparmor/resource.c:111: warning: Function parameter or
member 'new_rlim' not described in 'aa_task_setrlimit'
security/apparmor/resource.c:111: warning: Function parameter or
member 'resource' not described in 'aa_task_setrlimit'
security/apparmor/resource.c:111: warning: Function parameter or
member 'task' not described in 'aa_task_setrlimit'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index e85948164896..2bebc5d9e741 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -97,10 +97,10 @@ static int profile_setrlimit(struct aa_profile *profile, unsigned int resource,
 
 /**
  * aa_task_setrlimit - test permission to set an rlimit
- * @label - label confining the task  (NOT NULL)
- * @task - task the resource is being set on
- * @resource - the resource being set
- * @new_rlim - the new resource limit  (NOT NULL)
+ * @label: label confining the task  (NOT NULL)
+ * @task: task the resource is being set on
+ * @resource: the resource being set
+ * @new_rlim: the new resource limit  (NOT NULL)
  *
  * Control raising the processes hard limit.
  *
-- 
2.25.1

