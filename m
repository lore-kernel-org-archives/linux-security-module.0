Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6670C43334
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Jun 2022 20:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245594AbiFMU4i (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345169AbiFMUzf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jun 2022 16:55:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A121274D
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jun 2022 13:28:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso4005842pjg.1
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jun 2022 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osZI55S/5dMcmV9pE2V+C0A43bBMSnu9K9IPGFv9W/Q=;
        b=mWUznRIloP2KlmQ1d/y4w2DVizn3o5dRam9GxBJuSDKWWJyNFWl8lbPbBDxPFrlLYF
         bL6KsouwqNO7nn0ZucMLrpAvQeeMlv6Lz+ixXEBs2F9gtF6UMucw2rUHLthFUr17mVkI
         9R2z0NFBWgYL9bSujjUguW3v3dnYtOlRyA60Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osZI55S/5dMcmV9pE2V+C0A43bBMSnu9K9IPGFv9W/Q=;
        b=oJMkOw0I02JjcW2tK5XZcirHg07zV/KhgXKamC+S7bAT48QumnhYJ8p70LW3wmw+Ms
         M49pOsQIN+/ijPifDOcwlG22eeOjEh7knvkBYXCaKvRWq0VKbLWMCi1EHtWSguTN80Nb
         dOkNx3PUQV53POIGe38abwZDFP9G41FwSqSbxlAJzQe3jQZ58rOPE7D5ztcmlMspIO57
         H3mtcyhKCg6cv2BXt/kSsnUQEPznIitI4Wxa3XtjMABsmJkWQLJnvNhdri0Km09ESPkm
         z5S36JxQyXr/kAaI1Aqqqg9qn90DTpdCe/XxHofQOVwcPZ6zT/2iQCVzKF71SzxIiYBj
         1Uew==
X-Gm-Message-State: AJIora8nQucn7Kw6y5G8pEZrf/LucG1rmjehEUAWx8JrjalZNdSXN2f4
        hetUI1WZWvzbprn9T892EVtz91JLKYQsjQ==
X-Google-Smtp-Source: ABdhPJwWHXAV5GrU0wvTAGyjLfVkRBvo2yWyHFPTojpJxd+BGIwMV6Tfi1FuKAqpnzhRjLbV0+62Vg==
X-Received: by 2002:a17:902:eb90:b0:163:e4c1:b2fc with SMTP id q16-20020a170902eb9000b00163e4c1b2fcmr807340plg.159.1655152092015;
        Mon, 13 Jun 2022 13:28:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:cf79:20b3:87b5:90bc])
        by smtp.gmail.com with UTF8SMTPSA id f13-20020a170902f38d00b0016413dbbf92sm5531140ple.234.2022.06.13.13.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 13:28:10 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 1/2] security: Add LSM hook to setgroups() syscall
Date:   Mon, 13 Jun 2022 13:28:07 -0700
Message-Id: <20220613202807.447694-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Give the LSM framework the ability to filter setgroups() syscalls. There
are already analagous hooks for the set*uid() and set*gid() syscalls.
The SafeSetID LSM will use this new hook to ensure setgroups() calls are
allowed by the installed security policy.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---

Developed on 5.18

 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  7 +++++++
 include/linux/security.h      |  7 +++++++
 kernel/groups.c               | 12 ++++++++++++
 security/security.c           |  5 +++++
 5 files changed, 32 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index db924fe379c9..c01063ec4be7 100644
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
index 419b5febc3ca..b5143d9a1127 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -701,6 +701,13 @@
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
index 25b3ef71f495..d111ff830742 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -413,6 +413,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_fix_setgid(struct cred *new, const struct cred *old,
 			     int flags);
+int security_task_fix_setgroups(struct cred *new, const struct cred *old);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
@@ -1096,6 +1097,12 @@ static inline int security_task_fix_setgid(struct cred *new,
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
index 787b381c7c00..c085f54d8dbb 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -134,13 +134,25 @@ EXPORT_SYMBOL(set_groups);
 int set_current_groups(struct group_info *group_info)
 {
 	struct cred *new;
+	struct cred *old;
 
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
index b7cf5cbfdc67..eaed8d16d90a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1809,6 +1809,11 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
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

