Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B2E82CA5
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Sep 2023 15:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjI0PJx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Sep 2023 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjI0PJw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Sep 2023 11:09:52 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF2F4;
        Wed, 27 Sep 2023 08:09:49 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38RF9ZRE033048;
        Thu, 28 Sep 2023 00:09:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Thu, 28 Sep 2023 00:09:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38RF9Z8a033045
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Sep 2023 00:09:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9fccf6d7-4b1b-dd4e-5479-3c6d21d08d5a@I-love.SAKURA.ne.jp>
Date:   Thu, 28 Sep 2023 00:09:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: [RFC PATCH 2/2] LSM: A sample of dynamically appendable LSM module.
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
In-Reply-To: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is an example of dynamically appendable LSM modules.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 demo/Makefile |  1 +
 demo/demo.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 demo/Makefile
 create mode 100644 demo/demo.c

diff --git a/demo/Makefile b/demo/Makefile
new file mode 100644
index 000000000000..8a6ab0945858
--- /dev/null
+++ b/demo/Makefile
@@ -0,0 +1 @@
+obj-m += demo.o
diff --git a/demo/demo.c b/demo/demo.c
new file mode 100644
index 000000000000..90b03d10bd72
--- /dev/null
+++ b/demo/demo.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/module.h>
+#include <linux/lsm_hooks.h>
+
+static int demo_task_alloc_security(struct task_struct *p,
+				    unsigned long clone_flags)
+{
+	static unsigned int count;
+
+	if (count++ < 5)
+		dump_stack();
+	return 0;
+}
+
+static void demo_task_free_security(struct task_struct *p)
+{
+	static unsigned int count;
+
+	if (count++ < 5)
+		dump_stack();
+}
+
+static struct security_hook_list demo_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(task_free, demo_task_free_security),
+	LSM_HOOK_INIT(task_alloc, demo_task_alloc_security),
+};
+
+static int __init demo_init(void)
+{
+	const int ret = register_loadable_lsm(demo_hooks,
+					      ARRAY_SIZE(demo_hooks), "demo");
+
+	pr_info("Registering demo LSM module returned %d.\n", ret);
+	return ret;
+}
+
+module_init(demo_init);
+MODULE_LICENSE("GPL");
-- 
2.18.4

