Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39976C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104C220700
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIlec5t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbfCZS3u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:29:50 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33918 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732733AbfCZS22 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:28 -0400
Received: by mail-pf1-f201.google.com with SMTP id j1so1115696pff.1
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aQw0KGeWmvPzPQJC9aCiMXHo5RCdIiAFpbvhdBtqfOA=;
        b=DIlec5t0clil2K3z1mQdY8Ozo7PzlyiRXYNLrqoik42GWf+SWRdQxm0hFn3CDu6CT7
         z3l23Zj/4mmAJvQOjaNVvuhjtGBp3PSUL8NIDYIfVFqPmo7Y6tVU4WhqiKb0j0Ovyq4/
         uP4N0qPuQ8UBSpbd8J1/FCclbdWKoOxyfSchUBo9pr+auLEflx/O9jYxyHyO2OntwoNa
         zDIVBPCnINJDBVVQo1xUe9xiaiS1lQhbv4c8ylFNhZNGEiesp70hGeaXM6fmeK6Oi71x
         UTtqtlH3qdj+vmoGt8YCUW/DXotr4XE7NM7x+YRhhoncOOODmnhhmeTokf2EM59RBNWL
         7Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aQw0KGeWmvPzPQJC9aCiMXHo5RCdIiAFpbvhdBtqfOA=;
        b=tfCft1qrA1UgM5mi+GfuXO9sYgfMy0TLE5kgbpV3AGit97ttwq3uQHlZgZpiD7aP9u
         u74WXqP52hsHIyMJI7jsqJUlumZWoJq8nzssD8C1fcoduXOLPh6yVeHQPc/1t7B2Z/xQ
         RJ++3UTC3lfYmOEXmDv5/bZj67FHxE5ryumBKa+BGp1bCh8V8A6bfK3VJV/VzeXxP5qg
         93ZSQqCJsfYh5vkV066KYffIfvKZwSL09XNOBfKM+nr5oIGkq2ZaCktjXIB594r11+8O
         WSX1fFgyZIB3PC4zL764pC7mNv1TywejxGitZB1WrDtGLxVQVwmStMwEuTGf9a1NMhhg
         INNg==
X-Gm-Message-State: APjAAAU1I1aLDkQ5HV9c+VDmBRvoKmIyGFO8UGwYdTVTliu35qKwsHUl
        Dt7fjc2ubNIab+HdtyZkjkNTnyWi5UjlUEOPLnitTA==
X-Google-Smtp-Source: APXvYqwMAG8zXNmY8SYtlr6zSMiao5parpM7h46gp9u2mGxgCIj6BeGnsuRx9l4mNv99r59blJSOQTYpZpUTUH4Dvq+5gw==
X-Received: by 2002:a63:f80f:: with SMTP id n15mr30302790pgh.283.1553624907693;
 Tue, 26 Mar 2019 11:28:27 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:29 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 13/25] ACPI: Limit access to custom_method when the kernel
 is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>, linux-acpi@vger.kernel.org
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
 drivers/acpi/custom_method.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..37de3cd84493 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -29,6 +29,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	struct acpi_table_header table;
 	acpi_status status;
 
+	if (kernel_is_locked_down("ACPI custom methods", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
-- 
2.21.0.392.gf8f6787159e-goog

