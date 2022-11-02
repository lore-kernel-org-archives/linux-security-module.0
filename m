Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFF1C4321E
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKBRLs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiKBRLe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:34 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF15F1C425
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:11:29 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HAtHW021865;
        Thu, 3 Nov 2022 02:10:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 03 Nov 2022 02:10:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HAnkD021849
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
Subject: [PATCH 02/10] mm: Export copy_to_kernel_nofault()
Date:   Thu,  3 Nov 2022 02:10:17 +0900
Message-Id: <20221102171025.126961-2-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

LSM modules which can be loaded using /sbin/insmod need to be able to
modify security_hook_heads. Since security_hook_heads might be read-only
due to being marked as __lsm_ro_after_init, and writing to read-only memory
crashes the kernel, such LSM modules need to test whether memory pages
containing security_hook_heads is read-only.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 mm/maccess.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/maccess.c b/mm/maccess.c
index 5f4d240f67ec..f75447b13034 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -75,6 +75,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 	pagefault_enable();
 	return -EFAULT;
 }
+EXPORT_SYMBOL_GPL(copy_to_kernel_nofault);
 
 long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 {
-- 
2.18.4

