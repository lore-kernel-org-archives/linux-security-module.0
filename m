Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078236920C
	for <linux-security-module@vger.kernel.org>; Sun, 12 Apr 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.178.41.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775988521; cv=none; b=FKGh+MTSEpT+h3ug3ziMYS6SdjdCbif+in/YRDk2iqL2OAJU1C1z75v2+DqpV8Yj1j7tSYRrxSGA24r8XegxwYlZKnzc2Pt8gIvnJRFIpptiZU2Awu2zGQeX29FtXNWyTkL2SdMiKfMEtPidSKV4DvaPPjH/QR4u7JlNVsWKedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775988521; c=relaxed/simple;
	bh=xRCn5DDI5qtGs6pqXeqexgOmqmpWBtaeqfrXhj4gqT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhwCz5XEoi6Z0YR2aZK6EDoZ6xw9Vvq7nxQba6JrugvTz5JuznlzfR55qlSd97Gc5UPBwd2kUGi0/kBkPOGvNszzBuYP2t6FnjafqnvYEnxnhVnwsONo416I3StIc7pqNKNuVH/ja4hJ0ncGc1wclF1PD0Zu6M8lfi1jjFa3HqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr; spf=pass smtp.mailfrom=bencteux.fr; dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b=BrZpnUv0; arc=none smtp.client-ip=51.178.41.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bencteux.fr header.i=@bencteux.fr header.b="BrZpnUv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1775988108; bh=xRCn5DDI5qtGs6pqXeqexgOmqmpWBtaeqfrXhj4gqT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrZpnUv0czNM2MS4kR5KqmsOkrOQwtDDEtyOwDxu32Mx0N92JYPHtwLFmNmQFvB6v
	 yHLPWpICqJatL6Xp340bfQwFlk/GI5x1oeF1oRfrggBDiABcEUBQCpThOgYNA0HI/E
	 8t5mfTne7Jf7Yih15tkEiuPrRSSMvq0api4AxXas=
Received: from localhost (lfbn-idf3-1-911-123.w90-3.abo.wanadoo.fr [90.3.226.123])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 241A540333;
	Sun, 12 Apr 2026 12:01:48 +0200 (CEST)
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	jeff@bencteux.fr
Subject: [PATCH 3/5] selftests/landlock: add tests for chmod and chown restrictions
Date: Sun, 12 Apr 2026 11:50:42 +0200
Message-ID: <20260412095233.34306-4-jeff@bencteux.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412095233.34306-1-jeff@bencteux.fr>
References: <20260412095233.34306-1-jeff@bencteux.fr>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds basic tests for the support of chmod and chown system
calls restriction in landlock.

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
---
 tools/testing/selftests/landlock/fs_test.c | 99 +++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index e5898dc7e53e..13d276558146 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -578,7 +578,9 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_CHMOD | \
+	LANDLOCK_ACCESS_FS_CHOWN)
 
 #define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
 
@@ -4111,6 +4113,101 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
 
+static int test_chmod(const char *path, mode_t mode)
+{
+	if (chmod(path, mode) == -1)
+		return errno;
+	return 0;
+}
+
+TEST_F_FORK(layout1, chmod_file)
+{
+	const char *const file_rw_no_chmod = file1_s1d1;
+	const char *const file_chmod = file1_s1d2;
+
+	const struct rule rules[] = {
+		{
+			.path = file_rw_no_chmod,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = file_chmod,
+			.access = LANDLOCK_ACCESS_FS_CHMOD,
+		},
+		{},
+	};
+
+	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
+			      LANDLOCK_ACCESS_FS_WRITE_FILE |
+			      LANDLOCK_ACCESS_FS_CHMOD;
+	int ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd = create_ruleset(_metadata, handled, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks chmod rights when it is not allowed, mode is arbitrary */
+	EXPECT_EQ(EACCES, test_chmod(file_rw_no_chmod, 777));
+
+	/* Checks chmod rights when it is allowed, mode is arbitrary */
+	EXPECT_EQ(0, test_chmod(file_chmod, 777));
+}
+
+static int test_chown(const char *path, uid_t owner, gid_t group)
+{
+	if (chown(path, owner, group) == -1)
+		return errno;
+	return 0;
+}
+
+TEST_F_FORK(layout1, chown_file)
+{
+	const char *const file_rw_no_chown = file1_s1d1;
+	const char *const file_chown = file1_s1d2;
+
+	const struct rule rules[] = {
+		{
+			.path = file_rw_no_chown,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = file_chown,
+			.access = LANDLOCK_ACCESS_FS_CHOWN,
+		},
+		{},
+	};
+
+	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
+			      LANDLOCK_ACCESS_FS_WRITE_FILE |
+			      LANDLOCK_ACCESS_FS_CHOWN;
+	int ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd = create_ruleset(_metadata, handled, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks chown rights when it is not allowed, owner and group are
+	 * arbitrary.
+	 */
+	EXPECT_EQ(EACCES, test_chown(file_rw_no_chown, 0, 0));
+
+	/*
+	 * Checks chown rights when it is allowed, owner and group are
+	 * arbitrary.
+	 */
+	EXPECT_EQ(0, test_chown(file_chown, 0, 0));
+}
+
+
 /* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
 static int test_fs_ioc_getflags_ioctl(int fd)
 {
-- 
2.53.0

