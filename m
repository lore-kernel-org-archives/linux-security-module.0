Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDBAC43217
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKBRLr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiKBRLe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:34 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D291F9C0
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:11:27 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HAtFQ021860;
        Thu, 3 Nov 2022 02:10:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 03 Nov 2022 02:10:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HAnkC021849
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Nov 2022 02:10:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 01/10] security: Export security_hook_heads
Date:   Thu,  3 Nov 2022 02:10:16 +0900
Message-Id: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

LSM modules which can be loaded using /sbin/insmod need to be able to
access security_hook_heads, for security_add_hooks() is marked as __init
function which cannot be accessed from loadable kernel modules.

LSM modules which can be loaded using /sbin/insmod are developed in order
to make it possible to enable LSM modules without replacing or rebuilding
the whole kernel, for distributors disable LSM modules which they cannot
afford supporting via kernel config options while users cannot afford
enabling LSM modules which they want to use by replacing or rebuilding
the whole kernel.

Now that I'm demonstrating CaitSith as one of such LSM modules, export
the security_hook_heads list.

Unlike introducing a LSM manager module which could provide ability to
load/unload loadable LSM modules, exporting only security_hook_heads does
not affect performance of built-in LSM modules and will little increase
the kernel size. Therefore, no kernel config option for this change.

Distributors who believe that loadable LSM modules are unacceptable might
try to make it harder to use loadable LSM modules via unexporting
security_hook_heads. But we cannot hide security_hook_heads perfectly, for
binary code analysis allows loadable kernel modules to identify the
address of security_hook_heads. It is just a matter of cleanness of code.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/security.c b/security/security.c
index 79d82cb6e469..fd7b9b1f8348 100644
--- a/security/security.c
+++ b/security/security.c
@@ -75,6 +75,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 };
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
+EXPORT_SYMBOL_GPL(security_hook_heads);
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
-- 
2.18.4

