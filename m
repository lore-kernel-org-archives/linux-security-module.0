Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B2C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8902083E
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TByvivjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfDJQz0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:55:26 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:44269 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbfDJQzZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:55:25 -0400
Received: by mail-pf1-f169.google.com with SMTP id y13so1819014pfm.11
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sl4t4ul/+E9f2TaRFFo8H7oESH1GeQUI1PK2lPsmZY4=;
        b=TByvivjOsDIDE4sfrwCowXVKlQWA2ORE/pfs7KhmhHpXig0JZ2mB2MS/B4HfYLL2p+
         kOEjWIVSos+agKpnSnl//ouFAdBs9M3FHTqaDR0KK1Hi/e3nxizHKYUSp/1gRgeB7Ec8
         qIH35vum1OFwaCX6NckCE8XXRDhZty96PV+jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sl4t4ul/+E9f2TaRFFo8H7oESH1GeQUI1PK2lPsmZY4=;
        b=fMxv38rE/S7NOV0e3w/jAozROa3ABN6uJyEhRdNiXS6COybOEDElhRM3kMHt8N0ALs
         HsdnLaWSYH0yaGzt+FXbQwsQWbFDhxbBwqC6Ea587KYYCl6KzlpG9QWw5E9Bd5T/MUkS
         zEiwJdpOYfEJQhBxcBsFV84A/1j6uVSkXTqcdOl0HR/fPavk5nJv+jSyVuY+JxrRa+S8
         V8Vstz11O7t1xZRUrMzlmCrQ0edDO1KIstluqgq/Au0qHL9DfnWVMkc9wc9gLLVJNTlf
         i6fQe8Wzve8ky7c+RKNA21TwU4JwzWD+58gAgVJKsf4vDzWxLfDBtu3Hcm1TrpKMH13c
         oTjw==
X-Gm-Message-State: APjAAAW+1hNst6bR7nagzEg/wi3pj09x+TRj2yVpHbTU/x6DFW2sPNM7
        TGkQoqqWrlHJpoLERcrn0ILiuA==
X-Google-Smtp-Source: APXvYqyRUfRrvHzgty+TgY4IXe3293QPN/w4ogQtyTBq/owSTUU9VPI5VFK5cMoz6nEGp0VMWfTNFw==
X-Received: by 2002:a63:1654:: with SMTP id 20mr42539711pgw.166.1554915324837;
        Wed, 10 Apr 2019 09:55:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id u26sm49264827pfn.5.2019.04.10.09.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:55:24 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 02/10] LSM: SafeSetID: fix check for setresuid(new1, new2, new3)
Date:   Wed, 10 Apr 2019 09:55:19 -0700
Message-Id: <20190410165519.209565-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

With the old code, when a process with the (real,effective,saved) UID set
(1,1,1) calls setresuid(2,3,4), safesetid_task_fix_setuid() only checks
whether the transition 1->2 is permitted; the transitions 1->3 and 1->4 are
not checked. Fix this.

This is also a good opportunity to refactor safesetid_task_fix_setuid() to
be less verbose - having one branch per set*uid() syscall is unnecessary.

Note that this slightly changes semantics: The UID transition check for
UIDs that were not in the old cred struct is now always performed against
the policy of the RUID. I think that's more consistent anyway, since the
RUID is also the one that decides whether any policy is enforced at all.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/lsm.c | 125 +++++++++++----------------------------
 1 file changed, 35 insertions(+), 90 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 2daecab3a4c0..5310fcf3052a 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -99,20 +99,30 @@ static int safesetid_security_capable(const struct cred *cred,
 	return 0;
 }
 
-static int check_uid_transition(kuid_t parent, kuid_t child)
+/*
+ * Check whether a caller with old credentials @old is allowed to switch to
+ * credentials that contain @new_uid.
+ */
+static bool uid_permitted_for_cred(const struct cred *old, kuid_t new_uid)
 {
-	if (check_setuid_policy_hashtable_key_value(parent, child))
-		return 0;
-	pr_warn("UID transition (%d -> %d) blocked\n",
-		__kuid_val(parent),
-		__kuid_val(child));
+	bool permitted;
+
+	/* If our old creds already had this UID in it, it's fine. */
+	if (uid_eq(new_uid, old->uid) || uid_eq(new_uid, old->euid) ||
+	    uid_eq(new_uid, old->suid))
+		return true;
+
 	/*
-	 * Kill this process to avoid potential security vulnerabilities
-	 * that could arise from a missing whitelist entry preventing a
-	 * privileged process from dropping to a lesser-privileged one.
+	 * Transitions to new UIDs require a check against the policy of the old
+	 * RUID.
 	 */
-	force_sig(SIGKILL, current);
-	return -EACCES;
+	permitted = check_setuid_policy_hashtable_key_value(old->uid, new_uid);
+	if (!permitted) {
+		pr_warn("UID transition ((%d,%d,%d) -> %d) blocked\n",
+			__kuid_val(old->uid), __kuid_val(old->euid),
+			__kuid_val(old->suid), __kuid_val(new_uid));
+	}
+	return permitted;
 }
 
 /*
@@ -125,88 +135,23 @@ static int safesetid_task_fix_setuid(struct cred *new,
 				     int flags)
 {
 
-	/* Do nothing if there are no setuid restrictions for this UID. */
+	/* Do nothing if there are no setuid restrictions for our old RUID. */
 	if (!check_setuid_policy_hashtable_key(old->uid))
 		return 0;
 
-	switch (flags) {
-	case LSM_SETID_RE:
-		/*
-		 * Users for which setuid restrictions exist can only set the
-		 * real UID to the real UID or the effective UID, unless an
-		 * explicit whitelist policy allows the transition.
-		 */
-		if (!uid_eq(old->uid, new->uid) &&
-			!uid_eq(old->euid, new->uid)) {
-			return check_uid_transition(old->uid, new->uid);
-		}
-		/*
-		 * Users for which setuid restrictions exist can only set the
-		 * effective UID to the real UID, the effective UID, or the
-		 * saved set-UID, unless an explicit whitelist policy allows
-		 * the transition.
-		 */
-		if (!uid_eq(old->uid, new->euid) &&
-			!uid_eq(old->euid, new->euid) &&
-			!uid_eq(old->suid, new->euid)) {
-			return check_uid_transition(old->euid, new->euid);
-		}
-		break;
-	case LSM_SETID_ID:
-		/*
-		 * Users for which setuid restrictions exist cannot change the
-		 * real UID or saved set-UID unless an explicit whitelist
-		 * policy allows the transition.
-		 */
-		if (!uid_eq(old->uid, new->uid))
-			return check_uid_transition(old->uid, new->uid);
-		if (!uid_eq(old->suid, new->suid))
-			return check_uid_transition(old->suid, new->suid);
-		break;
-	case LSM_SETID_RES:
-		/*
-		 * Users for which setuid restrictions exist cannot change the
-		 * real UID, effective UID, or saved set-UID to anything but
-		 * one of: the current real UID, the current effective UID or
-		 * the current saved set-user-ID unless an explicit whitelist
-		 * policy allows the transition.
-		 */
-		if (!uid_eq(new->uid, old->uid) &&
-			!uid_eq(new->uid, old->euid) &&
-			!uid_eq(new->uid, old->suid)) {
-			return check_uid_transition(old->uid, new->uid);
-		}
-		if (!uid_eq(new->euid, old->uid) &&
-			!uid_eq(new->euid, old->euid) &&
-			!uid_eq(new->euid, old->suid)) {
-			return check_uid_transition(old->euid, new->euid);
-		}
-		if (!uid_eq(new->suid, old->uid) &&
-			!uid_eq(new->suid, old->euid) &&
-			!uid_eq(new->suid, old->suid)) {
-			return check_uid_transition(old->suid, new->suid);
-		}
-		break;
-	case LSM_SETID_FS:
-		/*
-		 * Users for which setuid restrictions exist cannot change the
-		 * filesystem UID to anything but one of: the current real UID,
-		 * the current effective UID or the current saved set-UID
-		 * unless an explicit whitelist policy allows the transition.
-		 */
-		if (!uid_eq(new->fsuid, old->uid)  &&
-			!uid_eq(new->fsuid, old->euid)  &&
-			!uid_eq(new->fsuid, old->suid) &&
-			!uid_eq(new->fsuid, old->fsuid)) {
-			return check_uid_transition(old->fsuid, new->fsuid);
-		}
-		break;
-	default:
-		pr_warn("Unknown setid state %d\n", flags);
-		force_sig(SIGKILL, current);
-		return -EINVAL;
-	}
-	return 0;
+	if (uid_permitted_for_cred(old, new->uid) &&
+	    uid_permitted_for_cred(old, new->euid) &&
+	    uid_permitted_for_cred(old, new->suid) &&
+	    uid_permitted_for_cred(old, new->fsuid))
+		return 0;
+
+	/*
+	 * Kill this process to avoid potential security vulnerabilities
+	 * that could arise from a missing whitelist entry preventing a
+	 * privileged process from dropping to a lesser-privileged one.
+	 */
+	force_sig(SIGKILL, current);
+	return -EACCES;
 }
 
 int add_safesetid_whitelist_entry(kuid_t parent, kuid_t child)
-- 
2.21.0.392.gf8f6787159e-goog

