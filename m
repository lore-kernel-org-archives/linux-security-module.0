Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A131C10F00
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157FF20663
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvy9XixY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCFX76 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:58 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49739 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCFX76 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:58 -0500
Received: by mail-pg1-f202.google.com with SMTP id e5so14121197pgc.16
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 15:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QDpkt2iLJaW7UQwtu1XuZ4vl79/9VRxhowqTd8n/Fpc=;
        b=jvy9XixYDMESBeGWm629iKWhW8u6ZS+rbPdR5wFtrAIoXp8X0Beq3w6n9KyLdUkrEq
         U63Xvyad7Y2Q/32lkLHR03jfxaTv1aMM6jOMrm+qmSWsxn6HOXHbRagx+eFwYySF+REa
         UvvUtrvxZCVpZjqOjHgIRFt3+/RVxukTl1nBAOBD3QTYdcuOr1gkmHZLxOR1/uxXUCUB
         XKOw9aEXXoB43Je4RTizkOm1OKKJ6GtN4jTQwKuHHOnEq8cLkxcX/rJCOdt7uTjtegeQ
         BUrVwanlHU9YJL5/dubEUv3r1m1tGqaggbRYbI2azMRSGJ5r+iChhYPnXncDsifN1LDg
         GaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QDpkt2iLJaW7UQwtu1XuZ4vl79/9VRxhowqTd8n/Fpc=;
        b=dhKW8bzdG2S5qNFl2yIuQ4BHraAhY+zmqdHMFdA0hvnkfPi32LSE4qewDNIXEH2juF
         KjCeHBQlY7zua4jnZL0pKNH31tAULjP8RtagM76CUlXftZdBYZ9eMDvGm/+jTNMhMBlf
         P8FHaafa/iV5wEcBD1Mh4EMiqDMocjFT/voYc+Bd3LF4DYymBwIY5mRRHOpgPOppvpUG
         /hVWEBpVHEtTwsqlP0i8QgF43CDxJ7IqCaaFh0RhJ2+pJgYlgMzDh8jx4948fnAee4Wx
         2A+kdKai8w3w+6+ymhp20gWIy3T1FUglnzajJNgaNwrlgJlKfpd1e9CbKmq1ev4zqndN
         MFfg==
X-Gm-Message-State: APjAAAWTdEhgsww6n6sXNtTF/XRbXtwCCoYoYw/obDacfZ3Y1x9P+N1s
        9kT9MEcGyRwaG0vLgt6RhYH9l9FUJlCBV4d98w09Jg==
X-Google-Smtp-Source: APXvYqzP27Yw1c4zS2hcP/6cmjCGlIABHINNbraOKET3ZcjSfIyP182tA8NHcR009uulMu0sFX+he9ulke/XQacya2FjMA==
X-Received: by 2002:aa7:8259:: with SMTP id e25mr3957696pfn.99.1551916797433;
 Wed, 06 Mar 2019 15:59:57 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:58 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 12/27] x86: Lock down IO port access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
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
2.21.0.352.gf09ad66450-goog

