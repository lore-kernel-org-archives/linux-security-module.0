Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0DFC197A0
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Nov 2023 15:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjKQPtt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Nov 2023 10:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjKQPts (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Nov 2023 10:49:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF8D73
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03c5ae220so2781074276.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700236184; x=1700840984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVfiNRLLXaCEL+LhQgjG8E5NzPHI4yY2YTNPue/a2KY=;
        b=wR9E01D4+2exuwxzMGEffYW0Ri95jPmHkaoajXhji7niVneWRk5kMkAvwOWsYQJGEl
         CdBDXpygfNLiKr9ZRP6vfmPzDAMAEB9Pw2rwh8IrU0aRHtsxXf6PpU+mtC4BlHbscQHH
         JIn/1Z2VuHH24WQR12KaXSNK1jJUP571ESHJQhM0tLtqEnuidzPTu2aXaWsYhHqtB1rl
         TX94nAXOlcwrTV2LTSVqzAn6NZw2jDunXhLfzEUyvgCcl+AIBdsKmbBvL5q1Ct1a/6/f
         Td3unDMnZjuQ85WVZKAjuOLGYvsAxiMHd+QHTIbJ3p+HZOKjttNUf/64g+oOH7i/cDVf
         BDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236184; x=1700840984;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVfiNRLLXaCEL+LhQgjG8E5NzPHI4yY2YTNPue/a2KY=;
        b=D/vypN1hZo6Kx30PMuP0qXmZsMH6pII60yKo1kvZbu1QOvG6ne6JVd5I1zJQdQ1zM9
         ENmhPQ0ID3Nj39nPllpmy/uEjv1sjO0Ln6AOQ8UZV+LIqcWt6kGtqw1yzPbPFCdQ/ebb
         zZLWDx6rG+xBUH4M+wy70z56YJWZopngS+cKjUl7SWvYVHKUoNSVGWtOONPrdSXJB/KW
         fKviLDYVmD6HrASvHXGex10lJ/vX59P3m5HS6jZoDxIWjghI7vUSs+xVkyRYUymDa72l
         WQJRHelBSeLk3VBEe+aZT/6S6uZyXq/v+O8lejT4Vk0XU32m1KjqhptGQicCB2FT8lNs
         poiA==
X-Gm-Message-State: AOJu0YzmhbmPvIKLDjOr+gbSEkxERk+QWFbgG65Gvvp9N0hsjuxqal04
        rhmQXHl7oJ0hFWpw/LbcbRq57an7zLZFvT6j9qoeTLZrnWiEW+z0fSIFR2aIlgkWa9ta4q0hOdh
        KDvyzbOBzPphhc+glasCgwNHZFFfyZPxmFPydUHqmz7Vpvdj5MWt9tUXGDxXglNTD28V5kdaDH+
        xp5olWmg==
X-Google-Smtp-Source: AGHT+IEI3z/RH1E68bidknSmyhsPGyeGT1Vkbj4du3rsWCUR+flN2mzzjzVW3Y3UGFKrW2SRoAVTYk/mUlA=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a05:6902:150f:b0:d89:42d7:e72d with SMTP id
 q15-20020a056902150f00b00d8942d7e72dmr188428ybu.3.1700236184430; Fri, 17 Nov
 2023 07:49:44 -0800 (PST)
Date:   Fri, 17 Nov 2023 16:49:18 +0100
In-Reply-To: <20231117154920.1706371-1-gnoack@google.com>
Message-Id: <20231117154920.1706371-6-gnoack@google.com>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v5 5/7] selftests/landlock: Test ioctl(2) and ftruncate(2)
 with open(O_PATH)
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

ioctl(2) and ftruncate(2) operations on files opened with O_PATH
should always return EBADF, independent of the
LANDLOCK_ACCESS_FS_TRUNCATE and LANDLOCK_ACCESS_FS_IOCTL access rights
in that file hierarchy.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 8a244c9cd030..06c47c816c51 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3812,6 +3812,46 @@ TEST(memfd_ftruncate_and_ioctl)
 	}
 }
=20
+TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
+{
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd;
+
+	/*
+	 * Checks that for files opened with O_PATH, both ioctl(2) and
+	 * ftruncate(2) yield EBADF, as it is documented in open(2) for the
+	 * O_PATH flag.
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks that after enabling Landlock,
+	 * - the file can still be opened with O_PATH
+	 * - both ioctl and truncate still yield EBADF (not EACCES).
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
 /* clang-format on */
--=20
2.43.0.rc1.413.gea7ed67945-goog

