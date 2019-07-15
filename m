Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAFAC76191
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BA520659
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgN+Hy5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfGOUAm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:00:42 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:54402 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732551AbfGOUAm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:42 -0400
Received: by mail-qk1-f201.google.com with SMTP id b139so14656742qkc.21
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+BVs4+IbUnzxqigablcI43G/OcpEsyLzvDMqSyBhvlI=;
        b=jgN+Hy5rzJRsBCdzAEzybx+UKxNAwDH+7UJAzEJ2Cej0p1BYdTOfvUb/mP4HbNphci
         wrI7yB5rVVj8A0KGE1Fb6LoYjo7Pbc9q5dzrpOD95LWQon1UmAeJE4nwUMagb5z8r8d3
         wJS0X52iwL8P8Dk14P9COut/Pc9XhvXqzQ+SyzWPSqAFqRoPJ0Eg5MTWcfS304S/WHfS
         iWIW3wBMWMj0oDP+DU/dD4dI2hPNlFGpu6neH8iTGqAP7t7Im0bNLKehHfrhvor/J0oZ
         Ymvh2xn8z+PugScxAa/rXUXqRxdwnHJ3iJQNEakHptBYqM/si+stCFQjrTP56XmKQOFA
         d2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+BVs4+IbUnzxqigablcI43G/OcpEsyLzvDMqSyBhvlI=;
        b=j4eH1MiDFjd3i3QIeZ944E8Z9oWbY1IK+yvWg/lb7/focUYA+0BIRhKCQ96Yj6op4Y
         ehi6i0MPcjiwxEI1E5irGyYQtAnFlYxPo0ELux0jQsHdgtH/HdTUjYflYKqWJQgMWYVW
         /mq/OG5BmGBcJ3wQKotA+USzrjsbDnQQ36lqmPfI4PzQB7IVu304/ldScpQHAtGmYo4F
         lubHbL1cagoSeWlPTWVhcd9t8FLqh0dmmQworpw8iHPwHHFKPhuLqlM/FjPgrgThIXT1
         YMyaaidQdGMKasqEZQCkwofvAWZMbm0mBZiwCYqwYdHwEB5rO0OEyNmLgBVqtqVDFwMI
         +v4A==
X-Gm-Message-State: APjAAAV7jarUd/fol+QJzHnGB98zs6d0L+Ht3xVMrZEwcV6TetpnZ7Cl
        X1BE7uKv3FmNpKJ5Tu8MyZZFcJnQC+RPG7JWXeK+ag==
X-Google-Smtp-Source: APXvYqz5vvHyqfroaIhAkEducyiSejDIwwb5RxaoLydNSP26fz0XARD+t+kfcq7TPA3VrlndqDtTAjK4bu1ie1cI3VCE7g==
X-Received: by 2002:a05:620a:1286:: with SMTP id w6mr17687717qki.219.1563220841099;
 Mon, 15 Jul 2019 13:00:41 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:35 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 18/29] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Lock down TIOCSSERIAL as that can be used to change the ioport and irq
settings on a serial port.  This only appears to be an issue for the serial
drivers that use the core serial code.  All other drivers seem to either
ignore attempts to change port/irq or give an error.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 5 +++++
 include/linux/security.h         | 1 +
 security/lockdown/lockdown.c     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4223cb496764..6e713be1d4e9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -22,6 +22,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/security.h>
 
 #include <linux/irq.h>
 #include <linux/uaccess.h>
@@ -862,6 +863,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		goto check_and_exit;
 	}
 
+	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
+	if (retval && (change_irq || change_port))
+		goto exit;
+
 	/*
 	 * Ask the low level driver to verify the settings.
 	 */
diff --git a/include/linux/security.h b/include/linux/security.h
index 3773ad09b831..8f7048395114 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -112,6 +112,7 @@ enum lockdown_reason {
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
+	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 96106c2870ef..07a49667f234 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

