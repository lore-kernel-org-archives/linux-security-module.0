Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE58BC433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jun 2022 17:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378222AbiFPRSZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377915AbiFPRSY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jun 2022 13:18:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666FB39162
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jun 2022 10:18:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso2051999pjh.4
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jun 2022 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/F8W4X0OG/zaI5SNdaWcoXd2ZhB+Vu7miSvJF8gcVgY=;
        b=TJjkupzaO1XanVa1a8MhVf2wS5mS4CLkAxnyU2AT4h6QR0Gb0ZyoWoYLUkUW0B3mQv
         tGBExJHMLN4zEOfuldWF+pLYgkGGqzLFFoHP6xYZI3TOStk8OSdr1sl9iudd+OntIKwh
         AIEX0Mq/0LBxOdTp//Pu1JhSe2QZgtF9YCuoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/F8W4X0OG/zaI5SNdaWcoXd2ZhB+Vu7miSvJF8gcVgY=;
        b=zPnmrJcJKhHa+HuDU1HrG50FJQQ6cUTkdIjzbqI1mn1PJLPrEjw3n80RTu0yCUTUks
         gK7ddL87P6EFkzv3XpOmA3svuMOXV+DJP60kncOR13VKftVMNIdaeIulCnl1nBiIDd7g
         EZ7LnKz7iVJw+mZPMIZZiCetIqwZgyfWVx/uj5l/hjQUbWxXEeLwoYYFYAL76MuIuTQZ
         x0bgLL/bbVpUEB0DvwwynLuXDPKErcecRW4wvk+6zpl6e/f/rbJKABy3sXCo2oXE6AHn
         JXP5RiBTPzVrp3W39Xa6kXvHT+G/J417RJwSG6YB/kSCTocGYGGptjSfILAgmFw9Vusg
         R1dw==
X-Gm-Message-State: AJIora/9+o8YVDEa0zY5sOqFuS9AAoecZYVfyt5e+TMujHHW9hhclbgr
        pNRm4BVRqmxV03x1hCjFG8w7F/n6EFfM1A==
X-Google-Smtp-Source: AGRyM1vPSDMIElCPrx4yIRc2lam3wMaH0PbSNRhHXnY4BG5I9I07mOaikaL+u5z4b3MRGxlRwHa6FA==
X-Received: by 2002:a17:90a:cc0d:b0:1e3:1256:faa3 with SMTP id b13-20020a17090acc0d00b001e31256faa3mr17228215pju.107.1655399902597;
        Thu, 16 Jun 2022 10:18:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:46bc:126f:64c1:579a])
        by smtp.gmail.com with UTF8SMTPSA id s12-20020a63924c000000b003fe4da67980sm2002300pgn.68.2022.06.16.10.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 10:18:17 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 1/3] security: Add LSM hook to setgroups() syscall
Date:   Thu, 16 Jun 2022 10:18:09 -0700
Message-Id: <20220616171809.783277-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Give the LSM framework the ability to filter setgroups() syscalls. There
are already analagous hooks for the set*uid() and set*gid() syscalls.
The SafeSetID LSM will use this new hook to ensure setgroups() calls are
allowed by the installed security policy. Tested by putting print
statement in security_task_fix_setgroups() hook and confirming that it
gets hit when userspace does a setgroups() syscall.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  7 +++++++
 include/linux/security.h      |  7 +++++++
 kernel/groups.c               | 13 +++++++++++++
 security/security.c           |  5 +++++
 5 files changed, 33 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index eafa1d2489fd..806448173033 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -201,6 +201,7 @@ LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
 	 int flags)
 LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
 	 int flags)
+LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
 LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
 LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
 LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 91c8146649f5..84a0d7e02176 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -702,6 +702,13 @@
  *	@old is the set of credentials that are being replaced.
  *	@flags contains one of the LSM_SETID_* values.
  *	Return 0 on success.
+ * @task_fix_setgroups:
+ *	Update the module's state after setting the supplementary group
+ *	identity attributes of the current process.
+ *	@new is the set of credentials that will be installed.  Modifications
+ *	should be made to this rather than to @current->cred.
+ *	@old is the set of credentials that are being replaced.
+ *	Return 0 on success.
  * @task_setpgid:
  *	Check permission before setting the process group identifier of the
  *	process @p to @pgid.
diff --git a/include/linux/security.h b/include/linux/security.h
index 7fc4e9f49f54..1dfd32c49fa3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -415,6 +415,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_fix_setgid(struct cred *new, const struct cred *old,
 			     int flags);
+int security_task_fix_setgroups(struct cred *new, const struct cred *old);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
@@ -1098,6 +1099,12 @@ static inline int security_task_fix_setgid(struct cred *new,
 	return 0;
 }
 
+static inline int security_task_fix_setgroups(struct cred *new,
+					   const struct cred *old)
+{
+	return 0;
+}
+
 static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return 0;
diff --git a/kernel/groups.c b/kernel/groups.c
index 787b381c7c00..9aaed2a31073 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -134,13 +134,26 @@ EXPORT_SYMBOL(set_groups);
 int set_current_groups(struct group_info *group_info)
 {
 	struct cred *new;
+	const struct cred *old;
+	int retval;
 
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
 
+	old = current_cred();
+
 	set_groups(new, group_info);
+
+	retval = security_task_fix_setgroups(new, old);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
+
+error:
+	abort_creds(new);
+	return retval;
 }
 
 EXPORT_SYMBOL(set_current_groups);
diff --git a/security/security.c b/security/security.c
index 188b8f782220..15c686145ad6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1803,6 +1803,11 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
 	return call_int_hook(task_fix_setgid, 0, new, old, flags);
 }
 
+int security_task_fix_setgroups(struct cred *new, const struct cred *old)
+{
+	return call_int_hook(task_fix_setgroups, 0, new, old);
+}
+
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return call_int_hook(task_setpgid, 0, p, pgid);
-- 
2.36.1.476.g0c4daa206d-goog

