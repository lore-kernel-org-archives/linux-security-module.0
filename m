Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46853905F0
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469649; cv=none; b=m6G4FktHOwl/wqq5Kq8EnPay1Lcnok+tpEIz3O/fIxKWuvZrVzoclOWI8XnLXlMi4TldIzn4puydAP99ZydzW/rN11fod4tLSkF53fiQU3id5BWdv7qBvpboJVrqR+tDR3en77zD62VOA00fs+pTl0EB9Ud5wYKNT2AidxYhh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469649; c=relaxed/simple;
	bh=CYMxGpl0gqnxoQtAzj9UWopPTaf81xquV2tv5Zrv+aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiJ1jUKHMfidV28PbGpwqiTLXZj5lZd5gPrq2BwKzmjmU8m20ngIZfT7Tn3MlENSnIT00Djoa8lWsac/UqnCPLp+EznSdnHOgr9Pl3D6aMPSJWj1UNArfsmKHeva81BCf2++uWYw2N3E5L6MXEVCwMll+DOC8Jwhpg1hp8nGyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNkn9cYP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNkn9cYP"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c411d6615so2170608f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469642; x=1792074442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UmnYyLvjlBAMZyReJTQjHEzFhauyvQvB+0OligZ34Po=;
        b=dNkn9cYPcHBUXxat+/Pjjp9PDazWdf+D+VgC74OLLsDR+nTNSjiaFYN9S/vL0HfYHI
         DaImCxM/MPjRRQJ8rt58AqFLg0UR39O3y3OrKiIA9YM82BtjV2oLyE4iE2vfPQ7DcG7p
         3QmGybF4vmtD+HWe1BJHdazwdp9Rkiy2lXwt0voozERopDW3OUx6Lb9PdgOhxXP5CL1R
         YN9Txqvyh7phiXEWKurmzCw/M8yf7JzdHCOGs1NCou4/2Nqa6zHFkeBhTavvGwK5opRc
         jQ8czF3UpGieMSk8UBDsQqFrfRc/hr7vh/rNmSIyPnf4sSd9iHqr7l2hN02o1ejpMLe6
         lwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469642; x=1792074442;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmnYyLvjlBAMZyReJTQjHEzFhauyvQvB+0OligZ34Po=;
        b=O8Ctnc3kOeTG7G8jvTcX8VHR0ce+E1eDd+1AjU6AK5PjlvP6ozM51brvQrTCDXuRfH
         w3CeqkH9ey/kvQ4e33gOokd8DC83rgO4MXnrGMeNV0LvKZQyMRBRSntrhqqKli4ww6p2
         p7etFFdHozudZCTZIM8/w7/NbmObydOfuy554/MrvagldKQxE6XYcfxqpafTJuLUVrm0
         l6GnDkicd0xY6oohWSKYOCw8W5ozgROGN5FVp8fZFbAOL907ZeIKeUbOIpjpn6oG8c2K
         MsvBGPLulnSY7XpLG3TL9ccOdVQuY1982jl2cdT+ougUaWJie5MTCsL9mkj356O+bAlI
         N36w==
X-Forwarded-Encrypted: i=1; AKwUvBwDs+r4fEAeY+DPz6V53opgYZdlZZ6khOOPuTXmnm/nEW/m8IMSVJsJahD1HjGWzjqQSH6lGyIv+WJWEHiljU+Xns+Pdcw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIigWHwl9MAMMpMyj4tANzBkM38J1yoLCbrySp+Z0gB7JZ8K2X5
	uyk53WgLVHU/XSQwhvBYhq4pV+YOZKBmzv5v8ZLYrqOJc94ukvPhvFad
X-Gm-Gg: AYBFou2vqQS+/le+XebB3xPthTp6ytR5oTh6XGGovGCFtcOT7pvWzE2awg+ceMDj/o/
	l9Av406M/X3XR2hfhLV0nyxk5bjoKQAkrCjldt/asIsOFGaqXQAUPSwyXx5qZKNbhvErt3Ensow
	IrT9lKfMByENT5dVfqrelkwPcl0kwBNv0C7Vvd42MMNY16hQPbWBnKWk8UuZUNYfMCn94RPbm9A
	eQe0IlkiHcZJglyfzBieUXuVbywxVXCm3/ka/448IJ+iqzzrBpaBtxlYxxj7tjDqfqlEruagaZR
	o44FaWKIh/V7GFY4CHgklj8cZK4kJkeMOOU+N8sXa752s9RsVTeFajRGP6iYtaV4DQGpHaKUyhI
	jS95kqYBPoIMbz/HQfVh0+Shm6sjb/VCiN8Ye8VLi0PD+K2RvC6rQ9oAPVyPjBnmuQLz4dSKw21
	XJiUA+b0eLROzZF0DHykvhDsCAUw3p56w/0Cj2+Y2MpmjEaHhu0pK8nbtGBALAoqSq9YjHUPvW2
	YV42Np+pDA/awK5bpCLyz4=
X-Received: by 2002:a5d:43cd:0:b0:48a:fb26:23a4 with SMTP id ffacd0b85a97d-48c72770db8mr8316238f8f.31.1791469640496;
        Thu, 08 Oct 2026 07:27:20 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d2014asm11490051f8f.38.2026.10.08.07.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:20 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/27] selftests/landlock: Close leaked file descriptors
Date: Thu,  8 Oct 2026 16:25:44 +0200
Message-ID: <20261008142604.39107-17-gnoack3000@gmail.com>
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

Several tests do not close file descriptors they open: the /dev/null FD
in restrict_self_fd and restrict_self_fd_flags, and the parent's ends
of the synchronization pipes in various ptrace, audit, signal and
abstract UNIX socket tests.

Close them once they are not needed anymore.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c          |  2 ++
 tools/testing/selftests/landlock/base_test.c           |  4 ++++
 tools/testing/selftests/landlock/ptrace_test.c         |  4 ++++
 .../selftests/landlock/scoped_abstract_unix_test.c     | 10 ++++++++++
 tools/testing/selftests/landlock/scoped_signal_test.c  |  1 +
 5 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 325fbb9ca297..b38d0c5d5869 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -977,6 +977,8 @@ TEST_F(audit_exec, signal_and_open)
 
 	/* Waits for the child to terminate. */
 	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+	EXPECT_EQ(0, close(pipe_child[0]));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	ASSERT_EQ(1, WIFEXITED(status));
 	ASSERT_EQ(0, WEXITSTATUS(status));
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 4e83f9c52a6f..e486e557f453 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -333,6 +333,8 @@ TEST(restrict_self_fd)
 
 	EXPECT_EQ(-1, landlock_restrict_self(fd, 0));
 	EXPECT_EQ(EBADFD, errno);
+
+	EXPECT_EQ(0, close(fd));
 }
 
 TEST(restrict_self_fd_flags)
@@ -354,6 +356,8 @@ TEST(restrict_self_fd_flags)
 	EXPECT_EQ(-1, landlock_restrict_self(
 			      fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	EXPECT_EQ(EBADFD, errno);
+
+	EXPECT_EQ(0, close(fd));
 }
 
 TEST(restrict_self_flags)
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index eb36d4d1ceaf..4fd2b440aa45 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -288,6 +288,8 @@ TEST_F(scoped_domains, trace)
 
 	/* Signals that the parent PTRACE_ATTACH test is done. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+	EXPECT_EQ(0, close(pipe_child[0]));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
@@ -422,6 +424,8 @@ TEST_F(audit, trace)
 
 	/* Signals that the parent PTRACE_ATTACH test is done. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+	EXPECT_EQ(0, close(pipe_child[0]));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 67fcc3380238..df41da5f2ab0 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -156,6 +156,7 @@ TEST_F(scoped_domains, connect_to_parent)
 
 	/* Signals to child that the parent is listening. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	EXPECT_EQ(0, close(stream_server));
@@ -263,6 +264,8 @@ TEST_F(scoped_domains, connect_to_child)
 		EXPECT_EQ(EPERM, errno_dgram);
 	}
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+	EXPECT_EQ(0, close(pipe_child[0]));
 	EXPECT_EQ(0, close(stream_client));
 	EXPECT_EQ(0, close(dgram_client));
 
@@ -433,6 +436,8 @@ TEST_F(scoped_audit, connect_to_child)
 	EXPECT_EQ(0, records.access);
 
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+	EXPECT_EQ(0, close(pipe_child[0]));
 	EXPECT_EQ(0, close(dgram_client));
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
@@ -637,6 +642,7 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 	ASSERT_EQ(0, listen(stream_server_parent, backlog));
 
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	EXPECT_EQ(0, close(stream_server_parent));
 	EXPECT_EQ(0, close(dgram_server_parent));
@@ -779,6 +785,7 @@ TEST_F(outside_socket, socket_with_different_domain)
 	} else {
 		server_socket = socket(AF_UNIX, variant->type, 0);
 	}
+	EXPECT_EQ(0, close(pipe_child[0]));
 	ASSERT_LE(0, server_socket);
 
 	/* Server always has a domain. */
@@ -791,6 +798,7 @@ TEST_F(outside_socket, socket_with_different_domain)
 
 	/* Signals to child that the parent is listening. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
 
 	ASSERT_EQ(child, waitpid(child, &status, 0));
 	EXPECT_EQ(0, close(server_socket));
@@ -1139,6 +1147,8 @@ TEST(datagram_sockets)
 	 */
 	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
 	ASSERT_EQ(1, recv(server_conn_socket, &buf, 1, 0));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+	EXPECT_EQ(0, close(pipe_child[0]));
 
 	/* Waits for all tests to finish. */
 	ASSERT_EQ(child, waitpid(child, &status, 0));
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index 47307dd2e242..0f88a6af9c72 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -1120,6 +1120,7 @@ TEST_F(trace_fown, deny_scope_fown)
 	ASSERT_EQ(0, fcntl(recv_socket, F_SETOWN, child));
 
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
 
 	/* Waits for the child to send MSG_OOB. */
 	ASSERT_EQ(1, read(pipe_child[0], &buffer_parent, 1));
-- 
2.56.0

