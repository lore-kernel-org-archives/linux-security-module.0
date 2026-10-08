Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06A4854EB
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469671; cv=none; b=Sqg/qkpYPs92/52Oal7JwOQjqys8V6Nt5ysvQMt4ZQ9jUQ9DdqLcWUSI5KgJlDO+pW/qn61H/7TqRHAABolc6lUyLz/VhoYUbBPAJGUUu4rIbr5DdIRo96awmmzwg06VVbHJ/l0YqsMhFWVJ//JwO4D4PeQkM9Lt3MmumEAP/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469671; c=relaxed/simple;
	bh=oIBvfLhe9RcPC5ignGXxVg+6zSNgM/TGC4/KkChIzxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CD7ZVHYcodTwBSpnV6jDm9uOb6C/G/1u8SLm68zkjn63738qlYB2VmWyVl3M54P9JJ5z8OQ4DIGp/gKW/7jT3DBITJfEzduaMSIJozwsDuI2to5nq7WEBerZFaHsanI/bMm/AcTyHpI+NcUZqqAx7nUbFLE1jqzjTyE7IRnfQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDUHFX4O; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDUHFX4O"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a168355946so28386645e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469667; x=1792074467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tK1LsBycm7svFazpas1C9qQH6F9RnoZ8nfV9ERTawjU=;
        b=IDUHFX4O+FaRXF8xUU2HodCMctvg9S405vwpppz+cyCJNWzYmebR+HlCmMqbtYUFg0
         HrlmoyC0/YGT/trond8ia4MLlCEbNpU9V/imtEGIlDH6S5axhtc62+D2el26OUv0hVOI
         l71qQXy/cXiSNKDSCFBZPib+xLiZWsk2O8gwZnNyK2/yzHJJPkdhkw9Gb2QOZENa0YOi
         dMG/6AkFd29R7Gi1HM3TfmKJmND8WnzmmLx44S8TwLdFgW5SfKhrAKULZRVl1SmqErSf
         FM/LQ/v4A1dDFB8Betqu3P/o6x/vn7eWZS12z1z3/f5OtJYCC1zR0TXyx3lwM+AOM+4o
         JGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469667; x=1792074467;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tK1LsBycm7svFazpas1C9qQH6F9RnoZ8nfV9ERTawjU=;
        b=khosXa22bb/1DzI669r9/iY4rsPB/wy+ZevSvO03BCJ7UVFvgTz0LxFvFjQRHO9VJV
         EMJDHh3aoOhBZf+eKBjh2LUJGodFAET46aDrku1cKZNyB7WQyEV+4yBIl68dfLPNfilE
         9Lo7JGX0AYYnfAfO3KySKLM21ygrYocD4VnBdAiu0HUc7mxAjRIXyEf/IaH/xwz7KEAb
         24/EAgNXHJU8iSSJ/K5FnDIWsmwKRcvvbvQDZPYdZ2N1bWRUBRoPjsrAinQfqnxzxZxC
         K4HTzWbHng2JvMrEVTgcPno6jgNfoOYJX4WgpGbm6MADjhC5i2PUVqJyLqFqzZKRAkGL
         GCLA==
X-Forwarded-Encrypted: i=1; AKwUvBwuwwhW8mzhWiecZ9bwC7hF6U3y7COC+pOjLMoIxjW2O+asSA42vZUOqARlho6pFYQsgexDSG5KDmEm0qrcXpybqHYt2As=@vger.kernel.org
X-Gm-Message-State: AFuF++nvSZ0b6h3U6g/GB3JqDHrliX/2JzTTbQWh2DI9Fw4KKoQYuLjR
	/T5OyAVZd4hDKosaBF2DjseDotLNeVMaegtbxLoizAy4c4MSBnPr3mdY
X-Gm-Gg: AYBFou2OBZW5frbyprySMpTDZwZzI5WfrHuFK4POKx9cLc7NwL4g2wGF3r9YPsT8mAp
	3lmtCaAJ8QGJTIjufH64Hm4AYdCwitNE52eHGeOmBwVGB71cnJQJznP/THizUQcuUzoxDhpPJKz
	NLZPwMNNjAnPaK5K9iVjSgNI7OTffrzNb0KxV5RFHCBWxibnsQKk3HOuu8D4wze5Sib0irz8D+f
	VZemtmy5iEE2KWE7cyz09V4NR9sR+ozmQxuX2ZRLc/gwWgrECCtT25eRAxJcLwcDf6wKHqChnPn
	iEdr4SvzI3MC5Bg65s6zzC48lV5CMxtv9b7NrGYWSIZi3BzaX29dHzYXFeXgJoZb1ko06J4J4nt
	SvOR9zsCIV/1U4VoamNn/XjffO/AYahJaEgnwkK9PsdgHTJfRoB9ZuvYEJhRVHxjQ77Qv0MScrL
	yNpBMsDNLtArSY50NEDrpkCKDx0PMqug0GZ8sDzMK1pg1rgN4Ys9iaP20d1b+8a4nIi2t/FhksM
	DJGEX88UtpnqJZ9+6KdVPg=
X-Received: by 2002:a05:600c:a104:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-4a1815a339cmr75868655e9.22.1791469666392;
        Thu, 08 Oct 2026 07:27:46 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3d3eesm13331756f8f.53.2026.10.08.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:45 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 24/27] selftests/landlock: Use ASSERT for syscall failures before errno checks
Date: Thu,  8 Oct 2026 16:25:53 +0200
Message-ID: <20261008142604.39107-26-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008142604.39107-2-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In cases where a syscall is expected to fail, but unexpectedly
succeeds, the resulting errno is undefined and we should not proceed
to check the errno.  Replace EXPECT* with ASSERT* macros for syscall
invocations where this is the case, so that we abort the tests early
in such cases.

In the errata test, check errno with EXPECT after the combined VERSION
and ERRATA flags, since nothing depends on it.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c |  8 +--
 tools/testing/selftests/landlock/base_test.c  | 40 +++++++--------
 tools/testing/selftests/landlock/fs_test.c    | 50 +++++++++----------
 tools/testing/selftests/landlock/net_test.c   | 24 ++++-----
 .../testing/selftests/landlock/ptrace_test.c  | 14 +++---
 .../landlock/scoped_abstract_unix_test.c      | 14 +++---
 6 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index b38d0c5d5869..392e75ddfa3c 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -100,7 +100,7 @@ TEST_F(audit, layers)
 			EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 
 			/* Creates a denial to get the domain ID. */
-			EXPECT_EQ(-1, kill(getppid(), 0));
+			ASSERT_EQ(-1, kill(getppid(), 0));
 			EXPECT_EQ(EPERM, errno);
 			EXPECT_EQ(0,
 				  matches_log_signal(_metadata, self->audit_fd,
@@ -119,7 +119,7 @@ TEST_F(audit, layers)
 		}
 
 		/* Checks that we reached the maximum number of layers. */
-		EXPECT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
+		ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
 		EXPECT_EQ(E2BIG, errno);
 
 		/* Updates filter rules to match the drop record. */
@@ -711,7 +711,7 @@ TEST_F(audit_flags, signal)
 		EXPECT_EQ(0, close(ruleset_fd));
 
 		/* First signal checks to test log entries. */
-		EXPECT_EQ(-1, kill(getppid(), 0));
+		ASSERT_EQ(-1, kill(getppid(), 0));
 		EXPECT_EQ(EPERM, errno);
 
 		if (!expect_audit) {
@@ -736,7 +736,7 @@ TEST_F(audit_flags, signal)
 		}
 
 		/* Second signal checks to test audit_count_records(). */
-		EXPECT_EQ(-1, kill(getppid(), 0));
+		ASSERT_EQ(-1, kill(getppid(), 0));
 		EXPECT_EQ(EPERM, errno);
 
 		/* Makes sure there is no superfluous logged records. */
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 5f10300a60cd..c19aa20609d6 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -136,7 +136,7 @@ TEST(errata)
 			      NULL, 0,
 			      LANDLOCK_CREATE_RULESET_VERSION |
 				      LANDLOCK_CREATE_RULESET_ERRATA));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_ERRATA |
@@ -333,7 +333,7 @@ TEST(restrict_self_fd)
 	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, fd);
 
-	EXPECT_EQ(-1, landlock_restrict_self(fd, 0));
+	ASSERT_EQ(-1, landlock_restrict_self(fd, 0));
 	EXPECT_EQ(EBADFD, errno);
 
 	EXPECT_EQ(0, close(fd));
@@ -350,12 +350,12 @@ TEST(restrict_self_fd_flags)
 	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF accepts -1 but not any file
 	 * descriptor.
 	 */
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      fd, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADFD, errno);
 
 	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	EXPECT_EQ(EBADFD, errno);
 
@@ -368,40 +368,40 @@ TEST(restrict_self_flags)
 
 	/* Tests invalid flag combinations. */
 
-	EXPECT_EQ(-1, landlock_restrict_self(-1, last_flag << 1));
+	ASSERT_EQ(-1, landlock_restrict_self(-1, last_flag << 1));
 	EXPECT_EQ(EINVAL, errno);
 
-	EXPECT_EQ(-1, landlock_restrict_self(-1, -1));
+	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
 	EXPECT_EQ(EINVAL, errno);
 
 	/* Tests valid flag combinations. */
 
-	EXPECT_EQ(-1, landlock_restrict_self(-1, 0));
+	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1,
+	ASSERT_EQ(-1,
 		  landlock_restrict_self(
 			  -1,
 			  LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
 				  LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1,
+	ASSERT_EQ(-1,
 		  landlock_restrict_self(
 			  -1,
 			  LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
 				  LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1,
+	ASSERT_EQ(-1,
 		  landlock_restrict_self(
 			  -1, LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
 				      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
@@ -409,18 +409,18 @@ TEST(restrict_self_flags)
 
 	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	EXPECT_EQ(EBADF, errno);
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
 					  LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	EXPECT_EQ(EBADF, errno);
 
 	/* Tests with an invalid ruleset_fd. */
 
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -2, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADF, errno);
 
@@ -446,7 +446,7 @@ TEST(restrict_self_no_new_privs)
 	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
 
 	/* Checks that a failed call does not set no_new_privs. */
-	EXPECT_EQ(-1, landlock_restrict_self(
+	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	EXPECT_EQ(EBADF, errno);
 	EXPECT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
@@ -577,7 +577,7 @@ TEST(cred_transfer)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks ruleset enforcement. */
-	EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 	EXPECT_EQ(EACCES, errno);
 
 	/* Needed for KEYCTL_SESSION_TO_PARENT permission checks */
@@ -591,7 +591,7 @@ TEST(cred_transfer)
 	ASSERT_LE(0, child);
 	if (child == 0) {
 		/* Checks ruleset enforcement. */
-		EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+		ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 		EXPECT_EQ(EACCES, errno);
 
 		/*
@@ -610,7 +610,7 @@ TEST(cred_transfer)
 				     0, 0, 0));
 
 		/* Re-checks ruleset enforcement. */
-		EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+		ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 		EXPECT_EQ(EACCES, errno);
 
 		_exit(_metadata->exit_code);
@@ -622,7 +622,7 @@ TEST(cred_transfer)
 	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	/* Re-checks ruleset enforcement. */
-	EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 	EXPECT_EQ(EACCES, errno);
 }
 
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index ba3b39ad5882..c73a438e088f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -678,7 +678,7 @@ TEST_F_FORK(layout0, rule_with_unknown_access)
 
 	for (access = 1ULL << 63; access != ACCESS_LAST; access >>= 1) {
 		path_beneath.allowed_access = access;
-		EXPECT_EQ(-1, landlock_add_rule(ruleset_fd,
+		ASSERT_EQ(-1, landlock_add_rule(ruleset_fd,
 						LANDLOCK_RULE_PATH_BENEATH,
 						&path_beneath, 0));
 		EXPECT_EQ(EINVAL, errno);
@@ -712,7 +712,7 @@ TEST_F_FORK(layout1, rule_with_unhandled_access)
 		if (access == ruleset_attr.handled_access_fs) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EINVAL, errno);
 		}
 	}
@@ -2069,7 +2069,7 @@ TEST_F_FORK(layout1, umount_sandboxer)
 
 	/* Tests that the sandboxer is tied to its mount point. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, umount(dir_s3d2));
+	ASSERT_EQ(-1, umount(dir_s3d2));
 	EXPECT_EQ(EBUSY, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -2264,7 +2264,7 @@ TEST_F_FORK(layout1, rename_whiteout_denied)
 	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT.
 	 * Denied, because whiteout creation is guarded with MAKE_REG.
 	 */
-	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
 				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
 	EXPECT_EQ(EACCES, errno);
 }
@@ -2354,7 +2354,7 @@ TEST_F_FORK(layout1, rename_whiteout_reparenting)
 	 * there, even though it is granted in the destination directory
 	 * dir_s3d3.
 	 */
-	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD,
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD,
 				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
 	EXPECT_EQ(EACCES, errno);
 
@@ -2404,7 +2404,7 @@ TEST_F_FORK(layout1, rename_whiteout_exchange)
 	 * dir_s3d4, even though it is granted in the whiteout object's own
 	 * directory dir_s3d3.
 	 */
-	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD, whiteout_s3d3,
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s3d4, AT_FDCWD, whiteout_s3d3,
 				RENAME_EXCHANGE));
 	EXPECT_EQ(EACCES, errno);
 
@@ -2637,11 +2637,11 @@ TEST_F_FORK(layout1, refer_mount_root_deny)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_DIR, NULL);
 
 	/* Link denied by Landlock: EACCES. */
-	EXPECT_EQ(-1, linkat(root_fd, ".", root_fd, "does_not_exist", 0));
+	ASSERT_EQ(-1, linkat(root_fd, ".", root_fd, "does_not_exist", 0));
 	EXPECT_EQ(EACCES, errno);
 
 	/* renameat2() always returns EBUSY. */
-	EXPECT_EQ(-1, renameat2(root_fd, ".", root_fd, "does_not_exist", 0));
+	ASSERT_EQ(-1, renameat2(root_fd, ".", root_fd, "does_not_exist", 0));
 	EXPECT_EQ(EBUSY, errno);
 
 	EXPECT_EQ(0, close(root_fd));
@@ -5398,14 +5398,14 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 		 * Tests that access widening checks indeed prevents us from renaming it
 		 * back.
 		 */
-		EXPECT_EQ(-1, rename(dir_s4d2, dir_s1d3));
+		ASSERT_EQ(-1, rename(dir_s4d2, dir_s1d3));
 		EXPECT_EQ(EXDEV, errno);
 
 		/*
 		 * Including through the now disconnected fd (but it should return
 		 * EXDEV).
 		 */
-		EXPECT_EQ(-1, renameat(bind_s1d3_fd, file1_name, AT_FDCWD,
+		ASSERT_EQ(-1, renameat(bind_s1d3_fd, file1_name, AT_FDCWD,
 				       file1_s2d2));
 		EXPECT_EQ(EXDEV, errno);
 		_exit(_metadata->exit_code);
@@ -7630,12 +7630,12 @@ TEST_F(audit_layout1, remove_dir)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, rmdir(dir_s1d3));
+	ASSERT_EQ(-1, rmdir(dir_s1d3));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_dir", dir_s1d2));
 
-	EXPECT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d3, AT_REMOVEDIR));
+	ASSERT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d3, AT_REMOVEDIR));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_dir", dir_s1d2));
@@ -7651,7 +7651,7 @@ TEST_F(audit_layout1, remove_file)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, unlink(file1_s1d3));
+	ASSERT_EQ(-1, unlink(file1_s1d3));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file", dir_s1d3));
@@ -7669,7 +7669,7 @@ TEST_F(audit_layout1, make_char)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(7, 0)));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(7, 0)));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_char",
 				    dir_s1d3));
@@ -7688,7 +7688,7 @@ TEST_F(audit_layout1, make_whiteout)
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
 	/* Whiteout creation is denied and logged as fs.make_reg. */
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(0, 0)));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, makedev(0, 0)));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
 				    dir_s1d3));
@@ -7706,7 +7706,7 @@ TEST_F(audit_layout1, make_dir)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mkdir(file1_s1d3, 0755));
+	ASSERT_EQ(-1, mkdir(file1_s1d3, 0755));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_dir",
 				    dir_s1d3));
@@ -7724,7 +7724,7 @@ TEST_F(audit_layout1, make_reg)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
 				    dir_s1d3));
@@ -7742,7 +7742,7 @@ TEST_F(audit_layout1, make_sock)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sock",
 				    dir_s1d3));
@@ -7760,7 +7760,7 @@ TEST_F(audit_layout1, make_fifo)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_fifo",
 				    dir_s1d3));
@@ -7778,7 +7778,7 @@ TEST_F(audit_layout1, make_block)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
+	ASSERT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_block", dir_s1d3));
@@ -7796,7 +7796,7 @@ TEST_F(audit_layout1, make_sym)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, symlink("target", file1_s1d3));
+	ASSERT_EQ(-1, symlink("target", file1_s1d3));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sym",
 				    dir_s1d3));
@@ -7814,7 +7814,7 @@ TEST_F(audit_layout1, refer_handled)
 
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, NULL);
 
-	EXPECT_EQ(-1, link(file1_s1d1, file1_s1d3));
+	ASSERT_EQ(-1, link(file1_s1d1, file1_s1d3));
 	EXPECT_EQ(EXDEV, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d1));
@@ -7838,7 +7838,7 @@ TEST_F(audit_layout1, refer_make)
 		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
 		   NULL);
 
-	EXPECT_EQ(-1, link(file1_s1d1, file1_s1d3));
+	ASSERT_EQ(-1, link(file1_s1d1, file1_s1d3));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d1));
@@ -7935,7 +7935,7 @@ TEST_F(audit_layout1, truncate)
 
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
-	EXPECT_EQ(-1, truncate(file1_s1d3, 0));
+	ASSERT_EQ(-1, truncate(file1_s1d3, 0));
 	EXPECT_EQ(EACCES, errno);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.truncate",
 				    file1_s1d3));
@@ -8008,7 +8008,7 @@ TEST_F(audit_layout1, mount)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_EXECUTE, NULL);
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
+	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
 	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 563e2214390b..51bcb4740dde 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1361,11 +1361,11 @@ TEST_F(protocol, tcp_fastopen)
 	}
 
 	if (restricted) {
-		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		ASSERT_EQ(-1, read(client_fd, &buf, 1));
 		EXPECT_EQ(ENOTCONN, errno);
 	} else if (self->srv0.protocol.domain == AF_UNIX &&
 		   self->srv0.protocol.type == SOCK_STREAM) {
-		EXPECT_EQ(-1, read(client_fd, &buf, 1));
+		ASSERT_EQ(-1, read(client_fd, &buf, 1));
 		EXPECT_EQ(EINVAL, errno);
 	} else {
 		EXPECT_EQ(1, read(client_fd, &buf, 1));
@@ -2261,7 +2261,7 @@ TEST_F(mini, ruleset_with_unknown_access)
 			.handled_access_net = access_mask,
 		};
 
-		EXPECT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
+		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
 						      sizeof(ruleset_attr), 0));
 		EXPECT_EQ(EINVAL, errno);
 	}
@@ -2284,7 +2284,7 @@ TEST_F(mini, rule_with_unknown_access)
 
 	for (access = 1ULL << 63; access != ACCESS_LAST; access >>= 1) {
 		net_port.allowed_access = access;
-		EXPECT_EQ(-1,
+		ASSERT_EQ(-1,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &net_port, 0));
 		EXPECT_EQ(EINVAL, errno);
@@ -2316,7 +2316,7 @@ TEST_F(mini, rule_with_unhandled_access)
 		if (access == ruleset_attr.handled_access_net) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EINVAL, errno);
 		}
 	}
@@ -2349,12 +2349,12 @@ TEST_F(mini, inval)
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Checks unhandled allowed_access. */
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&tcp_bind_connect, 0));
 	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks zero access value. */
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&tcp_denied, 0));
 	EXPECT_EQ(ENOMSG, errno);
 
@@ -2414,15 +2414,15 @@ TEST_F(mini, tcp_port_overflow)
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				       &port_max_bind, 0));
 
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&port_overflow1, 0));
 	EXPECT_EQ(EINVAL, errno);
 
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&port_overflow2, 0));
 	EXPECT_EQ(EINVAL, errno);
 
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&port_overflow3, 0));
 	EXPECT_EQ(EINVAL, errno);
 
@@ -2430,7 +2430,7 @@ TEST_F(mini, tcp_port_overflow)
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				       &port_max_connect, 0));
 
-	EXPECT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					&port_overflow4, 0));
 	EXPECT_EQ(EINVAL, errno);
 
@@ -2549,7 +2549,7 @@ TEST_F(ipv4_tcp, with_fs)
 	EXPECT_EQ(0, close(dir_fd));
 
 	dir_fd = open("/", O_RDONLY);
-	EXPECT_EQ(-1, dir_fd);
+	ASSERT_EQ(-1, dir_fd);
 	EXPECT_EQ(EACCES, errno);
 
 	/* Tests port binding. */
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 4fd2b440aa45..ea8e4be6659e 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -204,7 +204,7 @@ TEST_F(scoped_domains, trace)
 		if (can_trace_parent) {
 			EXPECT_EQ(0, ret);
 		} else {
-			EXPECT_EQ(-1, ret);
+			ASSERT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
 		}
 		if (ret == 0) {
@@ -218,7 +218,7 @@ TEST_F(scoped_domains, trace)
 		if (can_trace_child) {
 			EXPECT_EQ(0, ret);
 		} else {
-			EXPECT_EQ(-1, ret);
+			ASSERT_EQ(-1, ret);
 			EXPECT_EQ(EPERM, errno);
 		}
 
@@ -259,7 +259,7 @@ TEST_F(scoped_domains, trace)
 		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
 	} else {
 		/* The child should not be traced by the parent. */
-		EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
+		ASSERT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
 		EXPECT_EQ(ESRCH, errno);
 	}
 
@@ -276,7 +276,7 @@ TEST_F(scoped_domains, trace)
 	if (can_trace_child) {
 		EXPECT_EQ(0, ret);
 	} else {
-		EXPECT_EQ(-1, ret);
+		ASSERT_EQ(-1, ret);
 		EXPECT_EQ(EPERM, errno);
 	}
 
@@ -377,7 +377,7 @@ TEST_F(audit, trace)
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 
 		/* Tests child PTRACE_TRACEME. */
-		EXPECT_EQ(-1, ptrace(PTRACE_TRACEME));
+		ASSERT_EQ(-1, ptrace(PTRACE_TRACEME));
 		EXPECT_EQ(EPERM, errno);
 		/* We should see the child process. */
 		EXPECT_EQ(0, matches_log_ptrace(_metadata, self->audit_fd,
@@ -414,11 +414,11 @@ TEST_F(audit, trace)
 	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
 
 	/* The child should not be traced by the parent. */
-	EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
+	ASSERT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
 	EXPECT_EQ(ESRCH, errno);
 
 	/* Tests PTRACE_ATTACH on the child. */
-	EXPECT_EQ(-1, ptrace(PTRACE_ATTACH, child, NULL, 0));
+	ASSERT_EQ(-1, ptrace(PTRACE_ATTACH, child, NULL, 0));
 	EXPECT_EQ(EPERM, errno);
 	EXPECT_EQ(0, matches_log_ptrace(_metadata, self->audit_fd, child));
 
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index df41da5f2ab0..4c7f9c102d50 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -122,7 +122,7 @@ TEST_F(scoped_domains, connect_to_parent)
 		if (can_connect_to_parent) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		}
 		EXPECT_EQ(0, close(stream_client));
@@ -132,7 +132,7 @@ TEST_F(scoped_domains, connect_to_parent)
 		if (can_connect_to_parent) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		}
 		EXPECT_EQ(0, close(dgram_client));
@@ -417,7 +417,7 @@ TEST_F(scoped_audit, connect_to_child)
 	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
 	err_dgram = connect(dgram_client, &self->dgram_address.unix_addr,
 			    self->dgram_address.unix_addr_len);
-	EXPECT_EQ(-1, err_dgram);
+	ASSERT_EQ(-1, err_dgram);
 	EXPECT_EQ(EPERM, errno);
 
 	if (should_audit) {
@@ -762,7 +762,7 @@ TEST_F(outside_socket, socket_with_different_domain)
 		if (variant->child_socket) {
 			EXPECT_EQ(0, err);
 		} else {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		}
 		EXPECT_EQ(0, close(client_socket));
@@ -939,7 +939,7 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 			      &stream_abstract_addr.unix_addr,
 			      stream_abstract_addr.unix_addr_len);
 		if (variant->domain == SCOPE_SANDBOX) {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		} else {
 			EXPECT_EQ(0, err);
@@ -954,7 +954,7 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 			     &dgram_abstract_addr.unix_addr,
 			     dgram_abstract_addr.unix_addr_len);
 		if (variant->domain == SCOPE_SANDBOX) {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		} else {
 			EXPECT_EQ(1, err);
@@ -965,7 +965,7 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 			      &dgram_abstract_addr.unix_addr,
 			      dgram_abstract_addr.unix_addr_len);
 		if (variant->domain == SCOPE_SANDBOX) {
-			EXPECT_EQ(-1, err);
+			ASSERT_EQ(-1, err);
 			EXPECT_EQ(EPERM, errno);
 		} else {
 			EXPECT_EQ(0, err);
-- 
2.56.0

