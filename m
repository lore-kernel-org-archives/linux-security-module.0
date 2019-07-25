Return-Path: <SRS0=7xhQ=VW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D37C7618B
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jul 2019 12:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9C5229F3
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Jul 2019 12:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Akqpe6Ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfGYMRI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:17:08 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54535 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbfGYMRI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Jul 2019 08:17:08 -0400
Received: by mail-pf1-f202.google.com with SMTP id y66so30753028pfb.21
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2019 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=ljHSm6Zzu7WQyG9Dr0/JwBFIPwkJWPZ7lmDnCVtXIlE=;
        b=Akqpe6Ca2kvfIFTvnoJ+c5OIYtAWTfjYFlxZ91JhehPR4MBfJm9ywhoCD3lGefBXW0
         n7SlpQFWfYgG4Aeujtxv2t7rdZa2kXKrO9hHdeloLRjBRpBGpMGC+IgBRq2hYlz74cwT
         010HpW9jL8W5gbrRGoEO3Y5fFruckvISszQcCXS5Fakkmmuet7C21J+u8swlLNVNjOq5
         Y1f7sdvOFzNM443uu1ysPbXSRudZDiBnFMX+WjpLHVbB5ENiuVLz2sPMw8Llub0ae2DF
         odjWLHT2fIwPD/mrVsCYEKgBnlnMvrlYvMqvBgUUd2lfogU6I9BnZ/kduh+R4OJE/trK
         0jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=ljHSm6Zzu7WQyG9Dr0/JwBFIPwkJWPZ7lmDnCVtXIlE=;
        b=FuJ+I/e/JFxgOY5sGDGbTvb8jV1XeI0FGYnbwrxiCPWFJbwmMbOEQ/DwaTPJwW5Bzw
         zbxhiCSgQAmkFYb/DfuvwnijMy7OUowU2Flxpk9ToR0P3LWoJ++jaZGJcmOFtNAEPu3w
         8uYBOw9mjoIihpsoDdokZgYqrhha2J1k7a6nzkA5/MNDKgq4ago/L6JP/cF9AbEi3Ucq
         vWx7cwhHIiMKU+L6qne0P4ZI3TuuyjmPCLug4+qp3XCYIedMlOikleRV5e/iu737MkHx
         HgMaxqf6Sd0KaiPJ95P01NmWx67JDUQ4Ze1WfVvIBTDOn4XPoMcG8qkys4H47uvSiyWt
         WPGg==
X-Gm-Message-State: APjAAAXhNB/6Fjlb314R8B3dijrYXl/un7zaUZxMxecvOWA4w7E4LbMh
        kk6tKH+8RBMoQbatyK5DJJkcLG0wK1Y=
X-Google-Smtp-Source: APXvYqz7yDmnI8s4vZuY1Ns1rw5n80XNvB05UiBPhLd8LH+m+RekLRU9SaXAoHp8e/m+hAePiBCX3thvsdg=
X-Received: by 2002:a63:cb4f:: with SMTP id m15mr10449746pgi.100.1564057027478;
 Thu, 25 Jul 2019 05:17:07 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:17:03 +0200
Message-Id: <20190725121703.210874-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH] test_meminit: use GFP_ATOMIC in RCU critical section
From:   Alexander Potapenko <glider@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

kmalloc() shouldn't sleep while in RCU critical section, therefore
use GFP_ATOMIC instead of GFP_KERNEL.

The bug has been spotted by the 0day kernel testing robot.

Fixes: 7e659650cbda ("lib: introduce test_meminit module")
Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-security-module@vger.kernel.org
---
 lib/test_meminit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 62d19f270cad..9729f271d150 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -222,7 +222,7 @@ static int __init do_kmem_cache_size(size_t size, bool want_ctor,
 		 * Copy the buffer to check that it's not wiped on
 		 * free().
 		 */
-		buf_copy = kmalloc(size, GFP_KERNEL);
+		buf_copy = kmalloc(size, GFP_ATOMIC);
 		if (buf_copy)
 			memcpy(buf_copy, buf, size);
 
-- 
2.22.0.657.g960e92d24f-goog

