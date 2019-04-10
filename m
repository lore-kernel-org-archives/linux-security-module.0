Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE3C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16E020830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HCb2Y3eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbfDJQ4B (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:56:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40833 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733175AbfDJQ4B (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:56:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so1774991plr.7
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcnGgMu03T8LTTqVr2mqlTYFf4INWRgM/Q8XomVCOz4=;
        b=HCb2Y3eQjdD8wwXwkVLkmrgLN/r42Os1rjQoIJRqJro9tiVuhlJj98HJT5+7ulbPlF
         e/EAZl9CaIiFTJ08dfyv//yWgoqv4rzonPGmYjP+3LloyW54elbOo/wjZSAU7VYZgx/P
         VjDYK5p3xayWxp9KuoohITIEWFcmuyOjZod+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcnGgMu03T8LTTqVr2mqlTYFf4INWRgM/Q8XomVCOz4=;
        b=ChiieYlqmW2YCANxfEbRPmVQwVtEBAv9mq/vEP3tKwdqfGWyhHJR1Y8ayCNRg0teLD
         jhFjfe65W4umBIxr4BCBLmAzjip0F8VYyFP+435u+hKF0nRqLik+kqlBsRHh2Jrzusjj
         xWpaEzp8lNWDpU7vIeBqD1z/m4wi17i75ydR+Oy4ewaEqN3SQwHrq9yKUQaelHHs/BpI
         HlDraTeIGdf//fKYIo7AZKx+IXqP2eKSymK4BRqr88bCcI472vtSWL0w3XxOlJ9asPwo
         +r5bXW/Gwh3N/DTpHr86IdS3AY5tDlEg0y3HGn0isVrXYcRNnBDP8tu+GXIeW6M326cp
         Ll2g==
X-Gm-Message-State: APjAAAWUV8AdOa6CqYSjR26LANr7/AqmBreqz3g21BD4Q1tSg6PLHt0P
        D3JvdWilF58mFlPzipVNVpGT+A==
X-Google-Smtp-Source: APXvYqxCfAF31tcrDxApn6u0UecgXLlWBk0DFpvCDy7igKFfuB12pg96mzlRZMnnn93uhfNvky54+Q==
X-Received: by 2002:a17:902:e101:: with SMTP id cc1mr45320044plb.129.1554915360626;
        Wed, 10 Apr 2019 09:56:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id m7sm51300435pgg.62.2019.04.10.09.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:56:00 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
X-Google-Original-From: Micah Morton
To:     jmorris@namei.org, keescook@chromium.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 06/10] LSM: SafeSetID: fix userns handling in securityfs
Date:   Wed, 10 Apr 2019 09:55:58 -0700
Message-Id: <20190410165558.211483-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jann Horn <jannh@google.com>

Looking at current_cred() in write handlers is bad form, stop doing that.

Also, let's just require that the write is coming from the initial user
namespace. Especially SAFESETID_WHITELIST_FLUSH requires privilege over all
namespaces, and SAFESETID_WHITELIST_ADD should probably require it as well.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/securityfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 87e42b7f3e33..76c1e8a6ab93 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -59,8 +59,8 @@ static int parse_policy_line(
 	if (ret)
 		return ret;
 
-	*parent = make_kuid(current_user_ns(), parsed_parent);
-	*child = make_kuid(current_user_ns(), parsed_child);
+	*parent = make_kuid(file->f_cred->user_ns, parsed_parent);
+	*child = make_kuid(file->f_cred->user_ns, parsed_child);
 	if (!uid_valid(*parent) || !uid_valid(*child))
 		return -EINVAL;
 
@@ -92,7 +92,7 @@ static ssize_t safesetid_file_write(struct file *file,
 	kuid_t child;
 	int ret;
 
-	if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
+	if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
 		return -EPERM;
 
 	if (*ppos != 0)
-- 
2.21.0.392.gf8f6787159e-goog

