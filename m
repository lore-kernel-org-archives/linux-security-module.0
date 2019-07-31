Return-Path: <SRS0=Q99v=V4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EADEC32753
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Jul 2019 22:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21143214DA
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Jul 2019 22:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OA/ewO2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfGaWQn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:16:43 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:44120 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731189AbfGaWQm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 18:16:42 -0400
Received: by mail-ua1-f73.google.com with SMTP id p13so7231405uad.11
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F1VsQKe1CvGe90szBrckBeIyG/tsASbX2ypyWhc14LE=;
        b=OA/ewO2STl/8HuS0PxOzP53cqnJU4I2To46Ls2zbIPrZrcu6dWb3BWrs8Gv7I+OTa/
         8YbrIh1IYkmK0OtcTqi75E137+aNk2E/WFI/YsvmZnzcOaaf98xzsMoisWzYfDfLC2B7
         JN2b+P5R1eLpJX4dG9c9oeCWku4dL7sYsIrkTSNq5KSAuZFriPHkloD2Eg+XpfaeK/Ui
         hlokk/dSOm/77WEK1BNNuhO3N3lFKkSgLy8FYH8Z9lCWel6MAa8V17P6MG633C4Wxbb8
         b+F00xixmbEGqv+LwFArWUhV5ybH8n5Yo5qa0k/kDIAOJb71ElqEWbgXe+hHxUS3Ryct
         U9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F1VsQKe1CvGe90szBrckBeIyG/tsASbX2ypyWhc14LE=;
        b=ox+GfZJbFXDGNiW/wekAQOJ2Wi9xL87U8xZZmt+dAkidefdk1LcXc2ghehmYyODMZi
         tGNDBXqWKdXaTVk+jG4ZtnGDXhqQpuZAnF0sVsvmU0rsgB8pvqtN9dtmK4C4LWydLan6
         hvAtCwVe0RM9fF/GFhGdbIgUgmy/xwLxL893FvgSA22HkB9EiFkJS/d4T2A/kN0FzVUu
         Plag6zZnuzElfshVTaSocHNY8ez+W4HheARv51TIjfnGO16fvfrz9onBubYVXBDsbhBx
         ny3TNtNU9D3XwnJCagQAMcMDFPWSOQ0r6/0Hf8Rpi7MmeZG9PL1dP3wm8JE31yQJWLA+
         Ef/Q==
X-Gm-Message-State: APjAAAUswZexn0DNs/bUcvg6e8hcLqDQTv9u03cRjJlc1t6iVALx/i5F
        7VKPOB17FXadx6QMowzCraIUUFP5xzvHIQYeWJz95A==
X-Google-Smtp-Source: APXvYqx6UQL2kVcMcSAcMfiNdlcC1RYlaghiMf1GsQfTNxHzAwOnaMO09aJRTxLnk22BC2WML6UwPWYSOTr5JgeP2S6utw==
X-Received: by 2002:a05:6102:3c5:: with SMTP id n5mr42332847vsq.56.1564611401552;
 Wed, 31 Jul 2019 15:16:41 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:54 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 06/29] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Dave Young <dyoung@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 8 ++++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9458152601b5..69c5de539e9a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -105,6 +105,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_KEXEC,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1b018f1a6e0d..bc933c0db9bf 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -205,6 +205,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	result = security_locked_down(LOCKDOWN_KEXEC);
+	if (result)
+		return result;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d2ef29d9f0b2..6f302c156bc8 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

