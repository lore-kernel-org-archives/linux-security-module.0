Return-Path: <SRS0=9r3I=P6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A55C282C4
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 22:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B5520870
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 22:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jgQN2VLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfAVWmP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:42:15 -0500
Received: from mail-vk1-f200.google.com ([209.85.221.200]:56791 "EHLO
        mail-vk1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfAVWmP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Jan 2019 17:42:15 -0500
Received: by mail-vk1-f200.google.com with SMTP id d123so53217vkf.23
        for <linux-security-module@vger.kernel.org>; Tue, 22 Jan 2019 14:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u8yorHj8h/57xjAaoPMbj15fC7Mdy0qjHl4fjT0M0Tc=;
        b=jgQN2VLBHdd/5MRoZ1TP3dpMzQHUKSqUlXp0RiqZzz0LO/r7KxrsQkaUUEkbjhDfJF
         eys99Z/6+hJ7FUO1so6Kz59CKbOUWJExNqD+QK4PzzWxr23QJSfqR3Z8roDK1pexUbsE
         ibcqb+7NeqaHd73893Y8xwscOnp4XsVuhjH64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u8yorHj8h/57xjAaoPMbj15fC7Mdy0qjHl4fjT0M0Tc=;
        b=mgdMIYbImPkqkAMVx+tpiVLEjdnbaGdMdp4r0U//rzgYAbhJ6CT9j8HfhtB6A7GbHS
         L8BpfN1/n8KZfAUo32PJwpy/VWU43kwyP3bJXu7JmrWfy6pxProynqnDhI4Kv1ykRa+h
         1cAfKsJyLBPBuuF3SIt+5me5kguFqxJA/lhLKU0bkhSWFwj3SucKPm+2DQo8Ks//U/YR
         HAVa/TViTf6l++LttNZpTD1QYZ+jOK8CXw6QfY/6WN5vHKZnpQCm9A9KjFEGmoHUv0BI
         k+HMpXgzRn3uD2R4W8I2g4TXgiK/LWdB1jos9ML24MWuWj41bCGYXfbc3siUZPDc7bXS
         Rd0w==
X-Gm-Message-State: AJcUukfnScRuUBm7IhHVxMtPW3FLDc7FDKof9T5sQtP/VMLOr73AYeFU
        bZec/5SmBy5oQJhrwJcef2V+scBvffyIwF9L
X-Google-Smtp-Source: ALg8bN6L14bk1rpyFTYqu8PC3kKHvkdrcIQqnpw/covfywGHpnZ6VLR3jiq5SRRphQhXLZfd9VQo4ZpcHwl8PoDA
X-Received: by 2002:ab0:e01:: with SMTP id g1mr2374108uak.21.1548196933504;
 Tue, 22 Jan 2019 14:42:13 -0800 (PST)
Date:   Tue, 22 Jan 2019 14:42:09 -0800
In-Reply-To: <CAJ-EccM-uiYybMcLNfwJjJcVHRPb6b=BdhotBYVBV_j5stxxzA@mail.gmail.com>
Message-Id: <20190122224209.222480-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <CAJ-EccM-uiYybMcLNfwJjJcVHRPb6b=BdhotBYVBV_j5stxxzA@mail.gmail.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v3 1/2] LSM: add SafeSetID module that gates setid calls
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

