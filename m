Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D690BC04E69
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Aug 2023 17:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjHNR2y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Aug 2023 13:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjHNR2s (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Aug 2023 13:28:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FCF10DD
        for <linux-security-module@vger.kernel.org>; Mon, 14 Aug 2023 10:28:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942667393so66747597b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 14 Aug 2023 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034127; x=1692638927;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WtvUIdGkzX23JX/YHq7vqp/GHfdIGhzgpFpFAQBHX0=;
        b=LOerCmETGzBdbO/XQpzvs8FA03LvnAh5hvSc9iUuao6yCQxnXRB1Hk8ouJl3YGrUp5
         m7gVsW4y+6svba7DF2zPWTCxsMp/HhU6vs+SRbpo5BmugRRrkF35Ie4reFuXoZvai3B7
         uMZwxcaT5hxdoYypmbXt5fyWot1t2W3JmSHkqMRFSWfnFeKQaL58MdKbG/IEbUbqxtD6
         k87WmkUgtXVMsPizNinCosipYccAgn5WJKr1NA3FjqR8n6MRNdhu95Xx+EatjRbeGcv7
         iTwrRMNn2irm6Nijc5/86zIbp9+LwIdzCb32JkMsS4eGmbfa6AXY5i0iZ6i8Zf1Fgm+0
         +EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034127; x=1692638927;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/WtvUIdGkzX23JX/YHq7vqp/GHfdIGhzgpFpFAQBHX0=;
        b=j8doqbbFnERqAJKy43sGVzrzvIxAB3VgDOIGBIk+yvwRrYkoq++nsdDbB+9jjztKXT
         K58ovpUK5kuPosbZ5EJubhrjG0ammxl/MAAPvy+QDQANsIFfOeBLqS96IhlevqlJFyfr
         O8zio0ssfOr39MWrDhin5SOAXYUDoY+DaiNTd4mU6uriNK7NKK806HP5OIzpTFGunB6g
         3uHO6zm7+HlHNsvksu6MRq9NZqHn1rbFtbgX84nVzpfBtn8EAq7RcESdbxzL9t+VKefI
         /I/CL3N5QAQ+5F9OinxGfEtHSzbCd1Hl4TyI5uEqbjP0XISI35TdeRbTMsDZ7DbYa065
         jcYQ==
X-Gm-Message-State: AOJu0Yz3gzfxl/oV1Zrxzow1FNDHbMkDOWCpzNgWP0bhkDhkNt9zad1i
        +xpyDOTv3ShBROSOUyOW/sLTAfxhEIV5pWmeFnpvltpOwcoEu+WNs2+OXRyFD6fftT7N1uUSY09
        lQnNfU4Q22WruRwMLRlKrpOzRuhUc0un8CnOOM+onTkEPDOFHer+lqam2GLoBIzFuyvvl50XiT8
        vPW2xuzg==
X-Google-Smtp-Source: AGHT+IG19zvmZEkIlqv5EFl1D+B1zLaR7MtRp+mouvPIuY0XBo+TEsPB2oggohyn3O+q/wVu3sA+yy8obMw=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9ca9:bbb1:765a:e929])
 (user=gnoack job=sendgmr) by 2002:a81:ac23:0:b0:570:b1:ca37 with SMTP id
 k35-20020a81ac23000000b0057000b1ca37mr158065ywh.5.1692034126344; Mon, 14 Aug
 2023 10:28:46 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:28:13 +0200
In-Reply-To: <20230814172816.3907299-1-gnoack@google.com>
Message-Id: <20230814172816.3907299-3-gnoack@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Subject: [PATCH v3 2/5] selftests/landlock: Test ioctl support
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

Exercises Landlock's IOCTL feature: If the LANDLOCK_ACCESS_FS_IOCTL
right is restricted, the use of IOCTL fails with a freshly opened
file.

Irrespective of the LANDLOCK_ACCESS_FS_IOCTL right, IOCTL continues to
work with a selected set of known harmless IOCTL commands.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 96 +++++++++++++++++++++-
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 09dd1eaac8a9..456bd681091d 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3329,7 +3329,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
 			      LANDLOCK_ACCESS_FS_WRITE_FILE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3412,7 +3412,7 @@ TEST_F_FORK(layout1, truncate)
 			      LANDLOCK_ACCESS_FS_TRUNCATE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3639,7 +3639,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	};
 	int fd, ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -3732,6 +3732,96 @@ TEST(memfd_ftruncate)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/* Invokes the FIOQSIZE ioctl(2) and returns its errno or 0. */
+static int test_fioqsize_ioctl(int fd)
+{
+	loff_t size;
+
+	if (ioctl(fd, FIOQSIZE, &size) < 0)
+		return errno;
+	return 0;
+}
+
+/*
+ * Attempt ioctls on regular files, with file descriptors opened before an=
d
+ * after landlocking.
+ */
+TEST_F_FORK(layout1, ioctl)
+{
+	const struct rule rules[] =3D {
+		{
+			.path =3D file1_s1d1,
+			.access =3D LANDLOCK_ACCESS_FS_IOCTL,
+		},
+		{
+			.path =3D dir_s2d1,
+			.access =3D LANDLOCK_ACCESS_FS_IOCTL,
+		},
+		{},
+	};
+	const __u64 handled =3D LANDLOCK_ACCESS_FS_IOCTL;
+	int ruleset_fd;
+	int dir_s1d1_fd, file1_s1d1_fd, dir_s2d1_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	dir_s1d1_fd =3D open(dir_s1d1, O_RDONLY);
+	ASSERT_LE(0, dir_s1d1_fd);
+	file1_s1d1_fd =3D open(file1_s1d1, O_RDONLY);
+	ASSERT_LE(0, file1_s1d1_fd);
+	dir_s2d1_fd =3D open(dir_s2d1, O_RDONLY);
+	ASSERT_LE(0, dir_s2d1_fd);
+
+	/*
+	 * Checks that FIOQSIZE works on files where LANDLOCK_ACCESS_FS_IOCTL is
+	 * permitted.
+	 */
+	EXPECT_EQ(EACCES, test_fioqsize_ioctl(dir_s1d1_fd));
+	EXPECT_EQ(0, test_fioqsize_ioctl(file1_s1d1_fd));
+	EXPECT_EQ(0, test_fioqsize_ioctl(dir_s2d1_fd));
+
+	/* Closes all file descriptors. */
+	ASSERT_EQ(0, close(dir_s1d1_fd));
+	ASSERT_EQ(0, close(file1_s1d1_fd));
+	ASSERT_EQ(0, close(dir_s2d1_fd));
+}
+
+TEST_F_FORK(layout1, ioctl_always_allowed)
+{
+	struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL,
+	};
+	int ruleset_fd, fd;
+	int flag =3D 0;
+	int n;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	fd =3D open(file1_s1d1, O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	/* Checks that the restrictable FIOQSIZE is restricted. */
+	EXPECT_EQ(EACCES, test_fioqsize_ioctl(fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIONREAD, &n));
+	EXPECT_EQ(0, n);
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.41.0.694.ge786442a9b-goog

