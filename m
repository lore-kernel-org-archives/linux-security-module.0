Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A597374E6D
	for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773613383; cv=none; b=aN+Q6aogsFH7KKSfD8vdrSpyERmOi7Vh2AUurdTrX5VtN0nkLcViSXZDOFy5W9NRLBajwbxO4To0AiDJ542iEmFWQlscyrTgxbHRJ7FmP+bISwQjSVFw/ga4rGUVZrm0k2C4HsYY0iBD1hCoy5aJsTW4iHCqqFYGfV2p9xU5hI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773613383; c=relaxed/simple;
	bh=5BrGWnJ3wBnUQN8EDArxkKTuBV0kEycNia2jis63ykc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDMIr/JJvPU98crqsO1mEwa++H0b++AZy9rubI8dMeGnbUWM/fb0YPcU5eKY3OO1zznAtME89F6RKsNeibCzqaHCKdhTC4Jk/cuew4m7dLbptIERWFIZqgYK6f8aHl9VkcEnaQ/KnFG2o0hn0ZkFY67lDgHHFOmUfCaEAopx6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bucqG9Zx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bucqG9Zx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so37817165e9.2
        for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773613381; x=1774218181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwWxpa84Ce6o4BYTz2NDEq87gHz03Pnl3UkT3TO82jE=;
        b=bucqG9ZxUQKJM3W016IuONivGLJlKNWvqiRPUHuWmH6vh+BrZGgxW8F/e/1ZrwfwBW
         /er9bXns/a32sPglFjii3hqttLhw1s2jlAuCnwT+kya7fT2mObJry5DViXrRBcDZnsZS
         aNFMXEQQnmxBki6k1a7wVfr7fF4a4yNE6mtIpKg/vpZvuiZv4yXk0fGHbj95+Cav6Rpn
         2Kdxlc49bQxoc1O8J4+3q4Ovw3znGAccvyGvasmZKTl9zxK9vC92kqHz98aeh1tqp9OB
         2xCQxmY2d7PPA6b/Uij0vjDlIVec4kY7QidWpPWqVHzVf5SwrajSF/9TCJ0A+xYf1+SD
         UaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773613381; x=1774218181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwWxpa84Ce6o4BYTz2NDEq87gHz03Pnl3UkT3TO82jE=;
        b=Xg0yBj1rwQa8f/1rtndLDOsz3hrySUp+0Sn0EGZwnTbLCU8buI2UffUHbo75yranOe
         wzfjI1aoaIwXfSn/yR3HFvq0jDXIKj65mnKy1N6PdXr2CupZvrDVKzF9pgl/ksP6z7bn
         NADJ7UXf0np3CnurepOZBuUpY5JIgFiRplwISf9eIbbgIVqrd64i2pUR21PcM8Xw8W/X
         cmllRAA4ye2t1gSiDxXXE107yxANDFWmeBf/4HK07iCNB8y+++YfbGH5PHmUXFv+Tfn7
         4iU4ro+614k6a3j7ywBQ5WEFMKTPGo72dJts8KR9orn67BX3RrP04xL4Ltwak1FeZiF6
         W7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXnqXVRx3nLfuivX2t+wSvf53OyPZ1s1Jg5pwvlmmeZOt1saFUSO66XUHqG+KyeiMoS7HevBkSQKjLl6PgUed35JoRmxGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL2P7UYTtw3rGID1UJ+Fim31/tGnvu/olAvOcpB/woATAWUzd2
	8qcu5GKAlE/ur0yZKti8drAMAkkwmjs+tUI2gANSThqSHquvZ2JOBBf1
X-Gm-Gg: ATEYQzxyrAAYB/IVNU2SRer3ESsw9kGMD9F4NYVQDkIO1cU41unzEblhZQYSBmifpE0
	3ZxzWEtiA5Pgig/3ulzgkGnV1GfWORtodGdwmdzQjRLJZqXh1v8qhQbby5hilhyw74mse7X36cr
	qY3oXdX31UPMAH4qa6WkKKgY/iUq5rTC4ZA5SCwXR2smgvCx4BUWt/uDsSNkNGii4DsW9UlSPIq
	QMHsR0KsrHLAileob8VRm7wV8+jZ17r3YRC/Qwod982Sp+o/p53p1UBQ1EC9TfulepnHBvMXWfu
	eWu6TcMz2Z0WJoMw6Hok4B8wat75s7MAUnwfUI89vnBrvPT625QCbcOu9rLDALtU9T9Hdg/rcYD
	od6UT5QdrI4IXHZyeHT3baYcaiTgrFtzrH8viX/cG0/vMxKe1+ssiok9CFIH0VHEdeYRNvs7j4c
	4tYWnMmKqTs4XYyEqF8yeN9Be/ELLuVh4A958gb1TKd6FJqcR5
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr183523715e9.19.1773613380626;
        Sun, 15 Mar 2026 15:23:00 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6756e4sm438028185e9.15.2026.03.15.15.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:23:00 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>
Subject: [PATCH v6 6/9] landlock/selftests: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Date: Sun, 15 Mar 2026 23:21:47 +0100
Message-ID: <20260315222150.121952-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315222150.121952-1-gnoack3000@gmail.com>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an audit test to check that Landlock denials from
LANDLOCK_ACCESS_FS_RESOLVE_UNIX result in audit logs in the expected
format.  (There is one audit test for each filesystem access right, so
we should add one for LANDLOCK_ACCESS_FS_RESOLVE_UNIX as well.)

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 43 +++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index fdbb024da774..4198148e172f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7538,7 +7538,8 @@ static const __u64 access_fs_16 =
 	LANDLOCK_ACCESS_FS_MAKE_SYM |
 	LANDLOCK_ACCESS_FS_REFER |
 	LANDLOCK_ACCESS_FS_TRUNCATE |
-	LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	LANDLOCK_ACCESS_FS_IOCTL_DEV |
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
 /* clang-format on */
 
 TEST_F(audit_layout1, execute_read)
@@ -7983,6 +7984,46 @@ TEST_F(audit_layout1, ioctl_dev)
 	EXPECT_EQ(1, records.domain);
 }
 
+TEST_F(audit_layout1, resolve_unix)
+{
+	struct audit_records records;
+	const char *const path = "sock";
+	int srv_fd, cli_fd, status;
+	pid_t child_pid;
+
+	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, path);
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (!child_pid) {
+		drop_access_rights(_metadata,
+				   &(struct landlock_ruleset_attr){
+					   .handled_access_fs = access_fs_16,
+				   });
+
+		cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LE(0, cli_fd);
+		EXPECT_EQ(EACCES,
+			  test_connect_named_unix(_metadata, cli_fd, path));
+
+		EXPECT_EQ(0, close(cli_fd));
+		_exit(_metadata->exit_code);
+	}
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
+					  "fs\\.resolve_unix", path, NULL));
+
+	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
+	EXPECT_EQ(0, records.access);
+	EXPECT_EQ(1, records.domain);
+
+	EXPECT_EQ(0, close(srv_fd));
+}
+
 TEST_F(audit_layout1, mount)
 {
 	struct audit_records records;
-- 
2.53.0

