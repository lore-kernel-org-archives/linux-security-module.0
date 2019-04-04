Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A85C4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5B420820
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1zCieDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDDAem (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:34:42 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:37223 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfDDAdo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:44 -0400
Received: by mail-it1-f201.google.com with SMTP id q203so719860itb.2
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CCajKTRONhdynt5B0tRKLHYn7gScHVmkVEVnwB9DKOM=;
        b=s1zCieDIbjStDqi+VbZG5xM3sjOwoJ3+HzVhjYLaR7UmIvBxeAXLTptcS0cFeSV0Lz
         GwwpkyfF6ikIFd8i4swwhFgn0GiniGl0SQWvRPZc9xBTZHVHW7SOuzT5nwZpgJ4kcWUK
         2kFc9yOfPIb9IK7g+N8Hgps9d9NR7aCeXNo51766oho8GyfHpeDZKgQKC370JBN3X88H
         l7lEBD/09TPvf5nfQMc+FSxJhVlxrFIXaCImD+1MfyRAtL+nGamntP6IlLnJwVlVZPFp
         1tdmL5VstbWB03EnWSLtu7RwTgKnLRyUwFloXa7ZtktB9qcqCKGxS/E2fhIYDMxx5MXi
         iWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CCajKTRONhdynt5B0tRKLHYn7gScHVmkVEVnwB9DKOM=;
        b=Y2pRPtK0IKvP1JDzi4T+8QcqKS3MzfiDe0/sBT6R4AQNNmD8CYoHpGcdZxLSrxza0V
         rB0uVybTa9MutYrhRVF3v8IflpFqYRJ7e5HnSMVKIAaCSiZxzMYeqkpRaypDu3uvpI8g
         auB0kJVa3y4lvDOjpOtVTFM6EobiIbBNgIx0+f3BXjyKf9YwC3bmoLPlbegWSJ2YxHvh
         r3y3fmFVuYi21dRC8VeESNE59YPI4wJDY1LKMyx0VBKEz+z4EWRmaUSZukGS5X9QCdX/
         PmDscxo2kgAEvY53/q8JbpEMRR0NOPWjJW39Mt5E1kKaXXaCg4ByNS/TDydQ1SXLjx2u
         AQnw==
X-Gm-Message-State: APjAAAUYCOnNWxpfBSC9UFgFd2E7zCUqys4LrWCePixBGTUQzQ8bV42G
        bdWJ+finmldnipMymESAItA6qoe4r71QXHNJI0IlHw==
X-Google-Smtp-Source: APXvYqztLpxYOQsQrgxkzqR9K4RbtCE7akUg5egpcVSljxQ3131FkMhQn901XrIhoamzNcWoTW6/aQV7kciTkjgWbgL80w==
X-Received: by 2002:a24:6cd5:: with SMTP id w204mr643820itb.16.1554338023981;
 Wed, 03 Apr 2019 17:33:43 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:41 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 19/27] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space. This is
a runtime check rather than buildtime in order to allow configurations
where the same kernel may be run in both locked down or permissive modes
depending on local policy.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
---
 arch/x86/mm/testmmiotrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index f6ae6830b341..9e8ad665f354 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -115,6 +115,9 @@ static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
 
+	if (kernel_is_locked_down("MMIO trace testing", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
 		pr_err("DO NOT LOAD THIS MODULE UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!\n");
-- 
2.21.0.392.gf8f6787159e-goog

