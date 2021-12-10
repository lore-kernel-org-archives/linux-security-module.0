Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA217C433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Dec 2021 17:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbhLJRhF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244701AbhLJRhD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:03 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA6C061746
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:28 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s139so14081492oie.13
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Om7A8iJx3nmhRt21+GcSVSh1CLYidC/pJOApyfAW7NA=;
        b=SjV4lPhUdKrmpRTjTbfve+d5B769d3IL84XjeCyYyIxveR1xklcF8EADqlliDHUpYJ
         Frpg+DqzjkTlT32YzOqef4iMfY3Joj/P40H2wHvWyCUffJ0BIvLT3lAq9spBCpTV9VqW
         fhqvSvrGrkeHAyMG2Gr2cDT7Go5Db+PPVzNi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Om7A8iJx3nmhRt21+GcSVSh1CLYidC/pJOApyfAW7NA=;
        b=qUfY/K72+h1+tug3KuuuVUDt67JhssZJFQj+UgfM/NJ3kARA+a0QG4P86UEewXC6Jg
         MPGVHEIDEEJg9maSPfsyxV3mbGnvzig0CEsS/RpjxJWtxmZAeIUnJjIHqQrzrb+LPFaU
         gDW3yaY46wIyxVzoI8BuZdAarXrBrG10qIAXWccbT44n81L3COm4KK8QMPolNGTfgjLi
         LM6eY4ENAx+qla6MWe12vUI7mn2A9CFRBck67gnWXrZFoWGqmJdXwwUshf4P+QFk8AAc
         XWFBKSjkUUd27QbPG0OMNmKWFIgLv9TmRdP6ifsndh8j8H3EQ+YvEp9BFHg7/vi9lDgc
         qYwA==
X-Gm-Message-State: AOAM530mgmMuuYPlXfJB5uFSi+Qh7sCpYV96f1GkQ+t2u69D53b8Uhr0
        WhyQRf8ssVN9WMcTnjM/vVqu/w==
X-Google-Smtp-Source: ABdhPJw1xkTM0IGWbm2xBQvRbX572S/iV1SuoJVNLe1QtOfW6SfMXVYKCvQz8AqfVuAHR9tlpezb4g==
X-Received: by 2002:a05:6808:1a02:: with SMTP id bk2mr13567633oib.52.1639157607755;
        Fri, 10 Dec 2021 09:33:27 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:27 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 02/12] selftests/arm64: remove ARRAY_SIZE define from vec-syscfg.c
Date:   Fri, 10 Dec 2021 10:33:12 -0700
Message-Id: <7f6d7252af5c8efda140b6b5f626b9e5a267016a.1639156389.git.skhan@linuxfoundation.org>
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

Remove ARRAY_SIZE from vec-syscfg.c and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 272b888e018e..c90658811a83 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -21,8 +21,6 @@
 #include "../../kselftest.h"
 #include "rdvl.h"
 
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
-
 #define ARCH_MIN_VL SVE_VL_MIN
 
 struct vec_data {
-- 
2.32.0

