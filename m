Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826594;
	b=Lnos4MPk87OBy1r3mhxf3JWj7SUsp/3L3WxftWhgPRNqN8IX9A2sDmacHBcHEpnKpomG
	 77r61ef0pmQHaROgtdqzAYEgxb490zMWRNn3CRbi/qWdfYbKdslmZTs5leXfQAyoB4mJB
	 ur8L+uQUG/EDUOB11iwWNVNyG41TZPAWV6ErFkUnm/u0UkxutGIjZX1L3kiTBk7j3hUBb
	 Dm0aPlHroYsrM8Px8iLjxJ3yNiwF0A3MHkjboVQYsTk3/eUf/GV51jT3sJwqNBX2w6VSz
	 1Ylzq0L/fzP3Hnnfr153v1Xz4piaRIdm40xkuZQTBb82ngVNj2jpYK4By2kcXGjs39w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=AdAbmtFf1JgVMUMdTl2K+O+I4SIuo2anaVxxTlbzHok=;
	b=iKQdiqnXDHE+iptgjwRnKTjUbLscbL/jhwVqkJEBiJmmqyKJJd/gR0+QoSY+Y1J0bwBe
	 T1W2G2uFGXP7YNT8FfeAgckMIgkjQ0t8q/WhbXhB+MPRpLhkiFP1pTeGpUPaLBcUdXEAu
	 xEWIlsHHlab551G6MH3edkjQnP49Jmn0LcQjWJX88/MFKT4I1YvPhMLTV/zpCXN770ZB5
	 Y38TO1e6bcQbcavFi4IChv32tYd9mc+kSybQwFHmPBLU6nEvyhChuk1+1Hfilx+O/cn0b
	 W+DODt96OL+j0ArYQ2OKLUuxulLxT5VtuSahMMCNmv3LcDg2Kk9vwv0O0BQO01oYcpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IP2jJV7D;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9960A0EB6
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C9960A0EB6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IP2jJV7D
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4649b35bso992440f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826591; x=1794431391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdAbmtFf1JgVMUMdTl2K+O+I4SIuo2anaVxxTlbzHok=;
        b=IP2jJV7DOeL77q09FN1uDadm6ip7xhFR4AiuyWa048F3a386y7C62sOwJyySqAruFp
         R47Xzl47b0BIpMhzCB578Fp2S7FoTWOccEzjGfghN0R0kr/vv6mcUy3x7sAFVplTZjpj
         C7pIPBK4xSnRKt1kz2OWAdZN6pkc5SbWiaG5OBKuxHCs9l7C6WrDM7hyEL22hHdySBCy
         6IXLjn5soxkE9U7eecwVljqKdGPNDztmkCwU1KpfWYSCf9ExVnnkFPLi5ug2Bbdc52Q2
         ZkxW1Uk0TOOG9sImo/Snt2zbqUhbDtA3VV/Y9nqr2ZHVGMfqdI2mhommHMrS0mpokehh
         xCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826591; x=1794431391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdAbmtFf1JgVMUMdTl2K+O+I4SIuo2anaVxxTlbzHok=;
        b=M+aFSh7la2rLFUp+Bi5rda3smBd070o1TxOvMdn3o74ah2BUMgyuPIuIK9fM57F6bS
         EjYT78efi0HoPBWt25+wCbFrAVGWNyLWzfz2YOsKT/6bGEB1nMEXFqM1s5qLxEqC/yws
         H4D3U1pSkz3X+tUmLcVBUviqcaBw+SolXFnEi6dImwKkLRUC0zpUM00Ac2PM4N9BEdNa
         DT/tb+seuJESEaDGYCHI4u7cg/LhkKUGgbmxtdCqnjv5XX017K94/JdY8rv5d0V0ZglM
         FPVVpsBZCJfJUL/7vVNDkZHjTKzww04b1XAX79qIoPuoCm5qYwAxflhGDMo/mWtJoH8X
         grKw==
X-Gm-Message-State: APuU4Z93W/7xAjRhHR0D/xGZ1N8sGKPb9Mp8vYeORl/+cqanUP8T3L8/
	n5zgZubamzpe1aLb8/OWu1B3u2hV+upj7qU7EkWygLx4JUGZSj6mIFup
X-Gm-Gg: AYBFou37WFHkyZhQi1/bDhK1md1Nxk5u1ugr128bAB34fqlm/rOaDx0an7XzqOYIo8s
	2l9RHxEKjbi/y051qG/+NXXjqpixDp4Tjj4tSKwScL3ceBkyvNSrNWmiQRASU7+8HZ2a6Z48yIc
	teec72hbwQORZe/pn9qnMPhT+Im3SGLH2FGhSLnFhp7fFrsMfO5gjuse2bklS9um8Hrxi6ZsMJ4
	dJqlxU+6TORRILEW6xx8ZSileDaWuGIJPdFmf6aVSb+PuQ2sp1KgYC8ASjmHYkM2PXn5L13VeS9
	vlMO5ghquWDENu5NbAeex7nvhf1Zspp1ETloqhioTrqFaduy4IRdNrBVEMc5bZE5bqprwjV7ivn
	f4hb0RsLbgkU68c8dvaTZJKA6+EAOYGbY6KeJjxGjLLh3zGnuAfKeOjK+cqLfJzVE3JKy8MJpZ6
	MMdauTt02waDPVt8eiB2UvbgWCeFl47VDf+i1/xamTZ9dD5ZVDi98EBhN0RivjSgffhVtZtehbj
	rQEumg9H2KKRPuOLtU5Hnpp87P3CgnGwTI7fS8DM7mT8Fnky3RtqCCtZ4x48fQ/OtTmmCFBbbnC
	gufMz2mORaPHcMqm0vKndRsW1t//I1SWtCElvNRBhex8kp7L1HpHJGjdeOS6oHn4N50C0MLfOZg
	=
X-Received: by 2002:a05:6000:29cf:b0:48e:6f76:de9c with SMTP id ffacd0b85a97d-48e6f76f453mr22811528f8f.28.1793826591258;
        Wed, 04 Nov 2026 13:09:51 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece998absm6482615f8f.22.2026.11.04.13.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:50 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:12 +0100
Subject: [PATCH v2 26/27] selftests/landlock: Use EXPECT for closing FDs
 and stopping threads
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-selftests-refactor-v2-26-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Closing FDs and cancelling or joining threads whose results are not
used is teardown, whether it happens at the end of a test or in the
middle of it.  No later check depends on it, so a failure should be
reported without aborting the test.  Use EXPECT for these calls, as
most tests already do.  The same applies to removing the FIFO and
reaping the child at the end of named_pipe_ioctl.

The close(0) in ioctl_error() stays an ASSERT, as the following IOCTL
relies on FD 0 being closed.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c     |  40 ++++-----
 tools/testing/selftests/landlock/fs_test.c       | 106 +++++++++++------------
 tools/testing/selftests/landlock/ptrace_test.c   |  16 ++--
 tools/testing/selftests/landlock/trace_fs_test.c |   8 +-
 tools/testing/selftests/landlock/trace_test.c    |   6 +-
 tools/testing/selftests/landlock/tsync_test.c    |  22 ++---
 6 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 4cb30b943aa8..46af291edaef 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -203,7 +203,7 @@ TEST(create_ruleset_checks_ordering)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 /* Tests ordering of syscall argument checks. */
@@ -249,8 +249,8 @@ TEST(add_rule_checks_ordering)
 	ASSERT_LE(0, path_beneath_attr.parent_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath_attr, 0));
-	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(path_beneath_attr.parent_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 /* Tests ordering of syscall argument and permission checks. */
@@ -272,7 +272,7 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_LE(0, path_beneath_attr.parent_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath_attr, 0));
-	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
+	EXPECT_EQ(0, close(path_beneath_attr.parent_fd));
 
 	/* Checks unprivileged enforcement without no_new_privs. */
 	drop_caps(_metadata);
@@ -307,7 +307,7 @@ TEST(restrict_self_checks_ordering)
 
 	/* Checks valid call. */
 	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST(restrict_self_max_layers)
@@ -328,7 +328,7 @@ TEST(restrict_self_max_layers)
 	ASSERT_LE(0, path_beneath_attr.parent_fd);
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 				       &path_beneath_attr, 0));
-	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
+	EXPECT_EQ(0, close(path_beneath_attr.parent_fd));
 
 	/* Enforces the maximum number of allowed layers. */
 	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
@@ -342,7 +342,7 @@ TEST(restrict_self_max_layers)
 
 	/* Checks that the failed call did not set no_new_privs. */
 	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST(restrict_self_fd)
@@ -496,7 +496,7 @@ TEST(ruleset_fd_io)
 	ASSERT_EQ(-1, read(ruleset_fd, &buf, 1));
 	ASSERT_EQ(EINVAL, errno);
 
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 /* Tests enforcement of a ruleset FD transferred through a UNIX socket. */
@@ -525,14 +525,14 @@ TEST(ruleset_fd_transfer)
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
@@ -540,32 +540,32 @@ TEST(ruleset_fd_transfer)
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
@@ -670,9 +670,9 @@ TEST(useless_quiet_rule_fs)
 	ASSERT_EQ(EINVAL, errno);
 
 	/* Check that the rule had not been added. */
-	ASSERT_EQ(0, close(root_fd));
+	EXPECT_EQ(0, close(root_fd));
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 	ASSERT_EQ(EACCES, errno);
@@ -700,7 +700,7 @@ TEST(useless_quiet_rule_net)
 				    &net_port_attr, LANDLOCK_ADD_RULE_QUIET));
 	ASSERT_EQ(EINVAL, errno);
 
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST(invalid_quiet_bits_1)
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 183dfc42895c..408e4b220e02 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -492,7 +492,7 @@ TEST_F_FORK(layout1, inval)
 					&path_beneath, 0));
 	/* Returns EBADF because ruleset_fd is not a landlock-ruleset FD. */
 	ASSERT_EQ(EBADF, errno);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	ruleset_fd = open(dir_s1d1, O_DIRECTORY | O_CLOEXEC);
 	ASSERT_LE(0, ruleset_fd);
@@ -500,7 +500,7 @@ TEST_F_FORK(layout1, inval)
 					&path_beneath, 0));
 	/* Returns EBADFD because ruleset_fd is not a valid ruleset. */
 	ASSERT_EQ(EBADFD, errno);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Gets a real ruleset. */
 	ruleset_fd =
@@ -508,14 +508,14 @@ TEST_F_FORK(layout1, inval)
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
@@ -556,13 +556,13 @@ TEST_F_FORK(layout1, inval)
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
@@ -632,9 +632,9 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
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
@@ -676,8 +676,8 @@ TEST_F_FORK(layout0, rule_with_unknown_access)
 						&path_beneath, 0));
 		EXPECT_EQ(EINVAL, errno);
 	}
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, rule_with_unhandled_access)
@@ -734,7 +734,7 @@ static void add_path_beneath(struct __test_metadata *const _metadata,
 		TH_LOG("Failed to update the ruleset with \"%s\": %s", path,
 		       strerror(errno));
 	}
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
 }
 
 struct rule {
@@ -836,7 +836,7 @@ TEST_F_FORK(layout0, proc_nsfs)
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
 	ASSERT_EQ(EBADFD, errno);
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
 }
 
 TEST_F_FORK(layout0, unpriv)
@@ -859,7 +859,7 @@ TEST_F_FORK(layout0, unpriv)
 
 	/* enforce_ruleset() calls prctl(no_new_privs). */
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, effective_access)
@@ -907,14 +907,14 @@ TEST_F_FORK(layout1, effective_access)
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
@@ -1363,7 +1363,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
 			 dir_s1d3, 0);
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/*
 	 * Same tests and results as above, except for open(dir_s1d3) which is
@@ -1474,7 +1474,7 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 
 	/* Enforces a second time with the same ruleset. */
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, rule_on_mountpoint)
@@ -1763,7 +1763,7 @@ TEST_F_FORK(layout1, covered_rule)
 	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
 
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
 	ASSERT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
@@ -1886,8 +1886,8 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 	}
 
 	if (rel == REL_OPEN)
-		ASSERT_EQ(0, close(dirfd));
-	ASSERT_EQ(0, close(ruleset_fd));
+		EXPECT_EQ(0, close(dirfd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, relative_open)
@@ -1929,8 +1929,8 @@ static void copy_file(struct __test_metadata *const _metadata,
 	ASSERT_EQ(0, fstat(src_fd, &statbuf));
 	ASSERT_EQ(statbuf.st_size,
 		  sendfile(dst_fd, src_fd, 0, statbuf.st_size));
-	ASSERT_EQ(0, close(src_fd));
-	ASSERT_EQ(0, close(dst_fd));
+	EXPECT_EQ(0, close(src_fd));
+	EXPECT_EQ(0, close(dst_fd));
 }
 
 static void test_execute(struct __test_metadata *const _metadata, const int err,
@@ -3575,7 +3575,7 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 
 	proc_fd = open_proc_fd(_metadata, reg_fd, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, proc_fd);
-	ASSERT_EQ(0, close(proc_fd));
+	EXPECT_EQ(0, close(proc_fd));
 
 	proc_fd = open_proc_fd(_metadata, reg_fd, O_RDWR | O_CLOEXEC);
 	ASSERT_EQ(-1, proc_fd)
@@ -3585,7 +3585,7 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 	}
 	ASSERT_EQ(EACCES, errno);
 
-	ASSERT_EQ(0, close(reg_fd));
+	EXPECT_EQ(0, close(reg_fd));
 }
 
 TEST_F_FORK(layout1, proc_pipe)
@@ -3626,7 +3626,7 @@ TEST_F_FORK(layout1, proc_pipe)
 		TH_LOG("Failed to write through /proc/self/fd/%d: %s",
 		       pipe_fds[1], strerror(errno));
 	}
-	ASSERT_EQ(0, close(proc_fd));
+	EXPECT_EQ(0, close(proc_fd));
 
 	/* Checks read access to pipe through /proc/self/fd . */
 	proc_fd = open_proc_fd(_metadata, pipe_fds[0], O_RDONLY | O_CLOEXEC);
@@ -3637,10 +3637,10 @@ TEST_F_FORK(layout1, proc_pipe)
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
@@ -3901,10 +3901,10 @@ TEST_F_FORK(layout1, ftruncate)
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
@@ -3995,7 +3995,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	if (fd >= 0) {
 		EXPECT_EQ(variant->expected_ftruncate_result,
 			  test_ftruncate(fd));
-		ASSERT_EQ(0, close(fd));
+		EXPECT_EQ(0, close(fd));
 	}
 }
 
@@ -4032,10 +4032,10 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 
 		if (fd >= 0) {
 			ASSERT_EQ(0, send_fd(socket_fds[0], fd));
-			ASSERT_EQ(0, close(fd));
+			EXPECT_EQ(0, close(fd));
 		}
 
-		ASSERT_EQ(0, close(socket_fds[0]));
+		EXPECT_EQ(0, close(socket_fds[0]));
 
 		_exit(_metadata->exit_code);
 		return;
@@ -4047,15 +4047,15 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 
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
@@ -4089,7 +4089,7 @@ TEST(memfd_ftruncate_and_ioctl)
 		EXPECT_EQ(0, test_ftruncate(fd));
 		EXPECT_EQ(0, test_fs_ioc_getflags_ioctl(fd));
 
-		ASSERT_EQ(0, close(fd));
+		EXPECT_EQ(0, close(fd));
 
 		/* Enables Landlock. */
 		enforce_fs(_metadata, ACCESS_ALL, NULL);
@@ -4120,7 +4120,7 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	EXPECT_EQ(EBADF, test_ftruncate(fd));
 	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 
 	/* Enables Landlock. */
 	enforce_fs(_metadata, ACCESS_ALL, NULL);
@@ -4136,7 +4136,7 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	EXPECT_EQ(EBADF, test_ftruncate(fd));
 	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 }
 
 /* Arbitrary command with nonzero bits in both 16-bit halves. */
@@ -4171,7 +4171,7 @@ static int ioctl_error(struct __test_metadata *const _metadata, int fd,
 
 	/* Restores the old FD 0 and closes the backup FD. */
 	ASSERT_EQ(0, dup2(stdinbak_fd, 0));
-	ASSERT_EQ(0, close(stdinbak_fd));
+	EXPECT_EQ(0, close(stdinbak_fd));
 
 	if (res < 0)
 		return err;
@@ -4247,7 +4247,7 @@ TEST_F_FORK(layout1, blanket_permitted_ioctls)
 	/* Default case is also blocked. */
 	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, unknown_ioctl_cmd));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 }
 
 /*
@@ -4281,10 +4281,10 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
@@ -4437,7 +4437,7 @@ TEST_F_FORK(ioctl, handle_dir_access_file)
 	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
 	EXPECT_EQ(0, ioctl(fd, FIGETBSZ, &flag));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 }
 
 TEST_F_FORK(ioctl, handle_dir_access_dir)
@@ -4479,7 +4479,7 @@ TEST_F_FORK(ioctl, handle_dir_access_dir)
 	EXPECT_EQ(0, ioctl(dir_fd, FIOASYNC, &flag));
 	EXPECT_EQ(0, ioctl(dir_fd, FIGETBSZ, &flag));
 
-	ASSERT_EQ(0, close(dir_fd));
+	EXPECT_EQ(0, close(dir_fd));
 }
 
 TEST_F_FORK(ioctl, handle_file_access_file)
@@ -4513,7 +4513,7 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
 	EXPECT_EQ(0, ioctl(fd, FIGETBSZ, &flag));
 
-	ASSERT_EQ(0, close(fd));
+	EXPECT_EQ(0, close(fd));
 }
 
 /*
@@ -7431,7 +7431,7 @@ TEST_F_FORK(layout3_fs, release_inodes)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
 	ASSERT_EQ(EACCES, test_open(TMP_DIR, O_RDONLY));
@@ -8164,7 +8164,7 @@ static int apply_a_layer(struct __test_metadata *const _metadata,
 	{
 		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
 	}
-	ASSERT_EQ(0, close(rs_fd));
+	EXPECT_EQ(0, close(rs_fd));
 
 	if (debug_quiet_tests) {
 		sprint_access_bits(handled_access_s, sizeof(handled_access_s),
@@ -8299,7 +8299,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
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
index 1795d41b779f..0effe5d6d973 100644
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
@@ -514,7 +514,7 @@ TEST_F(trace, add_rule_invalid_fd)
 	/* Invalid ruleset fd (-1). */
 	ASSERT_EQ(-1, landlock_add_rule(-1, LANDLOCK_RULE_PATH_BENEATH,
 					&path_beneath, 0));
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
 
 	buf = tracefs_read_buf();
 	ASSERT_NE(NULL, buf);
@@ -550,7 +550,7 @@ TEST_F(trace, create_domain_invalid)
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

