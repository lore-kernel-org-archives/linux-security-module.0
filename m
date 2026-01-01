Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D8233723
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767274880; cv=none; b=E0GzXyTxGYVVD2MFOIoQKs5lYNVSR5s3MFxxnf8ziX15bwX9ygRDyQ1QZiE+hQ+OWFDpf817orsgHTqayw5i3J6phiGydjZxHd1CySL/OZuFaFKXm8fX8zn0dffJBjDik7SOWalW2QggnEPihaLuSaBmZ+EFdIF44WKVuZGj90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767274880; c=relaxed/simple;
	bh=ZUvbZN4W8jqDEN6E4nIHfyavDlUdpCdql2Z7h49Jkxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdY5WXbIDQOYXzE28DyUJJz+pEPYkXkPjjKvFReIOhIfQkaBH/EbF30xovMr9/BHTdBVRC02MUJFY4VP5857lc/+96htu1hJKDowrspLfh8Q0q8QJCQNHRaVAcJpZnbTAKnPEQiGg2s9IB34n1mQOEZK+Ok1wUz6dSVW5vGZaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icxKkF6g; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icxKkF6g"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7ffa421f1bso2119912566b.0
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767274876; x=1767879676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z01V4xLLglWC6xP1AXNQ9ZGxGsK5rCvY3N7cYy9TOrA=;
        b=icxKkF6gvfDZd1s58V16l6pbw46mHw6HLqjdvAoi7YoWB7CbJrI3AryLeZ/tUhbaHh
         v50MRRRNrZUG7QWK+jMABbR+34tNUm0cUek+BCo2RjoChIxTVpQwwgxSdkPbwDKbUjoJ
         1evT7XhqMFeUikzLLPfQBrHNCCZFq9/8fbX7GMvylSkqT1N0j4SNohSPvd9RsxZXoPsm
         YRPRI4es164Vmp4SXmW3f7p/lKo7RXP2cKw4EZyHEC+mW7IeP1EF2FgmVx6O3xsmHnlp
         aoPNbzCXK/zc8CHvmdYl3McOQWSwf7G6mWvkvWBGXZahxoquMoLDaHxaFyTQ2Rp/XI4x
         P4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767274876; x=1767879676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z01V4xLLglWC6xP1AXNQ9ZGxGsK5rCvY3N7cYy9TOrA=;
        b=KtCiY5bflx9vkS6KWZYWJRf4788+uc2rDgp1+j5V1XPIGSGHubk94sQfmK2HRYgHrQ
         Dvo37hJnhZM1GPSLrDCkTpgIA8rgpEV6nlkWA6ovbih2cJG9ASvWhlmM4OZwOMwslpWS
         2mgNbrpGRnwk5ZEagUWNOQNpm4BwF3UF4HAofJijpyVM8lFRpypjLxRMhFjliVLFx+6Q
         fh4o25JPBsDex9VyHMgTkpbJOjuQlimXe79D17aGFXwr7DXejZ/SdG2APLHoIV2VZ/YJ
         4wrTSe8B+M7M4dQ+vyETfowgTAKgK4vZBlCJqGisV/aX1tTx7BNE0KU92J1ZaUc2E4JN
         VxGA==
X-Gm-Message-State: AOJu0YygwPZB4SeniCsFs34C/MEA3pAWyyPiXN98/f6g+1Selae+ggGG
	UFY2ftLJe5VARtkjocXZ/HTbP2mOyGk/gZ74emECWAPdBkJurOA3mcbG
X-Gm-Gg: AY/fxX6bMsQspEo0ZT5kuTGp1+3P1ec3M3eRVTchEJDS2yOKOwr6SBjlccFYtXC8x7m
	jm0AP8ThRYbHOyMaKQVl9DP0u+JEjYv9nX7GKnbwzqsRK09xIBF09sa3YO3tp2qvjA5BoRTAVYL
	FamAZMrta+XnkVPzabww+DYAqLTuhETlKX7hvmm3j/yx10m2H9nJ1wfbwDI1YXNS+4V8oqGvQrH
	xOSHM1ZgFe1JBwcaGC0pJod4JAaUa2ma/+yBUpyvycwVByFQI4x/lMSN0/TB0ogk+d0Ly/GsI75
	tnxSstiF3AhyTYtBp1F2MqZ7itB6LRoopbbXGLN7meiYU/ZEUGKdBHM0brum43h+XsShuMGBUCL
	ZWRfb3KmYzZk1KErqUBQFvCrnnziW4UcJwAb08fLKMLIOpC+P+o0Pm83js6XU47YNqNZ9Xcsijv
	lNok2vQJzQwJquC4QH9G/ADT3P4Vuu/iuTTAMp
X-Google-Smtp-Source: AGHT+IEpTw8iPIhisXXD2v828j/u4UIw2cCxvZ1ayLTtDgonRgpp3yEmaxIWtA0bpactP+q0QYKjoA==
X-Received: by 2002:a17:907:2d8c:b0:b73:2d9c:9581 with SMTP id a640c23a62f3a-b80358bd87emr4498838866b.28.1767274876386;
        Thu, 01 Jan 2026 05:41:16 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0ebbasm4148887866b.55.2026.01.01.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:41:16 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 4/5] landlock/selftests: test LANDLOCK_ACCESS_FS_CONNECT_UNIX
Date: Thu,  1 Jan 2026 14:41:01 +0100
Message-ID: <20260101134102.25938-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260101134102.25938-1-gnoack3000@gmail.com>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Exercise the LANDLOCK_ACCESS_FS_CONNECT_UNIX access right.
* Extract common helpers from an existing IOCTL test that
  also uses pathname unix(7) sockets.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 88 +++++++++++++++++-----
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 74e975c5e9847..fb5b240bab629 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4358,30 +4358,58 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
 	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
 }
 
+/*
+ * set_up_named_unix_server - Create a pathname unix socket and listen
+ *
+ * Return: The listening FD - it is the caller responsibility to close it.
+ */
+static int set_up_named_unix_server(struct __test_metadata *const _metadata,
+				    const char *const path)
+{
+	int fd;
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+
+	ASSERT_EQ(0, unlink(path));
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, fd);
+
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
+	ASSERT_EQ(0, bind(fd, (struct sockaddr *)&addr, sizeof(addr)));
+
+	ASSERT_EQ(0, listen(fd, 10 /* qlen */));
+	return fd;
+}
+
+/*
+ * test_connect_named_unix - connect to the given named UNIX socket
+ *
+ * Return: The errno from connect(), or 0
+ */
+static int test_connect_named_unix(int fd, const char *const path)
+{
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
+
+	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) == -1)
+		return errno;
+	return 0;
+}
+
 /* For named UNIX domain sockets, no IOCTL restrictions apply. */
 TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 {
 	const char *const path = file1_s1d1;
 	int srv_fd, cli_fd, ruleset_fd;
-	struct sockaddr_un srv_un = {
-		.sun_family = AF_UNIX,
-	};
-	struct sockaddr_un cli_un = {
-		.sun_family = AF_UNIX,
-	};
 	const struct landlock_ruleset_attr attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
 	};
 
 	/* Sets up a server */
-	ASSERT_EQ(0, unlink(path));
-	srv_fd = socket(AF_UNIX, SOCK_STREAM, 0);
-	ASSERT_LE(0, srv_fd);
-
-	strncpy(srv_un.sun_path, path, sizeof(srv_un.sun_path));
-	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, sizeof(srv_un)));
-
-	ASSERT_EQ(0, listen(srv_fd, 10 /* qlen */));
+	srv_fd = set_up_named_unix_server(_metadata, path);
 
 	/* Enables Landlock. */
 	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
@@ -4393,9 +4421,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, cli_fd);
 
-	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
-	ASSERT_EQ(0,
-		  connect(cli_fd, (struct sockaddr *)&cli_un, sizeof(cli_un)));
+	ASSERT_EQ(0, test_connect_named_unix(cli_fd, path));
 
 	/* FIONREAD and other IOCTLs should not be forbidden. */
 	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
@@ -4570,6 +4596,34 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 	ASSERT_EQ(0, close(file_fd));
 }
 
+TEST_F_FORK(layout1, named_unix_domain_socket)
+{
+	const char *const path = file1_s1d1;
+	int cli_fd, srv_fd, ruleset_fd;
+	const struct landlock_ruleset_attr attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_CONNECT_UNIX,
+	};
+
+	/* Sets up a server */
+	srv_fd = set_up_named_unix_server(_metadata, path);
+
+	/* Enables Landlock. */
+	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Sets up a client connection to it */
+	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, cli_fd);
+
+	/* Connecting to the Unix socket is denied. */
+	EXPECT_EQ(EACCES, test_connect_named_unix(cli_fd, path));
+
+	ASSERT_EQ(0, close(cli_fd));
+	ASSERT_EQ(0, close(srv_fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.52.0

