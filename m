Return-Path: <SRS0=kyj6=UV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1FFC48BE0
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E24E2089E
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YIv34y8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFVAEi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:38 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54323 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFVAEi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:38 -0400
Received: by mail-pf1-f202.google.com with SMTP id c17so5302606pfb.21
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zyyz4Cz4gGHUXuxtWW1WrDh1XJA1NU8T7MmFpiT0rrE=;
        b=YIv34y8sbA5lbQnK/eli+pwNC0VaL5Zccqe5P08QByeHBjnT4ZCaFF6VNL0237nXRe
         Y82y2K6IWweiDfz+suVmozJiIJZ4FiWrNiF+czLcZ885+84IldvjGYnCqd6cBVGOB6X2
         LIB2ZUGsmvExhTJU+g5rsLSfPaB38pUV78wxFfZqkdvu5Ty0dz1z8kt1VvYSbRJXtjNZ
         PLQq1u/pklNhYtpNo+/JudN2J6hh+ZEnvhrWfXMwYC7LO2f/KTEcHLdaZib/MbY/cT6M
         aVlj+/7Xd3xzeZffz22TPbGJZPZ1gHSJhdPrgKyRQrQrSPgPzbAC5RkBFZ9Hz3KfX+B5
         eKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zyyz4Cz4gGHUXuxtWW1WrDh1XJA1NU8T7MmFpiT0rrE=;
        b=qr5wlRG1X1bhce5+rbix4V/+I4Bbl4ZsSNjo5krapwCgI5BWZ4ewjywiLOd2ymYlRs
         GzSy6TFFwZv8MeEezctrVwSEceLX8ivpNCJKIix/ENBujXvLUxGEISIAH9jaTXfLAyRQ
         G+WCAJ6f+ZPIcMav0imExeprs2vhBs57Y60BT/tIGwKOSdGRD+ow1RlOowg12jdNZEzI
         orkMxUahJeyd8qirleTvU/XO2AQBcucQ0Ig6gf2LBhCFFXknewvDFk2csKt98oB2giij
         g+LzFRgAEu2qzYfD7ZY//p4YgQzWUsUqUKzUHCbU55Y5epJUwvPEAz9bHJFcft64OeMT
         evag==
X-Gm-Message-State: APjAAAUBL8p45k8/7iTt0NF+t0eJ33HCGeKhST6a7r2WVoPmIizOXqhS
        CN8c7+SNGyhMxC6NdGpI3rvU9HQQ1dIHxgsjAMgujw==
X-Google-Smtp-Source: APXvYqxrieaEV4JvvipGtYx+FVX4wzWJu+9dkQO98TgTYS8DbVQaONy7gFhmlvKZ4R1EVRlKzulPfnPIGtj1Uc2BV2hMgw==
X-Received: by 2002:a63:f817:: with SMTP id n23mr21183139pgh.35.1561161877500;
 Fri, 21 Jun 2019 17:04:37 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:43 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-15-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 14/29] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/custom_method.c | 6 ++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index aa972dc5cb7e..6e56f9f43492 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/acpi.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -28,6 +29,11 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 
 	struct acpi_table_header table;
 	acpi_status status;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+	if (ret)
+		return ret;
 
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
diff --git a/include/linux/security.h b/include/linux/security.h
index 30bc6f058926..cc2b5ee4cadd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -89,6 +89,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
+	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 297a065e6261..1725224f0024 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

