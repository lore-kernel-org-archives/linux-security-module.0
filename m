Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C8C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C2120830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqN+sxxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfDJQyn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:54:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34152 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbfDJQyn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:54:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so1920415pgq.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrcHL0kMBw/SvjlhZQb5Lz2YkuzTjIC+UsSx0C/4214=;
        b=RqN+sxxUNazXMPmh1vqpGzL0oHUJpijlK2g8/8klMYjd+UBcv562haiJjgovGLO15g
         y+UHZ3A7Ebu4H9ZRyjmaEZVfn126Rgv7RYeyF2SMlp/IL64kfqnC7dKQI8cMlNlVTjt8
         ieJQFeRIgd1QaumLJw5xbvPtQhsyu8VmN7r+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrcHL0kMBw/SvjlhZQb5Lz2YkuzTjIC+UsSx0C/4214=;
        b=e7r8j2PVHie0gXtChoLCGiNP/oZu/VqlCH3aIu8lYLK/ha3qzF/gBN5Sa5LrQWsmfR
         JmMSQzl69QMBXRsLb5PXojmyZSsOfRO8hSi0eaB2aqOfsEyqDW7IbkBMp7GWdVvXCJhr
         6wm92wKsipyhQ+Hp/v3Uzyh5xslvKrVvgdKLD066WRs7W5pFP7dgCrypOh5nk5h22l/o
         jWPDqUa3BzWd2B9h/sVQNu0qHLJ+7uCoTS40d2ftJh0QEToK/9wwbQIGtmN4uo1byIOQ
         +DKMMpAPwfnh1z7Tyox/SkOwjGFGDUbOVL3VDMSf/9DWXzrATnHTbRjXIdZa2iIZNWAI
         EPZw==
X-Gm-Message-State: APjAAAVupCfYSI29hYcwSOZIGUXSR6I07BXf3OqrXg3dZWqwk9SKrhUH
        LMBWHP+5VsmajU2m0mX8JcKvLg==
X-Google-Smtp-Source: APXvYqxmrI89ehpm68s5ZXHOF6SE4j7Julbv7LyNMhlWUzRwcFYPPnI1VbsST/V+oEdG1wo2L52VQg==
X-Received: by 2002:a62:415d:: with SMTP id o90mr44476618pfa.236.1554915282625;
        Wed, 10 Apr 2019 09:54:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id a3sm3439841pgj.89.2019.04.10.09.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:54:41 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 01/10] LSM: SafeSetID: fix pr_warn() to include newline
Date:   Wed, 10 Apr 2019 09:54:34 -0700
Message-Id: <20190410165434.206579-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

Fix the pr_warn() calls in the SafeSetID LSM to have newlines at the end.
Without this, denial messages will be buffered as incomplete lines in
log_output(), and will then only show up once something else prints into
dmesg.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index cecd38e2ac80..2daecab3a4c0 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -91,7 +91,7 @@ static int safesetid_security_capable(const struct cred *cred,
 			 * to functionality other than calling set*uid() (e.g.
 			 * allowing user to set up userns uid mappings).
 			 */
-			pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions",
+			pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
 				__kuid_val(cred->uid));
 			return -1;
 		}
@@ -103,7 +103,7 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
 {
 	if (check_setuid_policy_hashtable_key_value(parent, child))
 		return 0;
-	pr_warn("UID transition (%d -> %d) blocked",
+	pr_warn("UID transition (%d -> %d) blocked\n",
 		__kuid_val(parent),
 		__kuid_val(child));
 	/*
-- 
2.21.0.392.gf8f6787159e-goog

