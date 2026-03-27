Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CE3537D6
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630169; cv=none; b=nR/LZyUynWwMODcR9X55WmQ3uNKU8k/RfnLfOMUIUurughY8ojidmDLU9mpZwQZ3tGA7cVMVU6n1t8ZbPc9vKlnQDjczMDjW4N7QlmdHZcmXiQKkwYBL7YmSr35Qya8iHs7Yc7/pDQ7pV80tOKSyyOePMpMlG2Xk4qLr3UqwV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630169; c=relaxed/simple;
	bh=jKehI41sAfsedYMKHmtwSlMchJz7byokQgPhCKXEKq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g24e2OkGEvNCOeO846sY39AamXsHJh9av6dUXjilqlzPCjWU/FIoKZ0MYnLiE9acIQUNF0obu5JMO73ZAosFNqMZce+8jaXw/FIWoAd3Et8Z8DGwtzG4yhmFY2crNtxLdT57FiNWiHZJRrWBFLf9XZGttl9qn2oE4GMjJ9jMjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTrcYSVR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTrcYSVR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fb439299so22164195e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630165; x=1775234965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPJJ9GcVSp1o+cZ5kD3BkHSWftPMYOCNSPAAovOpsuU=;
        b=XTrcYSVRl7ezdFcKwfDPrhgbwS78k4tvNe/7LNmyP78XDx5u/hAaxqTKR0N6beGb1M
         ke2xA99HlN5r8/QxclVULMGhEbcmsClYDPXpMprQu8U9RtVpG40yHjd4rgpU+avbY2+d
         /QfsNB58Gy2f2ekoAj9iwhgbDKdSiCZXaQtj5q9KewNPAIJVv3FtqGdF3LbhAlex0Ahr
         OytuiNCCPnPpL5aPkzL3L3dgYJqOkfJYV2aF2QvYXqlSfXws5gyH9YzQDKGWQdgorNsd
         Rd7U1l7uPv2P6yxaE5Mlmwc4h9kU/dx+yuTxo7FNeNwMGoJCGot8Gxbhwq9F7HAuNG5Z
         TNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630165; x=1775234965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPJJ9GcVSp1o+cZ5kD3BkHSWftPMYOCNSPAAovOpsuU=;
        b=EbZatahcWW3FXzCiCGamicqcWAC9aWQsGbY4SBFA3aEyMWjpde9fWDn0oPl91M9cwZ
         0k28+yWbtZc8U4V3y/fvAynE9H2dNacxB7RPAkOCKYVIIfsyqK72Wyj0LVNG81iwYp4c
         5yFIi8P852Yj6JXMUlwWA/nPwcn4j89XxMCCRVXX8XKeTrhgWplT+ZRPWh6hdrXr+80j
         crLbYb3x7fIGpT5Ql6/naEri32fYuVLA3SEXev56Gj/Y5A4yDOcJzYcQlX3+FW/LK4FR
         y5mZ8be5HTDc9qu5bc0VFp58HKaYKIx/Zn7iOJco0L+x+YhgYRPz+jAfS/mSg9O6uz6m
         tbxw==
X-Forwarded-Encrypted: i=1; AJvYcCX7V8otsl9vy28/fJrUM5oTpOhRFJYxLzO5SY4wmHpSinGXRiZfnW7GR5G/N+7SidKVwyGcqlWFSSuInHqWyOvelXo/Zwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Lfi+r0hP4Dra+Ri7cJG8LENFpgCqEjZ2VuUkX+FJmU6To3zV
	BW9watFFQZIkOfdjX368CVrxi/m7Hvtzd0wJxMCTlxDTNz8feUcIBcop
X-Gm-Gg: ATEYQzx+bgU0ghOwvr75xpCrLd2HejrK0Vf1t7UkszbKtF7znUG2lSDOJe1BKiEowLH
	MzVRrh+acSyfPmW2c89c0sD/JubXLJ8GohLIZTqSHkmHSL4wfncBuN55KlQd01j+jIYFnULCJSP
	Uuhzxqaa81D+VXxgFQKzjxqhbGd12qGmbcSEge2/Jeodd6vGaYLIs0fjP2vy8ZdRNBBcHQkfOJ8
	XF3BTPu+C1Cl0YVm7vHxR1yS+GMwNkb16yn1SoF5423MG99XovxwylS1It8E6n4lpsOkVpoK/kh
	VjEpjGMSoCUlKjbAXzUUEATJlp2AM+HkXFEpwfEi84bQN86nqwvWA3IQKyFRZIJ4pMexmOz6Owu
	+xA8V2uGnp3JZaCB2t8ByYn04zbAT72s63lt9HOHAnsowr0QHkCFR95A4DD2ABr2l964twlOyJT
	JsXapQ/96SCDqcHOKydJ6nOqf8COciOlUBnI9j7Gtj9cnWs7Vn
X-Received: by 2002:a05:600c:608f:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-48728088485mr53033835e9.23.1774630165116;
        Fri, 27 Mar 2026 09:49:25 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9134fsm183729275e9.9.2026.03.27.09.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:24 -0700 (PDT)
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
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>
Subject: [PATCH v8 08/12] selftests/landlock: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Date: Fri, 27 Mar 2026 17:48:33 +0100
Message-ID: <20260327164838.38231-9-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
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

