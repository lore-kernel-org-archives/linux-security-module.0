Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31011C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0359720700
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxYQmILS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbfCZS3j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:29:39 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:38139 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732761AbfCZS2d (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:33 -0400
Received: by mail-pl1-f202.google.com with SMTP id 4so2647404plb.5
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3FVj0Vux23rW7dwNJJDnKT59ZHynyqjKA3q4fn8QSso=;
        b=AxYQmILSdFg0+F/o39f/WfXSvOMkaN5wYJO4P7AP0HLuNoMiYIIvFwFvfk0hUBiR13
         4UAMjUq31t9bSPe0MnXikCSkC2eyMupf0ei8U0Ch/JsGWJCIxjQKrkYNixwHJNhsKf+8
         ewiscQ7iVR6PbhjFJ6irRmuxUVbZLX5V1eFKDgOc+diXskj2lcYCgwC0GRCcxdXfP6YA
         uW7rY+3bIfIzXqyMc9UiOcDQaANdLrPOlfGEVIiD5evpn8H4GKKNhOV6Dgx16grRJ0Oi
         rDHP+gZaykXlVyw38TJLvk19ALMIfOGPG8dCFPBpoaR2er4L7WOE5TXOO0+zJmre7Hh8
         8mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3FVj0Vux23rW7dwNJJDnKT59ZHynyqjKA3q4fn8QSso=;
        b=SVP6hj06HAhEZoxp6oLq9zn31UYmjAHjPkx3c3kz5kQcmQWdsmUAWNTah66hhwICh3
         jfWt0wMKPsEg50If8s2P8AbJXnWtXxrTuFfcTro6ZjIVQyrFNAvPAY5jNFQyBIM7mkYg
         0dpg485H7y0POlAWbjHreAc9wgGBPNS/fXvZcUA/FDI6cPA22dZN7nLkaixe4PIPKjRj
         zZEQRego4gXoG+h5BrtQ4bbTOaEjcSkWJw6jz49LK+Mi/sWY9bzIl3tGbKkWqCrilpL3
         tfInskuITYIaG/jwVRdMKzxh7M6RV1ec/24jm+2phaDEmZ1rPIaa5diLxtwrCMsi1FZT
         I6Vg==
X-Gm-Message-State: APjAAAWHS5TZokK7CteLj9gKWa7ZSXFhEqcvSxzInr26ahA9gpqDjn67
        SmWDq5zdxfjpBGdksHuOpuSsLbWxZGZUzod7DOEcIg==
X-Google-Smtp-Source: APXvYqzlbcsO0MLfv7TbuLhLJ50spDBJ4EO9m5/RfC1cSvWt7EDQbTTXzw3lPerDfy2lNc3+4Q1va2ANipQsr3I+ft+bOg==
X-Received: by 2002:a65:5343:: with SMTP id w3mr13108859pgr.232.1553624912801;
 Tue, 26 Mar 2019 11:28:32 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:31 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 15/25] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Linn Crosetto <linn@hpe.com>,
        Matthew Garrett <mjg59@google.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Linn Crosetto <linn@hpe.com>

From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When lockdown is enabled, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/tables.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 48eabb6c2d4f..0dc561210c86 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -531,6 +531,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (kernel_is_locked_down("ACPI table override", LOCKDOWN_INTEGRITY)) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.21.0.392.gf8f6787159e-goog

