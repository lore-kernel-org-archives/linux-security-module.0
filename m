Return-Path: <SRS0=lnE7=U2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51403C48BD6
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 13:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEC52053B
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 13:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+pfh+q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfF0NDd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:03:33 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:33408 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0NDd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 09:03:33 -0400
Received: by mail-vk1-f202.google.com with SMTP id a185so668845vkb.0
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OTM/dBWKP5pXAZwQDJU1YbjuxxUPU+6Vr1IAcbjuDVo=;
        b=t+pfh+q2u5DSP6mSeIK1r67ErcoQ4NQ8UsM5O9mGBYMiMCyv5PvcnnHkKNL/S8BSql
         eOA0/MWF7e5MR4sM/kFj2EDJhvTYzaDf++QwCyebCHUw/KNaIzSHf5WKn4Dt6RpqL+ql
         DmRJwW/0Je2MaVg41STn0p9q/VP9o0K/qRm0CtcgkzfRUbMccg2EyCxV0U/JM9UsEnlO
         g62cz0FUurVCddNaeP0ka5lwPT55dY+FEab2GfRuP0XKPq/hulqwOgsctIchPeVNa1M3
         ZUJnDFJoRj5ZCGnNG2BOWe67YpXjddedZW0akWlAupL03a82Bk0h6zX7lm6X6NrlCOXf
         4+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OTM/dBWKP5pXAZwQDJU1YbjuxxUPU+6Vr1IAcbjuDVo=;
        b=jjVIF6Q14ZCNFISsRdJoJp0HnNqo1CQjjEjZhmbbV/6lSpzqu6kZsIUG04tWZIqZIo
         yu4hUUVuNWof2fioVsyMElU5uZY3QL/yc60rxoygPCEYAERX9j48qp66uSIHSKz3+0Ig
         eMTRJiV4mPvhNRGotFmBUZNDaV3IClfsU9+7cSmA2f1H7EF/2s7wMltq1zH/ZCdSe5KI
         m4Eg/l8pazkeTwzg8iaHVEm0QlvqGIWSeN860ORAjNXTvaHLg7CPxBF+aXkNf2CSJKfj
         TIsibfGUElft28p/MdMXK259lF6/a9qTwFY3azvMIXbc+7VmbTJi7djMoBYSAK38jqAA
         O3wA==
X-Gm-Message-State: APjAAAUKSlBG2cSaZWQrMe8zvsuQ2LuIcNb1OTS8FTukuU7j+79d/kjv
        t6gjGokCfqqnltylTtncDD5T3Rz7uqs=
X-Google-Smtp-Source: APXvYqzHT3CTIJYzDrs0X3XZhQ1nNpPSVhzaXrDUP0P/c7kcHUZJG8WqtMpRqCMlOADbxQ/YidQWVk8aekg=
X-Received: by 2002:a67:bb18:: with SMTP id m24mr1257345vsn.201.1561640612036;
 Thu, 27 Jun 2019 06:03:32 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:03:16 +0200
In-Reply-To: <20190627130316.254309-1-glider@google.com>
Message-Id: <20190627130316.254309-3-glider@google.com>
Mime-Version: 1.0
References: <20190627130316.254309-1-glider@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 2/2] mm: init: report memory auto-initialization features
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
about these hardening measures in one place at boot, so the user can
reason about the expected behavior of the running system.

The possible options for stack are:
 - "all" for CONFIG_INIT_STACK_ALL;
 - "byref_all" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL;
 - "byref" for CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF;
 - "__user" for CONFIG_GCC_PLUGIN_STRUCTLEAK_USER;
 - "off" otherwise.

Depending on the values of init_on_alloc and init_on_free boottime
options we also report "heap alloc" and "heap free" as "on"/"off".

In the init_on_free mode initializing pages at boot time may take a
while, so print a notice about that as well. This depends on how much
memory is installed, the memory bandwidth, etc.
On a relatively modern x86 system, it takes about 0.75s/GB to wipe all
memory:

  [    0.418722] mem auto-init: stack:byref_all, heap alloc:off, heap free:on
  [    0.419765] mem auto-init: clearing system memory may take some time...
  [   12.376605] Memory: 16408564K/16776672K available (14339K kernel code, 1397K rwdata, 3756K rodata, 1636K init, 11460K bss, 368108K reserved, 0K cma-reserved)

Signed-off-by: Alexander Potapenko <glider@google.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

---
 v6:
 - update patch description, fixed message about clearing memory
 v7:
 - rebase the patch, add the Acked-by: tag;
 - more description updates as suggested by Kees;
 - make report_meminit() static.
 v8:
 - added the Signed-off-by: tag
---
 init/main.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/init/main.c b/init/main.c
index 66a196c5e4c3..ff5803b0841c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -520,6 +520,29 @@ static inline void initcall_debug_enable(void)
 }
 #endif
 
+/* Report memory auto-initialization states for this boot. */
+static void __init report_meminit(void)
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
2.22.0.410.gd8fdbe21b5-goog

