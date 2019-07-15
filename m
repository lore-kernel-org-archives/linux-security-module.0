Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F8CC76191
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F05F20659
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skNA0Zp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfGOUCB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:02:01 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43609 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732464AbfGOUAj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:39 -0400
Received: by mail-pg1-f202.google.com with SMTP id p29so2877633pgm.10
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6D0LT3kOVXFnzThxDWKYD3nJFmfA+k8GxVnpNpHN0jQ=;
        b=skNA0Zp0MFTgZ25ppBqcBepyRwgDB+SK+DMX63rm062qS/6ITw3TJ65vULvshl/TtW
         1yZWQbMVqnxpBWEsQYNtyKQ6lRuwNRorHBsub03kLBk72nEp68iw8HJZXBRNwVeE+USZ
         itxOsdWZdOvNbvaZECK5Ty85MxqMfKwYPCQtWK37i3zMdD/zXKZ7z0NzXOoC+t1DpYpx
         9PDFJhuk7aEFF7pchF4lWOUpfd5Ywv26LZROy4USqNjgj3ka56bjikdRTRSJj1e+cLJr
         xpNkbDDWelhTVtGwZAdkulUh13MBt8NDAm1EA8qyfqFu1ZGbS0D8/iJhrnDBfYWmZE4x
         lxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6D0LT3kOVXFnzThxDWKYD3nJFmfA+k8GxVnpNpHN0jQ=;
        b=ZhUPfsT+8qMVhpxOqAsyfCRzgH9+1tuHyS/9A8ZLeDd5CeIB/r1U90w6v9NLWRdthz
         xy6G6j74USnfQAx1y8izwp9Lfo2Jp4zdErYSau0WgrG8iZfdayFhcBuATdnmw2/CcB8K
         kf8APWvqWnMyIMlJIxmC/RJEmOf6W8ndsn4muXxXqFZp52PuCI6RCKz/j/5z8TDkpbLU
         JTmH27DgMs6VUhlWblePJaBLmu0iiF1kCe0DvkCJSRmqFjfpFjp8bDjO9pp2/aP4gt7P
         GE+iZllll7JiENBHfUunvwg7sY8b39qkuX/Po0UFUvG+xJaEXWScs2IHhzn04dHK9Szq
         pRng==
X-Gm-Message-State: APjAAAUCWQ9bafTREicMGcHenr4F0XdFKDjAc/cSJZAnKWbhaUPBaLDn
        f9dLYL3N0iflkxqzvMQmR4Ymd3Mru0dx794NIDvKuQ==
X-Google-Smtp-Source: APXvYqwX139JUoCV5imG25Ui0tA/gIuLEykR+UmIdT4xltTZpxM2nFpRz0YlncnpYVBThrlKvKGvsPAzEJX07X+Rj65jCw==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr28640627pgk.378.1563220838301;
 Mon, 15 Jul 2019 13:00:38 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:34 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 17/29] Prohibit PCMCIA CIS storage when the kernel is
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
index 67dbc5c70ea0..96106c2870ef 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

