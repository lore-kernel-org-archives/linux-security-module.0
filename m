Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA77AC43219
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKBRLq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiKBRLe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:34 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C92201A8
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:11:29 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A2HAtdL021870;
        Thu, 3 Nov 2022 02:10:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 03 Nov 2022 02:10:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A2HAnkE021849
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
Subject: [PATCH 03/10] fs,kernel: Export d_absolute_path()/find_task_by_pid_ns()/find_task_by_vpid()
Date:   Thu,  3 Nov 2022 02:10:18 +0900
Message-Id: <20221102171025.126961-3-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

CaitSith module which can be loaded using /sbin/insmod needs to be able to
access these functions. TOMOYO module will also access these functions when
CONFIG_SECURITY_TOMOYO=m becomes possible.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/d_path.c  | 1 +
 kernel/pid.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index 56a6ee4c6331..417e74414f19 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -234,6 +234,7 @@ char *d_absolute_path(const struct path *path,
 		return ERR_PTR(-EINVAL);
 	return extract_string(&b);
 }
+EXPORT_SYMBOL_GPL(d_absolute_path);
 
 static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index 3fbc5e46b721..9e5224d8769c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -416,11 +416,13 @@ struct task_struct *find_task_by_pid_ns(pid_t nr, struct pid_namespace *ns)
 			 "find_task_by_pid_ns() needs rcu_read_lock() protection");
 	return pid_task(find_pid_ns(nr, ns), PIDTYPE_PID);
 }
+EXPORT_SYMBOL_GPL(find_task_by_pid_ns);
 
 struct task_struct *find_task_by_vpid(pid_t vnr)
 {
 	return find_task_by_pid_ns(vnr, task_active_pid_ns(current));
 }
+EXPORT_SYMBOL_GPL(find_task_by_vpid);
 
 struct task_struct *find_get_task_by_vpid(pid_t nr)
 {
-- 
2.18.4

