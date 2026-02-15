Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27592D7DF2
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152761; cv=none; b=h2fa7kccQ1GA2AeMe02ADlyCETAah2OQwicd6gY2n8Va5gapWu6zi9x0SS2Z9DYxEyV9DTbsUAkh5SQhJlOts4ooeSTlIm51BwCAyAg0wm5pCRrNnqq+Q9CeELiEDhVkwyKZEgWQIm0RLs6wcGlZqqg4dWUVvzugIIRqMpu1k1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152761; c=relaxed/simple;
	bh=W098jvgGTtyMeJhIhKx2XLtsF1NmyaJFAuPguFV1ESc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjjRcfdK044vz63z/qsUHq7dlkpARsE9NULjtDCk8K7KDr13BrQr93E+LbGKC8mEPopmUvlfeGsAQsX4jPkyq2R0e4c8WOqw1iBHeUe2JOWa5AMjWokKhrwj9BEb2ix2js19CRWmrRfAMkSrWivQfFDuyPa+ASki41WgjELMv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlYLqXCl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlYLqXCl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43621bf67ceso1354217f8f.2
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 02:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152758; x=1771757558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7Jfkw1R/JbJQgzJE6ylywbMsHk9231HwiCoeMaxEkI=;
        b=mlYLqXCl7VNweHC1xcLDFAG4mPthN2WUW7MtNHo7l7XdQ+pBH/gxeHHw3Lj3Ri+ng7
         ISLXIuqeiPCvO5tVFln4kd5ikl9UPC8NwZD5z3GUv+/aCSullEAJhShQBrmG8olZX88h
         OHujeD71mQa23qZvz0LW1D89p0gpmfr4LjLMYdrN3BkcMwwxDs2zEzNTe2Z6cBxM1itP
         wq/8I0kovHGbiDPHAD0g5v99WX1OVRLO6OsO7c5s1KlIcrT/qMW3Esb3PYpVuxW+1TrM
         VccfkBpkNpyZdFQfwV9Ejr3wEHoNnvaQnC/DDJz+ac++kStn+JUB+SqQudCPsTctuksa
         8dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152758; x=1771757558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7Jfkw1R/JbJQgzJE6ylywbMsHk9231HwiCoeMaxEkI=;
        b=JXW8Y961uS9NZo3eP2jTaTlycXUlczTXCsHHk43/iWYYi6e53gTJmnBlC26MRR5dHX
         g6qV40+bS0eL5c36mwMwTfUcA5XAWnm16YqJwNf8Qk47OXnfB7TjlKLEBDZvaBqF+0a4
         ECeYQq9lbQKGpoOJnKBXNy3l/uvkSZx5pQro+vdhYjpJe1kTbs/QsDb6tIw/LqfMfq3j
         DHQDH7minKSp5pzoFmZn8821zlQrzO1iP+gp3pPiN4ynfu/i34XBD4wW7fGkRkMOfung
         GGNdTdSI6ru7pa2O6RUp8BiUpJO0OQ5SFqtmsQTO+cXf0pS/JD3oSsl7Xr6yOuAwMmE0
         samA==
X-Forwarded-Encrypted: i=1; AJvYcCXONVW3dBWJ3Whi8B7JaEJCtLTPTjhFaC5mJ+OLJR5P7fQfGtn7qm3FLjej9d2f0Na5vjEWkTQ3UyRSJdYifR3WA921INo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcuc47GBjd+ZYCFdra1dPZMsoi3hbpOaZYiVu4nRTt2C4LYAu
	FD2gzS/fJPbML1NEpk0NDULQL6MrGHRX5VnF6t0E2RlWHqfqgfGZtJkU
X-Gm-Gg: AZuq6aJdcrYedXEcVaROVgKkkzSHjttqErK28998Rl+PejHeY8OOvCU4Sp/PbCrQtlJ
	A4lxw57pzMz4uHc4d07O0cpAxXl+2hTKLpZkNG/e++03vkzA0xpZsVbqlbLbs0Pm7fJ3p40+KUh
	7/onkEp/0uA6axCGPvF4v8B982OndqC3nF1Lyg4DfUXs+RBHmYwQgxrFnAOrTdGx3cibQ3naXSr
	4fppL9M+UcM1MmmFJeSAehp5zs2SNE0jkFa9eEZJHCu8lxtmoW+ss4gkCYmw8TFZT40Q+21K5Bu
	/AUPZrWqn+AuR+7DUVEKecFhAhHn71xSc9d+MTqDwfOn9ipwjYKkRYQPATrePrlEzKpHL7j1/ha
	4byXoHmYlvbP8vUW/m2rhmkBFB3FrV5jKDbP07dCEM6hU7jFg1VDMZCuj6FXXOSmQzX/NN0f42D
	USlpTomcjS0cOZXt6HqXKKsi5nyKast10cIsr+u0AHkM+mwvxI
X-Received: by 2002:a5d:5f47:0:b0:436:3475:473f with SMTP id ffacd0b85a97d-4379db8cd9cmr7954859f8f.36.1771152758202;
        Sun, 15 Feb 2026 02:52:38 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1b4sm17594791f8f.14.2026.02.15.02.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:37 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v5 4/9] landlock/selftests: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Date: Sun, 15 Feb 2026 11:51:52 +0100
Message-ID: <20260215105158.28132-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215105158.28132-1-gnoack3000@gmail.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Extract common helpers from an existing IOCTL test that
  also uses pathname unix(7) sockets.
* These tests use the common scoped domains fixture which is also used
  in other Landlock scoping tests and which was used in Tingmao Wang's
  earlier patch set in [1].

These tests exercise the cross product of the following scenarios:

* Stream connect(), Datagram connect(), Datagram sendmsg() and
  Seqpacket connect().
* Child-to-parent and parent-to-child communication
* The Landlock policy configuration as listed in the scoped_domains
  fixture.
  * In the default variant, Landlock domains are only placed where
    prescribed in the fixture.
  * In the "ALL_DOMAINS" variant, Landlock domains are also placed in
    the places where the fixture says to omit them, but with a
    LANDLOCK_RULE_PATH_BENEATH that allows connection.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>
Cc: Mickaël Salaün <mic@digikod.net>
Link[1]: https://lore.kernel.org/all/53b9883648225d5a08e82d2636ab0b4fda003bc9.1767115163.git.m@maowtm.org/
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 384 ++++++++++++++++++++-
 1 file changed, 368 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index b318627e7561..bdeff2e0e029 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4358,30 +4358,61 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
 	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
 }
 
+/*
+ * set_up_named_unix_server - Create a pathname unix socket
+ *
+ * If the socket type is not SOCK_DGRAM, also invoke listen(2).
+ *
+ * Return: The listening FD - it is the caller responsibility to close it.
+ */
+static int set_up_named_unix_server(struct __test_metadata *const _metadata,
+				    int type, const char *const path)
+{
+	int fd;
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+
+	fd = socket(AF_UNIX, type, 0);
+	ASSERT_LE(0, fd);
+
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
+	ASSERT_EQ(0, bind(fd, (struct sockaddr *)&addr, sizeof(addr)));
+
+	if (type != SOCK_DGRAM)
+		ASSERT_EQ(0, listen(fd, 10 /* qlen */));
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
 	ASSERT_EQ(0, unlink(path));
-	srv_fd = socket(AF_UNIX, SOCK_STREAM, 0);
-	ASSERT_LE(0, srv_fd);
-
-	strncpy(srv_un.sun_path, path, sizeof(srv_un.sun_path));
-	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, sizeof(srv_un)));
-
-	ASSERT_EQ(0, listen(srv_fd, 10 /* qlen */));
+	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, path);
 
 	/* Enables Landlock. */
 	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
@@ -4393,9 +4424,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, cli_fd);
 
-	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
-	ASSERT_EQ(0,
-		  connect(cli_fd, (struct sockaddr *)&cli_un, sizeof(cli_un)));
+	ASSERT_EQ(0, test_connect_named_unix(cli_fd, path));
 
 	/* FIONREAD and other IOCTLs should not be forbidden. */
 	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
@@ -4570,6 +4599,329 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 	ASSERT_EQ(0, close(file_fd));
 }
 
+/*
+ * test_sendto_named_unix - sendto to the given named UNIX socket
+ *
+ * sendto() is equivalent to sendmsg() in this respect.
+ *
+ * Return: The errno from sendto(), or 0
+ */
+static int test_sendto_named_unix(int fd, const char *const path)
+{
+	static const char buf[] = "dummy";
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path));
+
+	if (sendto(fd, buf, sizeof(buf), 0, (struct sockaddr *)&addr,
+		   sizeof(addr)) == -1)
+		return errno;
+	return 0;
+}
+
+/* clang-format off */
+FIXTURE(scoped_domains) {};
+/* clang-format on */
+
+#include "scoped_base_variants.h"
+
+FIXTURE_SETUP(scoped_domains)
+{
+	drop_caps(_metadata);
+};
+
+FIXTURE_TEARDOWN(scoped_domains)
+{
+}
+
+static void enforce_fs_resolve_unix(struct __test_metadata *const _metadata,
+				    const struct rule rules[])
+{
+	if (rules) {
+		int fd = create_ruleset(_metadata,
+					LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
+		enforce_ruleset(_metadata, fd);
+		EXPECT_EQ(0, close(fd));
+	} else {
+		drop_access_rights(
+			_metadata,
+			&(struct landlock_ruleset_attr){
+				.handled_access_fs =
+					LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+			});
+	}
+}
+
+/*
+ * Flags for test_connect_to_parent and test_connect_to_child:
+ *
+ * USE_SENDTO: Use sendto() instead of connect() (for SOCK_DGRAM only)
+ * ENFORCE_ALL: Enforce a Landlock domain even when the variant says
+ *   we shouldn't.  We enforce a domain where the path is allow-listed,
+ *   and expect the behavior to be the same as if none was used.
+ */
+#define USE_SENDTO (1 << 0)
+#define ENFORCE_ALL (1 << 1)
+
+static void test_connect_to_parent(struct __test_metadata *const _metadata,
+				   const FIXTURE_VARIANT(scoped_domains) *
+					   variant,
+				   int sock_type, int flags)
+{
+	const char *const path = "sock";
+	const struct rule rules[] = {
+		{
+			.path = ".",
+			.access = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+		},
+		{},
+	};
+	int cli_fd, srv_fd, res, status;
+	pid_t child_pid;
+	int readiness_pipe[2];
+	char buf[1];
+
+	if (variant->domain_both)
+		enforce_fs_resolve_unix(_metadata, NULL);
+	else if (flags & ENFORCE_ALL)
+		enforce_fs_resolve_unix(_metadata, rules);
+
+	unlink(path);
+	ASSERT_EQ(0, pipe2(readiness_pipe, O_CLOEXEC));
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+
+	if (child_pid == 0) {
+		if (variant->domain_child)
+			enforce_fs_resolve_unix(_metadata, NULL);
+		else if (flags & ENFORCE_ALL)
+			enforce_fs_resolve_unix(_metadata, rules);
+
+		/* Wait for server to be available. */
+		EXPECT_EQ(0, close(readiness_pipe[1]));
+		EXPECT_EQ(1, read(readiness_pipe[0], &buf, 1));
+		EXPECT_EQ(0, close(readiness_pipe[0]));
+
+		/* Talk to server. */
+		cli_fd = socket(AF_UNIX, sock_type, 0);
+		ASSERT_LE(0, cli_fd);
+
+		if (flags & USE_SENDTO)
+			res = test_sendto_named_unix(cli_fd, path);
+		else
+			res = test_connect_named_unix(cli_fd, path);
+
+		EXPECT_EQ(variant->domain_child ? EACCES : 0, res);
+
+		/* Clean up. */
+		EXPECT_EQ(0, close(cli_fd));
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	if (variant->domain_parent)
+		enforce_fs_resolve_unix(_metadata, NULL);
+	else if (flags & ENFORCE_ALL)
+		enforce_fs_resolve_unix(_metadata, rules);
+
+	srv_fd = set_up_named_unix_server(_metadata, sock_type, path);
+
+	/* Tell the child that it can connect. */
+	EXPECT_EQ(0, close(readiness_pipe[0]));
+	EXPECT_EQ(sizeof(buf), write(readiness_pipe[1], buf, sizeof(buf)));
+	EXPECT_EQ(0, close(readiness_pipe[1]));
+
+	/* Wait for child. */
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/* Clean up. */
+	EXPECT_EQ(0, close(srv_fd));
+	EXPECT_EQ(0, unlink(path));
+}
+
+static void test_connect_to_child(struct __test_metadata *const _metadata,
+				  const FIXTURE_VARIANT(scoped_domains) *
+					  variant,
+				  int sock_type, int flags)
+{
+	const char *const path = "sock";
+	const struct rule rules[] = {
+		{
+			.path = ".",
+			.access = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+		},
+		{},
+	};
+	int readiness_pipe[2];
+	int shutdown_pipe[2];
+	int cli_fd, srv_fd, res, status;
+	pid_t child_pid;
+	char buf[1];
+
+	if (variant->domain_both)
+		enforce_fs_resolve_unix(_metadata, NULL);
+	else if (flags & ENFORCE_ALL)
+		enforce_fs_resolve_unix(_metadata, rules);
+
+	unlink(path);
+	ASSERT_EQ(0, pipe2(readiness_pipe, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(shutdown_pipe, O_CLOEXEC));
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+
+	if (child_pid == 0) {
+		if (variant->domain_child)
+			enforce_fs_resolve_unix(_metadata, NULL);
+		else if (flags & ENFORCE_ALL)
+			enforce_fs_resolve_unix(_metadata, rules);
+
+		srv_fd = set_up_named_unix_server(_metadata, sock_type, path);
+
+		/* Tell the parent that it can connect. */
+		EXPECT_EQ(0, close(readiness_pipe[0]));
+		EXPECT_EQ(sizeof(buf),
+			  write(readiness_pipe[1], buf, sizeof(buf)));
+		EXPECT_EQ(0, close(readiness_pipe[1]));
+
+		/* Wait until it is time to shut down. */
+		EXPECT_EQ(0, close(shutdown_pipe[1]));
+		EXPECT_EQ(1, read(shutdown_pipe[0], &buf, 1));
+		EXPECT_EQ(0, close(shutdown_pipe[0]));
+
+		/* Cleanup */
+		EXPECT_EQ(0, close(srv_fd));
+		EXPECT_EQ(0, unlink(path));
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	if (variant->domain_parent)
+		enforce_fs_resolve_unix(_metadata, NULL);
+	else if (flags & ENFORCE_ALL)
+		enforce_fs_resolve_unix(_metadata, rules);
+
+	/* Wait for server to be available. */
+	EXPECT_EQ(0, close(readiness_pipe[1]));
+	EXPECT_EQ(1, read(readiness_pipe[0], &buf, 1));
+	EXPECT_EQ(0, close(readiness_pipe[0]));
+
+	/* Talk to server. */
+	cli_fd = socket(AF_UNIX, sock_type, 0);
+	ASSERT_LE(0, cli_fd);
+
+	if (flags & USE_SENDTO)
+		res = test_sendto_named_unix(cli_fd, path);
+	else
+		res = test_connect_named_unix(cli_fd, path);
+
+	EXPECT_EQ(variant->domain_parent ? EACCES : 0, res);
+
+	/* Clean up. */
+	EXPECT_EQ(0, close(cli_fd));
+
+	/* Tell the server to shut down. */
+	EXPECT_EQ(0, close(shutdown_pipe[0]));
+	EXPECT_EQ(sizeof(buf), write(shutdown_pipe[1], buf, sizeof(buf)));
+	EXPECT_EQ(0, close(shutdown_pipe[1]));
+
+	/* Wait for child. */
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+}
+
+TEST_F(scoped_domains, unix_stream_connect_to_parent)
+{
+	test_connect_to_parent(_metadata, variant, SOCK_STREAM, 0);
+}
+
+TEST_F(scoped_domains, unix_dgram_connect_to_parent)
+{
+	test_connect_to_parent(_metadata, variant, SOCK_DGRAM, 0);
+}
+
+TEST_F(scoped_domains, unix_dgram_sendmsg_to_parent)
+{
+	test_connect_to_parent(_metadata, variant, SOCK_DGRAM, USE_SENDTO);
+}
+
+TEST_F(scoped_domains, unix_seqpacket_connect_to_parent)
+{
+	test_connect_to_parent(_metadata, variant, SOCK_SEQPACKET, 0);
+}
+
+TEST_F(scoped_domains, unix_stream_connect_to_parent_full)
+{
+	test_connect_to_parent(_metadata, variant, SOCK_STREAM, ENFORCE_ALL);
+}
+
+TEST_F(scoped_domains, unix_dgram_connect_to_parent_full)
+{
+	test_connect_to_parent(_metadata, variant, SOCK_DGRAM, ENFORCE_ALL);
+}
+
+TEST_F(scoped_domains, unix_dgram_sendmsg_to_parent_full)
+{
+	test_connect_to_parent(_metadata, variant, SOCK_DGRAM,
+			       USE_SENDTO | ENFORCE_ALL);
+}
+
+TEST_F(scoped_domains, unix_seqpacket_connect_to_parent_full)
+{
+	test_connect_to_parent(_metadata, variant, SOCK_SEQPACKET, ENFORCE_ALL);
+}
+
+TEST_F(scoped_domains, unix_stream_connect_to_child)
+{
+	test_connect_to_child(_metadata, variant, SOCK_STREAM, 0);
+}
+
+TEST_F(scoped_domains, unix_dgram_connect_to_child)
+{
+	test_connect_to_child(_metadata, variant, SOCK_DGRAM, 0);
+}
+
+TEST_F(scoped_domains, unix_dgram_sendmsg_to_child)
+{
+	test_connect_to_child(_metadata, variant, SOCK_DGRAM, USE_SENDTO);
+}
+
+TEST_F(scoped_domains, unix_seqpacket_connect_to_child)
+{
+	test_connect_to_child(_metadata, variant, SOCK_SEQPACKET, 0);
+}
+
+TEST_F(scoped_domains, unix_stream_connect_to_child_full)
+{
+	test_connect_to_child(_metadata, variant, SOCK_STREAM, ENFORCE_ALL);
+}
+
+TEST_F(scoped_domains, unix_dgram_connect_to_child_full)
+{
+	test_connect_to_child(_metadata, variant, SOCK_DGRAM, ENFORCE_ALL);
+}
+
+TEST_F(scoped_domains, unix_dgram_sendmsg_to_child_full)
+{
+	test_connect_to_child(_metadata, variant, SOCK_DGRAM,
+			      USE_SENDTO | ENFORCE_ALL);
+}
+
+TEST_F(scoped_domains, unix_seqpacket_connect_to_child_full)
+{
+	test_connect_to_child(_metadata, variant, SOCK_SEQPACKET, ENFORCE_ALL);
+}
+
+#undef USE_SENDTO
+#undef ENFORCE_ALL
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.52.0

