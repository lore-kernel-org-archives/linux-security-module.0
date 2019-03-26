Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FDAC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35A9206DF
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOLB9NJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbfCZSaB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:30:01 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:48758 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732697AbfCZS2X (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:23 -0400
Received: by mail-ot1-f74.google.com with SMTP id 70so2669608otn.15
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QnWxYoXtlXDh+QYWjqIOEuesK8IQe5p8ynytMTjRSCY=;
        b=VOLB9NJTyx8dN7/6UA5I87VxSg+nwZPoTxN2KDQgkrTv2236J9Olmq+quOI2nLXRXN
         1xZDat5ybiq8T8oFTM7wVNVjTnSSmmqUmWVdAzkBVYQT/TNuUFG4cfNZOz6XbbMduPQN
         jGPrQ3p3Du3K2KpWCoNs+2PsG7NrMg3SnaWygYmUHgW9YFvQSRfr9JLEjftvt4jqdqxx
         kl7nzHXM2jDxvwdZWc4ku65yfo6VoMaCqe6rocAivPH8R4QqQzivdbAJiP0R5QfdFmN4
         /LCq63e0gersazqqSl1O5radgSWZS9ZX8q4kkMVsn1u/MQc+a0q8rH9IU5wU2naCScPL
         uQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QnWxYoXtlXDh+QYWjqIOEuesK8IQe5p8ynytMTjRSCY=;
        b=h2taR0iwG/3fyCRa+QUST31ejjWN5qs+jTbQ1mj/6hIDiOuX1mWim266JzHcii75jr
         zaV0G8ybnYKtVFr4e+Aq7ZM8MVczdEO6Rzui2zIMSZw+vd2E7IXOUz9FbTq2YQtiENdL
         6EoaHJBmFy1iRCFk0I7UZO6O5Kyx1gbMNo/B9jFStZ2Bdi5UDgCPEC2jzjqfW/rqXtgf
         HisP6abr16vahfKtzmtYbBsoMLCXKm/EricZ7Ou2Pqb7DPSt+PzgvEiidlXnUsHz3LZo
         M6ZrrYh6ntLHtAT3YcF/0zWB/KwCVmOQnO51oZJyknss3DIPzDODA/PFB+5QGGEx0TQT
         74iA==
X-Gm-Message-State: APjAAAWlkw2rZTfqXr07MAzQvzpkRb7SYfSItVLPoPJLh7KiVxMMGsa1
        d5Kfu3wzuG8tdgVnzGXOGvVOdIWCwRWgPdAlM3f06A==
X-Google-Smtp-Source: APXvYqya4Q8mCNGenT/N6+mKmThPwv3Vw/5eFEF/hr0CHDhgdoiFSSgysKJ1Dj8ievmiAFsBB5YGdTZL+MPpKiKtZGiROg==
X-Received: by 2002:aca:7592:: with SMTP id q140mr16468631oic.152.1553624902883;
 Tue, 26 Mar 2019 11:28:22 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:27 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 11/25] x86: Lock down IO port access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>, x86@kernel.org
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

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: x86@kernel.org
---
 arch/x86/kernel/ioport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 0fe1c8782208..febbd7eb847c 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -31,7 +31,8 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
 		return -EINVAL;
-	if (turn_on && !capable(CAP_SYS_RAWIO))
+	if (turn_on && (!capable(CAP_SYS_RAWIO) ||
+			kernel_is_locked_down("ioperm", LOCKDOWN_INTEGRITY)))
 		return -EPERM;
 
 	/*
@@ -126,7 +127,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		return -EINVAL;
 	/* Trying to gain more privileges? */
 	if (level > old) {
-		if (!capable(CAP_SYS_RAWIO))
+		if (!capable(CAP_SYS_RAWIO) ||
+		    kernel_is_locked_down("iopl", LOCKDOWN_INTEGRITY))
 			return -EPERM;
 	}
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
-- 
2.21.0.392.gf8f6787159e-goog

