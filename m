Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYqbmgjt"
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B710FC
	for <linux-security-module@vger.kernel.org>; Fri,  1 Dec 2023 06:31:09 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-543d2bc7d9dso1586722a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Dec 2023 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441068; x=1702045868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc2n/IfdN6AW1c9SMxltAzJC+sd6luXorNUWF42eNJ4=;
        b=jYqbmgjtcbwUWr3AdkclsZjv/fdyGWWAlJGMwTdjaOZclKBL9IqxXhe7V8+MeDrqJv
         LEldVWSyZCQKQdkD2KT0B7a5Bvklj5SVKuXqGef3LFs6sKqG5kHynFfiRQaMySH5e/6R
         Xn42na9hA4xfE+UCNzF9D6bFIQjKamiFE0YDGwYKP825yaqtNxNUPG6GXq4si4cwhVVm
         PA82FEJBqQvhULrfCEgkOcAZFFBtTQcLceJu4lSdqKW2udiPFQrOgn7+VjB6NL8cvelg
         KtJczgLC83mKrFEx9hUp6KxQyEbIRYT8QI7gLUrK3r9Nw1NaiM266uJtnvoAB9l9bH0V
         F1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441068; x=1702045868;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zc2n/IfdN6AW1c9SMxltAzJC+sd6luXorNUWF42eNJ4=;
        b=MzLHopdJqw+pWhND8TRYmCOYMgm5A+cKS8MX/b2xoJl1HOoQnQegIlPZ/lxqyr5Luu
         yEEIoQfm6BsvYwTcamV04Fwm9sYrOh9JUHcLFbjbay0Ok9m2ANj9ZueEaCBTYkJJX3ZN
         N0PtfnfsTQrGDUYmXitb755kFO1XNfOHabZWePA0EpHYUlx40mxGS8UK95s6ymtJ1RPN
         38PLg0TJ11rn25lO949GDFyyKiBkC5wyS621+uTVqeDAPpKcRfcamg0mmV2WVYaTzyj4
         KYcNMe8bNwYhVnFHcV+smknZCVwQm/UHrHuBmXowqTmISUvG+4krIyBam531AG6Ja8sV
         1FEg==
X-Gm-Message-State: AOJu0YyYIwQ3BMHOdmZNfJJd0GvGC2bRPfU+Wekd18CaZA11NbbaqgQn
	EMq/y7HQGJJ8YnRbspqDyTrKuWXzJuOXaKtAcb3HsxLQlbUvRQSGbZqwHInZcsPoa+qmVh9BwOG
	s1jJ6MRgSdSrLPiGkulA/pm/fLURyGfZCqtmV+n+7nyPIYvE0R+qD3e3ZsteEUzFevgrVoBMHt7
	p87RKvmQ==
X-Google-Smtp-Source: AGHT+IFxeCHBw3CruXC3y61NsuMJhkBYw4MVKN3Q3KFVsKhCXKArCqmyJx77fkqBX4xWpH429QkvSV73/+o=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:aa7:d7d5:0:b0:54c:557f:e6f2 with SMTP id
 e21-20020aa7d7d5000000b0054c557fe6f2mr18849eds.0.1701441068052; Fri, 01 Dec
 2023 06:31:08 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:40 +0100
In-Reply-To: <20231201143042.3276833-1-gnoack@google.com>
Message-Id: <20231201143042.3276833-8-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 7/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
 with open(O_PATH)
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ioctl(2) and ftruncate(2) operations on files opened with O_PATH
should always return EBADF, independent of the
LANDLOCK_ACCESS_FS_TRUNCATE and LANDLOCK_ACCESS_FS_IOCTL access rights
in that file hierarchy.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index dcc8ed6cc076..89d1e4af6fb2 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3875,6 +3875,46 @@ TEST(memfd_ftruncate_and_ioctl)
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
2.43.0.rc2.451.g8631bc7472-goog

