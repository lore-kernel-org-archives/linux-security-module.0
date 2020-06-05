Return-Path: <SRS0=NT9g=7S=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B34C433E0
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 19:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BD02077D
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jun 2020 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LuduYH/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFETiL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgFETiK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Jun 2020 15:38:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF8CC08C5C2
        for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2020 12:38:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so4119569plr.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2020 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UBN9XkJ2jxlKA7wFZ1OzKmu6JrclnbLWZYYCPltam8Q=;
        b=LuduYH/uexf10mQK9zSgwVBalrjOSlW9gkczQtkycP/RzdSy5vDxftA2xLIDPx8gmJ
         jMNAo3NiFoKmZuav2ZrCp65ZUtuhUUBSmlCEo1F+Zrf+DtE01s0eqT3/rqVtCjhe4/dm
         rWfSSje7Q9hOGs00yuV5D0ZUNz+ujTgwqHwMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UBN9XkJ2jxlKA7wFZ1OzKmu6JrclnbLWZYYCPltam8Q=;
        b=BEcTDLKpW7xfgmmj5cBROeynkFEFzkEJy4VW4DFSTaCvFnl1hUvSAO+ovbGETP3eVo
         OuZ07qDQsztMJXhEXzscfsMF3IqPhH8rd8WiIvXIy8RGgGi2L5JlcYk3PNYiKz7GYnNQ
         GxFBtrXLaAEB6ewuU+WPrZwq0qZEeMdezEYWt/29I62XAJZVV6tjl5lham0NOOl4UoKR
         8CBoesCLjW8K0hVvWXwqUieJ5gTx0LjkdE7rrGyN2O5Anf2bSK+wDsxxyqGaSONhLG4+
         ucrmS8dtvlYvMaxMvQqwAKpY5zGEFWP5SiZ9xHykk4cOUymEFDRY2ZV/jZ+QubeZsbTf
         d2rA==
X-Gm-Message-State: AOAM530s5ovvky5vljsiIuzP8CeAxBirLhZMJmt/KeX41JjmYhEHa8eC
        3d1ERLtjiElKir+b70z2GcbOje7s8BM=
X-Google-Smtp-Source: ABdhPJwj2yP2KSqqkWDDt/j2JTUqwtyyxik6vnckn+zN/3JDFHz9J98FNSVx2GZW+pqNAAcCCRDiPQ==
X-Received: by 2002:a17:902:558f:: with SMTP id g15mr11233204pli.174.1591385889358;
        Fri, 05 Jun 2020 12:38:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:c921:befc:7379:cdab])
        by smtp.gmail.com with ESMTPSA id ck11sm1235913pjb.51.2020.06.05.12.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 12:38:08 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, thomascedeno@google.com,
        Micah Morton <mortonm@chromium.org>
Subject: [PATCH] security: Add LSM hooks to set*gid syscalls
Date:   Fri,  5 Jun 2020 12:38:05 -0700
Message-Id: <20200605193805.36531-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The SafeSetID LSM uses the security_task_fix_setuid hook to filter
set*uid() syscalls according to its configured security policy. In
preparation for adding analagous support in the LSM for set*gid()
syscalls, we add the requisite hook here. Tested by putting print
statements in the security_task_fix_setgid hook and seeing them get hit
during kernel boot.

From: Thomas Cedeno <thomascedeno@google.com>
Signed-off-by: Thomas Cedeno <thomascedeno@google.com>
Reviewed-by: Micah Morton <mortonm@chromium.org>
---
NOTE: I (Micah) will send this patch as a pull request to Linus through
my SafeSetID tree if there are no objections.
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/lsm_hooks.h     |  9 +++++++++
 include/linux/security.h      |  9 +++++++++
 kernel/sys.c                  | 15 ++++++++++++++-
 security/security.c           |  6 ++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index fb3ce6cec997..d5401c09f2d3 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -191,6 +191,8 @@ LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
 	 loff_t size, enum kernel_read_file_id id)
 LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
 	 int flags)
+LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
+	 int flags)
 LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
 LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
 LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3e62dab77699..8012b610fe53 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -659,6 +659,15 @@
  *	@old is the set of credentials that are being replaces
  *	@flags contains one of the LSM_SETID_* values.
  *	Return 0 on success.
+ * @task_fix_setgid:
+ *     Update the module's state after setting one or more of the group
+ *     identity attributes of the current process.  The @flags parameter
+ *     indicates which of the set*gid system calls invoked this hook.
+ *     @new is the set of credentials that will be installed.  Modifications
+ *     should be made to this rather than to @current->cred.
+ *     @old is the set of credentials that are being replaced.
+ *     @flags contains one of the LSM_SETID_* values.
+ *     Return 0 on success.
  * @task_setpgid:
  *	Check permission before setting the process group identifier of the
  *	process @p to @pgid.
diff --git a/include/linux/security.h b/include/linux/security.h
index b3f2cb21b4f2..2b08a2e49ba6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -390,6 +390,8 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
+int security_task_fix_setgid(struct cred *new, const struct cred *old,
+			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
@@ -1034,6 +1036,13 @@ static inline int security_task_fix_setuid(struct cred *new,
 	return cap_task_fix_setuid(new, old, flags);
 }
 
+static inline int security_task_fix_setgid(struct cred *new,
+					   const struct cred *old,
+					   int flags)
+{
+	return 0;
+}
+
 static inline int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return 0;
diff --git a/kernel/sys.c b/kernel/sys.c
index 891667a49bb7..e65ec850bfae 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -393,6 +393,10 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 		new->sgid = new->egid;
 	new->fsgid = new->egid;
 
+	retval = security_task_fix_setgid(new, old, LSM_SETID_RE);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
 
 error:
@@ -435,6 +439,10 @@ long __sys_setgid(gid_t gid)
 	else
 		goto error;
 
+	retval = security_task_fix_setgid(new, old, LSM_SETID_ID);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
 
 error:
@@ -756,6 +764,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 		new->sgid = ksgid;
 	new->fsgid = new->egid;
 
+	retval = security_task_fix_setgid(new, old, LSM_SETID_RES);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
 
 error:
@@ -862,7 +874,8 @@ long __sys_setfsgid(gid_t gid)
 	    ns_capable(old->user_ns, CAP_SETGID)) {
 		if (!gid_eq(kgid, old->fsgid)) {
 			new->fsgid = kgid;
-			goto change_okay;
+			if (security_task_fix_setgid(new,old,LSM_SETID_FS) == 0)
+				goto change_okay;
 		}
 	}
 
diff --git a/security/security.c b/security/security.c
index 11c1a7da4fd1..639324c68dd0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1690,6 +1690,12 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 	return call_int_hook(task_fix_setuid, 0, new, old, flags);
 }
 
+int security_task_fix_setgid(struct cred *new, const struct cred *old,
+				 int flags)
+{
+	return call_int_hook(task_fix_setgid, 0, new, old, flags);
+}
+
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return call_int_hook(task_setpgid, 0, p, pgid);
-- 
2.27.0.278.ge193c7cf3a9-goog

