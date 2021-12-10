Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC343C433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Dec 2021 17:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbhLJRhU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbhLJRhM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:12 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DAC061D5E
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:34 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso10311963ots.6
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4WzsD+UFVzLiH0Fp9HCyUMze55/PXfN1Fv5h1c0wwoc=;
        b=Qchokgi1K6EjNENIB16rZTHkLbnhJuZXljqbd4G55iiZmPcNdBVkeVbMowdmC9q4qj
         uM+vvJsP1r/+NUFhjZ04YGOlvj7dYAlIu5fXxMAi7Vp8riHsOdb9yTNfCIZhxOzmilUN
         fYlr3CYWkIhW0u0R7l+00dYGvA8bO+xcWIlrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4WzsD+UFVzLiH0Fp9HCyUMze55/PXfN1Fv5h1c0wwoc=;
        b=Aza+Bf3jCgUkZc0JYqrafr3Q4FSmWvTd54Y/R03zZI+qLojUGHHM6bICJeW6cV8Xn3
         TKN7pBYTYwISJM023ptMKizFBInZgcrPfM9S7vrnBeX7u2bvBVS37v6q+CHSSP4R+otv
         k+SE+ROTS0OBHTFe6NPvDKlP0r6OxpYnHCcdmMWc9suvXVr88x5shZJ92RZoFBnk/2l8
         i+S2G6++dFgVvFCo75i56rpXmkJMDyEl8s/9kgkb+KK/JXAWej/lLqJ57Sbd27jiOeum
         hoHZNd7kPcU9iv9rGLg/zgzF99fwVCzC4dZUpU0dF0FyP8lXzvQ1KOYmBsh3nJk5inJy
         hf6w==
X-Gm-Message-State: AOAM532Hkzbc6K2/bVzwIBmo1qNwvDRWrU7KCVvl3fCuoSOxP8Kytf+F
        YuzCe63EfgoSvSiuJY2GoduYcQ==
X-Google-Smtp-Source: ABdhPJyxsZn85HCQXDC0NYZWNPCIdku6oxp+hW2STbG5C8HyB1dqb+FYA6EOrK7FlkRbQQsZUFS6ug==
X-Received: by 2002:a9d:373:: with SMTP id 106mr12125638otv.127.1639157613531;
        Fri, 10 Dec 2021 09:33:33 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:33 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 08/12] selftests/rseq: remove ARRAY_SIZE define from individual tests
Date:   Fri, 10 Dec 2021 10:33:18 -0700
Message-Id: <f81e953716b03e9eb2392298b914b703dcfdace8.1639156389.git.skhan@linuxfoundation.org>
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

Remove ARRAY_SIZE from rseq tests and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/rseq/basic_percpu_ops_test.c | 3 +--
 tools/testing/selftests/rseq/rseq.c                  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index eb3f6db36d36..b953a52ff706 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -9,10 +9,9 @@
 #include <string.h>
 #include <stddef.h>
 
+#include "../kselftest.h"
 #include "rseq.h"
 
-#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
-
 struct percpu_lock_entry {
 	intptr_t v;
 } __attribute__((aligned(128)));
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 7159eb777fd3..fb440dfca158 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -27,10 +27,9 @@
 #include <signal.h>
 #include <limits.h>
 
+#include "../kselftest.h"
 #include "rseq.h"
 
-#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
-
 __thread volatile struct rseq __rseq_abi = {
 	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
 };
-- 
2.32.0

