Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764CCC56202
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Nov 2020 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F63E2223C
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Nov 2020 14:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbgKZOeJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Nov 2020 09:34:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7995 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389743AbgKZOeJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Nov 2020 09:34:09 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ChgHH1hXlzhhmV;
        Thu, 26 Nov 2020 22:33:47 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 22:33:56 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <takedakn@nttdata.co.jp>, <penguin-kernel@I-love.SAKURA.ne.jp>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
        <zhengzengkai@huawei.com>
Subject: [PATCH] tomoyo: Fix null pointer check
Date:   Thu, 26 Nov 2020 22:38:15 +0800
Message-ID: <20201126143815.67697-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Since tomoyo_memory_ok() will check for null pointer returned by
kzalloc() in tomoyo_assign_profile(), tomoyo_assign_namespace(),
tomoyo_get_name() and tomoyo_commit_ok(), then emit OOM warnings
if needed. And this is the expected behavior as informed by
Tetsuo Handa.

Let's add __GFP_NOWARN to kzalloc() in those related functions.
Besides, to achieve this goal, remove the null check for entry
right after kzalloc() in tomoyo_assign_namespace().

Fixes: 57c2590fb7fd ("TOMOYO: Update profile structure")
Fixes: bd03a3e4c9a9 ("TOMOYO: Add policy namespace support.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 security/tomoyo/common.c | 2 +-
 security/tomoyo/domain.c | 4 +---
 security/tomoyo/memory.c | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 4bee32bfe16d..bc54d3c8c70a 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -498,7 +498,7 @@ static struct tomoyo_profile *tomoyo_assign_profile
 	ptr = ns->profile_ptr[profile];
 	if (ptr)
 		return ptr;
-	entry = kzalloc(sizeof(*entry), GFP_NOFS);
+	entry = kzalloc(sizeof(*entry), GFP_NOFS | __GFP_NOWARN);
 	if (mutex_lock_interruptible(&tomoyo_policy_lock))
 		goto out;
 	ptr = ns->profile_ptr[profile];
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index dc4ecc0b2038..c6e5cc5cc7cd 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -473,9 +473,7 @@ struct tomoyo_policy_namespace *tomoyo_assign_namespace(const char *domainname)
 		return ptr;
 	if (len >= TOMOYO_EXEC_TMPSIZE - 10 || !tomoyo_domain_def(domainname))
 		return NULL;
-	entry = kzalloc(sizeof(*entry) + len + 1, GFP_NOFS);
-	if (!entry)
-		return NULL;
+	entry = kzalloc(sizeof(*entry) + len + 1, GFP_NOFS | __GFP_NOWARN);
 	if (mutex_lock_interruptible(&tomoyo_policy_lock))
 		goto out;
 	ptr = tomoyo_find_namespace(domainname, len);
diff --git a/security/tomoyo/memory.c b/security/tomoyo/memory.c
index 2e7fcfa923c9..1b570bde7a3b 100644
--- a/security/tomoyo/memory.c
+++ b/security/tomoyo/memory.c
@@ -73,7 +73,7 @@ bool tomoyo_memory_ok(void *ptr)
  */
 void *tomoyo_commit_ok(void *data, const unsigned int size)
 {
-	void *ptr = kzalloc(size, GFP_NOFS);
+	void *ptr = kzalloc(size, GFP_NOFS | __GFP_NOWARN);
 
 	if (tomoyo_memory_ok(ptr)) {
 		memmove(ptr, data, size);
@@ -170,7 +170,7 @@ const struct tomoyo_path_info *tomoyo_get_name(const char *name)
 		atomic_inc(&ptr->head.users);
 		goto out;
 	}
-	ptr = kzalloc(sizeof(*ptr) + len, GFP_NOFS);
+	ptr = kzalloc(sizeof(*ptr) + len, GFP_NOFS | __GFP_NOWARN);
 	if (tomoyo_memory_ok(ptr)) {
 		ptr->entry.name = ((char *) ptr) + sizeof(*ptr);
 		memmove((char *) ptr->entry.name, name, len);
-- 
2.20.1

