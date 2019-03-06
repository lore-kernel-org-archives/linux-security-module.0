Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0173CC10F00
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D0620842
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKz3VNDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCGAAM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:00:12 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:48569 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfCGAAL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:11 -0500
Received: by mail-ua1-f74.google.com with SMTP id y19so1990856uap.15
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 16:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PqjENvzleKHq5r7VnPhuqFw2a2C+H2yOqXdiGG7oaFo=;
        b=UKz3VNDTrFINv1Zw1JIFlqxV6jtbW7ksegxAkGlnfJsvZM35PiRWCSDU3Foos2uiey
         19kv+vj6oA5hcbIwcgitp8WcFyB64OdSGSJ/jVFTor6v9eKAvxBalM5dQZBERK/hVX/K
         F3OfCSW1PtffLcFO9mRmYFX1aJamjaEvbYwb0uULRCQmdb1uVatPgt7rAIiBcIfcOpew
         UQYi0FtKWccFFwG/ALEqEyjM3VfvjODjBz/ir7sywBOSGb+/7kr67LQr6Z2/bKTgIdAB
         xx5E2HnliBJTFtriJjYVkSBtEJYM5VtBjvOJFlDe6NuVu8GdwK+i01HjUm+aiz26RW6f
         z7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PqjENvzleKHq5r7VnPhuqFw2a2C+H2yOqXdiGG7oaFo=;
        b=VQMAG4hZBfolgQWOumqbtO9y08HznQLmdBgCWE/6ikQsbz7F8BjHg+0Z9IxBIc8CHE
         d3neqEZzQEEK8ylLgRREJigJYSNDVvgMiyzkXFbh1Tz+IgohrQidhhfxlZCITHZZk9Da
         olgvjImjh3geQnpmw1n2Yj2oApliTGxc4i2OtTmAH4a4KvDFM5ClKRdgIVf6UXvLw22+
         QkzNa5fpoBGxpil0JRiyM0yX8ipDNzyVsQeqitNPXAegG31DahywE78IzVBHG6Kwu5f4
         pEqoa57MUFWIjcg+YBbVIzz6ggdR4vuw4Cku4ndKOmHE0DM4TTSUECP9wNsGZQ1AQ88g
         8Bgw==
X-Gm-Message-State: APjAAAW1NufiSF2uQ2HisZ67wSvhJFbvFr5H/o+X3YG+PlzAu+dMvi1g
        nm6ZVConFxCZEXcLIuSbv0Mctqj+fojegGrYZpiy0w==
X-Google-Smtp-Source: APXvYqz4xl5JcRRYnkdfh5b5R4DGoQ7iBnjDI80Ifuo8n1LWoBqkTumYb8oFwWgTadiqg8qVnykG8rL9vu6Uy49JuXnWkw==
X-Received: by 2002:ab0:b98:: with SMTP id c24mr6860349uak.19.1551916810289;
 Wed, 06 Mar 2019 16:00:10 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:03 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 17/27] acpi: Disable APEI error injection if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Linn Crosetto <linn@hpe.com>

ACPI provides an error injection mechanism, EINJ, for debugging and testing
the ACPI Platform Error Interface (APEI) and other RAS features.  If
supported by the firmware, ACPI specification 5.0 and later provide for a
way to specify a physical memory address to which to inject the error.

Injecting errors through EINJ can produce errors which to the platform are
indistinguishable from real hardware errors.  This can have undesirable
side-effects, such as causing the platform to mark hardware as needing
replacement.

While it does not provide a method to load unauthenticated privileged code,
the effect of these errors may persist across reboots and affect trust in
the underlying hardware, so disable error injection through EINJ if
the kernel is locked down.

Signed-off-by: Linn Crosetto <linn@hpe.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/apei/einj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index fcccbfdbdd1a..9fe6bbab2e7d 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -518,6 +518,9 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	int rc;
 	u64 base_addr, size;
 
+	if (kernel_is_locked_down("ACPI error injection"))
+		return -EPERM;
+
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
 		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
-- 
2.21.0.352.gf09ad66450-goog

