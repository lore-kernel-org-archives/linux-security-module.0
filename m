Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0AAC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA662075E
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXK8l7T5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfCYWK2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:28 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45281 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbfCYWK1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:27 -0400
Received: by mail-qt1-f201.google.com with SMTP id 35so11658280qty.12
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kOBn4Vsz7+t5uoVUQ5YrfNtYfxZHot9P0BHurCwotW8=;
        b=EXK8l7T5cYfGiceftgkWGkN1G8A9oXteYG026SSL6tDI1FBBwP+joPkSAzs8YW9xhz
         NQ0CKWgD++O3K+ekroOkINAJMOrOZDJSU66JgvsVSh2PbLMX1olcD0kVRMWeiYERFYkS
         Cv2m2rSyv/k280NI7fC2mxmwSbrCoQugjaofRMLfhriI7h8oOba1lIwASidwkAk9hRr8
         TSRxtrkRHH+YaJaNY1KBrfNUa+nOCt4o0S/JVKDA3vaiZsvIC2SzTYnNTUVROEQTV5M+
         t5yTJG/8OV7Fnkp+2G1OIZbJGpI+tRE9f2VZ93vrU20ko/BqyRK9RJg/bArvjqE7M/QI
         sxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kOBn4Vsz7+t5uoVUQ5YrfNtYfxZHot9P0BHurCwotW8=;
        b=DcsdgXYW0dsBHCx+vm6awq5JO1pwA9WrM3ZxJxCW68zK0fxIynahOH6SVxQqAN0fC8
         pzWifVUohNjoR9Lfw+vKCKPlKfgYo6gNWm0gxQghWDrn+3efMRb19KwX/TU8nmmg8Voc
         /yjhffQvalFkfIdEgooYOCN+I/LzRg3fKjjPbRjDyKTAjok4xLuodEGRIjzhV5bjeqHv
         svjpJtaAFV8ukd0n7jCAaHBDvJzdLkGUo3Y6rR8Wsz9mKr9IuWNU48++LW66YmariIxu
         mmzvBTUu/4MB8EKCGLMQPlTuCycxfbEgt+5FdNZbPZsHgtnsTa/Zk7jIRILvy1yxhOJW
         SKyg==
X-Gm-Message-State: APjAAAUERmpNnwfl88XVpSItMo851SC0gKLxnzpTSflaNlrsdOmaPkIX
        SbqsdtWJk+kzKOTZCrOmNge9S++Bt7ftTwnIKHA2/A==
X-Google-Smtp-Source: APXvYqxLKe+Q28iq+tNncS/NjM3aLWiZZQNw0bKZ7UoQYHGKv0NEYL0K/f+llQZd5V6QDj5i42d/7O0G6P6jzw1JZtBOcw==
X-Received: by 2002:a0c:947a:: with SMTP id i55mr22757441qvi.223.1553551826807;
 Mon, 25 Mar 2019 15:10:26 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:38 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 11/27] x86: Lock down IO port access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

IO port access would permit users to gain access to PCI configuration
registers, which in turn (on a lot of hardware) give access to MMIO
register space. This would potentially permit root to trigger arbitrary
DMA, so lock it down by default.

This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
KDDISABIO console ioctls.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
cc: x86@kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 arch/x86/kernel/ioport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 0fe1c8782208..abc702a6ae9c 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -31,7 +31,8 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
-	if (turn_on && !capable(CAP_SYS_RAWIO))
+	if (turn_on && (!capable(CAP_SYS_RAWIO) ||
+			kernel_is_locked_down("ioperm")))
 		return -EPERM;
 
 	/*
@@ -126,7 +127,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		return -EINVAL;
 	/* Trying to gain more privileges? */
 	if (level > old) {
-		if (!capable(CAP_SYS_RAWIO))
+		if (!capable(CAP_SYS_RAWIO) ||
+		    kernel_is_locked_down("iopl"))
 			return -EPERM;
 	}
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
-- 
2.21.0.392.gf8f6787159e-goog

