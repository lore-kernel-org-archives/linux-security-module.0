Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EAFC10F0E
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3CD2083E
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDLLFd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:05:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61350 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLLFc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Apr 2019 07:05:32 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3CB578j025542;
        Fri, 12 Apr 2019 20:05:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Fri, 12 Apr 2019 20:05:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank060157095162.bbtec.net [60.157.95.162])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3CB54W7025473
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Apr 2019 20:05:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzbot <syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com>,
        syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
Subject: [PATCH (resend)] tomoyo: Add a kernel config option for fuzzing testing.
Date:   Fri, 12 Apr 2019 20:04:54 +0900
Message-Id: <1555067094-9861-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

syzbot is reporting kernel panic triggered by memory allocation fault
injection before loading TOMOYO's policy [1]. To make the fuzzing tests
useful, we need to assign a profile other than "disabled" (no-op) mode.
Therefore, let's allow syzbot to load TOMOYO's built-in policy for
"learning" mode using a kernel config option. This option must not be
enabled for kernels built for production system, for this option also
disables domain/program checks when modifying policy configuration via
/sys/kernel/security/tomoyo/ interface.

[1] https://syzkaller.appspot.com/bug?extid=29569ed06425fcf67a95

Reported-by: syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/Kconfig  | 10 ++++++++++
 security/tomoyo/common.c | 13 ++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/Kconfig b/security/tomoyo/Kconfig
index 404dce6..a00ab7e 100644
--- a/security/tomoyo/Kconfig
+++ b/security/tomoyo/Kconfig
@@ -74,3 +74,13 @@ config SECURITY_TOMOYO_ACTIVATION_TRIGGER
 	  You can override this setting via TOMOYO_trigger= kernel command line
 	  option. For example, if you pass init=/bin/systemd option, you may
 	  want to also pass TOMOYO_trigger=/bin/systemd option.
+
+config SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
+	bool "Use insecure built-in settings for fuzzing tests."
+	default n
+	depends on SECURITY_TOMOYO
+	select SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
+	help
+	  Enabling this option forces minimal built-in policy and disables
+	  domain/program checks for run-time policy modifications. Please enable
+	  this option only if this kernel is built for doing fuzzing tests.
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 57988d9..dd3d594 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -940,7 +940,7 @@ static bool tomoyo_manager(void)
 	const char *exe;
 	const struct task_struct *task = current;
 	const struct tomoyo_path_info *domainname = tomoyo_domain()->domainname;
-	bool found = false;
+	bool found = IS_ENABLED(CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING);
 
 	if (!tomoyo_policy_loaded)
 		return true;
@@ -2810,6 +2810,16 @@ void tomoyo_check_profile(void)
  */
 void __init tomoyo_load_builtin_policy(void)
 {
+#ifdef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
+	static char tomoyo_builtin_profile[] __initdata =
+		"PROFILE_VERSION=20150505\n"
+		"0-CONFIG={ mode=learning grant_log=no reject_log=yes }\n";
+	static char tomoyo_builtin_exception_policy[] __initdata =
+		"aggregator proc:/self/exe /proc/self/exe\n";
+	static char tomoyo_builtin_domain_policy[] __initdata = "";
+	static char tomoyo_builtin_manager[] __initdata = "";
+	static char tomoyo_builtin_stat[] __initdata = "";
+#else
 	/*
 	 * This include file is manually created and contains built-in policy
 	 * named "tomoyo_builtin_profile", "tomoyo_builtin_exception_policy",
@@ -2817,6 +2827,7 @@ void __init tomoyo_load_builtin_policy(void)
 	 * "tomoyo_builtin_stat" in the form of "static char [] __initdata".
 	 */
 #include "builtin-policy.h"
+#endif
 	u8 i;
 	const int idx = tomoyo_read_lock();
 
-- 
1.8.3.1

