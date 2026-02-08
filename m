Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819472DA75A
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592287; cv=none; b=hW/4Wg1jSGG9b70zOdkbZJng/ZrcmceCJ9C99If1/yzM68sFtXQr6K0bUSX0fUWSO8bfZT83OKt6qRoFTxSOxmPNo67hMKyCUul50DwokyUMlh6n8LWrulG2s5bDZr6VoVGI5tPhKa1Y+XfHEUfzbNXxDVEL53tX9R1ooWiYAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592287; c=relaxed/simple;
	bh=sULW7AKZkprS5H0yAgovkL4mD/ObX2IWUh9D+jvoDh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asfBYA5zYA8IV0unxhKlwk5LCHP+VG2HhvJRBCoAk4+gugrED+4EpVVc9GhCqbaFjK1oXLaNu4rHoYYv8lohNCvj0a/6vLtT3etPWswTtn1beuraY47D55x7MMmsF1mPR1mCGlGKrBsXHD4mH/XAhTpZ2zq9kwV6N24bVKh/UM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXbhoOlr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXbhoOlr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so36815365e9.1
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770592286; x=1771197086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLxcs4WGtxhBWvlTlclLASEvc1mlwf6PORvrvWWb93M=;
        b=mXbhoOlrsGC+F6PqdCBS2zJWMKSTaU19p5KQqE1KW9vWhh2cRlx9iLoc7DIZSIAhBS
         dlJTmX1qbQ4dvcUYFbaTn0T8CtM02hXrTFYTxA0gvCQTY1NCkoEQLeYK4wlPlIT3I8P8
         6npDIDUwwGdcDwtETrx/XAR622xqS4u7Yl97GZ4uVZ45qBI6ovG+zplCwMXdYYzvBwBN
         eBF2Xl+lHlvJICGFAoHEbZWOHDAWhHpqt8UDk/xxRslxxfDOMn5ylPgURB3wqHTsKYkd
         qV+ZCgj/HobJYrKUEFvKUjO2+2dfsnzi5HKTsIGrPL2/YaeKaJ4jwHXN1Zoz1XXSsUCv
         OTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592286; x=1771197086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLxcs4WGtxhBWvlTlclLASEvc1mlwf6PORvrvWWb93M=;
        b=A4X6KPVkggneO5hXxxqyF8i6i2hOL6YtWkIdoLFTphjjBnXcgGt8YNPXv5qdLgW1ST
         kc4IQhpxvgx7Js4ZqfdSlFBHXuHvpvibt1miaNZMrTEsC/0YSgJddtel8tPGzYmhg2+5
         5BK00XPCPmjY6bPhd2e3y9emNl+P3ha8fq/tTfrBcgIpqWYMjm3FRNrrTMC7s929CUTx
         nPmjD3GJhuv7LMK3rZWCcxo1/ik7Ea4ahKu53tN3++yIsR6HVd6Tg63AzDZ5fWimTUF9
         oLGWGEp8doaQoKs5rch0RjVbVIDYf5UNpYwGcUfhJaTT+XdBxMCA+vVQwssZeLMx9ZiP
         x80Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEuwnTWpORlWoAr0Qt0BVWM6tdSxdn1iVjA0w8fWmz6P8HchRIuqJI5opq47RLfO62MuOdGerbiNdaw29BgtS6IfwTPo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcv4zpTbxDTGRBWYIY2jBvll3Z07+F4o+1H39+AjALyTE0SqWL
	RkYA9xnCqOLtU1Ys8V+H0mz0jUbZ/RtgUBu9hLqwZl66uiFVN4jrxElQ
X-Gm-Gg: AZuq6aLmZmofQFP+8LZ8+Bn8ffUFxifGbbh9W3BLoSdjVKdgMx/snYYsmAgLarr7K0E
	eN+ib09V12VRXIii2lqeSW/NVDr7r/LA1HnVKsHXp7DAhIm/N3wfY/6X2bFAeZkeamwjJv2rYqN
	P5TNV9shAK9zCS6BlpPi6a5MSFZarYCl3zkigS40O42CWR4Uxl4wEwy6dUB0PMk9v0Q/DHLMlkR
	cg5WkpfSX/c+64tpL2M/yEJKxx/og8DDmjK3/vCDIeEOoL0BqqpkdOmODBNiTOKE+q+Dp+vG5LT
	pnBmn4HWws9NjTXjCivCRCIZAmM24+q8yyIT899BCifOphwU7Ada/WhXMl2kmtYNc1PfSHJq2Y6
	xfG2ouaZfikPD+NSDK57MRu9DbrsVFTAVo258CAqpYusJstnG3458A47/cXba3bjOPqcDGUOoeX
	OwdYYXlswVkKWcOQVi0eRjIyb2V0DXV2cejz5Z
X-Received: by 2002:a05:600c:64c6:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-483201fffeamr130562955e9.3.1770592285779;
        Sun, 08 Feb 2026 15:11:25 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376a78d796sm6595226f8f.20.2026.02.08.15.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:11:25 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v4 4/6] landlock/selftests: Test named UNIX domain socket restrictions
Date: Mon,  9 Feb 2026 00:10:14 +0100
Message-ID: <20260208231017.114343-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208231017.114343-1-gnoack3000@gmail.com>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Exercise the access right for connect() and sendmsg() on named UNIX
  domain sockets, in various combinations of Landlock domains and
  socket types.
* Extract common helpers from an existing IOCTL test that
  also uses pathname unix(7) sockets.

The tested combinations are the cross product of these sets of fixture
fields:

* {{.handled=RESOLVE_UNIX},
   {.handled=RESOLVE_UNIX, .allowed=RESOLVE_UNIX}}
* {{.sock_type=SOCK_STREAM},
   {.sock_type=SOCK_DGRAM},
   {.sock_type=SOCK_DGRAM, .use_sendto=true},
   {.sock_type=SOCK_SEQPACKET}}
* {{.server_in_same_domain=false},
   {.server_in_same_domain=true}}

Some additional fixtures exercise scenarios with two nested domains.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 381 ++++++++++++++++++++-
 1 file changed, 365 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index b318627e7561..9d3f5dab4567 100644
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
@@ -4570,6 +4599,326 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 	ASSERT_EQ(0, close(file_fd));
 }
 
+/* clang-format off */
+FIXTURE(unix_socket) {};
+
+FIXTURE_SETUP(unix_socket) {};
+
+FIXTURE_TEARDOWN(unix_socket) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(unix_socket)
+{
+	const __u64 handled;
+	const __u64 allowed;
+	const __u64 handled2;
+	const __u64 allowed2;
+	const int sock_type;
+	const int expected;
+	const bool use_sendto;
+	const bool server_in_same_domain;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_handled_not_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.sock_type = SOCK_STREAM,
+	.expected = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_handled_and_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_STREAM,
+	.expected = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_not_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.sock_type = SOCK_DGRAM,
+	.expected = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_and_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_DGRAM,
+	.expected = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_sendto_handled_not_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.sock_type = SOCK_DGRAM,
+	.use_sendto = true,
+	.expected = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_sendto_handled_and_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_DGRAM,
+	.use_sendto = true,
+	.expected = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_not_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.sock_type = SOCK_SEQPACKET,
+	.expected = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_and_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_SEQPACKET,
+	.expected = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_handled_not_allowed_and_same_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.sock_type = SOCK_STREAM,
+	.expected = 0,
+	.server_in_same_domain = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_handled_and_allowed_and_same_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_STREAM,
+	.expected = 0,
+	.server_in_same_domain = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_not_allowed_and_same_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.sock_type = SOCK_DGRAM,
+	.expected = 0,
+	.server_in_same_domain = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_and_allowed_and_same_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_DGRAM,
+	.expected = 0,
+	.server_in_same_domain = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_sendto_handled_not_allowed_and_same_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.sock_type = SOCK_DGRAM,
+	.use_sendto = true,
+	.expected = 0,
+	.server_in_same_domain = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_sendto_handled_and_allowed_and_same_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_DGRAM,
+	.use_sendto = true,
+	.expected = 0,
+	.server_in_same_domain = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_not_allowed_and_same_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.sock_type = SOCK_SEQPACKET,
+	.expected = 0,
+	.server_in_same_domain = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_and_allowed_and_same_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_SEQPACKET,
+	.expected = 0,
+	.server_in_same_domain = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_nested_domains_scope_path)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.server_in_same_domain = true,
+	.handled2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_STREAM,
+	.expected = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_nested_domains_path_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.server_in_same_domain = true,
+	.handled2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed2 = 0,
+	.sock_type = SOCK_STREAM,
+	.expected = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_nested_domains_scope_scope)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = 0,
+	.server_in_same_domain = true,
+	.handled2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed2 = 0,
+	.sock_type = SOCK_STREAM,
+	.expected = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_nested_domains_path_path)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.server_in_same_domain = true,
+	.handled2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.allowed2 = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+	.sock_type = SOCK_STREAM,
+	.expected = 0,
+};
+
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
+TEST_F_FORK(unix_socket, test)
+{
+	const char *const path = "sock";
+	int cli_fd, srv_fd, ruleset_fd, res;
+	struct rule rules[] = {
+		{
+			.path = ".",
+			.access = variant->allowed,
+		},
+		{},
+	};
+
+	/* Sets up a server (in the case where the server is in the parent domain) */
+	if (!variant->server_in_same_domain)
+		srv_fd = set_up_named_unix_server(_metadata, variant->sock_type,
+						  path);
+
+	/* Enables Landlock. */
+	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Sets up a server (in the case where the server is in the same domain) */
+	if (variant->server_in_same_domain)
+		srv_fd = set_up_named_unix_server(_metadata, variant->sock_type,
+						  path);
+
+	if (variant->handled2) {
+		/* Enables Landlock another time, if needed. */
+		rules[0].access = variant->allowed2;
+		ruleset_fd =
+			create_ruleset(_metadata, variant->handled2, rules);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
+
+	/* Sets up a client connection to it */
+	cli_fd = socket(AF_UNIX, variant->sock_type, 0);
+	ASSERT_LE(0, cli_fd);
+
+	/* Connecting or sendto to the Unix socket is denied. */
+	if (variant->use_sendto)
+		res = test_sendto_named_unix(cli_fd, path);
+	else
+		res = test_connect_named_unix(cli_fd, path);
+	EXPECT_EQ(variant->expected, res);
+
+	/* Clean up. */
+	EXPECT_EQ(0, close(cli_fd));
+	EXPECT_EQ(0, close(srv_fd));
+	EXPECT_EQ(0, unlink(path));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.52.0

