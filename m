Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9739A05C
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469685; cv=none; b=oTpvx42wXCVOmPvlcDRGDA5dasSn0izWESkLJTc5AdK8p32d9A47DTfgFxVbYoV+IJN7+bGrxQyU7LtQbKKAwH0Hu5HbJGfPGZeOcsfnFXlfKWSyvnlfS88/LOPFdLfZab+v/1pQT6tLVZW9zOOwdDpUrOuFr37HbpWIkU1kbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469685; c=relaxed/simple;
	bh=zFNTcWrhSxuuD4JIWlUOvbkZ2phJaIZ1TxMhw29uxSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0JenR0IQjwS2jd+Mp2b/9Fop0lfN503SnNQOLOtxNOhdMfqPBoVzFPIGF+R0yuqRDwy2Ab+eb1F6HAZX2jC1S34QtBHmr0vn4NGtnL4fCSW0FdemO6N+S+HtFOWz04eDRshn3fiO7OSWsyxKgeB1ktzGyo+sbGb2ZPiLTSiE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pO1m/q94; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO1m/q94"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c6955a7c3so931233f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469677; x=1792074477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=opd54HlIRjyTKB2mGFjZ6g7nqOY84FrGSB10cm7wG1s=;
        b=pO1m/q94mNcR43MoQleF2hFl0veLZ7VNysppsTVuCb0bPP1yU782gWtsZlUQ6YWaGK
         vKjw1x5rfbJBBMIoCUns309xFsHLGZV70KzEWa0mr4y4uLE9AXFQfeHhof9ri52081W6
         tblh2uxESmiN879vx8LXVSm7rDxg3yOJktEjH5zQkfFvuMllJRg0W4j09Wm2DN0GZsoD
         6lGJ2mYxoYCpkH2K1vpRBHIzie2xUriizLL6uvXPq5uAUbI7OQ0lwwmC4fzRRsC+AK0D
         f/XwEeOVxkRVKfPSjIAptXB2DxMskL/CwDfZ1AOPzmZCKlZP9p/jvDJuIpS5GCv5liO1
         YcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469677; x=1792074477;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opd54HlIRjyTKB2mGFjZ6g7nqOY84FrGSB10cm7wG1s=;
        b=VZL/if0NBnepPCck7E5MdCBCrnuxrnmFh0vczsuEpuvDnICvZzaYCfEp8H+WI7gJ+S
         EXl/r8U/Kc9AZV6aiNFge9C2GAa0wHzt9YyRSxxHuOvf5i6BKVHxv6t4Bslc+lcqBRjZ
         PMVxGj3H4UnICz4BJ+2Zf6i2adf75NhFtKmIn/pVx6vVHB0oByGc916YjPp91y9V323v
         VnOoe9slFAZvwiHzruabYmOo5icswEhlri55fbHPwBD24U6yM4URJbfGqJvaa/nf8c6L
         Qs88HlbGeI2I/43J/TomV79m+iyBQpLrfXr7HMjvwZbsTVnuXCuLeTrv+G3WpERGQm8E
         qtOA==
X-Forwarded-Encrypted: i=1; AKwUvBy9XZpmd/SdlAwvCPx3QcIEYhbG6sA5N0f8ptW17teiPf4TtrvHQ4+W7hkQhxrPpOccVrrPPd9SY4xQxoRFWyHUiWuyGH4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaOheIUp6v4JP8qLvaz2YLcAmJXd2i5XtNCR450d5I5n8ZZu3Z
	2p3jQKVTvSS1vlWijRUCwbfcLFMlrQ/uzyOnoRhJDwXwc+w8+suxYbGV
X-Gm-Gg: AYBFou3FAZmqLOooNp78FyfrsXB55T/65vFBxrDf1XTKdXHXE08Egm2uUvKoUSblHR+
	EudBIjNgrNJ3yqkEVHfqV3qah19BFJPHRy/xKsH90NkSQ11DSLJ3U5tw9T0YuOD94r6iW9O+ie3
	3+oUhN0QhK1WGZxAv/wccmguaX/agfW9hE/9graoVFoH4YvQHQgHAjPHj0NC+HlPvDyr8TBy6H4
	BLYr7KhlnmvVlPI84As4aS3NA/x2K/d2IdWkbekgAW3e48z3xBoTmSjW/ltQEDLD5uTCNbyVlat
	z2ESkLZb30aFK8DC+pPYnunzDUWbG6lWAVC1nICq5IzB7OOZAZ5MLJxYciu/kz6uPVd+pUjvLBh
	NbWCQaivqiC+2H3tsLQniabefdsyj74EJMQc8ZPlnKyUi4DM1hhNbEw12ybyyrP9D7Fy9uR4xQM
	6+73EnnnEKURvkfC36G3PWpuLVMGglWRG1lan30mgwRz3EXS1Faagy8Hm+s6WqEwy8qg/ZzV4in
	ZiSoxyU5GkgF9EL50i5R48=
X-Received: by 2002:adf:e19b:0:b0:48b:ff5:d297 with SMTP id ffacd0b85a97d-48c727823c4mr10967077f8f.25.1791469675651;
        Thu, 08 Oct 2026 07:27:55 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1f3f7sm11324227f8f.32.2026.10.08.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:55 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 27/27] selftests/landlock: Use EXPECT for checks that later steps do not need
Date: Thu,  8 Oct 2026 16:25:56 +0200
Message-ID: <20261008142604.39107-29-gnoack3000@gmail.com>
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

ASSERT aborts the test, so it should only be used when continuing after
a failure is pointless.  Use EXPECT for checks whose outcome nothing
later in the test depends on:

* errno values after a failed syscall,
* test_open() and test_open_rel(), which leave no state behind,
* WEXITSTATUS() of a child that has exited,
* matches_log_fs() and matches_log_fs_extra(),
* the record counts returned by audit_count_records().

Keep ASSERT for operations whose side effects later checks depend on,
such as renames, links and file removals.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c |   10 +-
 tools/testing/selftests/landlock/base_test.c  |  102 +-
 tools/testing/selftests/landlock/fs_test.c    | 1024 ++++++++---------
 tools/testing/selftests/landlock/net_test.c   |    2 +-
 .../landlock/scoped_abstract_unix_test.c      |    8 +-
 .../selftests/landlock/scoped_signal_test.c   |    6 +-
 .../testing/selftests/landlock/scoped_test.c  |    2 +-
 7 files changed, 577 insertions(+), 577 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 392e75ddfa3c..23ab3a696299 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -315,14 +315,14 @@ TEST_F(audit, log_subdomains_off_fork)
 	if (child == 0) {
 		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 		ASSERT_EQ(-1, kill(getppid(), 0));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 		_exit(_metadata->exit_code);
 		return;
 	}
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(true, WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 
 	/* The denial must be logged (baseline). */
 	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd, getpid(),
@@ -348,14 +348,14 @@ TEST_F(audit, log_subdomains_off_fork)
 	if (child == 0) {
 		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 		ASSERT_EQ(-1, kill(getppid(), 0));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 		_exit(_metadata->exit_code);
 		return;
 	}
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(true, WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 
 	/* No denial record should appear. */
 	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
@@ -981,7 +981,7 @@ TEST_F(audit_exec, signal_and_open)
 	EXPECT_EQ(0, close(pipe_child[0]));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 
 	/* Tests that the audit record only matches the child. */
 	if (!(variant->restrict_flags &
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 862ff91f6418..76864ad53020 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -33,40 +33,40 @@ TEST(inconsistent_attr)
 	/* Checks copy_from_user(). */
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 0, 0));
 	/* The size if less than sizeof(struct landlock_attr_enforce). */
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 1, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 7, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 1, 0));
 	/* The size if less than sizeof(struct landlock_attr_enforce). */
-	ASSERT_EQ(EFAULT, errno);
+	EXPECT_EQ(EFAULT, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(
 			      NULL, sizeof(struct landlock_ruleset_attr), 0));
-	ASSERT_EQ(EFAULT, errno);
+	EXPECT_EQ(EFAULT, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size + 1, 0));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	/* Checks minimal valid attribute size. */
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 8, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(
 			      ruleset_attr,
 			      sizeof(struct landlock_ruleset_attr), 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 
 	/* Checks non-zero value. */
 	buf[page_size - 2] = '.';
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size, 0));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size + 1, 0));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	free(buf);
 }
@@ -81,21 +81,21 @@ TEST(abi_version)
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
 					      LANDLOCK_CREATE_RULESET_VERSION));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1,
 		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
 					  LANDLOCK_CREATE_RULESET_VERSION));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION |
 						      1 << 31));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 }
 
 /*
@@ -121,16 +121,16 @@ TEST(errata)
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
 					      LANDLOCK_CREATE_RULESET_ERRATA));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
 					      LANDLOCK_CREATE_RULESET_ERRATA));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1,
 		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
 					  LANDLOCK_CREATE_RULESET_ERRATA));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(
 			      NULL, 0,
@@ -141,7 +141,7 @@ TEST(errata)
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_ERRATA |
 						      1 << 31));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 }
 
 /* Tests ordering of syscall argument checks. */
@@ -156,29 +156,29 @@ TEST(create_ruleset_checks_ordering)
 
 	/* Checks priority for invalid flags. */
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0, invalid_flag));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0, invalid_flag));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
 					      invalid_flag));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1,
 		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
 					  invalid_flag));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks too big ruleset_attr size. */
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, -1, 0));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	/* Checks too small ruleset_attr size. */
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 1, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks valid call. */
 	ruleset_fd =
@@ -204,25 +204,25 @@ TEST(add_rule_checks_ordering)
 
 	/* Checks invalid flags. */
 	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 100));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks invalid ruleset FD. */
 	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 0));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 
 	/* Checks invalid rule type. */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, 0, NULL, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks invalid rule attr. */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					NULL, 0));
-	ASSERT_EQ(EFAULT, errno);
+	EXPECT_EQ(EFAULT, errno);
 
 	/* Checks invalid path_beneath.parent_fd. */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath_attr, 0));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 
 	/* Checks valid call. */
 	path_beneath_attr.parent_fd =
@@ -262,11 +262,11 @@ TEST(restrict_self_checks_ordering)
 	 * CAP_SYS_ADMIN requirement.
 	 */
 	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	/*
 	 * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS fulfills the no_new_privs /
 	 * CAP_SYS_ADMIN requirement but requires a ruleset, so the FD is
@@ -274,17 +274,17 @@ TEST(restrict_self_checks_ordering)
 	 */
 	ASSERT_EQ(-1, landlock_restrict_self(
 			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
 
 	/* Checks invalid flags. */
 	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Checks invalid ruleset FD. */
 	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 
 	/* Checks valid call. */
 	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
@@ -319,7 +319,7 @@ TEST(restrict_self_max_layers)
 	drop_caps(_metadata);
 	ASSERT_EQ(-1, landlock_restrict_self(
 			      ruleset_fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
-	ASSERT_EQ(E2BIG, errno);
+	EXPECT_EQ(E2BIG, errno);
 
 	/* Checks that the failed call did not set no_new_privs. */
 	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
@@ -473,9 +473,9 @@ TEST(ruleset_fd_io)
 	ASSERT_LE(0, ruleset_fd);
 
 	ASSERT_EQ(-1, write(ruleset_fd, ".", 1));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, read(ruleset_fd, &buf, 1));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	EXPECT_EQ(0, close(ruleset_fd));
 }
@@ -530,7 +530,7 @@ TEST(ruleset_fd_transfer)
 
 		/* Checks that the ruleset enforcement. */
 		ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
-		ASSERT_EQ(EACCES, errno);
+		EXPECT_EQ(EACCES, errno);
 		dir_fd = open("/tmp", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
 		ASSERT_LE(0, dir_fd);
 		EXPECT_EQ(0, close(dir_fd));
@@ -550,7 +550,7 @@ TEST(ruleset_fd_transfer)
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 }
 
 TEST(cred_transfer)
@@ -648,7 +648,7 @@ TEST(useless_quiet_rule_fs)
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath_attr,
 					LANDLOCK_ADD_RULE_QUIET));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	/* Check that the rule had not been added. */
 	EXPECT_EQ(0, close(root_fd));
@@ -656,7 +656,7 @@ TEST(useless_quiet_rule_fs)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST(useless_quiet_rule_net)
@@ -679,7 +679,7 @@ TEST(useless_quiet_rule_net)
 	ASSERT_EQ(-1,
 		  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				    &net_port_attr, LANDLOCK_ADD_RULE_QUIET));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	EXPECT_EQ(0, close(ruleset_fd));
 }
@@ -702,15 +702,15 @@ TEST(invalid_quiet_bits_1)
 	/* Quiet bit set but not part of the handled mask. */
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_fs,
 					      sizeof(ruleset_attr_fs), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_net,
 					      sizeof(ruleset_attr_net), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_scoped,
 					      sizeof(ruleset_attr_scoped), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 }
 
 TEST(invalid_quiet_bits_2)
@@ -731,15 +731,15 @@ TEST(invalid_quiet_bits_2)
 	/* Quiet bit outside of the valid access range. */
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_fs,
 					      sizeof(ruleset_attr_fs), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_net,
 					      sizeof(ruleset_attr_net), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr_scoped,
 					      sizeof(ruleset_attr_scoped), 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 76f319c972db..de79bec2e6d7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -339,7 +339,7 @@ static void cleanup_layout(struct __test_metadata *const _metadata)
 		 * visibility of the nested TMP_DIR mount point for the test's
 		 * parent process doing this cleanup.
 		 */
-		ASSERT_EQ(EINVAL, errno);
+		EXPECT_EQ(EINVAL, errno);
 	}
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, remove_path(TMP_DIR));
@@ -455,25 +455,25 @@ static int test_open(const char *const path, const int flags)
 
 TEST_F_FORK(layout1, no_restriction)
 {
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s2d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s2d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s3d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d3, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, inval)
@@ -498,7 +498,7 @@ TEST_F_FORK(layout1, inval)
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
 	/* Returns EBADF because ruleset_fd is not a landlock-ruleset FD. */
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	ruleset_fd = open(dir_s1d1, O_DIRECTORY | O_CLOEXEC);
@@ -506,7 +506,7 @@ TEST_F_FORK(layout1, inval)
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
 	/* Returns EBADFD because ruleset_fd is not a valid ruleset. */
-	ASSERT_EQ(EBADFD, errno);
+	EXPECT_EQ(EBADFD, errno);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Gets a real ruleset. */
@@ -528,7 +528,7 @@ TEST_F_FORK(layout1, inval)
 	path_beneath.parent_fd = ruleset_fd;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EBADFD, errno);
+	EXPECT_EQ(EBADFD, errno);
 
 	/* Checks unhandled allowed_access. */
 	path_beneath.parent_fd =
@@ -539,28 +539,28 @@ TEST_F_FORK(layout1, inval)
 	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_EXECUTE;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
 
 	/* Tests with denied-by-default access right. */
 	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_REFER;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_REFER;
 
 	/* Test with unknown (64-bits) value. */
 	path_beneath.allowed_access |= (1ULL << 60);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EINVAL, errno);
+	EXPECT_EQ(EINVAL, errno);
 	path_beneath.allowed_access &= ~(1ULL << 60);
 
 	/* Test with no access. */
 	path_beneath.allowed_access = 0;
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 	path_beneath.allowed_access &= ~(1ULL << 60);
 
 	EXPECT_EQ(0, close(path_beneath.parent_fd));
@@ -636,7 +636,7 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
 			ASSERT_EQ(0, err);
 		} else {
 			ASSERT_EQ(-1, err);
-			ASSERT_EQ(EINVAL, errno);
+			EXPECT_EQ(EINVAL, errno);
 		}
 	}
 	EXPECT_EQ(0, close(path_beneath_file.parent_fd));
@@ -656,7 +656,7 @@ TEST_F_FORK(layout0, ruleset_with_unknown_access)
 
 		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
 						      sizeof(ruleset_attr), 0));
-		ASSERT_EQ(EINVAL, errno);
+		EXPECT_EQ(EINVAL, errno);
 	}
 }
 
@@ -813,24 +813,24 @@ TEST_F_FORK(layout0, proc_nsfs)
 		rules);
 
 	ASSERT_LE(0, ruleset_fd);
-	ASSERT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
+	EXPECT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
 
 	enforce_ruleset(_metadata, ruleset_fd);
 
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/dev", O_RDONLY));
-	ASSERT_EQ(0, test_open("/dev/null", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/dev/full", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/dev", O_RDONLY));
+	EXPECT_EQ(0, test_open("/dev/null", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/dev/full", O_RDONLY));
 
-	ASSERT_EQ(EACCES, test_open("/proc", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/proc/self", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/proc/self/ns", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/proc", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/proc/self", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/proc/self/ns", O_RDONLY));
 	/*
 	 * Because nsfs is an internal filesystem, /proc/self/ns/mnt is a
 	 * disconnected path.  Such path cannot be identified and must then be
 	 * allowed.
 	 */
-	ASSERT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
+	EXPECT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
 
 	/*
 	 * Checks that it is not possible to add nsfs-like filesystem
@@ -842,7 +842,7 @@ TEST_F_FORK(layout0, proc_nsfs)
 	ASSERT_LE(0, path_beneath.parent_fd);
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(EBADFD, errno);
+	EXPECT_EQ(EBADFD, errno);
 	EXPECT_EQ(0, close(path_beneath.parent_fd));
 }
 
@@ -862,7 +862,7 @@ TEST_F_FORK(layout0, unpriv)
 	ruleset_fd = create_ruleset(_metadata, ACCESS_RO, rules);
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 
 	/* enforce_ruleset() calls prctl(no_new_privs). */
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -889,23 +889,23 @@ TEST_F_FORK(layout1, effective_access)
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Tests on a directory (with or without O_PATH). */
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
-	ASSERT_EQ(0, test_open("/", O_RDONLY | O_PATH));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_PATH));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY | O_PATH));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(0, test_open("/", O_RDONLY | O_PATH));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_PATH));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY | O_PATH));
 
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
 	/* Tests on a file (with or without O_PATH). */
-	ASSERT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_PATH));
+	EXPECT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_PATH));
 
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDONLY));
 
 	/* Checks effective read and write actions. */
 	reg_fd = open(file1_s2d2, O_RDWR | O_CLOEXEC);
@@ -920,7 +920,7 @@ TEST_F_FORK(layout1, effective_access)
 	reg_fd = open(file1_s2d2, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, reg_fd);
 	ASSERT_EQ(-1, write(reg_fd, &buf, 1));
-	ASSERT_EQ(EBADF, errno);
+	EXPECT_EQ(EBADF, errno);
 	EXPECT_EQ(0, close(reg_fd));
 }
 
@@ -941,11 +941,11 @@ TEST_F_FORK(layout1, unhandled_access)
 	 * Because the policy does not handle LANDLOCK_ACCESS_FS_WRITE_FILE,
 	 * opening for write-only should be allowed, but not read-write.
 	 */
-	ASSERT_EQ(0, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
 
-	ASSERT_EQ(0, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDWR));
 }
 
 TEST_F_FORK(layout1, ruleset_overlap)
@@ -968,22 +968,22 @@ TEST_F_FORK(layout1, ruleset_overlap)
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks s1d1 hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d2 hierarchy. */
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d3 hierarchy. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 }
 
 TEST_F_FORK(layout1, layer_rule_unions)
@@ -1021,67 +1021,67 @@ TEST_F_FORK(layout1, layer_rule_unions)
 	enforce_fs(_metadata, ACCESS_RW, layer1);
 
 	/* Checks s1d1 hierarchy with layer1. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d2 hierarchy with layer1. */
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d3 hierarchy with layer1. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_WRONLY));
 	/* dir_s1d3 should allow READ_FILE and WRITE_FILE (O_RDWR). */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Doesn't change anything from layer1. */
 	enforce_fs(_metadata, ACCESS_RW, layer2);
 
 	/* Checks s1d1 hierarchy with layer2. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d2 hierarchy with layer2. */
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d3 hierarchy with layer2. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_WRONLY));
 	/* dir_s1d3 should allow READ_FILE and WRITE_FILE (O_RDWR). */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Only allows write (but not read) to dir_s1d3. */
 	enforce_fs(_metadata, ACCESS_RW, layer3);
 
 	/* Checks s1d1 hierarchy with layer3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d2 hierarchy with layer3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Checks s1d3 hierarchy with layer3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_WRONLY));
 	/* dir_s1d3 should now deny READ_FILE and WRITE_FILE (O_RDWR). */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 }
 
 TEST_F_FORK(layout1, non_overlapping_accesses)
@@ -1107,7 +1107,7 @@ TEST_F_FORK(layout1, non_overlapping_accesses)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, layer1);
 
 	ASSERT_EQ(-1, mknod(file1_s1d1, S_IFREG | 0700, 0));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, mknod(file1_s1d2, S_IFREG | 0700, 0));
 	ASSERT_EQ(0, unlink(file1_s1d2));
 
@@ -1115,12 +1115,12 @@ TEST_F_FORK(layout1, non_overlapping_accesses)
 
 	/* Unchanged accesses for file creation. */
 	ASSERT_EQ(-1, mknod(file1_s1d1, S_IFREG | 0700, 0));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, mknod(file1_s1d2, S_IFREG | 0700, 0));
 
 	/* Checks file removing. */
 	ASSERT_EQ(-1, unlink(file1_s1d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s1d3));
 }
 
@@ -1219,25 +1219,25 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer1_read);
 
 	/* Checks that read access is granted for file1_s1d3 with layer 1. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
 	enforce_fs(_metadata,
 		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
 		   layer2_read_write);
 
 	/* Checks that previous access rights are unchanged with layer 2. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer3_read);
 
 	/* Checks that previous access rights are unchanged with layer 3. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
 	/* This time, denies write access for the file hierarchy. */
 	enforce_fs(_metadata,
@@ -1248,36 +1248,36 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	 * Checks that the only change with layer 4 is that write access is
 	 * denied.
 	 */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
 
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer5_read);
 
 	/* Checks that previous access rights are unchanged with layer 5. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_EXECUTE, layer6_execute);
 
 	/* Checks that previous access rights are unchanged with layer 6. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 
 	enforce_fs(_metadata,
 		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
 		   layer7_read_write);
 
 	/* Checks read access is now denied with layer 7. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, inherit_subset)
@@ -1294,18 +1294,18 @@ TEST_F_FORK(layout1, inherit_subset)
 
 	enforce_ruleset(_metadata, ruleset_fd);
 
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Write access is forbidden. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
 	/* Readdir access is allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* Write access is forbidden. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 	/* Readdir access is allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/*
 	 * Tests shared rule extension: the following rules should not grant
@@ -1328,18 +1328,18 @@ TEST_F_FORK(layout1, inherit_subset)
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Same tests and results as above. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d2. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/*
 	 * Try to get more privileges by adding new access rights to the parent
@@ -1349,18 +1349,18 @@ TEST_F_FORK(layout1, inherit_subset)
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Same tests and results as above. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d2. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/*
 	 * Now, dir_s1d3 get a new rule tied to it, only allowing
@@ -1379,21 +1379,21 @@ TEST_F_FORK(layout1, inherit_subset)
 	 */
 
 	/* Same tests and results as above. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d2. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
 	/* Readdir access is still allowed. */
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* It is still forbidden to write in file1_s1d3. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 	/*
 	 * Readdir of dir_s1d3 is still allowed because of the OR policy inside
 	 * the same layer.
 	 */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 }
 
 TEST_F_FORK(layout1, inherit_superset)
@@ -1410,11 +1410,11 @@ TEST_F_FORK(layout1, inherit_superset)
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Readdir access is denied for dir_s1d2. */
-	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 	/* Readdir access is allowed for dir_s1d3. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 	/* File access is allowed for file1_s1d3. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
 	/* Now dir_s1d2, parent of dir_s1d3, gets a new rule tied to it. */
 	add_path_beneath(_metadata, ruleset_fd,
@@ -1425,11 +1425,11 @@ TEST_F_FORK(layout1, inherit_superset)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Readdir access is still denied for dir_s1d2. */
-	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 	/* Readdir access is still allowed for dir_s1d3. */
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 	/* File access is still allowed for file1_s1d3. */
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 }
 
 TEST_F_FORK(layout0, max_layers)
@@ -1450,7 +1450,7 @@ TEST_F_FORK(layout0, max_layers)
 	for (i = 0; i < 2; i++) {
 		err = landlock_restrict_self(ruleset_fd, 0);
 		ASSERT_EQ(-1, err);
-		ASSERT_EQ(E2BIG, errno);
+		EXPECT_EQ(E2BIG, errno);
 	}
 	EXPECT_EQ(0, close(ruleset_fd));
 }
@@ -1464,20 +1464,20 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_EQ(-1, ruleset_fd);
-	ASSERT_EQ(ENOMSG, errno);
+	EXPECT_EQ(ENOMSG, errno);
 
 	/* Enforces policy which denies read access to all files. */
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, NULL);
 
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
 	/* Nests a policy which denies read access to all directories. */
 	ruleset_fd =
 		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, NULL);
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
 
 	/* Enforces a second time with the same ruleset. */
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -1501,13 +1501,13 @@ TEST_F_FORK(layout1, rule_on_mountpoint)
 
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
-	ASSERT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
 
-	ASSERT_EQ(EACCES, test_open(dir_s3d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s3d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d3, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, rule_over_mountpoint)
@@ -1527,13 +1527,13 @@ TEST_F_FORK(layout1, rule_over_mountpoint)
 
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
-	ASSERT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s3d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s3d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d3, O_RDONLY));
 }
 
 /*
@@ -1553,15 +1553,15 @@ TEST_F_FORK(layout1, rule_over_root_allow_then_deny)
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks allowed access. */
-	ASSERT_EQ(0, test_open("/", O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open("/", O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
 	rules[0].access = LANDLOCK_ACCESS_FS_READ_FILE;
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks denied access (on a directory). */
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, rule_over_root_deny)
@@ -1577,8 +1577,8 @@ TEST_F_FORK(layout1, rule_over_root_deny)
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks denied access (on a directory). */
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
 }
 
 TEST_F_FORK(layout1, rule_inside_mount_ns)
@@ -1601,8 +1601,8 @@ TEST_F_FORK(layout1, rule_inside_mount_ns)
 
 	enforce_fs(_metadata, ACCESS_RW, rules);
 
-	ASSERT_EQ(0, test_open("s3d3", O_RDONLY));
-	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
+	EXPECT_EQ(0, test_open("s3d3", O_RDONLY));
+	EXPECT_EQ(EACCES, test_open("/", O_RDONLY));
 }
 
 TEST_F_FORK(layout1, mount_and_pivot)
@@ -1619,9 +1619,9 @@ TEST_F_FORK(layout1, mount_and_pivot)
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
@@ -1651,7 +1651,7 @@ TEST_F_FORK(layout1, move_mount)
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
 			      dir_s1d2, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
@@ -1691,16 +1691,16 @@ TEST_F_FORK(layout1, topology_changes_with_net_and_fs)
 	/* Mount, remount, move_mount, umount, and pivot_root checks. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, mount_opt(&mnt_tmp, dir_s1d2));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC, NULL));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
 			      dir_s2d2, 0));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, umount(dir_s3d2));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
-	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
@@ -1731,10 +1731,10 @@ TEST_F_FORK(layout1, release_inodes)
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
 	/* This dir_s3d3 would not be allowed and does not exist anyway. */
-	ASSERT_EQ(ENOENT, test_open(dir_s3d3, O_RDONLY));
+	EXPECT_EQ(ENOENT, test_open(dir_s3d3, O_RDONLY));
 }
 
 /*
@@ -1767,13 +1767,13 @@ TEST_F_FORK(layout1, covered_rule)
 	ASSERT_EQ(0, mount_opt(&mnt_tmp, dir_s3d2));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
-	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d2, O_RDONLY));
 
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
-	ASSERT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
 }
 
 enum relative_access {
@@ -1860,35 +1860,35 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 		break;
 	}
 
-	ASSERT_EQ((rel == REL_CHROOT_CHDIR) ? 0 : EACCES,
+	EXPECT_EQ((rel == REL_CHROOT_CHDIR) ? 0 : EACCES,
 		  test_open_rel(dirfd, "..", O_RDONLY));
-	ASSERT_EQ(0, test_open_rel(dirfd, ".", O_RDONLY));
+	EXPECT_EQ(0, test_open_rel(dirfd, ".", O_RDONLY));
 
 	if (rel == REL_CHROOT_ONLY) {
 		/* The current directory is dir_s2d2. */
-		ASSERT_EQ(0, test_open_rel(dirfd, "./s2d3", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "./s2d3", O_RDONLY));
 	} else {
 		/* The current directory is dir_s1d2. */
-		ASSERT_EQ(0, test_open_rel(dirfd, "./s1d3", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "./s1d3", O_RDONLY));
 	}
 
 	if (rel == REL_CHROOT_ONLY || rel == REL_CHROOT_CHDIR) {
 		/* Checks the root dir_s1d2. */
-		ASSERT_EQ(0, test_open_rel(dirfd, "/..", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "/", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "/f1", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "/s1d3", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "/..", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "/", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "/f1", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "/s1d3", O_RDONLY));
 	}
 
 	if (rel != REL_CHROOT_CHDIR) {
-		ASSERT_EQ(EACCES, test_open_rel(dirfd, "../../s1d1", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2/s1d3",
+		EXPECT_EQ(EACCES, test_open_rel(dirfd, "../../s1d1", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2/s1d3",
 					   O_RDONLY));
 
-		ASSERT_EQ(EACCES, test_open_rel(dirfd, "../../s2d1", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2", O_RDONLY));
-		ASSERT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2/s2d3",
+		EXPECT_EQ(EACCES, test_open_rel(dirfd, "../../s2d1", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2", O_RDONLY));
+		EXPECT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2/s2d3",
 					   O_RDONLY));
 	}
 
@@ -1960,7 +1960,7 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
 	}
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(err ? 2 : 0, WEXITSTATUS(status))
+	EXPECT_EQ(err ? 2 : 0, WEXITSTATUS(status))
 	{
 		TH_LOG("Unexpected return code for \"%s\"", path);
 	};
@@ -2002,18 +2002,18 @@ TEST_F_FORK(layout1, execute)
 
 	enforce_fs(_metadata, rules[0].access, rules);
 
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
 	test_execute(_metadata, EACCES, file1_s1d1);
 	test_check_exec(_metadata, EACCES, file1_s1d1);
 
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d2);
 	test_check_exec(_metadata, 0, file1_s1d2);
 
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d3);
 	test_check_exec(_metadata, 0, file1_s1d3);
 }
@@ -2092,7 +2092,7 @@ TEST_F_FORK(layout1, umount_sandboxer)
 	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 }
 
 TEST_F_FORK(layout1, link)
@@ -2119,15 +2119,15 @@ TEST_F_FORK(layout1, link)
 	enforce_fs(_metadata, layer1[0].access, layer1);
 
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Denies linking because of reparenting. */
 	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, link(file2_s1d2, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, link(file2_s1d3, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(0, link(file2_s1d2, file1_s1d2));
 	ASSERT_EQ(0, link(file2_s1d3, file1_s1d3));
@@ -2196,47 +2196,47 @@ TEST_F_FORK(layout1, rename_file)
 	 * but to a different directory (which also allows file removal).
 	 */
 	ASSERT_EQ(-1, rename(file1_s2d3, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, file1_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/*
 	 * Tries to replace a file, from a directory that denies file removal,
 	 * to a different directory (which allows file removal).
 	 */
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file1_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Exchanges files and directories that partially allow removal. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s2d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks that file1_s2d1 cannot be removed (instead of ENOTDIR). */
 	ASSERT_EQ(-1, rename(dir_s2d2, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, dir_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks that file1_s1d1 cannot be removed (instead of EISDIR). */
 	ASSERT_EQ(-1, rename(file1_s1d1, dir_s1d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Renames files with different parents. */
 	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Exchanges and renames files with same parent. */
 	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s2d3, AT_FDCWD, file1_s2d3,
@@ -2444,12 +2444,12 @@ TEST_F_FORK(layout1, rename_dir)
 	/* Exchanges and renames directory to a different parent. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s2d3, dir_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/*
 	 * Exchanges directory to the same parent, which doesn't allow
@@ -2457,16 +2457,16 @@ TEST_F_FORK(layout1, rename_dir)
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d1, AT_FDCWD, dir_s2d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks that dir_s1d2 cannot be removed (instead of ENOTDIR). */
 	ASSERT_EQ(-1, rename(dir_s1d2, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s1d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks that dir_s1d2 cannot be removed (instead of EISDIR). */
 	ASSERT_EQ(-1, rename(file1_s1d1, dir_s1d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * Exchanges and renames directory to the same parent, which allows
@@ -2497,22 +2497,22 @@ TEST_F_FORK(layout1, reparent_refer)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
 
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving should only be allowed when the source and the destination
 	 * parent directory have REFER.
 	 */
 	ASSERT_EQ(-1, rename(dir_s1d3, dir_s2d3));
-	ASSERT_EQ(ENOTEMPTY, errno);
+	EXPECT_EQ(ENOTEMPTY, errno);
 	ASSERT_EQ(0, unlink(file1_s2d3));
 	ASSERT_EQ(0, unlink(file2_s2d3));
 	ASSERT_EQ(0, rename(dir_s1d3, dir_s2d3));
@@ -2711,27 +2711,27 @@ TEST_F_FORK(layout1, reparent_link)
 
 	/* Denies linking because of missing MAKE_REG. */
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Denies linking because of missing source and destination REFER. */
 	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/* Denies linking because of missing source REFER. */
 	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Denies linking because of missing MAKE_REG. */
 	ASSERT_EQ(-1, link(file1_s2d2, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Denies linking because of missing destination REFER. */
 	ASSERT_EQ(-1, link(file1_s2d2, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Allows linking because of REFER and MAKE_REG. */
 	ASSERT_EQ(0, link(file1_s2d2, file1_s1d3));
 	ASSERT_EQ(0, unlink(file1_s2d2));
 	/* Reverse linking denied because of missing MAKE_REG. */
 	ASSERT_EQ(-1, link(file1_s1d3, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s2d3));
 	/* Checks reverse linking. */
 	ASSERT_EQ(0, link(file1_s1d3, file1_s2d3));
@@ -2745,9 +2745,9 @@ TEST_F_FORK(layout1, reparent_link)
 	ASSERT_EQ(0, unlink(file1_s1d3));
 
 	ASSERT_EQ(-1, link(file2_s1d2, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, link(file2_s1d3, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(0, link(file2_s1d2, file1_s1d2));
 	ASSERT_EQ(0, link(file2_s1d3, file1_s1d3));
@@ -2786,57 +2786,57 @@ TEST_F_FORK(layout1, reparent_rename)
 	/* Denies renaming because of missing MAKE_REG. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file1_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Even denies same file exchange. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file2_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Denies renaming because of missing source and destination REFER. */
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Denies renaming because of missing MAKE_REG, source and destination
 	 * REFER.
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file2_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file1_s2d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Denies renaming because of missing source REFER. */
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/* Denies renaming because of missing MAKE_REG. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file2_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Denies renaming because of missing MAKE_REG. */
 	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Denies renaming because of missing destination REFER*/
 	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Denies exchange because of one missing MAKE_REG. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, file2_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Allows renaming because of REFER and MAKE_REG. */
 	ASSERT_EQ(0, rename(file1_s2d2, file1_s1d3));
 
 	/* Reverse renaming denied because of missing MAKE_REG. */
 	ASSERT_EQ(-1, rename(file1_s1d3, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s2d3));
 	ASSERT_EQ(0, rename(file1_s1d3, file1_s2d3));
 
@@ -2868,17 +2868,17 @@ TEST_F_FORK(layout1, reparent_rename)
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, file1_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(file1_s2d3, dir_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(-1, rename(file2_s1d2, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(file2_s1d3, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Renaming in the same directory is always allowed. */
 	ASSERT_EQ(0, rename(file2_s1d2, file1_s1d2));
@@ -2887,12 +2887,12 @@ TEST_F_FORK(layout1, reparent_rename)
 	ASSERT_EQ(0, unlink(file1_s1d2));
 	/* Denies because of missing source MAKE_REG and destination REFER. */
 	ASSERT_EQ(-1, rename(dir_s2d3, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	/* Denies because of missing source MAKE_REG and REFER. */
 	ASSERT_EQ(-1, rename(dir_s2d2, file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 }
 
 static void
@@ -2976,14 +2976,14 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
 	 * MAKE_DIR is not tied to dir_s2d2.
 	 */
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * Moving the dir_s1d3 directory below dir_s2d3 is forbidden because it
 	 * would grants MAKE_REG and MAKE_DIR rights to it.
 	 */
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/*
 	 * Moving the file2_s1d3 file below dir_s2d3 is denied because the
@@ -2991,7 +2991,7 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
 	 * default.
 	 */
 	ASSERT_EQ(-1, rename(file2_s1d3, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 }
 
 TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
@@ -3000,42 +3000,42 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
 
 	/* Checks EACCES predominance over EXDEV. */
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/* Modify layout! */
 	ASSERT_EQ(0, rename(file1_s1d2, file1_s2d3));
 
 	/* Without REFER source. */
 	ASSERT_EQ(-1, rename(dir_s1d1, file1_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, file1_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	reparent_exdev_layers_enforce2(_metadata);
 
 	/* Checks EACCES predominance over EXDEV. */
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	/* Checks with actual file2_s1d2. */
 	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Modifying the layout is now denied because the second layer does not
 	 * handle REFER, which is always denied by default.
 	 */
 	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Without REFER source, EACCES wins over EXDEV. */
 	ASSERT_EQ(-1, rename(dir_s1d1, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, file1_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, reparent_exdev_layers_exchange1)
@@ -3053,10 +3053,10 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange1)
 	/* Error predominance with file exchange: returns EXDEV and EACCES. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, file1_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * Checks with directories which creation could be allowed, but denied
@@ -3064,10 +3064,10 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange1)
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD,
 				dir_file2_s2d3, RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD,
 				dir_file1_s1d2, RENAME_EXCHANGE));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Checks with same access rights. */
 	ASSERT_EQ(0, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, dir_s2d3,
@@ -3100,46 +3100,46 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange1)
 	 */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	reparent_exdev_layers_enforce2(_metadata);
 
 	/* Error predominance with file exchange: returns EXDEV and EACCES. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, file1_s1d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Checks with directories which creation is now denied. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD,
 				dir_file2_s2d3, RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD,
 				dir_file1_s1d2, RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Checks with different (child-only) access rights. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, dir_s2d3,
 				RENAME_EXCHANGE));
 	/* Denied because of MAKE_DIR. */
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Checks with different (child-only) access rights. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_file1_s1d2,
 				RENAME_EXCHANGE));
 	/* Denied because of MAKE_DIR. */
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file1_s1d2, AT_FDCWD, dir_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* See layout1.reparent_exdev_layers_exchange2 for complement. */
 }
@@ -3157,10 +3157,10 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange2)
 	/* Checks that exchange between file and directory are consistent. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, reparent_exdev_layers_exchange3)
@@ -3181,10 +3181,10 @@ TEST_F_FORK(layout1, reparent_exdev_layers_exchange3)
 			       RENAME_EXCHANGE));
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_file2_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_file2_s2d3, AT_FDCWD, file1_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, reparent_remove)
@@ -3214,23 +3214,23 @@ TEST_F_FORK(layout1, reparent_remove)
 
 	/* Access denied because of wrong/swapped remove file/dir. */
 	ASSERT_EQ(-1, rename(file1_s1d1, dir_s2d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(dir_s2d2, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s2d2,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s2d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Access allowed thanks to the matching rights. */
 	ASSERT_EQ(-1, rename(file1_s2d1, dir_s1d2));
-	ASSERT_EQ(EISDIR, errno);
+	EXPECT_EQ(EISDIR, errno);
 	ASSERT_EQ(-1, rename(dir_s1d2, file1_s2d1));
-	ASSERT_EQ(ENOTDIR, errno);
+	EXPECT_EQ(ENOTDIR, errno);
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d1));
-	ASSERT_EQ(ENOTDIR, errno);
+	EXPECT_EQ(ENOTDIR, errno);
 	ASSERT_EQ(0, unlink(file1_s2d1));
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	ASSERT_EQ(0, unlink(file2_s1d3));
@@ -3242,7 +3242,7 @@ TEST_F_FORK(layout1, reparent_remove)
 			       RENAME_EXCHANGE));
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s1d3,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, reparent_dom_superset)
@@ -3283,13 +3283,13 @@ TEST_F_FORK(layout1, reparent_dom_superset)
 		   layer1);
 
 	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving file1_s1d2 beneath dir_s2d3 would grant it the READ_FILE
 	 * access right.
 	 */
 	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving file1_s1d2 should be allowed even if dir_s2d2 grants a
 	 * superset of access rights compared to dir_s1d2, because file1_s1d2
@@ -3299,13 +3299,13 @@ TEST_F_FORK(layout1, reparent_dom_superset)
 	ASSERT_EQ(0, rename(file1_s2d2, file1_s1d2));
 
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving dir_s1d3 beneath dir_s2d3 would grant it the MAKE_FIFO access
 	 * right.
 	 */
 	ASSERT_EQ(-1, rename(dir_s1d3, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	/*
 	 * Moving dir_s1d3 should be allowed even if dir_s2d2 grants a superset
 	 * of access rights compared to dir_s1d2, because dir_s1d3 already has
@@ -3322,7 +3322,7 @@ TEST_F_FORK(layout1, reparent_dom_superset)
 	 */
 	ASSERT_EQ(0, rename(file1_s2d3, file2_s1d2));
 	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 	ASSERT_EQ(0, unlink(file2_s1d2));
 	ASSERT_EQ(0, unlink(file2_s2d3));
 	/*
@@ -3331,7 +3331,7 @@ TEST_F_FORK(layout1, reparent_dom_superset)
 	 */
 	ASSERT_EQ(0, rename(dir_s2d3, file2_s1d2));
 	ASSERT_EQ(-1, rename(file2_s1d2, dir_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 }
 
 TEST_F_FORK(layout1, remove_dir)
@@ -3357,13 +3357,13 @@ TEST_F_FORK(layout1, remove_dir)
 
 	/* dir_s1d2 itself cannot be removed. */
 	ASSERT_EQ(-1, rmdir(dir_s1d2));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d2, AT_REMOVEDIR));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rmdir(dir_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d1, AT_REMOVEDIR));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 }
 
 TEST_F_FORK(layout1, remove_file)
@@ -3379,9 +3379,9 @@ TEST_F_FORK(layout1, remove_file)
 	enforce_fs(_metadata, rules[0].access, rules);
 
 	ASSERT_EQ(-1, unlink(file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, unlinkat(AT_FDCWD, file1_s1d1, 0));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, unlink(file1_s1d2));
 	ASSERT_EQ(0, unlinkat(AT_FDCWD, file1_s1d3, 0));
 }
@@ -3415,11 +3415,11 @@ static void test_make_file(struct __test_metadata *const _metadata,
 	enforce_fs(_metadata, access, rules);
 
 	ASSERT_EQ(-1, mknod(file1_s1d1, mode | 0400, dev));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, mknod(file1_s1d2, mode | 0400, dev))
 	{
@@ -3507,11 +3507,11 @@ TEST_F_FORK(layout1, make_sym)
 	enforce_fs(_metadata, rules[0].access, rules);
 
 	ASSERT_EQ(-1, symlink("none", file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, symlink("none", file1_s1d2));
 	ASSERT_EQ(0, link(file1_s1d2, file2_s1d2));
@@ -3542,7 +3542,7 @@ TEST_F_FORK(layout1, make_dir)
 
 	/* Uses file_* as directory names. */
 	ASSERT_EQ(-1, mkdir(file1_s1d1, 0700));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 	ASSERT_EQ(0, mkdir(file1_s1d2, 0700));
 	ASSERT_EQ(0, mkdir(file1_s1d3, 0700));
 }
@@ -3574,8 +3574,8 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
 		   rules);
 
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
 	reg_fd = open(file1_s1d2, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, reg_fd);
 	ASSERT_EQ(0, unlink(file1_s1d2));
@@ -3590,7 +3590,7 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 		TH_LOG("Successfully opened /proc/self/fd/%d: %s", reg_fd,
 		       strerror(errno));
 	}
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	EXPECT_EQ(0, close(reg_fd));
 }
@@ -3613,8 +3613,8 @@ TEST_F_FORK(layout1, proc_pipe)
 	enforce_fs(_metadata, rules[0].access, rules);
 
 	/* Checks enforcement for normal files. */
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDWR));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
 
 	/* Checks access to pipes through FD. */
 	ASSERT_EQ(0, pipe2(pipe_fds, O_CLOEXEC));
@@ -4059,7 +4059,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
-	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
 	EXPECT_EQ(0, close(socket_fds[0]));
 	EXPECT_EQ(0, close(socket_fds[1]));
@@ -5043,24 +5043,24 @@ FIXTURE_TEARDOWN_PARENT(layout1_bind)
 
 TEST_F_FORK(layout1_bind, no_restriction)
 {
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s2d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d1, O_RDONLY));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY));
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
-	ASSERT_EQ(ENOENT, test_open(dir_s2d3, O_RDONLY));
-	ASSERT_EQ(ENOENT, test_open(file1_s2d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	EXPECT_EQ(ENOENT, test_open(dir_s2d3, O_RDONLY));
+	EXPECT_EQ(ENOENT, test_open(file1_s2d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY));
-	ASSERT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY));
+	EXPECT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(dir_s3d1, O_RDONLY));
+	EXPECT_EQ(0, test_open(dir_s3d1, O_RDONLY));
 }
 
 TEST_F_FORK(layout1_bind, same_content_same_file)
@@ -5117,73 +5117,73 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 	enforce_fs(_metadata, ACCESS_RW, layer1_parent);
 
 	/* Checks source hierarchy. */
-	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* Checks destination hierarchy. */
-	ASSERT_EQ(0, test_open(file1_s2d1, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s2d1, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
 
 	/* Sets rules for the mount points. */
 	enforce_fs(_metadata, ACCESS_RW, layer2_mount_point);
 
 	/* Checks source hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
 	/* Checks destination hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s2d1, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s2d1, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s2d1, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s2d1, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s2d2, O_RDWR));
-	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
-	ASSERT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s2d2, O_RDWR));
+	EXPECT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/* Sets a (shared) rule only on the source. */
 	enforce_fs(_metadata, ACCESS_RW, layer3_source);
 
 	/* Checks source hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/* Checks destination hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s2d2, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s2d2, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(EACCES, test_open(file1_s2d2, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s2d2, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
 
-	ASSERT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
-	ASSERT_EQ(EACCES, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
+	EXPECT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/* Sets a (shared) rule only on the destination. */
 	enforce_fs(_metadata, ACCESS_RW, layer4_destination);
 
 	/* Checks source hierarchy. */
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
 
 	/* Checks destination hierarchy. */
-	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_RDONLY));
-	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
+	EXPECT_EQ(EACCES, test_open(bind_file1_s1d3, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
 }
 
 TEST_F_FORK(layout1_bind, reparent_cross_mount)
@@ -5207,15 +5207,15 @@ TEST_F_FORK(layout1_bind, reparent_cross_mount)
 
 	/* Checks basic denied move. */
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s1d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Checks real cross-mount move (Landlock is not involved). */
 	ASSERT_EQ(-1, rename(file1_s2d1, file1_s2d2));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Checks move that will give more accesses. */
 	ASSERT_EQ(-1, rename(file1_s2d2, bind_file1_s1d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Checks legitimate downgrade move. */
 	ASSERT_EQ(0, rename(bind_file1_s1d3, file1_s2d2));
@@ -6850,33 +6850,33 @@ TEST_F_FORK(layout2_overlay, no_restriction)
 	if (self->skip_test)
 		SKIP(return, "overlayfs is not supported (test)");
 
-	ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_fo1, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_do1, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_do1_fo2, O_RDONLY));
-	ASSERT_EQ(0, test_open(lower_do1_fl3, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_fl1, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_dl1, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_fo1, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_do1, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_do1_fo2, O_RDONLY));
+	EXPECT_EQ(0, test_open(lower_do1_fl3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(upper_fu1, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_du1, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_du1_fu2, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_fo1, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_do1, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_do1_fo2, O_RDONLY));
-	ASSERT_EQ(0, test_open(upper_do1_fu3, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_fu1, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_du1, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_du1_fu2, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_fo1, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_do1, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_do1_fo2, O_RDONLY));
+	EXPECT_EQ(0, test_open(upper_do1_fu3, O_RDONLY));
 
-	ASSERT_EQ(0, test_open(merge_fl1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_dl1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_dl1_fl2, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_fu1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_du1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_du1_fu2, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_fo1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_do1, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_do1_fo2, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_do1_fl3, O_RDONLY));
-	ASSERT_EQ(0, test_open(merge_do1_fu3, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_fl1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_dl1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_dl1_fl2, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_fu1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_du1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_du1_fu2, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_fo1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_do1, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_do1_fo2, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_do1_fl3, O_RDONLY));
+	EXPECT_EQ(0, test_open(merge_do1_fu3, O_RDONLY));
 }
 
 #define for_each_path(path_list, path_entry, i)               \
@@ -7020,29 +7020,29 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks lower layer. */
 	for_each_path(lower_base_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	for_each_path(lower_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES,
+		EXPECT_EQ(EACCES,
 			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(lower_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	/* Checks upper layer. */
 	for_each_path(upper_base_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	for_each_path(upper_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES,
+		EXPECT_EQ(EACCES,
 			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(upper_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	/*
 	 * Checks that access rights are independent from the lower and upper
@@ -7051,13 +7051,13 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 	 * through the merge point is still allowed.
 	 */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 
 	/* Sets rules on data directories (i.e. inside overlay scope). */
@@ -7065,13 +7065,13 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks merge. */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 
 	/* Same checks with tighter rules. */
@@ -7079,21 +7079,21 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks changes for lower layer. */
 	for_each_path(lower_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDONLY));
 	}
 	/* Checks changes for upper layer. */
 	for_each_path(upper_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDONLY));
 	}
 	/* Checks all merge accesses. */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 
 	/* Sets rules directly on overlayed files. */
@@ -7101,24 +7101,24 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks unchanged accesses on lower layer. */
 	for_each_path(lower_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	/* Checks unchanged accesses on upper layer. */
 	for_each_path(upper_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
-		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+		EXPECT_EQ(0, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_WRONLY));
 	}
 	/* Checks all merge accesses. */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES,
+		EXPECT_EQ(EACCES,
 			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 
 	/* Only allows access to the merge hierarchy. */
@@ -7126,22 +7126,22 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 
 	/* Checks new accesses on lower layer. */
 	for_each_path(lower_sub_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDONLY));
 	}
 	/* Checks new accesses on upper layer. */
 	for_each_path(upper_sub_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDONLY));
 	}
 	/* Checks all merge accesses. */
 	for_each_path(merge_base_files, path_entry, i) {
-		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(EACCES, test_open(path_entry, O_RDWR));
 	}
 	for_each_path(merge_base_directories, path_entry, i) {
-		ASSERT_EQ(EACCES,
+		EXPECT_EQ(EACCES,
 			  test_open(path_entry, O_RDONLY | O_DIRECTORY));
 	}
 	for_each_path(merge_sub_files, path_entry, i) {
-		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+		EXPECT_EQ(0, test_open(path_entry, O_RDWR));
 	}
 }
 
@@ -7438,7 +7438,7 @@ TEST_F_FORK(layout3_fs, release_inodes)
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
-	ASSERT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
+	EXPECT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
 }
 
 static int matches_log_fs_extra(struct __test_metadata *const _metadata,
@@ -7918,7 +7918,7 @@ TEST_F(audit_layout1, refer_rename_half)
 	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
 
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d3));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* Only half of the request is denied. */
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
@@ -8236,7 +8236,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			};
 		} else {
 			ASSERT_EQ(-1, fd);
-			ASSERT_EQ(EACCES, errno);
+			EXPECT_EQ(EACCES, errno);
 		}
 
 		expect_audit = true;
@@ -8251,12 +8251,12 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			expect_audit = false;
 
 		if (expect_audit)
-			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+			EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 						    blocker, target->target));
 
 		/* Check that we see no (other) logs. */
 		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-		ASSERT_EQ(0, records.access);
+		EXPECT_EQ(0, records.access);
 
 		if (target->expect_open_success && fd >= 0) {
 			if (debug_quiet_tests)
@@ -8268,11 +8268,11 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			} else {
 				ASSERT_EQ(-1, ret);
 				if (open_mode != O_RDONLY)
-					ASSERT_EQ(EACCES, errno);
+					EXPECT_EQ(EACCES, errno);
 			}
 
 			if (target->audit_truncate)
-				ASSERT_EQ(0, matches_log_fs(_metadata,
+				EXPECT_EQ(0, matches_log_fs(_metadata,
 							    self->audit_fd,
 							    "fs\\.truncate",
 							    target->target));
@@ -8292,7 +8292,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			}
 
 			if (target->audit_ioctl)
-				ASSERT_EQ(0, matches_log_fs_extra(
+				EXPECT_EQ(0, matches_log_fs_extra(
 						     _metadata, self->audit_fd,
 						     "fs\\.ioctl_dev",
 						     target->target,
@@ -8301,7 +8301,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			/* Check that we see no other logs. */
 			ASSERT_EQ(0, audit_count_records(self->audit_fd,
 							 &records));
-			ASSERT_EQ(0, records.access);
+			EXPECT_EQ(0, records.access);
 			EXPECT_EQ(0, close(fd));
 		}
 	}
@@ -9690,10 +9690,10 @@ static void simple_quiet_rename(struct __test_metadata *const _metadata,
 		}
 
 		if (source_blockers)
-			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+			EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 						    source_blockers, dir_s1d1));
 		if (dest_blockers)
-			ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+			EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 						    dest_blockers, dir_s2d1));
 	}
 	/*
@@ -9701,7 +9701,7 @@ static void simple_quiet_rename(struct __test_metadata *const _metadata,
 	 * audit_quiet_layout1_test_body.
 	 */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, rename_ok)
@@ -9816,11 +9816,11 @@ TEST_F(audit_quiet_rename, handle_all_deny_quiet_refer)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
 	/* No logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, handle_all_deny_not_quiet_refer)
@@ -9852,16 +9852,16 @@ TEST_F(audit_quiet_rename, handle_all_deny_not_quiet_refer)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d1));
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s2d1));
 
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, handle_all_deny_refer_quiet_source_not_quiet_dest)
@@ -9893,14 +9893,14 @@ TEST_F(audit_quiet_rename, handle_all_deny_refer_quiet_source_not_quiet_dest)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EXDEV, errno);
+	EXPECT_EQ(EXDEV, errno);
 
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s2d1));
 
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_same_dir)
@@ -9924,10 +9924,10 @@ TEST_F(audit_quiet_rename, quiet_same_dir)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored)
@@ -9956,18 +9956,18 @@ TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
 	/* We didn't unlink destination file */
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
 				    dir_s2d1));
 
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored_same_dir)
@@ -9996,15 +9996,15 @@ TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored_same_dir)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
-	ASSERT_EQ(0,
+	EXPECT_EQ(0,
 		  matches_log_fs(_metadata, self->audit_fd,
 				 "fs\\.remove_file,fs\\.make_reg", dir_s1d1));
 
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, two_layers_different_quiet1)
@@ -10052,17 +10052,17 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet1)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * The youngest denial will be layer 2.  Refer is quieted but we are
 	 * also missing remove_file on source.
 	 */
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
 	/* No other logs */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, two_layers_different_quiet2)
@@ -10110,14 +10110,14 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet2)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * The youngest denial will be layer 2, but refer is quieted (and that
 	 * layer does not handle any other accesses).
 	 */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, two_layers_different_quiet3)
@@ -10165,13 +10165,13 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet3)
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/*
 	 * The youngest denial will be layer 2, in which everything is quieted.
 	 */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename,
@@ -10209,15 +10209,15 @@ TEST_F(audit_quiet_rename,
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
 	/* No other logs. */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename,
@@ -10261,14 +10261,14 @@ TEST_F(audit_quiet_rename,
 	ASSERT_EQ(0, apply_a_layer(_metadata, &layer2));
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	/* Source is quieted but destination is not. */
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
 	/* No other logs. */
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, rename_xchg)
@@ -10298,10 +10298,10 @@ TEST_F(audit_quiet_rename, rename_xchg)
 
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, file1_s2d1,
 				RENAME_EXCHANGE));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_on_parent_mount)
@@ -10327,10 +10327,10 @@ TEST_F(audit_quiet_rename, quiet_on_parent_mount)
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, bind_file1_s1d3, AT_FDCWD,
 			       bind_file2_s1d3));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_behind_mountpoint_ignored)
@@ -10356,13 +10356,13 @@ TEST_F(audit_quiet_rename, quiet_behind_mountpoint_ignored)
 
 	ASSERT_EQ(-1, renameat(AT_FDCWD, bind_file1_s1d3, AT_FDCWD,
 			       bind_file2_s1d3));
-	ASSERT_EQ(EACCES, errno);
-	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
+	EXPECT_EQ(EACCES, errno);
+	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.make_reg",
 				    bind_dir_s1d3));
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_on_parent_mount_disconnected)
@@ -10397,10 +10397,10 @@ TEST_F(audit_quiet_rename, quiet_on_parent_mount_disconnected)
 
 	ASSERT_EQ(-1,
 		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 TEST_F(audit_quiet_rename, quiet_behind_mountpoint_disconnected)
@@ -10435,10 +10435,10 @@ TEST_F(audit_quiet_rename, quiet_behind_mountpoint_disconnected)
 
 	ASSERT_EQ(-1,
 		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
-	ASSERT_EQ(EACCES, errno);
+	EXPECT_EQ(EACCES, errno);
 
 	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
-	ASSERT_EQ(0, records.access);
+	EXPECT_EQ(0, records.access);
 }
 
 /* clang-format off */
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index e194fd78d8a1..31e113873d66 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -3720,7 +3720,7 @@ TEST_F(trace_net_address, deny_access_net)
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_TRUE(WIFEXITED(status));
-	ASSERT_EQ(0, WEXITSTATUS(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 4c7f9c102d50..9aa1d375ef51 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -1114,7 +1114,7 @@ TEST(datagram_sockets)
 		ASSERT_EQ(-1, sendto(client_unconn_socket, ".", 1, 0,
 				     &non_connected_addr.unix_addr,
 				     non_connected_addr.unix_addr_len));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 
 		EXPECT_EQ(0, close(client_conn_socket));
@@ -1196,17 +1196,17 @@ TEST(self_connect)
 		ASSERT_EQ(-1,
 			  connect(connected_socket, &connected_addr.unix_addr,
 				  connected_addr.unix_addr_len));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 
 		ASSERT_EQ(-1, sendto(connected_socket, ".", 1, 0,
 				     &connected_addr.unix_addr,
 				     connected_addr.unix_addr_len));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 
 		ASSERT_EQ(-1, sendto(non_connected_socket, ".", 1, 0,
 				     &non_connected_addr.unix_addr,
 				     non_connected_addr.unix_addr_len));
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 
 		EXPECT_EQ(0, close(connected_socket));
 		EXPECT_EQ(0, close(non_connected_socket));
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 66fec3822812..f9c270a1107a 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -124,7 +124,7 @@ TEST_F(scoping_signals, send_sig_to_parent)
 		 */
 		err = kill(parent, variant->sig);
 		ASSERT_EQ(-1, err);
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 
 		/*
 		 * No matter of the domain, a process should be able to
@@ -216,7 +216,7 @@ TEST_F(scoped_domains, check_access_signal)
 			ASSERT_EQ(0, err);
 		} else {
 			ASSERT_EQ(-1, err);
-			ASSERT_EQ(EPERM, errno);
+			EXPECT_EQ(EPERM, errno);
 		}
 		/*
 		 * No matter of the domain, a process should be able to
@@ -241,7 +241,7 @@ TEST_F(scoped_domains, check_access_signal)
 		ASSERT_EQ(0, err);
 	} else {
 		ASSERT_EQ(-1, err);
-		ASSERT_EQ(EPERM, errno);
+		EXPECT_EQ(EPERM, errno);
 	}
 	ASSERT_EQ(0, raise(0));
 
diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
index b90f76ed0d9c..4d8f79170892 100644
--- a/tools/testing/selftests/landlock/scoped_test.c
+++ b/tools/testing/selftests/landlock/scoped_test.c
@@ -26,7 +26,7 @@ TEST(ruleset_with_unknown_scope)
 
 		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
 						      sizeof(ruleset_attr), 0));
-		ASSERT_EQ(EINVAL, errno);
+		EXPECT_EQ(EINVAL, errno);
 	}
 }
 
-- 
2.56.0

