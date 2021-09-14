Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C75C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9639C60E08
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhINUD0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhINUD0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 16:03:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4CCC061574
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 13:02:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so86006plr.12
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ytz9T65KINeMDYgtvEhkkCARVDqnbfdteXwgWuVKDiI=;
        b=NRuom6JboBrj4IXL+pBGw7eEz90ljXX1tfKU8KHlfdND+6f8WcEcq3XSl5fZ+Z7Hm7
         jOf2r+/EUDLBo2NN6Fo36PIWetd1fxV20GRa8K/6eGrxrDkSGtLwzkC0HQ2wotAzsSqJ
         QwxakmNvcd59dGryK2aUYTK0qGCUv6FnpFEms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ytz9T65KINeMDYgtvEhkkCARVDqnbfdteXwgWuVKDiI=;
        b=oG39SOLPV0p/TJ5nUExpMTH/c0Eh7TVArKrOmkV/orx9+w44SUDphYwyd0j4T/6HHq
         pboz9DttbAsI7CLvTeo9Q9oZPY9eaqhGB27i6dtzl3+VSSksN9ahCf90AVQrc3tyTzXh
         eh/G6D0QRFMaaN62ajLfQB5U4aVEGEEgvby5Kj0pHr8nNcdEYLKRuRDHJScNfBdCLKwD
         ZXhINNQLYDIjHb+siHoMUZ8IcsrHyJLEe76z0Sz/Yy0LoaW8ute8abJK6YODGwTnecZa
         WDEzTGOsLXk/4fyGfvWlmAJmRBpjc16VDIpS9vvU7BJApVfsNehRW+U8Ge4MX2HATqo0
         Ferw==
X-Gm-Message-State: AOAM530Nx6Ly23JG5TMOQiim7xsUOk7vbP2Z/NvIGLgiozuDLV83jDnP
        mn+1HQobejjHFU8M2uAUthgH7/QW6M+Mww==
X-Google-Smtp-Source: ABdhPJxhhZk1i7zHZPiprze3RqdD3yBPfw9oRSO69WtgTUwL8hmFgpqNya25NvLvysnJFy0XAsg0ng==
X-Received: by 2002:a17:902:8a83:b0:132:6674:f28b with SMTP id p3-20020a1709028a8300b001326674f28bmr16382589plo.63.1631649727515;
        Tue, 14 Sep 2021 13:02:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m21sm2406530pjl.14.2021.09.14.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 13:02:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] hardening: Avoid harmless Clang option under CONFIG_INIT_STACK_ALL_ZERO
Date:   Tue, 14 Sep 2021 13:02:03 -0700
Message-Id: <20210914200203.1667751-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2977; h=from:subject; bh=imXvSq9i08/jXla4+sBmsEoHRgxDVq0c/pR4Y+Src2Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhQP+6KIBv7ADhwLtBfRJcxajHiIjU9syPZkgPPvze 7pK8/OSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYUD/ugAKCRCJcvTf3G3AJmttD/ 4mVU7Uy78lGKS9GG4/AATbbI2r+H4dlMvkCBdPoS9u0ZZWy9ANO/hgX4YAbWMHyJlcwuYaEF0qlNXY FH+7dggnZaFS02i3ZFJLPcdDZPEBZnFO87uTxXL9lDha35X9mC7epPNTP4noj25bU5erE5pbxyxPDu DqImezS/gxrMsa1DPkvzKshSTEOM/LfO9VmN9wucjUMzlEYZzsToT+DbvdczK0B5RgoCSY787J5FYu 6P+N5A3SeT4ob22KoyAGNYGhXjELxTAPqnvXbj0CEkRh1WKNc8Knz/R9mk3FCx0qMkCRx5UxqYXMc2 E46IBRhrauS2lc2V0BQ9Ucip2broVQVj/A5jWAt7zd3JubGP14NTreyt9tV3Ry21uOrZfpipH/Txh5 plKgkla9cKh4yOR6PXD6wmEihq0pkOrOg3HSkWLtH2/dknakAYmN863uoCRPbe86Y2PMyM9uy1EU7V 9pS8Hz+GnxJLTX6HMJvQZvCyfQ/9Nj996X3+9iXDguWxM1fqrw9vwr/qdP1GO0jMKb/CqdAUNM1Xge 2tzx3f9Ds6ue6YV6t28roXbHEyYyTwzggRYDpWyj6pbN3NknET2P0o8TNtnCBFLDYyQKwc9YstZ02m vuyuoahu6RDM2jnuT5Khd3rtsnEBEbQW7Wp952MN5xrEpYIsZ2Os14rEiVNw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently under Clang, CC_HAS_AUTO_VAR_INIT_ZERO requires an extra
-enable flag compared to CC_HAS_AUTO_VAR_INIT_PATTERN. GCC does not,
and will happily ignore the Clang-specific flag. However, its presence
on the command-line is both cumbersome and confusing. Due to GCC's
tolerant behavior, though, we can continue to use a single Kconfig
cc-option test for the feature on both compilers, but then drop the
Clang-specific option in the Makefile.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: llvm@lists.linux.dev
Fixes: dcb7c0b9461c ("hardening: Clarify Kconfig text for auto-var-init")
Suggested-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/lkml/20210914102837.6172-1-will@kernel.org/
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile                   | 6 +++---
 security/Kconfig.hardening | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 34a0afc3a8eb..72d165ffabdb 100644
--- a/Makefile
+++ b/Makefile
@@ -831,12 +831,12 @@ endif
 
 # Initialize all stack variables with a zero value.
 ifdef CONFIG_INIT_STACK_ALL_ZERO
-# Future support for zero initialization is still being debated, see
-# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
-# renamed or dropped.
 KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
+ifdef CONFIG_CC_IS_CLANG
+# https://bugs.llvm.org/show_bug.cgi?id=45497
 KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
 endif
+endif
 
 # While VLAs have been removed, GCC produces unreachable stack probes
 # for the randomize_kstack_offset feature. Disable it for all compilers.
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 90cbaff86e13..ded17b8abce2 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -23,13 +23,16 @@ config CC_HAS_AUTO_VAR_INIT_PATTERN
 	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
 
 config CC_HAS_AUTO_VAR_INIT_ZERO
+	# GCC ignores the -enable flag, so we can test for the feature with
+	# a single invocation using the flag, but drop it as appropriate in
+	# the Makefile, depending on the presence of Clang.
 	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
 
 choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
 	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
-	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
+	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_ZERO
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at
-- 
2.30.2

