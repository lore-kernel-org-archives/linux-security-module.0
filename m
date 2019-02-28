Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B4FC10F00
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4B32133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyKcSgko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbfB1XMt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:49 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54959 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387937AbfB1XMt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:49 -0500
Received: by mail-pl1-f202.google.com with SMTP id j95so16159517plb.21
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0c4DnPm/cx2jzTzIvXsNGvNdz/XPR522PUMTkwR1KuQ=;
        b=uyKcSgkoAKvFlpnGAcowfxwKxFJXbTANnMFv51NpWe1AQ9/g7xJ6nr0sF8jaUuyoul
         uheLayLR/gi5715AElFU1bWdzgUWltb5IZ0nXAomZakOxNSpH+KCAecD8F8akvxCHdlC
         62ZkceTDBnB2i4cqSDOvE/aLMZ7zRpKy25snYHxLAmT9nWEi2kONGe2/F3wKJWB6g3W+
         uXs1Q/e78G7v51pN6kV0j+y1Q0Wb6SDhobx6DQmfNW5yielNATjHv2sEohO/V+QpdFRN
         H7o5fhkzSZxYHkWXpUYVUApxgbUEgszPFqoPnDXUK9xPMae+MagL9xmcTnvSB+X1Dn9t
         U0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0c4DnPm/cx2jzTzIvXsNGvNdz/XPR522PUMTkwR1KuQ=;
        b=kMCvTOz7/87OLe6/SsJvVyUqIyi/ScgSucR3/TftSQne4ypGTo8xJ7wcTijUaIDWsT
         H6wJhTs8jCP5w0LS+cT0W5CHKCHxaYwsOz08YPT+M82Glq57xbZENSFS3EXYnyeRVEKO
         3H7rxF9UCR8iFKx676fOXJR++ChAdzVuSxaaunMk/ZF5sIE4rhuDtIpLNqB88zT963g+
         fH5mHbA1nVfhhSs0McuQgbX1WXbSJGOwWUOqhFFzwTMVnOa/+qsRsGC5DkTbp5tXWqIm
         Gi7hgPLKgF0iSBFGYuOfOvjaeUnXhpVmONVjJbbQGMgFo5i7CEiMeUaqXV/8EuraEPqP
         rjmA==
X-Gm-Message-State: AHQUAubagw4yov1TIV3XIO5rKcUtEq8o3/OIQSgQisfV4MVOYMHYKoF6
        waRZ+N6vEuVuHbp0gZkPqGbUb8Y97rSDK7YUjGOrIA==
X-Google-Smtp-Source: APXvYqzzwt9UewHcrRVj6+HEeD5KRfke8EwJHrMZ3x/xl5bWeZh/LV7ynXZIZ1SmpY4ZfYIcAJ/6gy/8Lm/ElX7bMzL/fA==
X-Received: by 2002:a62:121a:: with SMTP id a26mr972694pfj.47.1551395568702;
 Thu, 28 Feb 2019 15:12:48 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:53 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
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

