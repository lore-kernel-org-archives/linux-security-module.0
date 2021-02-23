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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA99DC433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Feb 2021 02:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D65D64E41
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Feb 2021 02:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBWCc0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBWCcZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 21:32:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D5C061786
        for <linux-security-module@vger.kernel.org>; Mon, 22 Feb 2021 18:31:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l3so18970851ybf.17
        for <linux-security-module@vger.kernel.org>; Mon, 22 Feb 2021 18:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=Q1j93qwuy/J16VYdZY9OwcszBQob8ihsmTijrh0rYD4=;
        b=DVElnxie0yaEXCS7ca25i9lmUVZhtZ4x2QRALHD8pmEq45Y8JrUrAOVroI/Kheq9hK
         v8AMU7lNenLwIeE7TBqbCZhmiY9h8BKLC1nnjDpyJgj4pcFhPl4zvVifRdtpPLjlylI/
         ezLYkKqbiM8/ghryZuBss1/wmACnj6lo28XKrKLQqPROxffxNnVAOQwVCyl8dgSFV3+u
         7RxCarhish8ysaUXMUEP+OqepKRIwxzTGv4KgJI7XA3EwpaO3u9spReDNcoKok4c1T2r
         VRvSzg0JbQL4EU1GZKXmcmy+BackzruQTuebrlsMoWpZvcZPGQWQO283uxAk/2yfW1hx
         8c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=Q1j93qwuy/J16VYdZY9OwcszBQob8ihsmTijrh0rYD4=;
        b=DPsoUbVA2J2AdSQeptkHB6aNXuNlvgn8LgMTicHqrGeYvCOO9HpM/qo9ESaYxR9opS
         UIfZgxAKistQtkc9M/aA/of05U6WU10jcTfsKKIdhgFH8ic9rYdm78TKjlhmhVM/ZeW1
         tVSP2EKmUt9Vo7oq66ubGMd0YSIQpqBS/1cosLrKyasIMEiyDKIvor+8hMpYOkowJSME
         VzF0zSJ87yslKHDv+Vas0fgzbfiY/f55XBOIi3gX4OdgViL06EEvrETJl2L/naFuSJ1W
         aV38y9VjF7KY1WNo/A2jaZeAfRwI5ydRm/GoXiN/DUorKWhdqpVSUeegivklE2+uVPhJ
         OE8g==
X-Gm-Message-State: AOAM533o8P1KSHPw51//gFo2P8closMEVY384juP4Dz487lRW0hhltLm
        qVkWt2xvgsx12Argzk7MXWweX4k0Q6tI
X-Google-Smtp-Source: ABdhPJzdESPMYVkuKRp46z6k/1HyWow5PI6VIDHD9DSx2dJLwqSBnc6LDFRg9huHcQPGORE8+ydqlstwhrZh
Sender: "jiancai via sendgmr" <jiancai@jiancai.svl.corp.google.com>
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:7985:60cc:661a:9692])
 (user=jiancai job=sendgmr) by 2002:a25:da0e:: with SMTP id
 n14mr37389154ybf.356.1614047504192; Mon, 22 Feb 2021 18:31:44 -0800 (PST)
Date:   Mon, 22 Feb 2021 18:31:07 -0800
In-Reply-To: <20210219230841.875875-1-jiancai@google.com>
Message-Id: <20210223023125.2265845-1-jiancai@google.com>
Mime-Version: 1.0
References: <20210219230841.875875-1-jiancai@google.com>
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
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Marc Zyngier <maz@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
  Kconfig.hardening.


 arch/arm/Makefile                  |  4 ++++
 arch/arm/include/asm/vmlinux.lds.h |  4 ++++
 arch/arm/kernel/vmlinux.lds.S      |  1 +
 arch/arm64/Makefile                |  4 ++++
 arch/arm64/kernel/vmlinux.lds.S    |  5 +++++
 security/Kconfig.hardening         | 10 ++++++++++
 6 files changed, 28 insertions(+)

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
index 269967c4fc1b..146b75a79d9e 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -121,6 +121,16 @@ choice
 
 endchoice
 
+config HARDEN_SLS_ALL
+	bool "enable SLS vulnerability hardening"
+	default n
+	depends on $(cc-option,-mharden-sls=all)
+	help
+	  Enables straight-line speculation vulnerability hardening on ARM and ARM64
+	  architectures. It inserts speculation barrier sequences (SB or DSB+ISB
+	  depending on the target architecture) after RET and BR, and replacing
+	  BLR with BL+BR sequence.
+
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-- 
2.30.0.617.g56c4b15f3c-goog

