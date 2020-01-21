Return-Path: <SRS0=nZVu=3K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373D0C2D0CE
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jan 2020 08:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1738D24125
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Jan 2020 08:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAUIuI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:50:08 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59121 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729260AbgAUIuH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Jan 2020 03:50:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToHXclo_1579596605;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHXclo_1579596605)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:50:05 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: remove EARLY_LSM_COUNT which never used
Date:   Tue, 21 Jan 2020 16:50:03 +0800
Message-Id: <1579596603-258380-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This macro is never used from it was introduced in commit e6b1db98cf4d5
("security: Support early LSMs"), better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Matthew Garrett <matthewgarrett@google.com>
Cc: James Morris <jmorris@namei.org> 
Cc: "Serge E. Hallyn" <serge@hallyn.com> 
Cc: linux-security-module@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 security/security.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index cd2d18d2d279..b9771de83cf7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -33,7 +33,6 @@
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
-#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
-- 
1.8.3.1

