Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2499222597
	for <linux-security-module@vger.kernel.org>; Tue,  2 Dec 2025 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764712317; cv=none; b=ejvvvIDLXiNp0jX2rT171GjF0Y+ZTqUETyDAdU3bZXSwy21tqa1RPdy7RWCBxIJTczpHS0YzY9na+9oI5j2TnhBHcl1JVLlqIP1v4PxyLLNl/xctTCkgvE6MtoJiCGB5dpjNOvg4bCpdXBvliKIV5y08Kpj9TSXqml8MRRY9yBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764712317; c=relaxed/simple;
	bh=uAoRhEvYEsg/GO+jbP+zA650LAb6CZpffIsb9gAucaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZVj/vPbMnXL21Kiqs04IAQTfiODtCoAmf3qhBkh4Q1ZItEjXJKHoPyL5LVaqozSPLCqQpR5Srz6VpOadPWm/Do91fKrZmu1oHKTFKTKvVE1tcRbYQco1C6TDcWqezHOvyRwzRusgW/MaINQTsUuPq1ZBiHAV1r8LE80wOz3tHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=Jm8+k7Nv; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="Jm8+k7Nv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1764712312; bh=uAoRhEvYEsg/GO+jbP+zA650LAb6CZpffIsb9gAucaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jm8+k7NvwmOwkfrKQnU1ePR2K+29aOuSibLpuKUnnWkIZt/gikWy5e+oarNkwtiP8
	 qm0LS52bU++IwUmeu39WMR/E2J5LLTKDfddrBSdTNjYXJlpdOFFl8RRC6gNYoyLJ0b
	 jnmQbR4O4v/FzgkLlvkUwrJXW6YIaXXm91B7p9SnINQfkG2y3cvH4XIaJ2BVeEjijh
	 ngZn1WcFribtYewaIK2DZ4Mb4GmbYtPuEvIKQuOm4p/wDgbSZ+I8xGhytzWN09EY4b
	 0mCFmrmwJKVyfnW6UzMGzjDtD/ODrFP1TrqI8jt2Arx+P2bYxcZoMZ9jpMJ4G9kkSS
	 G15KjOEkP6ieg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 1090012543A;
	Tue,  2 Dec 2025 22:51:52 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH] selftests/landlock: NULL-terminate unix pathname addresses
Date: Tue,  2 Dec 2025 22:51:41 +0100
Message-Id: <20251202215141.689986-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <c2780073-9e74-4303-9e07-6b825963148e@buffet.re>
References: <c2780073-9e74-4303-9e07-6b825963148e@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of Unix pathname addresses is computed in selftests using
offsetof(struct sockaddr_un, sun_path) + strlen(xxx). It should have
been that +1, which makes addresses passed to the libc and kernel
non-NULL-terminated. unix_mkname_bsd() fixes that in Linux so there is
no harm, but just using sizeof(the address struct) should improve
readability.

Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
---
Based on commit https://lore.kernel.org/linux-security-module/20251201003631.190817-1-matthieu@buffet.re/

 tools/testing/selftests/landlock/fs_test.c    | 24 +++++++++----------
 .../landlock/scoped_abstract_unix_test.c      | 21 +++++++---------
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 7d378bdf3bce..76491ba54dce 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4362,22 +4362,24 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 {
 	const char *const path = file1_s1d1;
 	int srv_fd, cli_fd, ruleset_fd;
-	socklen_t size;
-	struct sockaddr_un srv_un, cli_un;
+	struct sockaddr_un srv_un = {
+		.sun_family = AF_UNIX,
+	};
+	struct sockaddr_un cli_un = {
+		.sun_family = AF_UNIX,
+	};
 	const struct landlock_ruleset_attr attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
 	};
 
 	/* Sets up a server */
-	srv_un.sun_family = AF_UNIX;
-	strncpy(srv_un.sun_path, path, sizeof(srv_un.sun_path));
-
 	ASSERT_EQ(0, unlink(path));
 	srv_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, srv_fd);
 
-	size = offsetof(struct sockaddr_un, sun_path) + strlen(srv_un.sun_path);
-	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, size));
+	strncpy(srv_un.sun_path, path, sizeof(srv_un.sun_path));
+	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, sizeof(srv_un)));
+
 	ASSERT_EQ(0, listen(srv_fd, 10 /* qlen */));
 
 	/* Enables Landlock. */
@@ -4387,16 +4389,12 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	/* Sets up a client connection to it */
-	cli_un.sun_family = AF_UNIX;
 	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, cli_fd);
 
-	bzero(&cli_un, sizeof(cli_un));
-	cli_un.sun_family = AF_UNIX;
 	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
-	size = offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path);
-
-	ASSERT_EQ(0, connect(cli_fd, (struct sockaddr *)&cli_un, size));
+	ASSERT_EQ(0,
+		  connect(cli_fd, (struct sockaddr *)&cli_un, sizeof(cli_un)));
 
 	/* FIONREAD and other IOCTLs should not be forbidden. */
 	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 6825082c079c..2cdf1ba07016 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -779,7 +779,6 @@ FIXTURE_TEARDOWN(various_address_sockets)
 
 TEST_F(various_address_sockets, scoped_pathname_sockets)
 {
-	socklen_t size_stream, size_dgram;
 	pid_t child;
 	int status;
 	char buf_child, buf_parent;
@@ -798,12 +797,8 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 	/* Pathname address. */
 	snprintf(stream_pathname_addr.sun_path,
 		 sizeof(stream_pathname_addr.sun_path), "%s", stream_path);
-	size_stream = offsetof(struct sockaddr_un, sun_path) +
-		      strlen(stream_pathname_addr.sun_path);
 	snprintf(dgram_pathname_addr.sun_path,
 		 sizeof(dgram_pathname_addr.sun_path), "%s", dgram_path);
-	size_dgram = offsetof(struct sockaddr_un, sun_path) +
-		     strlen(dgram_pathname_addr.sun_path);
 
 	/* Abstract address. */
 	memset(&stream_abstract_addr, 0, sizeof(stream_abstract_addr));
@@ -841,8 +836,9 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 		/* Connects with pathname sockets. */
 		stream_pathname_socket = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, stream_pathname_socket);
-		ASSERT_EQ(0, connect(stream_pathname_socket,
-				     &stream_pathname_addr, size_stream));
+		ASSERT_EQ(0,
+			  connect(stream_pathname_socket, &stream_pathname_addr,
+				  sizeof(stream_pathname_addr)));
 		ASSERT_EQ(1, write(stream_pathname_socket, "b", 1));
 		EXPECT_EQ(0, close(stream_pathname_socket));
 
@@ -850,12 +846,13 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 		dgram_pathname_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
 		ASSERT_LE(0, dgram_pathname_socket);
 		err = sendto(dgram_pathname_socket, "c", 1, 0,
-			     &dgram_pathname_addr, size_dgram);
+			     &dgram_pathname_addr, sizeof(dgram_pathname_addr));
 		EXPECT_EQ(1, err);
 
 		/* Sends with connection. */
-		ASSERT_EQ(0, connect(dgram_pathname_socket,
-				     &dgram_pathname_addr, size_dgram));
+		ASSERT_EQ(0,
+			  connect(dgram_pathname_socket, &dgram_pathname_addr,
+				  sizeof(dgram_pathname_addr)));
 		ASSERT_EQ(1, write(dgram_pathname_socket, "d", 1));
 		EXPECT_EQ(0, close(dgram_pathname_socket));
 
@@ -910,13 +907,13 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 	stream_pathname_socket = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, stream_pathname_socket);
 	ASSERT_EQ(0, bind(stream_pathname_socket, &stream_pathname_addr,
-			  size_stream));
+			  sizeof(stream_pathname_addr)));
 	ASSERT_EQ(0, listen(stream_pathname_socket, backlog));
 
 	dgram_pathname_socket = socket(AF_UNIX, SOCK_DGRAM, 0);
 	ASSERT_LE(0, dgram_pathname_socket);
 	ASSERT_EQ(0, bind(dgram_pathname_socket, &dgram_pathname_addr,
-			  size_dgram));
+			  sizeof(dgram_pathname_addr)));
 
 	/* Sets up abstract servers. */
 	stream_abstract_socket = socket(AF_UNIX, SOCK_STREAM, 0);

base-commit: c07e22414d18559b5c0fd5bc2c2f68f2903f1738
-- 
2.47.3

