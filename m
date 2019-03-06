Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856B6C43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F14620663
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nf5PyV7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCGABO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:01:14 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43339 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfCGAAF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 19:00:05 -0500
Received: by mail-pg1-f201.google.com with SMTP id t6so14129214pgp.10
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 16:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UFGeS7+xruZP4sn4Tn07AerSriOPiGRkhy6cYT13zbQ=;
        b=nf5PyV7J5TjGLSrz1snkW5lN8yaR5isc/9tBuhM/tahXRhF2gThjaVYqfeVruaHQFt
         qW2UjDI7At2H/XB0rystIOSTqsowEIFewHXGRkGJFDqOA4quy6fmdJ6jQ7R/OPLBZ7vr
         DSFGpDml+Z24jD2zVecZEVOYDF7uu5ghdhlqYY7rNnKB09Eq+OE+pC6I+0bh7kobCWae
         caVhYDOn2j82QZ4tdjD4+2zg+ciNvfq9HHni+bbj67pSHQTr5lS9kSrmT/Xi9BIxZU3B
         t5tbNCqRUBF5R77M+twcWSg8IXhZXAmXAlATd8+4aiHncxDJIq1XwR0N4gNFFQI8kjdI
         m4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UFGeS7+xruZP4sn4Tn07AerSriOPiGRkhy6cYT13zbQ=;
        b=NsNl886TROk3gjQCtrGooRVnDg6r/ToD/4X8Np8MMx4HK+b5RiQT5G7NSw5gF4Sju6
         8ksO/+fcOXQkC6RGi/f3znamyGSYOhjrY+xKGbPVnBJEIoPKugJFigJLbYlASz8ZoEz2
         UUKduMF53alKMjqfYzCkhNq86Y3o1En7JITtJ20NIq+I1rHoI85gtHDaUcyKWbUoGyKR
         9DRaO2JKH4BzEo3c5GxG6madD/Rcahj5EY6sb1kQ9PbpxHgxmfplLGz4ZVsb11uK9pKg
         Q1ppkvbidrgJ8IZRqJL9DgOs5uV+X85CQWPsPZOsCyC9BE/hGgCLmlhFosdY/yOnbQZV
         NXmA==
X-Gm-Message-State: APjAAAXQZTtb1G00u1Fk3mc/iMTw6zxvprI0pkQcoSy10SPkL5KfHx17
        hxdhPMNlvuglc2p2oJNhqCTj8pw5tse7v7KTfTpfJA==
X-Google-Smtp-Source: APXvYqwJBsGUaIGqFR3CJSWo/i0FpDRirNWONamjbWrJaTKAzfV5w3fQjS/fE5bbN9GDU1+wkgSr0HNKitEjh64tjjEshQ==
X-Received: by 2002:a62:e706:: with SMTP id s6mr3820429pfh.87.1551916805075;
 Wed, 06 Mar 2019 16:00:05 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:59:01 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-16-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 15/27] acpi: Ignore acpi_rsdp kernel param when the kernel has
 been locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Josh Boyer <jwboyer@redhat.com>

This option allows userspace to pass the RSDP address to the kernel, which
makes it possible for a user to modify the workings of hardware .  Reject
the option when the kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: Dave Young <dyoung@redhat.com>
cc: linux-acpi@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f29e427d0d1d..3e44cef7a0cd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -194,7 +194,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
-	if (acpi_rsdp)
+	if (acpi_rsdp && !kernel_is_locked_down("ACPI RSDP specification"))
 		return acpi_rsdp;
 #endif
 	pa = acpi_arch_get_root_pointer();
-- 
2.21.0.352.gf09ad66450-goog

