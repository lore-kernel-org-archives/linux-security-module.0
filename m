Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A18C0032E
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Oct 2023 00:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjJWAzY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 22 Oct 2023 20:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJWAzY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 22 Oct 2023 20:55:24 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1840B7;
        Sun, 22 Oct 2023 17:55:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuctJle_1698022518;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VuctJle_1698022518)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 08:55:19 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] apparmor: Fix some kernel-doc comments
Date:   Mon, 23 Oct 2023 08:55:17 +0800
Message-Id: <20231023005517.115318-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix some kernel-doc comments to silence the warnings:
security/apparmor/capability.c:66: warning: Function parameter or member 'ad' not described in 'audit_caps'
security/apparmor/capability.c:66: warning: Excess function parameter 'as' description in 'audit_caps'
security/apparmor/capability.c:154: warning: Function parameter or member 'subj_cred' not described in 'aa_capable'
security/apparmor/capability.c:154: warning: Excess function parameter 'subj_cread' description in 'aa_capable'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7035
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/capability.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index 0b7d2b1086c9..9934df16c843 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -51,7 +51,7 @@ static void audit_cb(struct audit_buffer *ab, void *va)
 
 /**
  * audit_caps - audit a capability
- * @as: audit data
+ * @ad: audit data
  * @profile: profile being tested for confinement (NOT NULL)
  * @cap: capability tested
  * @error: error code returned by test
@@ -140,7 +140,7 @@ static int profile_capable(struct aa_profile *profile, int cap,
 
 /**
  * aa_capable - test permission to use capability
- * @subj_cread: cred we are testing capability against
+ * @subj_cred: cred we are testing capability against
  * @label: label being tested for capability (NOT NULL)
  * @cap: capability to be tested
  * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
-- 
2.20.1.7.g153144c

