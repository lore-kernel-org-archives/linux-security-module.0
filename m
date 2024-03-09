Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B375381B0
	for <linux-security-module@vger.kernel.org>; Sat,  9 Mar 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970821; cv=none; b=KuleGmopVQzQmjrCIJQu5KXdTMOMZh+vbIcYLZHVIJhR28+rWoUPX3uF0dqhHw9XHy91NsNbCO2aADiMgSgLZSsqhlZpgqQORTliPaJpMBxc4i1QxaOrPg+scOWA28enMiy7/lxTRkXKxGxOLQOMGfdKt2bskaLtjbi5JyaNTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970821; c=relaxed/simple;
	bh=Z3q8TUMjwgpivCigA4vrhz3RNGKNneAYDv1Up6/p3tU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bpiFlRPztyeGJh2vGGSbMujL3xArB9QASf7szbLAWAq7r+7R0qHRVI5hHUlZ2RA02znwz8jRvfczxsaNFnkF+tTg6KuIFuA51yXTHnla7Xxds5mMaJKqoEDkG+D7aVxqEUG4oXV2tdSSZCFzh33lFWlecZqEOAp19i8ip97lMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yya/tQOJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yya/tQOJ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso4698658276.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2024 23:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970819; x=1710575619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZWDgBnbZIfaFhFVfT7jsQxJgGlWIGxyoXMZnZq9C5M=;
        b=yya/tQOJneI+zLKmXqGxuwnCMIBnhWvFzyn0ISx/shUGbptwgMnlxPh5Dpdptv1Uud
         bM1F2qtyybxnEIfsf+1bVFDuqgCyo2HsLD7Lyo5kq/s7eBPncopCqO87cWJuwtzfAjDF
         yQPUGpQhffpyoHxSOeBFKylR98D5B+WEGM5ZUOMV7Z1iPDWrnRy5nU7HAKW9yUoWyk/7
         tG/quUvQ/+Jz3bmLxHWLdypbAOFVNZLisJEb+slj/zHOldOsOiPioBiLFMzKy5yjqeDe
         iTXg2uU3Wfsctv/JjblcLZ4edDFlFO7x6OA1mK03xgOwpGkWtyUTygsmDdTNPFinwQpd
         o6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970819; x=1710575619;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ZWDgBnbZIfaFhFVfT7jsQxJgGlWIGxyoXMZnZq9C5M=;
        b=UJ59k25uWrxazH0hWJiEHGupZ1VRvEp3b7JfSOohhPmNr1GuwQZfYYdLqGVetC5lYr
         sXXr+2s27TiMh5dBxj5sC1gGHU/x8OvGjrfo8hMUZseh+vHRuGRdBYguuKCd88FCLYf4
         saydwycEv39r45GfMMQSVmQzRcWMR1p/HNzu45sFsq08sOOpqb3lmoB7MzzHguH0akMV
         NDU6l1jS6Tkw4vdLtsDmrKPUs4WdvyojiirxxCxnVMjGw++4XBcygsR5SVingtjoBKPM
         Tvh207UJgUHDSVLmmWvUTv6q8T13CfD6oCzcZVQZhhRG0uaN8X0UH/JMceis4VfakqbT
         rkKg==
X-Gm-Message-State: AOJu0YyIhEZyLgDm7Ore6JzYHZCGwpxKjVRVobhs2iLvr+B4r6nrXiG4
	xPp+MWR6huZO7BCZ7EmgqX+2y/sJzcbEpYr4BWdx5VaDOcXAaXYN69m/HFu6fAxdIKCCCp6JJbe
	m0GaYEIYh/hLSZqWMKtmygqKTembh+XfZP/jD23+xTjrWWzpRhLgYAaFvDkO/2JXsY1sqG8ovdh
	eF3Dcag9T8s7kxMNjcU/qdso1MjxzMDwFbFwLhTabp1q5cAkYotGjZ
X-Google-Smtp-Source: AGHT+IFG5DX7qqXVTepRoOI8ZJVWe6Gadhv8jhaw+KaBWoOHLKfMIfTCOYgc+feUd9HW5jsS6V5+s/3qXRM=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:120a:b0:dc6:ff54:249f with SMTP id
 s10-20020a056902120a00b00dc6ff54249fmr357788ybu.8.1709970818999; Fri, 08 Mar
 2024 23:53:38 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:17 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-7-gnoack@google.com>
Subject: [PATCH v10 6/9] selftests/landlock: Test IOCTLs on named pipes
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
 tools/testing/selftests/landlock/fs_test.c | 61 ++++++++++++++++++----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 5c47231a722e..d991f44875bc 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3924,6 +3924,58 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
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
+ * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
+ * because they are not character or block devices.
+ */
+TEST_F_FORK(layout1, named_pipe_ioctl)
+{
+	pid_t child_pid;
+	int fd, ruleset_fd;
+	const char *const path =3D file1_s1d1;
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
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
+	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
@@ -3997,15 +4049,6 @@ static int test_tcgets_ioctl(int fd)
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
2.44.0.278.ge034bb2e1d-goog

