Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B95C43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD91720663
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRJHSCTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCFX73 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:29 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36427 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfCFX72 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:28 -0500
Received: by mail-pf1-f201.google.com with SMTP id w16so15441639pfn.3
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=on0K5RsXZCuQ1MSHm3bzRhjjZRQoobIGEx9Qfo8mw4g=;
        b=BRJHSCTT5HXLhMtX9ZhNlkKo0cDQm7AcgfOZcUu0aVzbksY2LE+NzHcIcivLi8bvmr
         QVIr11Kz9ZMgAarXVz8pGyLrX4PgOilfxs+OxOumql0mEeSGAhZTIitLv+vpyA9FsDxR
         PkXbU8I/n23+DS+uuWh190cNWlx2abMh6wXCuXn5ib5BLnreSIOVpRc6d6TEdFfLjXnd
         Mc3scLQdBEsEUyRSZMkV9pl3zGQtDXrZ84RTwmtCCwU9Vnm+wltQA/Plox9G5aTc4g7R
         66+o6J0+C+fCe9Ez6FZ/Vk481nzH2qjQrrLzVyjGya50CvNhzziWyreF85q2LAMcEgby
         dowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=on0K5RsXZCuQ1MSHm3bzRhjjZRQoobIGEx9Qfo8mw4g=;
        b=fRb5C4vGQ+SxyGIKWKi4+3ez8FNPR2saztXu3Ea2kxJSdrs/KEmSGTtJoVE2xIicD4
         d/+u0je3ddfG8aya87kDyOhdTwHVcVma7yjv5h0e/OO/quWeosBxfsT+pgDguNxSZqV5
         5g9KZBwQlhj4OdhMtni3Y402t5m+IElwhHxC89J61ExlvDVdm+EIPFf0AicSudW9x4ln
         KewYsSern4/SoVtZ+dc2YNlKBkoHSNDZ4lVco/7Nl31RfyRcgSjLeiTqdxsHXP3PPI6l
         g15l0Llg9M7hHVilbbA0vV8RTfN2sZDTaDsOPYnRYJTOWKDp0ZHGduXjl15iVAswveT+
         krAA==
X-Gm-Message-State: APjAAAWXK7XaLHVh37szVgmdoX7U6BkH6D+2x/K5+xkTNUsXV2Lf5R94
        BerS2dfc7v+apJ59lmj54ZO0ZcOcRhnGbyX3o6qBkw==
X-Google-Smtp-Source: APXvYqxcWasyCCaYPhVYEfqiCvDF53otXQ/MyvgFH2qxeaaDZ8tzGek3/QhJs6plqMr+BqfthgxyQUs9xtWbIXvMXd0J2A==
X-Received: by 2002:a62:5206:: with SMTP id g6mr3844743pfb.58.1551916767462;
 Wed, 06 Mar 2019 15:59:27 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:49 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 03/27] Enforce module signatures if the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: "Lee, Chun-Yi" <jlee@suse.com>
cc: James Morris <james.l.morris@oracle.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/module.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 2ad1b5239910..9a377c6ea200 100644
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
+		if (kernel_is_locked_down(reason))
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
2.21.0.352.gf09ad66450-goog

