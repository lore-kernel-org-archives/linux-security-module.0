Return-Path: <SRS0=J6Hd=6T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EF5C47256
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 10:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017E120721
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 10:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ogl9bS0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgEEK1b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 May 2020 06:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728822AbgEEK1a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 May 2020 06:27:30 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD4C061A10
        for <linux-security-module@vger.kernel.org>; Tue,  5 May 2020 03:27:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a4so900311lfh.12
        for <linux-security-module@vger.kernel.org>; Tue, 05 May 2020 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1n6Cfn9T8YCEV6dpjNIVgTHrosueglFJqXjbboo9a8g=;
        b=Ogl9bS0ze7bvZClDL882hNRrW4mzKPxFGP2s0fltIPLqv9XaBJNvVnuXpwJfGQH/6a
         kkjxls2iJijFrKE2K6SSEveB/q4gKUDs4/TMxreRYN6KTkgwCIbINZBvboXv2fFOOzRU
         f4K9Qu8ek8smsPpbIRHKa3bFN7zgNUBouxESS7JkrluwMwJFsaEr4BfYrF16/VT0iVgr
         xpBKAHORARUj+lFmoOOgh7b7bdvzcG6qWvkLzrHH9661/fbSKnCTddzEKmWoUpihIxI0
         Y1mJycyBwQLzDLmH1OP/NPEoHDNe0GMmWeif9/x4M559YJPQ/5C7E2wMZMJfT6iBRbY1
         fLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1n6Cfn9T8YCEV6dpjNIVgTHrosueglFJqXjbboo9a8g=;
        b=X7qJ4829+gN19/8c2ngugpE7XJN/KEGewtBnVmNhIB0xuu43xRkcAuCxjXheOiTDxe
         AOIzatz1b7p7edtgS8YwXEIpg0pAPLGRLXlw8kcQr8VJ4fGs7wEdOKvBBil9d7xtuZx3
         FTcAt/YOK288TqDTAsSdY9TW+6uKHoiuiIAlGDnYo+sZo3ny0n65oWStdUenYryK/ASa
         aK1az38vsIhXTPLqVU3pFbbxdypY3iSu/f2dGbXxAuGgSYy/D0U25IiqnVhbjJAo8UQz
         DDjN9sOipGlqWvBpdQH27H2zFS1DZSvCSOWyhYzw5L6QLLTkL/Jji/AMJMQ1QxKmpMh3
         lUxw==
X-Gm-Message-State: AGi0PuYrffXmler/kC8Hqj14BRI9pNiwjWYcgdIDeXq7gyF8LojgrJIG
        O0cV15cHnp5npznHa1I6A7nT/A==
X-Google-Smtp-Source: APiQypJ05S+8D6hCUKWWxXYjCtPUKhk7oai+ye/tyDqNidiPXly4f7vFf1vHOjA/N1XK92kKFf4bfw==
X-Received: by 2002:ac2:43c7:: with SMTP id u7mr1256634lfl.50.1588674448320;
        Tue, 05 May 2020 03:27:28 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id 7sm1592575lfr.52.2020.05.05.03.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:27:27 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        brendanhiggins@google.com, =linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        elver@google.com, davidgow@google.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 5/6] fs: ext4: default KUNIT_* fragments to KUNIT_RUN_ALL
Date:   Tue,  5 May 2020 12:27:23 +0200
Message-Id: <20200505102723.8120-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
someone wants that even though KUNIT_RUN_ALL is enabled.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 fs/ext4/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 2a592e38cdfe..76785143259d 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -103,9 +103,10 @@ config EXT4_DEBUG
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
 
 config EXT4_KUNIT_TESTS
-	tristate "KUnit tests for ext4"
+	tristate "KUnit tests for ext4" if !KUNIT_RUN_ALL
 	select EXT4_FS
 	depends on KUNIT
+	default KUNIT_RUN_ALL
 	help
 	  This builds the ext4 KUnit tests.
 
-- 
2.20.1

