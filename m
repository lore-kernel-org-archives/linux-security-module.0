Return-Path: <SRS0=kyj6=UV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F0BC48BE3
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B8D208C3
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGkLNU5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfFVAES (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:18 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:48096 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfFVAER (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:17 -0400
Received: by mail-vk1-f202.google.com with SMTP id a2so3038606vkg.14
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U/lZ7fD+T6IptDZssnUJlCZR7ScE9UF2AoyQTpT4HbA=;
        b=XGkLNU5iHH7hzuL0cMZIlVDgMLidEQIz9bIMGPNZmvYRjpXgd47gSC1YjKyllW0b8O
         n4cqGDaho8/zL2ugLBApVL0GUyu0YEL8OBR7cSVggwR6jMwP8RLdQ6EcnOB0cxkUrnFb
         TCFyfWFJfKOwNPWdM+oyTiN70K82MbhBazc+Z8WxdR50iyGJwYiDEFeWSlTIE2tIz5dl
         ckMEc++flsaUac43SpRMBhHvqhPoGsLYPEDC5/adpXWXeYSjKXtNWiJPMerIHawYHUsk
         VyZWbQoGyNCtK4zeJgDBeLYOPrK6v2onoPFnZJMQWgjLhlqzV4sYI1qdJTfUDSPGkPSt
         nZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U/lZ7fD+T6IptDZssnUJlCZR7ScE9UF2AoyQTpT4HbA=;
        b=H3vvpu5LQF3c6GLHbVBy9WsQ7Klnlptn6pAMGjky5kCwcZGOPzDi/Ha4ICPS4VWiDs
         jd8pZ3zEKHH0a6MWAxyZvvpB1Zb82x2GcogBVI9h4M2JdZh6kGPK3wCCd+JmtgGfSMP+
         Jm8IA+/2AOCwBgJ/9eamWniUUMtpFn+JiRQU801GxjSimtXOIm3ODUNjrpzmEmKgoLJ8
         gVg6IBPiXL/5cIFV7HPdynyowyZNJ8sj7HBhxlvW88ta7ljegzae39IYhNHZVfEh9Xbe
         fbg1lvEw0/WSuLrkWnZtqi2tbTEyMKM0yeRbZ92AKT5j83on8xICTX5S6/iSfun+lj4X
         b3SQ==
X-Gm-Message-State: APjAAAX7vyb9tP73Lv0DQE4gyclsX9M9YjioRLK/CC5p0vQuDvtUTyS8
        rk1mwtozwQtqBO6ACmYPwmPnmih0+fURTn/TyqL/Fw==
X-Google-Smtp-Source: APXvYqziUqgtWLgJrBADFFVvyKB2oLgiiIjHdoYuwv326vdxMw4s35iQ24bb3foHcyDzF6GLXkrPi9QxFNM1SCvcd+SeCw==
X-Received: by 2002:a1f:728b:: with SMTP id n133mr14793805vkc.84.1561161856703;
 Fri, 21 Jun 2019 17:04:16 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:35 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 06/29] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Dave Young <dyoung@redhat.com>
cc: kexec@lists.infradead.org
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 8 ++++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 200175c8605a..00a31ab2e5ba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -84,6 +84,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_KEXEC,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..ec3f07a4b1c0 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	result = security_locked_down(LOCKDOWN_KEXEC);
+	if (result)
+		return result;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 565c87451f0f..08fcd8116db3 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

