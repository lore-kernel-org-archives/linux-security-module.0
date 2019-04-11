Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232A5C10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 20:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC16E2184B
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 20:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GaXT2vsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDKUL7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:11:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38279 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKUL6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 16:11:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id f36so3938683plb.5
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JjTPkoM9UPI3NoiT+mhvmo5CzoCwUgsBiLiwGNSQjFw=;
        b=GaXT2vsJT94J3pPv3yA9qJxYucSpJs9F8a+lM3LJ1pG5YQmTv8cxUcxDlGGOdaTkTH
         Yy+wKIH8+H0UzFdZr61/ubMMlIy7EJQKrAHgcVlvsMsenIF8CeGeO9DoQK468rp8eJOY
         ZRML9TgrM5d0GVRw2nOd5EWVy7i7Ww1aQNmPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JjTPkoM9UPI3NoiT+mhvmo5CzoCwUgsBiLiwGNSQjFw=;
        b=eeH7PjdmrrKsV/B336aAYXkEdYralDvJrH6Oeo418Bttqco1TzTin1lxQ0xvAdHvm8
         8FCuK5MDwx3srRJDs75mgegmjCy7G6XNGSV9sQl64Xits9XEO+mSSssc4fPHyN3LfDb2
         BIjnVwMcPHUTgBDeHil8E2J8ZUXEIWQPa8sBZlGMgXs5lV4t6TIvUlm2BWBMaQpmB9w9
         wZO88633dqK7k4j6MpLu30k5k/iT5PGukodzZ7rm6nFyoCP46XJTQX/q0w18nHIZwA8a
         8wN4HV1Mrwpqe79WD40TuI2YhWekMmLhQhvSG+7OEAzcTRmAux2vTVdeMh5AJqi2gDjb
         yP6Q==
X-Gm-Message-State: APjAAAVyPw/u7f/uS06xvNF1Al1ZuouR9iubn7cyn6qAiqN/2QSjOPMA
        ap/GrvawH2rBTgqHyVAzXSDhu0OWL8+Ggw==
X-Google-Smtp-Source: APXvYqyySK0ojZTSut90f4gRQjkQrrS7vnikwBlY8tjg3wPsq4rBCtK0WBPvCMpqIit2u2jk/T0DEQ==
X-Received: by 2002:a17:902:b597:: with SMTP id a23mr3619147pls.284.1555013517206;
        Thu, 11 Apr 2019 13:11:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id t13sm34937228pgo.14.2019.04.11.13.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:11:56 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH v2 08/10] LSM: SafeSetID: add read handler
Date:   Thu, 11 Apr 2019 13:11:54 -0700
Message-Id: <20190411201154.167617-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

For debugging a running system, it is very helpful to be able to see what
policy the system is using. Add a read handler that can dump out a copy of
the loaded policy.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
Changes since the last patch set: Instead of doing refcounting, change
policy_update_lock to a mutex and hold the mutex across the policy read.
 security/safesetid/lsm.h        |  1 +
 security/safesetid/securityfs.c | 35 +++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index 4a34f558d964..db6d16e6bbc3 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -41,6 +41,7 @@ struct setuid_rule {
 
 struct setuid_ruleset {
 	DECLARE_HASHTABLE(rules, SETID_HASH_BITS);
+	char *policy_str;
 	struct rcu_head rcu;
 };
 
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 250d59e046c1..997b403c6255 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -19,7 +19,7 @@
 
 #include "lsm.h"
 
-static DEFINE_SPINLOCK(policy_update_lock);
+static DEFINE_MUTEX(policy_update_lock);
 
 /*
  * In the case the input buffer contains one or more invalid UIDs, the kuid_t
@@ -67,6 +67,7 @@ static void __release_ruleset(struct rcu_head *rcu)
 
 	hash_for_each_safe(pol->rules, bucket, tmp, rule, next)
 		kfree(rule);
+	kfree(pol->policy_str);
 	kfree(pol);
 }
 
@@ -85,6 +86,7 @@ static ssize_t handle_policy_update(struct file *file,
 	pol = kmalloc(sizeof(struct setuid_ruleset), GFP_KERNEL);
 	if (!pol)
 		return -ENOMEM;
+	pol->policy_str = NULL;
 	hash_init(pol->rules);
 
 	p = buf = memdup_user_nul(ubuf, len);
@@ -92,6 +94,11 @@ static ssize_t handle_policy_update(struct file *file,
 		err = PTR_ERR(buf);
 		goto out_free_pol;
 	}
+	pol->policy_str = kstrdup(buf, GFP_KERNEL);
+	if (pol->policy_str == NULL) {
+		err = -ENOMEM;
+		goto out_free_buf;
+	}
 
 	/* policy lines, including the last one, end with \n */
 	while (*p != '\0') {
@@ -135,10 +142,10 @@ static ssize_t handle_policy_update(struct file *file,
 	 * What we really want here is an xchg() wrapper for RCU, but since that
 	 * doesn't currently exist, just use a spinlock for now.
 	 */
-	spin_lock(&policy_update_lock);
+	mutex_lock(&policy_update_lock);
 	rcu_swap_protected(safesetid_setuid_rules, pol,
 			   lockdep_is_held(&policy_update_lock));
-	spin_unlock(&policy_update_lock);
+	mutex_unlock(&policy_update_lock);
 	err = len;
 
 out_free_buf:
@@ -162,7 +169,27 @@ static ssize_t safesetid_file_write(struct file *file,
 	return handle_policy_update(file, buf, len);
 }
 
+static ssize_t safesetid_file_read(struct file *file, char __user *buf,
+				   size_t len, loff_t *ppos)
+{
+	ssize_t res = 0;
+	struct setuid_ruleset *pol;
+	const char *kbuf;
+
+	mutex_lock(&policy_update_lock);
+	pol = rcu_dereference_protected(safesetid_setuid_rules,
+					lockdep_is_held(&policy_update_lock));
+	if (pol) {
+		kbuf = pol->policy_str;
+		res = simple_read_from_buffer(buf, len, ppos,
+					      kbuf, strlen(kbuf));
+	}
+	mutex_unlock(&policy_update_lock);
+	return res;
+}
+
 static const struct file_operations safesetid_file_fops = {
+	.read = safesetid_file_read,
 	.write = safesetid_file_write,
 };
 
@@ -181,7 +208,7 @@ static int __init safesetid_init_securityfs(void)
 		goto error;
 	}
 
-	policy_file = securityfs_create_file("whitelist_policy", 0200,
+	policy_file = securityfs_create_file("whitelist_policy", 0600,
 			policy_dir, NULL, &safesetid_file_fops);
 	if (IS_ERR(policy_file)) {
 		ret = PTR_ERR(policy_file);
-- 
2.21.0.392.gf8f6787159e-goog
