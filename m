Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02706C5479A
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Aug 2023 21:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244261AbjHQVDR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355138AbjHQVDE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Aug 2023 17:03:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8681E2D7D
        for <linux-security-module@vger.kernel.org>; Thu, 17 Aug 2023 14:03:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf092a16c9so2223265ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 17 Aug 2023 14:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306183; x=1692910983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0/qVubjCn8QjeiduEIaoe1YZl8jLl5oqB9xdcoWoKQ=;
        b=SO1eMrC2GY1aIR7YrQb+v7ANMHyntlxzYeKA/Fdg1vw7Vy7SmU9Nn5CXZk2aEoWzEt
         Mps9n0NMAp9aUHb43+IXTc38YO4M/TB9nEM/8hc323qpHktu608hNxbruW00XHb2tvyC
         6ccdsht+VYo30dX/orku3k6uCnXEOT0COyd/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306183; x=1692910983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0/qVubjCn8QjeiduEIaoe1YZl8jLl5oqB9xdcoWoKQ=;
        b=W/Tf71SA9Ce2kcqHXNlptgkMYyjxMFYUc52FvPpEak9F1/jfbarBxvZu104UFuXLrL
         Kjt6Zg0ONli8Tg8YzWMONjrHQfIKExib3+SzP10eHMm6fI5eeYMq+NHWR5w1Oi5xHNAJ
         FUDaoSTydlIribHlkDGvNLnTD50EEE/MQQMDtRT7io5MtvQdFveWCDz7MWFHb6Jrvwua
         nU6Mi1MwcrrRp4F7bvAE1OAN4KiSd/UNxa9Wgq8mPgARxCTFVOiaPnm87LDpes0xeZQO
         xqFWf5SK8avkNXQdHKQMD2D0Bhamop4XvsNiXMgFObzQTzijKWYsOj5V3IWEnJU15U4a
         NVwg==
X-Gm-Message-State: AOJu0YzNr2MJHfhmx38JLlGm5dy9Qkmf4MY0iYxhZ5sMX/MRaW9bCNpk
        k+310HPTrdPwjBqeWIGj1/iUyg==
X-Google-Smtp-Source: AGHT+IHXnDzFXlw3xeo5r1JY5HaLFsc5T+vkvbY7aXlRYd6GvorNyJTr4toAE8Jcz32Oc5mK+prnhA==
X-Received: by 2002:a17:903:18a:b0:1bd:b073:a55e with SMTP id z10-20020a170903018a00b001bdb073a55emr730093plg.5.1692306183053;
        Thu, 17 Aug 2023 14:03:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b001bbb7d8fff2sm209717plb.116.2023.08.17.14.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:03:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] landlock: Annotate struct landlock_rule with __counted_by
Date:   Thu, 17 Aug 2023 14:03:01 -0700
Message-Id: <20230817210257.never.920-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=keescook@chromium.org;
 h=from:subject:message-id; bh=iTklL+T2FjRBoyo3mvZaG8ACV/VUbVrQ2aCwx0twq2M=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3osEFMJ0zzGJ63CR65j8tvMzUBtC6PHXb0KZM
 A3k/eDiVTSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6LBAAKCRCJcvTf3G3A
 JoQ/D/9ikKtdFJsQ4UzJxwOtg/1tA67jGqfW8tNupzPzY4K3L1HVvx9tqc1sgZAzZpnz6KB0pWQ
 Xzpae8S+kAEwB9B87UpgmBd+vwrczwgchrO7kF3V0FlEAlXjJQYNCzoYJM3L79BP8ko1Pm4mB8d
 KukOxNx3kjLPzdD/WvaYQMNn2tBzDZrD6gP/6qlMNw6phcZbLmlwWnUj68sx+TRX1YzQgT5379d
 x6sPHU1OJjPhFBWBB6TykBCi02w3ouRO2R5m/u8xxHTIQokya7heN2lzV7fb4bCzZ+Phz4AEDpm
 59cI9Qoo8mLd67NQuQs80c0JcnHP1YTSV1q4u5zql0qfxvIcVpSuozPCTbfDfl28A8YnDYDvYTj
 aDOnEi8W4B62zswUyKkqTfl5QT+o0+LPzUfHW0RcZ/yXDFUeqQBMF4YTgVtkt89ZFYa7XzjIf2K
 kknZ6EZHzPYDQtsSUMjGQDSBbjfT3B5n14/SldPg1Fpt/+vIKCkkWgIXZG7KXYGKYq7pGyi+DuB
 Ox3gE3iL3JFa+kzflMqe28NUf6/RYmhTxnqKujjdNGr0AaWlRGYpngjBch3Uqm40ixjqJ9izWhV
 YrqeMkNoiaGgSNUJYBLt9SD+oUTmcNmnhC0G5BQ0l+f8iHoNTcWAXsfBI4Fl9FDIiGzhxEO5obf
 dCobU81 NQuDQYQw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct landlock_rule.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/landlock/ruleset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index d43231b783e4..55b1df8f66a8 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -67,7 +67,7 @@ struct landlock_rule {
 	 * @layers: Stack of layers, from the latest to the newest, implemented
 	 * as a flexible array member (FAM).
 	 */
-	struct landlock_layer layers[];
+	struct landlock_layer layers[] __counted_by(num_layers);
 };
 
 /**
-- 
2.34.1

