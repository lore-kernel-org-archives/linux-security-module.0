Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1D8C47082
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Jun 2021 06:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A7D6121F
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Jun 2021 06:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFEGTG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Jun 2021 02:19:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3064 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGTG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Jun 2021 02:19:06 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fxq6j6pwmzWn6G;
        Sat,  5 Jun 2021 14:12:29 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 14:17:16 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 14:17:16 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] capability: fix doc warnings in capability.c
Date:   Sat, 5 Jun 2021 14:26:02 +0800
Message-ID: <20210605062602.678602-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixes the following W=1 kernel build warning(s):

kernel/capability.c:490: warning: Function parameter or
 member 'mnt_userns' not described in 'privileged_wrt_inode_uidgid'
kernel/capability.c:506: warning: Function parameter or
 member 'mnt_userns' not described in 'capable_wrt_inode_uidgid'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/capability.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/capability.c b/kernel/capability.c
index 46a361dde042..27a959aa897f 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -480,6 +480,7 @@ EXPORT_SYMBOL(file_ns_capable);
 /**
  * privileged_wrt_inode_uidgid - Do capabilities in the namespace work over the inode?
  * @ns: The user namespace in question
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @inode: The inode in question
  *
  * Return true if the inode uid and gid are within the namespace.
@@ -495,6 +496,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
 /**
  * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
  * @inode: The inode in question
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @cap: The capability in question
  *
  * Return true if the current task has the given capability targeted at
-- 
2.31.1

