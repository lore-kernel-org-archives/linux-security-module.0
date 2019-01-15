Return-Path: <SRS0=ihUA=PX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D22C43387
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 18:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C799A20859
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Jan 2019 18:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WOWZCfyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfAOSE1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:04:27 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:44861 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfAOSE1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Jan 2019 13:04:27 -0500
Received: by mail-io1-f72.google.com with SMTP id v8so2595741ioh.11
        for <linux-security-module@vger.kernel.org>; Tue, 15 Jan 2019 10:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u8yorHj8h/57xjAaoPMbj15fC7Mdy0qjHl4fjT0M0Tc=;
        b=WOWZCfyEqdwcezEfpwnCib99I7pZKNv7RaHDYR9U2j+uaqubvbx+L8cpyXFX5YHkSj
         n2qsGotyAbUaMseRAa9yw/ubFI8kdd6UlnLLPoBoAEn9sre4suRWxMHXjK1Rh5YehID7
         v7nbTk8ykfitCKOTHhYruwzriGen74pQUHUro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u8yorHj8h/57xjAaoPMbj15fC7Mdy0qjHl4fjT0M0Tc=;
        b=PnV5kSmhq2LaJ4bJhwDono8pBm7ezWWSTERVSMnekH+gk98HsODF+eztUfLpgeoh3H
         VVQsVXeGY3mNtxuSiS7pFN7SBoIf6/sYgq1vRhKRF+ecBCJU+cMTjpTcHbrg5ljGCnPI
         y/dzf8PiobSzfBtx9GAphR+qcLrd0YzSOmrNa/7nfoCMXoqLYbkIPLqbbhegc3KvL3Hr
         OmAGKae6tdalkrICp6WiD2HMwUyqq98QPNDpRCydjFY5XS+Iy/FHYyUbVCjtLov6XMdV
         3DOuhrM7uEYRbHQj5KsPMUkREr1vIrKGBWmcbRiv5MfPIANDapL+Co/8d3Sutnoz0JA8
         lJ+A==
X-Gm-Message-State: AJcUukejfKWHIbmFZxNqSX617oGQ6JSvcr8WckvYh4aJuPrwieGa9n6u
        fSIVvnYvzuIuxl8J2CZtcEU+23J0aCaQ7Wb4
X-Google-Smtp-Source: ALg8bN48TZwH70Jms8m8M8BX3BjX+l0J7T0awm2yOxEVPP7OAzAB8p9eK/44I8vK4u6u8O6uwtMlFIWVLW3xrUDK
X-Received: by 2002:a24:6852:: with SMTP id v79mr3109220itb.29.1547575466337;
 Tue, 15 Jan 2019 10:04:26 -0800 (PST)
Date:   Tue, 15 Jan 2019 10:04:21 -0800
In-Reply-To: <CAGXu5jKiFDD25TUnt7s_zFv7sjrt8avjeZgBKUBVzQ-er+xdkg@mail.gmail.com>
Message-Id: <20190115180421.102209-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <CAGXu5jKiFDD25TUnt7s_zFv7sjrt8avjeZgBKUBVzQ-er+xdkg@mail.gmail.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 1/2] LSM: mark all set*uid call sites in kernel/sys.c
From:   mortonm@chromium.org
To:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

This change ensures that the set*uid family of syscalls in kernel/sys.c
(setreuid, setuid, setresuid, setfsuid) all call ns_capable_common with
the CAP_OPT_INSETID flag, so capability checks in the security_capable
hook can know whether they are being called from within a set*uid
syscall. This change is a no-op by itself, but is needed for the
proposed SafeSetID LSM.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
These changes used to be part of the main SafeSetID LSM patch set.

 include/linux/capability.h |  5 +++++
 kernel/capability.c        | 19 +++++++++++++++++++
 kernel/sys.c               | 10 +++++-----
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index f640dcbc880c..c3f9a4d558a0 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -209,6 +209,7 @@ extern bool has_ns_capability_noaudit(struct task_struct *t,
 extern bool capable(int cap);
 extern bool ns_capable(struct user_namespace *ns, int cap);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
+extern bool ns_capable_setid(struct user_namespace *ns, int cap);
 #else
 static inline bool has_capability(struct task_struct *t, int cap)
 {
@@ -240,6 +241,10 @@ static inline bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 {
 	return true;
 }
+static inline bool ns_capable_setid(struct user_namespace *ns, int cap)
+{
+	return true;
+}
 #endif /* CONFIG_MULTIUSER */
 extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode);
 extern bool capable_wrt_inode_uidgid(const struct inode *inode, int cap);
diff --git a/kernel/capability.c b/kernel/capability.c
index 7718d7dcadc7..e0734ace5bc2 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -417,6 +417,25 @@ bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(ns_capable_noaudit);
 
+/**
+ * ns_capable_setid - Determine if the current task has a superior capability
+ * in effect, while signalling that this check is being done from within a
+ * setid syscall.
+ * @ns:  The usernamespace we want the capability in
+ * @cap: The capability to be tested for
+ *
+ * Return true if the current task has the given superior capability currently
+ * available for use, false if not.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+bool ns_capable_setid(struct user_namespace *ns, int cap)
+{
+	return ns_capable_common(ns, cap, CAP_OPT_INSETID);
+}
+EXPORT_SYMBOL(ns_capable_setid);
+
 /**
  * capable - Determine if the current task has a superior capability in effect
  * @cap: The capability to be tested for
diff --git a/kernel/sys.c b/kernel/sys.c
index a48cbf1414b8..a98061c1a124 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -516,7 +516,7 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 		new->uid = kruid;
 		if (!uid_eq(old->uid, kruid) &&
 		    !uid_eq(old->euid, kruid) &&
-		    !ns_capable(old->user_ns, CAP_SETUID))
+		    !ns_capable_setid(old->user_ns, CAP_SETUID))
 			goto error;
 	}
 
@@ -525,7 +525,7 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 		if (!uid_eq(old->uid, keuid) &&
 		    !uid_eq(old->euid, keuid) &&
 		    !uid_eq(old->suid, keuid) &&
-		    !ns_capable(old->user_ns, CAP_SETUID))
+		    !ns_capable_setid(old->user_ns, CAP_SETUID))
 			goto error;
 	}
 
@@ -584,7 +584,7 @@ long __sys_setuid(uid_t uid)
 	old = current_cred();
 
 	retval = -EPERM;
-	if (ns_capable(old->user_ns, CAP_SETUID)) {
+	if (ns_capable_setid(old->user_ns, CAP_SETUID)) {
 		new->suid = new->uid = kuid;
 		if (!uid_eq(kuid, old->uid)) {
 			retval = set_user(new);
@@ -646,7 +646,7 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	old = current_cred();
 
 	retval = -EPERM;
-	if (!ns_capable(old->user_ns, CAP_SETUID)) {
+	if (!ns_capable_setid(old->user_ns, CAP_SETUID)) {
 		if (ruid != (uid_t) -1        && !uid_eq(kruid, old->uid) &&
 		    !uid_eq(kruid, old->euid) && !uid_eq(kruid, old->suid))
 			goto error;
@@ -814,7 +814,7 @@ long __sys_setfsuid(uid_t uid)
 
 	if (uid_eq(kuid, old->uid)  || uid_eq(kuid, old->euid)  ||
 	    uid_eq(kuid, old->suid) || uid_eq(kuid, old->fsuid) ||
-	    ns_capable(old->user_ns, CAP_SETUID)) {
+	    ns_capable_setid(old->user_ns, CAP_SETUID)) {
 		if (!uid_eq(kuid, old->fsuid)) {
 			new->fsuid = kuid;
 			if (security_task_fix_setuid(new, old, LSM_SETID_FS) == 0)
-- 
2.20.1.97.g81188d93c3-goog

