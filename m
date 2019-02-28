Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C4C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D689A2133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GC2PYmS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbfB1XMf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:35 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46618 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfB1XMf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:35 -0500
Received: by mail-pl1-f201.google.com with SMTP id 59so16192920plc.13
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wtblv7CT5Upf5j4F9ZDp7ozjiqhluHRrt49GDLKpkfY=;
        b=GC2PYmS9jR6nrnqlMzH2aZd92rT/QgV0RAhZ9ntx1vuRcVG6IiFngBTZeNuw6bzV6u
         f1pYzZ5m8GDX7LMG6N7JOdwb7tlBpa71/HnuLlEM5zohtke23Lfg98b3gWZ808IkMshv
         +u7wbW4DFyB5r+jTTvUf1akuE0xU5IU9EuYQ6XotCTFddmLeVB1/G8piCZ8dLMfsVsP4
         yR1UimMKwYlWQvulSSd57CUFEeFvJ8gAjhzdOW2iajytFiwvnYtyfS2qQN8xEhE7G6Zr
         IEWt45+L5WvUWk35DQMLxlvFcW5hT5hehluPIQpjuQCysapZ21ZzdDgcj5ZteEuwXysG
         FdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wtblv7CT5Upf5j4F9ZDp7ozjiqhluHRrt49GDLKpkfY=;
        b=PWk3eKXjbHurjcl+lguhMDKu/yjgbBhQkqPcmT1Uk+Z3pK50J4SwuykzChDqIY7G5a
         xxOwBwzKmnV7VL7kFSTi7Ox3dTyMD3MYat01WukqmfHkCOVjQEs6mi01pTJ1sAtOThai
         zajHClMGfrd8Gux1/sLl9zLyX5uO1wLty/Kn2wrxZX/M/U5706QWO8wlYJ2ycJ0FKLxb
         wlHrPVrpa2gL8DC1Ph9msIezNFpS0dweJHRauG6PYchZMbk8x+QvAfyj8UD7nsjO+iHK
         XvHgH8sty8ccPCrpRTvsRPTelV2EYU6dmii5iVp6sEXv+Z+hF7k9hqIpZdkgq6MFemoI
         KACA==
X-Gm-Message-State: APjAAAVz8lq2q7lHAVHVombldyDvw0aEJ1ID50nGUt6tjv9YXAmun7TR
        nes8vrY/lgjL5wc3wl0QN1BdAorPKHDhXfFciBJBzw==
X-Google-Smtp-Source: APXvYqzrGA7dIkJjpqwmFqWlyr4b6N/5jE4dyLWuDOrDg08GA7j64lKrGinC5H0wOfNXX1Q2F3Gb7VxNeHL5AryL7HAfWQ==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr671197plb.108.1551395554796;
 Thu, 28 Feb 2019 15:12:34 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:48 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
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

