Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAB2C76195
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C993920659
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGpuCm9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfGOUBJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:01:09 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38610 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732764AbfGOUBI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:01:08 -0400
Received: by mail-pf1-f201.google.com with SMTP id e25so10866142pfn.5
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1gkPgS/LUQWYTDhNcm4n5VtrDpueDO81OkRBGTKoxwg=;
        b=SGpuCm9nyv32QRgah8+1J8biiXF/tNR9HQ4GFBCBrRmNuWoaPEMCoMeG8CznrJ2xBC
         zkbDMbcYm8YcsYwmLzYCmSKjnsTMSvkKRRECL0tqQ36b9oNCLd5cuBcoa4BpCMdF21Fu
         O2tmCsQco516iIqUSW/mBRVF6fBtQAPjVYpsnS6G2E/HLyeMh1D0p0TkTpbvhIPBXbtS
         qtbaAbxFrni0pU2z0i41Fjy8ygJksGW51zsL1JC0ZC9Y3KF+G5b/rSrWYgjlPNfyEXRH
         GI0wIh/cCu2IgLJwz+vjTQ1V+oJarCXW6xl6K2cpPDlePYHuZsHrVGZ78+B3jX0whKqm
         o3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1gkPgS/LUQWYTDhNcm4n5VtrDpueDO81OkRBGTKoxwg=;
        b=N/Xhb2TnHXY40N9rtyWhM3kdz5iWdmgWTbazFv/3Zw1XHaP9TUpBnp7lxxJehaedKe
         8NaGUI3LRUKttL5ha4zl6fX0gGWMp6RuGQ87YrdlzSPgbUQpdiyt57qALa+nbi0/82+T
         DR78dCB42yFH6MHJrmgxrEgY56XHLvwXxZj2d+WUqcjdrleezRRJsPDoLetO+rAodZQ4
         5xQN83fl+jfIoKNu9f2xOm8wIs+dehJtf9JWxXq11/fQ52XpFa/Al3egqfMCWbeGFPgF
         GJCbGZyt/Dv/JwALqk3CCYeUUgDCfctrOA7F3Ss16Zr34H1RnDBGXxob8OPoLUF4GxLn
         TF6g==
X-Gm-Message-State: APjAAAXsrs0GqjaLLy2g7jA3Zwt/OrMCvkSlHuVPJ/f3q/e0Ldl7IkOg
        wTLYaoaJs5nr6VPym9SZFWdyB0FZ9E20GhDjHnkzMg==
X-Google-Smtp-Source: APXvYqx8IB42RsjuQvqr21hPpPSRXnXopU3sD+HW/qRD9CSWBN6XHwG27W8+mPAUWW4oj0dcn2icPxBiU0iXrQYpoIx1NQ==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr28729222pgc.346.1563220867059;
 Mon, 15 Jul 2019 13:01:07 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:45 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 28/29] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
EFI variable, which gives arbitrary code execution in ring 0. Prevent
that when the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/efi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ad3b1f4866b3..776f479e5499 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -30,6 +30,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/security.h>
 
 #include <asm/early_ioremap.h>
 
@@ -242,6 +243,11 @@ static void generic_ops_unregister(void)
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
+	int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+
+	if (ret)
+		return ret;
+
 	if (strlen(str) < sizeof(efivar_ssdt))
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
-- 
2.22.0.510.g264f2c817a-goog

