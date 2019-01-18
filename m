Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70ACC43387
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 10:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C8520823
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 10:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfARKRM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:17:12 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55451 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfARKRL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Jan 2019 05:17:11 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0IAH1Ik057057;
        Fri, 18 Jan 2019 19:17:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Fri, 18 Jan 2019 19:17:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0IAGquv056876
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Jan 2019 19:17:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] LSM: Make lsm_early_cred() and lsm_early_task() local functions.
Date:   Fri, 18 Jan 2019 19:15:59 +0900
Message-Id: <1547806559-12097-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Since current->cred == current->real_cred when ordered_lsm_init()
is called, and lsm_early_cred()/lsm_early_task() need to be called
between the amount of required bytes is determined and module specific
initialization function is called, we can move these calls from
individual modules to ordered_lsm_init().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/lsm_hooks.h  |  5 -----
 security/apparmor/lsm.c    |  2 --
 security/security.c        | 27 +++++++++++----------------
 security/selinux/hooks.c   |  1 -
 security/smack/smack_lsm.c |  2 --
 security/tomoyo/tomoyo.c   |  1 -
 6 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c753d06..b3e94bc 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2133,9 +2133,4 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
-#ifdef CONFIG_SECURITY
-void __init lsm_early_cred(struct cred *cred);
-void __init lsm_early_task(struct task_struct *task);
-#endif
-
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index dff7f94..49d664d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1484,8 +1484,6 @@ static int __init set_init_ctx(void)
 {
 	struct cred *cred = (struct cred *)current->real_cred;
 
-	lsm_early_cred(cred);
-	lsm_early_task(current);
 	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
 
 	return 0;
diff --git a/security/security.c b/security/security.c
index 9a98c52..8c09334 100644
--- a/security/security.c
+++ b/security/security.c
@@ -278,6 +278,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
+static void __init lsm_early_cred(struct cred *cred);
+static void __init lsm_early_task(struct task_struct *task);
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -312,6 +315,8 @@ static void __init ordered_lsm_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
+	lsm_early_cred((struct cred *) current->cred);
+	lsm_early_task(current);
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
 
@@ -465,17 +470,12 @@ static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
  * lsm_early_cred - during initialization allocate a composite cred blob
  * @cred: the cred that needs a blob
  *
- * Allocate the cred blob for all the modules if it's not already there
+ * Allocate the cred blob for all the modules
  */
-void __init lsm_early_cred(struct cred *cred)
+static void __init lsm_early_cred(struct cred *cred)
 {
-	int rc;
+	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
 
-	if (cred == NULL)
-		panic("%s: NULL cred.\n", __func__);
-	if (cred->security != NULL)
-		return;
-	rc = lsm_cred_alloc(cred, GFP_KERNEL);
 	if (rc)
 		panic("%s: Early cred alloc failed.\n", __func__);
 }
@@ -589,17 +589,12 @@ int lsm_msg_msg_alloc(struct msg_msg *mp)
  * lsm_early_task - during initialization allocate a composite task blob
  * @task: the task that needs a blob
  *
- * Allocate the task blob for all the modules if it's not already there
+ * Allocate the task blob for all the modules
  */
-void __init lsm_early_task(struct task_struct *task)
+static void __init lsm_early_task(struct task_struct *task)
 {
-	int rc;
+	int rc = lsm_task_alloc(task);
 
-	if (task == NULL)
-		panic("%s: task cred.\n", __func__);
-	if (task->security != NULL)
-		return;
-	rc = lsm_task_alloc(task);
 	if (rc)
 		panic("%s: Early task alloc failed.\n", __func__);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2332243..d0fa81c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -209,7 +209,6 @@ static void cred_init_security(void)
 	struct cred *cred = (struct cred *) current->real_cred;
 	struct task_security_struct *tsec;
 
-	lsm_early_cred(cred);
 	tsec = selinux_cred(cred);
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a326cd9..fa98394 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4772,8 +4772,6 @@ static __init int smack_init(void)
 	if (!smack_inode_cache)
 		return -ENOMEM;
 
-	lsm_early_cred(cred);
-
 	/*
 	 * Set the security state for the initial task.
 	 */
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 066c0da..2b3eee0 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -566,7 +566,6 @@ static int __init tomoyo_init(void)
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-	lsm_early_cred(cred);
 	blob = tomoyo_cred(cred);
 	*blob = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
-- 
1.8.3.1

