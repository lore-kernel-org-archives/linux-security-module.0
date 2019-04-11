Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A71C10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 20:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69102084D
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 20:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AxDaVDX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDKUMr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:12:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44496 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKUMq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 16:12:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so3963679pfm.11
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eMTDDO7hg7vcj82VEGutxpZ2D4xMOKcVJ8qdeJ+R0i8=;
        b=AxDaVDX/PQoJOKDnb35CeZhh+ck0OWMenkrj+wA6tUvZ+xUgFmwzklEhI6Pysy4IR/
         Rkly4s20ORdEIkhOddBc3+TjXJk8BqeV5q3Jgf1OlbFwLiSa0gU104V+R1TS8P8Dhs1D
         NF948+weo4AOB2CpzvgklerAC0R5VEvZDHnkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eMTDDO7hg7vcj82VEGutxpZ2D4xMOKcVJ8qdeJ+R0i8=;
        b=mugTcvQGhbqAm1o2ANdBFNjCdr02jn30NdkYyhc7P9iCQ/+g8Sz/D8fUdeaRRI51Tw
         lLwSaoFFS7vaGdrvZkPO4zeEdbNUy/BmnQLG4m4mEx2euhoN1C8mDgcDfFcVZrKhHuGf
         PgQb2bNHCIwxtYa+eJWqO1QEfFo+OzznCGpXhawioOhF1YgKLA6y41SG4irTjzJq38cn
         E53E+2XzT0wVbQGeD5abcgud6aSc80TclvzxJLSLZxERSzrjx/TTxxnqG5On0LTn5WHl
         9mLYu+Fo8bmy2rzYURbaimPnDjK7kyvY0B9J9O+MQ/fwRRdRRXUOlBJsKjYoILEtxaDb
         z0Zg==
X-Gm-Message-State: APjAAAU1vyBHwRu09zcBsC355RZ4SG8FMZ2Ki9Wae+3sFCxa90fFXE5Z
        5Tqtr7sJy8D8b2XYFaQ16xEAOw==
X-Google-Smtp-Source: APXvYqwqY0g8USD1U0NsGUXfLqXZYT7GxUHAXPZ8zlfWQbUpFDaHEEjFPNb/zSc1waN2/afQtHfqYw==
X-Received: by 2002:a63:cf0d:: with SMTP id j13mr48970331pgg.34.1555013566262;
        Thu, 11 Apr 2019 13:12:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id v6sm48291662pgv.92.2019.04.11.13.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:12:45 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH v2 09/10] LSM: SafeSetID: verify transitive constrainedness
Date:   Thu, 11 Apr 2019 13:12:43 -0700
Message-Id: <20190411201243.167800-1-mortonm@chromium.org>
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
Changes since the last patch: Instead of failing open when userspace
configures an unconstrained (and vulnerable) policy, fix up the policy
to make sure it is safe by restricting the un-constrained UIDs. Return
EINVAL from the policy write in the case that userspace writes an
unconstrained policy. Also move hash_add() into a small helper function.
 security/safesetid/securityfs.c               | 38 ++++++++++++++++++-
 .../selftests/safesetid/safesetid-test.c      |  4 +-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 997b403c6255..d568e17dd773 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -76,6 +76,37 @@ static void release_ruleset(struct setuid_ruleset *pol)
 	call_rcu(&pol->rcu, __release_ruleset);
 }
 
+static void insert_rule(struct setuid_ruleset *pol, struct setuid_rule *rule)
+{
+	hash_add(pol->rules, &rule->next, __kuid_val(rule->src_uid));
+}
+
+static int verify_ruleset(struct setuid_ruleset *pol)
+{
+	int bucket;
+	struct setuid_rule *rule, *nrule;
+	int res = 0;
+
+	hash_for_each(pol->rules, bucket, rule, next) {
+		if (_setuid_policy_lookup(pol, rule->dst_uid, INVALID_UID) ==
+		    SIDPOL_DEFAULT) {
+			pr_warn("insecure policy detected: uid %d is constrained but transitively unconstrained through uid %d\n",
+				__kuid_val(rule->src_uid),
+				__kuid_val(rule->dst_uid));
+			res = -EINVAL;
+
+			/* fix it up */
+			nrule = kmalloc(sizeof(struct setuid_rule), GFP_KERNEL);
+			if (!nrule)
+				return -ENOMEM;
+			nrule->src_uid = rule->dst_uid;
+			nrule->dst_uid = rule->dst_uid;
+			insert_rule(pol, nrule);
+		}
+	}
+	return res;
+}
+
 static ssize_t handle_policy_update(struct file *file,
 				    const char __user *ubuf, size_t len)
 {
@@ -128,7 +159,7 @@ static ssize_t handle_policy_update(struct file *file,
 			goto out_free_rule;
 		}
 
-		hash_add(pol->rules, &rule->next, __kuid_val(rule->src_uid));
+		insert_rule(pol, rule);
 		p = end + 1;
 		continue;
 
@@ -137,6 +168,11 @@ static ssize_t handle_policy_update(struct file *file,
 		goto out_free_buf;
 	}
 
+	err = verify_ruleset(pol);
+	/* bogus policy falls through after fixing it up */
+	if (err && err != -EINVAL)
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
