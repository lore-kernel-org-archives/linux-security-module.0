Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5506BC433FE
	for <linux-security-module@archiver.kernel.org>; Fri,  6 May 2022 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443434AbiEFQKv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 May 2022 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443439AbiEFQKs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 May 2022 12:10:48 -0400
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA4B69CCB
        for <linux-security-module@vger.kernel.org>; Fri,  6 May 2022 09:07:01 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS41jJtzMr2ZJ;
        Fri,  6 May 2022 18:07:00 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS36zpTzlhMC1;
        Fri,  6 May 2022 18:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853220;
        bh=kL99cMtumD1QSIju+JYUr1ezJx54p7MQnxDHvS0ug5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7yCdbhtnjRe+nxPNSrDCHTy9c7mQejcD3NxaH0m24ixTY2jesKdu4jlM9gqw6y9A
         kvHQR81mVeCaee/gP/xcdmCOXwKTZ3wfamX9O6Z2uZCyIsbdXaIRPfzQhPQ5eURt+O
         FQ4QVth19fHjMTsFAGQFXPRi+b8KzQWeQ1b5nv9c=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 04/10] selftests/landlock: Add tests for unknown access rights
Date:   Fri,  6 May 2022 18:08:14 +0200
Message-Id: <20220506160820.524344-5-mic@digikod.net>
In-Reply-To: <20220506160820.524344-1-mic@digikod.net>
References: <20220506160820.524344-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make sure that trying to use unknown access rights returns an error.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160820.524344-5-mic@digikod.net
---

Changes since v1:
* Format with clang-format and rebase.
---
 tools/testing/selftests/landlock/fs_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cc7fa7b17578..f293b7e2a1a7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -448,6 +448,22 @@ TEST_F_FORK(layout1, file_access_rights)
 	ASSERT_EQ(0, close(path_beneath.parent_fd));
 }
 
+TEST_F_FORK(layout1, unknown_access_rights)
+{
+	__u64 access_mask;
+
+	for (access_mask = 1ULL << 63; access_mask != ACCESS_LAST;
+	     access_mask >>= 1) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_fs = access_mask,
+		};
+
+		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+						      sizeof(ruleset_attr), 0));
+		ASSERT_EQ(EINVAL, errno);
+	}
+}
+
 static void add_path_beneath(struct __test_metadata *const _metadata,
 			     const int ruleset_fd, const __u64 allowed_access,
 			     const char *const path)
-- 
2.35.1

