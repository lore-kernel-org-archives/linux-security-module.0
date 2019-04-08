Return-Path: <SRS0=KU/V=SK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9AAC10F13
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A8720880
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KaYr8tw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfDHREo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:04:44 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:57002 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDHREo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Apr 2019 13:04:44 -0400
Received: by mail-ua1-f74.google.com with SMTP id z31so1725965uac.23
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2019 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1gO3dgS9UpC3tIRnZuIJ3y5CfBnKsH5tYfqKFkwj1cY=;
        b=KaYr8tw+jeZqiOwrzwVAlDptBYA4Ry/ZR4xpuhtzE3lOl7IbAN7jpK8BJ+bBmzBIeZ
         GYI+dVRWPubMRW8P0YmGCdlkdqMUNVU7tWvnyPHC0vMLqFQsupZCaLfraR7jmsQ6uKbg
         HmHnnwd+AXI8bsbaiMiA2vfJ7BDTA7CWiJvhe5o+3gPPzSsqHvSm2A9RbJwoe88QJsZB
         5VfZNZlWR301uXtwQkkHDeK5heCyLuk/TjsS25GW+UP8xA3vQ4CeUD62+dvZbuhXnLsQ
         V1MzOqWojcxjRDNLlDWl5FEYy+RVwZiIq3dzSCGg72d8vtYSKXQ43eD8fazii32LoQjr
         ioKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1gO3dgS9UpC3tIRnZuIJ3y5CfBnKsH5tYfqKFkwj1cY=;
        b=SXX4Eldg4YurDP9cIf9Zbhnjvd4YQc2ksTdpgVWWiY0lJ9GiZfvSOEUv5dPTnGgO/J
         yijdrfsVQrrLgVGgSdPcvsdbeZmi9o7t1zEUq4HTU2ckfeR8u7FaA0T2RvO4E2dvjpXV
         jh5n/gv8AtciofmyuvKJqEN+1Xu1GXgUcRkT8mCXBpV5WbGf+/B5xzD230tTjp61BT+v
         o6gIQYF8Em9CeAnkVMvHsvZ7qx/WvLZcA1EUJpep8WGD81/A2KnGX604b6BG5J02qGJp
         QaByjWQ+7l+Jvw2fVew4dVJPkYXh1WtxpUrQ/5CIQKP8dOti1eWCW6C041dIxkeVQSwq
         W3lQ==
X-Gm-Message-State: APjAAAWkZc3hKllnOMydiKT7nI8hgrDmUIbfpQPFdI2nvrHvFr5vIE2N
        2GmEmJR0UEo4Jg3XNX+2hU66F77424o=
X-Google-Smtp-Source: APXvYqzyl5ZUeSUGvGPgux97lMADMvy+mCZfm2pazYAkhNnd7vBDeT04YEg9jX2ti+IsYqJjJ7Myb/Mih9M=
X-Received: by 2002:a67:f5da:: with SMTP id t26mr3298362vso.10.1554743083407;
 Mon, 08 Apr 2019 10:04:43 -0700 (PDT)
Date:   Mon,  8 Apr 2019 19:04:18 +0200
In-Reply-To: <20190408170418.148554-1-glider@google.com>
Message-Id: <20190408170418.148554-3-glider@google.com>
Mime-Version: 1.0
References: <20190408170418.148554-1-glider@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
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

This config option enables CONFIG_SLUB_DEBUG and CONFIG_PAGE_POISONING
without the need to pass any boot parameters.

No performance optimizations are done at the moment to reduce double
initialization of memory regions.

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
 v3:
  - addressed comments by Masahiro Yamada (Kconfig fixes)
---
 mm/page_poison.c         |  5 +++++
 mm/slub.c                |  2 ++
 security/Kconfig.initmem | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index 21d4f97cb49b..a1985f33f635 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -12,9 +12,14 @@ static bool want_page_poisoning __read_mostly;
 
 static int __init early_page_poison_param(char *buf)
 {
+#ifdef CONFIG_INIT_ALL_HEAP
+	want_page_poisoning = true;
+	return 0;
+#else
 	if (!buf)
 		return -EINVAL;
 	return strtobool(buf, &want_page_poisoning);
+#endif
 }
 early_param("page_poison", early_page_poison_param);
 
diff --git a/mm/slub.c b/mm/slub.c
index 1b08fbcb7e61..00e0197d3f35 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1287,6 +1287,8 @@ static int __init setup_slub_debug(char *str)
 	if (*str == ',')
 		slub_debug_slabs = str + 1;
 out:
+	if (IS_ENABLED(CONFIG_INIT_ALL_HEAP))
+		slub_debug |= SLAB_POISON;
 	return 1;
 }
 
diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
index 5e49a55382ad..37cc10a2eeb5 100644
--- a/security/Kconfig.initmem
+++ b/security/Kconfig.initmem
@@ -13,6 +13,17 @@ config INIT_ALL_MEMORY
 
 if INIT_ALL_MEMORY
 
+config INIT_ALL_HEAP
+	bool "Initialize all heap"
+	depends on INIT_ALL_MEMORY
+	select PAGE_POISONING
+	select PAGE_POISONING_NO_SANITY
+	select PAGE_POISONING_ZERO
+	select SLUB_DEBUG if SLUB
+	default y
+	help
+	  Enable page poisoning and SLUB poisoning by default.
+
 config INIT_ALL_STACK
 	bool "Initialize all stack"
 	depends on INIT_ALL_MEMORY
-- 
2.21.0.392.gf8f6787159e-goog

