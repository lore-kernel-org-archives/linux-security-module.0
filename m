Return-Path: <SRS0=y35J=WQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F47C3A5A2
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B49122CE8
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBD5OFSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfHTATA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:00 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49175 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfHTAS5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:57 -0400
Received: by mail-pf1-f201.google.com with SMTP id s10so3519770pfd.16
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 17:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lNoz89i9XS2jvvI1H04tt6HZt6/wgDBv5mdC4YvRgGk=;
        b=FBD5OFSBztcf1k/51yy5DB86+s8rw9puUZD6jZa+gn00sbyPgW3Ca0yt76jHjBLaWd
         PPeVOeQ8TwSoDnE0dwd+ZCKNK6cOwphc74rNO9sgjC1iQZI1Jl92bGpvNWtFi4fuKOj2
         6Rngiw0Sz76EbPcal0USv8Nw1V0Agsl9zSKmPyCM0oBA95rkaoEQV+e1VO2kt3P2/yJL
         jGoxg4yUtoUfeEgJ4B14T8lvK9E+mdU7C8r+d6ONqm3EwVORHnkHlFIClokihAxqgJEm
         xpSmqe1PBlBbPE65vrjUiLRVfmhAZPPx3GYV6c+daZ2BsdAq6TrSrf/295j/9pfAAiPu
         SWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lNoz89i9XS2jvvI1H04tt6HZt6/wgDBv5mdC4YvRgGk=;
        b=aAjRtfMIZKtKI1TtK3QLTrjil1+Ai5u9RfqiZHdOfIeSUqWMfA1K/UjQu9nc4OOnuB
         xVsVeRB5XiCpew38BK+gGsbPtY1E9sl1lYP/O86iStB1CNfe88neBfWaweVTuP+ZDQJw
         XfmMdc+DPYvfRuBlQkzUqBiBnskZ345oXNP0KBVBD00Btoy/OqgHJdq/2ss/qtTT/FOL
         VmHO62UTXRZnwBvdK1e04ctdeZHRRXs1nf6APB7kb/dOUZVc1XMFmSykgTGNJ69T0Sei
         8NGypGrd0WOEi9IkTjQZdFZVOLnv5rMQpKZMLva4mdUDya+dNTy4deMggrISPu/ta1gP
         6w1w==
X-Gm-Message-State: APjAAAWo54EdonBEMlKkewhIWusbOTLsSvDvPYV2mHr/EacLGrOehkja
        K8t45LSYTPP/R3/CZYEusPYvHxsveQB+LYg934zI+A==
X-Google-Smtp-Source: APXvYqyRhFezZNSXJG5OpUUhtCC25DNBxb85NXjeRB6HBisse3eGGLJPKPWqBnxx3Uyiq9HJIm5R+9lMNqD79ydspAYUxQ==
X-Received: by 2002:a63:6888:: with SMTP id d130mr21330152pgc.197.1566260336938;
 Mon, 19 Aug 2019 17:18:56 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:54 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 18/29] lockdown: Lock down TIOCSSERIAL
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
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/tty/serial/serial_core.c | 5 +++++
 include/linux/security.h         | 1 +
 security/lockdown/lockdown.c     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 83f4dd0bfd74..bbad407557b9 100644
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
index 683f0607e6f2..b4a85badb03a 100644
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
index db3477585972..771c77f9c04a 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

