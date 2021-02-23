Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A75C433DB
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Feb 2021 02:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A3464E41
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Feb 2021 02:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBWCga (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhBWCg1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 21:36:27 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA4FC06178A
        for <linux-security-module@vger.kernel.org>; Mon, 22 Feb 2021 18:35:46 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 185so5688226pfx.5
        for <linux-security-module@vger.kernel.org>; Mon, 22 Feb 2021 18:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=PGrLnEq5sje+DbyVyjyk9DtPrIKTxkj/GFVaSNwb+20=;
        b=lQPJcLW5Zj/rVq/5KMZi6Bk5Gxp9bi/jqYNJj/hkmFM6gzte6FNZy8pUhQPuF48DW5
         rgdLyFQsyQ6U4RJUQqukWwxkSjocc0fLx+yt1DM01Qk39F7C/1AXZh+zjBdJxQ/3G0By
         9Q1STBNlBg5Q7c+WlQM3qRq5jdlJ/xEHfGwh+b+RySqJGyYgto60gGTcmqgVTnskcTia
         voGzzLmvFVyrWpAvMnajOE6rcF29MHLzcWao+b+LIqDC6xm2dNFZctXjqUO3V/BvFPkl
         xIDw2+GeuCSLwm+cSUCmzXDs9pW4C7jufUXw/nbxuMFcESLv2rHy/6q1Bho4udqCsDPz
         0t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=PGrLnEq5sje+DbyVyjyk9DtPrIKTxkj/GFVaSNwb+20=;
        b=qjKN4jMEFXOH50yKN2sMt5FQ7TktuxMHW+GVgkKBfsK7nydjm3qMEpThZ0y6PamaWJ
         jbqsKZVfH78aHgezc3YJtxmV3XIQ1HZDJmgNgcyQm8Kh1lhinIlVazNBtIhPxbggxAKp
         o/jh2BBUnZMjtxsW/aBb9FcB6PzQ5nJbfzr3teI0iaRpcAiyxlhN85n1XTEsx8GOdkmv
         U+ZV3HSXkvAprU1cd9xfTSiJsiNGyz8HVfubM4FLqYAxei2oeCPaCBu8K86cMDamfqj7
         y+sHDa9W58YesxLLLg4DpvLfIvSYvtahpuwn2HBagUv7/hOEOLpIOxmG3s3R3Hbmy247
         TupA==
X-Gm-Message-State: AOAM531Eb5WrFmtGTStG56rOMy1Lu45D7TRoeEVKmM71LMkAoQZ97SSN
        xyGTXh58i5aui95vFcnPwyCT93kEnEhy
X-Google-Smtp-Source: ABdhPJwpIgoHP79+CAP1cZb8niAgyx2loeUCwl0+OoIAPkr358YzHC0nbYkhT6jM2oeR9Nm6NApKoYyBPvq+
Sender: "jiancai via sendgmr" <jiancai@jiancai.svl.corp.google.com>
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:7985:60cc:661a:9692])
 (user=jiancai job=sendgmr) by 2002:a17:90a:8e83:: with SMTP id
 f3mr27877234pjo.70.1614047746241; Mon, 22 Feb 2021 18:35:46 -0800 (PST)
Date:   Mon, 22 Feb 2021 18:35:28 -0800
In-Reply-To: <20210223023125.2265845-1-jiancai@google.com>
Message-Id: <20210223023542.2287529-1-jiancai@google.com>
Mime-Version: 1.0
References: <20210223023125.2265845-1-jiancai@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v5] ARM: Implement SLS mitigation
From:   Jian Cai <jiancai@google.com>
Cc:     ndesaulniers@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch adds CONFIG_HARDEN_SLS_ALL that can be used to turn on
-mharden-sls=all, which mitigates the straight-line speculation
vulnerability, speculative execution of the instruction following some
unconditional jumps. Notice -mharden-sls= has other options as below,
and this config turns on the strongest option.

all: enable all mitigations against Straight Line Speculation that are implemented.
none: disable all mitigations against Straight Line Speculation.
retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
blr: enable the mitigation against Straight Line Speculation for BLR instructions.

Links:
https://reviews.llvm.org/D93221
https://reviews.llvm.org/D81404
https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation
https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/frequently-asked-questions#SLS2

Suggested-by: Manoj Gupta <manojgupta@google.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: David Laight <David.Laight@aculab.com>
Suggested-by: Will Deacon <will@kernel.org>
Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jian Cai <jiancai@google.com>
---
Changes v4->v5:
  Removed "default n" and made the description target indepdent in
  Kconfig.hardening. Please ignore my last email, it did not include the
  changes.

 arch/arm/Makefile                  | 4 ++++
 arch/arm/include/asm/vmlinux.lds.h | 4 ++++
 arch/arm/kernel/vmlinux.lds.S      | 1 +
 arch/arm64/Makefile                | 4 ++++
 arch/arm64/kernel/vmlinux.lds.S    | 5 +++++
 security/Kconfig.hardening         | 8 ++++++++
 6 files changed, 26 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4aaec9599e8a..11d89ef32da9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -48,6 +48,10 @@ CHECKFLAGS	+= -D__ARMEL__
 KBUILD_LDFLAGS	+= -EL
 endif
 
+ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
+KBUILD_CFLAGS  += -mharden-sls=all
+endif
+
 #
 # The Scalar Replacement of Aggregates (SRA) optimization pass in GCC 4.9 and
 # later may result in code being generated that handles signed short and signed
diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 4a91428c324d..c7f9717511ca 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -145,3 +145,7 @@
 		__edtcm_data = .;					\
 	}								\
 	. = __dtcm_start + SIZEOF(.data_dtcm);
+
+#define SLS_TEXT							\
+		ALIGN_FUNCTION();					\
+		*(.text.__llvm_slsblr_thunk_*)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index f7f4620d59c3..e71f2bc97bae 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -63,6 +63,7 @@ SECTIONS
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 		ARM_TEXT
+		SLS_TEXT
 	}
 
 #ifdef CONFIG_DEBUG_ALIGN_RODATA
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 90309208bb28..ca7299b356a9 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -34,6 +34,10 @@ $(warning LSE atomics not supported by binutils)
   endif
 endif
 
+ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
+KBUILD_CFLAGS  += -mharden-sls=all
+endif
+
 cc_has_k_constraint := $(call try-run,echo				\
 	'int main(void) {						\
 		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4c0b0c89ad59..f8912e42ffcd 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -93,6 +93,10 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#define SLS_TEXT					\
+	ALIGN_FUNCTION();				\
+	*(.text.__llvm_slsblr_thunk_*)
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from _stext to _edata, must be a round multiple of the PE/COFF
@@ -144,6 +148,7 @@ SECTIONS
 			HIBERNATE_TEXT
 			TRAMP_TEXT
 			*(.fixup)
+			SLS_TEXT
 			*(.gnu.warning)
 		. = ALIGN(16);
 		*(.got)			/* Global offset table		*/
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 269967c4fc1b..db76ad732c14 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -121,6 +121,14 @@ choice
 
 endchoice
 
+config HARDEN_SLS_ALL
+	bool "enable SLS vulnerability hardening"
+	depends on $(cc-option,-mharden-sls=all)
+	help
+	  Enables straight-line speculation vulnerability hardening. This inserts
+	  speculation barrier instruction sequences after certain unconditional jumps
+	  to prevent speculative execution past those barriers.
+
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-- 
2.30.0.617.g56c4b15f3c-goog

