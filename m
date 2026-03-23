Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB53C4553
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285104; cv=none; b=e2xGiK8tIUsG37LnjdRS9cd0xxyD+ETqlgHXEWEaL3jZ0LT/QgrwxTA91Iawzh/8h5JA8ho4a0srWU1Xbc/z7KPvGK583oLHEUMqjUDk3Gukxonl9T++RMjQfLZKhIYFnlEvY8OHl2GgaI0iPw5svrhQ0wotKwBI3qt++HMtnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285104; c=relaxed/simple;
	bh=jKehI41sAfsedYMKHmtwSlMchJz7byokQgPhCKXEKq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLdJiRZOhhT4Jeky10K/z0/6dsthXe28plRu8+fOevZHdJLMRISLFBl+FXWHUyr6SHmYG+Vmo2/lNDgy0vZspNaAayjP/jdBH+vkeL4QzalDOr9/BbedUd3/t7d+j9g9XnITBAmb6cP6Vtcpu382OsB66dUutmB0pgCBVAACaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4xHqZQl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4xHqZQl"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so3727261f8f.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774285101; x=1774889901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPJJ9GcVSp1o+cZ5kD3BkHSWftPMYOCNSPAAovOpsuU=;
        b=E4xHqZQlNxo0DhbLLbGii30xUIZTY6kvTiLj7OQQqWGfbbEmb5EWR8yBPI6V3U+zav
         WWGDpwK7AuNDTUTvmr6igQf4xfBpoeGsdH7q4qdpsIFmhPlFpnndmnv958/y3s1m7HZn
         rqJSoemGk1A6uyg/IfWCpWvtlsd5qxc6XfJjtTCdb2JyBG73tFVssWLduGlFfxXiCnXK
         6S8LQy77YIQW2M5mKSc97xF7kZu/J2rMkQRYh6XIa8IJ84IdzvKuVPUpaaFOsTpFr4PY
         GEh5+XBpqyiy2qV4ZeA6YzjRRzlXbQPbg8/BX1YBBVSHxOA+rTTjEgd04M+ISU4igZLq
         QSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285101; x=1774889901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPJJ9GcVSp1o+cZ5kD3BkHSWftPMYOCNSPAAovOpsuU=;
        b=R3rhBy5VQTmuIEWw9OzLAu47Y41mtNOZkPIwcmmx75dDeYQ45i2g1ujAyMgQntAtXQ
         N+COHkPHbXbtNM26J4/qUiaXsS3HwOwG13wzxESqF1ds9a7DiLxaZPR9gBybgI8gcohH
         CXu06bxu9/HmkVTEdaDciHrKY99Pme3q3ww+HLQQVdF39Y9tPFFckt6gpM6eL5bXsBsK
         82jrRh9y4Wx1YtMbA5w9hdMHjVY3IiS2mk5cqutCiTyXzolYfvxfKN5rjBvSJ+e6erXQ
         fNrEka1/p25BgcyoszsC5eWfAmN/egpPuHwj2FbSwKs3Nv/1Y+Dc0jL6mlG10b5emoTS
         oZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnLfDk9HWyeU+Yc+2n0dUJggMRZQz5u14t75PBMBXoFcGYHq3lcVoHacjRsF3x0uTSl4ve4mB3ncQvu6bTlYeyJO0Wo/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaQURqYcIctrmREhN9c6zE+eMIKde8uCKid47TtoH0o6YgT7M
	/5f9rCKs0N5cg5Ba7kZrmnDeaNWAQCvCdhchRlVallGWy4XFzDSohiwN
X-Gm-Gg: ATEYQzzxU6FHbwbbADNXErGz81F5fa1ko3NAV35eD13O2LX449CfYi5w7gHsLMzpgKB
	zLq7y4vsR0H5F85TqHsqIEyhYAjTyhKIRSsA9fA8j142jHYw7jTd1xwFXhaXMhG3DASsso1ReTN
	rigxqr/yGvwPwwbPlSmfSToEwnpsQRrd2jt1K8EiXSo4RjV5s6IEulv0EiFwsoHnChz0jn1oKsv
	xqy0vfvJec/9sjlrsJsoeJQ2UawP5l+kxg/fO/ImJRIofDIBfdB8jNpvNdHDEUCfsRBsWLfYydw
	aNVzN9InXT5rNJr88VmRCQZlGTe0fyRavmKAKyDdgT68+ufnnYfMfCbMaNrm9Au0Jb4PRYiFx1A
	ZggP4+S9QMGAeBQGogTO3/MrvDPguzvVM2yrukkgH6DoIKjOxQPKVrPHyTAIie5tIAGXqh+EqeH
	RDfx1SD3SApeq+P20orCCVfNw7HcSY8+wxmXV+GmXttY+9ItBv
X-Received: by 2002:a05:6000:2302:b0:43b:63d9:6360 with SMTP id ffacd0b85a97d-43b80579c39mr528000f8f.20.1774285100997;
        Mon, 23 Mar 2026 09:58:20 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd0dcsm29994030f8f.11.2026.03.23.09.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:20 -0700 (PDT)
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
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>
Subject: [PATCH v7 07/11] selftests/landlock: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Date: Mon, 23 Mar 2026 17:56:49 +0100
Message-ID: <20260323165654.193957-8-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165654.193957-1-gnoack3000@gmail.com>
References: <20260323165654.193957-1-gnoack3000@gmail.com>
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
 tools/testing/selftests/landlock/fs_test.c | 390 ++++++++++++++++++++-
 1 file changed, 374 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 9fdd3b8f7b11..f8cfd31335e1 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4358,30 +4358,66 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
+	ASSERT_LT(strlen(path), sizeof(addr.sun_path));
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+
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
+static int test_connect_named_unix(struct __test_metadata *const _metadata,
+				   int fd, const char *const path)
+{
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+
+	ASSERT_LT(strlen(path), sizeof(addr.sun_path));
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
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
@@ -4393,9 +4429,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, cli_fd);
 
-	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
-	ASSERT_EQ(0,
-		  connect(cli_fd, (struct sockaddr *)&cli_un, sizeof(cli_un)));
+	ASSERT_EQ(0, test_connect_named_unix(_metadata, cli_fd, path));
 
 	/* FIONREAD and other IOCTLs should not be forbidden. */
 	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
@@ -4570,6 +4604,330 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 	ASSERT_EQ(0, close(file_fd));
 }
 
+/*
+ * test_sendto_named_unix - sendto to the given named UNIX socket
+ *
+ * sendto() is equivalent to sendmsg() in this respect.
+ *
+ * Return: The errno from sendto(), or 0
+ */
+static int test_sendto_named_unix(struct __test_metadata *const _metadata,
+				  int fd, const char *const path)
+{
+	static const char buf[] = "dummy";
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+
+	ASSERT_LT(strlen(path), sizeof(addr.sun_path));
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
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
+		struct landlock_ruleset_attr attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+		};
+		drop_access_rights(_metadata, &attr);
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
+			res = test_sendto_named_unix(_metadata, cli_fd, path);
+		else
+			res = test_connect_named_unix(_metadata, cli_fd, path);
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
+		res = test_sendto_named_unix(_metadata, cli_fd, path);
+	else
+		res = test_connect_named_unix(_metadata, cli_fd, path);
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
2.53.0

