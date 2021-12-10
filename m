Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E9FC4167D
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Dec 2021 17:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbhLJRhG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244746AbhLJRhE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:04 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59314C0617A1
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:29 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so10320992otj.7
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk7892EwBeQtmWfsZIAYujFfNQTmGWtEjgsjRv69+2g=;
        b=cLDJy7RNXkPVErf7+3pf0+bZ3jiuNMCjfkw3gOiwUaBeQdzuD8ZZ1Uyk7KdyZ6E3xp
         RKmfI7bq+6mGVljth/QC8Cfr74lIcmqnuNiEg9nlkAeFPl9jwYm93xx09FxNLnzAS3md
         xU6p7pqzKYbFQQDoiFq/PwNxoFT6afSbfUla4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk7892EwBeQtmWfsZIAYujFfNQTmGWtEjgsjRv69+2g=;
        b=pDQ7lcW0DbCO4NEcubf+P43KmUFTpiGYmv85TFwpzGq1rEGIDpW2esYwLx0DLZGjRR
         H+tiy55nSroaZFU1PtPRll63btrrAPeADU3GQwdI90TExP4t+EWx5DqsGKaK3+HQ5dFH
         WsZtAuCRppn39j4mVG2leXYfA/6ysJ8Dj3QgCf6CA/gY4o47RR3R/faTHvIHogc5ef6/
         Zw+YblJ8kBxsee7yV9MpCDyH5tou7eDADaLzXpTpM9tnxzTtH9+mVOu28JwCI8uePLM3
         nkLf47mZ5Cl7OL6c7zNKCO6Y4H1UAWMLZRdUzVk5RJoXwGYV/7hP7dVcuAPPYbJBrMnX
         ryig==
X-Gm-Message-State: AOAM5325h9H/rW8/wzimUO5P5XquWlgWSkKrb5XlQ6SzfVpb9TaJNmuB
        kH72Rv+M9/QqjcEOSdk+VW42vA==
X-Google-Smtp-Source: ABdhPJy8XksdNtBxn0PbE6EqXjHVZ9t/h8g8/JvDVwy45IUv5fD/F1510mJLv+/gSB4O0/zZ2hb6RA==
X-Received: by 2002:a05:6830:4391:: with SMTP id s17mr12125024otv.118.1639157608654;
        Fri, 10 Dec 2021 09:33:28 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:28 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 03/12] selftests/cgroup: remove ARRAY_SIZE define from cgroup_util.h
Date:   Fri, 10 Dec 2021 10:33:13 -0700
Message-Id: <093209c9eb91462a6d9d0080112379c78d18a33c.1639156389.git.skhan@linuxfoundation.org>
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

Remove ARRAY_SIZE from cgroup_util.h and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/cgroup/cgroup_util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 82e59cdf16e7..4f66d10626d2 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -2,9 +2,9 @@
 #include <stdbool.h>
 #include <stdlib.h>
 
-#define PAGE_SIZE 4096
+#include "../kselftest.h"
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#define PAGE_SIZE 4096
 
 #define MB(x) (x << 20)
 
-- 
2.32.0

