Return-Path: <SRS0=KU/V=SK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD74C10F13
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8118D20880
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOJKpGb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfDHRE3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:04:29 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:44191 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfDHRE3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Apr 2019 13:04:29 -0400
Received: by mail-yw1-f73.google.com with SMTP id l203so10970632ywb.11
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2019 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qe2VE7lyZVupjMwRpQ+dHdBGYyLN/Bj/tqxvBGnY3Yw=;
        b=HOJKpGb/cbGJXi9w+tc4PVhynYzKaHAHM8Aeh+hoEteVLQpORr//ykK9jWUCFRr/0e
         Ueb5XWofRFOLcKmixicUTYM+DVFolNrzQG46BVUhDCYyUbS/lRMCNqvGaEF9ybBo0lRF
         55uQFJD7KdtjNmhrne3sR9tjA3eTIhYUar+UXP+ubs2l8k7Fnk9NFbaDsDYvvMTMbRed
         oL73zSOUKgzMwJqFp2heeAVPpJtgoxi6Cq9qyl2U12TNLI5MjB/MN2oq1PF57b6+wlO4
         MFaxQu7CAPQuHrc3tHrUVS+eUbhFsGpArU41lbOMoFBeNXeJyvSqvi09u3bUGOE3ECCc
         0YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qe2VE7lyZVupjMwRpQ+dHdBGYyLN/Bj/tqxvBGnY3Yw=;
        b=mex36Hy6Sakow3VnnCQAcHr4VVHT6QSifTgexrAHSlpBiWmoBY61QBD0f6D7m9QAs2
         v0fexmiLgiwhJPcNNUSwz0JTtKIOM9HdrvGq9bMwlKp6TZFAdn55kU7/SrQSdNTqnEj7
         GHowKYQu8P3bsfFodpFg7P9xkQMXiJHviYcmS+Y8d0EJl9347lljhKj7SM89T8iBn6IY
         wVCGuG7mpIgrU3RTYL3e6HioRZ671az9we5p+dqgf1jWDlvoAXO8gE3cEDzhsw41qq3O
         zhaadPa4wIsRK4O9gHAdA0zkUWwJrrEOVHSwV6W1mVmIPkUet2zmovpFCfDQebnRDIFL
         wb/w==
X-Gm-Message-State: APjAAAUL10uVleKTRfuwPH3NqyelGNYVVohncLvon6XrwcFEqSj/1AEv
        pOHQve1OZiQYjAOF1c4eKBU5To6X6sM=
X-Google-Smtp-Source: APXvYqx345bwZUW1qENJgcBZ9oGUG7SYOQw1bKVYzKDoYZOkLS4SVmnezDgvGpTFShw+2uQ5NRuaTqIxQBY=
X-Received: by 2002:a81:3ac7:: with SMTP id h190mr2106812ywa.5.1554743068175;
 Mon, 08 Apr 2019 10:04:28 -0700 (PDT)
Date:   Mon,  8 Apr 2019 19:04:17 +0200
In-Reply-To: <20190408170418.148554-1-glider@google.com>
Message-Id: <20190408170418.148554-2-glider@google.com>
Mime-Version: 1.0
References: <20190408170418.148554-1-glider@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 1/2] initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
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
Cc: linux-security-module@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
---
 v2:
  - addressed Kees Cook's comments: added GCC support
 v3: addressed Masahiro Yamada's comments:
  - dropped per-file opt-out mechanism
  - fixed GCC_PLUGINS dependencies
---
 Makefile                 |  3 ++-
 scripts/Makefile.initmem | 10 ++++++++++
 security/Kconfig         |  1 +
 security/Kconfig.initmem | 29 +++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 scripts/Makefile.initmem
 create mode 100644 security/Kconfig.initmem

diff --git a/Makefile b/Makefile
index f070e0d65186..028ca37878fd 100644
--- a/Makefile
+++ b/Makefile
@@ -448,7 +448,7 @@ export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
-export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
+export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN CFLAGS_INITMEM
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
@@ -840,6 +840,7 @@ KBUILD_ARFLAGS := $(call ar-option,D)
 include scripts/Makefile.kasan
 include scripts/Makefile.extrawarn
 include scripts/Makefile.ubsan
+include scripts/Makefile.initmem
 
 # Add any arch overrides and user supplied CPPFLAGS, AFLAGS and CFLAGS as the
 # last assignments
diff --git a/scripts/Makefile.initmem b/scripts/Makefile.initmem
new file mode 100644
index 000000000000..a6253d78fe35
--- /dev/null
+++ b/scripts/Makefile.initmem
@@ -0,0 +1,10 @@
+ifdef CONFIG_INIT_ALL_STACK
+
+# Clang's -ftrivial-auto-var-init=pattern flag initializes the
+# uninitialized parts of local variables (including fields and padding)
+# with a fixed pattern (0xAA in most cases).
+ifdef CONFIG_CC_HAS_AUTO_VAR_INIT
+  CFLAGS_INITMEM := -ftrivial-auto-var-init=pattern
+endif
+
+endif
diff --git a/security/Kconfig b/security/Kconfig
index e4fe2f3c2c65..cc12a39424dd 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -230,6 +230,7 @@ config STATIC_USERMODEHELPER_PATH
 	  If you wish for all usermode helper programs to be disabled,
 	  specify an empty string here (i.e. "").
 
+source "security/Kconfig.initmem"
 source "security/selinux/Kconfig"
 source "security/smack/Kconfig"
 source "security/tomoyo/Kconfig"
diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
new file mode 100644
index 000000000000..5e49a55382ad
--- /dev/null
+++ b/security/Kconfig.initmem
@@ -0,0 +1,29 @@
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
+	depends on INIT_ALL_MEMORY
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

