Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81807C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1E82133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxgH7GKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbfB1XMj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:39 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:43578 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387828AbfB1XMj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:39 -0500
Received: by mail-qt1-f202.google.com with SMTP id m37so20070146qte.10
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VhmO31ASaR5AbbhJWKJOBB028OwydePZqKoH4vU4z54=;
        b=VxgH7GKWv5U4pP/baW0EyNSMJWfYR8gz/BNo9nVnFnEbb7Wbl++IfRu+fPTJW+sC+t
         abIrkqtE/EIbIUcTRr00QmRoWKgu6q69FQ2LLvQPHXNRek+QGxuYUXxmcjQvTQ+NZnm/
         xyWgVAEFG4KKloh3LwEDipU9xFX9B/8XIFCDbJ9pQHU9bvru88IxfktsGmYgZxc8nE1k
         F6u5QdZr+olLTyOkzOs2Wpa26v6gRZ/WJRWB3zElt/pKkmJQs6kA3UsNRuJxcKJbeEpO
         +26QhH7uKevD/pI+FR64cPIcixbS0Q8nN5JMztze+qS2V1T3dkpySufI0b05e0UCmT87
         Khhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VhmO31ASaR5AbbhJWKJOBB028OwydePZqKoH4vU4z54=;
        b=P+vHTCmC6wFIPOw8rlz+j/uB+achBN9FXFD2lhs+qNySnEg4rjtPQZYj9wrCO5Eas/
         ung7Xt0YZcB8lwCB9m7QLP6rzxv3BtC+A1ybn200LUorNbikooFTGRq8rxsvC4JZsmRe
         610Ap8yaYWWocuVoamTy2HEX2r7LNB4cOLFF2s9kHslXAajbisO0jHivaonxt+U7InWv
         8hg19sD+MstjQLCYuu1V4VmDYrg+rVMo7D8NaWTD3YfhaUVhHdb/fU5WnEVHEy0a2zJO
         LF8tO67XU4bb9+7MqeGMAlHsjAcurk9vcDNuvnwRfspWD2J+insT7X70GniFFl+zJ3Zl
         aCQg==
X-Gm-Message-State: APjAAAVePaixaw+DtDUDLR8kL/EsRnC2R0ymgQvxJOwp6yPQggSRR3Be
        Eyc9i70x9QJdfQ2ynf+0mIJutf1T8bCUqxjk/ELHkg==
X-Google-Smtp-Source: APXvYqwE+a/HZDk/gA/G8rVtk8wnZBlVTQ2ZhFr0hyf1V4T3NaXl8KqqxOcmV3++fmWncM37Zw7w9b2jhx2y0c15fmxNkQ==
X-Received: by 2002:a0c:af6c:: with SMTP id j41mr1093756qvc.29.1551395557856;
 Thu, 28 Feb 2019 15:12:37 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:49 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
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

