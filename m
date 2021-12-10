Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14517C433EF
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Dec 2021 17:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbhLJRhH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbhLJRhG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:06 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E9C0617A1
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:31 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so10335015otl.3
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uh/Z9FDGr3qAAzEx+UXrnnj7QMHTF1v60adwa/WDWsE=;
        b=QvxE5B8BPn73UwnQSq14JPyQUVNaNUdzJIk09czGGhqGyoNq67Gtxk3CzYxR01hbht
         xtbSOHY32W87o9On8opuVK6zWIF+ANh7V/TPVN/bXzmOht/nwv8Fe+7n2kGi6lBbGAX0
         4aIaRtWSG8tsp1iF8NMv6Vq3Ozl9ooZRMar7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uh/Z9FDGr3qAAzEx+UXrnnj7QMHTF1v60adwa/WDWsE=;
        b=vk8yWX8fC2dcTaUbfYVcQoyt4CuC22nFCiOxiuNtZjpl9Ub+3XAqwsqoCBXEi7d1o2
         zUMjh3O4/XhjzuAsodgL2bCq/SiHsDPuze/k0CxrJtWTQ3qHVvYlCL1TnsD5AdfTZtBh
         5lheaLHKGvVdq5ZvGeNyqSnqg7tS4l28eURKRCSf5X14mJs7cKjCYreYm1aJ9F6GaAf3
         iJIfkq3qDo7opIUBw3ekl0gQgGGL56OuZz/QTg0XoyJUf/o7g1B/mAUp1YEMIzSPsvHs
         OuT3oZ1/Ze6xdhE59wTJ2J5C9L43Xa050s6j/SEuuQn3VxvwqCeFFiOQ08bZe4dlzg9s
         NqoA==
X-Gm-Message-State: AOAM532Z61u02AvfnFnR5maHJdlAh9X71+LJMkt+/eE1Yo/ka8ODjUnH
        P2SSzOK7aUmlNeue3hRMmbVfMA==
X-Google-Smtp-Source: ABdhPJx4YSaRrvZVxbri/pWyy+QD/g1KBhe+XS0kuK/s8ZRC/VWuwyewAD6/3CwmIMT4Ovj4Oe4jIQ==
X-Received: by 2002:a9d:8c2:: with SMTP id 60mr12177010otf.174.1639157610565;
        Fri, 10 Dec 2021 09:33:30 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:30 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 05/12] selftests/ir: remove ARRAY_SIZE define from ir_loopback.c
Date:   Fri, 10 Dec 2021 10:33:15 -0700
Message-Id: <019379a12759bf5b3f14cf66c5e8742cc71bced3.1639156389.git.skhan@linuxfoundation.org>
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

Remove ARRAY_SIZE from ir_loopback.c and pickup the one defined
in kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/ir/ir_loopback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index af7f9c7d59bc..06256c96df12 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -26,7 +26,6 @@
 #include "../kselftest.h"
 
 #define TEST_SCANCODES	10
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define SYSFS_PATH_MAX 256
 #define DNAME_PATH_MAX 256
 
-- 
2.32.0

