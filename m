Return-Path: <SRS0=kyj6=UV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD079C43613
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4CF20656
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 00:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHPhigq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfFVAEP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:15 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47906 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfFVAEP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:15 -0400
Received: by mail-qk1-f201.google.com with SMTP id x17so9386704qkf.14
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/+3/eHA+dSCIdfxEbsEJE5ZPu3YcdHs14Y4qiRI8qP0=;
        b=NHPhigq8H1Po8LVtH5GbIbnsfNJsBGYMYY2gEq3zllF27oLua38Vj9z3wa+okf8okb
         pWH8iQupEO8ZFxTX+7BkdVwPl9krXRrBOrM2ceSMETStMsli0y5kRfGaoJeyAfmxsGYs
         o8uSDCGcI305P4/xETNJWHi1axbKmmzz8veJll2OP3L72Jegea7jCAMBcOnplFMrmN+K
         ytNo4+f9k5qf7ZV83nxVq8Qpj3r4HNyoA67wTs19qVwB1HYRsUq7H7CtagwoBI6KNa8x
         POTZqxmWt7TQDlbu9VSGvXTAtI7pnzKL+/L/HA38N6Itp3uWcvomSdNGbKbv4ZVcDhbB
         7eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/+3/eHA+dSCIdfxEbsEJE5ZPu3YcdHs14Y4qiRI8qP0=;
        b=izYV4PBedM4cNucRn7D9pWUjlcSi3i+70P4QizSHcr2qOcMTBcm2Mdw+Rf2h0fkZEQ
         svl/18/nSpO18ytOFGimYDQPamx6vjmyL3ERhhYicc0V0jHfJOv6tMURcXE7OGiepZqn
         PR8icP6yKOupWoHplp1ElkvCQ4nxxm3kQb5lDIrGkZqHZq3wzmLaeQJceTGebg5Ac1Dv
         Ny2KLdXY0x+/ttbF20heE0Ye+QR7wmiQFdokIVIOvjW60JmUXAkW2EblKjPD4KfBhSkh
         nmQWDI5rcJzCcdefxtJ8HkkWq2T11BWEfq1cQ3edq62Kd6B0Smkzivj+Wvho7SIeBRMS
         JdqQ==
X-Gm-Message-State: APjAAAVlhoQgwf4LyFvsxTiMAr5tKfUkhMqQe8mmVPTWYovw/6FsEa7l
        fZP6WEpQIqTNpCMiCZ4p4wFP/BEIpmgJ+GtP3BL/1g==
X-Google-Smtp-Source: APXvYqx73LVPKUTT0/Z2o6KTeTT6M6JdkpFVqc84Ol8mGehYEExhBCBNgJGcfHkD+Wx3YMnYmuwtGz8w8+pv3jt43vq5Fg==
X-Received: by 2002:a37:a152:: with SMTP id k79mr7772332qke.411.1561161854063;
 Fri, 21 Jun 2019 17:04:14 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:34 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 05/29] Restrict /dev/{mem,kmem,port} when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: x86@kernel.org
---
 drivers/char/mem.c           | 6 +++++-
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..93c02493f0fa 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -29,8 +29,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/uio.h>
-
 #include <linux/uaccess.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -786,6 +786,10 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	int ret = security_locked_down(LOCKDOWN_DEV_MEM);
+
+	if (ret)
+		return ret;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 46d85cd63b06..200175c8605a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -83,6 +83,7 @@ enum lsm_event {
 enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
+	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 25a3a5b0aa9c..565c87451f0f 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -19,6 +19,7 @@ static enum lockdown_reason kernel_locked_down;
 static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
+	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

