Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B632DC05027
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjBQD1k (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBQD1C (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:27:02 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C624BEA8
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:55 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id y2so3143697qvo.4
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGJTy/KKbGyyQHVdcCeKOFNsWJh1zHVmQkOjCyezJ64=;
        b=O7Qy5BcKOmfzpELQGHbhZTuC9Oe7jDzUHYXEq5HVO4dtduBYHRjDOG/sUUUk4rh/L4
         +LLgI2grtgPKiOm0+iSaAJYbk9V5xVEqRfWGdi943CjsB4bQsipzCBmxCDCZhcjNQsfs
         6mZZi89wKGPtIWZ+XqonyiKE9zVnmshwS1gFVJkAnKXv5MsEkvRTrvXAlTq24qGfNYXS
         4gogdOBRxGaxGKWydZBgsMyqi3vBHhD1UP6fdb78nVY83V3iBXp6y03KtFdqL94v1olL
         ysoVV6YJ1bdQeqca+gD73MukrmxNJm0We9uURvnKnXBu0/GsgVysfCiQUsKQdGCAQYY2
         4dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGJTy/KKbGyyQHVdcCeKOFNsWJh1zHVmQkOjCyezJ64=;
        b=7Ad61qELxhG+JvRw8WRkwFsZf8Wd7tn8JCXfCjukcuB7T9KirJh+QwIo0uDw8E9nQL
         ZuRTJ/3l/IWUdxNnau1cc2bwfmNf4CdoftaY9g8IJAO+FKdCEMCardFICT+GJipDTzIm
         qHw8zOXlGTDtMH2FpZxdlta3K7z+HvNJuzLUkqASiOEyYylsT1X/oI9B7l8me35kUbLX
         X3v848WK1ZMffTbvhxfdqT2P9K4XSrvjWVkJVggGLUwQBvUBxR7HnRXJVfanu/ooaSdX
         uoZbQnEhYJUQHcOOHOK2WAuj4tTSj3SRpWFsqcilVPmkXx4G0Jy+UnE+mRGWM1//iLW6
         1flg==
X-Gm-Message-State: AO0yUKUkOH3AsyFyXRi2pyOLjFLJ5m61W1ITeDXyRk70xqQThdruIAxY
        xXPCaJRXFxQiwWHgthdnzHxcaHCYRhirIk0=
X-Google-Smtp-Source: AK7set8TK7i5qzaYxGtqhCQQFdidVyo4NRm8AgJ0tNUCNQZOuU11w6kMltpAANtn+LUFIVyQ5C1COA==
X-Received: by 2002:a05:6214:1d2e:b0:56f:154:2517 with SMTP id f14-20020a0562141d2e00b0056f01542517mr5892916qvd.10.1676604413896;
        Thu, 16 Feb 2023 19:26:53 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id a143-20020ae9e895000000b007389403f7e6sm2552426qkg.9.2023.02.16.19.26.53
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:53 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 19/22] lsm: move the perf hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:22 -0500
Message-Id: <20230217032625.678457-20-paul@paul-moore.com>
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
 security/security.c       | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 601d1ecdae0f..3d8d430e271a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -196,23 +196,6 @@
  *	@what: kernel feature being accessed.
  *	Return 0 if permission is granted.
  *
- * Security hooks for perf events
- *
- * @perf_event_open:
- *	Check whether the @type of perf_event_open syscall is allowed.
- *	Return 0 if permission is granted.
- * @perf_event_alloc:
- *	Allocate and save perf_event security info.
- *	Return 0 on success, error on failure.
- * @perf_event_free:
- *	Release (free) perf_event security info.
- * @perf_event_read:
- *	Read perf_event security info if allowed.
- *	Return 0 if permission is granted.
- * @perf_event_write:
- *	Write perf_event security info if allowed.
- *	Return 0 if permission is granted.
- *
  * Security hooks for io_uring
  *
  * @uring_override_creds:
diff --git a/security/security.c b/security/security.c
index 8eb0cef761dd..557dbd748f7b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4926,26 +4926,65 @@ int security_locked_down(enum lockdown_reason what)
 EXPORT_SYMBOL(security_locked_down);
 
 #ifdef CONFIG_PERF_EVENTS
+/**
+ * security_perf_event_open() - Check if a perf event open is allowed
+ * @attr: perf event attribute
+ * @type: type of event
+ *
+ * Check whether the @type of perf_event_open syscall is allowed.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_perf_event_open(struct perf_event_attr *attr, int type)
 {
 	return call_int_hook(perf_event_open, 0, attr, type);
 }
 
+/**
+ * security_perf_event_alloc() - Allocate a perf event LSM blob
+ * @event: perf event
+ *
+ * Allocate and save perf_event security info.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_perf_event_alloc(struct perf_event *event)
 {
 	return call_int_hook(perf_event_alloc, 0, event);
 }
 
+/**
+ * security_perf_event_free() - Free a perf event LSM blob
+ * @event: perf event
+ *
+ * Release (free) perf_event security info.
+ */
 void security_perf_event_free(struct perf_event *event)
 {
 	call_void_hook(perf_event_free, event);
 }
 
+/**
+ * security_perf_event_read() - Check if reading a perf event label is allowed
+ * @event: perf event
+ *
+ * Read perf_event security info if allowed.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_perf_event_read(struct perf_event *event)
 {
 	return call_int_hook(perf_event_read, 0, event);
 }
 
+/**
+ * security_perf_event_write() - Check if writing a perf event label is allowed
+ * @event: perf event
+ *
+ * Write perf_event security info if allowed.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_perf_event_write(struct perf_event *event)
 {
 	return call_int_hook(perf_event_write, 0, event);
-- 
2.39.2

