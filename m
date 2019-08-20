Return-Path: <SRS0=y35J=WQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA02C3A5A5
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09382339D
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SvGMP+S6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfHTAUM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:20:12 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55125 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbfHTASo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:44 -0400
Received: by mail-pf1-f202.google.com with SMTP id y66so3513279pfb.21
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=28L+ehB4vT7SQwhr1GVEAssWYqpFu3ff7CisXtvvxdY=;
        b=SvGMP+S6tMmZzB+fw4HPKsKm+2MzyO3OimsS0WVncAijxpLHKoBqaTGUEm9cRs2F3g
         JFUqTBIEbmfxGZMI708DrwMp7SC9bYp0+w98WIkUwTk7xD2TQ/plYib5XDtlmzInzPK4
         Bl15YFCF7X65kaqgC0Jq7joAWDh7/aaHOFj97YCrlK/WTgaq58IRXzDQei3jcJd9JEf1
         8zt90+b0w3jm7dsVXxx3U8USdMIbQTQegNG5MEYO04d4lN/NdioBvpCVsa65qQjwjwpJ
         bww+t43WooMK364Z+SmADURskaIOmMQDM/zOyPpKkUTMMVVLy5hhJzfDuMzR0cb4GqD2
         /bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=28L+ehB4vT7SQwhr1GVEAssWYqpFu3ff7CisXtvvxdY=;
        b=ACFSOt+YTsIOiDaD53WIUalWpcO+d6UeFQaNoKlZF4wanM6QwScy8CjKXD6PTp1REw
         1MDN/fwH8zKHXaF/UZk3otnW95LdRXKEfMs4BB25T6fEO0ADxf//NbqBBZxdCFs/7aJR
         po6PYo9H/06oGqI3ZNEikmMS39/s4ruO4MtUCVbB4c4QZmUDM9Gzb5IYe+LDSCRvWY5J
         Dlxgl9X+dUpUM6EZ4rw8TdHubyC4ltSTDrtWvkfoss/ex1LvL6fFOjtnq1K2lHC2EhJi
         1wcJjGUOkg1g9IAsOZ/BRUgNWv9vp6RhQStTY2OsNzNGmiUbxXDyUjWPGpVlkaY/TcLb
         ar8Q==
X-Gm-Message-State: APjAAAUsdPGqvlPFbLfoOSp8xv6i9D70H9OAknp4EIPaF4RUjfv2jfvY
        LicubTuwyQboOjs5y82pSve9iE/FKQ98FK4S+a8d5A==
X-Google-Smtp-Source: APXvYqwSAuJyFawiCWBPUfWSfl+ey1b0WgKBia9JeslWeeR5kptToofdPLL2GkFbfzP46jJ2hazqwwFcv+/poIq39PAY2Q==
X-Received: by 2002:a65:4304:: with SMTP id j4mr22959013pgq.419.1566260323884;
 Mon, 19 Aug 2019 17:18:43 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:49 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 13/29] x86/msr: Restrict MSR access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Writing to MSRs should not be allowed if the kernel is locked down, since
it could lead to execution of arbitrary code in kernel mode.  Based on a
patch by Kees Cook.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
cc: x86@kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 arch/x86/kernel/msr.c        | 8 ++++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 3db2252b958d..1547be359d7f 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/security.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -79,6 +80,10 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	err = security_locked_down(LOCKDOWN_MSR);
+	if (err)
+		return err;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -130,6 +135,9 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		err = security_locked_down(LOCKDOWN_MSR);
+		if (err)
+			break;
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
diff --git a/include/linux/security.h b/include/linux/security.h
index cd93fa5d3c6d..010637a79eac 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -109,6 +109,7 @@ enum lockdown_reason {
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
+	LOCKDOWN_MSR,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8b7d65dbb086..b1c1c72440d5 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -24,6 +24,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
+	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

