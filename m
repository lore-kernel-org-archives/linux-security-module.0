Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEDFC636D4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjBQD1l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBQD1D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:27:03 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41CB5A395
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:56 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id t8so3133363qvr.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9cXi8vvXPR0wKFluf79d1bkz/E0cEEMbKHBRKBLXCY=;
        b=XJhx7QhnL+6lV+KybLEKzlEfhOwp4HUrfgozM8JynyFLvSGqSFomlGgztqIIooKz8y
         3xxkWBcJrV6my2hVA2t6UAGwpM1hPOJ3kvRpT+cK9qvmRDlZOMT4lf0KIlW5KNhmV3yo
         c5Qc+AajXDvSjHuFSrkkSATvw5AoR0IbK0rDadaxjn/JuIU7AYAS97RLUr8lkjM4TOka
         TG+CP9RZWXjxwz86lM3A1wDN27kj3CR17nFKmTm8VVz/ka2imk1pP/4d9eYJLQm9bMcQ
         6wkyhxBRcT8EXrgv8qqJZJOtYrDJCL4Sg1sF4NfiS16G4RZ8YLvKhuRqqqZewc3yy8Y6
         Mt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9cXi8vvXPR0wKFluf79d1bkz/E0cEEMbKHBRKBLXCY=;
        b=ox6mZgF5WGP2yoybKfCt2StXRj/Su2nEBNAx+3L5Hih08jPLaIjiNV6LVXigvv70Do
         7+bER3B8FRGsFFIMLqXLrTpQSUuvExtpDLVXdi/mb5uDnqSD+mtZ949R7Hku0W0CMwkI
         0l7/UzlJ3g8YUJoEuD6/cQDt/12O4TXyKib7+QvVEuWWERU+5r2ktY+/I7Qzd7unH4A3
         vSrTwh0M4H9H0Aswp/1FOTjOSoASM9q3vg4NvnDWuDJ1c0EfyStYpBkpdhJvlMdd2GVK
         lfolFkgizpog6ov6Mr8bHGzIPA5bUaGjZDa2SU8l+ShEESjrhcV9J7GB8PGFROaN2OOr
         JGew==
X-Gm-Message-State: AO0yUKX6Qa5NBKsCezw/uayCyWZ8zmKMqjFpRIQtIvmXTWJ5dhr5Krlq
        aZFvt36jlohbJW03GqE4ale71vLWmYFIs0c=
X-Google-Smtp-Source: AK7set9a6exRM9GGfiXHamXgZ56J1thFZUuyM2cQgXxpIn0H0FOnJTtUoDLPNYYv0N7vbLwmq+WRfg==
X-Received: by 2002:a05:6214:1ccb:b0:56e:961a:b454 with SMTP id g11-20020a0562141ccb00b0056e961ab454mr7770564qvd.21.1676604415232;
        Thu, 16 Feb 2023 19:26:55 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id o62-20020a374141000000b0073b676274e7sm2460142qka.94.2023.02.16.19.26.54
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:54 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 20/22] lsm: move the io_uring hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:23 -0500
Message-Id: <20230217032625.678457-21-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch relocates the LSM hook function comments to the function
definitions, in keeping with the current kernel conventions.  This
should make the hook descriptions more easily discoverable and easier
to maintain.

While formatting changes have been done to better fit the kernel-doc
style, content changes have been kept to a minimum and limited to
text which was obviously incorrect and/or outdated.  It is expected
the future patches will improve the quality of the function header
comments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 17 -----------------
 security/security.c       | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3d8d430e271a..8e006df1db56 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -196,23 +196,6 @@
  *	@what: kernel feature being accessed.
  *	Return 0 if permission is granted.
  *
- * Security hooks for io_uring
- *
- * @uring_override_creds:
- *	Check if the current task, executing an io_uring operation, is allowed
- *	to override it's credentials with @new.
- *	@new: the new creds to use.
- *	Return 0 if permission is granted.
- *
- * @uring_sqpoll:
- *	Check whether the current task is allowed to spawn a io_uring polling
- *	thread (IORING_SETUP_SQPOLL).
- *	Return 0 if permission is granted.
- *
- * @uring_cmd:
- *	Check whether the file_operations uring_cmd is allowed to run.
- *	Return 0 if permission is granted.
- *
  */
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
diff --git a/security/security.c b/security/security.c
index 557dbd748f7b..f4b093673ca6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4992,15 +4992,41 @@ int security_perf_event_write(struct perf_event *event)
 #endif /* CONFIG_PERF_EVENTS */
 
 #ifdef CONFIG_IO_URING
+/**
+ * security_uring_override_creds() - Check if overriding creds is allowed
+ * @new: new credentials
+ *
+ * Check if the current task, executing an io_uring operation, is allowed to
+ * override it's credentials with @new.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_uring_override_creds(const struct cred *new)
 {
 	return call_int_hook(uring_override_creds, 0, new);
 }
 
+/**
+ * security_uring_sqpoll() - Check if IORING_SETUP_SQPOLL is allowed
+ *
+ * Check whether the current task is allowed to spawn a io_uring polling thread
+ * (IORING_SETUP_SQPOLL).
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_uring_sqpoll(void)
 {
 	return call_int_hook(uring_sqpoll, 0);
 }
+
+/**
+ * security_uring_cmd() - Check if a io_uring passthrough command is allowed
+ * @ioucmd: command
+ *
+ * Check whether the file_operations uring_cmd is allowed to run.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_uring_cmd(struct io_uring_cmd *ioucmd)
 {
 	return call_int_hook(uring_cmd, 0, ioucmd);
-- 
2.39.2

