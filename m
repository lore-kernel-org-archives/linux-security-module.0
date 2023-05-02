Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CEDC77B7E
	for <linux-security-module@archiver.kernel.org>; Tue,  2 May 2023 17:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjEBRSM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 May 2023 13:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjEBRSL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 May 2023 13:18:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3F1700
        for <linux-security-module@vger.kernel.org>; Tue,  2 May 2023 10:18:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f20215fa70so26949875e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 May 2023 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683047881; x=1685639881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K1bnKuWYHqxbRlOxJJGQFetbQIj2EsjF7Ail6vx8I8=;
        b=ddfs1GGQ6UuM0jIgPqjBkeDXsgzwuIBBGw2tF3qV4yjGuTzxU4habl4BucQ28cO6N4
         kyFi7geTaJ+D3w9iIvcHHXpXaohFeSfHIENJWyGXWSrYji80AJSfKbFhcgbrNX/+V+ZS
         JLC0UsofrVrg8/bMl6hKYHykXdIPtb647YU7U0U2h6x7M1RAb7pzega5tyYXWYcWnIfx
         EGibNKMKyh1jlT4yalOKl7YvHCNpFC3Ur5ZpOJ4cWki2XbZMUpr0ybyhiIjuezsnsUBE
         3Cvur17fJm/E6P21ApSSo/kISIwlqqYguWx9V7pouwBRBnPflHWU4EcfBij8ZKLgENbd
         5IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683047881; x=1685639881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K1bnKuWYHqxbRlOxJJGQFetbQIj2EsjF7Ail6vx8I8=;
        b=hbJArP8eWhs4S0M2Wy7W8MaVJzFOCwHkqq0u3WUZ8NWPerXBhciwmXDinApr+oTUKc
         brdRoewzow6WhK3xEnof7GbO71sXeyJHIFmYer7rRa5jkBxjEaPHE6keHda1dsiFuSqj
         G26pGJSzAnAfGsfVcvHRvzyiN3TZVJDWDctMt2rHU7MbiHn2X6zNg+NVP961JdVFkPGi
         /VT173NT4lYm92BV0xJSrIEmZ/ONPu7uvmsOLaz3eGvx9i3HfSYV+eDEzNVTcDNAkdju
         eZkHRNvWkeWRudEWaeQLPCYGNnEdUNLUBTgKVP8ThTcp4srGJFYZUwBbeN+sIK53agbL
         kuIg==
X-Gm-Message-State: AC+VfDydHGEdwLJ2OPrEcLpltcjoguPu5mTt1L40BRAJy5NyvXmhDKQg
        VdYymt/bu0dwfJF3ATUfZ2Uc5kq/MRM=
X-Google-Smtp-Source: ACHHUZ4MBS2z5ZxE4wZPYM+T17dP6HlZKz+UJDhMlt8WJz4l/VmLj7tAPxrISgpT5xgp4kAMXEHkuA==
X-Received: by 2002:a05:6000:124b:b0:306:31b7:abe4 with SMTP id j11-20020a056000124b00b0030631b7abe4mr4356796wrx.14.1683047880843;
        Tue, 02 May 2023 10:18:00 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id i6-20020a5d6306000000b002fed865c55esm31507763wru.56.2023.05.02.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:18:00 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: [RFC 1/4] landlock: Increment Landlock ABI version to 4
Date:   Tue,  2 May 2023 19:17:52 +0200
Message-Id: <20230502171755.9788-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502171755.9788-1-gnoack3000@gmail.com>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Increment the Landlock ABI version in preparation for the ioctl
feature.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/syscalls.c                 | 2 +-
 tools/testing/selftests/landlock/base_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 245cc650a4d..c70fc9e6fe9 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 3
+#define LANDLOCK_ABI_VERSION 4
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 792c3f0a59b..646f778dfb1 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
-- 
2.40.1

