Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD2EC433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Dec 2021 17:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244594AbhLJRh1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244663AbhLJRhQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:16 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57697C0698CC
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:38 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so10321223otl.8
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8DvdE8cQs/ahPWAnUud5n5yToq2pjtImEbhrWCSKj4=;
        b=A2U4egVLtJIpoFQ30tstUVGzUGtOmsoHZ0xs8fseV5579Sz4E00j5WbNj12yVBrh10
         gBjWd+OSjLozqsC67VnD+TKT5lsMslmI9Dan2YNX0NvXY97ryAY1BHSC/uJesx1iBcpC
         Pd1bwFa6CQTZ3aeMIGkPxRo3I016VxH2gMgzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8DvdE8cQs/ahPWAnUud5n5yToq2pjtImEbhrWCSKj4=;
        b=sfVF+jRd4GdofBwTuBxHHZtVMJm7f1xSvqMOtbDif8jx/vR7EeZ0vvuKtr0cg0NYM6
         LKLH/n34PuA2W6zbAczQ00kFCxEFyLh520t7sJ8RfmkMxYguhzH83DK9eXQAWr9SR+Fa
         4ZE3nmpGQpNPFHAuEB79NX/iaHclHs7cs3UWBQA8SdxvaD+vjkXNjwBZqehKJXPeYcwc
         ZJb0LdumsOLVodmSPjI0kPgUC+C8XIH8+xHHmUUkKd747ooazRZLCVBNywlMIa2KX2D+
         uVRffYBaMHhpWQ0ik+qOeLgjr/LFjKofzrj+95x58rDSsvaRMz+uzpDKgjt6GzyFLF+x
         EAYA==
X-Gm-Message-State: AOAM531VEMzPrAQE5YbPsv/2stYAdzCOpArxS6/CGduNIpQJ0tLCl8QX
        a91nTDnnHZs1OWhD3iFcEEN4Yg==
X-Google-Smtp-Source: ABdhPJw/EV9rFIsA/Y2l9EL9YhWZjVYVklXozZh2QN5jLKH28l9K6PLS2YIbrdvs6ptrFP99TR5idg==
X-Received: by 2002:a05:6830:1216:: with SMTP id r22mr12680706otp.10.1639157617637;
        Fri, 10 Dec 2021 09:33:37 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:37 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 12/12] selftests/vm: remove ARRAY_SIZE define from individual tests
Date:   Fri, 10 Dec 2021 10:33:22 -0700
Message-Id: <18321f68b399cd2c2709131d6d6eb1d0f58e8b4f.1639156389.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1639156389.git.skhan@linuxfoundation.org>
References: <cover.1639156389.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

ARRAY_SIZE is defined in several selftests. Remove definitions from
individual test files and include header file for the define instead.
ARRAY_SIZE define is added in a separate patch to prepare for this
change.

Remove ARRAY_SIZE from vm tests and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/vm/mremap_test.c    | 1 -
 tools/testing/selftests/vm/pkey-helpers.h   | 3 ++-
 tools/testing/selftests/vm/va_128TBswitch.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 0624d1bd71b5..7c0b0617b9f8 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -20,7 +20,6 @@
 #define VALIDATION_DEFAULT_THRESHOLD 4	/* 4MB */
 #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 
 struct config {
diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 622a85848f61..92f3be3dd8e5 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -13,6 +13,8 @@
 #include <ucontext.h>
 #include <sys/mman.h>
 
+#include "../kselftest.h"
+
 /* Define some kernel-like types */
 #define  u8 __u8
 #define u16 __u16
@@ -175,7 +177,6 @@ static inline void __pkey_write_allow(int pkey, int do_allow_write)
 	dprintf4("pkey_reg now: %016llx\n", read_pkey_reg());
 }
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
 #define ALIGN_UP(x, align_to)	(((x) + ((align_to)-1)) & ~((align_to)-1))
 #define ALIGN_DOWN(x, align_to) ((x) & ~((align_to)-1))
 #define ALIGN_PTR_UP(p, ptr_align_to)	\
diff --git a/tools/testing/selftests/vm/va_128TBswitch.c b/tools/testing/selftests/vm/va_128TBswitch.c
index 83acdff26a13..da6ec3b53ea8 100644
--- a/tools/testing/selftests/vm/va_128TBswitch.c
+++ b/tools/testing/selftests/vm/va_128TBswitch.c
@@ -9,7 +9,7 @@
 #include <sys/mman.h>
 #include <string.h>
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#include "../kselftest.h"
 
 #ifdef __powerpc64__
 #define PAGE_SIZE	(64 << 10)
-- 
2.32.0

