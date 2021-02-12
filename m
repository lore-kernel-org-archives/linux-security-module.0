Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD26C433DB
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Feb 2021 05:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA74D64E6C
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Feb 2021 05:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhBLFPv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Feb 2021 00:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLFPq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Feb 2021 00:15:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D4C061756
        for <linux-security-module@vger.kernel.org>; Thu, 11 Feb 2021 21:15:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 6so8647611ybq.7
        for <linux-security-module@vger.kernel.org>; Thu, 11 Feb 2021 21:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=UsZfh0ugYXVBA8yeF7pE4YFwStzOHtAmek3RdORCX+E=;
        b=SzJL9vBy8lVTuUNig36qJ5I3eO9VZPL2gttToIRg/rfH0Rl+BdC92sD5+F5r7Z6XPS
         7Arqpz65uTK4op7fIZV5M2CrdBGfXqaaSosq+n10YCqivOICp0yUQP6hdB54n5fIw7pe
         1Hy+SVqmSBOeUvK4ugcpZHP+89/UvS+cxYhlmLMrNoANYkOwoaGuR7krjBoK7NZjq9zz
         x0LXWTU0Pq/Ri79FmStfQL4v28EPwr9qbwOD25x6W+CKPf7BwpB6AO8NceInXPHtwGQf
         lO/RywqfNIpjw86uTffqIHFIHPBUUsSTfvDx7CbnUSXaJ1drDsn1R+To1Mti4LY1JG6W
         rwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=UsZfh0ugYXVBA8yeF7pE4YFwStzOHtAmek3RdORCX+E=;
        b=MQMW3W8iYn1NkVL+dV5ajuF2UdXzC8uVJbcxa6ja9wDcxKUPAmh2OhwTlYGm/it3mR
         UZZg6AMls4W8Su2BzIOc6HFg4L4cTYHvxMZ/O8vsJ6xxdRoX2ntc2y+PH6TnoknKhtt5
         ag3ulhlkOnR758YxPZZG2gS47ZSFfc7wIMmkUatqBOtgT8LnfSfHk4isPGvHio70CIco
         37u3v2tZV2LMJb9uDGBQTUnM5Q1W3Oh3155gmaIC8OncAgh68JoFNHSCYL0yrk6809O6
         NsLrfDNn9rIRE9NFdF0XFGkh3luKLAfuHueVccQ0bEXT/e90Ews0t2+OLIInIfglvdg5
         L+ug==
X-Gm-Message-State: AOAM532/fQ073b1vrlufcv6E7Fh3AapQjkIiFpUuHI7go5+9mBeweVs/
        tnQuW/Q/F0HsA8QTYGmRY7fMcde6gVq6
X-Google-Smtp-Source: ABdhPJycIY3mywfzpize22XFsRLYY7NYl3ks6OFPoxSO3RoiL0EL5Ir2jRncglUNKqPUXzz6G9tAhg3k4Nay
Sender: "jiancai via sendgmr" <jiancai@jiancai.svl.corp.google.com>
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:9923:3694:46ec:d62])
 (user=jiancai job=sendgmr) by 2002:a25:ce51:: with SMTP id
 x78mr1842451ybe.198.1613106904807; Thu, 11 Feb 2021 21:15:04 -0800 (PST)
Date:   Thu, 11 Feb 2021 21:14:58 -0800
Message-Id: <20210212051500.943179-1-jiancai@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] ARM: Implement Clang's SLS mitigation
From:   Jian Cai <jiancai@google.com>
Cc:     ndesaulniers@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        "=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch adds a config CONFIG_HARDEN_SLS_ALL that can be used to turn
on -mharden-sls=all, which mitigates the straight-line speculation
vulnerability, or more commonly known as Spectre, Meldown.

Notice -mharden-sls= has other options as below, and this config turns
on the strongest option.

all: enable all mitigations against Straight Line Speculation that are implemented.
none: disable all mitigations against Straight Line Speculation.
retbr: enable the mitigation against Straight Line Speculation for RET and BR instructions.
blr: enable the mitigation against Straight Line Speculation for BLR instructions.

Link: https://reviews.llvm.org/D93221
Link: https://reviews.llvm.org/D81404
Link: https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/downloads/straight-line-speculation
Link: https://crbug.com/1171521

Suggested-by: Manoj Gupta <manojgupta@google.com>
Signed-off-by: Jian Cai <jiancai@google.com>
---
 arch/arm/Makefile          |  4 ++++
 arch/arm64/Makefile        |  5 +++++
 security/Kconfig.hardening | 11 +++++++++++
 3 files changed, 20 insertions(+)

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
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 90309208bb28..8fd0ccd87eca 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -34,6 +34,11 @@ $(warning LSE atomics not supported by binutils)
   endif
 endif
 
+ifeq ($(CONFIG_HARDEN_SLS_ALL), y)
+KBUILD_CFLAGS  += -mharden-sls=all
+endif
+
+
 cc_has_k_constraint := $(call try-run,echo				\
 	'int main(void) {						\
 		asm volatile("and w0, w0, %w0" :: "K" (4294967295));	\
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 269967c4fc1b..d83c406c81a3 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -121,6 +121,17 @@ choice
 
 endchoice
 
+
+config CC_HAS_HARDEN_SLS_ALL
+	def_bool $(cc-option,-mharden-sls=all)
+
+	config HARDEN_SLS_ALL
+               bool "enable SLS vulnerability hardening"
+               depends on CC_HAS_HARDEN_SLS_ALL
+               help
+                 Enables straight-line speculation vulnerability hardening
+		 at highest level.
+
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-- 
2.30.0.478.g8a0d178c01-goog

