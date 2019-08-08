Return-Path: <SRS0=ikEQ=WE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB2AC32751
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D601217D7
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 00:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoIhUEuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbfHHAJO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:09:14 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44805 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbfHHAIJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Aug 2019 20:08:09 -0400
Received: by mail-pl1-f201.google.com with SMTP id n1so54313240plk.11
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2019 17:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dLYiAr9hqix+w29Ej2S74ESH31+c2YOxCuX5zuQe/lQ=;
        b=uoIhUEuUfzQjSKJS+7uyEhLItO8fBOuPoBctqNF+mfgcDy7bzRQ/Ft8tv1RdYxWlG5
         O9VtfxsYBr9KFdaoYsSLwqG3su5Ai7ft9709ro41wWX7OECg9+0mq1iCzMtAk2w3QzTd
         PES0/NZaoYskLxwaDyNKcSJSorIVrYW+92TbMjkbiQ5e/PzR8Zxe9gR2enjSQy93dh7x
         5HehUUasr80bkgmESKnM35g6OsTHCyRtdHy2JweVD2RpPwMs0M5cwUS8+Tc1y6CYbvfQ
         6Y9dbhAZ160BONDi0650a8BqYkdAauasMbBal2w8FlJccfSV5+ZhICF4CCQb1XAGqk6P
         xsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dLYiAr9hqix+w29Ej2S74ESH31+c2YOxCuX5zuQe/lQ=;
        b=iyUiQJhYXMrbtwketGohBRSRhoLeGOhuBluRKHxE12FV/Zwk9ppaEbTwUF9+sLxHAm
         Mk1+61kOXt4uNZuOmRfuYZDfeWGeHMqo9tYdw1lXmadZSXgSX81vkJoVXrY9Go+/NAh3
         3aDRMvm34mWEKLKmEGjPZ+ONOHREsL8HPq64x1ALXXHT8pVntxulTV3eLbIAagXeJ9gt
         czmz01b9eLmdibQm7Dd7svO7nq7A4T0FkkrJmAg25YhA0VEnGWb2iuJb2G0Z4qhb/XNK
         EhigpLfYe4zqEcsJ2oirANY6KPnlU5LOHPaGYDLH5QprAdft9tcRrjUqxT98pR/pdU9C
         JTSA==
X-Gm-Message-State: APjAAAUCocu3Y/S53GmMTddeznrTnFj5SOKD38b2TvzFRevdOqgGmVls
        aaaxPSZaHyGiraXfyF9z/hKFOLpn31XQp5kLnY9s+g==
X-Google-Smtp-Source: APXvYqwV8ViolvK5jUMBxX5yiZQcS59+TOG07qwamPrZF9QUUHyiXc3zw/mVoKRuk9XOMpVI0iba9BA2jYXvxHdxWki25Q==
X-Received: by 2002:a65:51c1:: with SMTP id i1mr10127643pgq.417.1565222887874;
 Wed, 07 Aug 2019 17:08:07 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:09 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 17/29] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/pcmcia/cistpl.c      | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index abd029945cc8..629359fe3513 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1575,6 +1576,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	error = security_locked_down(LOCKDOWN_PCMCIA_CIS);
+	if (error)
+		return error;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1c32522b3c5a..3773ad09b831 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -111,6 +111,7 @@ enum lockdown_reason {
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
+	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index ecb51b1a5c03..22482e1b9a77 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

