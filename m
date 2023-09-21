Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E99E7D0A6
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 20:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjIUUOD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjIUUNo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 16:13:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7F392819
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 11:54:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d818fb959f4so1845522276.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695322461; x=1695927261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6b+r/qO6jTNd+eQdEZK212ydTtWtBK6Hb2cWKKJgo7o=;
        b=Rj6H/jq0RXpY6lFrI48jysV0iZ9hkRY63vhJoo1NBULrphM3/NtWmTeUAgPbaVLWnL
         blwB1Gf5itzJyTfd4/8graG0p8h2Mvb4HQNRWMFgXF355oqG+Z2Z4cAyfX/3a2e64Oh+
         S9Tayz78LEE56OXeOWL0lH2KtavjvhJr6+oNUqarw1rvSUdAr/XaHgx/Zt/TlIysK/sc
         tvFi4R/oUrfVnPM+c0eOzGTVoZZPLLBMyRjgzgtQk8159LPH8yCZnwc6x4Msd5h5cNkr
         91O3eSVTt8y37hSV2VYuau4Rne3ppvinyRoVOlnbn8p5cjCCq+sxqted5uv3Bpk1zMZ0
         0mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322461; x=1695927261;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6b+r/qO6jTNd+eQdEZK212ydTtWtBK6Hb2cWKKJgo7o=;
        b=d7wkWHCqHFb6/3F1PQqMIqhRSZ6V5MNdLfnbh8TVYrOC0JgXvAVuobswrtC6vB/95S
         JE7+Vlvaoes+YWFBTHL67nnxZVI++Ywwi0bHk3NG+lv9MtcSsPk1MLEuWRxBtU8gmVs9
         sjApxDYkLnEe7UIOnRCZYtb+jLgU/0iGK92OTiLufnybSyc28KKjFsyKrLq1+4cKt0DM
         qqzw6YDAtBC8ZKSazGK0Ckm0pI+97KmZD4OxaPLIz7jl9BLIz60QkyKx3Uss8Tdwux9H
         VrlFKIWGYzyUJbaGADKzqVP3x7x65smmeJWjuy+v5DV4BuCfgOLLJjmn9EMZUvR9oJ2E
         nS+g==
X-Gm-Message-State: AOJu0YxQhcNCGss9/71cZbyTizXHq33d+MnT5qndzpbaE968aOXwpOnf
        I9UXzEE0L0vw0DZqR/nrKgOFfvo=
X-Google-Smtp-Source: AGHT+IFLA7pELMkRmPVUcV9dQSyP5wShtjA3I4pLFmR0wr3ICAIAxSCbstWOoMP3LDJ/cCr9C0wtfNw=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a25:408f:0:b0:d7f:8774:dfd4 with SMTP id
 n137-20020a25408f000000b00d7f8774dfd4mr62822yba.12.1695278727640; Wed, 20 Sep
 2023 23:45:27 -0700 (PDT)
Date:   Thu, 21 Sep 2023 06:45:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921064506.3420402-1-ovt@google.com>
Subject: [PATCH] ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig
From:   Oleksandr Tymoshenko <ovt@google.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     ovt@google.com, rnv@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The removal of IMA_TRUSTED_KEYRING made IMA_LOAD_X509
and IMA_BLACKLIST_KEYRING unavailable because the latter
two depend on the former. Since IMA_TRUSTED_KEYRING was
deprecated in favor of INTEGRITY_TRUSTED_KEYRING use it
as a dependency for the two Kconfigs affected by the
deprecation.

Fixes: 5087fd9e80e5 ("ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig")
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 security/integrity/ima/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index ecddc807c536..4e559bd1fd41 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -269,7 +269,7 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 config IMA_BLACKLIST_KEYRING
 	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"
 	depends on SYSTEM_TRUSTED_KEYRING
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   This option creates an IMA blacklist keyring, which contains all
@@ -279,7 +279,7 @@ config IMA_BLACKLIST_KEYRING
 
 config IMA_LOAD_X509
 	bool "Load X509 certificate onto the '.ima' trusted keyring"
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   File signature verification is based on the public keys
-- 
2.42.0.459.ge4e396fd5e-goog

