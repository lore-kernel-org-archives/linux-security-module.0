Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2238E5E9
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469638; cv=none; b=sz59sN1MC0ff/CWk4HnO4IPutDVYlAKC0D2lqvDX1l4TAJbXURKqOdnJofGluOojGgRSVU9NqQuESN1lDK0TwiS7rsr/gYx3zmwASt1z6Dktmiu8JnqX/jS0zZAwBbOjAZsBL9BGHTnBd0OLR/itRhma45cAXM8f6fZ0vM1S4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469638; c=relaxed/simple;
	bh=MHXA/p18wwoJ/6jOGALFX69//S5UywksHFNnMmWZ1hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfEh7nzcCvYqiXAYFoCmoJ4Hf1jqpqgQ4N1jaCDI6hDVCysr1eSHTZdbuueX1u+L2KEknjTSLUgt7E+bEu+DpOtjI5c2Ffw+2uVIjqOPMzd3dOiTtmGWNp29kByCL9Amj+DyF/B0mh+arz1qLpA6MlewL+xfy/I6cmE6VHegJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHmT7AEm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHmT7AEm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b0d19cf7eso596687f8f.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2026 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791469634; x=1792074434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xgtN/bWh4jDHL33H6HSiMFAylcYoNKBIW5SYqc6Om/U=;
        b=ZHmT7AEmogughJyxzEglUiKsDp42+wu/G6IwR4JSBZcncvPNCd4Oq1LcPxVwRdc8I/
         eKJg/XJVL9zpXh7d+a+IBkJsxndCc3ijw75DbBwnZg7Xk9mETem1NUObuHj03FXa8FSe
         4tjw4HvRdF5vIz1o8OPvQksXFQ+YPW8WmFZv6vr0hE9diJoUTaiH2nkhRVG2lcCyuEbl
         AGoaYn2qKI8T0UOTx9rwmRvzNMszDgGDpFmE/PVg1oeqCHqI/OfLMIapk2wHbL22UVNF
         yX1heNmrdtMTjL5E5M5jI5R3DX4zrMXnx6o90whoQ58Fnx+IyPKH+vs5kxKfE9Nor956
         WsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469634; x=1792074434;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgtN/bWh4jDHL33H6HSiMFAylcYoNKBIW5SYqc6Om/U=;
        b=WyZ8klmASr5iY3KXXAIuDLbhh/iZQfvKL5MSMgYAl+9eD1etTwRTICCM8u7N+OpjNv
         6Y9tqR/ZOLmm6r3j7Q1ElMAoMBbr3E7Frl4ZrphmuSckPLlvkuztm3qTcGg/CuG+jwEt
         XtlfxT37UlQZ8Bu7p9EUwkKjdX3I6lvmeQ049r5PBhqakvlzJUvwZLWaie/nRegB4CBb
         CFLug5jsfV5x3i1XRv904FHkDWEg/kRfmEYQXVXVrYZwZg+tu/ixyx7vonn2LOURKRtg
         BqX9/sL+xpPGO2W5ywqDlyb0g4cyzuiI+TEyK5tHO4WJMT23asdfhgTvL7ETkrblOC4U
         tRSw==
X-Forwarded-Encrypted: i=1; AKwUvBxB5thqVUxUTYtj3VZioogggZeUCI1hy0WHUspciMgLnGSaoA/nveA36wFxwAf0wisgddhWZSOC+GtPyRz8cMtjP1w5s9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKUMsBQCW0whd12orwg4h9KX3vqUL98Mgb7lI3H8jpuz/x/0Y1
	KTTOP4rtghwLXHbgbkp5+meUblElxhGLR4Eb3F2OY3tuSNv300f57YLy
X-Gm-Gg: AYBFou3hzLG+ulTjgYdV7BAwcFiv/mmJtHKCb2ZSdGqpjO/8CL6hxc2M1BN6W+9g9Ea
	0Hf7GUQBsgnnn6GECM4l6DfvswIN5QIAgiEI655oajnCphWazd7Uueak7axSosONfntThh74iLN
	M4k0Zti5gR13MBS6KSgjFyAbEcRIEDTWkFztHsKd2V8uAw48BdNzNR9kdc6sOcdcclcucUFsJGF
	FucYiYfOPgigvHWpzt6niWye0FM2w5jYF8vzaeCU7quVYcuusFtU2UwbukZ5TXVMQwuD0LXmQdF
	ZbtSfNHjQDGTffZyaI9Pyp2K2TWiZIcNRIp0S9KAziXKRLqdp/vc9kde8lRr116R38VdQzY1bty
	ltplAH/Xhnxk/fSQF12Y7nyIk66W2cO1dxgx7RA8LIBYoMgofyGf34CCSQrmz8zR1ye48+2tP5o
	TW1rkalieWCRPKz0vtnTs24+dXjA9s5PPn5y5j+necWEahtgBgruL9ZPPDx6FeYx1EarTyShCyS
	BF7SrAmxWO6OP3Lg02ZUBM=
X-Received: by 2002:a05:6000:4710:b0:48c:5a7b:7573 with SMTP id ffacd0b85a97d-48c7f1318d0mr5869426f8f.29.1791469633611;
        Thu, 08 Oct 2026 07:27:13 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71bd769csm11424714f8f.5.2026.10.08.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:27:12 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Wang Yan <wangyan01@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/27] selftests/landlock: Assert audit_count_records() before using its result
Date: Thu,  8 Oct 2026 16:25:41 +0200
Message-ID: <20261008142604.39107-14-gnoack3000@gmail.com>
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

audit_count_records() fills in the record counts that are checked right
after it, but its return value is checked with EXPECT.  On failure, the
counts may be left uninitialized and the following checks are
meaningless.  Use ASSERT instead.

Assisted-by: LLM
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/audit_test.c | 20 ++---
 tools/testing/selftests/landlock/fs_test.c    | 86 +++++++++----------
 tools/testing/selftests/landlock/net_test.c   | 22 ++---
 .../testing/selftests/landlock/ptrace_test.c  |  6 +-
 .../landlock/scoped_abstract_unix_test.c      |  4 +-
 5 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 63b1b2a04eee..325fbb9ca297 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -329,7 +329,7 @@ TEST_F(audit, log_subdomains_off_fork)
 					NULL));
 
 	/* Drains any remaining records (e.g. domain allocation). */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 
 	/*
 	 * Mutes subdomain logs without creating a domain.  The parent's
@@ -361,7 +361,7 @@ TEST_F(audit, log_subdomains_off_fork)
 	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
 					      getpid(), NULL));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	EXPECT_EQ(0, close(ruleset_fd));
@@ -487,7 +487,7 @@ TEST_F(audit, log_subdomains_off_tsync)
 					child_data.parent_pid, NULL));
 
 	/* Drains any remaining records (e.g. domain allocation). */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 
 	/*
 	 * Mutes subdomain logs and propagates to the sibling thread via TSYNC,
@@ -509,7 +509,7 @@ TEST_F(audit, log_subdomains_off_tsync)
 	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
 					      child_data.parent_pid, NULL));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	EXPECT_EQ(0, close(pipe_child[0]));
@@ -571,7 +571,7 @@ TEST_F(audit, tsync_override_log_subdomains_off)
 					      child_data.parent_pid, NULL));
 
 	/* Drains any remaining records. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	/*
@@ -740,7 +740,7 @@ TEST_F(audit_flags, signal)
 		EXPECT_EQ(EPERM, errno);
 
 		/* Makes sure there is no superfluous logged records. */
-		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 		if (!expect_audit) {
 			EXPECT_EQ(0, records.access);
 		} else {
@@ -929,7 +929,7 @@ TEST_F(audit_exec, signal_and_open)
 	EXPECT_EQ(1, read(pipe_child[0], &buf_parent, 1));
 
 	/* Tests that there was no denial until now. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -948,7 +948,7 @@ TEST_F(audit_exec, signal_and_open)
 	}
 
 	/* Checks that we didn't miss anything. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	/*
@@ -972,7 +972,7 @@ TEST_F(audit_exec, signal_and_open)
 	}
 
 	/* Checks that we didn't miss anything. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	/* Waits for the child to terminate. */
@@ -995,7 +995,7 @@ TEST_F(audit_exec, signal_and_open)
 	}
 
 	/* Checks that we didn't miss anything. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 }
 
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 779a7bf477a9..b1ce0f810e10 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7538,7 +7538,7 @@ TEST_F(audit_layout1, execute_make)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.execute",
 				    file1_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7569,7 +7569,7 @@ TEST_F(audit_layout1, execute_read)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.execute,fs\\.read_file", file1_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7584,7 +7584,7 @@ TEST_F(audit_layout1, write_file)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.write_file", file1_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7599,7 +7599,7 @@ TEST_F(audit_layout1, read_file)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_file",
 				    file1_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7614,7 +7614,7 @@ TEST_F(audit_layout1, read_dir)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_dir",
 				    dir_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7638,7 +7638,7 @@ TEST_F(audit_layout1, remove_dir)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_dir", dir_s1d2));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7654,7 +7654,7 @@ TEST_F(audit_layout1, remove_file)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file", dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7672,7 +7672,7 @@ TEST_F(audit_layout1, make_char)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_char",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7691,7 +7691,7 @@ TEST_F(audit_layout1, make_whiteout)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7709,7 +7709,7 @@ TEST_F(audit_layout1, make_dir)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_dir",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7727,7 +7727,7 @@ TEST_F(audit_layout1, make_reg)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_reg",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7745,7 +7745,7 @@ TEST_F(audit_layout1, make_sock)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sock",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7763,7 +7763,7 @@ TEST_F(audit_layout1, make_fifo)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_fifo",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7781,7 +7781,7 @@ TEST_F(audit_layout1, make_block)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_block", dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7799,7 +7799,7 @@ TEST_F(audit_layout1, make_sym)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.make_sym",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7821,7 +7821,7 @@ TEST_F(audit_layout1, refer_handled)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7843,7 +7843,7 @@ TEST_F(audit_layout1, refer_make)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7863,7 +7863,7 @@ TEST_F(audit_layout1, refer_rename)
 				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
 				    dir_s2d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7888,7 +7888,7 @@ TEST_F(audit_layout1, refer_exchange)
 				    "fs\\.remove_file,fs\\.make_reg,fs\\.refer",
 				    dir_s2d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
@@ -7922,7 +7922,7 @@ TEST_F(audit_layout1, refer_rename_half)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.refer",
 				    dir_s1d1));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7938,7 +7938,7 @@ TEST_F(audit_layout1, truncate)
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.truncate",
 				    file1_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7957,7 +7957,7 @@ TEST_F(audit_layout1, ioctl_dev)
 					  "fs\\.ioctl_dev", "/dev/null",
 					  " ioctlcmd=0x541b"));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -7992,7 +7992,7 @@ TEST_F(audit_layout1, resolve_unix)
 	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
 					  "fs\\.resolve_unix", path, NULL));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -8011,7 +8011,7 @@ TEST_F(audit_layout1, mount)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.change_topology", dir_s3d2));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 }
@@ -8253,7 +8253,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 						    blocker, target->target));
 
 		/* Check that we see no (other) logs. */
-		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 		ASSERT_EQ(0, records.access);
 
 		if (target->expect_open_success && fd >= 0) {
@@ -8297,7 +8297,7 @@ void audit_quiet_layout1_test_body(struct __test_metadata *const _metadata,
 						     " ioctlcmd=0x541b\\+"));
 
 			/* Check that we see no other logs. */
-			EXPECT_EQ(0, audit_count_records(self->audit_fd,
+			ASSERT_EQ(0, audit_count_records(self->audit_fd,
 							 &records));
 			ASSERT_EQ(0, records.access);
 			ASSERT_EQ(0, close(fd));
@@ -9698,7 +9698,7 @@ static void simple_quiet_rename(struct __test_metadata *const _metadata,
 	 * No other logs. records.domain not checked per reasoning in
 	 * audit_quiet_layout1_test_body.
 	 */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9817,7 +9817,7 @@ TEST_F(audit_quiet_rename, handle_all_deny_quiet_refer)
 	ASSERT_EQ(EXDEV, errno);
 
 	/* No logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9858,7 +9858,7 @@ TEST_F(audit_quiet_rename, handle_all_deny_not_quiet_refer)
 				    dir_s2d1));
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9897,7 +9897,7 @@ TEST_F(audit_quiet_rename, handle_all_deny_refer_quiet_source_not_quiet_dest)
 				    dir_s2d1));
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9924,7 +9924,7 @@ TEST_F(audit_quiet_rename, quiet_same_dir)
 	ASSERT_EQ(-1, renameat(AT_FDCWD, file1_s1d1, AT_FDCWD, file2_s1d1));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -9964,7 +9964,7 @@ TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored)
 				    dir_s2d1));
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10001,7 +10001,7 @@ TEST_F(audit_quiet_rename, quiet_flag_on_file_ignored_same_dir)
 				 "fs\\.remove_file,fs\\.make_reg", dir_s1d1));
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10059,7 +10059,7 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet1)
 	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.remove_file,fs\\.refer", dir_s1d1));
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10114,7 +10114,7 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet2)
 	 * The youngest denial will be layer 2, but refer is quieted (and that
 	 * layer does not handle any other accesses).
 	 */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10168,7 +10168,7 @@ TEST_F(audit_quiet_rename, two_layers_different_quiet3)
 	/*
 	 * The youngest denial will be layer 2, in which everything is quieted.
 	 */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10214,7 +10214,7 @@ TEST_F(audit_quiet_rename,
 	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
 	/* No other logs. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10265,7 +10265,7 @@ TEST_F(audit_quiet_rename,
 	ASSERT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
 				    "fs\\.make_reg,fs\\.refer", dir_s2d1));
 	/* No other logs. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10298,7 +10298,7 @@ TEST_F(audit_quiet_rename, rename_xchg)
 				RENAME_EXCHANGE));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10327,7 +10327,7 @@ TEST_F(audit_quiet_rename, quiet_on_parent_mount)
 			       bind_file2_s1d3));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10359,7 +10359,7 @@ TEST_F(audit_quiet_rename, quiet_behind_mountpoint_ignored)
 				    "fs\\.remove_file,fs\\.make_reg",
 				    bind_dir_s1d3));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10397,7 +10397,7 @@ TEST_F(audit_quiet_rename, quiet_on_parent_mount_disconnected)
 		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
@@ -10435,7 +10435,7 @@ TEST_F(audit_quiet_rename, quiet_behind_mountpoint_disconnected)
 		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name));
 	ASSERT_EQ(EACCES, errno);
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	ASSERT_EQ(0, records.access);
 }
 
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index c1b6e288c965..563e2214390b 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -3004,7 +3004,7 @@ TEST_F(audit, bind)
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "saddr",
 				      variant->addr, "src", self->srv0.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -3015,7 +3015,7 @@ TEST_F(audit, bind)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, bind_variant(sock_fd, &self->srv2));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -3065,7 +3065,7 @@ TEST_F(audit, connect)
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "daddr",
 				      variant->addr, "dest", self->srv0.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -3075,7 +3075,7 @@ TEST_F(audit, connect)
 
 		EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp",
 					      NULL, NULL, NULL, 0));
-		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 		EXPECT_EQ(0, records.access);
 		EXPECT_EQ(0, records.domain);
 	}
@@ -3087,7 +3087,7 @@ TEST_F(audit, connect)
 	ASSERT_LE(0, sock_fd);
 	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv2));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -3136,7 +3136,7 @@ TEST_F(audit, connect_quiet_bind)
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, audit_evt, "daddr",
 				      variant->addr, "dest", self->srv2.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	EXPECT_EQ(0, close(sock_fd));
@@ -3155,7 +3155,7 @@ TEST_F(audit, connect_quiet_bind)
 	EXPECT_EQ(-EACCES, connect_variant(sock_fd, &self->srv2));
 
 	/* Quieted - no logs expected. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	EXPECT_EQ(0, close(sock_fd));
@@ -3226,7 +3226,7 @@ TEST_F(audit, connect_bound)
 					       variant->addr, self->srv0.port,
 					       srv_remote.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -3266,7 +3266,7 @@ TEST_F(audit, sendmsg)
 				      "daddr", variant->addr, "dest",
 				      self->srv0.port));
 
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(1, records.domain);
 
@@ -3274,7 +3274,7 @@ TEST_F(audit, sendmsg)
 	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv1, "A", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp", NULL,
 				      NULL, NULL, 0));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -3282,7 +3282,7 @@ TEST_F(audit, sendmsg)
 		  sendto_variant(sock_fd, &self->unspec_srv0, "B", 1, 0));
 	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.connect_send_udp",
 				      "daddr", NULL, "dest", 0));
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index b951889cd6ca..eb36d4d1ceaf 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -343,7 +343,7 @@ TEST_F(audit, trace)
 	struct audit_records records;
 
 	/* Makes sure there is no superfluous logged records. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -381,7 +381,7 @@ TEST_F(audit, trace)
 		EXPECT_EQ(0, matches_log_ptrace(_metadata, self->audit_fd,
 						getpid()));
 
-		EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+		ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 		EXPECT_EQ(0, records.access);
 		/* Checks for a domain creation. */
 		EXPECT_EQ(1, records.domain);
@@ -428,7 +428,7 @@ TEST_F(audit, trace)
 		_metadata->exit_code = KSFT_FAIL;
 
 	/* Makes sure there is no superfluous logged records. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 }
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 55a1599819c8..67fcc3380238 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -360,7 +360,7 @@ TEST_F(scoped_audit, connect_to_child)
 		!(variant->quiet_scoped & LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
 
 	/* Makes sure there is no superfluous logged records. */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 	EXPECT_EQ(0, records.domain);
 
@@ -429,7 +429,7 @@ TEST_F(scoped_audit, connect_to_child)
 	}
 
 	/* No other logs */
-	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	ASSERT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
 
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
-- 
2.56.0

