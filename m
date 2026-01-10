Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B82346AC6
	for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768055692; cv=none; b=ijBvgZoR80nycRYdf5DVC+UK2InkA09tAeF05/j0z6idHJIEq1ORkDNvzUYtJUMyDxHiyRYgDhy1dXEN0Kw/WsKdTbI0/3x9eTgyHUNNHINFG2Sd6QDxymFGwRHHPvqG0Myvlm1mHi/lmI2oPZoPw1qZySlKxrdvHsCHbCbaps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768055692; c=relaxed/simple;
	bh=ersSGzq/uMBvQgPgK/53cSWWgQS4GQZSyzoPv/AygYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfHL04AyKgnFDo51/Ic3hio+JIytiPxXxGVzpDBabIm9MzqjSrLLvQkJLY8i5pEWszsCv0EHYqI+dUTs2kkyL6OzGI5BGLs1xkKh0628qO9yawpEZdj9nrvluGEMwkQGXfoCMXmuacfzrMTxoForKa9wQ5uKVV7Yaf00y13Yxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVfv7ivW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVfv7ivW"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so7825622a12.1
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 06:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768055688; x=1768660488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijwlJAe5HzeKYOzMJDwcQxT/c8nMdGxvS62e4u0+20I=;
        b=SVfv7ivWCOq4NW3Dgo8ItqmqBmDu8glvf5mdXz0ukPf/tXSS38j6smF5Ce7BKuLK36
         aCHHP9hpcYv8AaQ7Q2q48t/DSLK76AH2SDlOpyb/fa0VaEaLobuknP9O5FtZNmnPLlb9
         TB2gy69uvU2eUvO2vTShp9EBWF6AfX/X4JzDNjPVnt8HD5T2hHqYMEzT1Ip5NiTmwBJg
         25FLsNc093TjBFyCGhcnSbObg1xhxKX55f0YWszC8mX+XOBJeoEotTVD09CqiXEXE1mv
         v/TetnSs5jet5XrPH+L9nFI1HCh1/FqICIMIO8yrPtXkg4DqOxNSMB4YI7S4h1pJeUna
         sw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768055688; x=1768660488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijwlJAe5HzeKYOzMJDwcQxT/c8nMdGxvS62e4u0+20I=;
        b=TkxrI85Z8+vsYesQHn7IK9q3zzQ+yk5ZkU+z7NLuu8YMW1VC4Zf0U5BJG+EUAvkU0j
         b3/ZMzol8n+6A2aE7KRmE0YU+DozVDj/I4Nh4ZGrbsnKEjIIcMPXotkEwWWI8/4dKx7a
         F+jnBPYVkjBrCpQ+VT1sDEvVm6y6Sv8f96d4tuTr+QfvK51R3tRxgQjf7E91Ihkg+Unj
         XSPopvQ3JsCAjrn76hMpYo/crSRkH++mpkMc2kWQgU7+QPvdNBKqz/iyYDLQezakq2dR
         nCyCbN7KuJR9W9fD+EdDnwZvyXlh6AhD9g8+ydLswXNCKCvLKadnCXnShZFH6/YCYFj5
         4MTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0P6EMZweEOjZmOjC9iNNTObKA949VT9ViJ5tKEdnBdoVJFXs2EY9lcK1/4ZHDqS4N9/ULc82QgCX7r+54fAwgf7N6gMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwicQABkLK5+Rn5WwOYa83X5uMdr3nbgn8918h6N4I4jZ0p5kNC
	vI0TqpqkmYTjCBeGbVw0D5m5UyH9DXIC2Fax/CKJitYlmi3El+NInnSDUjlOaSm/
X-Gm-Gg: AY/fxX6sgoRBdQKR788hjz9lhRh2D4i3hNI8rvWbD/4b9yH1FOYSbtocCdyEaBKNC/h
	kjd0gWG5WGdlSpPQHuEB6r+3P/cGm+FN8Ro70rj3YnZ3karq63izm1/dZFAf+IuGaSaDS8Fi7II
	vUvkdurrY1gGlMg3uqpxSUDMKhhM6idbL5ZaXwvtbyhki7w7KiUEWH7GNJcHkQOUfAQrAduhTYg
	QR1K2uXf2WwAIoMgOaK2GYI98bgPZrj1s39FROTj9zY8zowvB0SuO+hSDSM2cdToypxGv8oCkf+
	lzull1w2HMKhhnSLqtt1BWkG4+k0AKtNdLNeNeaBbnlR5BujrK85VJ0vG2+310890wfkFYeo9UT
	VU4lR6v0aP+OoEozckjApGxdroNmoI/Bzqc6Hke9Kg0wfOVw63T22Wz+83V3xtI6Y3Xt2oIsHDO
	sXKLXOIOnD3cnvElcvJAprfuN9FsbNL1bN6KuO
X-Google-Smtp-Source: AGHT+IExcB+j21V/o8G2rTw8mojdxL7CQXsit8HsG/+Y/VSquhii72Nh40q5jM6rNNLR+oWYEcUEEA==
X-Received: by 2002:a05:6402:3546:b0:649:ce39:3bd0 with SMTP id 4fb4d7f45d1cf-65097ea5f12mr12188617a12.34.1768055688212;
        Sat, 10 Jan 2026 06:34:48 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d508csm14404756a12.13.2026.01.10.06.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:34:47 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
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
Subject: [PATCH v2 4/5] landlock/selftests: Test named UNIX domain socket restrictions
Date: Sat, 10 Jan 2026 15:33:01 +0100
Message-ID: <20260110143300.71048-8-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110143300.71048-2-gnoack3000@gmail.com>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Exercise the access rights for connect() and sendmsg() to named UNIX
  domain sockets, in various combinations.
* Extract common helpers from an existing IOCTL test that
  also uses pathname unix(7) sockets.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 218 +++++++++++++++++++--
 1 file changed, 202 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 0cbde65e032a..e1822fa687e8 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4360,30 +4360,61 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
@@ -4395,9 +4426,7 @@ TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, cli_fd);
 
-	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
-	ASSERT_EQ(0,
-		  connect(cli_fd, (struct sockaddr *)&cli_un, sizeof(cli_un)));
+	ASSERT_EQ(0, test_connect_named_unix(cli_fd, path));
 
 	/* FIONREAD and other IOCTLs should not be forbidden. */
 	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
@@ -4572,6 +4601,163 @@ TEST_F_FORK(ioctl, handle_file_access_file)
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
+	const int sock_type;
+	const int expected;
+	const bool use_sendto;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_handled_not_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM,
+	.allowed = 0,
+	.sock_type = SOCK_STREAM,
+	.expected = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, stream_handled_and_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM,
+	.sock_type = SOCK_STREAM,
+	.expected = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_not_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM,
+	.allowed = 0,
+	.sock_type = SOCK_DGRAM,
+	.expected = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_handled_and_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM,
+	.sock_type = SOCK_DGRAM,
+	.expected = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, dgram_sendto_handled_not_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM,
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
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM,
+	.sock_type = SOCK_DGRAM,
+	.use_sendto = true,
+	.expected = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_not_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET,
+	.allowed = 0,
+	.sock_type = SOCK_SEQPACKET,
+	.expected = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(unix_socket, seqpacket_handled_and_allowed)
+{
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET,
+	.allowed = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET,
+	.sock_type = SOCK_SEQPACKET,
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
+	const struct rule rules[] = {
+		{
+			.path = path,
+			.access = variant->allowed,
+		},
+		{},
+	};
+
+	/* Sets up a server */
+	srv_fd = set_up_named_unix_server(_metadata, variant->sock_type, path);
+
+	/* Enables Landlock. */
+	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
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
+	ASSERT_EQ(0, close(cli_fd));
+	ASSERT_EQ(0, close(srv_fd));
+	ASSERT_EQ(0, unlink(path));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.52.0

