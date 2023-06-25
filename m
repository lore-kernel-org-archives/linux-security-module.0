Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495BCC0015E
	for <linux-security-module@archiver.kernel.org>; Sun, 25 Jun 2023 01:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjFYBN6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Jun 2023 21:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFYBNy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Jun 2023 21:13:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40ABE54
        for <linux-security-module@vger.kernel.org>; Sat, 24 Jun 2023 18:13:53 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QpXzl6zk7z1HBhd;
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
Subject: [PATCH -next 04/11] apparmor: Fix kernel-doc warnings in apparmor/file.c
Date:   Sun, 25 Jun 2023 09:13:42 +0800
Message-ID: <20230625011349.1457810-5-cuigaosheng1@huawei.com>
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

security/apparmor/file.c:177: warning: Excess function parameter
'dfa' description in 'aa_lookup_fperms'
security/apparmor/file.c:177: warning: Function parameter or member
'file_rules' not described in 'aa_lookup_fperms'
security/apparmor/file.c:202: warning: Excess function parameter
'dfa' description in 'aa_str_perms'
security/apparmor/file.c:202: warning: Excess function parameter
'state' description in 'aa_str_perms'
security/apparmor/file.c:202: warning: Function parameter or member
'file_rules' not described in 'aa_str_perms'
security/apparmor/file.c:202: warning: Function parameter or member
'start' not described in 'aa_str_perms'

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/apparmor/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 698b124e649f..c0fc5e77e889 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -164,7 +164,7 @@ static int path_name(const char *op, struct aa_label *label,
 struct aa_perms default_perms = {};
 /**
  * aa_lookup_fperms - convert dfa compressed perms to internal perms
- * @dfa: dfa to lookup perms for   (NOT NULL)
+ * @file_rules: the aa_policydb to lookup perms for  (NOT NULL)
  * @state: state in dfa
  * @cond:  conditions to consider  (NOT NULL)
  *
@@ -188,8 +188,8 @@ struct aa_perms *aa_lookup_fperms(struct aa_policydb *file_rules,
 
 /**
  * aa_str_perms - find permission that match @name
- * @dfa: to match against  (MAYBE NULL)
- * @state: state to start matching in
+ * @file_rules: the aa_policydb to match against  (NOT NULL)
+ * @start: state to start matching in
  * @name: string to match against dfa  (NOT NULL)
  * @cond: conditions to consider for permission set computation  (NOT NULL)
  * @perms: Returns - the permissions found when matching @name
-- 
2.25.1

