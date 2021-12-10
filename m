Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C907AC433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Dec 2021 17:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244553AbhLJRhZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244537AbhLJRhQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:16 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706CC0698CA
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:37 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso10280786otf.12
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DiZeUVUX8yxJeM10Cpt7v1VvqmpI5eFmoRBxYdddIiM=;
        b=K0OpNOeDoVajb3W4xt0KX7FV9FbcaAXSxNvrA6087bIQw7tap5Xv3ErI4wfxiVZEYz
         M6AfFqilfX8ijAknnwuE2KW46iOXBC7rxJrpuL1JwcedYnpdXUvl2dp2O008xrVpHkp/
         0+YC6YtffxgVuZdSYs9NfFLK09hxHT0eSo2gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiZeUVUX8yxJeM10Cpt7v1VvqmpI5eFmoRBxYdddIiM=;
        b=0MKfLYldIeK4zqVGioiq4AZgC/jXmJi7YHGzRcctIcrvcDgKx7/0U4OBgtoqW1nja6
         /xJNcz+kvrwAQVjyjxgkkSGcKbp5Yc4OD/bZc6EKjUcL0eyXB34A+m7wTOm7OwPYcB9h
         3h2BcK3UBE2tAv6MtZuDZQm84h18EoayU3fxGYUJwYPIyD7cNSmVOIz8Pu9fQhcCack6
         234d38A03Cd9bwADZB5ADnwopUQjSTROXB+JLTLZyqHV0jzZ0/hRRMvenZWOzS6a0bou
         b3T6XocnmgtZTdCUNgh0z+28ilbDFYnd9ImMzN7tuatknxa4kG462FJ1Uz8kkOzkhVLN
         xcfw==
X-Gm-Message-State: AOAM533drE6A6qncP0IuPkMw7r1U/G4f42GwKNb7nu46PTRoFPkVTGPB
        cuAJ+RHxU1tIB5/AQ5tnS+PINg==
X-Google-Smtp-Source: ABdhPJwjEnwr1b7d/xDdJEMULYxeBIxDwb3X/wQaHnBiudTS3BTD6SqME8GwsDGoPjchyNdPyOCytA==
X-Received: by 2002:a05:6830:1e4a:: with SMTP id e10mr12001687otj.58.1639157616590;
        Fri, 10 Dec 2021 09:33:36 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:36 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 11/12] selftests/timens: remove ARRAY_SIZE define from individual tests
Date:   Fri, 10 Dec 2021 10:33:21 -0700
Message-Id: <5837749541102ed658cfae6ab4b68be9f7f96688.1639156389.git.skhan@linuxfoundation.org>
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

Remove ARRAY_SIZE from timens tests and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/timens/procfs.c | 2 --
 tools/testing/selftests/timens/timens.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index f2519154208a..1833ca97eb24 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -24,8 +24,6 @@
 #define DAY_IN_SEC			(60*60*24)
 #define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
 static int child_ns, parent_ns;
 
 static int switch_ns(int fd)
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 52b6a1185f52..387220791a05 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -22,8 +22,6 @@
 #define DAY_IN_SEC			(60*60*24)
 #define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
 struct test_clock {
 	clockid_t id;
 	char *name;
-- 
2.32.0

