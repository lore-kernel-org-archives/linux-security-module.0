Return-Path: <SRS0=m0b+=VP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09351C76196
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D236521849
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vodmcAMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbfGRTpP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:45:15 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37408 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403850AbfGRTpO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 15:45:14 -0400
Received: by mail-pg1-f202.google.com with SMTP id n9so13826106pgq.4
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mT71xXVMH/YHXOSXzvPL0YxfKiIdabN6lyP5dpCrImQ=;
        b=vodmcAMnUh0hMddJHJka9lcA79+EsuKYh9jQ/nRDimpHP2j8dNS8ZkNSHnz15Zmqxx
         8T5PpWkIyrO0Ihi3lsLVJAiZ97yw/aI99IUsFCTgFUHjyHhUXbNSNcTg9QWvbAzg/tNt
         L0PHpzxXoK70mVorxkpV8am65v+xyxN+KJAg3OvNkHdHIRddY3OJPlIZqkHhPdmzVq91
         ltHihVyene7ZHPNesB5qECUzVqNVMvBNHmTKBQA2VOJBmbaUJKj9vBz4inT8xG7TzG/S
         HB7ijyroYoriT/1w/4121SWUE7G78gYZB+0NUbyp6tIzdK2uWXRNVrrNFKG1qVdw25Lx
         fKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mT71xXVMH/YHXOSXzvPL0YxfKiIdabN6lyP5dpCrImQ=;
        b=X4M01BBQf7r+b9imgFp1wFwyJpDBFZqwWcMPRSbqfbNDiyeIVirGNWFJ1v3M8W7DgL
         SAsaSteJG+OGB5EQRusht0+Q+cFX/dKFJZ5YciyMHke8pgZ0HsYk9sToXL01lTtVeVno
         5pxi+TfPl50Au3jfk50PtgCY8mxhU4NPJSMsjkhNWJoHIxp5OOsfgO15OkT/9AWyhCXm
         vLNPj1w/XwlobLmpHvxuDrKkx3NZXYMRxDnNoHxHjFMabT/SZoCLoUQx47URS/BdForF
         rGogUaJRCd072chIIiKvQ3xdeapETp7QO/z49mlYALiTnvT3nqphqo7NzcDNkx93WbW5
         r23g==
X-Gm-Message-State: APjAAAWDVkq8ppOl9vAtoLLZgI8YUdSPhEyMuiO2sDqOmLdAnHM9kFoh
        tvGXvaKixMvnIABykdBVF65NcRTyxormIzZmx1agmQ==
X-Google-Smtp-Source: APXvYqzvoYeByMb8GuABYxGSZRPpcq3M3gaVftP8ooVueZdKIuBRQTXo4VTviDY8kkeRKzQJJaR/UejRFk1iKrC5nLfDZw==
X-Received: by 2002:a65:5304:: with SMTP id m4mr48981605pgq.126.1563479112898;
 Thu, 18 Jul 2019 12:45:12 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:07 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-22-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 21/29] Lock down /proc/kcore
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
index 3f7b6a4cd65a..f0cffd0977d3 100644
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
index 37b7d7e50474..c050b82c7f9f 100644
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
2.22.0.510.g264f2c817a-goog

