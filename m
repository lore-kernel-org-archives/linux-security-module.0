Return-Path: <SRS0=daWi=T5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27B8C28CC1
	for <linux-security-module@archiver.kernel.org>; Wed, 29 May 2019 12:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B909208C3
	for <linux-security-module@archiver.kernel.org>; Wed, 29 May 2019 12:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVUrmXjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfE2Mie (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 May 2019 08:38:34 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46676 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfE2Mie (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 May 2019 08:38:34 -0400
Received: by mail-qk1-f202.google.com with SMTP id 18so1734844qkl.13
        for <linux-security-module@vger.kernel.org>; Wed, 29 May 2019 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OTSVci+9HQFGuKiIh59lqpYGkMYL4TSES3kfTgmqHdU=;
        b=QVUrmXjBtd4xAGA041VU9vn2Wo24J0G/ryDcfbSzyIaXXA9eT1e/5dNi0QJEzMBCWq
         fN3WkgM5gqMR9l0iwxBy9vH+tbNaCYmzc3eMgJngHj1kSa5AtgjWh5+5HjO/QfCZpvY6
         Jb+OfcJFPlWhCrVMcT9BX7VIzn5XFynOaCCkftBB3mbVd1JQuJaHm0m7kyXHACmQ9cgW
         9zAnA35gH0p0YX9UacAq6LYdKrQ3NUIsIStqgl+m5S9sxABy/LK6SgMc6qA6s4YfiEYT
         SjwPmB5DRuLJ/T8J4jYw4vuR8yqEzw06eiiDOGT9MuQeYfiVfkXQYF9mVBXb/uZL2taU
         nQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OTSVci+9HQFGuKiIh59lqpYGkMYL4TSES3kfTgmqHdU=;
        b=eeJmEd1hMjzRL0MeohW04Ke+YFgxtA997zJfgv0JmCkYlq+NQE/rTTDFtEnaDpceyp
         FpKTufx33H2/Yj4gkcMzIB+AgHK0TfMiTDYEYA4Xtbk3Lfldh7C3x41r3v1djlsC3PMu
         eSXW9pBHNwxXEiKVWvHPol1JfRDU6cz3LMnqf3C5YxDb/7ZiBPALKGKSFztFLhYpxaHg
         JGWcBq101oY5RpQRHCJ4DMO9uCLJMu7cGUy45elRGBfHf+kktSF3EUEkvW+LkMlkezjm
         B12drVifu6diUBcZx4kVYKznQGdE2UX7zVANfb0DAfccSvn8qPtGI+Ms7HW82s8X2PTR
         SExA==
X-Gm-Message-State: APjAAAUROha/EbBddpKFwLpb11/CkoWVOhwl6LnyxDUhG51iCS1lPHUE
        szO6XE/PV3k53xawMrqW/RcS6C+KhnQ=
X-Google-Smtp-Source: APXvYqyuj6WNrP123438HFtnTx32oR/o63x7jglpOtKNMGuuQ+g2SgRyW1Nxym/uXkKBa07I2QYAnrLim8k=
X-Received: by 2002:a05:620a:141a:: with SMTP id d26mr6791202qkj.32.1559133513103;
 Wed, 29 May 2019 05:38:33 -0700 (PDT)
Date:   Wed, 29 May 2019 14:38:11 +0200
In-Reply-To: <20190529123812.43089-1-glider@google.com>
Message-Id: <20190529123812.43089-3-glider@google.com>
Mime-Version: 1.0
References: <20190529123812.43089-1-glider@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v5 2/3] mm: init: report memory auto-initialization features
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
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
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
Cc: Marco Elver <elver@google.com>
Cc: kernel-hardening@lists.openwall.com
Cc: linux-mm@kvack.org
Cc: linux-security-module@vger.kernel.org
---
 init/main.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/init/main.c b/init/main.c
index 66a196c5e4c3..9d63ff1d48f3 100644
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
+		pr_info("Clearing system memory may take some time...\n");
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
2.22.0.rc1.257.g3120a18244-goog

