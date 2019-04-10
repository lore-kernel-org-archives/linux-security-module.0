Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3096C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17AA20830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dzwEU+8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDJQ4Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:56:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44934 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDJQ4Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:56:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so1820441pfm.11
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRKzXLFLbU7DMEk2P3khrapG+d6oPZs96LbWtLYN8Sg=;
        b=dzwEU+8/ifknUJSDQSEGD2onmSUM+mnKSoWkThQTGZijr7a3ew9MVszjoI6s3EmdoC
         WoILFaqpKs007WoR19H6s1zAdDT15xGgK3Pf1TkRUGqFW4OkAMkTgdaXpjGEDQkZUFUM
         4Bq18q4YI7lL2WJ2NwOvXfJFHxAN2dtsIv4pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRKzXLFLbU7DMEk2P3khrapG+d6oPZs96LbWtLYN8Sg=;
        b=azRXN4EPTemjwFTzpIY0GG2jT0wbtpmoszBVTpzCUFeLhHRUh9cYCiIC97FEhGUqCi
         TXhTdWNSboU4iigLKWj4XsVjRr5SGHF97SdGthADBVWiD7p9ddiiODuP/X9qlpR99StT
         lwftN98XmJ+rNP/k5ZeQK1Uxj3rL+Q+qT9LxQCcXmVQZcinUn3YLA1dHG6DIiawYeXt0
         Ux4Fe2oYJea5SJR94LjNrh2DAFZ9Ej12e/3IDGGquNhTJBsV+QJp0EVTq8O+etNE5R4n
         hbAMPWYTrgdFBhc61XNgh3OMnQISC8AszfV1A2SR1UOGJcEvQuqStl5RCafRoEI/r/11
         n6Zw==
X-Gm-Message-State: APjAAAWBkVsBpHvbT4vQGxWtO9deHdGP2nN5v5rXFTS3rWtyYXdvXV58
        MGzlzSNRSP40O8xXgmAT6RD8TQ==
X-Google-Smtp-Source: APXvYqxiGciZgRntaw28fluPyiT8H8A8wD1P+4/hmFhaKSe6bH7Vcapowg+aaQcOpAmenBOAoOBvQQ==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr43525299pff.35.1554915375289;
        Wed, 10 Apr 2019 09:56:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id t82sm97551836pfa.153.2019.04.10.09.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:56:14 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 08/10] LSM: SafeSetID: add read handler
Date:   Wed, 10 Apr 2019 09:56:13 -0700
Message-Id: <20190410165613.212056-1-mortonm@chromium.org>
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
 security/safesetid/lsm.h        |  3 +++
 security/safesetid/securityfs.c | 38 +++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index 4a34f558d964..9380329fe30a 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/uidgid.h>
 #include <linux/hashtable.h>
+#include <linux/refcount.h>
 
 /* Flag indicating whether initialization completed */
 extern int safesetid_initialized;
@@ -41,7 +42,9 @@ struct setuid_rule {
 
 struct setuid_ruleset {
 	DECLARE_HASHTABLE(rules, SETID_HASH_BITS);
+	char *policy_str;
 	struct rcu_head rcu;
+	refcount_t refcount;
 };
 
 enum sid_policy_type _setuid_policy_lookup(struct setuid_ruleset *policy,
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 13fce4c10930..7a08fff2bc14 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -67,12 +67,14 @@ static void __release_ruleset(struct rcu_head *rcu)
 
 	hash_for_each_safe(pol->rules, bucket, tmp, rule, next)
 		kfree(rule);
+	kfree(pol->policy_str);
 	kfree(pol);
 }
 
 static void release_ruleset(struct setuid_ruleset *pol)
 {
-	call_rcu(&pol->rcu, __release_ruleset);
+	if (pol != NULL && refcount_dec_and_test(&pol->refcount))
+		call_rcu(&pol->rcu, __release_ruleset);
 }
 
 static ssize_t handle_policy_update(struct file *file,
@@ -85,6 +87,8 @@ static ssize_t handle_policy_update(struct file *file,
 	pol = kmalloc(sizeof(struct setuid_ruleset), GFP_KERNEL);
 	if (!pol)
 		return -ENOMEM;
+	refcount_set(&pol->refcount, 1);
+	pol->policy_str = NULL;
 	hash_init(pol->rules);
 
 	p = buf = memdup_user_nul(ubuf, len);
@@ -92,6 +96,11 @@ static ssize_t handle_policy_update(struct file *file,
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
@@ -162,7 +171,32 @@ static ssize_t safesetid_file_write(struct file *file,
 	return handle_policy_update(file, buf, len);
 }
 
+static ssize_t safesetid_file_read(struct file *file, char __user *buf,
+				   size_t len, loff_t *ppos)
+{
+	ssize_t res;
+	struct setuid_ruleset *pol;
+	const char *kbuf;
+
+	rcu_read_lock();
+	pol = rcu_dereference(safesetid_setuid_rules);
+	if (!pol) {
+		rcu_read_unlock();
+		return 0;
+	}
+	if (!refcount_inc_not_zero(&pol->refcount)) {
+		rcu_read_unlock();
+		return -EBUSY;
+	}
+	rcu_read_unlock();
+	kbuf = pol->policy_str;
+	res = simple_read_from_buffer(buf, len, ppos, kbuf, strlen(kbuf));
+	release_ruleset(pol);
+	return res;
+}
+
 static const struct file_operations safesetid_file_fops = {
+	.read = safesetid_file_read,
 	.write = safesetid_file_write,
 };
 
@@ -181,7 +215,7 @@ static int __init safesetid_init_securityfs(void)
 		goto error;
 	}
 
-	policy_file = securityfs_create_file("whitelist_policy", 0200,
+	policy_file = securityfs_create_file("whitelist_policy", 0600,
 			policy_dir, NULL, &safesetid_file_fops);
 	if (IS_ERR(policy_file)) {
 		ret = PTR_ERR(policy_file);
-- 
2.21.0.392.gf8f6787159e-goog

