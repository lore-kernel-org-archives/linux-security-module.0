Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED2C433DB
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 00:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E403E64FD3
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 00:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCEAxc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCEAxb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 19:53:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A551BC061574
        for <linux-security-module@vger.kernel.org>; Thu,  4 Mar 2021 16:53:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l3so582876ybf.17
        for <linux-security-module@vger.kernel.org>; Thu, 04 Mar 2021 16:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=s0a03NeiimEs02gcpf/77HytMIb3TLvi/V8gs4T53vU=;
        b=lUvKcrArmDzU4hhIn19yXnWghv4IeaePzhyeh1iVUFnn/5/6O2BI7BsDD1MHKJyRs2
         RAyPCJER4zhqlgnJg79GENfvVkc3l7EIrWxnr8ZLsAopDB1IaGqDAtZH10NJTQdm3nrW
         2gleXvBpVAgSlTZpvZGXP7IGzILkvt8qlYMV56Vqooc0W03LZrnCDWlJq/gw1aDBT6NC
         8fE2L8E3/ExcgFRNXzNgiMsd8IN7+eFhZ5OtXFE2nljCmJsSPSbmyspdd7xUb81P7RFt
         AXVjG6GTxA71nZEbGSKt0V9FTkLssNeeHm9mcd9LZsE/8yUEe5AUPCwgSTSSxZHsKhX+
         VQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=s0a03NeiimEs02gcpf/77HytMIb3TLvi/V8gs4T53vU=;
        b=DkA5PgwJMfZdOOeJ+F6/FqaCBruk7KrAq3Gxw/orUI2+a0wi4fps0Gu2lV6Jo69CnV
         Nw7Y6/4r+vYPUHSw1v0isOg9fIL/DKMKiBjxS2NZtuQNpI+8sM/QDoBqKPz4yohOHgRr
         2sk7XYvKuxxQUubUjf/44Jt+OfbbMyx2LnVeXahdyoHZxwKLMe1XE6eZK2ui9l1jyTwO
         zxKbRqkAhuKokdfi7y7tmK0j2VegNGqvYQMv4clUbFH56EVkCaDmALJJBN+d25FV1JAk
         i476o/Z2ifZ5p7aFI2uJ0aCBZueeOlEriwW3naO9WjSh2iETgovFw5RyzIWvwOXQTE24
         dAsQ==
X-Gm-Message-State: AOAM530cslyca/pSP25wFcUBzKooGAtmi6KDwra23FCGF/j0xwiBRIwJ
        0YXn/m/4hjw8J0YZ1e5RgEMfQ4KPTm9D
X-Google-Smtp-Source: ABdhPJzNifQecS1ELfAGb8xMfod28CcY5fmiWPIkutWHFymb9agAnhUArzpzU6/YksGQ0r5lKWYUKmIrz7kj
Sender: "jiancai via sendgmr" <jiancai@jiancai.svl.corp.google.com>
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:1164:dbaf:a707:265d])
 (user=jiancai job=sendgmr) by 2002:a25:d8d1:: with SMTP id
 p200mr10331970ybg.14.1614905610829; Thu, 04 Mar 2021 16:53:30 -0800 (PST)
Date:   Thu,  4 Mar 2021 16:53:18 -0800
In-Reply-To: <20210223023542.2287529-1-jiancai@google.com>
Message-Id: <20210305005327.405365-1-jiancai@google.com>
Mime-Version: 1.0
References: <20210223023542.2287529-1-jiancai@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v6] ARM: Implement SLS mitigation
From:   Jian Cai <jiancai@google.com>
Cc:     ndesaulniers@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" 
        <u.kleine-koenig@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Joey Gouly <joey.gouly@arm.com>,
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
Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jian Cai <jiancai@google.com>
---

Changes v1 -> v2:
 Update the description and patch based on Nathan and David's comments.

Changes v2 -> v3:
  Modify linker scripts as Nick suggested to address boot failure
  (verified with qemu). Added more details in Kconfig.hardening
  description. Disable the config by default.

Changes v3 -> v4:
  Address Nathan's comment and replace def_bool with depends on in
  HARDEN_SLS_ALL.

Changes v4 -> v5:
  Removed "default n" and made the description target indepdent in
  Kconfig.hardening.

Changes v5 -> v6:
  Add select HARDEN_SLS_ALL under config HARDEN_BRANCH_PREDICTOR. This
  turns on HARDEN_SLS_ALL by default where applicable.


 arch/arm/Makefile                  | 4 ++++
 arch/arm/include/asm/vmlinux.lds.h | 4 ++++
 arch/arm/kernel/vmlinux.lds.S      | 1 +
 arch/arm/mm/Kconfig                | 1 +
 arch/arm64/Makefile                | 4 ++++
 arch/arm64/kernel/vmlinux.lds.S    | 5 +++++
 security/Kconfig.hardening         | 8 ++++++++
 7 files changed, 27 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index dad5502ecc28..54f9b5ff9682 100644
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
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 35f43d0aa056..bdb63e7b1bec 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -837,6 +837,7 @@ config HARDEN_BRANCH_PREDICTOR
 	bool "Harden the branch predictor against aliasing attacks" if EXPERT
 	depends on CPU_SPECTRE
 	default y
+	select HARDEN_SLS_ALL
 	help
 	   Speculation attacks against some high-performance processors rely
 	   on being able to manipulate the branch predictor for a victim
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5b84aec31ed3..e233bfbdb1c2 100644
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
index 7eea7888bb02..d5c892605862 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -103,6 +103,10 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#define SLS_TEXT					\
+	ALIGN_FUNCTION();				\
+	*(.text.__llvm_slsblr_thunk_*)
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from _stext to _edata, must be a round multiple of the PE/COFF
@@ -154,6 +158,7 @@ SECTIONS
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
2.30.1.766.gb4fecdf3b7-goog

