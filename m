Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F972C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Oct 2022 08:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJNInI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJNInH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Oct 2022 04:43:07 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92C91C39DB;
        Fri, 14 Oct 2022 01:43:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VS755BC_1665736981;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VS755BC_1665736981)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 16:43:02 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] apparmor: Fix spelling of function name in comment block
Date:   Fri, 14 Oct 2022 16:42:55 +0800
Message-Id: <20221014084255.26103-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

'resouce' -> 'resource'

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2396
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index ed543f4edfd9..d7dbacc9a369 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -66,7 +66,7 @@ static int audit_resource(struct aa_profile *profile, unsigned int resource,
 }
 
 /**
- * aa_map_resouce - map compiled policy resource to internal #
+ * aa_map_resource - map compiled policy resource to internal #
  * @resource: flattened policy resource number
  *
  * Returns: resource # for the current architecture.
-- 
2.20.1.7.g153144c

