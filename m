Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFE2F0C6E
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854936; cv=none; b=GVC6znu8cTsMDmOSgjIlD1Lu0JHRi/psbFw+BwE1Zxfhqu+x8xJQOUsleDRImp+eqhoAb7r58nCQc0TX/iwggVBB2kb6Zjzot6LUZwLNILdXj/obv8Dpou4Nhq9atXhOn3PNjXjxhqQJjNiQfd3LCbE0bSV7Stz/ZFdj0ycTuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854936; c=relaxed/simple;
	bh=APRgeNm7u4UPg8AZUs0v42sMbHeJrbCN3ROTSmDiSXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmiXBjsF7WSxWjMVD10gmiohf1aIIBBiKDwHWhvyYUgcft/wVwhLuwPKiD//1shmOltM/nD3bzdxeB+4xohi5ub/fCSWsduSZnfGOmVzPAG48tMb/XjK9Q6LzWMG8KPKZK6j6KDkYTZ4MNyNheKa6zchvR4JURKQScywwxY/5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igCo7fWD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igCo7fWD"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b871cfb49e6so755687866b.1
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 12:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854933; x=1769459733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O25v0JI+We923SGvPSgncVaI07C6IyoXkXK/BmdfD58=;
        b=igCo7fWDowmH9uVdSr97rMmJJsxvQHQgnzXR7qntFhEanNjakSr/z5TJuX9FJ+jP7G
         H3GdsSJnr9LAv7MITjritJTy/n6yM9HzdSUpE6WayLEDHHcli6kItTXr7gAOK073vKKv
         93LPXjfSOYR9h6pRXC48CHQX1fNrESBkXwuhls1DtnRYKltyb5/8zAR7/ODp9Jo37piJ
         Pr8UhRvRMK0sTpdoFzHmZPk2Yk8YSgllHXZx1gaBoI5dhzfgMmnAJDF/eWCfI4m3Uyyn
         QdVvUc9yNaXIlCx0inU1fWpTNk+p1NovPrCVZQjclJCgHDcDvPr1VoXLvYPaSblAssfv
         3c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854933; x=1769459733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O25v0JI+We923SGvPSgncVaI07C6IyoXkXK/BmdfD58=;
        b=SlEjIROlkpamJyKwQAvBjvW3MB5jLrL80D48iojj63zLpTWzEXjmZajn5nPZ2bZ12n
         ZcLp5PXiVOKnF89RwXPWButlbjddcoT+rR4FQVVoz7828OJkMguCxroNN7Jw96YQj1qs
         QXp4lupHrWZ3+kmmXBBATx6RadnPjdRXiS86x/tmsGQXRcThM+qu8BbJPbQX1FcS1dDu
         JIWRv1Rhuf2a3Hm70yP6TZq5PmQh6MtpWYL+CV4Jo3dSC+/JmL8Ub5oeyf6fWIcr0+ur
         vL5nph3a1xdacitv9+IJPmK6rLKCROq2hfPZaIgUshyRnYlSvhejP91KQT8BDuBmqwA8
         4WKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnGI9k7+81ZeD2iQ9WgZMP1iFcygf/jjQZnQxQ7Wc53hoft+sxkeXMej3nqrrIUWfKv7wc0x2+k7J3IbUr02+GX4c59gM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IgoryGTPTLG00k/sVXwP+YUcZg29qPqwtALQLDthp4oxz30I
	gcT8NgTPmgl9oHHKQrcMWhIzgqToDkaBYQcOJGn27cI6NNt9OZVeJsvP
X-Gm-Gg: AY/fxX5plfYTOZD2rlR2Vum/ts71+hTxiXyFUY7oV5HJikgQPfbw4NhbWd2BMkpNz/r
	TUarHw0SCpMzCkhePGCJtTJ8wP4Q+nEeFPMGTkRbCB8KLFy9/XA4digkKlISE34gAms7HxvI5mb
	lsYko/Rt/WlAGQsV6dv9VusCxRsgSYuhdi09gvFMUxLH1MSR9igyna7rO8tXDH0zMYsVU/aWlU/
	gCQQf4Zllh2pMUFG5anTNhpYlcYk4rBNphSWI/d2AP90zlyt+6Z7I/VRs4mbXvEJmCmhJNT8NQo
	TIi6CRisR0Qs+QoFB8GVuD66oSbmvqSJEWJSY48Mt8ryKvcLYCt6QxDU8U7ezXlqfB0rsSHi7w/
	5InYp6z6o35ZX8Cc5Hm4FsNCbYja11gnHeT1HLVMmVrzPff9SRDMtprw9qAgnXg1cs1xUyAA0ug
	o5ZlPPNo9nMuVGQ8Zjx9/r60oivI0t1sLHPUMS
X-Received: by 2002:a17:906:730e:b0:b87:115c:4a30 with SMTP id a640c23a62f3a-b879690c497mr1010984966b.16.1768854932755;
        Mon, 19 Jan 2026 12:35:32 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795169017sm1231235566b.18.2026.01.19.12.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:35:32 -0800 (PST)
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
Subject: [PATCH v3 4/5] landlock/selftests: Test named UNIX domain socket restrictions
Date: Mon, 19 Jan 2026 21:34:57 +0100
Message-ID: <20260119203457.97676-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203457.97676-2-gnoack3000@gmail.com>
References: <20260119203457.97676-2-gnoack3000@gmail.com>
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

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 218 +++++++++++++++++++--
 1 file changed, 202 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index b318627e7561..5c2780efa266 100644
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
@@ -4570,6 +4599,163 @@ TEST_F_FORK(ioctl, handle_file_access_file)
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

