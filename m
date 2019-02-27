Return-Path: <SRS0=eR/s=RC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61751C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A1821850
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 20:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C4BBLg+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfB0UAJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:00:09 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:39795 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfB0UAJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Feb 2019 15:00:09 -0500
Received: by mail-it1-f199.google.com with SMTP id h3so6208917itb.4
        for <linux-security-module@vger.kernel.org>; Wed, 27 Feb 2019 12:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=acWaroyTBI7QJoMJVN2cPr+dS2cdj5Ho45I9JDPNLF0=;
        b=C4BBLg+uUznwmL7IRuUFdnYRUHNAkPjxGI04ex8XNK7po7k+G7LM0b6txpI7NTL7m5
         vd7NrDq9XuBKzZTkDxFUWZCCstRNXPBOKrumLC+IOL/rSRFT8JePPVAtems8+ON91cMi
         L3/zkwr20vc4seWcHl7cQQg0SrJxMowImLEbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=acWaroyTBI7QJoMJVN2cPr+dS2cdj5Ho45I9JDPNLF0=;
        b=gNW8sLlizoDqudlywM7mS9wkU87kEQQXBCuwY0SKrVTXNOl2Vu4AnoigF4NiQHybUK
         GKOUKWbt7YkARSqDgI51WHEFcOvFnbX2ABQebd3VeLvzqNsOmQE3IAf7TUUuen4vgDEl
         fxW2ZzB5GFnhELzwFhHX64ofAzYj1pxkXiDdIseOZUQ2XASUd1GO3gh005nmBDDdXegu
         YCnlPu0c9IUUhMhhZ+rfs1I4+qsupG9SFLznnVr0AxhB0b21JMVsLQg6zAfeOQ5G5AdL
         NackR2eCF4nZGzlhbsqPh/54mQ9FTR1lWo6xgLybjf8Tm5DbfQ4STGgVX673pGIiSRPI
         E8dA==
X-Gm-Message-State: AHQUAuZvX4g5geeFAineaZbpA3aeS0TGDapNYKepEmlcQYtrl1Fr8XVz
        zcMonuVWyi0peY3NRDEfBEJu0N2RKcNwsLcs
X-Google-Smtp-Source: APXvYqx+1VVq7z44czNOqGtEbkl9n/7P8e6to/Kkolv24pALtNucFy0nXQdsboMZXw1c8Fxh8NsD0uWKS2YFPJKS
X-Received: by 2002:a24:4d8e:: with SMTP id l136mr644538itb.5.1551297607929;
 Wed, 27 Feb 2019 12:00:07 -0800 (PST)
Date:   Wed, 27 Feb 2019 12:00:03 -0800
In-Reply-To: <CAJ-EccN6FYCsHbmuWaDQmN-wseNVVJvRAwdzAu-K7_9w+nNrog@mail.gmail.com>
Message-Id: <20190227200003.143808-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <CAJ-EccN6FYCsHbmuWaDQmN-wseNVVJvRAwdzAu-K7_9w+nNrog@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH v2 1/2] LSM: SafeSetID: gate setgid transitions
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

This patch adds a 'task_fix_setgid' LSM hook, which is analogous to the
existing 'task_fix_setuid' LSM hook, and calls this new hook from the
setgid functions in kernel/sys.c. This will allow the SafeSetID LSM to
govern setgid transitions in addition to setuid transitions. This change
also makes sure the setgid functions in kernel/sys.c call
security_capable_setid rather than the ordinary security_capable
function, so that the security_capable hook in the SafeSetID LSM knows
it is being invoked from a setid function.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
Changes since the last patch: took out the cap_task_fix_setgid stuff
from include/linux/security.h since this hook won't be hooked by
security/commoncap.c.
 include/linux/lsm_hooks.h | 12 ++++++++++++
 include/linux/security.h  |  9 +++++++++
 kernel/sys.c              | 27 +++++++++++++++++++++------
 security/security.c       |  6 ++++++
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 22fc786d723a..f252ed3e95ef 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -603,6 +603,15 @@
  *	@old is the set of credentials that are being replaces
  *	@flags contains one of the LSM_SETID_* values.
  *	Return 0 on success.
+ * @task_fix_setgid:
+ *      Update the module's state after setting one or more of the group
+ *      identity attributes of the current process.  The @flags parameter
+ *      indicates which of the set*gid system calls invoked this hook.
+ *      @new is the set of credentials that will be installed.  Modifications
+ *      should be made to this rather than to @current->cred.
+ *      @old is the set of credentials that are being replaced
+ *      @flags contains one of the LSM_SETID_* values.
+ *      Return 0 on success.
  * @task_setpgid:
  *	Check permission before setting the process group identifier of the
  *	process @p to @pgid.
@@ -1596,6 +1605,8 @@ union security_list_options {
 				     enum kernel_read_file_id id);
 	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
 				int flags);
+	int (*task_fix_setgid)(struct cred *new, const struct cred *old,
+				int flags);
 	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
 	int (*task_getpgid)(struct task_struct *p);
 	int (*task_getsid)(struct task_struct *p);
@@ -1887,6 +1898,7 @@ struct security_hook_heads {
 	struct hlist_head kernel_post_read_file;
 	struct hlist_head kernel_module_request;
 	struct hlist_head task_fix_setuid;
+	struct hlist_head task_fix_setgid;
 	struct hlist_head task_setpgid;
 	struct hlist_head task_getpgid;
 	struct hlist_head task_getsid;
diff --git a/include/linux/security.h b/include/linux/security.h
index 13537a49ae97..e28ef6bf6280 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -326,6 +326,8 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
+int security_task_fix_setgid(struct cred *new, const struct cred *old,
+			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
@@ -930,6 +932,13 @@ static inline int security_task_fix_setuid(struct cred *new,
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
index c5f875048aef..76f1c46ac66f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -372,7 +372,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 	if (rgid != (gid_t) -1) {
 		if (gid_eq(old->gid, krgid) ||
 		    gid_eq(old->egid, krgid) ||
-		    ns_capable(old->user_ns, CAP_SETGID))
+		    ns_capable_setid(old->user_ns, CAP_SETGID))
 			new->gid = krgid;
 		else
 			goto error;
@@ -381,7 +381,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 		if (gid_eq(old->gid, kegid) ||
 		    gid_eq(old->egid, kegid) ||
 		    gid_eq(old->sgid, kegid) ||
-		    ns_capable(old->user_ns, CAP_SETGID))
+		    ns_capable_setid(old->user_ns, CAP_SETGID))
 			new->egid = kegid;
 		else
 			goto error;
@@ -392,6 +392,10 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 		new->sgid = new->egid;
 	new->fsgid = new->egid;
 
+	retval = security_task_fix_setgid(new, old, LSM_SETID_RE);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
 
 error:
@@ -427,13 +431,17 @@ long __sys_setgid(gid_t gid)
 	old = current_cred();
 
 	retval = -EPERM;
-	if (ns_capable(old->user_ns, CAP_SETGID))
+	if (ns_capable_setid(old->user_ns, CAP_SETGID))
 		new->gid = new->egid = new->sgid = new->fsgid = kgid;
 	else if (gid_eq(kgid, old->gid) || gid_eq(kgid, old->sgid))
 		new->egid = new->fsgid = kgid;
 	else
 		goto error;
 
+	retval = security_task_fix_setgid(new, old, LSM_SETID_ID);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
 
 error:
@@ -735,7 +743,7 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 	old = current_cred();
 
 	retval = -EPERM;
-	if (!ns_capable(old->user_ns, CAP_SETGID)) {
+	if (!ns_capable_setid(old->user_ns, CAP_SETGID)) {
 		if (rgid != (gid_t) -1        && !gid_eq(krgid, old->gid) &&
 		    !gid_eq(krgid, old->egid) && !gid_eq(krgid, old->sgid))
 			goto error;
@@ -755,6 +763,10 @@ long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 		new->sgid = ksgid;
 	new->fsgid = new->egid;
 
+	retval = security_task_fix_setgid(new, old, LSM_SETID_RES);
+	if (retval < 0)
+		goto error;
+
 	return commit_creds(new);
 
 error:
@@ -858,10 +870,13 @@ long __sys_setfsgid(gid_t gid)
 
 	if (gid_eq(kgid, old->gid)  || gid_eq(kgid, old->egid)  ||
 	    gid_eq(kgid, old->sgid) || gid_eq(kgid, old->fsgid) ||
-	    ns_capable(old->user_ns, CAP_SETGID)) {
+	    ns_capable_setid(old->user_ns, CAP_SETGID)) {
 		if (!gid_eq(kgid, old->fsgid)) {
 			new->fsgid = kgid;
-			goto change_okay;
+			if (security_task_fix_setgid(new,
+						old,
+						LSM_SETID_FS) == 0)
+				goto change_okay;
 		}
 	}
 
diff --git a/security/security.c b/security/security.c
index ed9b8cbf21cf..7e936f944a66 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1574,6 +1574,12 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 	return call_int_hook(task_fix_setuid, 0, new, old, flags);
 }
 
+int security_task_fix_setgid(struct cred *new, const struct cred *old,
+			     int flags)
+{
+	return call_int_hook(task_fix_setgid, 0, new, old, flags);
+}
+
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return call_int_hook(task_setpgid, 0, p, pgid);
-- 
2.21.0.352.gf09ad66450-goog

