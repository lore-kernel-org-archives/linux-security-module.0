Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D52C47071
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Nov 2023 15:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjKQPts (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Nov 2023 10:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjKQPts (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Nov 2023 10:49:48 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AEDD57
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:43 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-54366567af4so2696082a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700236181; x=1700840981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6FpLrL6T5sRQ7ploFHr8tXpmBKeFm0JWqOkKrwN4Ms=;
        b=JfxSqnEsZGgCghLTgYFBJvjPQC5e3IMJl/l811SUmgkug3XiQ2yKWKVSuUBP3+ynpO
         t3stzFyvb+qOJHTccBRhiXxv7wyrywvV+mjtzsa2j31NnWTSZz6jbcbczXA7nniM/Pnw
         0gJvMrW3SKrissKXVUAwrNZaNRR/AmQNxJtDh0hmB4LLFcmSkp/qEw6dHN8QpDa1LY7R
         L5pCdtynJi2Nz36paktZ5+Iry58tA3gTZ0APFeXeKM6zb4NfNPuN6qPTeZcnw9Pono8w
         tMb5x5yQ8pEYJAtQVZA+B8FA5UX0icD6isqmdom/semMEfz54OYWhSqdRhkLjUzvINTJ
         eOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236181; x=1700840981;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y6FpLrL6T5sRQ7ploFHr8tXpmBKeFm0JWqOkKrwN4Ms=;
        b=lbP3WvKPLBFMUjQnRJXazwgJxPI1/uJxAZ7aFWY6l9vJkJJC02RZ6NvgbGWFNQ4NwI
         X1xAXA7FhGc5+5kz0Q8uIZOa8Fy97kT3DbLl0zlLk7bUVtN2+UWPHWbwKk5RVDs0KI3c
         DaYxUMNzm0wWnTBkjfaRXqWs5mWJLkUx6QCtdXjZxKJjZ4j7eFH9t0HJh+CJCc4QbJhu
         2L+l/XyY2p2wCF0YaRDNl5Wxdn9INepADrneAC1RMQ5msFX9PlVALO2HUq6eNULESJJn
         sTRB2TqfVknV3Ul2maQ/kVCp5Zl7lHHzVjr9lQgGqv4jqP/qi5Tmgyuhywih6eIRdIFH
         ocMg==
X-Gm-Message-State: AOJu0Ywqd9XOtXdREFWW0Z0JQf7cZwAxhGpMfLbFYnfqmZFdOEJ6q9yE
        gJmmBlMQ0QZkChEM1lxTdVa138WA11pc5xw1I1i7MrIb5lctcXi+ImwyDJ0wSeM+IRRWhre5Bmd
        CGzYBaEj535R9/Xxi5i7FNiCM1o8Uy5/KyY7PgkMN3+rvxrUsNdVcUdN1j0Mo+xatFitf6Ssg+M
        yrjyQ/Fg==
X-Google-Smtp-Source: AGHT+IEbEUjzfqSnZbAg03Yz0uZfLr/h52QSsON79DRqm6yi857P5FdhGyVrzYtr1m6Hyro0gTS5Z8uRbAI=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a05:6402:5004:b0:53f:a289:4542 with SMTP id
 p4-20020a056402500400b0053fa2894542mr88139eda.3.1700236181316; Fri, 17 Nov
 2023 07:49:41 -0800 (PST)
Date:   Fri, 17 Nov 2023 16:49:17 +0100
In-Reply-To: <20231117154920.1706371-1-gnoack@google.com>
Message-Id: <20231117154920.1706371-5-gnoack@google.com>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v5 4/7] selftests/landlock: Test IOCTL with memfds
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Because the LANDLOCK_ACCESS_FS_IOCTL right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 564e73087e08..8a244c9cd030 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3778,20 +3778,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
 	return 0;
 }
=20
-TEST(memfd_ftruncate)
+TEST(memfd_ftruncate_and_ioctl)
 {
-	int fd;
-
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd, i;
=20
 	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
+	 * We exercise the same test both with and without Landlock enabled, to
+	 * ensure that it behaves the same in both cases.
 	 */
-	EXPECT_EQ(0, test_ftruncate(fd));
+	for (i =3D 0; i < 2; i++) {
+		/* Creates a new memfd. */
+		fd =3D memfd_create("name", MFD_CLOEXEC);
+		ASSERT_LE(0, fd);
=20
-	ASSERT_EQ(0, close(fd));
+		/*
+		 * Checks that operations associated with the opened file
+		 * (ftruncate, ioctl) are permitted on file descriptors that are
+		 * created in ways other than open(2).
+		 */
+		EXPECT_EQ(0, test_ftruncate(fd));
+		EXPECT_EQ(0, test_fs_ioc_getflags_ioctl(fd));
+
+		ASSERT_EQ(0, close(fd));
+
+		/* Enables Landlock. */
+		ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
 }
=20
 /* clang-format off */
--=20
2.43.0.rc1.413.gea7ed67945-goog

