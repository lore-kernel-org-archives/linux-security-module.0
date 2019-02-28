Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD8DC4360F
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDA02133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQlkbUme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfB1XM6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:58 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45051 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388021AbfB1XMy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:54 -0500
Received: by mail-qt1-f202.google.com with SMTP id c9so19960664qte.11
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IP8fctA6K8NN5G061Fb911uxfYbe+tQq7t68cSfEm4c=;
        b=mQlkbUme7tUstIHNnk9Zjy+vZsDymO3M/+KQz36FFl4PseyptXPSkOtBCU+VpzfEzc
         w3Im01jnFe+xZbYmKjScHPbl0D5aFAz9aJX9QND+3DJ+4w2AyWglVW9aSPYzyZWM4Xov
         VNMUMd1Hty/C/yllcYOxa1rarjilo90btm0agwUTN1xuIFhQmzbKupvAihcV0+yUYUmP
         5SRr3bC9Lxy14IGMFYgXruziHJfDmPzF+qG4swTP01x4n/j6MX/s8cEo5REfTmpcTorT
         i380vbq3qlJJdw2Ya002CR0tq2AQicmhOuN88v8S4QRFAmpsoW5lTOuK+Et7XBt2D3XH
         dQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IP8fctA6K8NN5G061Fb911uxfYbe+tQq7t68cSfEm4c=;
        b=YhCQYiKy96O1Y0qE7Yd45KH0nG7/XlFpVEWKWHHxxfeVcOqjl1ZNnar8k3YNsvXTr/
         Eer9b+wprt11fMUJeJoUNCbM30IlfulkZm2hoIg2L/OFqwRuL56p8WYeNT+4WeSF9xU7
         X1qXDXwhPrkBdEgUQS9ogXWkChD1WGSGARh6Uy8x86EelPvRIvvWeWljDOffvaK0csFM
         U99NbGy+EqXrFvi64EGme+h2IQxdpEGVMMt04/ZR89wHJx8qAYNrJ8Bq5xRhnUuhYbeQ
         ootZDsgsoB9ZhM2HZT4M+aIExKPnEZ5yet9UHpy3xEXOd2Bb9NDCRun8SFnFCAadE2Mq
         jpfA==
X-Gm-Message-State: APjAAAVXXUlnMont956FkrQ6qv/Mf3/AEaRQY/SHW8fGQe8brFFeIqS1
        CPwdABWBtAzgGt5CQjT7i3Vl6z3nVg++3mJrFhK31A==
X-Google-Smtp-Source: APXvYqy6lnQP7cNTqUdwNAkXY6NJVBfXyJNp6Vjb7dh42LsutuwHpIVZFbrkYoaWwoRivdgkehMjZnjCLN5L07N/suMS5g==
X-Received: by 2002:ac8:1973:: with SMTP id g48mr1130734qtk.58.1551395574099;
 Thu, 28 Feb 2019 15:12:54 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:55 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 19/27] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
cc: Jiri Slaby <jslaby@suse.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 556f50aa1b58..627e859ae25a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -852,6 +852,12 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	if ((change_port || change_irq) &&
+	    kernel_is_locked_down("Using TIOCSSERIAL to change device addresses, irqs and dma channels")) {
+		retval = -EPERM;
+		goto exit;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||
-- 
2.21.0.352.gf09ad66450-goog

