Return-Path: <SRS0=z3Bq=TX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEC5C282DD
	for <linux-security-module@archiver.kernel.org>; Thu, 23 May 2019 12:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C9421019
	for <linux-security-module@archiver.kernel.org>; Thu, 23 May 2019 12:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwxaN5TX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfEWMmg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 May 2019 08:42:36 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:40204 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfEWMmg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 May 2019 08:42:36 -0400
Received: by mail-vk1-f202.google.com with SMTP id p83so2271614vkd.7
        for <linux-security-module@vger.kernel.org>; Thu, 23 May 2019 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NCAxoLMPldvKQMidzNTr8hyOEHq1jSHIcOt+CxAESVs=;
        b=kwxaN5TXi2fzUmuexBBY0GXWxXPKI1jjIZBR+Z9tiHoEQ/9ujAqPr7MVyXRNhvSd9+
         AK6kCkOhJm5SbE0jSM+BNskxXce/VCkWz+Q+nhHVzGM9EiVIxQWQw6xGFRwc293n6pL6
         UjuOZc6NpSLuxS9lgkZ9YHgOqEJdb30RHbq5NVEGKZ2RrMvsO8eGym5LjADg9LCNz+Mj
         M2xn9+Ia0uIgVsD4bzKVJvdYZBbu08DtKLv/k2Kp238pWpoARR/ey5wwSaCTCcg+zg5u
         IdrKv4BJiVUrPXZyjmF08n8tXNbuPmuj2yNUQwZ+XjwO6HLAiarXc1mbTJcvhpLSEk3Y
         /qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NCAxoLMPldvKQMidzNTr8hyOEHq1jSHIcOt+CxAESVs=;
        b=W0mwKD3C6pWzGeAqj051MHxxUBbN6zKbYUS9Uqn5J5lC55T1xpBKTvpLUibpWT+SPd
         oY0k8BGUk4MTA6hGg0cRbqezIiTN16fvTUWddG+45kS7Y3Xqjz4C9P3uvGrQu9x8Izy1
         ZdPC8ge4vXqq+rWfNv4xeLUj6/445L9y7ht24uLWVrTLamsAb2orRUGZ0IaqVURglt2f
         OYqqmTIGxbQQSegY7dJFGuwVp8yrdcRcstQWwCEeejCByr+T2CiNCnH2Y91tJebHZy0r
         TWc2Sy3/F0kcimoWUINV7kuEdOlDmW+o6Tp4clhUeWj5DA9hM9iWVafpe5f8cXkm3Wh+
         X70g==
X-Gm-Message-State: APjAAAUT0HqJInnadAboyvx+1SluxEwoY+XSgu/bMljCxWC2gYUTtpKS
        hVm4A96Y1qmggr/aHPbs8Pl661zaVT8=
X-Google-Smtp-Source: APXvYqyogFkZZsLOf7+neUZRBCYC8MGU1KnLcLqehoJt4hw5P+8oApijqvC8NaJniUHj65EbWsPUM/NXYM8=
X-Received: by 2002:a1f:944d:: with SMTP id w74mr1575300vkd.38.1558615355140;
 Thu, 23 May 2019 05:42:35 -0700 (PDT)
Date:   Thu, 23 May 2019 14:42:15 +0200
In-Reply-To: <20190523124216.40208-1-glider@google.com>
Message-Id: <20190523124216.40208-3-glider@google.com>
Mime-Version: 1.0
References: <20190523124216.40208-1-glider@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH 2/3] mm: init: report memory auto-initialization features at
 boot time
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, cl@linux.com, keescook@chromium.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
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
        Souptick Joarder <jrdr.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Print the currently enabled stack and heap initialization modes.

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
Cc: kernel-hardening@lists.openwall.com
Cc: linux-mm@kvack.org
Cc: linux-security-module@vger.kernel.org
---
 init/main.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/init/main.c b/init/main.c
index 5a2c69b4d7b3..90f721c58e61 100644
--- a/init/main.c
+++ b/init/main.c
@@ -519,6 +519,29 @@ static inline void initcall_debug_enable(void)
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
+		pr_info("Clearing system memory may take some time...\n");
+}
+
 /*
  * Set up kernel memory allocators
  */
@@ -529,6 +552,7 @@ static void __init mm_init(void)
 	 * bigger than MAX_ORDER unless SPARSEMEM.
 	 */
 	page_ext_init_flatmem();
+	report_meminit();
 	mem_init();
 	kmem_cache_init();
 	pgtable_init();
-- 
2.21.0.1020.gf2820cf01a-goog

