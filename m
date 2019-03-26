Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A090CC4360F
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735D720700
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7k55eRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfCZS3g (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:29:36 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48206 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732782AbfCZS2i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:38 -0400
Received: by mail-qk1-f201.google.com with SMTP id b188so12383329qkg.15
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h9EnFy04jMHVM1ZMNH2nx3A+bDTELFHTwxmLElxP71o=;
        b=Z7k55eRQRYGcZah8QOHEIlHkH8KCl4gYI7fGrsmv4pyVRN2TE0VQxMVCfKBoCJFYcV
         kvxQC/SOAqFtnWiz6XNtEHDlp0wdjYRXLoWdNGYNtazGpr1wIYh7W9UzmDh5iZf7wwKM
         bpBIXO6ymj34WPya4v+dPjhxdGs93VkG7jXgcc7DLXNfHMLrPcWGD1nX79BWUY3qY48s
         DgpRcNhmY8ZJAqANIbasB7lKFamqPuXlJZNJNd40vPj/fgZvScq0VExRxburPO3qk/JN
         1PtAOp8+Mk7977nxUVBg5Z6w7LvRhumrO/NQ7JKIlm0NMH9sDbothKVECbiaIBhj6xzz
         yUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h9EnFy04jMHVM1ZMNH2nx3A+bDTELFHTwxmLElxP71o=;
        b=igcnMcPgc8SWTik1eP0+8go2Fe2tQNEi/xyf7uBEexeUnED6Mbnr43ZYDvZ3Yb9wuj
         ffAXAjm/b1t1lytnXHsuDwSH7XYJFyAdVGE1/I8Glo8jXDBhzgFFg3Qe7+p5Lt9w8SbL
         JydMkrK8RhjVFd10KwoneNChcp6LbX73slRCdPcARxv1CVE76LE1CAMaEDzllYIW/xTu
         mkbsZj4cYM6D54P5mzxu7oxiPgEx6LWlRdyV77Jo77OuWHSWS/IeSPN7aRtqsGJzTH91
         0zKRm2XqRz4evJd2UcCXRbQr4kDIHg+XlJFPY1eGBIjVxtSWEdwqJjn75nRjGuNl5raP
         bvZA==
X-Gm-Message-State: APjAAAX+0l6u/S/5dDMjVCzRoJUIoE5tkCLvr660tiCX7WyJQ7ewduIo
        UfbeFqXc7Caz6dU1bJWptAqsSh2zjHoPaQmxSlAFMw==
X-Google-Smtp-Source: APXvYqxdTd1jUs6dwf4ovhU+ZzR5OkjsK7SluXNtMP4TQSlVeJye4bUNfuWPhjrz9fQ9H73M9kP4eC8pkZdt7zfnoeQ90g==
X-Received: by 2002:a37:a797:: with SMTP id q145mr2953780qke.292.1553624917716;
 Tue, 26 Mar 2019 11:28:37 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:33 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 17/25] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
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
cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d4cca5bdaf1c..65b67f0d4386 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -842,6 +842,12 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	if ((change_port || change_irq) &&
+	    kernel_is_locked_down("Using TIOCSSERIAL to change device addresses, irqs and dma channels", LOCKDOWN_INTEGRITY)) {
+		retval = -EPERM;
+		goto exit;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||
-- 
2.21.0.392.gf8f6787159e-goog

