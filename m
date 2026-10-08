Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196938A71F
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469677; cv=none; b=XOvcbggwgEZlcVSiSP2IMA/mOw6c1/JJxrpLtRyEzSfXsO7uPePWbALafghZkcVafrTseJGnY+8YJ4tyPsykyLQilh499Y0zDg1PnpEKb6AM53J8ewGH07ZDP4pXQzpvfNkfWjtoYK+81QR0DaRwuSv783droESat+DVNyxUfoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469677; c=relaxed/simple;
	bh=eNTbyrhZ9YQ8sZ99oyZCrK4fMnYrteG+ywlW8dtVJxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nV+YvCCAfl7xe7c8NEKJeP9kerNLoiDEx4BUMGQnt28EEe3bF6dxZo1czltbpgZllF7poIRwA0x1+eSeXjotfI/s0Dm0UXr64PYKBn1Gd6iBvope59tT/OtL+K7u95AUWHQ9Gsle1OsWEHPjN7zXcfVko+MFlXlwqkDDox138+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaRq1ZHD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaRq1ZHD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso24926995e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469672; x=1792074472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qvHvblG2C0bFu75uZQts5KU8wYjZyENS6e5NZCp7PMU=;
        b=PaRq1ZHD0ZVTMqF/UupdgYX6tT6uXLX8Jpdove0OfH26pwQdCe1F/L28vDqC7xs7aU
         r7TCbj57Mq1JLJ+3Env5ttSAd9/xai4CppLnPQDq+/IddpJOQYAIWZNi18dISvEQd7H2
         F+KBd/9kwPiXhUOinE8+FIcLBqiK63WpiwBimVgnUJBc1dCAvKn60FClsAPYo1rvaUMY
         Xn3BMfywniboonEX0dVR1oEmoHQYVWJWhj5fwWToGP6tI2gIODbSZIyarXjQkUglINv8
         ceyCAlQ/iOX/Jsv4WS60cyKE4bwL3mMweY70p3pUreiyrFqYA/PqXJWfD/G4kLAsS4QC
         wlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469672; x=1792074472;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qvHvblG2C0bFu75uZQts5KU8wYjZyENS6e5NZCp7PMU=;
        b=urL7aXBaf/Ay33NQI61pnxCiBOpC8ad8odkGwj2zhEbwRd0q7U2XSUvj6wZm2ULwM2
         SLL3Uavb1YR/i4qoMPGWUnNIL5AeSZ8wr9kAAiQVsP4f1dkPJp6NI0YemG2JNYXKayrV
         kSEwtEqDly1SlPCZ6FEJT7uMeSySM7w4KClUiut+vPsEIpFLviFd1ylqstuow9Y/Se+j
         LfnKc8NUYdC6kUYpT/Yi6gyIXQkPnof4I/J9q4n3Bk1ZfwN3Pp2OC1PjvQM0GsR9y5ij
         FbaPkAkDNEVOuNU65luPdpCwTnxnc2+4mj72Ty/df50BDokjVzR16pkbhm6I85jEWOvA
         fV1g==
X-Forwarded-Encrypted: i=1; AKwUvBzKLLXU5Vgw5X3plOMPCi8gnRS9trUioybEmNV1pmI+PijAlIHpMELZ45yD3vcX7ZWWiOnwBVXncwbsCjME2EqipUhCyMk=@vger.kernel.org
X-Gm-Message-State: AFuF++nolayMcSrzhN/TxQo2gRPSemubZWVaTx82THc1yVrt2p5Kja6o
	AanLWwRMT2NXmwwjMSaOri9unVSnF3q6oC1kmBqE+umyDtEHPFecfHE5
X-Gm-Gg: AYBFou01ylu52HnJujNygCLmQulZMbiECtxGbXUEO4I5P9Bc8YmxMnMQ9SV9MIHVKtC
	VCriwkOnX4Ywr69CmZHiIB8CM3c4o0lDQBxuNc7qAZ3//xgjXo0ldE0NXF1pmWnjTS4GUoooBEC
	cXdnZbcbTXUzy8+kMaLqoWhVWpMoSPhofI5/mLZf438xIGn40lMItaYatJd6KCehrP2i6n4k3wR
	WZMA4ZaLthgiwXWriDn7h2V8CHIAxZ9CUNMOvhtxOqGpYgExSavotjr5yiTS35vgV6QVsw9IOOf
	iFdx6f2AW0Wc+LAf4DKZfNKV+10P9c3A7BRCA1MBydMKBbEMwm9+1QkE5YdgNB8rWjDGMidAv1V
	NDol19xAI1cbXLT0q6NQ7ssCXNJ/nw9wrxpbH620aoid9EEdd+IVfxmVq1THit0lVUx7zqN0YiT
	4aTCB/xcqCFw7HG8Eep43X61qkLebp6Gwjrp3XJUuCOdNUVvofHggf+y3nwmh3mMVvozV8wHM99
	kgkkcAygzBtsfq8RXisJ8Qdzze/4dViVg==
X-Received: by 2002:a05:600c:8209:b0:4a1:7ba9:da34 with SMTP id 5b1f17b1804b1-4a180086586mr104436775e9.0.1791469672185;
        Thu, 08 Oct 2026 07:27:52 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d123b5sm11268744f8f.24.2026.10.08.07.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:51 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 26/27] selftests/landlock: Use EXPECT for closing FDs and stopping threads
Date: Thu,  8 Oct 2026 16:25:55 +0200
Message-ID: <20261008142604.39107-28-gnoack3000@gmail.com>
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

Closing FDs and cancelling or joining threads whose results are not
used is teardown, whether it happens at the end of a test or in the
middle of it.  No later check depends on it, so a failure should be
reported without aborting the test.  Use EXPECT for these calls, as
most tests already do.  The same applies to removing the FIFO and
reaping the child at the end of named_pipe_ioctl.

The close(0) in ioctl_error() stays an ASSERT, as the following IOCTL
relies on FD 0 being closed.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c  |  40 +++----
 tools/testing/selftests/landlock/fs_test.c    | 106 +++++++++---------
 .../testing/selftests/landlock/ptrace_test.c  |  16 +--
 .../selftests/landlock/trace_fs_test.c        |   8 +-
 tools/testing/selftests/landlock/trace_test.c |   6 +-
 tools/testing/selftests/landlock/tsync_test.c |  22 ++--
 6 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index f7c063fdc397..862ff91f6418 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -184,7 +184,7 @@ TEST(create_ruleset_checks_ordering)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 /* Tests ordering of syscall argument checks. */
@@ -230,8 +230,8 @@ TEST(add_rule_checks_ordering)
 	ASSERT_LE(0, path_beneath_attr.parent_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath_attr, 0));
-	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(path_beneath_attr.parent_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 /* Tests ordering of syscall argument and permission checks. */
@@ -253,7 +253,7 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_LE(0, path_beneath_attr.parent_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath_attr, 0));
-	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
+	EXPECT_EQ(0, close(path_beneath_attr.parent_fd));
 
 	/* Checks unprivileged enforcement without no_new_privs. */
 	drop_caps(_metadata);
@@ -288,7 +288,7 @@ TEST(restrict_self_checks_ordering)
 
 	/* Checks valid call. */
 	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST(restrict_self_max_layers)
@@ -309,7 +309,7 @@ TEST(restrict_self_max_layers)
 	ASSERT_LE(0, path_beneath_attr.parent_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath_attr, 0));
-	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
+	EXPECT_EQ(0, close(path_beneath_attr.parent_fd));
 
 	/* Enforces the maximum number of allowed layers. */
 	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
@@ -323,7 +323,7 @@ TEST(restrict_self_max_layers)
 
 	/* Checks that the failed call did not set no_new_privs. */
 	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST(restrict_self_fd)
@@ -477,7 +477,7 @@ TEST(ruleset_fd_io)
 	ASSERT_EQ(-1, read(ruleset_fd, &buf, 1));
 	ASSERT_EQ(EINVAL, errno);
 
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 /* Tests enforcement of a ruleset FD transferred through a UNIX socket. */
@@ -506,14 +506,14 @@ TEST(ruleset_fd_transfer)
 	ASSERT_EQ(0,
 		  landlock_add_rule(ruleset_fd_tx, LANDLOCK_RULE_PATH_BENEATH,
 				    &path_beneath_attr, 0));
-	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
+	EXPECT_EQ(0, close(path_beneath_attr.parent_fd));
 
 	/* Sends the ruleset FD over a socketpair and then close it. */
 	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
 				socket_fds));
 	ASSERT_EQ(0, send_fd(socket_fds[0], ruleset_fd_tx));
-	ASSERT_EQ(0, close(socket_fds[0]));
-	ASSERT_EQ(0, close(ruleset_fd_tx));
+	EXPECT_EQ(0, close(socket_fds[0]));
+	EXPECT_EQ(0, close(ruleset_fd_tx));
 
 	child = fork();
 	ASSERT_LE(0, child);
@@ -521,32 +521,32 @@ TEST(ruleset_fd_transfer)
 		const int ruleset_fd_rx = recv_fd(socket_fds[1]);
 
 		ASSERT_LE(0, ruleset_fd_rx);
-		ASSERT_EQ(0, close(socket_fds[1]));
+		EXPECT_EQ(0, close(socket_fds[1]));
 
 		/* Enforces the received ruleset on the child. */
 		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
 		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd_rx, 0));
-		ASSERT_EQ(0, close(ruleset_fd_rx));
+		EXPECT_EQ(0, close(ruleset_fd_rx));
 
 		/* Checks that the ruleset enforcement. */
 		ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 		ASSERT_EQ(EACCES, errno);
 		dir_fd = open("/tmp", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
 		ASSERT_LE(0, dir_fd);
-		ASSERT_EQ(0, close(dir_fd));
+		EXPECT_EQ(0, close(dir_fd));
 		_exit(_metadata->exit_code);
 		return;
 	}
 
-	ASSERT_EQ(0, close(socket_fds[1]));
+	EXPECT_EQ(0, close(socket_fds[1]));
 
 	/* Checks that the parent is unrestricted. */
 	dir_fd = open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, dir_fd);
-	ASSERT_EQ(0, close(dir_fd));
+	EXPECT_EQ(0, close(dir_fd));
 	dir_fd = open("/tmp", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, dir_fd);
-	ASSERT_EQ(0, close(dir_fd));
+	EXPECT_EQ(0, close(dir_fd));
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
@@ -651,9 +651,9 @@ TEST(useless_quiet_rule_fs)
 	ASSERT_EQ(EINVAL, errno);
 
 	/* Check that the rule had not been added. */
-	ASSERT_EQ(0, close(root_fd));
+	EXPECT_EQ(0, close(root_fd));
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 	ASSERT_EQ(EACCES, errno);
@@ -681,7 +681,7 @@ TEST(useless_quiet_rule_net)
 				    &net_port_attr, LANDLOCK_ADD_RULE_QUIET));
 	ASSERT_EQ(EINVAL, errno);
 
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST(invalid_quiet_bits_1)
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 7e36baffdf36..76f319c972db 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -499,7 +499,7 @@ TEST_F_FORK(layout1, inval)
 					&path_beneath, 0));
 	/* Returns EBADF because ruleset_fd is not a landlock-ruleset FD. */
 	ASSERT_EQ(EBADF, errno);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	ruleset_fd = open(dir_s1d1, O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, ruleset_fd);
@@ -507,7 +507,7 @@ TEST_F_FORK(layout1, inval)
 					&path_beneath, 0));
 	/* Returns EBADFD because ruleset_fd is not a valid ruleset. */
 	ASSERT_EQ(EBADFD, errno);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Gets a real ruleset. */
 	ruleset_fd =
@@ -515,14 +515,14 @@ TEST_F_FORK(layout1, inval)
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath, 0));
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
 
 	/* Tests without O_PATH. */
 	path_beneath.parent_fd = open(dir_s1d2, O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, path_beneath.parent_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath, 0));
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
 
 	/* Tests with a ruleset FD. */
 	path_beneath.parent_fd = ruleset_fd;
@@ -563,13 +563,13 @@ TEST_F_FORK(layout1, inval)
 	ASSERT_EQ(ENOMSG, errno);
 	path_beneath.allowed_access &= ~(1ULL << 60);
 
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
 
 	/* Enforces the ruleset. */
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
 	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
 
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 /* clang-format off */
@@ -639,9 +639,9 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
 			ASSERT_EQ(EINVAL, errno);
 		}
 	}
-	ASSERT_EQ(0, close(path_beneath_file.parent_fd));
-	ASSERT_EQ(0, close(path_beneath_dir.parent_fd));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(path_beneath_file.parent_fd));
+	EXPECT_EQ(0, close(path_beneath_dir.parent_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout0, ruleset_with_unknown_access)
@@ -683,8 +683,8 @@ TEST_F_FORK(layout0, rule_with_unknown_access)
 						&path_beneath, 0));
 		EXPECT_EQ(EINVAL, errno);
 	}
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, rule_with_unhandled_access)
@@ -741,7 +741,7 @@ static void add_path_beneath(struct __test_metadata *const _metadata,
 		TH_LOG("Failed to update the ruleset with \"%s\": %s", path,
 		       strerror(errno));
 	}
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
 }
 
 struct rule {
@@ -843,7 +843,7 @@ TEST_F_FORK(layout0, proc_nsfs)
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
 	ASSERT_EQ(EBADFD, errno);
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
 }
 
 TEST_F_FORK(layout0, unpriv)
@@ -866,7 +866,7 @@ TEST_F_FORK(layout0, unpriv)
 
 	/* enforce_ruleset() calls prctl(no_new_privs). */
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, effective_access)
@@ -914,14 +914,14 @@ TEST_F_FORK(layout1, effective_access)
 	ASSERT_LE(0, lseek(reg_fd, 0, SEEK_SET));
 	ASSERT_EQ(1, read(reg_fd, &buf, 1));
 	ASSERT_EQ('.', buf);
-	ASSERT_EQ(0, close(reg_fd));
+	EXPECT_EQ(0, close(reg_fd));
 
 	/* Just in case, double-checks effective actions. */
 	reg_fd = open(file1_s2d2, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, reg_fd);
 	ASSERT_EQ(-1, write(reg_fd, &buf, 1));
 	ASSERT_EQ(EBADF, errno);
-	ASSERT_EQ(0, close(reg_fd));
+	EXPECT_EQ(0, close(reg_fd));
 }
 
 TEST_F_FORK(layout1, unhandled_access)
@@ -1370,7 +1370,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
 			 dir_s1d3, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/*
 	 * Same tests and results as above, except for open(dir_s1d3) which is
@@ -1481,7 +1481,7 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 
 	/* Enforces a second time with the same ruleset. */
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, rule_on_mountpoint)
@@ -1770,7 +1770,7 @@ TEST_F_FORK(layout1, covered_rule)
 	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
 
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
 	ASSERT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
@@ -1893,8 +1893,8 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 	}
 
 	if (rel == REL_OPEN)
-		ASSERT_EQ(0, close(dirfd));
-	ASSERT_EQ(0, close(ruleset_fd));
+		EXPECT_EQ(0, close(dirfd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, relative_open)
@@ -1936,8 +1936,8 @@ static void copy_file(struct __test_metadata *const _metadata,
 	ASSERT_EQ(0, fstat(src_fd, &statbuf));
 	ASSERT_EQ(statbuf.st_size,
 		  sendfile(dst_fd, src_fd, 0, statbuf.st_size));
-	ASSERT_EQ(0, close(src_fd));
-	ASSERT_EQ(0, close(dst_fd));
+	EXPECT_EQ(0, close(src_fd));
+	EXPECT_EQ(0, close(dst_fd));
 }
 
 static void test_execute(struct __test_metadata *const _metadata, const int err,
@@ -3582,7 +3582,7 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 
 	proc_fd = open_proc_fd(_metadata, reg_fd, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, proc_fd);
-	ASSERT_EQ(0, close(proc_fd));
+	EXPECT_EQ(0, close(proc_fd));
 
 	proc_fd = open_proc_fd(_metadata, reg_fd, O_RDWR | O_CLOEXEC);
 	ASSERT_EQ(-1, proc_fd)
@@ -3592,7 +3592,7 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 	}
 	ASSERT_EQ(EACCES, errno);
 
-	ASSERT_EQ(0, close(reg_fd));
+	EXPECT_EQ(0, close(reg_fd));
 }
 
 TEST_F_FORK(layout1, proc_pipe)
@@ -3633,7 +3633,7 @@ TEST_F_FORK(layout1, proc_pipe)
 		TH_LOG("Failed to write through /proc/self/fd/%d: %s",
 		       pipe_fds[1], strerror(errno));
 	}
-	ASSERT_EQ(0, close(proc_fd));
+	EXPECT_EQ(0, close(proc_fd));
 
 	/* Checks read access to pipe through /proc/self/fd . */
 	proc_fd = open_proc_fd(_metadata, pipe_fds[0], O_RDONLY | O_CLOEXEC);
@@ -3644,10 +3644,10 @@ TEST_F_FORK(layout1, proc_pipe)
 		TH_LOG("Failed to read through /proc/self/fd/%d: %s",
 		       pipe_fds[1], strerror(errno));
 	}
-	ASSERT_EQ(0, close(proc_fd));
+	EXPECT_EQ(0, close(proc_fd));
 
-	ASSERT_EQ(0, close(pipe_fds[0]));
-	ASSERT_EQ(0, close(pipe_fds[1]));
+	EXPECT_EQ(0, close(pipe_fds[0]));
+	EXPECT_EQ(0, close(pipe_fds[1]));
 }
 
 /* Invokes truncate(2) and returns its errno or 0. */
@@ -3908,10 +3908,10 @@ TEST_F_FORK(layout1, ftruncate)
 	EXPECT_EQ(0, test_ftruncate(fd_layer2));
 	EXPECT_EQ(EACCES, test_ftruncate(fd_layer3));
 
-	ASSERT_EQ(0, close(fd_layer0));
-	ASSERT_EQ(0, close(fd_layer1));
-	ASSERT_EQ(0, close(fd_layer2));
-	ASSERT_EQ(0, close(fd_layer3));
+	EXPECT_EQ(0, close(fd_layer0));
+	EXPECT_EQ(0, close(fd_layer1));
+	EXPECT_EQ(0, close(fd_layer2));
+	EXPECT_EQ(0, close(fd_layer3));
 }
 
 /* clang-format off */
@@ -4002,7 +4002,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	if (fd >= 0) {
 		EXPECT_EQ(variant->expected_ftruncate_result,
 			  test_ftruncate(fd));
-		ASSERT_EQ(0, close(fd));
+		EXPECT_EQ(0, close(fd));
 	}
 }
 
@@ -4039,10 +4039,10 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 
 		if (fd >= 0) {
 			ASSERT_EQ(0, send_fd(socket_fds[0], fd));
-			ASSERT_EQ(0, close(fd));
+			EXPECT_EQ(0, close(fd));
 		}
 
-		ASSERT_EQ(0, close(socket_fds[0]));
+		EXPECT_EQ(0, close(socket_fds[0]));
 
 		_exit(_metadata->exit_code);
 		return;
@@ -4054,15 +4054,15 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 
 		EXPECT_EQ(variant->expected_ftruncate_result,
 			  test_ftruncate(fd));
-		ASSERT_EQ(0, close(fd));
+		EXPECT_EQ(0, close(fd));
 	}
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
 	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 
-	ASSERT_EQ(0, close(socket_fds[0]));
-	ASSERT_EQ(0, close(socket_fds[1]));
+	EXPECT_EQ(0, close(socket_fds[0]));
+	EXPECT_EQ(0, close(socket_fds[1]));
 }
 
 /* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
@@ -4096,7 +4096,7 @@ TEST(memfd_ftruncate_and_ioctl)
 		EXPECT_EQ(0, test_ftruncate(fd));
 		EXPECT_EQ(0, test_fs_ioc_getflags_ioctl(fd));
 
-		ASSERT_EQ(0, close(fd));
+		EXPECT_EQ(0, close(fd));
 
 		/* Enables Landlock. */
 		enforce_fs(_metadata, ACCESS_ALL, NULL);
@@ -4127,7 +4127,7 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	EXPECT_EQ(EBADF, test_ftruncate(fd));
 	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 
 	/* Enables Landlock. */
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
@@ -4143,7 +4143,7 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	EXPECT_EQ(EBADF, test_ftruncate(fd));
 	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 }
 
 /*
@@ -4175,7 +4175,7 @@ static int ioctl_error(struct __test_metadata *const _metadata, int fd,
 
 	/* Restores the old FD 0 and closes the backup FD. */
 	ASSERT_EQ(0, dup2(stdinbak_fd, 0));
-	ASSERT_EQ(0, close(stdinbak_fd));
+	EXPECT_EQ(0, close(stdinbak_fd));
 
 	if (res < 0)
 		return err;
@@ -4251,7 +4251,7 @@ TEST_F_FORK(layout1, blanket_permitted_ioctls)
 	/* Default case is also blocked. */
 	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, 0xc00ffeee));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 }
 
 /*
@@ -4285,10 +4285,10 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
 	/* FIONREAD is implemented by pipefifo_fops. */
 	EXPECT_EQ(0, test_fionread_ioctl(fd));
 
-	ASSERT_EQ(0, close(fd));
-	ASSERT_EQ(0, unlink(path));
+	EXPECT_EQ(0, close(fd));
+	EXPECT_EQ(0, unlink(path));
 
-	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
+	EXPECT_EQ(child_pid, waitpid(child_pid, NULL, 0));
 }
 
 /*
@@ -4441,7 +4441,7 @@ TEST_F_FORK(ioctl, handle_dir_access_file)
 	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
 	EXPECT_EQ(0, ioctl(fd, FIGETBSZ, &flag));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 }
 
 TEST_F_FORK(ioctl, handle_dir_access_dir)
@@ -4483,7 +4483,7 @@ TEST_F_FORK(ioctl, handle_dir_access_dir)
 	EXPECT_EQ(0, ioctl(dir_fd, FIOASYNC, &flag));
 	EXPECT_EQ(0, ioctl(dir_fd, FIGETBSZ, &flag));
 
-	ASSERT_EQ(0, close(dir_fd));
+	EXPECT_EQ(0, close(dir_fd));
 }
 
 TEST_F_FORK(ioctl, handle_file_access_file)
@@ -4517,7 +4517,7 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
 	EXPECT_EQ(0, ioctl(fd, FIGETBSZ, &flag));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 }
 
 /*
@@ -7435,7 +7435,7 @@ TEST_F_FORK(layout3_fs, release_inodes)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
 	ASSERT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
@@ -8167,7 +8167,7 @@ static int apply_a_layer(struct __test_metadata *const _metadata,
 	{
 		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
 	}
-	ASSERT_EQ(0, close(rs_fd));
+	EXPECT_EQ(0, close(rs_fd));
 
 	if (debug_quiet_tests) {
 		sprint_access_bits(handled_access_s, sizeof(handled_access_s),
@@ -8302,7 +8302,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 			ASSERT_EQ(0, audit_count_records(self->audit_fd,
 							 &records));
 			ASSERT_EQ(0, records.access);
-			ASSERT_EQ(0, close(fd));
+			EXPECT_EQ(0, close(fd));
 		}
 	}
 }
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index ea8e4be6659e..f253c6a3a436 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -183,8 +183,8 @@ TEST_F(scoped_domains, trace)
 	if (child == 0) {
 		char buf_child;
 
-		ASSERT_EQ(0, close(pipe_parent[1]));
-		ASSERT_EQ(0, close(pipe_child[0]));
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
 		if (variant->domain_child)
 			create_domain(_metadata);
 
@@ -238,8 +238,8 @@ TEST_F(scoped_domains, trace)
 		return;
 	}
 
-	ASSERT_EQ(0, close(pipe_child[1]));
-	ASSERT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_child[1]));
+	EXPECT_EQ(0, close(pipe_parent[0]));
 	if (variant->domain_parent)
 		create_domain(_metadata);
 
@@ -370,8 +370,8 @@ TEST_F(audit, trace)
 	if (child == 0) {
 		char buf_child;
 
-		ASSERT_EQ(0, close(pipe_parent[1]));
-		ASSERT_EQ(0, close(pipe_child[0]));
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
 
 		/* Waits for the parent to be in a domain, if any. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
@@ -400,8 +400,8 @@ TEST_F(audit, trace)
 		return;
 	}
 
-	ASSERT_EQ(0, close(pipe_child[1]));
-	ASSERT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_child[1]));
+	EXPECT_EQ(0, close(pipe_parent[0]));
 	create_domain(_metadata);
 
 	/* Signals that the parent is in a domain. */
diff --git a/tools/testing/selftests/landlock/trace_fs_test.c b/tools/testing/selftests/landlock/trace_fs_test.c
index 64014ade3a0e..06161aa6d5d7 100644
--- a/tools/testing/selftests/landlock/trace_fs_test.c
+++ b/tools/testing/selftests/landlock/trace_fs_test.c
@@ -210,8 +210,8 @@ TEST_F(trace_fs, add_rule_path_beneath)
 
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath, 0));
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
@@ -274,8 +274,8 @@ TEST_F(trace_fs, add_rule_path_beneath_escaped_path_overflow)
 
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath, 0));
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
diff --git a/tools/testing/selftests/landlock/trace_test.c b/tools/testing/selftests/landlock/trace_test.c
index a331df746dbc..df6cc3c4d945 100644
--- a/tools/testing/selftests/landlock/trace_test.c
+++ b/tools/testing/selftests/landlock/trace_test.c
@@ -163,7 +163,7 @@ TEST_F(trace, create_ruleset)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
@@ -508,7 +508,7 @@ TEST_F(trace, add_rule_invalid_fd)
 	/* Invalid ruleset fd (-1). */
 	ASSERT_EQ(-1, landlock_add_rule(-1, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
@@ -544,7 +544,7 @@ TEST_F(trace, create_domain_invalid)
 	/* Unknown flags. */
 	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, -1));
 
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
index 2b53596c986e..aff973ba4735 100644
--- a/tools/testing/selftests/landlock/tsync_test.c
+++ b/tools/testing/selftests/landlock/tsync_test.c
@@ -152,10 +152,10 @@ TEST_F(multi_threaded, restrict)
 	EXPECT_EQ(variant->expected_no_new_privs,
 		  prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
 
-	ASSERT_EQ(0, pthread_cancel(t1));
-	ASSERT_EQ(0, pthread_cancel(t2));
-	ASSERT_EQ(0, pthread_join(t1, NULL));
-	ASSERT_EQ(0, pthread_join(t2, NULL));
+	EXPECT_EQ(0, pthread_cancel(t1));
+	EXPECT_EQ(0, pthread_cancel(t2));
+	EXPECT_EQ(0, pthread_join(t1, NULL));
+	EXPECT_EQ(0, pthread_join(t2, NULL));
 
 	/* Checks the no_new_privs state of the sibling threads. */
 	EXPECT_EQ(variant->expected_no_new_privs, no_new_privs1);
@@ -184,10 +184,10 @@ TEST(multi_threaded_success_despite_diverging_domains)
 	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd,
 					    LANDLOCK_RESTRICT_SELF_TSYNC));
 
-	ASSERT_EQ(0, pthread_cancel(t1));
-	ASSERT_EQ(0, pthread_cancel(t2));
-	ASSERT_EQ(0, pthread_join(t1, NULL));
-	ASSERT_EQ(0, pthread_join(t2, NULL));
+	EXPECT_EQ(0, pthread_cancel(t1));
+	EXPECT_EQ(0, pthread_cancel(t2));
+	EXPECT_EQ(0, pthread_join(t1, NULL));
+	EXPECT_EQ(0, pthread_join(t2, NULL));
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
@@ -309,11 +309,11 @@ TEST(tsync_interrupt)
 					    LANDLOCK_RESTRICT_SELF_TSYNC));
 
 	sd.stop = true;
-	ASSERT_EQ(0, pthread_join(signaler, NULL));
+	EXPECT_EQ(0, pthread_join(signaler, NULL));
 
 	for (i = 0; i < NUM_IDLE_THREADS; i++) {
-		ASSERT_EQ(0, pthread_cancel(threads[i]));
-		ASSERT_EQ(0, pthread_join(threads[i], NULL));
+		EXPECT_EQ(0, pthread_cancel(threads[i]));
+		EXPECT_EQ(0, pthread_join(threads[i], NULL));
 	}
 
 	EXPECT_EQ(0, close(ruleset_fd));
-- 
2.56.0

