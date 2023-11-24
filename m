Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iE80bAcd"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D919A8
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db4038d7cfdso1523561276.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700847047; x=1701451847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqKMyUbOjp1pzrjHSa8fjOBv5M/NXQQHG22g8xcIt5c=;
        b=iE80bAcdWmUqdGCeAIH9DKZp/VP3gEeVma9SEwaiQayqkjFdYV7LdGd85ymuBeukDd
         QKhscsbjoQ2UCgyWKLEBkRGc6OCsy7SOPOr6CHffO1IaEHfFN9547l/SRT5K5zxJDt+h
         goEJDQlgkUil/NDJB9n4OZ0sJ4SUxnDOOXBMpzjKpbba23iibVz6HKypmMTB7fuA5Qnf
         V6nO3U40IAEtLFWMm53qnkDDIHovCvb5TSRBJ4nfxTs2iUPktMDZoeMTd/5tCJrzWh1w
         iiHSNW128d7rSYUy+gXGAsMS/7QujIzi6ijBNuRZ1pnvLj1U+aLTI0UcC8lbiLzgBDjb
         jDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847047; x=1701451847;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dqKMyUbOjp1pzrjHSa8fjOBv5M/NXQQHG22g8xcIt5c=;
        b=EBTZU/r8UGO78uhCN+z7jqbrIP90zWsDVBTAxBvekpy8/c3pm3GuHaO5ZgEVq8g8wN
         OQxDnch4yBZtDAmZz5WJn3Wnnzts2/VN8X3K32exnYvqNRFQu7LYjKxZhJ7JoeThXNwA
         2wrsAjIKe8GXilW5zSO0o7K3Ifn/Cz43VKiDuKeRLoJUjcerscdQUQF00J68TepHFGaR
         9RM7RivdpGxPXwwHDqGCCpvfYYlKNuIwMQQJWnJ7MaewTBbe/4wHVkD/EWarRQ2ToEy/
         fu/ILxNbO4kCNWuYQwCQzIJvQKKhF7yg5e5P7NB1X2u+T5bZ0chOxq0lBq4AECqUULTd
         C2AA==
X-Gm-Message-State: AOJu0YyGgEYye4xMnJbJ+kMFTju8g92tkpV9H8VXcwrZhtpi6hkyHrd/
	mWzoR1M6GGXlYiIioGhJPr4A79qKF/0WBS9JmlgmUbJUMS/jCjPmCuBosZ1zdYA2G/8NupKSeki
	vW8xjOdCWDDLztrkNJoIr+we4HNqS62ZWyrcmrffQ8B5yHctGAqamRzmrvY7xnNmiFCpfFYeXhH
	3A3D5fRw==
X-Google-Smtp-Source: AGHT+IEGMBW4lWTYeutsfau0rPAmfoob6PRsHdbStM7KPd/olF/IzC5pNmhu2qVF/mWoVcLTZZ9OU6RLy4w=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a25:e482:0:b0:d9a:42b5:d160 with SMTP id
 b124-20020a25e482000000b00d9a42b5d160mr103762ybh.10.1700847046654; Fri, 24
 Nov 2023 09:30:46 -0800 (PST)
Date: Fri, 24 Nov 2023 18:30:23 +0100
In-Reply-To: <20231124173026.3257122-1-gnoack@google.com>
Message-Id: <20231124173026.3257122-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v6 6/9] selftests/landlock: Test IOCTL with memfds
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

Because the LANDLOCK_ACCESS_FS_IOCTL right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 94f54a61e508..734647f86564 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3780,20 +3780,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
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

