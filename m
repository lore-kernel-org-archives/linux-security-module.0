Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3FBEB64DD
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Jun 2023 14:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjFWOoJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjFWOoE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jun 2023 10:44:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FEB1BD6
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd5059e5347so4309923276.0
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687531418; x=1690123418;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/UqCyxOi6pEB3p/clvC6xeYuOhn2xyeOxUnD9vu6fo=;
        b=53rKp8DijAsW4TqdCjoN2CvS+aiuSzosjOmYzfruYzsQfwHMUSVtNTUgMs8U1bvdnR
         F8bMluZYKh2cagi7HXdZ6G5i6i7fBbBcko7hiUFiXKrOU90/44YvEx4xXzl5VNLdGnQK
         Zx0UH4rcXvFN03Bzbp2UUWngVzHKJqg9Qa+mAm0l38jBZjVuRuhxCe3XhHvgTXslGzIN
         hWIhC2FDKKNA8aQaqVO/XbfSWc/IUIzgUuF0c8QlTZbpdp9xw76yD5mbFhpVSSDplR7D
         IyMK/Beuu8CO5Ok7Rgmap0dbrAjHmwRWgrPkJ/u1jiDMBg1AzXpqYp3YY1ul9qnGdrwU
         FH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531418; x=1690123418;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/UqCyxOi6pEB3p/clvC6xeYuOhn2xyeOxUnD9vu6fo=;
        b=kU0ZEEoTXWGuKtkDo02K/+5qAYIlCZIVXgZ/HTxXce8xi77tI7OyYRa06YZqNJ9cdC
         LxGgIubFzX2nKnJR4CYOvCbRLiDGZDHQUw8zvjCi3Ckcpvm3ShPV04HXqIi4fb5yIB9b
         b3+ZmKtYrHAydxTdOv9thCSBPiWvaPAPgpy8MoOi6Cisrzd2CpftEOTGAYTMsNK6ye9x
         grTGUjJ1QfyFDiRXmFHArcuRrwrxRNwi5CHfAzXj2DT17ZGTqDhjfYvdKOxdAmoYYFQ9
         Pb2Wa8WaxLEA+8cJ1/Z8AAtkJVw+HaYTnm0b53hbR0VWgvD0VKS2N0FU6eGLhBpqz/jU
         7LWg==
X-Gm-Message-State: AC+VfDyzgjqG7OALms+Tzjd5U/fyjSpFQkiJb/KGWiZmlkOYuOS+MFAh
        Vp0comPP+qQLNW0OKnd7I2EO/nYP0lAwSqVLfZkd4242fQFP9F/2S0Xu3eKOeKncAhS3MOnnOEC
        kaO+AVw6bbpsftrHTAwJ9C9YjJwqVsc4bjQe/k3Ao6LqG3GQ2CaaFQdQjxazlO30ZBTgpuKsAHR
        /haLDj3w==
X-Google-Smtp-Source: ACHHUZ64N3w6ZZi29DfV91ESEl4ZVypB3pvaFdMa1FuMx2QW8kAHMBMdRLl+WH+5BU1teFxsX/KIqwrFPNY=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8b55:dee0:6991:c318])
 (user=gnoack job=sendgmr) by 2002:a05:6902:561:b0:bad:2b06:da3 with SMTP id
 a1-20020a056902056100b00bad2b060da3mr9361801ybt.3.1687531418465; Fri, 23 Jun
 2023 07:43:38 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:43:24 +0200
In-Reply-To: <20230623144329.136541-1-gnoack@google.com>
Message-Id: <20230623144329.136541-2-gnoack@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 1/6] landlock: Increment Landlock ABI version to 4
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Increment the Landlock ABI version in preparation for the ioctl
feature.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/syscalls.c                 | 2 +-
 tools/testing/selftests/landlock/base_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 245cc650a4dc..c70fc9e6fe9e 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops =3D {
 	.write =3D fop_dummy_write,
 };
=20
-#define LANDLOCK_ABI_VERSION 3
+#define LANDLOCK_ABI_VERSION 4
=20
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 792c3f0a59b4..646f778dfb1e 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr =3D {
 		.handled_access_fs =3D LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
=20
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
--=20
2.41.0.162.gfafddb0af9-goog

