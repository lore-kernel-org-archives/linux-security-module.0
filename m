Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E9BC10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF84F2173C
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KTMfuuhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDKSBf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:01:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40092 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfDKSB3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 14:01:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so3874473pgl.7
        for <linux-security-module@vger.kernel.org>; Thu, 11 Apr 2019 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5UVcalT/69dnaWJbEUHGU/qZgqR3xSJfEBAdMd0KbXI=;
        b=KTMfuuhGOAqwrTLGNljYi6CKR+25P7Qtg0HJTwZl7qsUCJ7pVzOJAMuZilvmtF9cYV
         PRZf1Nh2XYnUoC1vE1eByRDwxWPvOH4MOC1bBwuKqkUsdrM9zqXpwAhR0iplvRAFngZO
         97eydYlVTVEXHobFBzWWFIR0rBhW4vy3vY9H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5UVcalT/69dnaWJbEUHGU/qZgqR3xSJfEBAdMd0KbXI=;
        b=eq+gHdObealtNBYW7d+srKh50gVyioCt4dvyA16OTFmnOxmBBdSTg2qYsqd0D3tDsB
         ijh4iByiuuIYcKYFy5JCV9kc62kQyFxwh/n/riTRlTV1y4YmOyNyPQom6NMGRvM/XZ4m
         rkMRaH//JXZln7RaAyGSX2CkKwrrI3AI/lGh9M2Y+mgwhMxqlUquIGv0+rufx07SJjx5
         7fBUMsWkq8Xr71lw6dQMKZYUIPLvvFav8xooyB4KoHzOsTmzueeOxLuV//Cuon0zWgl/
         YOHI9se1I64ywj1uM0tcCauyl0kmejSkoKiEpq3Rbtu9rbVM9GFEj25v6PWFT2Vn5I7B
         LTkg==
X-Gm-Message-State: APjAAAX8F6shMI1u76FiAnM9hHXU0crxTj/Og0XS5D1/kAt63Rd//TCr
        hsOYnGSivrBO4VKB3tbqM41gKw==
X-Google-Smtp-Source: APXvYqzZVkmGbK/kgGkS3PLIBPjakP/68xlKHi3tGLgH2Y/iUp33a3mnIFCATqNKZ2EmHv7KCzngQg==
X-Received: by 2002:a63:2b4c:: with SMTP id r73mr49317982pgr.181.1555005688308;
        Thu, 11 Apr 2019 11:01:28 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p189sm58691148pfg.184.2019.04.11.11.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 11:01:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        Alexander Popov <alex.popov@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        kernel-hardening@lists.openwall.com,
        linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] security: Move stackleak config to Kconfig.hardening
Date:   Thu, 11 Apr 2019 11:01:16 -0700
Message-Id: <20190411180117.27704-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411180117.27704-1-keescook@chromium.org>
References: <20190411180117.27704-1-keescook@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This moves the stackleak plugin options to Kconfig.hardening's memory
initialization menu.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/Kconfig | 51 ---------------------------------
 security/Kconfig.hardening  | 57 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 84d471dea2b7..e4cb58d5a73f 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -109,57 +109,6 @@ config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
 	  in structures.  This reduces the performance hit of RANDSTRUCT
 	  at the cost of weakened randomization.
 
-config GCC_PLUGIN_STACKLEAK
-	bool "Erase the kernel stack before returning from syscalls"
-	depends on GCC_PLUGINS
-	depends on HAVE_ARCH_STACKLEAK
-	help
-	  This option makes the kernel erase the kernel stack before
-	  returning from system calls. That reduces the information which
-	  kernel stack leak bugs can reveal and blocks some uninitialized
-	  stack variable attacks.
-
-	  The tradeoff is the performance impact: on a single CPU system kernel
-	  compilation sees a 1% slowdown, other systems and workloads may vary
-	  and you are advised to test this feature on your expected workload
-	  before deploying it.
-
-	  This plugin was ported from grsecurity/PaX. More information at:
-	   * https://grsecurity.net/
-	   * https://pax.grsecurity.net/
-
-config STACKLEAK_TRACK_MIN_SIZE
-	int "Minimum stack frame size of functions tracked by STACKLEAK"
-	default 100
-	range 0 4096
-	depends on GCC_PLUGIN_STACKLEAK
-	help
-	  The STACKLEAK gcc plugin instruments the kernel code for tracking
-	  the lowest border of the kernel stack (and for some other purposes).
-	  It inserts the stackleak_track_stack() call for the functions with
-	  a stack frame size greater than or equal to this parameter.
-	  If unsure, leave the default value 100.
-
-config STACKLEAK_METRICS
-	bool "Show STACKLEAK metrics in the /proc file system"
-	depends on GCC_PLUGIN_STACKLEAK
-	depends on PROC_FS
-	help
-	  If this is set, STACKLEAK metrics for every task are available in
-	  the /proc file system. In particular, /proc/<pid>/stack_depth
-	  shows the maximum kernel stack consumption for the current and
-	  previous syscalls. Although this information is not precise, it
-	  can be useful for estimating the STACKLEAK performance impact for
-	  your workloads.
-
-config STACKLEAK_RUNTIME_DISABLE
-	bool "Allow runtime disabling of kernel stack erasing"
-	depends on GCC_PLUGIN_STACKLEAK
-	help
-	  This option provides 'stack_erasing' sysctl, which can be used in
-	  runtime to control kernel stack erasing for kernels built with
-	  CONFIG_GCC_PLUGIN_STACKLEAK.
-
 config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 01a119437dfc..3dd7a28c3822 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -88,6 +88,63 @@ config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	  initialized. Since not all existing initializers are detected
 	  by the plugin, this can produce false positive warnings.
 
+config GCC_PLUGIN_STACKLEAK
+	bool "Poison kernel stack before returning from syscalls"
+	depends on GCC_PLUGINS
+	depends on HAVE_ARCH_STACKLEAK
+	help
+	  This option makes the kernel erase the kernel stack before
+	  returning from system calls. This has the effect of leaving
+	  the stack initialized to the poison value, which both reduces
+	  the lifetime of any sensitive stack contents and reduces
+	  potential for uninitialized stack variable exploits or information
+	  exposures (it does not cover functions reaching the same stack
+	  depth as prior functions during the same syscall). This blocks
+	  most uninitialized stack variable attacks, with the performance
+	  impact being driven by the depth of the stack usage, rather than
+	  the function calling complexity.
+
+	  The performance impact on a single CPU system kernel compilation
+	  sees a 1% slowdown, other systems and workloads may vary and you
+	  are advised to test this feature on your expected workload before
+	  deploying it.
+
+	  This plugin was ported from grsecurity/PaX. More information at:
+	   * https://grsecurity.net/
+	   * https://pax.grsecurity.net/
+
+config STACKLEAK_TRACK_MIN_SIZE
+	int "Minimum stack frame size of functions tracked by STACKLEAK"
+	default 100
+	range 0 4096
+	depends on GCC_PLUGIN_STACKLEAK
+	help
+	  The STACKLEAK gcc plugin instruments the kernel code for tracking
+	  the lowest border of the kernel stack (and for some other purposes).
+	  It inserts the stackleak_track_stack() call for the functions with
+	  a stack frame size greater than or equal to this parameter.
+	  If unsure, leave the default value 100.
+
+config STACKLEAK_METRICS
+	bool "Show STACKLEAK metrics in the /proc file system"
+	depends on GCC_PLUGIN_STACKLEAK
+	depends on PROC_FS
+	help
+	  If this is set, STACKLEAK metrics for every task are available in
+	  the /proc file system. In particular, /proc/<pid>/stack_depth
+	  shows the maximum kernel stack consumption for the current and
+	  previous syscalls. Although this information is not precise, it
+	  can be useful for estimating the STACKLEAK performance impact for
+	  your workloads.
+
+config STACKLEAK_RUNTIME_DISABLE
+	bool "Allow runtime disabling of kernel stack erasing"
+	depends on GCC_PLUGIN_STACKLEAK
+	help
+	  This option provides 'stack_erasing' sysctl, which can be used in
+	  runtime to control kernel stack erasing for kernels built with
+	  CONFIG_GCC_PLUGIN_STACKLEAK.
+
 endmenu
 
 endmenu
-- 
2.17.1

