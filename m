Return-Path: <SRS0=9TCU=UG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2103C28CC3
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jun 2019 08:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB06C2089E
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jun 2019 08:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdCdjwMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFGIzo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:55:44 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56462 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFGIzo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jun 2019 04:55:44 -0400
Received: by mail-vk1-f201.google.com with SMTP id a4so514339vki.23
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jun 2019 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7sAcFhzm9//uuWPzvmk6JGPNvQAtroDUafFgbzLm/yQ=;
        b=rdCdjwMg3gY0shibBU1Y00zUYQIbtOM1x+c+yT+bFe7iBq5B+DoGdkjBVtzSVU+VH4
         pP96pPCG+Y973PP3O/lWES1n/UCOKtZa3RNHsidIfwLMPCrenvyWFxRyRqzXyZsOsCjr
         qSODaba6lZJocr0BUenu+4ZEbh1HblpWCFTpj73QuxvyUjbyJLZFozdmYeqn4HCfWCGh
         /AMfOsdrVXar7zg8+8htj5UxeyZr5izHf4MgEsCAHA6hwcqCH0BBWjwFe+k9QgjrSEmp
         U+n4drC9Dr/6Kek1dfT2CT1N1chYQ3TylncKuorf8JsVOifT/sDp1sYcXeCWD0MPL07+
         5kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7sAcFhzm9//uuWPzvmk6JGPNvQAtroDUafFgbzLm/yQ=;
        b=KxHmUddiL1xSGvjTzY4dogHe9S+XIjGMuDImV0erov3vy+/1UI/ge7oxpQNB8NqMim
         L0adyb/BXsHvOM7uSwNdGxAg4EIT4ZmAsRVlksYFhHLzA6fZaUf262zxkeXktdydknrs
         Nk+v7l1OSW0kAdj3oPmGPUmSQOmbU4pW9bvyO6fHYog9b0zh0LVY0xmNqta6b0E0yvqI
         xwiaILhtS9t6MQSRg4K0hm4DE6AsTecizWEp1JyMMVjc7GC8HfMJOwDWzlb8APJkVGpo
         mC3FMnvlnEpRJRh6NcaA3AuLG3TvfH9+Po+cZuGIHIeJDV6A/sO2quYhVEzM8NyaZ3lk
         ot7A==
X-Gm-Message-State: APjAAAUAshQoWyWFBj3rKPl8g6MzvVUjluh6Q58lppJIOByQQbvCFgPl
        UMo//rsVztqQwvolhxeiPLNky0i1eeE=
X-Google-Smtp-Source: APXvYqxl2fR/kTIk2qghgxJ9BB+AYD6tf6ZHiB+nSiWLpCvBpXZOF6k/lSrBGI83j05i6uqHwLil+lUnGI4=
X-Received: by 2002:a1f:e906:: with SMTP id g6mr514895vkh.25.1559897742846;
 Fri, 07 Jun 2019 01:55:42 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:48:44 +0200
In-Reply-To: <20190606164845.179427-1-glider@google.com>
Message-Id: <20190606164845.179427-3-glider@google.com>
Mime-Version: 1.0
References: <20190606164845.179427-1-glider@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v6 2/3] mm: init: report memory auto-initialization features
 at boot time
From:   Alexander Potapenko <glider@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sandeep Patil <sspatil@android.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Marco Elver <elver@google.com>,
        Kaiwan N Billimoria <kaiwan@kaiwantech.com>,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Print the currently enabled stack and heap initialization modes.

Stack initialization is enabled by a config flag, while heap
initialization is configured at boot time with defaults being set
in the config. It's more convenient for the user to have all information
about these hardening measures in one place.

The possible options for stack are:
 - "all" for CONFIG_INIT_STACK_ALL;
 - "byref_all" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL;
 - "byref" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF;
 - "__user" for CONFIG_GCC_PLUGIN_STRUCTLEAK_USER;
 - "off" otherwise.

Depending on the values of init_on_alloc and init_on_free boottime
options we also report "heap alloc" and "heap free" as "on"/"off".

In the init_on_free mode initializing pages at boot time may take some
time, so print a notice about that as well.

Signed-off-by: Alexander Potapenko <glider@google.com>
Suggested-by: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Lameter <cl@linux.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Sandeep Patil <sspatil@android.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: Kaiwan N Billimoria <kaiwan@kaiwantech.com>
Cc: kernel-hardening@lists.openwall.com
Cc: linux-mm@kvack.org
Cc: linux-security-module@vger.kernel.org
---
 v6:
 - update patch description, fixed message about clearing memory
---
 init/main.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/init/main.c b/init/main.c
index 66a196c5e4c3..e68ef1f181f9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -520,6 +520,29 @@ static inline void initcall_debug_enable(void)
 }
 #endif
 
+/* Report memory auto-initialization states for this boot. */
+void __init report_meminit(void)
+{
+	const char *stack;
+
+	if (IS_ENABLED(CONFIG_INIT_STACK_ALL))
+		stack = "all";
+	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL))
+		stack = "byref_all";
+	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF))
+		stack = "byref";
+	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_USER))
+		stack = "__user";
+	else
+		stack = "off";
+
+	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
+		stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
+		want_init_on_free() ? "on" : "off");
+	if (want_init_on_free())
+		pr_info("mem auto-init: clearing system memory may take some time...\n");
+}
+
 /*
  * Set up kernel memory allocators
  */
@@ -530,6 +553,7 @@ static void __init mm_init(void)
 	 * bigger than MAX_ORDER unless SPARSEMEM.
 	 */
 	page_ext_init_flatmem();
+	report_meminit();
 	mem_init();
 	kmem_cache_init();
 	pgtable_init();
-- 
2.22.0.rc1.311.g5d7573a151-goog

