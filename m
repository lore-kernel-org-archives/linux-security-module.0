Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C24C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6770020700
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1UEVtxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfCZS3b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:29:31 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:37685 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732807AbfCZS2n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:43 -0400
Received: by mail-vs1-f74.google.com with SMTP id r74so3449543vsc.4
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CCajKTRONhdynt5B0tRKLHYn7gScHVmkVEVnwB9DKOM=;
        b=f1UEVtxL0EVlbPLDdmHVG79aucAXc1fBqJUwg7tt7fSA+AaesqY3P1p2ZfzU8cEB3n
         03bsTL9VAsQne/n8Nhvw1sWnpcWum4Nqv3Yd9wb0ciIhqZ81AcSWIwiSc4FpvQcIXzja
         GBTM5kZH/0zi5Ne9dZ+ikq9lnF2Q32FFRZvvpt9YRkY75BhFAUNRNgck5+N1zyk4f1qA
         vMNtUXdf9cac4ri6xntmYw06VGoUUZsq8lxd2e2TecdKei4KeSsc3xhm0MGSU87S8/FC
         RxRKWWq47aOtlEK1k4qA6SDhvIGzXiN34T2kO23uj22gg09sBp27vGRNkphNud+PLe70
         YX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CCajKTRONhdynt5B0tRKLHYn7gScHVmkVEVnwB9DKOM=;
        b=G5Fo2/RT5Q+k5gOOlNf8NVeRUhPDMC7gyCrPby8z2rw+ESd8ezjpW2YYVUh/I/CLhG
         sC9LHA3wPUgbfIup11uQsK/crecPQD80gMLu5QwetGrgI/4wDZWOo0IDtzEe0nzKkzhV
         q9sCeSim0AC39gbg0Rdjdt5+33DJ6zHXM4lPRs8sjz8pyFluSW+E2dMEXTyOGLGbP87F
         b2l/sGxcPVVW9K8sD8UD8GuYQKx27H5e7zVbCUAmeqOj8fMp74HyDMFLIKDxZzD3EuG7
         FXiPgCaP2sWy3zuhVg044y9a3yrTm5jx2JVODj6NactNRbUge1FfONW9SPgrlDsnn4iY
         ULwQ==
X-Gm-Message-State: APjAAAVaEYcfN3CYm91bwTBW8MkNVR6JDSNezPetZC7KAeT7GvPP317O
        t0NvnWWPKrMTAhxWssOoERTRZvZCLvK8pGoXGsGT1w==
X-Google-Smtp-Source: APXvYqz5uwzG+qKt/vXAWjIFjKNq6CxLPDoTjZaK9Y+pyALLrDT+Cci9K4q1KvaMk9n8XrM1s9rc/+mImVPEnueEPe9h4A==
X-Received: by 2002:a67:e405:: with SMTP id d5mr11689528vsf.236.1553624922695;
 Tue, 26 Mar 2019 11:28:42 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:35 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 19/25] x86/mmiotrace: Lock down the testmmiotrace module
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

