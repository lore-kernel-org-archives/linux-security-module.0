Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE58C4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Oct 2022 20:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJSUF6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Oct 2022 16:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJSUF5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Oct 2022 16:05:57 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6123D18DA86
        for <linux-security-module@vger.kernel.org>; Wed, 19 Oct 2022 13:05:52 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Mt1v13XXkzMq4cH;
        Wed, 19 Oct 2022 22:05:49 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Mt1v06dk9zxH;
        Wed, 19 Oct 2022 22:05:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1666209949;
        bh=dLhBf8o1kXqp6sscAfSz5LKvdc7yEb7Q8TYdJPkHjFU=;
        h=From:To:Cc:Subject:Date:From;
        b=AoGSdmPF2lFsibBkqhvB5eYH60CouLgJ8QYefj+ta77rUi4JMemlGJVAt8EPpPaCk
         P+tS6NSCCXlNSCOxMpSJa4uhMtesUp5+kVEmXqiUFqIhu0KYl9/3fEoekhY7JwKyEr
         r1uI/wobcxe+Eb9kYM0tZ2vS3YpOOh+RzjhTgB6U=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v1] selftests/landlock: Build without static libraries
Date:   Wed, 19 Oct 2022 22:05:36 +0200
Message-Id: <20221019200536.2771316-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The only (forced) static test binary doesn't depend on libcap.  Because
using -lcap on systems that don't have such static library would fail
(e.g. on Arch Linux), let's be more specific and require only dynamic
libcap linking.

Fixes: a52540522c95 ("selftests/landlock: Fix out-of-tree builds")
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Guillaume Tucker <guillaume.tucker@collabora.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20221019200536.2771316-1-mic@digikod.net
---
 tools/testing/selftests/landlock/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index 6632bfff486b..348e2dbdb4e0 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -3,7 +3,6 @@
 # First run: make -C ../../../.. headers_install
 
 CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
-LDLIBS += -lcap
 
 LOCAL_HDRS += common.h
 
@@ -13,10 +12,12 @@ TEST_GEN_PROGS := $(src_test:.c=)
 
 TEST_GEN_PROGS_EXTENDED := true
 
-# Static linking for short targets:
+# Short targets:
+$(TEST_GEN_PROGS): LDLIBS += -lcap
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
 
 include ../lib.mk
 
-# Static linking for targets with $(OUTPUT)/ prefix:
+# Targets with $(OUTPUT)/ prefix:
+$(TEST_GEN_PROGS): LDLIBS += -lcap
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.37.2

