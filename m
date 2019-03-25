Return-Path: <SRS0=q+Rt=R4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF3C43381
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED1E20830
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrawaBB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfCYWKu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:50 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:57177 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfCYWKq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:46 -0400
Received: by mail-qk1-f202.google.com with SMTP id a15so7163137qkl.23
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2019 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d2w/jghx/Rqm9mT1Z9xpzhe5/Zw0d2YU0UIlwgQoEuk=;
        b=FrawaBB6eN8b4P/bVnjNhs6scGHBTE+TRJi3FQc+Wwj3NMeo6WCD3+HQbjxbbv7+WI
         wDvx0vr8l5x8DzoI7Tj5mPDrvDE+B/5x/IkMJfAz/BDDG/Xw1MnUdDSmAETbxxPgdsmX
         VYNfR2jows0dyDzxsN0D5o4jEVaObey0r1uqPlTIw9+c9pUY9s2qld90O2y0Nsj7j2dn
         T+Bpo74qJ+oGzlbqnocrS8st4xl4QLtcoBL8M5dUotNMJLJ1Fia6RrOf17DILTsA8kZN
         M6JQjp5NfHLIqjiyEugQs0B+MPF4ooHCAmn4/M9kSptz6VxUATW91wp/wM7IeI0PAiiR
         5qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d2w/jghx/Rqm9mT1Z9xpzhe5/Zw0d2YU0UIlwgQoEuk=;
        b=C6Eb3Q4FRi6ZW7QXMW5obPOqIgk2rJicN6kXMf5PvKAy5qOlUZf6v9YID30aMxcurt
         UZC8ELMZkzsnoNgqGDyQQ4fz9/4w3pKr0a+EFayZCTVEspQc85kxOIUZxBtd5r/ogHZW
         LpHEhqAH13ltOSGKa1RxARy8a7Chlej63sAZrmpfyiLlQqlonD34sp2IENTO900uvV0S
         0//EN1J4xibF4XlhJtqwgvsuT36C8qn6DPl7PKU8veFThM6EIjufD3Cj9iA8z+ozo21O
         bLNnXpWh7mCPPDZh7bkP5K1KTiw7/GmjbC2dMswxbmht5nllpgIfKbDoltnssVV0kLE+
         5jjw==
X-Gm-Message-State: APjAAAVaCo1LIncvDELc06skuvf0K6UFCQrqSxwxm55af3Yc2WVwvHcL
        +lhtLdIogKlv/UmVktsp4CYrHToLqzVsKq5JR4QI0Q==
X-Google-Smtp-Source: APXvYqzVTVmfctzgnwCAHNdEt4TH8ZQrL1tFaVyjQTLK8D82gLE4ptXXx53VXcErlNp281g0KEM8LQ1kT4/LgoRtBMESyw==
X-Received: by 2002:a0c:e58f:: with SMTP id t15mr22962206qvm.170.1553551845625;
 Mon, 25 Mar 2019 15:10:45 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:45 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 18/27] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
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
Cc: linux-serial@vger.kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d4cca5bdaf1c..04534877b575 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -842,6 +842,12 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
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
2.21.0.392.gf8f6787159e-goog

