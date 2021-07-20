Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A28C07E95
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2AB6113A
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 22:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhGTVT2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Jul 2021 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhGTVT0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Jul 2021 17:19:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608FFC061766
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jul 2021 15:00:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bt15so508084pjb.2
        for <linux-security-module@vger.kernel.org>; Tue, 20 Jul 2021 15:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WyxGUW8l0i1+27gVKNpxMIuSdpPKu6kJDnkVFPaL1B8=;
        b=CvGYL7R+ixxU/JIlmN6/TJdMXXXXBl4WApNx0WZ/sQ60gmly7rRjWn5rEs/7RcgL8+
         48a66pvoeTtIOcO4Yj/ISKAz00K3YYrzUYzvTtWhiQMdzEx0SMkmZvjNddi27ZygyNgz
         VF3+NsdsEEmtRvjR7ZOmSMnN7Cylp8rFHYI5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WyxGUW8l0i1+27gVKNpxMIuSdpPKu6kJDnkVFPaL1B8=;
        b=YYACslCs1zsY1EmN3530lcJ9zIXhq1RtOiccAPqgNw8kKPKt0CUovI8yxtDINs53Ue
         BzseJ5gH/2q+Vd3K1ivFXjXfndIHZgXdRcHD9KTGFelNIV+YCrFJJgtklHpxx/OTak7z
         9UnOHw3ovclB5Ae0w1n02k160RvvlzmfHZFPnVjNpBVf7k7LbhOXV9S41e0hGwElPpIu
         0xEHSrCJAmPT8olVP1kanNVuHRjhwRiFiWsqsJYJjx4dLHYJFajRdlFxqGHhUBaS/Z2A
         iTH5UzbMhYW0vRkgHipRGwy2scJtptKGwbY2InkrOzF8RujPcjEOr/1rsQy1Ao4gbnfF
         qd7Q==
X-Gm-Message-State: AOAM530KOp9+srQT2k/zLmPMFgyxpFWaPPWiZWpSchj+d6+UHkeqLVPB
        6mcL0KkRTzf28HVxKr+kcEUyFQ==
X-Google-Smtp-Source: ABdhPJwZLJrQEIugeNEH1We9YX0Ow3bcRiVxxx12v0TxyrOgmHcmdg1t2SI0sqWzHQWp/tQIRiaZ4g==
X-Received: by 2002:a17:90a:c8b:: with SMTP id v11mr505781pja.114.1626818401485;
        Tue, 20 Jul 2021 15:00:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e16sm28694557pgl.54.2021.07.20.15.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:00:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, glider@google.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] hardening: Clarify Kconfig text for auto-var-init
Date:   Tue, 20 Jul 2021 14:59:57 -0700
Message-Id: <20210720215957.3446719-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4689; h=from:subject; bh=Z2jIdIqSWFjGjbsnH0q1H4OQWdcOHIzxX0E/vHpuz2Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg90dclov0B+zGzREFyMibbwv9l5oqr9QJrpcMBRsN hb++VKyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYPdHXAAKCRCJcvTf3G3AJvpfD/ 48Gq6fxhiEccbjQyQe+7IJXzIsYGWv+awOpA5DqwDe5ctfyYW5icxUSVx+Clzkn60bS8MOF5HK64Zs zu2EN8WIVWI53o/I7n8yieURnaJhOWRaodHPfz6sO8dvn3ddQAG2LF18ckn+L532AKdvPnDGhGHFDR Ez7EcJQoM2jNCTffA+Z7joyraqV4sL590QVJ6mB6CWtxsy2rB8JRIv73xRyHtajtELy3TJ9fExNdDZ ZIA26rgLKetjgMSKtz45O4khEwF0biQzfJw/pev0HXIzTOs5LZ+oxWMKyMM5dU9/77VKgTx6FDd9OE /Un9lPGCZKWTkGdyOUTXo4LNX2DYldun1e7zJ6Y73mo0HY//kluFhjJx/A84aNfge+v8JufRdH7ymD woQcwoMBkyRAWQFy4Jd/S91LPhyp1NA1uXoc4M8ZXvePbBtG201Awb2fCaYEAuXm7TiR18GmAtRqsB XR3rfGyHFvi/qRNpjBfAnvgOL2UY/r9TYrKZhNBEsMcIWpGLKjT6Jtlqf8MmXHsuNVElcnIPRCgom9 wdrabjtlA41UUFPBGhgsEF76FSR3UPI2v3gL/T+jL7RjJp++1nTkK5M38G1RKo8Zfda0wK3qcLIaVU vs2ym4j9tzZ8qvAreuqUY7R+rhMNrO4+Iyo4eQ8M6ZhUT9i1aYIRpPQ0uhQw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Clarify the details around the automatic variable initialization modes
available. Specifically this details the values used for pattern init
and expands on the rationale for zero init safety. Additionally makes
zero init the default when available.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig.hardening | 52 +++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 023aea5e117c..90cbaff86e13 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -29,6 +29,7 @@ choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
 	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
+	default INIT_STACK_ALL_ZERO if CC_HAS_AUTO_VAR_INIT_PATTERN
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at
@@ -39,11 +40,11 @@ choice
 	  syscalls.
 
 	  This chooses the level of coverage over classes of potentially
-	  uninitialized variables. The selected class will be
+	  uninitialized variables. The selected class of variable will be
 	  initialized before use in a function.
 
 	config INIT_STACK_NONE
-		bool "no automatic initialization (weakest)"
+		bool "no automatic stack variable initialization (weakest)"
 		help
 		  Disable automatic stack variable initialization.
 		  This leaves the kernel vulnerable to the standard
@@ -80,7 +81,7 @@ choice
 		  and is disallowed.
 
 	config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
-		bool "zero-init anything passed by reference (very strong)"
+		bool "zero-init everything passed by reference (very strong)"
 		depends on GCC_PLUGINS
 		depends on !(KASAN && KASAN_STACK)
 		select GCC_PLUGIN_STRUCTLEAK
@@ -91,33 +92,44 @@ choice
 		  of uninitialized stack variable exploits and information
 		  exposures.
 
+		  As a side-effect, this keeps a lot of variables on the
+		  stack that can otherwise be optimized out, so combining
+		  this with CONFIG_KASAN_STACK can lead to a stack overflow
+		  and is disallowed.
+
 	config INIT_STACK_ALL_PATTERN
-		bool "0xAA-init everything on the stack (strongest)"
+		bool "pattern-init everything (strongest)"
 		depends on CC_HAS_AUTO_VAR_INIT_PATTERN
 		help
-		  Initializes everything on the stack with a 0xAA
-		  pattern. This is intended to eliminate all classes
-		  of uninitialized stack variable exploits and information
-		  exposures, even variables that were warned to have been
-		  left uninitialized.
+		  Initializes everything on the stack (including padding)
+		  with a specific debug value. This is intended to eliminate
+		  all classes of uninitialized stack variable exploits and
+		  information exposures, even variables that were warned about
+		  having been left uninitialized.
 
 		  Pattern initialization is known to provoke many existing bugs
 		  related to uninitialized locals, e.g. pointers receive
-		  non-NULL values, buffer sizes and indices are very big.
+		  non-NULL values, buffer sizes and indices are very big. The
+		  pattern is situation-specific; Clang on 64-bit uses 0xAA
+		  repeating for all types and padding except float and double
+		  which use 0xFF repeating (-NaN). Clang on 32-bit uses 0xFF
+		  repeating for all types and padding.
 
 	config INIT_STACK_ALL_ZERO
-		bool "zero-init everything on the stack (strongest and safest)"
+		bool "zero-init everything (strongest and safest)"
 		depends on CC_HAS_AUTO_VAR_INIT_ZERO
 		help
-		  Initializes everything on the stack with a zero
-		  value. This is intended to eliminate all classes
-		  of uninitialized stack variable exploits and information
-		  exposures, even variables that were warned to have been
-		  left uninitialized.
-
-		  Zero initialization provides safe defaults for strings,
-		  pointers, indices and sizes, and is therefore
-		  more suitable as a security mitigation measure.
+		  Initializes everything on the stack (including padding)
+		  with a zero value. This is intended to eliminate all
+		  classes of uninitialized stack variable exploits and
+		  information exposures, even variables that were warned
+		  about having been left uninitialized.
+
+		  Zero initialization provides safe defaults for strings
+		  (immediately NUL-terminated), pointers (NULL), indices
+		  (index 0), and sizes (0 length), so it is therefore more
+		  suitable as a production security mitigation than pattern
+		  initialization.
 
 endchoice
 
-- 
2.30.2

