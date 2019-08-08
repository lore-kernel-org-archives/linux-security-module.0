Return-Path: <SRS0=ikEQ=WE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63836C433FF
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336FA217D7
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tqhon0H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbfHHAIC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:08:02 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:50936 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389615AbfHHAH6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 20:07:58 -0400
Received: by mail-qk1-f202.google.com with SMTP id e18so80700139qkl.17
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 17:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q3etb4lqcpfoYcLMBUBDWWlC5fl/teVFWCZH3Y1QNdw=;
        b=Tqhon0H3z8E92aFzuPwtjNN7FSEFdwBgdQh90r8+5jGt42X0jpWdT2ic6gZiBZAt8u
         +ZeaMZ9Tb2E6/AHzGfMK9gWChnhOFKauqGkCxFiL6BGyxcxMswDQrz3xyK4QqV5kT2wc
         Nav5p4TKwh5whjulyAHJSVPcTq4s/WL1Wsu/UKuSRuSg8Ml6FNYhpCyvlbsHvFYcBTDl
         g/MWJxOOr7HzlFP4+ukFXafwQwDL3ZF8kkubFLQfZMMIbFPPj/Tx+Bl5AjNwAE2YnavF
         O7GIxzl//nHtCkMtVT914UStZ/BJC6Dha4T0VOSIj4n0UynrW2oA3lmsi6h8I/il64WA
         onVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q3etb4lqcpfoYcLMBUBDWWlC5fl/teVFWCZH3Y1QNdw=;
        b=TBmS+yvomYhz2ClOdKVfZ6LWdS7s7FinHMhkOk9YFV9OdA2X/plYy4IyDsB6NTO7Fi
         oFsZjyl10Y/EerhY5OUo9iWPpDCt20OalAjdPWIdeDYjgCyt4HInhVMfw8N6o3FlEauU
         s5LkWyMwspBRZO6yNxTUX1E+uAQC1H4qkCUiFwkSVhn8X0Dr9M+FkddUhIRa+/qdVvIc
         3/2YW1dXnePHvg2Nm6z6zauyg9TuQjcdGA4jyjYvbkjMrxeGquk4XvLtdBu6R/zMqrfO
         ITA79FX1qZmzWFsxWELZE9Y+90Pb2kk+YZvWkLjhYtTT7chahK1mleoX/6MydkjVi3c9
         AjrQ==
X-Gm-Message-State: APjAAAUOo+oc8ip9bMv1nc4eV2QOcEb5S0XcNKVVSbEGmQJtQYHkuoo1
        4vkH/K7aYKXhPbZjBSYVtnlXfK+wUZPL19b4pRh35w==
X-Google-Smtp-Source: APXvYqxygXUCD8ZQW0eUhdQi0YBIU2fXYtSPLBvBUKdb9Fcx5kgOpiLLKMaYoTc2ZpEPkk4WQEh+m3qnhNy8WAVosLrTcw==
X-Received: by 2002:a37:9d13:: with SMTP id g19mr10622302qke.124.1565222877553;
 Wed, 07 Aug 2019 17:07:57 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:05 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 13/29] x86/msr: Restrict MSR access when the kernel is
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
index 79250b2ffb8f..155ff026eca4 100644
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
index 316f7cf4e996..d99c0bee739d 100644
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
2.22.0.770.g0f2c4a37fd-goog

