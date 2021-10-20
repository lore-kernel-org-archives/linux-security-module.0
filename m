Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD19C433FE
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Oct 2021 17:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 990C0610EA
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Oct 2021 17:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhJTRiP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhJTRiL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Oct 2021 13:38:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F71AC06176A
        for <linux-security-module@vger.kernel.org>; Wed, 20 Oct 2021 10:35:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso2982122pjb.1
        for <linux-security-module@vger.kernel.org>; Wed, 20 Oct 2021 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1XRomZ8Io7favCHYT3bnx2s+fAILcX1u70AHtBS8Pw=;
        b=LVALPJH/SaUOIt6tZIPCSWPo1H2JwFkEu1rbLRKHJSKLX0Fe2p+vDLyPsA6xKrmpay
         2/adVT1XNUTiHSjePbzWz4fFYJhY1SGWKAYGsFl0WnNq5UxfMmVfRcZztjIwIYEIxt3i
         Od9hD3+Z9ELsNgag3q6EmXfQZ6WAXDCJxbgHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1XRomZ8Io7favCHYT3bnx2s+fAILcX1u70AHtBS8Pw=;
        b=3XKhG8eeQOcIy5rpjVck/o6KKTAx31Rsg/AIHh/WnCUZQLxH5F5BB+xv+/T+EiYJ7E
         /iugwuGEiJgJB/iUZ4KggnavGnBZZvVqJczrVVrsu8of1hixxdzRoYHuagySt/o6dOJ9
         JarqyXDOJCf3MkOo5+Qd2r0L78i1A2Oi2SIhXUGeytRRdOGDJSXldrB0tGj+sZ1KfLUO
         lY2YxaIl5zo5l0Du2YNzO4MRGcLcHtqP1AcuPGfACM5dbPXtsV1SXKM2Pqt2I4XY01Gl
         VCl1ehTXUpfo0WwGQqo/9OprlUDnzvc5v3b0dPbxkENNmNy8+sfgqVTHbO0j7w3zCVRk
         M32g==
X-Gm-Message-State: AOAM5323gC4MKB47B82Vf5n3ZJnGy3OuzSHRVZzJXejLZFO7lwK2/3hI
        ooVl+EA0vYpEX9a+3Qwve9+WWg==
X-Google-Smtp-Source: ABdhPJz1Usn7FsIMGM086r+0uc2HiWD32fZOkmfv4SUsDanHb7JXEZzWHcQqdvPT3HCTBiJIoKzUjQ==
X-Received: by 2002:a17:90a:718b:: with SMTP id i11mr468924pjk.22.1634751356652;
        Wed, 20 Oct 2021 10:35:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v22sm3266439pff.93.2021.10.20.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:35:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, Dan Li <ashimida@linux.alibaba.com>,
        ardb@kernel.org, ojeda@kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/2] gcc-plugins: Remove cyc_complexity
Date:   Wed, 20 Oct 2021 10:35:54 -0700
Message-Id: <20211020173554.38122-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020173554.38122-1-keescook@chromium.org>
References: <20211020173554.38122-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5284; h=from:subject; bh=f2Np39be8zJVYWgx0MLtNjd71k0ksUQOTt8kvkajL04=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhcFN51/MMK5PHASvRnsuVs7LQ9NKVVm1rmcssDUDA wONxnBWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYXBTeQAKCRCJcvTf3G3AJnCBD/ 9jWTO6a8sOqL7zQXVu/EiXql18cf8YSXnFWBxaTujzSjaSRjF9ivILZRxR1yk1g9eKEsFYJ+ziJvJV Q4jpD8gqM2wtH/wWEQyfRl38sYUJeOpyWNLWvKWJcMM8dNAiTGCfujbDMCAPQAARORXUqlJlI/8iOE ppZ21R7oHGDeFHGzKLc/OUnxo6OuWLb855Z9hBCEXWZAJ1G9NeujwYLCtaHMXmCyG1Xgd8x/CU+HiD mkAsaWbDfZeKKXYlcLlRmd4TV380UAz5lANqoXdcMnbFqMSkG82JuwBs+/z70afm2OqNjtEWcBbmc+ heX1tUsKYWekMN4h7EQGyuE4YtYta0TVjLKYwSR3LiX4yZdsKUS94RiZMM56HHymWkQQjdbCgTj7BM PInUl+JAVFqYlaBj3Rr5UkHeN0tPoVIIHq6TDIZkie+RRF1HQqJKaptOcOh07dI/6Z4cC2V/qhedmt O0Xh3lpGLCwuWbL/JiyAng13B/Nw5B48knBt/wzUOOwykfHJannZz9/6NiBrXzhWsARHoHjdbt9yK0 LAcWZSRnIhCObuCCRXD3GcMxey8UWQaTOisPhI1bNXt5h3+N020zRywYJ+y6f7eyErAY5LZg+r/HBy 2AzAqmv5Iw3L8ovjrVBSj/Gsh7aD7Obk0o5MOp4o7LloSugDViYk6OPa5vRQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This plugin has no impact on the resulting binary, is disabled
under COMPILE_TEST, and is not enabled on any builds I'm aware of.
Additionally, given the clarified purpose of GCC plugins in the kernel,
remove cyc_complexity.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-hardening@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/kbuild/gcc-plugins.rst        |  2 -
 scripts/Makefile.gcc-plugins                |  2 -
 scripts/gcc-plugins/Kconfig                 | 16 -----
 scripts/gcc-plugins/cyc_complexity_plugin.c | 69 ---------------------
 4 files changed, 89 deletions(-)
 delete mode 100644 scripts/gcc-plugins/cyc_complexity_plugin.c

diff --git a/Documentation/kbuild/gcc-plugins.rst b/Documentation/kbuild/gcc-plugins.rst
index 4b28c7a4032f..0ba76719f1b9 100644
--- a/Documentation/kbuild/gcc-plugins.rst
+++ b/Documentation/kbuild/gcc-plugins.rst
@@ -96,7 +96,6 @@ Enable the GCC plugin infrastructure and some plugin(s) you want to use
 in the kernel config::
 
 	CONFIG_GCC_PLUGINS=y
-	CONFIG_GCC_PLUGIN_CYC_COMPLEXITY=y
 	CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
 	...
 
@@ -115,4 +114,3 @@ The GCC plugins are in scripts/gcc-plugins/. You need to put plugin source files
 right under scripts/gcc-plugins/. Creating subdirectories is not supported.
 It must be added to scripts/gcc-plugins/Makefile, scripts/Makefile.gcc-plugins
 and a relevant Kconfig file.
-See the cyc_complexity_plugin.c (CONFIG_GCC_PLUGIN_CYC_COMPLEXITY) GCC plugin.
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 952e46876329..6583ecf2e674 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gcc-plugin-$(CONFIG_GCC_PLUGIN_CYC_COMPLEXITY)	+= cyc_complexity_plugin.so
-
 gcc-plugin-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= latent_entropy_plugin.so
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)		\
 		+= -DLATENT_ENTROPY_PLUGIN
diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 3f5d3580ec06..821a725a7f5c 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -19,22 +19,6 @@ menuconfig GCC_PLUGINS
 
 if GCC_PLUGINS
 
-config GCC_PLUGIN_CYC_COMPLEXITY
-	bool "Compute the cyclomatic complexity of a function" if EXPERT
-	depends on !COMPILE_TEST	# too noisy
-	help
-	  The complexity M of a function's control flow graph is defined as:
-	   M = E - N + 2P
-	  where
-
-	  E = the number of edges
-	  N = the number of nodes
-	  P = the number of connected components (exit nodes).
-
-	  Enabling this plugin reports the complexity to stderr during the
-	  build. It mainly serves as a simple example of how to create a
-	  gcc plugin for the kernel.
-
 config GCC_PLUGIN_SANCOV
 	bool
 	# Plugin can be removed once the kernel only supports GCC 6.1.0+
diff --git a/scripts/gcc-plugins/cyc_complexity_plugin.c b/scripts/gcc-plugins/cyc_complexity_plugin.c
deleted file mode 100644
index 73124c2b3edd..000000000000
--- a/scripts/gcc-plugins/cyc_complexity_plugin.c
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * Copyright 2011-2016 by Emese Revfy <re.emese@gmail.com>
- * Licensed under the GPL v2, or (at your option) v3
- *
- * Homepage:
- * https://github.com/ephox-gcc-plugins/cyclomatic_complexity
- *
- * https://en.wikipedia.org/wiki/Cyclomatic_complexity
- * The complexity M is then defined as:
- * M = E - N + 2P
- * where
- *
- *  E = the number of edges of the graph
- *  N = the number of nodes of the graph
- *  P = the number of connected components (exit nodes).
- *
- * Usage (4.5 - 5):
- * $ make clean; make run
- */
-
-#include "gcc-common.h"
-
-__visible int plugin_is_GPL_compatible;
-
-static struct plugin_info cyc_complexity_plugin_info = {
-	.version	= "20160225",
-	.help		= "Cyclomatic Complexity\n",
-};
-
-static unsigned int cyc_complexity_execute(void)
-{
-	int complexity;
-	expanded_location xloc;
-
-	/* M = E - N + 2P */
-	complexity = n_edges_for_fn(cfun) - n_basic_blocks_for_fn(cfun) + 2;
-
-	xloc = expand_location(DECL_SOURCE_LOCATION(current_function_decl));
-	fprintf(stderr, "Cyclomatic Complexity %d %s:%s\n", complexity,
-		xloc.file, DECL_NAME_POINTER(current_function_decl));
-
-	return 0;
-}
-
-#define PASS_NAME cyc_complexity
-
-#define NO_GATE
-#define TODO_FLAGS_FINISH TODO_dump_func
-
-#include "gcc-generate-gimple-pass.h"
-
-__visible int plugin_init(struct plugin_name_args *plugin_info, struct plugin_gcc_version *version)
-{
-	const char * const plugin_name = plugin_info->base_name;
-
-	PASS_INFO(cyc_complexity, "ssa", 1, PASS_POS_INSERT_AFTER);
-
-	if (!plugin_default_version_check(version, &gcc_version)) {
-		error(G_("incompatible gcc/plugin versions"));
-		return 1;
-	}
-
-	register_callback(plugin_name, PLUGIN_INFO, NULL,
-				&cyc_complexity_plugin_info);
-	register_callback(plugin_name, PLUGIN_PASS_MANAGER_SETUP, NULL,
-				&cyc_complexity_pass_info);
-
-	return 0;
-}
-- 
2.30.2

