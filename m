Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EFDC433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Dec 2021 17:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbhLJRhN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Dec 2021 12:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbhLJRhH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:07 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517DC0617A2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:32 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so10320950otl.8
        for <linux-security-module@vger.kernel.org>; Fri, 10 Dec 2021 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WMqa61IMKQAN9nayBNaET9ogW/1IQBHwCkgxPK83A3s=;
        b=ZiinzdUTAUE4pW3+MikJK5J7ul2KgoWPeStbJcIb4f+ObGuAEAF6SL+SMRMxnX95h2
         iK95itksi/1uauaJqsD/x6K8C5VGuaLthvLoxR2o9n0klTF4wkcseELo0XrgDCp4GWPa
         /qWqBFehtViF2vhi7zRNmscMQ1Z5b/aeYT60o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WMqa61IMKQAN9nayBNaET9ogW/1IQBHwCkgxPK83A3s=;
        b=YvQFzLrZvvuA2Rq7Cv386El3PuxuTuH+XZE2Kzy6+888SJh6BZZ+tM9Mg8ZfHCSiZ1
         34AqCkiAhScBog6po0HpyeNVubhx6qn5jqrrE7vsr7ZTK8NP7irl9X82B+e/AhuYMHIy
         9CO/tFt0bWSAyP1aA5eRh6PSQjBqFaOwaWZ1b70dO726MRTae4iHDDOrPeLw3TNO9EU/
         vNro8D6aZ9F1d0hFLGcqTaVoRG9k0AumADyNC0PU/ABm3sw10J7Si07+uMGe1VPQ6mQ8
         oXUqk9sjo0bkTZvfKhHrc2NdeKcW60Wny015QhVetUTZIQSeoDghqfD9B8hykb+PFZSr
         wLDw==
X-Gm-Message-State: AOAM533IOMXJqsraEYiETNzPHhUt05EX770lVl/Ld+SoyHacHg8BKpZj
        3lJi6bb9U0/B9FvgiFecQbh6EA==
X-Google-Smtp-Source: ABdhPJxs5UyjzAwtor6CH4V3zYGHQWLFyg/yw499Ss2tuG45t4WeD25Up32eMNTOXvKpzS2SfYHVjw==
X-Received: by 2002:a05:6830:1392:: with SMTP id d18mr11833207otq.374.1639157611625;
        Fri, 10 Dec 2021 09:33:31 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:31 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 06/12] selftests/landlock: remove ARRAY_SIZE define from common.h
Date:   Fri, 10 Dec 2021 10:33:16 -0700
Message-Id: <e86b9f3a050a919b90a41e42f369e8945210c2fb.1639156389.git.skhan@linuxfoundation.org>
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

Remove ARRAY_SIZE from common.h and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/landlock/common.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 20e2a9286d71..183b7e8e1b95 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -17,10 +17,6 @@
 
 #include "../kselftest_harness.h"
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 /*
  * TEST_F_FORK() is useful when a test drop privileges but the corresponding
  * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
-- 
2.32.0

