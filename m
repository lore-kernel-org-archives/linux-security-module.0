Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAA17555C
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353285; cv=none; b=Gj6K8kEZYPZV7doF6F58Li+X5if/PUpGEzzgVar5PCdYtBEr8fMxyKXl+sTgrj0rn3147f36aDvqahjT+A0xd060DTjR9l1br1/Krexl+61QsM89jwhZVDpBKVnUVz6UNv9HpH97FAhm8DSvmrH6jUpozG+8hz6wVxPj28W05wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353285; c=relaxed/simple;
	bh=MtpbTlvL7SyD43IAyhPOPaImHwA66wNwR74olQIifFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pBDnhmEiZipihzpxW61Vw2o/XZtkcQY3nzejBdHbpf4O0/Ox0WLl2IuWnKHJ9Sh9sLCIjpI5TLShFApHpd25LvM6J1RaI5XY4kILvOcZzbMaB5OhNp5/2CiMBO8uWsaBb0nVI6T7QEfzorbY/D2ZXk0zGlkcn4lmsHT746tRwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P0wxu0rb; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P0wxu0rb"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-56c5ce6dd4dso1884471a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353282; x=1712958082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFM7a28BI4HHHJ3WCQsqOtPwSLDVB+jP/gaHsbLT3vs=;
        b=P0wxu0rbbFiwXEKVeE41o7ut4Elu1UciQlXMapU8sDqVsvMucIVIMLBgW4UDJlltM5
         0lGgvrgohxVmvF5wdZKgroGLEiltHBZxcNUTHSal974owvKTEtACLG0L1LgJqMJZ/4D7
         AoKlLS9kgmg0K3xIYnQ8r89Aly3wd65HJ6zrsqhlSXPXGS5XH9XUt0aPyw+wPSAxc7aM
         79uJ1uPqyBTYotCrJxF1t0DY6GpW9GBZFLrLy0+c4sSw8IjxJC0KM/iqdwB1kV+yWmn8
         S/t4d9EbjJSlGm+xo82TVloIpthmrMC5TbxfYWHejeftg9Fzai3rw++xLDzS7Bpk82Zu
         iUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353282; x=1712958082;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sFM7a28BI4HHHJ3WCQsqOtPwSLDVB+jP/gaHsbLT3vs=;
        b=w4qruotnOIY9b7CHDsJMSHYQFvoLVK9KbNIn2edSvwxfYuzAWo7LvCpxfFvIUlR7UG
         uE+emuJUw1Qb2/apGKSklr1DtVE+9fYBbXQqwTGAwR1+crgruepEeU/dVMX0dAqlIvTt
         iYTj3WObyY7/UghRDCuxLiwRyv2XW/3DfoZyA8u04A5CGxI+TETbiOGPCFNpa1US51Bs
         FWCTc4L52tNzb2Km48Dg89A3U3j2bawJySslSGiwI9FZ4nt9dKqfYlwOu/HQv+qtU76R
         ohQdaOWXdb4ijObOw+KsBG7mofXhmmiS1yWlup9vht7JRNKqF7+EPAbHLAZp6+RUBQJK
         v96Q==
X-Gm-Message-State: AOJu0Yy04EHQ4MHTLkSZvTfLmshP5v2yPx89lQgfxMdoeR3X0HmLK0xo
	oRwkyCddD26sez2NKihtaaTkbod3c6O4pXkEnsoRHCWdEwwtv57+i2YDzrFUgg1GgHBbLaMOxFS
	sz+6X7AIXKvTAW+3CbgT15zjeQNw8glhzXBbdxxf9PD42F8+XSOU1Wg8DK8Og/AX86/EIt3GuWe
	H+huLI7PPVZbvjHiGIXPGP/orIOAxQgn7gqad9AmRrEtQBAVE/R4QT
X-Google-Smtp-Source: AGHT+IEUZPxdGsJVz4Sgv0mtGdF/BAGJk8yDSWeRh3CR6MVV8l8ysgBWYXvTPD9tQmebd+OME7EreOfHGN8=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:551b:b0:56b:b73a:5f8b with SMTP id
 fi27-20020a056402551b00b0056bb73a5f8bmr4335edb.5.1712353282022; Fri, 05 Apr
 2024 14:41:22 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:34 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-7-gnoack@google.com>
Subject: [PATCH v14 06/12] selftests/landlock: Test IOCTLs on named pipes
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
 tools/testing/selftests/landlock/fs_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 84e5477d2e36..215f0e8bcd69 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3935,6 +3935,49 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
=20
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
--=20
2.44.0.478.gd926399ef9-goog

