Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32276C0729B
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Aug 2023 17:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjHNR2z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Aug 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjHNR2w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Aug 2023 13:28:52 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A401C10DB
        for <linux-security-module@vger.kernel.org>; Mon, 14 Aug 2023 10:28:50 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-99beea69484so268653166b.0
        for <linux-security-module@vger.kernel.org>; Mon, 14 Aug 2023 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034129; x=1692638929;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y+Q4IgcXaw8U/O/rkXVJ7BYtEcI6PYv5gdexTlLSGg=;
        b=76LNTaNIah1o+e6XeFaLssd4uycHXfK97IQH6AHGjHtLoh6b9kde4Ii6a4C8W8la3f
         8+iH3Yy0Hg9ym+ynWn2v63PPJb/Ny+icFkUFYHjL9gtSxEmXzEhztxIoLUfKtywHmUD8
         VnU384WXTthdvxw4yfv5w/VfMAokctotuBPvp0a3p6axWTiv1+QP6rTMF4TU6UeUYp1H
         6tsrJwYyQRFFiH3GCLGJOTOLvSghmDSsyaOQCEBKx7uBb8rC1kAZv6SrsmmxnyVYsUAc
         /7+YEO8WlxlmuHdt0TvV9vz8wEpIymFIwroe5nWKI4afWsnKGyWDRDifb/ZEWAGJsZ1C
         Cx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034129; x=1692638929;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3y+Q4IgcXaw8U/O/rkXVJ7BYtEcI6PYv5gdexTlLSGg=;
        b=SnX6hxnKlW219KHlsMn+XYUpXo6aqkYEDKTA6P6H7jTkuaKfvatxhP2suTeWixJXBY
         mfgz8YA/TvACjK5HjVdr0GN97Em1sbYrdqkXHYdYm/4xVwhCBicEHaWO4y6jxq/9InqH
         ohfGbf/NQxgWoN7MEBByjLmVGDeLuHiOz8OqzDFcDDVOBUYNiQllFN19+kZ1gc6qDzq5
         k7fp+6U+z4SunEDrcqiQonO3P3+to3+grmt3zuD46de4+4BtaeNLFFzCXUhNNlcWvMNb
         6/2Ti1rTQgfVCHgBHs4MXRFu3RlW/frhbzEDYtweMrM8/kEtQHOSWFVs37rU10ZT+zSW
         zm4A==
X-Gm-Message-State: AOJu0YydRtjE+bhiT/8Y4Qzd70nVTVggiNQsPOFWsL1/sjwCi37Vp2Gt
        HjArTjHhrxubN9U6emY5bpBujK8Qg/zOVemPdh1oWp8fY170OXvr8N4EjfWrd9HCTtWHSjipyLB
        4TKc7njjhJYRTMNDLMGG9hK+IaF6+5dIugfcUYEvApnHiXvuatl8zTHvoCx5zSkla/iu7TU5M4v
        aIN4ut/g==
X-Google-Smtp-Source: AGHT+IFW4XpqyjomRR9EPf5Gq+z2WJPB0LttavYHYi6hcS3R6CAGGgvghrTtGhKZZUe5XQ84aS0BgC2gBSo=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9ca9:bbb1:765a:e929])
 (user=gnoack job=sendgmr) by 2002:a17:906:6b4e:b0:99b:ed53:6574 with SMTP id
 o14-20020a1709066b4e00b0099bed536574mr48745ejs.14.1692034129000; Mon, 14 Aug
 2023 10:28:49 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:28:14 +0200
In-Reply-To: <20230814172816.3907299-1-gnoack@google.com>
Message-Id: <20230814172816.3907299-4-gnoack@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Subject: [PATCH v3 3/5] selftests/landlock: Test ioctl with memfds
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

Because the ioctl right is associated with the opened file,
we expect that it will work with files which are opened by means
other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 50 +++++++++++++++-------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 456bd681091d..4eb989d5ff39 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3716,22 +3716,6 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
nt_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
=20
-TEST(memfd_ftruncate)
-{
-	int fd;
-
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
-
-	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
-	 */
-	EXPECT_EQ(0, test_ftruncate(fd));
-
-	ASSERT_EQ(0, close(fd));
-}
-
 /* Invokes the FIOQSIZE ioctl(2) and returns its errno or 0. */
 static int test_fioqsize_ioctl(int fd)
 {
@@ -3742,6 +3726,40 @@ static int test_fioqsize_ioctl(int fd)
 	return 0;
 }
=20
+TEST(memfd_ftruncate_and_ioctl)
+{
+	struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd, i;
+
+	/*
+	 * We exercise the same test both with and without Landlock enabled, to
+	 * ensure that it behaves the same in both cases.
+	 */
+	for (i =3D 0; i < 2; i++) {
+		/* Creates a new memfd. */
+		fd =3D memfd_create("name", MFD_CLOEXEC);
+		ASSERT_LE(0, fd);
+
+		/*
+		 * Checks that operations associated with the opened file
+		 * (ftruncate, ioctl) are permitted on file descriptors that are
+		 * created in ways other than open(2).
+		 */
+		EXPECT_EQ(0, test_ftruncate(fd));
+		EXPECT_EQ(0, test_fioqsize_ioctl(fd));
+
+		ASSERT_EQ(0, close(fd));
+
+		/* Enables Landlock. */
+		ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+		ASSERT_LE(0, ruleset_fd)
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
+}
+
 /*
  * Attempt ioctls on regular files, with file descriptors opened before an=
d
  * after landlocking.
--=20
2.41.0.694.ge786442a9b-goog

