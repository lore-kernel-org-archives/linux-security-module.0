Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A4BC6FA8E
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Mar 2023 01:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCCB2k (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCCB2k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 20:28:40 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B78173B;
        Thu,  2 Mar 2023 17:28:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vcyz2mq_1677806914;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vcyz2mq_1677806914)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 09:28:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] AppArmor: Fix some kernel-doc comments
Date:   Fri,  3 Mar 2023 09:28:33 +0800
Message-Id: <20230303012833.57690-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make the description of @table to @strs in function unpack_trans_table()
to silence the warnings:

security/apparmor/policy_unpack.c:456: warning: Function parameter or member 'strs' not described in 'unpack_trans_table'
security/apparmor/policy_unpack.c:456: warning: Excess function parameter 'table' description in 'unpack_trans_table'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4332
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index cf2ceec40b28..c3f44f1deb07 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -448,7 +448,7 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e, int flags)
 /**
  * unpack_trans_table - unpack a profile transition table
  * @e: serialized data extent information  (NOT NULL)
- * @table: str table to unpack to (NOT NULL)
+ * @strs: str table to unpack to (NOT NULL)
  *
  * Returns: true if table successfully unpacked or not present
  */
-- 
2.20.1.7.g153144c

