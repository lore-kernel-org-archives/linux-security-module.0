Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA658C47082
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jun 2021 03:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4AE611C1
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Jun 2021 03:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFGDrh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 6 Jun 2021 23:47:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7124 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhFGDrh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 Jun 2021 23:47:37 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FyzjB70kMzYrmZ;
        Mon,  7 Jun 2021 11:42:54 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 11:45:43 +0800
Received: from huawei.com (10.175.101.6) by dggemi758-chm.china.huawei.com
 (10.1.198.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 11:45:42 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <casey@schaufler-ca.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiaosong2@huawei.com>
Subject: [PATCH -next] Smack: fix doc warning
Date:   Mon, 7 Jun 2021 11:52:01 +0800
Message-ID: <20210607035201.289393-1-chenxiaosong2@huawei.com>
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

Fix gcc W=1 warning:

security/smack/smack_access.c:342: warning: Function parameter or member 'ad' not described in 'smack_log'
security/smack/smack_access.c:403: warning: Function parameter or member 'skp' not described in 'smk_insert_entry'
security/smack/smack_access.c:487: warning: Function parameter or member 'level' not described in 'smk_netlbl_mls'
security/smack/smack_access.c:487: warning: Function parameter or member 'len' not described in 'smk_netlbl_mls'

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 security/smack/smack_access.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index efe2406a3960..1f391f6a3d47 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -332,7 +332,7 @@ static void smack_log_callback(struct audit_buffer *ab, void *a)
  *  @object_label  : smack label of the object being accessed
  *  @request: requested permissions
  *  @result: result from smk_access
- *  @a:  auxiliary audit data
+ *  @ad:  auxiliary audit data
  *
  * Audit the granting or denial of permissions in accordance
  * with the policy.
@@ -396,6 +396,7 @@ struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
 
 /**
  * smk_insert_entry - insert a smack label into a hash map,
+ * @skp: smack label
  *
  * this function must be called under smack_known_lock
  */
@@ -476,8 +477,10 @@ char *smk_parse_smack(const char *string, int len)
 
 /**
  * smk_netlbl_mls - convert a catset to netlabel mls categories
+ * @level: MLS sensitivity level
  * @catset: the Smack categories
  * @sap: where to put the netlabel categories
+ * @len: number of bytes for the levels in a CIPSO IP option
  *
  * Allocates and fills attr.mls
  * Returns 0 on success, error code on failure.
-- 
2.25.4

