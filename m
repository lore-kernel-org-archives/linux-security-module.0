Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFAEC10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 13:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B10420830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 13:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlD3R7xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfDJNSX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:18:23 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:49559 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfDJNSW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 09:18:22 -0400
Received: by mail-ot1-f74.google.com with SMTP id s22so999263otk.16
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=92BVS4bOOFYP/dev0+TE/aXOaSZOqfDor9qoSr0AfGY=;
        b=KlD3R7xqSemcWSTra8s+1FVKrLwUdua/UkuTLb1R8auPLhTxEjHOlmxR4AJFAvHib7
         /0agFv6GFB2mtXF46aij3e8o+qr1V41ReyzjqDCSa+pzrGuitIPPnb9lF8icWtlB42dl
         Z5GAf6FUGclv/v7vEunjDhj1MuTFePNte/flucwqDbmmyX8TSYYTeiiwC8VKEu6wI5SL
         1aZ90PjWyPp31lGKQhJpZcLBf4OcCL6UFTck5qVDJhs1HMazLi1qefmV/Zp/Uv4d3GI6
         CiiFvEL1YxghdlNyDgP6Lk6zCkZYkkUXIGYlO9fRsmWa0ZZ2pmPtDBbQXDTsX0KNlm1F
         +H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=92BVS4bOOFYP/dev0+TE/aXOaSZOqfDor9qoSr0AfGY=;
        b=rIHA+7OBAQwNOv/rej5992pIZ83/BgyKI/Td/9x+9h6fYYR/OaaxKH4YZdxTSWfAAO
         za+FkK1MzvnCOlZo140hHMDjX4VIIDdchxz+WYE2A7534Kp+85RBz7r/ycFsddtl7RwK
         k5G0UmA0df7HsIkCIrk1htDD6vC9BM8yQINa81zyzYw7qU3jiMHJCPolxXS41rmWpYQH
         SdbiUMZGKTa3HxcVV7oJ5IpBWvPdoQVkkvbDlskpf8Qe0bzEoITFbbTnvIGY/bYT0c6o
         vi5o7OzEt/4j5vWpfK//5qhVRYWxbfoXSezCssfwe8aOsSGoCdb1nyii21N2MPsGF/3M
         VKWg==
X-Gm-Message-State: APjAAAUNcl5b/doSWs5jwtMadnOxge5zeou+fG3vOfDKgJvlTZhtOIU0
        ypgEqi2nhs3zueV7kvNV0SZDSp6ZJOs=
X-Google-Smtp-Source: APXvYqwbHimlBzwRHIj8V77isV8vldO++KJUl9VOK5KppM9XkBC/pYiCrpwNuQX7vKzJTow1zfpoZmxDil8=
X-Received: by 2002:a05:6830:1c6:: with SMTP id r6mr3515701ota.67.1554902301749;
 Wed, 10 Apr 2019 06:18:21 -0700 (PDT)
Date:   Wed, 10 Apr 2019 15:17:24 +0200
In-Reply-To: <20190410131726.250295-1-glider@google.com>
Message-Id: <20190410131726.250295-2-glider@google.com>
Mime-Version: 1.0
References: <20190410131726.250295-1-glider@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v4 1/3] initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
From:   Alexander Potapenko <glider@google.com>
To:     yamada.masahiro@socionext.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
        kcc@google.com, dvyukov@google.com, keescook@chromium.org,
        sspatil@android.com, labbott@redhat.com,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

CONFIG_INIT_ALL_MEMORY is going to be an umbrella config for options
that force heap and stack initialization.
The rationale behind doing so is to reduce the severity of bugs caused
by using uninitialized memory.

CONFIG_INIT_ALL_STACK turns on stack initialization based on
-ftrivial-auto-var-init in Clang builds and on
-fplugin-arg-structleak_plugin-byref-all in GCC builds.

-ftrivial-auto-var-init is a Clang flag that provides trivial
initializers for uninitialized local variables, variable fields and
padding.

It has three possible values:
  pattern - uninitialized locals are filled with a fixed pattern
    (mostly 0xAA on 64-bit platforms, see https://reviews.llvm.org/D54604
    for more details) likely to cause crashes when uninitialized value is
    used;
  zero (it's still debated whether this flag makes it to the official
    Clang release) - uninitialized locals are filled with zeroes;
  uninitialized (default) - uninitialized locals are left intact.

The proposed config builds the kernel with
-ftrivial-auto-var-init=pattern.

Developers have the possibility to opt-out of this feature on a
per-variable basis by using __attribute__((uninitialized)).

For GCC builds, CONFIG_INIT_ALL_STACK is simply wired up to
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL. No opt-out is possible at the
moment.

Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sandeep Patil <sspatil@android.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-security-module@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
---
 v2:
  - addressed Kees Cook's comments: added GCC support
 v3: addressed Masahiro Yamada's comments:
  - dropped per-file opt-out mechanism
  - fixed GCC_PLUGINS dependencies
 v4:
  - addressed Randy Dunlap's comments: remove redundant "depends on"
  - addressed Masahiro Yamada's comments: drop Makefile.initmem
---
 Makefile                 | 10 ++++++++++
 security/Kconfig         |  1 +
 security/Kconfig.initmem | 28 ++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 security/Kconfig.initmem

diff --git a/Makefile b/Makefile
index 15c8251d4d5e..02f4b9df0102 100644
--- a/Makefile
+++ b/Makefile
@@ -727,6 +727,16 @@ KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # See modpost pattern 2
 KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
 KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
+
+ifdef CONFIG_INIT_ALL_STACK
+# Clang's -ftrivial-auto-var-init=pattern flag initializes the
+# uninitialized parts of local variables (including fields and padding)
+# with a fixed pattern (0xAA in most cases).
+ifdef CONFIG_CC_HAS_AUTO_VAR_INIT
+KBUILD_CFLAGS += -ftrivial-auto-var-init=pattern
+endif
+endif
+
 else
 
 # These warnings generated too much noise in a regular build.
diff --git a/security/Kconfig b/security/Kconfig
index 353cfef71d4e..4d27437c2eb8 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -229,6 +229,7 @@ config STATIC_USERMODEHELPER_PATH
 	  If you wish for all usermode helper programs to be disabled,
 	  specify an empty string here (i.e. "").
 
+source "security/Kconfig.initmem"
 source "security/selinux/Kconfig"
 source "security/smack/Kconfig"
 source "security/tomoyo/Kconfig"
diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
new file mode 100644
index 000000000000..cdad1e185b10
--- /dev/null
+++ b/security/Kconfig.initmem
@@ -0,0 +1,28 @@
+menu "Initialize all memory"
+
+config CC_HAS_AUTO_VAR_INIT
+	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
+
+config INIT_ALL_MEMORY
+	bool "Initialize all memory"
+	default n
+	help
+	  Enforce memory initialization to mitigate infoleaks and make
+	  the control-flow bugs depending on uninitialized values more
+	  deterministic.
+
+if INIT_ALL_MEMORY
+
+config INIT_ALL_STACK
+	bool "Initialize all stack"
+	depends on CC_HAS_AUTO_VAR_INIT || (HAVE_GCC_PLUGINS && PLUGIN_HOSTCC != "")
+	select GCC_PLUGINS if !CC_HAS_AUTO_VAR_INIT
+	select GCC_PLUGIN_STRUCTLEAK if !CC_HAS_AUTO_VAR_INIT
+	select GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if !CC_HAS_AUTO_VAR_INIT
+	default y
+	help
+	  Initialize uninitialized stack data with a fixed pattern
+	  (0x00 in GCC, 0xAA in Clang).
+
+endif # INIT_ALL_MEMORY
+endmenu
-- 
2.21.0.392.gf8f6787159e-goog

