Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03490C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43DD20830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iXmRcGaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbfDJQzo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:55:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38727 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733280AbfDJQzo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:55:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so1909157pgl.5
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUypBXodY0erBeXTZIWhrSekmLh1Upz6H7xhxGfMPp8=;
        b=iXmRcGafMKXhqrkM/O42SJ440W8Sn6EjyAjOBPdv9k4DhE9eaxnVjF8C26h3YhpHaO
         akEs46eUKe/FHGzHqweV2IIxWBa90cso0kTTNVUG3nWv6iGMIXa8ntYjA6dv8/8RaXIh
         N1J3EtGu1e+9dqWFBhWbK26coCgcNz6h3a9n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eUypBXodY0erBeXTZIWhrSekmLh1Upz6H7xhxGfMPp8=;
        b=ZBJfx4vO8ZpSGe0BVFPsH9BHo+zy1d8RQ+gcd+7pcBr1k418hGBfb0HEwMN8YtTeLY
         SUUPGIcLBm23swFt6fCk+/NQYLwV5LU+YH3VT6Hg2ngYgz1QCxJmsYir+Oj5lfuiWAV+
         8w/RG3NqCBCVHIjxYVUtbmhxNZ7h+qe4+JhE1j+LxQ83VWbiuzZggxl309tGYCf1cNGm
         D4XdQZs94j7BvKqLMaN4ApT6CTUVVx6wSTP0BZB/pOQQ8OFWQarzzuRRY9k+sbrSMovg
         6aHQBHXUPIp3yVvghy1zRFmHIVa0PPR3YVMwaMKJzHvrRgwLTtDmt+6auEAkmpPkrYqE
         NyaQ==
X-Gm-Message-State: APjAAAUI+M9GzPS/9J2ldFzh54S735otPiEFHDRwP0iFOuBCK81pAyp4
        xFtHZ4Ysgr4rq3zOhc76wMmvAghyOReNpw==
X-Google-Smtp-Source: APXvYqzdhBRy2mW3GisaU62Gu3iLGqOTO9Dq6+04sOB2+FOMrQEExsFYMklkmipMQ/tFFX8f/q4Jbw==
X-Received: by 2002:a63:c45:: with SMTP id 5mr42420066pgm.385.1554915343483;
        Wed, 10 Apr 2019 09:55:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id h1sm24857345pgs.67.2019.04.10.09.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:55:43 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 04/10] LSM: SafeSetID: refactor safesetid_security_capable()
Date:   Wed, 10 Apr 2019 09:55:41 -0700
Message-Id: <20190410165541.210809-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

At the moment, safesetid_security_capable() has two nested conditional
blocks, and one big comment for all the logic. Chop it up and reduce the
amount of indentation.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/lsm.c | 41 +++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 15cd13b5a211..ab429e1816c5 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -55,21 +55,32 @@ static int safesetid_security_capable(const struct cred *cred,
 				      int cap,
 				      unsigned int opts)
 {
-	if (cap == CAP_SETUID &&
-	    setuid_policy_lookup(cred->uid, INVALID_UID) != SIDPOL_DEFAULT) {
-		if (!(opts & CAP_OPT_INSETID)) {
-			/*
-			 * Deny if we're not in a set*uid() syscall to avoid
-			 * giving powers gated by CAP_SETUID that are related
-			 * to functionality other than calling set*uid() (e.g.
-			 * allowing user to set up userns uid mappings).
-			 */
-			pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
-				__kuid_val(cred->uid));
-			return -1;
-		}
-	}
-	return 0;
+	/* We're only interested in CAP_SETUID. */
+	if (cap != CAP_SETUID)
+		return 0;
+
+	/*
+	 * If CAP_SETUID is currently used for a set*uid() syscall, we want to
+	 * let it go through here; the real security check happens later, in the
+	 * task_fix_setuid hook.
+	 */
+	if ((opts & CAP_OPT_INSETID) != 0)
+		return 0;
+
+	/*
+	 * If no policy applies to this task, allow the use of CAP_SETUID for
+	 * other purposes.
+	 */
+	if (setuid_policy_lookup(cred->uid, INVALID_UID) == SIDPOL_DEFAULT)
+		return 0;
+
+	/*
+	 * Reject use of CAP_SETUID for functionality other than calling
+	 * set*uid() (e.g. setting up userns uid mappings).
+	 */
+	pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
+		__kuid_val(cred->uid));
+	return -1;
 }
 
 /*
-- 
2.21.0.392.gf8f6787159e-goog

