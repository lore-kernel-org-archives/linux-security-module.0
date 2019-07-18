Return-Path: <SRS0=m0b+=VP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE25C76195
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308DA21849
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 19:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpW5XOBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391507AbfGRToa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:44:30 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45666 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391500AbfGRTo3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:29 -0400
Received: by mail-pf1-f201.google.com with SMTP id i27so17219639pfk.12
        for <linux-security-module@vger.kernel.org>; Thu, 18 Jul 2019 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TwJXmltaqPXLScJPeplt82MxiWbulhRh2wFIx7ld1zA=;
        b=KpW5XOBG641l/Xw8B2PEiHxAcqUkwOdT8pWMv4P9X4i+9tASsD+6DKmFEGZAItkLm3
         nt+eL03RKB94E27Z+0SWtx0TsF44fWmjxgOtF7Cs9dp929LT5CINR0ubQgGECLFjJZ9b
         CBGqD0yXt2ziKZH/d3fp5ogvaF6WdfGy97JSO7OMqv0X+tki9ZHCr2+fiw/XlJ6SrObJ
         yF5qQ8imSZIYloYPzge8UZvrzBiV9dfpFgb+FEj56i6tVz5f5s0K17nWcTTh9VZGux5y
         azQvE+1YXrsqP9Ep53uXtGtJZPhew0u89/7pYmaCmMG+M7r3LcHMmHanccR7UURyvdFV
         bxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TwJXmltaqPXLScJPeplt82MxiWbulhRh2wFIx7ld1zA=;
        b=B2oR8I0gEGJbN33IdLpArY4vbJwQQanDyRf+0poLi9/z/Bu8YjXuH7O1vMv0SW1NcI
         /uSBSYIjR3MBBK8aNIhFo7JlcNVD70gus/ZSAvrcjA0FgnCWSDKFld49xzeKbxqRPQ0g
         jVHKDQ1ChqPTZWlaQd+I856PKxGROLqnFvNpWXzaY6XUHIpqXPYbtcFJY8gWeYj7eR2z
         Mc2kjmhPKLi68A+vc7bQsExOVX+nl/RFOBvLgmrSv6bREOX1vla6sPt2mNTjDt+QeI0q
         b7YpYO/llJuqvvU6gq81Khkba8StU5EgKc7Csk+P7c3Vb8pcmkQMSul+0OG6eCQPEoDr
         JqMA==
X-Gm-Message-State: APjAAAXaOlJHuP25m4gC9YttfumJhhJeXlBIBd8qFFq76zR+CdRgFgMT
        SsUbo9JGyNQpZTBJD8q5MDmNX0HAKBW0RrOAiFEEKA==
X-Google-Smtp-Source: APXvYqxsgSe+hKIUupoQACu1/e2K7TL8mPi+SfdyEwMn/PeozIXLkIfTEE+jqRKohan3TNzkLTn9q6P0KM1Cs9A3zxP4YQ==
X-Received: by 2002:a63:10a:: with SMTP id 10mr50049340pgb.281.1563479068817;
 Thu, 18 Jul 2019 12:44:28 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:50 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 04/29] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

If the kernel is locked down, require that all modules have valid
signatures that we can verify.

I have adjusted the errors generated:

 (1) If there's no signature (ENODATA) or we can't check it (ENOPKG,
     ENOKEY), then:

     (a) If signatures are enforced then EKEYREJECTED is returned.

     (b) If there's no signature or we can't check it, but the kernel is
	 locked down then EPERM is returned (this is then consistent with
	 other lockdown cases).

 (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
     the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we
     return the error we got.

Note that the X.509 code doesn't check for key expiry as the RTC might not
be valid or might not have been transferred to the kernel's clock yet.

 [Modified by Matthew Garrett to remove the IMA integration. This will
  be replaced with integration with the IMA architecture policy
  patchset.]

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/linux/security.h     |  1 +
 kernel/module.c              | 37 +++++++++++++++++++++++++++++-------
 security/lockdown/lockdown.c |  1 +
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 54a0532ec12f..8e70063074a1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -103,6 +103,7 @@ enum lsm_event {
  */
 enum lockdown_reason {
 	LOCKDOWN_NONE,
+	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/module.c b/kernel/module.c
index a2cee14a83f3..d8e1258e54af 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2753,8 +2753,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 #ifdef CONFIG_MODULE_SIG
 static int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2769,16 +2770,38 @@ static int module_sig_check(struct load_info *info, int flags)
 		err = mod_verify_sig(mod, info);
 	}
 
-	if (!err) {
+	switch (err) {
+	case 0:
 		info->sig_ok = true;
 		return 0;
-	}
 
-	/* Not having a signature is only an error if we're strict. */
-	if (err == -ENOKEY && !is_module_sig_enforced())
-		err = 0;
+		/* We don't permit modules to be loaded into trusted kernels
+		 * without a valid signature on them, but if we're not
+		 * enforcing, certain errors are non-fatal.
+		 */
+	case -ENODATA:
+		reason = "Loading of unsigned module";
+		goto decide;
+	case -ENOPKG:
+		reason = "Loading of module with unsupported crypto";
+		goto decide;
+	case -ENOKEY:
+		reason = "Loading of module with unavailable key";
+	decide:
+		if (is_module_sig_enforced()) {
+			pr_notice("%s is rejected\n", reason);
+			return -EKEYREJECTED;
+		}
 
-	return err;
+		return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+
+		/* All other errors are fatal, including nomem, unparseable
+		 * signatures and signature check failures - even if signatures
+		 * aren't required.
+		 */
+	default:
+		return err;
+	}
 }
 #else /* !CONFIG_MODULE_SIG */
 static int module_sig_check(struct load_info *info, int flags)
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d30c4d254b5f..2c53fd9f5c9b 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -18,6 +18,7 @@ static enum lockdown_reason kernel_locked_down;
 
 static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
+	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

