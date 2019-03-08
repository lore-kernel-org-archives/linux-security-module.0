Return-Path: <SRS0=RbId=RL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E03C43381
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 13:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31EF2087C
	for <linux-security-module@archiver.kernel.org>; Fri,  8 Mar 2019 13:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUlH6Dmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfCHN1R (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:27:17 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:46413 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCHN1R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 8 Mar 2019 08:27:17 -0500
Received: by mail-yw1-f73.google.com with SMTP id g6so27758558ywa.13
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2019 05:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yqzTiUVyYLyv9KlkUwhxAc47WzGcrn+Wl93m1d0s4TI=;
        b=SUlH6DmgbaUC6Nvh5WLFxCglPyIMG0gZdXWMvoXDO/rSyOM9rfSkS7FA06gaADddoS
         +T87l6xR8oFCkJKa2PfVJfT1JGwrNZ+ZARhedauJEd/3UDjB6JcCUcpLtR74sYE2UCRP
         GQ0r5jm3pFB5rIl05jDolfafgKLu6Cy7AH0jzzeXlyYH3bmARC79/5bvp1BelL/cRvlo
         aIAM/btrCQYV6WtrRC56Ys9RwfOa1zCsmdBnhac3ALV1zc84WEubFvdQJq7DLyBkKrkZ
         crl1NY1EpSa6vRaCY0YRGhQHH/nXJN1Pd1vKa+jCNVq/tHLDqXTZasuhDHrMWWlaiyLi
         M29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yqzTiUVyYLyv9KlkUwhxAc47WzGcrn+Wl93m1d0s4TI=;
        b=AAoLTMY7HGIWLV6jkshZ82ZT1MBxUds5/9x+kwh5a1MBIMQap47ijg100BU1+0tHAd
         CPXOQa4J67ZGBdFpBu3RSyZ0Yg2L4NerWA0xBB6nvVK25YtpaVEhJNZNZ9eEDsq5Wd3g
         RGcNcSLXk8qKhIOeCfrS8m6Tk6qP3qutapl0oZfQ5YtLD67vHOee/PxbQJT3Cy4k8/f6
         O/1yJGc0ms7O7HvpW4a7qGn7vKt4jCMdoDz9zu40nSl89MgM52HTA9f6NKbq/x5ICUWN
         uK/CLjlq61k7vJOSizk8QY9FC7BoOuSrcF547xgI0b/owze99skQ4gukwqQSnqTFJSse
         lejw==
X-Gm-Message-State: APjAAAXxaZkeev5Sk9OMkhBpF/lVqt3pZjImw9fiFCbmSqXyAKnyPf+D
        ebB3B0tvP9KJdENwPD8+vJV4qnL/sm4=
X-Google-Smtp-Source: APXvYqxKz4BvldII6JDKfVcbTdRjrj8iWTTtN2LnxMbKzD+Mub0f07BKOBXFWdUJ5jRGcSVvgfvlCXVGfKg=
X-Received: by 2002:a81:b184:: with SMTP id p126mr8399501ywh.14.1552051635984;
 Fri, 08 Mar 2019 05:27:15 -0800 (PST)
Date:   Fri,  8 Mar 2019 14:27:01 +0100
In-Reply-To: <20190308132701.133598-1-glider@google.com>
Message-Id: <20190308132701.133598-3-glider@google.com>
Mime-Version: 1.0
References: <20190308132701.133598-1-glider@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v2 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
From:   Alexander Potapenko <glider@google.com>
To:     yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This config option enables CONFIG_SLUB_DEBUG and CONFIG_PAGE_POISONING
without the need to pass any boot parameters.

No performance optimizations are done at the moment to reduce double
initialization of memory regions.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sandeep Patil <sspatil@android.com>
Cc: linux-security-module@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
---
 mm/page_poison.c         |  5 +++++
 mm/slub.c                |  2 ++
 security/Kconfig.initmem | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index 21d4f97cb49b..a1985f33f635 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -12,9 +12,14 @@ static bool want_page_poisoning __read_mostly;
 
 static int __init early_page_poison_param(char *buf)
 {
+#ifdef CONFIG_INIT_ALL_HEAP
+	want_page_poisoning = true;
+	return 0;
+#else
 	if (!buf)
 		return -EINVAL;
 	return strtobool(buf, &want_page_poisoning);
+#endif
 }
 early_param("page_poison", early_page_poison_param);
 
diff --git a/mm/slub.c b/mm/slub.c
index 1b08fbcb7e61..00e0197d3f35 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1287,6 +1287,8 @@ static int __init setup_slub_debug(char *str)
 	if (*str == ',')
 		slub_debug_slabs = str + 1;
 out:
+	if (IS_ENABLED(CONFIG_INIT_ALL_HEAP))
+		slub_debug |= SLAB_POISON;
 	return 1;
 }
 
diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
index 27aec394365e..5ce49663777a 100644
--- a/security/Kconfig.initmem
+++ b/security/Kconfig.initmem
@@ -13,6 +13,17 @@ config INIT_ALL_MEMORY
 
 if INIT_ALL_MEMORY
 
+config INIT_ALL_HEAP
+	bool "Initialize all heap"
+	depends on INIT_ALL_MEMORY
+	select CONFIG_PAGE_POISONING
+	select CONFIG_PAGE_POISONING_NO_SANITY
+	select CONFIG_PAGE_POISONING_ZERO
+	select CONFIG_SLUB_DEBUG
+	default y
+	help
+	  Enable page poisoning and slub poisoning by default.
+
 config INIT_ALL_STACK
 	bool "Initialize all stack"
 	depends on INIT_ALL_MEMORY
-- 
2.21.0.360.g471c308f928-goog

