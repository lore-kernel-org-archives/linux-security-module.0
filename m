Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34642C47094
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 07:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F855613C8
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 07:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhFJHok (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:44:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9060 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHoj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jun 2021 03:44:39 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0wqC69m8zYrLt;
        Thu, 10 Jun 2021 15:39:51 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 15:42:42 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 15:42:41 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <takedakn@nttdata.co.jp>, <penguin-kernel@I-love.SAKURA.ne.jp>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiaosong2@huawei.com>
Subject: [PATCH -next] tomoyo: fix doc warnings
Date:   Thu, 10 Jun 2021 15:49:00 +0800
Message-ID: <20210610074900.58736-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemi758-chm.china.huawei.com (10.1.198.144)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix gcc W=1 warnings:

security/tomoyo/audit.c:331: warning: Function parameter or member 'matched_acl' not described in 'tomoyo_get_audit'
security/tomoyo/securityfs_if.c:146: warning: Function parameter or member 'inode' not described in 'tomoyo_release'
security/tomoyo/tomoyo.c:122: warning: Function parameter or member 'path' not described in 'tomoyo_inode_getattr'
security/tomoyo/tomoyo.c:497: warning: Function parameter or member 'clone_flags' not described in 'tomoyo_task_alloc'
security/tomoyo/util.c:92: warning: Function parameter or member 'time64' not described in 'tomoyo_convert_time'

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 security/tomoyo/audit.c         | 1 +
 security/tomoyo/securityfs_if.c | 1 +
 security/tomoyo/tomoyo.c        | 5 ++---
 security/tomoyo/util.c          | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/tomoyo/audit.c b/security/tomoyo/audit.c
index b51bad121c11..d79bf07e16be 100644
--- a/security/tomoyo/audit.c
+++ b/security/tomoyo/audit.c
@@ -320,6 +320,7 @@ static unsigned int tomoyo_log_count;
  * @ns:          Pointer to "struct tomoyo_policy_namespace".
  * @profile:     Profile number.
  * @index:       Index number of functionality.
+ * @matched_acl: Pointer to "struct tomoyo_acl_info".
  * @is_granted:  True if granted log, false otherwise.
  *
  * Returns true if this request should be audited, false otherwise.
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 065f4941c4d8..a2705798476f 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -139,6 +139,7 @@ static int tomoyo_open(struct inode *inode, struct file *file)
 /**
  * tomoyo_release - close() for /sys/kernel/security/tomoyo/ interface.
  *
+ * @inode: Pointer to "struct inode".
  * @file:  Pointer to "struct file".
  *
  */
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 1f3cd432d830..b7d484b43054 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -113,8 +113,7 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 /**
  * tomoyo_inode_getattr - Target for security_inode_getattr().
  *
- * @mnt:    Pointer to "struct vfsmount".
- * @dentry: Pointer to "struct dentry".
+ * @path:    Pointer to "struct path".
  *
  * Returns 0 on success, negative value otherwise.
  */
@@ -488,7 +487,7 @@ struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init = {
  * tomoyo_task_alloc - Target for security_task_alloc().
  *
  * @task:  Pointer to "struct task_struct".
- * @flags: clone() flags.
+ * @clone_flags: clone() flags.
  *
  * Returns 0.
  */
diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index e89cac913583..84d6ba8ba8b9 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -83,7 +83,7 @@ const u8 tomoyo_index2category[TOMOYO_MAX_MAC_INDEX] = {
 /**
  * tomoyo_convert_time - Convert time_t to YYYY/MM/DD hh/mm/ss.
  *
- * @time:  Seconds since 1970/01/01 00:00:00.
+ * @time64:  Seconds since 1970/01/01 00:00:00.
  * @stamp: Pointer to "struct tomoyo_time".
  *
  * Returns nothing.
-- 
2.25.4

