Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D1BC43217
	for <linux-security-module@archiver.kernel.org>; Sat,  8 Oct 2022 06:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJHGez (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 8 Oct 2022 02:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJHGey (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 8 Oct 2022 02:34:54 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2322C1A205;
        Fri,  7 Oct 2022 23:34:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VRZfq31_1665210882;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VRZfq31_1665210882)
          by smtp.aliyun-inc.com;
          Sat, 08 Oct 2022 14:34:45 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 3/3] AppArmor: Fix kernel-doc
Date:   Sat,  8 Oct 2022 14:34:11 +0800
Message-Id: <20221008063411.14829-3-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20221008063411.14829-1-jiapeng.chong@linux.alibaba.com>
References: <20221008063411.14829-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

security/apparmor/ipc.c:53: warning: expecting prototype for audit_cb(). Prototype was for audit_signal_cb() instead.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2337
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 security/apparmor/ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
index 1d4099385bdf..5acde746775f 100644
--- a/security/apparmor/ipc.c
+++ b/security/apparmor/ipc.c
@@ -45,7 +45,7 @@ static const char *audit_signal_mask(u32 mask)
 }
 
 /**
- * audit_cb - call back for signal specific audit fields
+ * audit_signal_cb() - call back for signal specific audit fields
  * @ab: audit_buffer  (NOT NULL)
  * @va: audit struct to audit values of  (NOT NULL)
  */
-- 
2.20.1.7.g153144c

