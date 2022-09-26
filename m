Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC24FC6FA86
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Sep 2022 14:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIZOYS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiIZOX4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Sep 2022 10:23:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930BA16586
        for <linux-security-module@vger.kernel.org>; Mon, 26 Sep 2022 05:34:45 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MbgvN3XlrzHqHS;
        Mon, 26 Sep 2022 19:46:24 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 19:48:39 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <cuigaosheng1@huawei.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH] apparmor: fix obsoleted comments for aa_getprocattr() and audit_resource()
Date:   Mon, 26 Sep 2022 19:48:38 +0800
Message-ID: <20220926114838.1699096-1-cuigaosheng1@huawei.com>
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

Update the comments for aa_getprocattr() and audit_resource(), the
args of them have beed changed since commit 76a1d263aba3 ("apparmor:
switch getprocattr to using label_print fns()").

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/procattr.c | 11 +++++------
 security/apparmor/resource.c |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index 86ad26ef72ed..197d41f9c32b 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -17,14 +17,13 @@
 
 
 /**
- * aa_getprocattr - Return the profile information for @profile
- * @profile: the profile to print profile info about  (NOT NULL)
- * @string: Returns - string containing the profile info (NOT NULL)
+ * aa_getprocattr - Return the label information for @label
+ * @label: the label to print label info about  (NOT NULL)
+ * @string: Returns - string containing the label info (NOT NULL)
  *
- * Requires: profile != NULL
+ * Requires: label != NULL && string != NULL
  *
- * Creates a string containing the namespace_name://profile_name for
- * @profile.
+ * Creates a string containing the label information for @label.
  *
  * Returns: size of string placed in @string else error code on failure
  */
diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index 1ae4874251a9..4c1869bb31ec 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -45,6 +45,8 @@ static void audit_cb(struct audit_buffer *ab, void *va)
  * @profile: profile being enforced  (NOT NULL)
  * @resource: rlimit being auditing
  * @value: value being set
+ * @peer: aa_albel of the task being set
+ * @info: info being auditing
  * @error: error value
  *
  * Returns: 0 or sa->error else other error code on failure
-- 
2.25.1

