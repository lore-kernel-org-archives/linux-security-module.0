Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4C0C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A1120830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P5sUy1sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfDJQ4W (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:56:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43830 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDJQ4W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:56:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so1764208plp.10
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NN44NkEtMVXdxkdk12Rk4J66J5+HedQJJJFmuyRC6Q=;
        b=P5sUy1sdYbrIg8zBxDwDOeVLkcU5AazfpXn+Hm20jWmu+GylPYbzpMtindewvQeWIs
         9YEVcN4vijoBLkZNKodqVRAhkxpNmOi9jSyR934yNfx58gmsOMWav3q+vy0VbJznTDce
         mRmSEzwh12WEpl2ZAmRMxVY4iktiiQixp7JKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NN44NkEtMVXdxkdk12Rk4J66J5+HedQJJJFmuyRC6Q=;
        b=BIwFqA/OF0h6T8uSmySAI3ypcq2s1+hUA8z0ytb9JFFpus8v1saEHUnN2tpQZ4vt8i
         9NpUNDoIqKvRjo42mjfEIClrjkKxBcgmCKkF2h04ZG/T3UIscGtmZLxtQa8silM6AIP/
         XaXx85nl0odZvwsLmpmBWDdccyhRGDL/gcrQY5y/NwkumNSTXlI9NBG/kLIt22e3yd1m
         JtWLAMfHzNeriDqStJZ5lZbhaX1eSrrZfnLLTqCrxdQNlGVYXdAB14XxgBnyYo3V/s5q
         makqez+YYSggADSvGSJdHjqhOv8AfoZkLPl/umEzkrLNno+hE8KF8cBZtqk86W0xRPr5
         faCw==
X-Gm-Message-State: APjAAAX0zkFk0V93pSBN/I6jod26RgDXzV8AuKJ9+KtrPMWDy2/8g6Ph
        GY9BzFskYAMDvaWNL+UInL6kYQ==
X-Google-Smtp-Source: APXvYqysw3rtGdFoXsXB9UOo8SQwcWeY3mp9GzptMEfSv1lsYy4EZAB0Vr5sk+f9kA7eFq2qzvmk7Q==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr45560048plz.216.1554915382045;
        Wed, 10 Apr 2019 09:56:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id j6sm48606518pfe.107.2019.04.10.09.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:56:21 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 09/10] LSM: SafeSetID: verify transitive constrainedness
Date:   Wed, 10 Apr 2019 09:56:19 -0700
Message-Id: <20190410165619.212464-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

Someone might write a ruleset like the following, expecting that it
securely constrains UID 1 to UIDs 1, 2 and 3:

    1:2
    1:3

However, because no constraints are applied to UIDs 2 and 3, an attacker
with UID 1 can simply first switch to UID 2, then switch to any UID from
there. The secure way to write this ruleset would be:

    1:2
    1:3
    2:2
    3:3

, which uses "transition to self" as a way to inhibit the default-allow
policy without allowing anything specific.

This is somewhat unintuitive. To make sure that policy authors don't
accidentally write insecure policies because of this, let the kernel verify
that a new ruleset does not contain any entries that are constrained, but
transitively unconstrained.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/securityfs.c               | 21 +++++++++++++++++++
 .../selftests/safesetid/safesetid-test.c      |  4 +++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 7a08fff2bc14..3ec64487f0e9 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -77,6 +77,23 @@ static void release_ruleset(struct setuid_ruleset *pol)
 		call_rcu(&pol->rcu, __release_ruleset);
 }
 
+static int verify_ruleset(struct setuid_ruleset *pol)
+{
+	int bucket;
+	struct setuid_rule *rule;
+
+	hash_for_each(pol->rules, bucket, rule, next) {
+		if (_setuid_policy_lookup(pol, rule->dst_uid, INVALID_UID) ==
+		    SIDPOL_DEFAULT) {
+			pr_warn("insecure policy rejected: uid %d is constrained but transitively unconstrained through uid %d\n",
+				__kuid_val(rule->src_uid),
+				__kuid_val(rule->dst_uid));
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static ssize_t handle_policy_update(struct file *file,
 				    const char __user *ubuf, size_t len)
 {
@@ -139,6 +156,10 @@ static ssize_t handle_policy_update(struct file *file,
 		goto out_free_buf;
 	}
 
+	err = verify_ruleset(pol);
+	if (err)
+		goto out_free_buf;
+
 	/*
 	 * Everything looks good, apply the policy and release the old one.
 	 * What we really want here is an xchg() wrapper for RCU, but since that
diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index 4f03813d1911..8f40c6ecdad1 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -144,7 +144,9 @@ static void write_policies(void)
 {
 	static char *policy_str =
 		"1:2\n"
-		"1:3\n";
+		"1:3\n"
+		"2:2\n"
+		"3:3\n";
 	ssize_t written;
 	int fd;
 
-- 
2.21.0.392.gf8f6787159e-goog

