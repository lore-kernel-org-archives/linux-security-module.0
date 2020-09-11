Return-Path: <SRS0=uslm=CU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC9C43461
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Sep 2020 11:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F8F21D79
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Sep 2020 11:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSXLqLzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKLos (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgIKLoJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Sep 2020 07:44:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465BFC061757;
        Fri, 11 Sep 2020 04:44:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so11164328wrx.7;
        Fri, 11 Sep 2020 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Uxr7xy49Weq7pd1s1vVHMdn6nRX902qFhoxZ9UgjIY=;
        b=oSXLqLzqLlp5KZmNeVY0rQeg2YQWiyK/CQHbZfAfzhckCkA6R2l/25b8JyRCiarCBW
         hvshme8hDGfVvh1ji7zNlQRVNH4W1ufpY0crIE/Wf8KFPiJGfhf2uz7guen8da/aU8Xu
         /To45Nc8IKKsge6WBiZtwMJ/s06FYTtwTk+MfdJ2ZhppqAWiB0xkMLh7E+IguiYy3Fc+
         aKt71dFkuzb96Q+M0APNpLnEvfF5l17+Wo3ki/en1iVCfFilTry9kM/dsIb3qF3/YDH3
         eGBSbi+KeT6BZojwDv+UMymFE/ipvNf1plpL3yciN6FbZbjWWw5rrtQYYWm+rXnI5qBZ
         nCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Uxr7xy49Weq7pd1s1vVHMdn6nRX902qFhoxZ9UgjIY=;
        b=XI6yTvkD/GjeGHPrTYh2qS8kwIV3d4ghF2glkXg49isscB4I9SyW67asOjNPJ1Vwde
         KxokUqGNcdQgpk50W1BxqAAIK+72SoN8bh0+RPr3yOgb6grAtXqv4fQfTxl2s2t5D9+M
         d3SuASVh+UMS8Ymx1yJlN5XBoe6L/pfQQsBaMe6ZKm77ljfGL3KIezLfoPCNqRsljjYn
         LcMyC1rHGooNKZudepG1ovuRIR6963loka7D0JcwP7ky+kHIhX9mhBxnd4Bj3YcGcntz
         N1aZz/gHZ90o5jbfZwVTdpUIo5/LBjTgdVynuiVdufwdcQnNmhsvOtSiMo34WDxpPOPU
         xalA==
X-Gm-Message-State: AOAM5337qBCgzBF5/n9ep2PbKuPngsafB4kEk2xvL5UMnew9nq1OZ2Xe
        H7fqP48vZHC63cmvnRqGBuY=
X-Google-Smtp-Source: ABdhPJzsWtAPOH+dRmC4weQKtjF8A0Sq7DDAltrpBt83Tf2MFmx73sM9ngU2lceOV2OmN5zPwxhftA==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr1779144wru.363.1599824646937;
        Fri, 11 Sep 2020 04:44:06 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id g143sm3752442wme.0.2020.09.11.04.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 04:44:06 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: keys: Use kvfree_sensitive in a few places
Date:   Fri, 11 Sep 2020 12:44:00 +0100
Message-Id: <20200911114400.82207-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In big_key.c, there are a few places where memzero_explicit + kvfree is
used. It is better to use kvfree_sensitive instead, which is more
readable and also prevents the compiler from eliding the call to
memzero_explicit. Fix this.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 security/keys/big_key.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 691347dea3c1..d17e5f09eeb8 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -121,8 +121,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		*path = file->f_path;
 		path_get(path);
 		fput(file);
-		memzero_explicit(buf, enclen);
-		kvfree(buf);
+		kvfree_sensitive(buf, enclen);
 	} else {
 		/* Just store the data in a buffer */
 		void *data = kmalloc(datalen, GFP_KERNEL);
@@ -140,8 +139,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 err_enckey:
 	kfree_sensitive(enckey);
 error:
-	memzero_explicit(buf, enclen);
-	kvfree(buf);
+	kvfree_sensitive(buf, enclen);
 	return ret;
 }
 
@@ -273,8 +271,7 @@ long big_key_read(const struct key *key, char *buffer, size_t buflen)
 err_fput:
 		fput(file);
 error:
-		memzero_explicit(buf, enclen);
-		kvfree(buf);
+		kvfree_sensitive(buf, enclen);
 	} else {
 		ret = datalen;
 		memcpy(buffer, key->payload.data[big_key_data], datalen);
-- 
2.28.0

