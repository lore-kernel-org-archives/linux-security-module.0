Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BD3C278C
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285106; cv=none; b=o/Kj+7A1EdDCvkInDA/Pe0azx+eKCnVlRTUehn/Ju8yGSOx+PS/5bJoqTvOT5qqaRkjMQeLgHbWWlFEC7xGpScoPDvcxiUCkxkB3nYZPsmS1nEXvZFKPDbd7BbYaVlvVDAv+S2+qL3bebkhlJN/BycheacYGfJNJn4gmyUGBIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285106; c=relaxed/simple;
	bh=JwlJK27ld5wY72CdZJsUNzFCBoWDPpz0xRcYOzdUy18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+szC5of83g6Fb6NvQwx2Bh6QfKodPl4IDvcF6E0U0JAS9r5ydQaPA2PJd8NIYwLarPeInybHj06/c8TBiGv0aBU18xv26VziIVg7OtKiEad9A6xK/2LIaOfP3EwE/7uUTnf9idUQXP/q+Vq0cw+b+OrpliLKVSzHScLvB96/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2cEyveh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2cEyveh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso3538635e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774285103; x=1774889903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4uXACmOVDZbOw+U/66ZI9WIPBSn+WvwZpUDFZPPhLU=;
        b=k2cEyvehmaDZfvnYqtStPYxX6VRthLrwgzeKVCmjFcvmss3ePsRvCFeu3eQAE8xDKH
         3ceCqq36wkzGmeJMGGC9sSMiDHhgnNfPt/39/WBKjKL316T74xuSa6ZUZx5DJ6Mz45DF
         BNx95JJYdZL6b3ORC98U77iOXiFa4NRn9ULjEZ5J2uaCoh8egCTPrXRw++Rb2nfPlXCC
         JAxCalRNRs7NFWYgioOdHiOKBJFht1LIbW9CjjLkvyLdkGnRZOr9VMhfrXcKvSavdBjE
         G2VR5GzFG8k7PZOelSrWx6e4RdcQa6xwldzRCJpxRXpJh3OENXmt7r8IBovtjcm4UZqh
         ZiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285103; x=1774889903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4uXACmOVDZbOw+U/66ZI9WIPBSn+WvwZpUDFZPPhLU=;
        b=PphjmGFJDKiVHhkfHll2j6qRcR61sbW0r4Fp4XlHQi/67jWmOAeKI2kidht6KcRBkt
         N1mOp/F2bwZOHLOIeR38z8lQaKJjmqPmqwiuA21DbYBJ/ucP4q3WxeMYAdzXNvI8MDUt
         RCs3YGjr4C9YYZQgCMb5sjPMnU8Ki3M6Z8oXPC6R+pHLctxvJbIsZe10Fab4TPdjdpua
         8ANVUSq+XNrR8bpnL9QMboI0L5rveN3QD5sKMVKleAXJS1Hsgi1hOCUy8WI7kqKML+pP
         qW40wRfREGuHkBBe2+FzrGDstdrUBR1z2ZZ9U6rJWvF5JSxUYOLEoIofaI8sB5N4Hzw9
         juQA==
X-Forwarded-Encrypted: i=1; AJvYcCVSftH/gcNfNEF9wTHlvYogIQHWbZBOVWfnESwz+T1wICPoq9leSORY20CZQWifvCCBsg0pn1lnKqm6O7YcgvH9GBHhHYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+koMq9AEedaZmFRV1wsn9MTc+Q3FdlDhPzPnyU/Kf8HYtM3C
	CkTQxK9YaybKlMYXbBAYPPqbEOo4ISO5WlhNb8jVTJi5gtaDJrvTe5SxVDYQVnY0
X-Gm-Gg: ATEYQzwZu/gNp86EImqWQNfQYij4E3Pn4/0qj+7OKGsHSS2EtYcrFyCk7UMFF/lHgvw
	2XIhnXzjGuCYfrKOzb/iQ0G9605VRcumjzGMPHj73SzQIA2CAb7S09yDDHyuZH63LXd4eBEyWX1
	LHmv0A/XCQcmq2v3vCzmWWlsPpyzbCSare90dqtsybLWRgIF6fLhspUXIgHdddgVOV18jGrWtWF
	rGLn+f3GJlkWLC2WVTNAAujCnXDaS8C0se8hwHW4HJ/jxy4o3NUs68RCW+tLIq3epaIQUDyLVBP
	nw6nNJKuvS+73eqKbuq3aGZT9iMK6f+L456oVP8lKkBYR8C4HWSngcIHgGzFKbj26t9XC1it1kh
	W1iBb6KJa0OdooKqv/rewylaAgZ0ePSezsaRyNJDti8hL2hEXn0mLMLCKPHUo7frR+2e4cfOzU2
	mcsSC+UF/UEviJm7u+XtuFcnpKvkAcC/Fz+5rKu7wd+ipYS3mE
X-Received: by 2002:a05:600c:a31c:b0:485:2a4b:7bc3 with SMTP id 5b1f17b1804b1-486fede723dmr149885465e9.4.1774285103136;
        Mon, 23 Mar 2026 09:58:23 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm601435975e9.9.2026.03.23.09.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:22 -0700 (PDT)
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
Subject: [PATCH v7 08/11] selftests/landlock: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
Date: Mon, 23 Mar 2026 17:56:50 +0100
Message-ID: <20260323165654.193957-9-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165654.193957-1-gnoack3000@gmail.com>
References: <20260323165654.193957-1-gnoack3000@gmail.com>
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
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f8cfd31335e1..3dad643741f7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7961,6 +7961,46 @@ TEST_F(audit_layout1, ioctl_dev)
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
+					   .handled_access_fs = ACCESS_ALL,
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

