Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826561;
	b=TikoGuBIN38WGtNfLGJ12A7bA46VwokXHROc67eA/57UjtmGsvosOnEyhT+WvBKCl++k
	 M8pn247405etK/MqVBudCLTBCG1Rtv253g8s5ERd+bJBUONzyC8O2wu5G9DI/iMJrTO9T
	 xT3XpdRVoxOAATmEZ1MWe9N7/J+HPp5tW2nT5axtth3YTlxCZLQrOKA52mjrRHkPf4i+4
	 lMCWiaTVQ1UUOxWjgXgC9k74Uabpx4J8F7X6lWlkyIcsrKh7jVMN6WHrzcxuQBGZZd4HY
	 3S2kfWbguKkS5QDzaUcTA+i8YXNMgcYr2/7X7p5X9iNXK6e/BvUlh0d2CW412MSL5vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=X9wnpJsazkN5foWhabxg0QWUZDXf9PEJ3m6VtZwLNVE=;
	b=C3FipgPBC/sOL0bmFb7ApCq1Ic7KVh8jgPYa1nFWV7gOCm00x+DiwDOgGOdM9M2sU/bh
	 YuZBI1L6RWCsHavsfntPS1zFVVS8t8epPbkM3aEGN6dSSkhhjoMgoAcWkWnsCQSLodwFk
	 gn4g0gwWZIPc79o16J4+5T6qkxdpTRdSw67WgXTqYUaa1HH6iR3UwATldLOtzPccnp7j4
	 qsP6hD2diI047Z3OLEJxD7IbnS+Caz+dhpOwfwy4oFULS1UqW8kdpb+KdZly3IU/rLUnM
	 mkkWt9X4SwFzAiaOoyuEvQT8w2XTjGz7M+3eJ/xoWM5HGpXh1aH4yZ8xZYZz3hy2/ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTOXDZr5;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA3607E92E
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EFA3607E92E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTOXDZr5
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so6429665e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826559; x=1794431359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9wnpJsazkN5foWhabxg0QWUZDXf9PEJ3m6VtZwLNVE=;
        b=LTOXDZr5bLktgK4avwYS9F/zbl+kahrT6v5PeXdFUGhBi83GXjDQgEb3rwI+1EolRm
         eOv7aNNuPo+vZIYwCTJ1G2HdFxD/IHyz16btWou1HvdDhyu5jO8dnkoyvHlzqySQeZQx
         RA0EyJrCzZz1OpIcAuhJxJc3ZMSFM2BBNvHRE7HS4RYscwgX+FLutAZEhEzUY0fga0TP
         +IC4ceEY+ZWGdzCKLo4NAXSdqt/rxYt22DJifSvRC7drARWdepAaT8Hg3elaFGxYOyLi
         6bPWeZzIYCWNDJ1sLJunStnZN7tmWCQSq35A5+WNQHlWrpmx+mEnywfVmaPb3jWaan9P
         jC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826559; x=1794431359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9wnpJsazkN5foWhabxg0QWUZDXf9PEJ3m6VtZwLNVE=;
        b=Z3ZuoWtr8kTrJotnoYBwdg9ZEhn90FVJ9QMM1Ol5CHjSw+IP8ITBTYwMhf7iQjVHxh
         M9bjsMZHuc8cCUnyDnbLL6IZMXPAr9fOt4Pf/VDZbF56Fo4NXaXkndhqoztz8FFFG7nZ
         7tKSnKQtAoZXmp/+9Z6yveLNt3i8zySaoCEn+shCisXzkc7FVaUuLroDcQGoYVJAlgJb
         yOP/tLpCWALY9A0mQLRQMktwt0EEJe9GIJon0lS3n+lBsw0W5LbKiCbnhrVAmnDUkpQv
         E9ofNTDes3FNM3kzbcfgVce1h/gSpm75ModQm+pDXuOAu4MSMxOl5Vb6su6+eJGk58zj
         J2ww==
X-Gm-Message-State: APuU4Z/Sf4YV9BMz+W8KVRozC8BaCz1byqMdgi7xcXhmoQNBuG+mHm84
	E8M6srYBOib+vSG+/X1UUlVFi3AFkpsuJ5QLeg9gyuYwISdxg68sg/fn
X-Gm-Gg: AYBFou0thhYHdX6ia6lxDBHAEV1WQZa5LGxJbbEJmIaLsVb4PNcCcK7YnPdlk9v7wG3
	WBV6EKkXorFIrTlrtJm2RcPQGhxl7zcH0zd2QW1d9c+FaIinAvO1TzhnPL8ZV14jeLWgX18+m4N
	AclYXT/ka9RGvE35/xy82SjcbUdbvhdlLez9/tP7oU3OJNRctX8iazbYi1FHXYE5mosNzr4Bxjy
	+vuzVp9xIgsTHe+QwEoIrq9EQZ/580uYXp3HSNv27LOUS9nYquAadOuG1hBtDsrtF8sxKptsDoE
	2ylhLST7BRdsWcgNlECGrIFyENUpXan3dasX6BI14UAHy0n42kl/tGdQTq7D6AYjYEy+S8Eesp7
	cxzoCWTFuLRbprlHkqFByOk3ovoSuvSAKnt8qnYmyhkefoNnqCVUnM1BWpj7z1jOmOuOjAIFoRQ
	vqLUAqAIc9AFaS6xB8pSr4fR3EFLTSO35eMHALB3l+DDIiCMkeTGeNpYwvfDpbQDNOSJteTtUQz
	zl7H71nhlS2Rwx43Kk7NMGpfg2c3g7q/L7r07zZbB9AMvbRx1FmbREgOBMuLd3dWk6Js4PtcGFZ
	d9KwDYKQHUba6mTKsPvgh40vKhNNeGpN2qWmH/jxFzILEFmZblotDJVPM8almqEMzOghZfEQSu8
	=
X-Received: by 2002:a05:600c:848a:b0:4a3:59c9:a756 with SMTP id 5b1f17b1804b1-4ac17b2ce84mr422739115e9.6.1793826559506;
        Wed, 04 Nov 2026 13:09:19 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca2a4fsm12965075e9.15.2026.11.04.13.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:09:19 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:09:01 +0100
Subject: [PATCH v2 15/27] selftests/landlock: Close leaked file descriptors
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
Message-Id: <20261104-selftests-refactor-v2-15-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

Several tests do not close file descriptors they open: the /dev/null FD
in restrict_self_fd and restrict_self_fd_flags, and the parent's ends
of the synchronization pipes in various ptrace, audit, signal and
abstract UNIX socket tests.

Close them once they are not needed anymore.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c                |  2 ++
 tools/testing/selftests/landlock/base_test.c                 |  4 ++++
 tools/testing/selftests/landlock/ptrace_test.c               |  4 ++++
 tools/testing/selftests/landlock/scoped_abstract_unix_test.c | 10 ++++++++++
 tools/testing/selftests/landlock/scoped_signal_test.c        |  1 +
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
index 0bf8632b725f..a6d355807dab 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -352,6 +352,8 @@ TEST(restrict_self_fd)
 
 	EXPECT_EQ(-1, landlock_restrict_self(fd, 0));
 	EXPECT_EQ(EBADFD, errno);
+
+	EXPECT_EQ(0, close(fd));
 }
 
 TEST(restrict_self_fd_flags)
@@ -373,6 +375,8 @@ TEST(restrict_self_fd_flags)
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

