Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CD7EF00
	for <linux-security-module@vger.kernel.org>; Fri,  9 Feb 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498394; cv=none; b=nkjYmwd1qxM3eOuB9IIVJLTvT4tgpObMGnsKZvgyVvP6rzvGKNmSJkjsWSTnkzM+DxdCf8zbLUkLvtvTLYF1bhtR4lWDUMFkw8RioCGrrD5pkzcwApQUbgh/qkmoNLT34VzjUk9mC6Lla5RNyGj9QncEr4sAYt+An3z8sdblwjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498394; c=relaxed/simple;
	bh=ir+nhOodQJZaUi3t0QMO4b+HzJCAUJIFK8BFQmc/sIE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=TtOLWsNoOXwVKxe1r7cJI6j2PgrKjwBHvMhmJLYtY/ljVNM0GL/0KbaZWa2YbOWKJ2BS/TJbBp9VrdJjdQOCsbgsZxUNBhWKYaXGK0GcLL/xTezoqx1QsY96w8H6ql9PhABNNvo90B9TxlvMPTuV235TuJEJkL4/ei8mIHpVKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVzjXZqF; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVzjXZqF"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-560d6fb3b7aso682520a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 09 Feb 2024 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498391; x=1708103191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8bXTZKOf2uP7frXW3XX6UWjY33n1Dc79uBumdx0Eb8=;
        b=HVzjXZqF5vNEJFOAdPupnEgIN1JSVCm7uSgGM8p4tEYXT9SBRryO+8x6XKp+5ewl7S
         i/XjzEwwbntWq4qLOlIepHzZNtr1UuKJ19yfg3k2Uz69JaGWbfb88gMrK4lZyDFatRW4
         5alamRHVYD77uQ6NgXipgZHc2zBvP+/BxenAe593rjhijWb6SZeUb0+zLzOId4oKt/iv
         QaCiW3UxqwZYduagxIdZzptXW6vKjiKt3ZEqSCBnzToHhyAEMLlJHZHg+ZmyQK5XjXJU
         y2dEqNsUwhpLnnGN3ESu+C/GFhnoAebxwmQ/fVYuvWhafXGSLxUVRuebfdhMef9qe/Ra
         JMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498391; x=1708103191;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x8bXTZKOf2uP7frXW3XX6UWjY33n1Dc79uBumdx0Eb8=;
        b=dxd2Jzf67VhtkAqtk3UW7FgLEEbRBwyv3unBtCEMPQDs36rnKPIc3ys2Jmnh0tu9Cl
         vDJSBPUSUcYvjSrqxyQsyK0gtOouGlN64KOcMbeaUbqqrMiqLtdjsSADcSYW9qVvbgQZ
         v+c6+mmNCqT5b0Zp44Ga2P/NPvnL8MGZDjqak5M0WcXGelkpwob06nbFb4YSHLN+DSZw
         1+kzCIH/0M4+TLAPXJL3NDdM88uhU0cbx0D9VnMy1SLG25bICKpLxw1V2k8A6YazDAKD
         m2Xi48slLgjwRjjLVPNt22Fv2b0mRt1saRoiqKpoNUAX+q4GcnpidF5xqZ8Yu+ZcOam3
         1IOQ==
X-Gm-Message-State: AOJu0Yw8XI/G95LJH+0Eqkgflc+fMA7t/2aJkBqEG3JSqH7iYW3Pt5Ir
	hOFO7ekVxLB/JPsxNUi/s6gG8g5wJ2pNPxSDgOaSj/ziEuLrnBzxrus6IhH/ZCu36sCpJQOJPPD
	NrRjYHPNAlJx4j0awTch7U8vFo4YhxXT4QxGN6GfpD5+mQEL3oJlgcUrf0JV22m/QcGOMkzZEjp
	7KECL/6D6pNrE5zZ05ihz5g2+GozIfsfJIk2MdOBR0rkLtxjMQ0BWW
X-Google-Smtp-Source: AGHT+IF10vz63m02uAW14nmsz+sX2yfpf+Cs1KrtSmnw3SCKnw6/XlxHkgRXgdVE9Z2EFKf37IgfUOygyog=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:6402:f08:b0:560:98a2:93e2 with SMTP id
 i8-20020a0564020f0800b0056098a293e2mr10505eda.0.1707498390946; Fri, 09 Feb
 2024 09:06:30 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:09 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-6-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 5/8] selftests/landlock: Test IOCTLs on named pipes
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Named pipes should behave like pipes created with pipe(2),
so we don't want to restrict IOCTLs on them.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 70 +++++++++++++++++++---
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 9e9b828a898b..ae8b8b412828 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3922,6 +3922,67 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
=20
+static int test_fionread_ioctl(int fd)
+{
+	size_t sz =3D 0;
+
+	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+/*
+ * For named pipes, the same rules should apply as for anonymous pipes.
+ *
+ * That means, if the pipe is opened, we should permit the IOCTLs which ar=
e
+ * implemented by pipefifo_fops (fs/pipe.c), even if they were otherwise
+ * forbidden by Landlock policy.
+ */
+TEST_F_FORK(layout1, named_pipe_ioctl)
+{
+	pid_t child_pid;
+	int fd, ruleset_fd;
+	const char *const path =3D file1_s1d1;
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL,
+	};
+
+	ASSERT_EQ(0, unlink(path));
+	ASSERT_EQ(0, mkfifo(path, 0600));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* The child process opens the pipe for writing. */
+	child_pid =3D fork();
+	ASSERT_NE(-1, child_pid);
+	if (child_pid =3D=3D 0) {
+		fd =3D open(path, O_WRONLY);
+		close(fd);
+		exit(0);
+	}
+
+	fd =3D open(path, O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	/* FIONREAD is implemented by pipefifo_fops. */
+	EXPECT_EQ(0, test_fionread_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+	ASSERT_EQ(0, unlink(path));
+
+	/* Under the same conditions, FIONREAD on a regular file fails. */
+	fd =3D open(file2_s1d1, O_RDONLY);
+	ASSERT_LE(0, fd);
+	EXPECT_EQ(EACCES, test_fionread_ioctl(fd));
+	ASSERT_EQ(0, close(fd));
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
 /* clang-format on */
@@ -4134,15 +4195,6 @@ static int test_fibmap_ioctl(int fd)
 	return 0;
 }
=20
-static int test_fionread_ioctl(int fd)
-{
-	size_t sz =3D 0;
-
-	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
-		return errno;
-	return 0;
-}
-
 TEST_F_FORK(ioctl, handle_dir_access_file)
 {
 	const int flag =3D 0;
--=20
2.43.0.687.g38aa6559b0-goog

