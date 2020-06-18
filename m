Return-Path: <SRS0=g/MA=77=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC021C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 01:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B402193E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 01:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5IIWXRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFRBIA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgFRBH7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jun 2020 21:07:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEC3C06174E;
        Wed, 17 Jun 2020 18:07:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h95so1890060pje.4;
        Wed, 17 Jun 2020 18:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8zZSp1JCwgW3Vq7GmDNUsJ1DjWL0wX5Tz/OMp52IbU=;
        b=e5IIWXRLgjqZTK6J7/0VNYrgTtEawRgKaNEk7veP7AqZIZppaTcRhyQjz0DrkCe4Gb
         shFHrcMuP0nGsK5m/2Fv5R8bheLLpkpsfFzwZqRaYnjZpMpIqzY4Lar9tCWoYuQuP2QY
         MFvdXNFBzOTH2om8HExE/LLkGCpFZlys00yb6165/SyNgHLuVfjzODUNoY6z1ozZMWyq
         AQVj4qb3QBjptEV5e6jKO0oZRyd7Wc+aRY05hohUtd5IQtaENxWw1ECs3vvAWFdXI1qW
         J5m0LnMMKU6dudrXzeK5iBTQeGdnPsW1TwVtXN1Xazp5XZXUGGC7KYuG03JxmVM9boxR
         oIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8zZSp1JCwgW3Vq7GmDNUsJ1DjWL0wX5Tz/OMp52IbU=;
        b=ZfGt3llIp+TU1yGVyPuO0tvtkrnAXHa5LtjTCNHGJQVPWVI15t4uZPnqoOA2A3dcsA
         41u+mRJAU402LsMNHICIVSFMt9zV9FQ/GA5l6ZRHGpZ+SJKg5odnCnyUJCsL4Gl5hl/X
         STAHPWG/3EThNv7sjogS+Vc/NlBkanlrmSykDVdLONZLvgUZtzb/Kz+j0kE6tCKcKSi+
         JMLKZPKG4fCGVdoXakW9fHIlUvF+JQkYvVRlZiY5Xfa4Me3FPT+P3chubV0+As1nvVv1
         sXzRNsMximoccAb4pW+Kr4XmNpmrYzqP6Sqize1PZSGakXMKGPNNxFts0V/4ZQkVRRYP
         oHpQ==
X-Gm-Message-State: AOAM530RjPHmJMNUeg89oRETBEVHU5KHwDrIFW+1dxJmI2orSX0Mwzmw
        r5O+XCpFjWJSnP1WkDkSX4o=
X-Google-Smtp-Source: ABdhPJwN7DQgI7nrMDLPd/GYGorlEDR6mr3A0sUpRNCut1O2FOtvx/aSXKVU1ny/mwbxjbZhRjLiLA==
X-Received: by 2002:a17:90a:30a5:: with SMTP id h34mr1827522pjb.36.1592442479076;
        Wed, 17 Jun 2020 18:07:59 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-165-39.hsd1.ca.comcast.net. [107.3.165.39])
        by smtp.gmail.com with ESMTPSA id gb4sm661555pjb.6.2020.06.17.18.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 18:07:58 -0700 (PDT)
From:   Pranith Kumar <bobby.prani@gmail.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [RFC PATCH] security: Add a config option to disable security mitigations
Date:   Wed, 17 Jun 2020 18:07:54 -0700
Message-Id: <20200618010755.4179-1-bobby.prani@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Instead of having to pass 'mitigations=off' on the kernel command line,
add a config option that has a similar effect.

Adding this makes it easier to disable mitigations in scenarios where
you cannot modify the command line or are unable to pass a command line
while booting.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 kernel/cpu.c     | 2 +-
 security/Kconfig | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..584eb39585d6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2542,7 +2542,7 @@ early_param("mitigations", mitigations_parse_cmdline);
 /* mitigations=off */
 bool cpu_mitigations_off(void)
 {
-	return cpu_mitigations == CPU_MITIGATIONS_OFF;
+	return cpu_mitigations == CPU_MITIGATIONS_OFF || IS_ENABLED(CONFIG_DISABLE_MITIGATIONS);
 }
 EXPORT_SYMBOL_GPL(cpu_mitigations_off);
 
diff --git a/security/Kconfig b/security/Kconfig
index cd3cc7da3a55..90b8e9c89a6d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -65,6 +65,14 @@ config PAGE_TABLE_ISOLATION
 
 	  See Documentation/x86/pti.rst for more details.
 
+config DISABLE_MITIGATIONS
+	bool "Disable kernel security mitigations"
+	default n
+	help
+	  This turns off the kernel security mitigations. This is
+	  equivalent to passing 'mitigations=off' on the kernel
+	  command line.
+
 config SECURITY_INFINIBAND
 	bool "Infiniband Security Hooks"
 	depends on SECURITY && INFINIBAND
-- 
2.27.0

