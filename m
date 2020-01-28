Return-Path: <SRS0=y/rA=3R=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E082C2D0DB
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jan 2020 21:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8BA2173E
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jan 2020 21:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgA1VY7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:24:59 -0500
Received: from namei.org ([65.99.196.166]:60576 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgA1VY7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jan 2020 16:24:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 00SLOtER004936;
        Tue, 28 Jan 2020 21:24:55 GMT
Date:   Wed, 29 Jan 2020 08:24:55 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Security subsystem changes for v5.6
Message-ID: <alpine.LRH.2.21.2001290823510.4816@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Just one minor fix this time. Please pull.

The following changes since commit 219d54332a09e8d8741c1e1982f5eae56099de85:

  Linux 5.4 (2019-11-24 16:32:01 -0800)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-security for-v5.6

for you to fetch changes up to 10c2d111c906599942efd13109061885631c4a0c:

  security: remove EARLY_LSM_COUNT which never used (2020-01-27 11:19:41 -0800)

----------------------------------------------------------------
Alex Shi (1):
      security: remove EARLY_LSM_COUNT which never used

 security/security.c | 1 -
 1 file changed, 1 deletion(-)

---
commit 10c2d111c906599942efd13109061885631c4a0c
Author: Alex Shi <alex.shi@linux.alibaba.com>
Date:   Tue Jan 21 16:50:03 2020 +0800

    security: remove EARLY_LSM_COUNT which never used
    
    This macro is never used from it was introduced in commit e6b1db98cf4d5
    ("security: Support early LSMs"), better to remove it.
    
    Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
    Acked-by: Serge Hallyn <serge@hallyn.com>
    Signed-off-by: James Morris <jmorris@namei.org>

diff --git a/security/security.c b/security/security.c
index 1bc000f834e2..344bf1327d7e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -33,7 +33,6 @@
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
-#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
