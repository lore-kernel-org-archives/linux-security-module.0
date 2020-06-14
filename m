Return-Path: <SRS0=sigj=73=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A3C433DF
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6B420578
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 14:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMwlKrrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFNOpm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Jun 2020 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNOpm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Jun 2020 10:45:42 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48689C03E969
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 07:45:40 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d187so12154128qke.4
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cES73WJaLMoUweYIM+OlRJ2Jm853+1vLwtEwV6Uh388=;
        b=pMwlKrrHagVLWTUat4QRNSBaTmseF6Z+raXgWIIqRaGm32qet+ibqsVdxjZ1TQZOP6
         3NrTDjoo72m0GXXw+6rq1i0wbY/80L2a/P2kf/i1+bbxZ01cJUPNcMcnD4Jfu/9mR5Hp
         5DQCr+bpfXTbpo1LOmHyCtcIyoInzk+NtksLYTG/HmRUXIyLGd9NP3wpuRvXdTncf8fT
         cJUQZsbItoIyZI/pn6Dt3j4v0X8B1MKBr57SpiusXEiIQKstqowTgHYgC5i0NkpphVgU
         GNowbTVhXFd7DuYMnR+WXEcYSTXUL1dapX3wiNm8nCF7l49dweq/s+0WHf/HEkIY+qeT
         VDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cES73WJaLMoUweYIM+OlRJ2Jm853+1vLwtEwV6Uh388=;
        b=Ojt1AvuTeTrx5XWQ1G1m1wZZ3PqahQW91KHB2/vnXCZKJ9/b2w+3Qwfx04PtFL9gNm
         D0rhNoHsewvhtnWQwwRiTfkOiGlF8769c5/pyxPLkShWCsDbnPPKqr6OSRFzWQ8AhU8b
         mL4aC/ofGfPy8Z035xaXtIUxepRGAPxEFi5UgR+rnr5IFmDQJlEwimXqd23of4RgIXY4
         Ub2M5NO99HUopBvAbG9e/AMwoc8XyPoD3g4V5W98+3yDPwtvIQO3f+JJb8fLukfsLris
         R6cBowNiPFq7DoBx4qrsPkrWvMdLbTImz2nozsF4WZGHj8D2IF+t74vEoG2AcG+RXZVM
         WzAw==
X-Gm-Message-State: AOAM533+pG5MDYzqfdkPuNiY4UGmV0CwS01gUYI3w30lTJjBac+Lfzyw
        zsxWyM7mJKqEWhfHnD+Lgza1f96Hhho=
X-Google-Smtp-Source: ABdhPJz1k1RNu9dAXsmdsawTe7TyraBkMndQDppnCMV2qrWO1j7+QMn1X+iW+F38INV+PsKSU5IK3AvNUXA=
X-Received: by 2002:a05:6214:713:: with SMTP id b19mr20890435qvz.199.1592145938185;
 Sun, 14 Jun 2020 07:45:38 -0700 (PDT)
Date:   Sun, 14 Jun 2020 16:45:34 +0200
Message-Id: <20200614144534.237035-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] [RFC] security: allow using Clang's zero initialization for
 stack variables
From:   glider@google.com
To:     yamada.masahiro@socionext.com, keescook@chromium.org,
        jmorris@namei.org
Cc:     maze@google.com, ndesaulniers@google.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In addition to -ftrivial-auto-var-init=pattern (used by
CONFIG_INIT_STACK_ALL now) Clang also supports zero initialization for
locals enabled by -ftrivial-auto-var-init=zero.
The future of this flag is still being debated, see
https://bugs.llvm.org/show_bug.cgi?id=45497
Right now it is guarded by another flag,
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
which means it may not be supported by future Clang releases.
Another possible resolution is that -ftrivial-auto-var-init=zero will
persist (as certain users have already started depending on it), but the
name of the guard flag will change.

In the meantime, zero initialization has proven itself as a good
production mitigation measure against uninitialized locals. Unlike
pattern initialization, which has a higher chance of triggering existing
bugs, zero initialization provides safe defaults for strings, pointers,
indexes, and sizes. On the other hand, pattern initialization remains
safer for return values.
Performance-wise, the difference between pattern and zero initialization
is usually negligible, although the generated code for zero
initialization is more compact.

The proposed config, CONFIG_USE_CLANG_ZERO_INITIALIZATION, makes
CONFIG_INIT_STACK_ALL use zero initialization if the corresponding flags
are supported by Clang.

Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 Makefile                   | 15 ++++++++++++++-
 security/Kconfig.hardening | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fd31992bf918..2860bad7e39a 100644
--- a/Makefile
+++ b/Makefile
@@ -802,9 +802,22 @@ KBUILD_CFLAGS	+= -fomit-frame-pointer
 endif
 endif
 
-# Initialize all stack variables with a pattern, if desired.
+# Initialize all stack variables, if desired.
 ifdef CONFIG_INIT_STACK_ALL
+
+# Use pattern initialization by default.
+ifndef CONFIG_USE_CLANG_ZERO_INITIALIZATION
 KBUILD_CFLAGS	+= -ftrivial-auto-var-init=pattern
+else
+
+ifdef CONFIG_CC_HAS_AUTO_VAR_ZERO_INIT
+# Future support for zero initialization is still being debated, see
+# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
+# renamed or dropped.
+KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
+endif
+
+endif
 endif
 
 DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index af4c979b38ee..299d27c6d78c 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -22,6 +22,9 @@ menu "Memory initialization"
 config CC_HAS_AUTO_VAR_INIT
 	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
 
+config CC_HAS_AUTO_VAR_ZERO_INIT
+	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
+
 choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
@@ -100,6 +103,19 @@ choice
 
 endchoice
 
+config USE_CLANG_ZERO_INITIALIZATION
+	bool "Use Clang's zero initialization for local variables"
+	depends on CC_HAS_AUTO_VAR_ZERO_INIT
+	depends on INIT_STACK_ALL
+	help
+	  If set, uses zeros instead of 0xAA to initialize local variables in
+	  INIT_STACK_ALL. Zeroing the stack provides safer defaults for strings,
+	  pointers, indexes, and sizes. The downsides are less-safe defaults for
+	  return values, and exposing fewer bugs where the underlying code
+	  relies on zero initialization.
+	  The corresponding flag isn't officially supported by Clang and may
+	  sooner or later go away or get renamed.
+
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-- 
2.27.0.290.gba653c62da-goog

