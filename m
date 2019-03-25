Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA4FC43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2B1206C0
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlInIGo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfCYWKe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:34 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48681 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbfCYWKc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:32 -0400
Received: by mail-pl1-f201.google.com with SMTP id y17so771573plr.15
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JjClfNcwudfjVo/9wlvsMTmCzUCPUTa4DRML2JJ7YVY=;
        b=WlInIGo7E8Sg1V/FJrdy7246BJfv2IFZBnZYy6waTznK9n+caw2TjPOhGfPZ703SMU
         HsdZZBq/cfCb9aUasck8HT2YGLHxCNOEM9Dn8gFGDuQRppgl9963pB2bWUbB3OdW0afz
         R9HQ+dGBSgtqfa4Llibc6rDd6MCdkBpPk9PllURgbs7CB/aHBVoZoDL9rJ67wbDYeM2+
         nkvuRWNqfMG3FM8h9H3EFUVkL8vF8uCHI4XGBEht/JE3ERIQt2oTW06JFFUZIo/C2MeG
         Gup11dIXcq1FY5/CF5EJkioM9JR9kP5hnhmiHGiydSEU3zr+pQBPM+64rv1Ip3uSVYPi
         STGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JjClfNcwudfjVo/9wlvsMTmCzUCPUTa4DRML2JJ7YVY=;
        b=maU96LpmV5YzEEsU72tZAdjn0bPh9wpuwlJ6PRwIesDxQBKadjlXGVzh7G/hqMdmL2
         kc5a497hl84g06/IcaZbVY2OiL9DgShNsBJjQpDt2rnLNgdkAxwrwgNiWXOmLLiWXxoy
         5nMSODFtSacK3vQVqSMGZyrQM/AEXNMUsZUVGy7kQ9XwAOHAdHLd3xr547kIyHiyNCYW
         ljcuZL6fxWtF/A6sYapUa/dRwQbvkwbLTqXZZc0ujj3H1g6huKta2/BMciFrMFt0GMQx
         faGIRxZTiHKSAkbOYfMc7RuxmV6OfvwHp5/fioCnlKsnOX138S09NZXTAoIIHwLr2yOK
         KamQ==
X-Gm-Message-State: APjAAAVrIDHE5pAQg6HKFhFPIyIsUygoDsX85DC7HPNKs+kbr1G0twhr
        s472BBjP3L9i5DIRBRpLoWW9Q+rb87M/Bob3p2lReg==
X-Google-Smtp-Source: APXvYqy+/HPWSggooyPKfCP9rCJAS540SEUMOaDvUBcRppcKI7iz6oLk3Dau8NiT2sBTzaxyaianjTm+/T/hLkd14AF0/g==
X-Received: by 2002:a63:6a45:: with SMTP id f66mr6790296pgc.7.1553551831630;
 Mon, 25 Mar 2019 15:10:31 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:40 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 13/27] ACPI: Limit access to custom_method when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

custom_method effectively allows arbitrary access to system memory, making
it possible for an attacker to circumvent restrictions on module loading.
Disable it if the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/custom_method.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..ac8a90dc7096 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -29,6 +29,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	struct acpi_table_header table;
 	acpi_status status;
 
+	if (kernel_is_locked_down("ACPI custom methods"))
+		return -EPERM;
+
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
-- 
2.21.0.392.gf8f6787159e-goog

