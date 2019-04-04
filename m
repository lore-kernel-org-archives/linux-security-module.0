Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BA6C4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1096F20820
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VagzsV/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfDDAfd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:35:33 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:40083 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfDDAdB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:01 -0400
Received: by mail-vs1-f74.google.com with SMTP id l6so64055vsl.7
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fNnpo8lLzymZARu5UXrve26AL2A88YZO9HZRbBxOnPc=;
        b=VagzsV/GOtPglfcVAyOphZ6+bVVD4ZbfMzItuKqhvYZLgU1u3KPRVAvlOamt8YnoOJ
         +8QQ+xK45r5Mvlgk0BL4/GKJmr0qmySeg0i2eBUfDL7DwdH+urAgs6KVu+pEfJoTTPeu
         UXdF9MlekstBa4MgT33etfSkXxK7il3rlNJ9jyMix+gouqtxYP8gFTmzJG/WA/FBnSfR
         UhcZZlpWCJLlrRXbC8VoHW4Ne50W8CDKRFmJmmzDXQDXw7C6ZeQK6yOMsbTdkHTDf+TV
         NuWbl7zBb2C2yPMb5aBB9xEsq+SvqwqeFvT4IHTRujmmhYRMC4FkePtUdXu2HPwjqHcc
         aUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fNnpo8lLzymZARu5UXrve26AL2A88YZO9HZRbBxOnPc=;
        b=d1n7ApIWnJK7wg/ZDsI7oHtwOqwTlQvl9Evo40yfD28U9abJFWegk0oLoRDqqaDdzj
         mCQLyyRJe4trw8bOAnbEjn2vQulmCEQv+6an+1T7l3eAdOhUh4kngl0k9uxiDmfHDXWo
         s+ucSdpq3shQJGpa/POmNvviwg0/haBzP5aO4vOyoyhnztsb8nFadrSavwPaCaJ7AD1J
         X9LDtq3bMoZMqSY0dVnWBjT4pMW/Yp4rKHo7hC6xRqlx6TECbRajBQUF4fseV8dFnbKR
         DlKEkWwvZZK84+qBkdREF4SMdqA2NGY1thwIOsr17aMhPD2aewF9oVGkTMemzHavWGHD
         0mcw==
X-Gm-Message-State: APjAAAXtpFWWg2NJiRjGaL39OLbvi4BZECl15RICNOpo/jhC/3xYpkBb
        efkcSrj7rDnPqJe5VXXtpwoUbGVfzZZSm1O4jnCE+Q==
X-Google-Smtp-Source: APXvYqzEoCm7SP2u+ZOUlxbsorBu+4zlH+UN4ej/RRdM5tZcMiR0pjXVyaXpI+eG5Hg4KuyXMm0NoVPbFMMEAboSkheVyQ==
X-Received: by 2002:ab0:694b:: with SMTP id c11mr415622uas.17.1554337979931;
 Wed, 03 Apr 2019 17:32:59 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:24 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 02/27] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Jessica Yu <jeyu@kernel.org>
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
Cc: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 2ad1b5239910..deea9d2763f8 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2767,8 +2767,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 #ifdef CONFIG_MODULE_SIG
 static int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2783,16 +2784,40 @@ static int module_sig_check(struct load_info *info, int flags)
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
+		if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY))
+			return -EPERM;
+		return 0;
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
-- 
2.21.0.392.gf8f6787159e-goog

