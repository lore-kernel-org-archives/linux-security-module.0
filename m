Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A247C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35DC20830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQ0CQoUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbfDJQzw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:55:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38590 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733244AbfDJQzw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:55:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so1836456pfo.5
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LajVu4VslfAgWMA/TCWVbfoWVgf035evlD8l/6dvzDA=;
        b=kQ0CQoUHh3aQKwsIc5oTSMfjEAkytF+fmvsLLtAd597bHixYk76l2GM3xLY0hD2uhM
         Co5glDlTZvQZRdbBzNsEZCgFTYetWLMEVI85M9I3ev0E7qHv/GFgrkj6Gy9DtQJJXMje
         NJpPN4tEgPwJ4LwPiWgpiPPTJYm1AgBOapup4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LajVu4VslfAgWMA/TCWVbfoWVgf035evlD8l/6dvzDA=;
        b=lz3oOl87/M2Dh7H4d7LO/RyFVzgYRd+GgX0sIQtyWLrrzINZ5aqR5HweQA9buosDyB
         e+WNY3KJXjmQ74z3PjUoK7aPhkveRC7LYv8WmBQ1rYCdQRDtw/S9k3e4Rzd2xlHEws3e
         jeq0Mzv1fCffcv+brp1Vmb3GSwOh4fiXJ8Ecj4EN9jkYnLgQaDp6J+odkMo9Cv8QpvrA
         JUYrVC23sEjP9eM4uY1kSEKB3TEGy1pQCNrbtYjstDz3fA4sohkIjX4DDeBIci46X7lc
         UCYcPBHjHIzBw6P0CiJcHM1/t1cazP137gpWQJNc79U1H0PjEshqsbeJpy6kk65uWam1
         rETg==
X-Gm-Message-State: APjAAAULP7A8naBzOfOrZRPna9oe4fb4PysHq733sGlWMUb+iuu9X0GC
        zQT8YTYDyLRi6g7UbIte881IlCItJVH9wA==
X-Google-Smtp-Source: APXvYqzKsVa2LAgw7WoNeoww6g0MV040hhphYGcsvfFnXToV+1YCiT/+ztYmTCaHuQNBuXjm1LrH8g==
X-Received: by 2002:a63:bd52:: with SMTP id d18mr41966787pgp.52.1554915351455;
        Wed, 10 Apr 2019 09:55:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id x16sm78186086pge.27.2019.04.10.09.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:55:50 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 05/10] LSM: SafeSetID: refactor policy parsing
Date:   Wed, 10 Apr 2019 09:55:48 -0700
Message-Id: <20190410165548.211254-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

In preparation for changing the policy parsing logic, refactor the line
parsing logic to be less verbose and move it into a separate function.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
I made a minor change to Jann's original patch to use u32 instead of
s32 for the 'parsed_parent' and 'parsed_child' variables.

 security/safesetid/securityfs.c | 84 +++++++++++++--------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 2c6c829be044..90784a8d950a 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -33,68 +33,50 @@ static struct safesetid_file_entry safesetid_files[] = {
 
 /*
  * In the case the input buffer contains one or more invalid UIDs, the kuid_t
- * variables pointed to by 'parent' and 'child' will get updated but this
+ * variables pointed to by @parent and @child will get updated but this
  * function will return an error.
+ * Contents of @buf may be modified.
  */
-static int parse_safesetid_whitelist_policy(const char __user *buf,
-					    size_t len,
-					    kuid_t *parent,
-					    kuid_t *child)
+static int parse_policy_line(
+	struct file *file, char *buf, kuid_t *parent, kuid_t *child)
 {
-	char *kern_buf;
-	char *parent_buf;
-	char *child_buf;
-	const char separator[] = ":";
+	char *child_str;
 	int ret;
-	size_t first_substring_length;
-	long parsed_parent;
-	long parsed_child;
+	u32 parsed_parent, parsed_child;
 
-	/* Duplicate string from user memory and NULL-terminate */
-	kern_buf = memdup_user_nul(buf, len);
-	if (IS_ERR(kern_buf))
-		return PTR_ERR(kern_buf);
-
-	/*
-	 * Format of |buf| string should be <UID>:<UID>.
-	 * Find location of ":" in kern_buf (copied from |buf|).
-	 */
-	first_substring_length = strcspn(kern_buf, separator);
-	if (first_substring_length == 0 || first_substring_length == len) {
-		ret = -EINVAL;
-		goto free_kern;
-	}
-
-	parent_buf = kmemdup_nul(kern_buf, first_substring_length, GFP_KERNEL);
-	if (!parent_buf) {
-		ret = -ENOMEM;
-		goto free_kern;
-	}
+	/* Format of |buf| string should be <UID>:<UID>. */
+	child_str = strchr(buf, ':');
+	if (child_str == NULL)
+		return -EINVAL;
+	*child_str = '\0';
+	child_str++;
 
-	ret = kstrtol(parent_buf, 0, &parsed_parent);
+	ret = kstrtou32(buf, 0, &parsed_parent);
 	if (ret)
-		goto free_both;
+		return ret;
 
-	child_buf = kern_buf + first_substring_length + 1;
-	ret = kstrtol(child_buf, 0, &parsed_child);
+	ret = kstrtou32(child_str, 0, &parsed_child);
 	if (ret)
-		goto free_both;
+		return ret;
 
 	*parent = make_kuid(current_user_ns(), parsed_parent);
-	if (!uid_valid(*parent)) {
-		ret = -EINVAL;
-		goto free_both;
-	}
-
 	*child = make_kuid(current_user_ns(), parsed_child);
-	if (!uid_valid(*child)) {
-		ret = -EINVAL;
-		goto free_both;
-	}
+	if (!uid_valid(*parent) || !uid_valid(*child))
+		return -EINVAL;
 
-free_both:
-	kfree(parent_buf);
-free_kern:
+	return 0;
+}
+
+static int parse_safesetid_whitelist_policy(
+	struct file *file, const char __user *buf, size_t len,
+	kuid_t *parent, kuid_t *child)
+{
+	char *kern_buf = memdup_user_nul(buf, len);
+	int ret;
+
+	if (IS_ERR(kern_buf))
+		return PTR_ERR(kern_buf);
+	ret = parse_policy_line(file, kern_buf, parent, child);
 	kfree(kern_buf);
 	return ret;
 }
@@ -121,8 +103,8 @@ static ssize_t safesetid_file_write(struct file *file,
 		flush_safesetid_whitelist_entries();
 		break;
 	case SAFESETID_WHITELIST_ADD:
-		ret = parse_safesetid_whitelist_policy(buf, len, &parent,
-								 &child);
+		ret = parse_safesetid_whitelist_policy(file, buf, len,
+						       &parent, &child);
 		if (ret)
 			return ret;
 
-- 
2.21.0.392.gf8f6787159e-goog

