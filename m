Return-Path: <SRS0=y35J=WQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619DBC3A5A0
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3664822D6D
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bj7lFYyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfHTATH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:07 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50649 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfHTATG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:06 -0400
Received: by mail-vk1-f201.google.com with SMTP id s80so2367820vkb.17
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 17:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QVXgaTwVG9VreaH3kje2rc/wKurD8V4CNVZ/noHYMMk=;
        b=bj7lFYyjZn020SZbZOk33R7A56KuaUFVTe2noLL8QdE7HgZxuAhxLaUSgMCukpx3vn
         jvYHzDrs6UZ+J8cEPlybtgzi1a4GcjbDQKj91Fxmq838IZuuR1o01r26YEk81pj8tU4u
         F62FzJH9nZ+M3/4CpkH1ed7675JPtKKC/L3+HwSvIge7LZEdpDlGPnbl0dSL34+lPro0
         e19bCC2w0bloNUoPXX0F3Ow5/Yb0M/32OU5P0qvxdNLrBw0DxhsYs5hAPDuhxvob+LE3
         keTHnblpb76cieqWg1IhWeobmLv4+1YH8q1Yv6SsJ3p7OLDyh54wMAVyugFGEyqVzf8o
         EClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QVXgaTwVG9VreaH3kje2rc/wKurD8V4CNVZ/noHYMMk=;
        b=V1N6GlkyURuzBX5f/equhmFtvSHyazjn5pxM+RMLntpwmK81cBlWkxgI+cAcex+UAX
         o5U9fllmTZ5W36PypRz8PSx0iJYCvBWVBmLI6eQ9rxb0NSk++/KJ6rdKVeiHgPaiftTa
         uQY9ssrwnNaeOuxsVN8yBRGJIDUI6ABH0ODqYmhkZ/mGqsyGkOi2bU5k2HxKNkuwIlP4
         JECA83O1NvNg/it97bthjIvKneL9O6ckQs81nezqj6dG1hdPiN9PSxD98/TwSWAsWCLZ
         jq+jR027buCPgcznVhL11FMUscf9aH7KusdW2YK4IjgK7UOaQfBooSiPH7rKp6FcluAP
         LFDQ==
X-Gm-Message-State: APjAAAUvbY6e4H6rhDTOkWw8nPeif3sC7SDmIhvpxnulBHDu0PMwUkSu
        NCprwlqKa6153gS0FJW7CMIL6p7UM/s0VLBU+MwoUg==
X-Google-Smtp-Source: APXvYqzx0pbLPeq+7iW9FmfOUkB/8f86o5aEj/xOncerWqYh1W5+r4mi86/9A3la/JbE3hLldzHA1rPe+X4GGuSw65luZg==
X-Received: by 2002:a67:d11d:: with SMTP id u29mr15922362vsi.147.1566260344913;
 Mon, 19 Aug 2019 17:19:04 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:57 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 21/29] lockdown: Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data. This is limited to lockdown
confidentiality mode and is still permitted in integrity mode.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: James Morris <jmorris@namei.org>
---
 fs/proc/kcore.c              | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index f5834488b67d..ee2c576cc94e 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -31,6 +31,7 @@
 #include <linux/ioport.h>
 #include <linux/memory.h>
 #include <linux/sched/task.h>
+#include <linux/security.h>
 #include <asm/sections.h>
 #include "internal.h"
 
@@ -545,6 +546,10 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	int ret = security_locked_down(LOCKDOWN_KCORE);
+
+	if (ret)
+		return ret;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index d8db7ea4c4bf..669e8de5299d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,6 +116,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_KCORE,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 2eadbe0667e7..403b30357f75 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -31,6 +31,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

