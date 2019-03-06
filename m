Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDD7C43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A99820663
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYTOWof+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfCGAAB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:01 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:54588 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfCGAAA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:00 -0500
Received: by mail-qk1-f201.google.com with SMTP id i66so11512756qke.21
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EgD7M29mELKbRq1NWt6DNZZmbYMYEW26ecUsjbEvlVs=;
        b=gYTOWof+SnJgMS2LMqTCUBSp6zvC0gCXrCSqXNr50gmxewWj8i1zMYIleOGZoVxMPQ
         LF37ClnmwpqbzLw2xE8kWW8XNteLVIsCet67X232y7QE+kb57re8nGck768NviwV1t5l
         fJecS05fRNQ9WKgzKmIbkiqL82Z1S8X8Npca0z9r7YkeAgAo8zFrxNeTjgbZqXxrCkcm
         d5+Jr2N6cwpx+0SPxEEmQS6+b1WW3yrKkoGtM7svV8BvQzcAOUIWyFSYyYDHqfdpPkB7
         D/Mk96oFbG+YOC/1Yyf5ws/IFrQ2VPf7EEq49q2+f/jbjKa3lmOtkfTb8PWvjD0Pp2pF
         U5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EgD7M29mELKbRq1NWt6DNZZmbYMYEW26ecUsjbEvlVs=;
        b=GGD3/gam34FCNHNhVqRS64JZbsSYwgQ9c31tHvEyiDi3qZbkEqP2NO6t5OwsV/lwk4
         nWWZJaW8Tp5nuNoMrW96L17ZrUILuwBLKUj7dYIbEsL3gMNji2jyerw+yJ0XEzjWF+L5
         7dWDTy+oS18sKwZtJN3B/KleigNaF2SZyFXCOyGph0DCKELZqpatgBUNZy7zyYP7Q5Ei
         oDc2lcnOVxK4QzOk8wt+q5lsxvBAiho31xR5DfwVkZFW1BOB5DYqNABMnoUlcloh/zBV
         g0tQXT/tZ/U51oqRzxeGngbgtRXtYwDWzcVfuvdjOd0W14EpUduk2FzrPcBggVDYiYEi
         M0xQ==
X-Gm-Message-State: APjAAAVliM431jxwP7fIgvzhEEW/BXxAwIU9SfUfSIfKBs8d5WJ3DXQ8
        UQdQB1mk9fzYi9j0l68AN6uhGlBYT4kIstnCtRzUkw==
X-Google-Smtp-Source: APXvYqyMy1TJIWtN1222VFXuk/FGDSDNyZ8044iMtqYU3Zf07qKmx+B/7/pJqqNoAqGr0x0JLQBdkjn8lvYBk6GwiigknA==
X-Received: by 2002:aed:37c4:: with SMTP id j62mr5900910qtb.19.1551916799883;
 Wed, 06 Mar 2019 15:59:59 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:59 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 13/27] x86/msr: Restrict MSR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Writing to MSRs should not be allowed if the kernel is locked down, since
it could lead to execution of arbitrary code in kernel mode.  Based on a
patch by Kees Cook.

MSR accesses are logged for the purposes of building up a whitelist as per
Alan Cox's suggestion.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: x86@kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 arch/x86/kernel/msr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 4588414e2561..f5a2cf07972f 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -84,6 +84,11 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	if (kernel_is_locked_down("Direct MSR access")) {
+		pr_info("Direct access to MSR %x\n", reg);
+		return -EPERM;
+	}
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -135,6 +140,11 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		if (kernel_is_locked_down("Direct MSR access")) {
+			pr_info("Direct access to MSR %x\n", regs[1]); /* Display %ecx */
+			err = -EPERM;
+			break;
+		}
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
-- 
2.21.0.352.gf09ad66450-goog

