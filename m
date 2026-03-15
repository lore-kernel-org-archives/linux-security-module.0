Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF3371872
	for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773613390; cv=none; b=BTEkABmp0HdL0ePWFhVUVThd8amvRjsBh6XuKA59fDmpSoU4JFhNYv6xxJmJmOUYBc19xdCIjgI6W53PS6ZIJJx5727bdQQZI45JqzVdtS0c58ywA+rz40ieRQ+E6KoSUIOyVo2XDIWOyuj/4CgkMu69e98jN8zovbDNUmgUdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773613390; c=relaxed/simple;
	bh=8Dm+mPnYhXDzsR7169zulMJ+gLH/i8BPAcRsRMZ5F2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qi+XzgJV+5p+nO6/YLlkiW56e6S+Qvers7XHbSXy717D5rPPKY/ntUuRcdse5XocDB3fI7D5vAVQ6NRHSEK3v0WlYjJrUdTkxhA04EUD9S33KBnmqUG8J3Kln44uPF/AVP5/hbZcRw/4A8/YI7GYtqTN6viBucTsXLFH4oDN1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POTCHpD5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POTCHpD5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so47263435e9.2
        for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773613385; x=1774218185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4ixoX/hZLWFvo2R5S27ZWBjf0IAFEAT8v0U96fjLfM=;
        b=POTCHpD5Ei2HxFUwutdoPOXQcI7CJcjGCnlJK+fjys2jvj1GXnuG3BRafKVCeZUigY
         4lALI3p550yA0WvPSQuKskoJnLM5CqqgYwzC/lj729pTXEzaPFlWax64+2YLwew3RinC
         qlFxOn+BkNntzeVb9k3ASLdYwL8zF4Cg2VL5sr/tTCn2eTn2oUYJULLseYEQ4REZcS0G
         z4O96kg2/ZkSOWOAAwwvE9nHkA0KQKKg7R7PGDV38tO6NJccW63KdQsb1NNxtySpTzE/
         GHZQTfUg5bqpDZFdp9afAlPGgJYMyG/sHUKHwsZLYuYqc8KXOndsySYIEQlTt5+fDJm7
         Hy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773613385; x=1774218185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4ixoX/hZLWFvo2R5S27ZWBjf0IAFEAT8v0U96fjLfM=;
        b=h0GLUuJ2jjOS1G2TIK/HASHGKavzJFoaPvrj9xFfU8AgQKWTkk095YuGgQYzQqewnW
         OHU4hHTJmvOLR8TxQf3p2Z2Amt0tOVjPPJEVs3KD16mRda0jFimDFSjeu4Ihp38zIm1f
         1vtX0Etm4sC8AFnJnSdDd/b1fbyjYY44iCIpSYdLgaWyz/yrO2qce01sZ92Y8alVJwiw
         HohpzFv3jCk2cADZxaxqTuHwCQb3H4pRbCxuXrkaf00qVKRQqnQHf8jxCCOsGcduBWL1
         nRzqMmI5Z/OtvnIHH90xhfvh+Vzgw8bZEwZw3UyZEgkryWm73PYVPCLRdd0XwGN1xXgC
         dZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV4cPS52YqNFdOxTW/BADoODTCmsbTYaGsKUiMxgz6qwNNGxNCOpXHzLjb4hBCR1WMn7yJJit2HS7Xw45/csFI/SBgOwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPbx5n7nFFbq6QIlRWZiaH1REy0tKfUWsBGWganr7NZ+fkHAp
	y46fDAv2BovF14kiqZwgetQmUiheYFHU8Zzm7OR7BdTqfzDoAOVW5P94gGCNDYYz
X-Gm-Gg: ATEYQzxSKp0PvF+K7KcXZzLHMlsOiuw2eAj8mSqPKbaduzFtRZmaBPDdKPda7s/ToWa
	9jqZNoYDPioNTtDaqVvT1vDM1kmvj786qPZQZxufNqvBbLIi/7yGtdupuhfZ2Prv0gUA+8Bs6yR
	D8bzo/jTlQeMYik8sYbHsr4mqRkzdLI+84XrRvK6DIYKNY04F2mWD+aFSstYJelB9R6QTXv/R4i
	/KMgzY+O+5hY4IPUOte2aZNIEb0hD78A/3TJcuHKHrwWRSbc3soDnY1FVdAKhDfkzVpCbwwOLDv
	/0DLZ/KrCBcAOYCCey0Pdg+Da4lQAQbbn6iRpGSvj1FRr44fOZSe1xH9uWckkqQZu/Y8Pe0ZkJm
	ej4WSIPx6JzcXbEDXUXTxzy3tM/1QPUl4cvbrgF4LB0fAKnHHzrLHrn/l9Q4mlyfHa6Vzi6KpAZ
	wUoJEC9zrOs3iVxGsXbobeLgc7kooOSTR1vYmhrOeLhwS3aRJL
X-Received: by 2002:a05:600c:64cf:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-485566cf893mr182183015e9.7.1773613384633;
        Sun, 15 Mar 2026 15:23:04 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm813463345e9.11.2026.03.15.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 15:23:04 -0700 (PDT)
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
Subject: [PATCH v6 8/9] landlock/selftests: fs_test: Simplify ruleset creation and enforcement
Date: Sun, 15 Mar 2026 23:21:49 +0100
Message-ID: <20260315222150.121952-9-gnoack3000@gmail.com>
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

* Add enforce_fs() for defining and enforcing a ruleset in one step
* In some places, dropped "ASSERT_LE(0, fd)" checks after
  create_ruleset() call -- create_ruleset() already checks that.
* In some places, rename "file_fd" to "fd" if it is not needed to
  disambiguate any more.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 822 ++++++---------------
 1 file changed, 211 insertions(+), 611 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index a12a4b8105d2..d61957af170f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -767,15 +767,6 @@ static int create_ruleset(struct __test_metadata *const _metadata,
 		.handled_access_fs = handled_access_fs,
 	};
 
-	ASSERT_NE(NULL, rules)
-	{
-		TH_LOG("No rule list");
-	}
-	ASSERT_NE(NULL, rules[0].path)
-	{
-		TH_LOG("Empty rule list");
-	}
-
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd)
@@ -783,16 +774,26 @@ static int create_ruleset(struct __test_metadata *const _metadata,
 		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
 	}
 
-	for (i = 0; rules[i].path; i++) {
-		if (!rules[i].access)
-			continue;
+	if (rules)
+		for (i = 0; rules[i].path; i++) {
+			if (!rules[i].access)
+				continue;
 
-		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
-				 rules[i].path);
-	}
+			add_path_beneath(_metadata, ruleset_fd, rules[i].access,
+					 rules[i].path);
+		}
 	return ruleset_fd;
 }
 
+static void enforce_fs(struct __test_metadata *const _metadata,
+		       const __u64 access_fs, const struct rule rules[])
+{
+	const int ruleset_fd = create_ruleset(_metadata, access_fs, rules);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 TEST_F_FORK(layout0, proc_nsfs)
 {
 	const struct rule rules[] = {
@@ -879,13 +880,10 @@ TEST_F_FORK(layout1, effective_access)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 	char buf;
 	int reg_fd;
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Tests on a directory (with or without O_PATH). */
 	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
@@ -932,12 +930,9 @@ TEST_F_FORK(layout1, unhandled_access)
 		},
 		{},
 	};
-	/* Here, we only handle read accesses, not write accesses. */
-	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RO, rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	/* Here, we only handle read accesses, not write accesses. */
+	enforce_fs(_metadata, ACCESS_RO, rules);
 
 	/*
 	 * Because the policy does not handle LANDLOCK_ACCESS_FS_WRITE_FILE,
@@ -966,11 +961,8 @@ TEST_F_FORK(layout1, ruleset_overlap)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks s1d1 hierarchy. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
@@ -1022,11 +1014,8 @@ TEST_F_FORK(layout1, layer_rule_unions)
 		},
 		{},
 	};
-	int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer1);
 
 	/* Checks s1d1 hierarchy with layer1. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
@@ -1048,10 +1037,7 @@ TEST_F_FORK(layout1, layer_rule_unions)
 	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Doesn't change anything from layer1. */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer2);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer2);
 
 	/* Checks s1d1 hierarchy with layer2. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
@@ -1073,10 +1059,7 @@ TEST_F_FORK(layout1, layer_rule_unions)
 	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
 
 	/* Only allows write (but not read) to dir_s1d3. */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer3);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer3);
 
 	/* Checks s1d1 hierarchy with layer3. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
@@ -1114,27 +1097,18 @@ TEST_F_FORK(layout1, non_overlapping_accesses)
 		},
 		{},
 	};
-	int ruleset_fd;
 
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file1_s1d2));
 
-	ruleset_fd =
-		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, layer1);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, layer1);
 
 	ASSERT_EQ(-1, mknod(file1_s1d1, S_IFREG | 0700, 0));
 	ASSERT_EQ(EACCES, errno);
 	ASSERT_EQ(0, mknod(file1_s1d2, S_IFREG | 0700, 0));
 	ASSERT_EQ(0, unlink(file1_s1d2));
 
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_REMOVE_FILE,
-				    layer2);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REMOVE_FILE, layer2);
 
 	/* Unchanged accesses for file creation. */
 	ASSERT_EQ(-1, mknod(file1_s1d1, S_IFREG | 0700, 0));
@@ -1238,37 +1212,24 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 		},
 		{},
 	};
-	int ruleset_fd;
 
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
-				    layer1_read);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer1_read);
 
 	/* Checks that read access is granted for file1_s1d3 with layer 1. */
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
-	ruleset_fd = create_ruleset(_metadata,
-				    LANDLOCK_ACCESS_FS_READ_FILE |
-					    LANDLOCK_ACCESS_FS_WRITE_FILE,
-				    layer2_read_write);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
+		   layer2_read_write);
 
 	/* Checks that previous access rights are unchanged with layer 2. */
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
-				    layer3_read);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer3_read);
 
 	/* Checks that previous access rights are unchanged with layer 3. */
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
@@ -1276,13 +1237,9 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
 
 	/* This time, denies write access for the file hierarchy. */
-	ruleset_fd = create_ruleset(_metadata,
-				    LANDLOCK_ACCESS_FS_READ_FILE |
-					    LANDLOCK_ACCESS_FS_WRITE_FILE,
-				    layer4_read_write);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
+		   layer4_read_write);
 
 	/*
 	 * Checks that the only change with layer 4 is that write access is
@@ -1293,11 +1250,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
 
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
-				    layer5_read);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer5_read);
 
 	/* Checks that previous access rights are unchanged with layer 5. */
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
@@ -1305,11 +1258,7 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_EXECUTE,
-				    layer6_execute);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_EXECUTE, layer6_execute);
 
 	/* Checks that previous access rights are unchanged with layer 6. */
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
@@ -1317,13 +1266,9 @@ TEST_F_FORK(layout1, interleaved_masked_accesses)
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
 	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
 
-	ruleset_fd = create_ruleset(_metadata,
-				    LANDLOCK_ACCESS_FS_READ_FILE |
-					    LANDLOCK_ACCESS_FS_WRITE_FILE,
-				    layer7_read_write);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
+		   layer7_read_write);
 
 	/* Checks read access is now denied with layer 7. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
@@ -1344,7 +1289,6 @@ TEST_F_FORK(layout1, inherit_subset)
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
@@ -1460,7 +1404,6 @@ TEST_F_FORK(layout1, inherit_superset)
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
 
 	/* Readdir access is denied for dir_s1d2. */
@@ -1476,7 +1419,7 @@ TEST_F_FORK(layout1, inherit_superset)
 				 LANDLOCK_ACCESS_FS_READ_DIR,
 			 dir_s1d2);
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Readdir access is still denied for dir_s1d2. */
 	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
@@ -1498,7 +1441,6 @@ TEST_F_FORK(layout0, max_layers)
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
 	for (i = 0; i < 16; i++)
 		enforce_ruleset(_metadata, ruleset_fd);
 
@@ -1507,7 +1449,7 @@ TEST_F_FORK(layout0, max_layers)
 		ASSERT_EQ(-1, err);
 		ASSERT_EQ(E2BIG, errno);
 	}
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, empty_or_same_ruleset)
@@ -1521,20 +1463,15 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 	ASSERT_LE(-1, ruleset_fd);
 	ASSERT_EQ(ENOMSG, errno);
 
-	/* Enforces policy which deny read access to all files. */
-	ruleset_attr.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE;
-	ruleset_fd =
-		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
+	/* Enforces policy which denies read access to all files. */
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, NULL);
+
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
-	/* Nests a policy which deny read access to all directories. */
-	ruleset_attr.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR;
+	/* Nests a policy which denies read access to all directories. */
 	ruleset_fd =
-		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-	ASSERT_LE(0, ruleset_fd);
+		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, NULL);
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
 	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
@@ -1558,11 +1495,8 @@ TEST_F_FORK(layout1, rule_on_mountpoint)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
@@ -1587,11 +1521,8 @@ TEST_F_FORK(layout1, rule_over_mountpoint)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
@@ -1615,21 +1546,15 @@ TEST_F_FORK(layout1, rule_over_root_allow_then_deny)
 		},
 		{},
 	};
-	int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks allowed access. */
 	ASSERT_EQ(0, test_open("/", O_RDONLY));
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 
 	rules[0].access = LANDLOCK_ACCESS_FS_READ_FILE;
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks denied access (on a directory). */
 	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
@@ -1645,11 +1570,8 @@ TEST_F_FORK(layout1, rule_over_root_deny)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	/* Checks denied access (on a directory). */
 	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
@@ -1665,7 +1587,6 @@ TEST_F_FORK(layout1, rule_inside_mount_ns)
 		},
 		{},
 	};
-	int ruleset_fd;
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3))
@@ -1675,10 +1596,7 @@ TEST_F_FORK(layout1, rule_inside_mount_ns)
 	ASSERT_EQ(0, chdir("/"));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	ASSERT_EQ(0, test_open("s3d3", O_RDONLY));
 	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
@@ -1693,11 +1611,8 @@ TEST_F_FORK(layout1, mount_and_pivot)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
@@ -1716,9 +1631,6 @@ TEST_F_FORK(layout1, move_mount)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
-
-	ASSERT_LE(0, ruleset_fd);
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
@@ -1731,8 +1643,7 @@ TEST_F_FORK(layout1, move_mount)
 			     dir_s3d2, 0));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, rules);
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
@@ -1747,14 +1658,9 @@ TEST_F_FORK(layout1, topology_changes_with_net_only)
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
 	};
-	int ruleset_fd;
 
 	/* Add network restrictions. */
-	ruleset_fd =
-		landlock_create_ruleset(&ruleset_net, sizeof(ruleset_net), 0);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	drop_access_rights(_metadata, &ruleset_net);
 
 	/* Mount, remount, move_mount, umount, and pivot_root checks. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
@@ -1775,14 +1681,9 @@ TEST_F_FORK(layout1, topology_changes_with_net_and_fs)
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
 		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
-	int ruleset_fd;
 
 	/* Add network and filesystem restrictions. */
-	ruleset_fd = landlock_create_ruleset(&ruleset_net_fs,
-					     sizeof(ruleset_net_fs), 0);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	drop_access_rights(_metadata, &ruleset_net_fs);
 
 	/* Mount, remount, move_mount, umount, and pivot_root checks. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
@@ -1819,14 +1720,13 @@ TEST_F_FORK(layout1, release_inodes)
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	ASSERT_LE(0, ruleset_fd);
 	/* Unmount a file hierarchy while it is being used by a ruleset. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, umount(dir_s3d2));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	EXPECT_EQ(0, close(ruleset_fd));
 
 	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
 	ASSERT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
@@ -1858,7 +1758,6 @@ TEST_F_FORK(layout1, covered_rule)
 	/* Creates a ruleset with the future hidden directory. */
 	ruleset_fd =
 		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, layer1);
-	ASSERT_LE(0, ruleset_fd);
 
 	/* Covers with a new mount point. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
@@ -1908,10 +1807,7 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 	};
 	int dirfd, ruleset_fd;
 
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_base);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer1_base);
 
 	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer2_subs);
 
@@ -2092,10 +1988,7 @@ TEST_F_FORK(layout1, execute)
 		},
 		{},
 	};
-	const int ruleset_fd =
-		create_ruleset(_metadata, rules[0].access, rules);
 
-	ASSERT_LE(0, ruleset_fd);
 	copy_file(_metadata, bin_true, file1_s1d1);
 	copy_file(_metadata, bin_true, file1_s1d2);
 	copy_file(_metadata, bin_true, file1_s1d3);
@@ -2104,8 +1997,7 @@ TEST_F_FORK(layout1, execute)
 	test_execute(_metadata, 0, file1_s1d1);
 	test_check_exec(_metadata, 0, file1_s1d1);
 
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, rules[0].access, rules);
 
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
@@ -2216,16 +2108,12 @@ TEST_F_FORK(layout1, link)
 		},
 		{},
 	};
-	int ruleset_fd = create_ruleset(_metadata, layer1[0].access, layer1);
-
-	ASSERT_LE(0, ruleset_fd);
 
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file1_s1d2));
 	ASSERT_EQ(0, unlink(file1_s1d3));
 
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, layer1[0].access, layer1);
 
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
 	ASSERT_EQ(EACCES, errno);
@@ -2245,10 +2133,7 @@ TEST_F_FORK(layout1, link)
 	ASSERT_EQ(0, unlink(file2_s1d2));
 	ASSERT_EQ(0, unlink(file2_s1d3));
 
-	ruleset_fd = create_ruleset(_metadata, layer2[0].access, layer2);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, layer2[0].access, layer2);
 
 	/* Checks that linkind doesn't require the ability to delete a file. */
 	ASSERT_EQ(0, link(file1_s1d2, file2_s1d2));
@@ -2298,15 +2183,10 @@ TEST_F_FORK(layout1, rename_file)
 		},
 		{},
 	};
-	const int ruleset_fd =
-		create_ruleset(_metadata, rules[0].access, rules);
-
-	ASSERT_LE(0, ruleset_fd);
 
 	ASSERT_EQ(0, unlink(file1_s1d2));
 
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, rules[0].access, rules);
 
 	/*
 	 * Tries to replace a file, from a directory that allows file removal,
@@ -2380,17 +2260,12 @@ TEST_F_FORK(layout1, rename_dir)
 		},
 		{},
 	};
-	const int ruleset_fd =
-		create_ruleset(_metadata, rules[0].access, rules);
-
-	ASSERT_LE(0, ruleset_fd);
 
 	/* Empties dir_s1d3 to allow renaming. */
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	ASSERT_EQ(0, unlink(file2_s1d3));
 
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, rules[0].access, rules);
 
 	/* Exchanges and renames directory to a different parent. */
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_s1d3,
@@ -2444,12 +2319,8 @@ TEST_F_FORK(layout1, reparent_refer)
 		},
 		{},
 	};
-	int ruleset_fd =
-		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
 
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d1));
 	ASSERT_EQ(EXDEV, errno);
@@ -2479,14 +2350,9 @@ static void refer_denied_by_default(struct __test_metadata *const _metadata,
 				    const int layer1_err,
 				    const struct rule layer2[])
 {
-	int ruleset_fd;
-
 	ASSERT_EQ(0, unlink(file1_s1d2));
 
-	ruleset_fd = create_ruleset(_metadata, layer1[0].access, layer1);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, layer1[0].access, layer1);
 
 	/*
 	 * If the first layer handles LANDLOCK_ACCESS_FS_REFER (according to
@@ -2498,10 +2364,7 @@ static void refer_denied_by_default(struct __test_metadata *const _metadata,
 	ASSERT_EQ(layer1_err, test_exchange(file2_s1d1, file2_s1d2));
 	ASSERT_EQ(layer1_err, test_exchange(file2_s1d2, file2_s1d1));
 
-	ruleset_fd = create_ruleset(_metadata, layer2[0].access, layer2);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, layer2[0].access, layer2);
 
 	/*
 	 * Now, either the first or the second layer does not handle
@@ -2587,10 +2450,7 @@ TEST_F_FORK(layout1, refer_denied_by_default4)
  */
 TEST_F_FORK(layout1, refer_mount_root_deny)
 {
-	const struct landlock_ruleset_attr ruleset_attr = {
-		.handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_DIR,
-	};
-	int root_fd, ruleset_fd;
+	int root_fd;
 
 	/* Creates a mount object from a non-mount point. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
@@ -2600,13 +2460,7 @@ TEST_F_FORK(layout1, refer_mount_root_deny)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_LE(0, root_fd);
 
-	ruleset_fd =
-		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
-	ASSERT_LE(0, ruleset_fd);
-
-	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
-	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
-	EXPECT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_DIR, NULL);
 
 	/* Link denied by Landlock: EACCES. */
 	EXPECT_EQ(-1, linkat(root_fd, ".", root_fd, "does_not_exist", 0));
@@ -2641,18 +2495,12 @@ TEST_F_FORK(layout1, refer_part_mount_tree_is_allowed)
 		},
 		{},
 	};
-	int ruleset_fd;
 
 	ASSERT_EQ(0, unlink(file1_s3d3));
-	ruleset_fd = create_ruleset(_metadata,
-				    LANDLOCK_ACCESS_FS_REFER |
-					    LANDLOCK_ACCESS_FS_MAKE_REG |
-					    LANDLOCK_ACCESS_FS_REMOVE_FILE,
-				    layer1);
-
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG |
+			   LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		   layer1);
 
 	ASSERT_EQ(0, rename(file1_s3d4, file1_s3d3));
 }
@@ -2678,13 +2526,10 @@ TEST_F_FORK(layout1, reparent_link)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(
-		_metadata,
-		LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER, layer1);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
+		   layer1);
 
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file1_s1d2));
@@ -2756,13 +2601,10 @@ TEST_F_FORK(layout1, reparent_rename)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(
-		_metadata,
-		LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER, layer1);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
+		   layer1);
 
 	ASSERT_EQ(0, unlink(file1_s1d2));
 	ASSERT_EQ(0, unlink(file1_s1d3));
@@ -2902,13 +2744,9 @@ reparent_exdev_layers_enforce1(struct __test_metadata *const _metadata)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(
-		_metadata,
-		LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER, layer1);
-
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
+		   layer1);
 }
 
 static void
@@ -2925,12 +2763,7 @@ reparent_exdev_layers_enforce2(struct __test_metadata *const _metadata)
 	 * Same checks as before but with a second layer and a new MAKE_DIR
 	 * rule (and no explicit handling of REFER).
 	 */
-	const int ruleset_fd =
-		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_MAKE_DIR, layer2);
-
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_DIR, layer2);
 }
 
 TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
@@ -3199,15 +3032,11 @@ TEST_F_FORK(layout1, reparent_remove)
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(
-		_metadata,
-		LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_REMOVE_DIR |
-			LANDLOCK_ACCESS_FS_REMOVE_FILE,
-		layer1);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_REMOVE_DIR |
+			   LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		   layer1);
 
 	/* Access denied because of wrong/swapped remove file/dir. */
 	ASSERT_EQ(-1, rename(file1_s1d1, dir_s2d2));
@@ -3271,17 +3100,13 @@ TEST_F_FORK(layout1, reparent_dom_superset)
 		},
 		{},
 	};
-	int ruleset_fd = create_ruleset(_metadata,
-					LANDLOCK_ACCESS_FS_REFER |
-						LANDLOCK_ACCESS_FS_EXECUTE |
-						LANDLOCK_ACCESS_FS_MAKE_SOCK |
-						LANDLOCK_ACCESS_FS_READ_FILE |
-						LANDLOCK_ACCESS_FS_MAKE_FIFO,
-					layer1);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_EXECUTE |
+			   LANDLOCK_ACCESS_FS_MAKE_SOCK |
+			   LANDLOCK_ACCESS_FS_READ_FILE |
+			   LANDLOCK_ACCESS_FS_MAKE_FIFO,
+		   layer1);
 
 	ASSERT_EQ(-1, rename(file1_s1d2, file1_s2d1));
 	ASSERT_EQ(EXDEV, errno);
@@ -3344,18 +3169,13 @@ TEST_F_FORK(layout1, remove_dir)
 		},
 		{},
 	};
-	const int ruleset_fd =
-		create_ruleset(_metadata, rules[0].access, rules);
-
-	ASSERT_LE(0, ruleset_fd);
 
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file1_s1d2));
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	ASSERT_EQ(0, unlink(file2_s1d3));
 
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, rules[0].access, rules);
 
 	ASSERT_EQ(0, rmdir(dir_s1d3));
 	ASSERT_EQ(0, mkdir(dir_s1d3, 0700));
@@ -3381,12 +3201,8 @@ TEST_F_FORK(layout1, remove_file)
 		},
 		{},
 	};
-	const int ruleset_fd =
-		create_ruleset(_metadata, rules[0].access, rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, rules[0].access, rules);
 
 	ASSERT_EQ(-1, unlink(file1_s1d1));
 	ASSERT_EQ(EACCES, errno);
@@ -3407,9 +3223,6 @@ static void test_make_file(struct __test_metadata *const _metadata,
 		},
 		{},
 	};
-	const int ruleset_fd = create_ruleset(_metadata, access, rules);
-
-	ASSERT_LE(0, ruleset_fd);
 
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file2_s1d1));
@@ -3425,8 +3238,7 @@ static void test_make_file(struct __test_metadata *const _metadata,
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	ASSERT_EQ(0, unlink(file2_s1d3));
 
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, access, rules);
 
 	ASSERT_EQ(-1, mknod(file1_s1d1, mode | 0400, dev));
 	ASSERT_EQ(EACCES, errno);
@@ -3495,10 +3307,6 @@ TEST_F_FORK(layout1, make_sym)
 		},
 		{},
 	};
-	const int ruleset_fd =
-		create_ruleset(_metadata, rules[0].access, rules);
-
-	ASSERT_LE(0, ruleset_fd);
 
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file2_s1d1));
@@ -3510,8 +3318,7 @@ TEST_F_FORK(layout1, make_sym)
 	ASSERT_EQ(0, unlink(file1_s1d3));
 	ASSERT_EQ(0, unlink(file2_s1d3));
 
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, rules[0].access, rules);
 
 	ASSERT_EQ(-1, symlink("none", file1_s1d1));
 	ASSERT_EQ(EACCES, errno);
@@ -3540,17 +3347,12 @@ TEST_F_FORK(layout1, make_dir)
 		},
 		{},
 	};
-	const int ruleset_fd =
-		create_ruleset(_metadata, rules[0].access, rules);
-
-	ASSERT_LE(0, ruleset_fd);
 
 	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file1_s1d2));
 	ASSERT_EQ(0, unlink(file1_s1d3));
 
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, rules[0].access, rules);
 
 	/* Uses file_* as directory names. */
 	ASSERT_EQ(-1, mkdir(file1_s1d1, 0700));
@@ -3581,14 +3383,10 @@ TEST_F_FORK(layout1, proc_unlinked_file)
 		{},
 	};
 	int reg_fd, proc_fd;
-	const int ruleset_fd = create_ruleset(
-		_metadata,
-		LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
-		rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
+		   rules);
 
 	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
 	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
@@ -3624,13 +3422,9 @@ TEST_F_FORK(layout1, proc_pipe)
 		},
 		{},
 	};
-	/* Limits read and write access to files tied to the filesystem. */
-	const int ruleset_fd =
-		create_ruleset(_metadata, rules[0].access, rules);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	/* Limits read and write access to files tied to the filesystem. */
+	enforce_fs(_metadata, rules[0].access, rules);
 
 	/* Checks enforcement for normal files. */
 	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
@@ -3720,16 +3514,10 @@ TEST_F_FORK(layout1, truncate_unhandled)
 		{},
 	};
 
-	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
-			      LANDLOCK_ACCESS_FS_WRITE_FILE;
-	int ruleset_fd;
-
 	/* Enables Landlock. */
-	ruleset_fd = create_ruleset(_metadata, handled, rules);
-
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE,
+		   rules);
 
 	/*
 	 * Checks read right: truncate and open with O_TRUNC work, unless the
@@ -3802,17 +3590,13 @@ TEST_F_FORK(layout1, truncate)
 		},
 		{},
 	};
-	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
-			      LANDLOCK_ACCESS_FS_WRITE_FILE |
-			      LANDLOCK_ACCESS_FS_TRUNCATE;
-	int ruleset_fd;
 
 	/* Enables Landlock. */
-	ruleset_fd = create_ruleset(_metadata, handled, rules);
-
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_READ_FILE |
+			   LANDLOCK_ACCESS_FS_WRITE_FILE |
+			   LANDLOCK_ACCESS_FS_TRUNCATE,
+		   rules);
 
 	/* Checks read, write and truncate rights: truncation works. */
 	EXPECT_EQ(0, test_truncate(file_rwt));
@@ -3912,34 +3696,25 @@ TEST_F_FORK(layout1, ftruncate)
 		},
 		{},
 	};
-	int fd_layer0, fd_layer1, fd_layer2, fd_layer3, ruleset_fd;
+	int fd_layer0, fd_layer1, fd_layer2, fd_layer3;
 
 	fd_layer0 = open(path, O_WRONLY);
 	EXPECT_EQ(0, test_ftruncate(fd_layer0));
 
-	ruleset_fd = create_ruleset(_metadata, handled1, layer1);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, handled1, layer1);
 
 	fd_layer1 = open(path, O_WRONLY);
 	EXPECT_EQ(0, test_ftruncate(fd_layer0));
 	EXPECT_EQ(0, test_ftruncate(fd_layer1));
 
-	ruleset_fd = create_ruleset(_metadata, handled2, layer2);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, handled2, layer2);
 
 	fd_layer2 = open(path, O_WRONLY);
 	EXPECT_EQ(0, test_ftruncate(fd_layer0));
 	EXPECT_EQ(0, test_ftruncate(fd_layer1));
 	EXPECT_EQ(0, test_ftruncate(fd_layer2));
 
-	ruleset_fd = create_ruleset(_metadata, handled3, layer3);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, handled3, layer3);
 
 	fd_layer3 = open(path, O_WRONLY);
 	EXPECT_EQ(0, test_ftruncate(fd_layer0));
@@ -4031,13 +3806,10 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 		},
 		{},
 	};
-	int fd, ruleset_fd;
+	int fd;
 
 	/* Enables Landlock. */
-	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, variant->handled, rules);
 
 	fd = open(path, O_WRONLY);
 	EXPECT_EQ(variant->expected_open_result, (fd < 0 ? errno : 0));
@@ -4072,12 +3844,9 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 			},
 			{},
 		};
-		int fd, ruleset_fd;
+		int fd;
 
-		ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
-		ASSERT_LE(0, ruleset_fd);
-		enforce_ruleset(_metadata, ruleset_fd);
-		ASSERT_EQ(0, close(ruleset_fd));
+		enforce_fs(_metadata, variant->handled, rules);
 
 		fd = open(path, O_WRONLY);
 		ASSERT_EQ(variant->expected_open_result, (fd < 0 ? errno : 0));
@@ -4122,10 +3891,7 @@ static int test_fs_ioc_getflags_ioctl(int fd)
 
 TEST(memfd_ftruncate_and_ioctl)
 {
-	const struct landlock_ruleset_attr attr = {
-		.handled_access_fs = ACCESS_ALL,
-	};
-	int ruleset_fd, fd, i;
+	int fd, i;
 
 	/*
 	 * We exercise the same test both with and without Landlock enabled, to
@@ -4147,10 +3913,7 @@ TEST(memfd_ftruncate_and_ioctl)
 		ASSERT_EQ(0, close(fd));
 
 		/* Enables Landlock. */
-		ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
-		ASSERT_LE(0, ruleset_fd);
-		enforce_ruleset(_metadata, ruleset_fd);
-		ASSERT_EQ(0, close(ruleset_fd));
+		enforce_fs(_metadata, ACCESS_ALL, NULL);
 	}
 }
 
@@ -4165,10 +3928,7 @@ static int test_fionread_ioctl(int fd)
 
 TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 {
-	const struct landlock_ruleset_attr attr = {
-		.handled_access_fs = ACCESS_ALL,
-	};
-	int ruleset_fd, fd;
+	int fd;
 
 	/*
 	 * Checks that for files opened with O_PATH, both ioctl(2) and
@@ -4184,10 +3944,7 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 
 	/* Enables Landlock. */
-	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_ALL, NULL);
 
 	/*
 	 * Checks that after enabling Landlock,
@@ -4261,16 +4018,10 @@ struct space_resv {
  */
 TEST_F_FORK(layout1, blanket_permitted_ioctls)
 {
-	const struct landlock_ruleset_attr attr = {
-		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
-	};
-	int ruleset_fd, fd;
+	int fd;
 
 	/* Enables Landlock. */
-	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_IOCTL_DEV, NULL);
 
 	fd = open("/dev/null", O_RDWR | O_CLOEXEC);
 	ASSERT_LE(0, fd);
@@ -4323,20 +4074,14 @@ TEST_F_FORK(layout1, blanket_permitted_ioctls)
 TEST_F_FORK(layout1, named_pipe_ioctl)
 {
 	pid_t child_pid;
-	int fd, ruleset_fd;
+	int fd;
 	const char *const path = file1_s1d1;
-	const struct landlock_ruleset_attr attr = {
-		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
-	};
 
 	ASSERT_EQ(0, unlink(path));
 	ASSERT_EQ(0, mkfifo(path, 0600));
 
 	/* Enables Landlock. */
-	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_IOCTL_DEV, NULL);
 
 	/* The child process opens the pipe for writing. */
 	child_pid = fork();
@@ -4411,20 +4156,14 @@ static int test_connect_named_unix(struct __test_metadata *const _metadata,
 TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
 {
 	const char *const path = file1_s1d1;
-	int srv_fd, cli_fd, ruleset_fd;
-	const struct landlock_ruleset_attr attr = {
-		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
-	};
+	int srv_fd, cli_fd;
 
 	/* Sets up a server */
 	ASSERT_EQ(0, unlink(path));
 	srv_fd = set_up_named_unix_server(_metadata, SOCK_STREAM, path);
 
 	/* Enables Landlock. */
-	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_IOCTL_DEV, NULL);
 
 	/* Sets up a client connection to it */
 	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
@@ -4497,29 +4236,25 @@ TEST_F_FORK(ioctl, handle_dir_access_file)
 		},
 		{},
 	};
-	int file_fd, ruleset_fd;
+	int fd;
 
 	/* Enables Landlock. */
-	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, variant->handled, rules);
 
-	file_fd = open("/dev/zero", variant->open_mode);
-	ASSERT_LE(0, file_fd);
+	fd = open("/dev/zero", variant->open_mode);
+	ASSERT_LE(0, fd);
 
 	/* Checks that IOCTL commands return the expected errors. */
-	EXPECT_EQ(variant->expected_fionread_result,
-		  test_fionread_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
 
 	/* Checks that unrestrictable commands are unrestricted. */
-	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
-	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
-	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
-	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
-	EXPECT_EQ(0, ioctl(file_fd, FIGETBSZ, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIGETBSZ, &flag));
 
-	ASSERT_EQ(0, close(file_fd));
+	ASSERT_EQ(0, close(fd));
 }
 
 TEST_F_FORK(ioctl, handle_dir_access_dir)
@@ -4532,13 +4267,10 @@ TEST_F_FORK(ioctl, handle_dir_access_dir)
 		},
 		{},
 	};
-	int dir_fd, ruleset_fd;
+	int dir_fd;
 
 	/* Enables Landlock. */
-	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, variant->handled, rules);
 
 	/*
 	 * Ignore variant->open_mode for this test, as we intend to open a
@@ -4577,32 +4309,28 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 		},
 		{},
 	};
-	int file_fd, ruleset_fd;
+	int fd;
 
 	/* Enables Landlock. */
-	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, variant->handled, rules);
 
-	file_fd = open("/dev/zero", variant->open_mode);
-	ASSERT_LE(0, file_fd)
+	fd = open("/dev/zero", variant->open_mode);
+	ASSERT_LE(0, fd)
 	{
 		TH_LOG("Failed to open /dev/zero: %s", strerror(errno));
 	}
 
 	/* Checks that IOCTL commands return the expected errors. */
-	EXPECT_EQ(variant->expected_fionread_result,
-		  test_fionread_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
 
 	/* Checks that unrestrictable commands are unrestricted. */
-	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
-	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
-	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
-	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
-	EXPECT_EQ(0, ioctl(file_fd, FIGETBSZ, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIGETBSZ, &flag));
 
-	ASSERT_EQ(0, close(file_fd));
+	ASSERT_EQ(0, close(fd));
 }
 
 /*
@@ -4644,24 +4372,6 @@ FIXTURE_TEARDOWN(scoped_domains)
 {
 }
 
-static void enforce_fs_resolve_unix(struct __test_metadata *const _metadata,
-				    const struct rule rules[])
-{
-	if (rules) {
-		int fd = create_ruleset(_metadata,
-					LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
-		enforce_ruleset(_metadata, fd);
-		EXPECT_EQ(0, close(fd));
-	} else {
-		drop_access_rights(
-			_metadata,
-			&(struct landlock_ruleset_attr){
-				.handled_access_fs =
-					LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
-			});
-	}
-}
-
 /*
  * Flags for test_connect_to_parent and test_connect_to_child:
  *
@@ -4692,9 +4402,9 @@ static void test_connect_to_parent(struct __test_metadata *const _metadata,
 	char buf[1];
 
 	if (variant->domain_both)
-		enforce_fs_resolve_unix(_metadata, NULL);
+		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
 	else if (flags & ENFORCE_ALL)
-		enforce_fs_resolve_unix(_metadata, rules);
+		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
 
 	unlink(path);
 	ASSERT_EQ(0, pipe2(readiness_pipe, O_CLOEXEC));
@@ -4704,9 +4414,11 @@ static void test_connect_to_parent(struct __test_metadata *const _metadata,
 
 	if (child_pid == 0) {
 		if (variant->domain_child)
-			enforce_fs_resolve_unix(_metadata, NULL);
+			enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+				   NULL);
 		else if (flags & ENFORCE_ALL)
-			enforce_fs_resolve_unix(_metadata, rules);
+			enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+				   rules);
 
 		/* Wait for server to be available. */
 		EXPECT_EQ(0, close(readiness_pipe[1]));
@@ -4732,9 +4444,9 @@ static void test_connect_to_parent(struct __test_metadata *const _metadata,
 	}
 
 	if (variant->domain_parent)
-		enforce_fs_resolve_unix(_metadata, NULL);
+		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
 	else if (flags & ENFORCE_ALL)
-		enforce_fs_resolve_unix(_metadata, rules);
+		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
 
 	srv_fd = set_up_named_unix_server(_metadata, sock_type, path);
 
@@ -4773,9 +4485,9 @@ static void test_connect_to_child(struct __test_metadata *const _metadata,
 	char buf[1];
 
 	if (variant->domain_both)
-		enforce_fs_resolve_unix(_metadata, NULL);
+		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
 	else if (flags & ENFORCE_ALL)
-		enforce_fs_resolve_unix(_metadata, rules);
+		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
 
 	unlink(path);
 	ASSERT_EQ(0, pipe2(readiness_pipe, O_CLOEXEC));
@@ -4786,9 +4498,11 @@ static void test_connect_to_child(struct __test_metadata *const _metadata,
 
 	if (child_pid == 0) {
 		if (variant->domain_child)
-			enforce_fs_resolve_unix(_metadata, NULL);
+			enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+				   NULL);
 		else if (flags & ENFORCE_ALL)
-			enforce_fs_resolve_unix(_metadata, rules);
+			enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
+				   rules);
 
 		srv_fd = set_up_named_unix_server(_metadata, sock_type, path);
 
@@ -4812,9 +4526,9 @@ static void test_connect_to_child(struct __test_metadata *const _metadata,
 	}
 
 	if (variant->domain_parent)
-		enforce_fs_resolve_unix(_metadata, NULL);
+		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
 	else if (flags & ENFORCE_ALL)
-		enforce_fs_resolve_unix(_metadata, rules);
+		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
 
 	/* Wait for server to be available. */
 	EXPECT_EQ(0, close(readiness_pipe[1]));
@@ -5023,9 +4737,7 @@ TEST_F_FORK(coredump, socket_not_restricted)
 	set_core_pattern(_metadata, core_pattern);
 
 	/* Restrict LANDLOCK_ACCESS_FS_RESOLVE_UNIX. */
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-		.handled_access_fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
-	});
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
 
 	/* Fork a child that crashes. */
 	child_pid = fork();
@@ -5212,13 +4924,9 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 		},
 		{},
 	};
-	int ruleset_fd;
 
 	/* Sets rules for the parent directories. */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_parent);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer1_parent);
 
 	/* Checks source hierarchy. */
 	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
@@ -5237,10 +4945,7 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
 
 	/* Sets rules for the mount points. */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer2_mount_point);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer2_mount_point);
 
 	/* Checks source hierarchy. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
@@ -5261,10 +4966,7 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 	ASSERT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/* Sets a (shared) rule only on the source. */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer3_source);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer3_source);
 
 	/* Checks source hierarchy. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
@@ -5285,10 +4987,7 @@ TEST_F_FORK(layout1_bind, same_content_same_file)
 	ASSERT_EQ(EACCES, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
 
 	/* Sets a (shared) rule only on the destination. */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer4_destination);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer4_destination);
 
 	/* Checks source hierarchy. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
@@ -5313,13 +5012,10 @@ TEST_F_FORK(layout1_bind, reparent_cross_mount)
 		},
 		{},
 	};
-	int ruleset_fd = create_ruleset(
-		_metadata,
-		LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_EXECUTE, layer1);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_EXECUTE,
+		   layer1);
 
 	/* Checks basic denied move. */
 	ASSERT_EQ(-1, rename(file1_s1d1, file1_s1d2));
@@ -5376,10 +5072,6 @@ TEST_F_FORK(layout1_bind, path_disconnected)
 		create_ruleset(_metadata, ACCESS_RW, layer3_only_s1d2);
 	int bind_s1d3_fd;
 
-	ASSERT_LE(0, ruleset_fd_l1);
-	ASSERT_LE(0, ruleset_fd_l2);
-	ASSERT_LE(0, ruleset_fd_l3);
-
 	enforce_ruleset(_metadata, ruleset_fd_l1);
 	EXPECT_EQ(0, close(ruleset_fd_l1));
 
@@ -5483,8 +5175,6 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	ruleset_fd_l1 = create_ruleset(_metadata, ACCESS_ALL, layer1);
 	ruleset_fd_l2 = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
 				       layer2_only_s1d2);
-	ASSERT_LE(0, ruleset_fd_l1);
-	ASSERT_LE(0, ruleset_fd_l2);
 
 	enforce_ruleset(_metadata, ruleset_fd_l1);
 	EXPECT_EQ(0, close(ruleset_fd_l1));
@@ -5630,7 +5320,7 @@ TEST_F_FORK(layout1_bind, path_disconnected_link)
 		},
 		{}
 	};
-	int ruleset_fd, bind_s1d3_fd;
+	int bind_s1d3_fd;
 
 	/* Removes unneeded files created by layout1, otherwise it will EEXIST. */
 	ASSERT_EQ(0, unlink(file1_s1d2));
@@ -5653,10 +5343,7 @@ TEST_F_FORK(layout1_bind, path_disconnected_link)
 		TH_LOG("Failed to create %s: %s", dir_s4d2, strerror(errno));
 	}
 
-	ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, layer1);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	EXPECT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_ALL, layer1);
 
 	/* From disconnected to connected. */
 	ASSERT_EQ(0, linkat(bind_s1d3_fd, file1_name, AT_FDCWD, file1_s2d2, 0))
@@ -6194,7 +5881,6 @@ TEST_F_FORK(layout4_disconnected_leafs, read_rename_exchange)
 	int ruleset_fd, s1d41_bind_fd, s1d42_bind_fd;
 
 	ruleset_fd = create_ruleset(_metadata, handled_access, rules);
-	ASSERT_LE(0, ruleset_fd);
 
 	/* Adds rule for the covered directory. */
 	if (variant->allowed_s2d2) {
@@ -7127,7 +6813,6 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 		},
 		{},
 	};
-	int ruleset_fd;
 	size_t i;
 	const char *path_entry;
 
@@ -7135,10 +6820,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 		SKIP(return, "overlayfs is not supported (test)");
 
 	/* Sets rules on base directories (i.e. outside overlay scope). */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_base);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer1_base);
 
 	/* Checks lower layer. */
 	for_each_path(lower_base_files, path_entry, i) {
@@ -7183,10 +6865,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 	}
 
 	/* Sets rules on data directories (i.e. inside overlay scope). */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer2_data);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer2_data);
 
 	/* Checks merge. */
 	for_each_path(merge_base_files, path_entry, i) {
@@ -7200,10 +6879,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 	}
 
 	/* Same checks with tighter rules. */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer3_subdirs);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer3_subdirs);
 
 	/* Checks changes for lower layer. */
 	for_each_path(lower_base_files, path_entry, i) {
@@ -7225,10 +6901,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 	}
 
 	/* Sets rules directly on overlayed files. */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer4_files);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer4_files);
 
 	/* Checks unchanged accesses on lower layer. */
 	for_each_path(lower_sub_files, path_entry, i) {
@@ -7253,10 +6926,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 	}
 
 	/* Only allowes access to the merge hierarchy. */
-	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer5_merge_only);
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, ACCESS_RW, layer5_merge_only);
 
 	/* Checks new accesses on lower layer. */
 	for_each_path(lower_sub_files, path_entry, i) {
@@ -7442,11 +7112,7 @@ static void layer3_fs_tag_inode(struct __test_metadata *const _metadata,
 		},
 		{},
 	};
-	const struct landlock_ruleset_attr layer2_deny_everything_attr = {
-		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
-	};
 	const char *const dev_null_path = "/dev/null";
-	int ruleset_fd;
 
 	if (self->skip_test)
 		SKIP(return, "this filesystem is not supported (test)");
@@ -7455,22 +7121,14 @@ static void layer3_fs_tag_inode(struct __test_metadata *const _metadata,
 	EXPECT_EQ(0, test_open(dev_null_path, O_RDONLY | O_CLOEXEC));
 	EXPECT_EQ(0, test_open(variant->file_path, O_RDONLY | O_CLOEXEC));
 
-	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
-				    layer1_allow_read_file);
-	EXPECT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	EXPECT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
+		   layer1_allow_read_file);
 
 	EXPECT_EQ(EACCES, test_open(dev_null_path, O_RDONLY | O_CLOEXEC));
 	EXPECT_EQ(0, test_open(variant->file_path, O_RDONLY | O_CLOEXEC));
 
 	/* Forbids directory reading. */
-	ruleset_fd =
-		landlock_create_ruleset(&layer2_deny_everything_attr,
-					sizeof(layer2_deny_everything_attr), 0);
-	EXPECT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	EXPECT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_READ_FILE, NULL);
 
 	/* Checks with Landlock and forbidden access. */
 	EXPECT_EQ(EACCES, test_open(dev_null_path, O_RDONLY | O_CLOEXEC));
@@ -7532,7 +7190,6 @@ TEST_F_FORK(layout3_fs, release_inodes)
 
 	ruleset_fd =
 		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, layer1);
-	ASSERT_LE(0, ruleset_fd);
 
 	/* Unmount the filesystem while it is being used by a ruleset. */
 	set_cap(_metadata, CAP_SYS_ADMIN);
@@ -7639,11 +7296,7 @@ TEST_F(audit_layout1, execute_make)
 	test_execute(_metadata, 0, file1_s1d1);
 	test_check_exec(_metadata, 0, file1_s1d1);
 
-	drop_access_rights(_metadata,
-			   &(struct landlock_ruleset_attr){
-				   .handled_access_fs =
-					   LANDLOCK_ACCESS_FS_EXECUTE,
-			   });
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_EXECUTE, NULL);
 
 	test_execute(_metadata, EACCES, file1_s1d1);
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.execute",
@@ -7691,9 +7344,7 @@ TEST_F(audit_layout1, execute_read)
 	test_execute(_metadata, 0, file1_s1d1);
 	test_check_exec(_metadata, 0, file1_s1d1);
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	/*
 	 * The only difference with the previous audit_layout1.execute_read test is
@@ -7715,9 +7366,7 @@ TEST_F(audit_layout1, write_file)
 {
 	struct audit_records records;
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
@@ -7732,9 +7381,7 @@ TEST_F(audit_layout1, read_file)
 {
 	struct audit_records records;
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_file",
@@ -7749,9 +7396,7 @@ TEST_F(audit_layout1, read_dir)
 {
 	struct audit_records records;
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_DIRECTORY));
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_dir",
@@ -7769,9 +7414,7 @@ TEST_F(audit_layout1, remove_dir)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 	EXPECT_EQ(0, unlink(file2_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, rmdir(dir_s1d3));
 	EXPECT_EQ(EACCES, errno);
@@ -7792,9 +7435,7 @@ TEST_F(audit_layout1, remove_file)
 {
 	struct audit_records records;
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, unlink(file1_s1d3));
 	EXPECT_EQ(EACCES, errno);
@@ -7812,9 +7453,7 @@ TEST_F(audit_layout1, make_char)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
@@ -7832,9 +7471,7 @@ TEST_F(audit_layout1, make_dir)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, mkdir(file1_s1d3, 0755));
 	EXPECT_EQ(EACCES, errno);
@@ -7852,9 +7489,7 @@ TEST_F(audit_layout1, make_reg)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
@@ -7872,9 +7507,7 @@ TEST_F(audit_layout1, make_sock)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
@@ -7892,9 +7525,7 @@ TEST_F(audit_layout1, make_fifo)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
@@ -7912,9 +7543,7 @@ TEST_F(audit_layout1, make_block)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
 	EXPECT_EQ(EACCES, errno);
@@ -7932,9 +7561,7 @@ TEST_F(audit_layout1, make_sym)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, symlink("target", file1_s1d3));
 	EXPECT_EQ(EACCES, errno);
@@ -7952,10 +7579,7 @@ TEST_F(audit_layout1, refer_handled)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs =
-						      LANDLOCK_ACCESS_FS_REFER,
-				      });
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, NULL);
 
 	EXPECT_EQ(-1, link(file1_s1d1, file1_s1d3));
 	EXPECT_EQ(EXDEV, errno);
@@ -7977,12 +7601,9 @@ TEST_F(audit_layout1, refer_make)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata,
-			   &(struct landlock_ruleset_attr){
-				   .handled_access_fs =
-					   LANDLOCK_ACCESS_FS_MAKE_REG |
-					   LANDLOCK_ACCESS_FS_REFER,
-			   });
+	enforce_fs(_metadata,
+		   LANDLOCK_ACCESS_FS_MAKE_REG | LANDLOCK_ACCESS_FS_REFER,
+		   NULL);
 
 	EXPECT_EQ(-1, link(file1_s1d1, file1_s1d3));
 	EXPECT_EQ(EACCES, errno);
@@ -8002,9 +7623,7 @@ TEST_F(audit_layout1, refer_rename)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(EACCES, test_rename(file1_s1d2, file1_s2d3));
 	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
@@ -8024,9 +7643,7 @@ TEST_F(audit_layout1, refer_exchange)
 
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	/*
 	 * The only difference with the previous audit_layout1.refer_rename test is
@@ -8064,12 +7681,8 @@ TEST_F(audit_layout1, refer_rename_half)
 		},
 		{},
 	};
-	int ruleset_fd =
-		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
 
-	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
-	ASSERT_EQ(0, close(ruleset_fd));
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER, layer1);
 
 	ASSERT_EQ(-1, rename(dir_s1d2, dir_s2d3));
 	ASSERT_EQ(EXDEV, errno);
@@ -8087,9 +7700,7 @@ TEST_F(audit_layout1, truncate)
 {
 	struct audit_records records;
 
-	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
-				      });
+	enforce_fs(_metadata, access_fs_16, NULL);
 
 	EXPECT_EQ(-1, truncate(file1_s1d3, 0));
 	EXPECT_EQ(EACCES, errno);
@@ -8106,12 +7717,8 @@ TEST_F(audit_layout1, ioctl_dev)
 	struct audit_records records;
 	int fd;
 
-	drop_access_rights(_metadata,
-			   &(struct landlock_ruleset_attr){
-				   .handled_access_fs =
-					   access_fs_16 &
-					   ~LANDLOCK_ACCESS_FS_READ_FILE,
-			   });
+	enforce_fs(_metadata, access_fs_16 & ~LANDLOCK_ACCESS_FS_READ_FILE,
+		   NULL);
 
 	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, fd);
@@ -8137,10 +7744,7 @@ TEST_F(audit_layout1, resolve_unix)
 	child_pid = fork();
 	ASSERT_LE(0, child_pid);
 	if (!child_pid) {
-		drop_access_rights(_metadata,
-				   &(struct landlock_ruleset_attr){
-					   .handled_access_fs = access_fs_16,
-				   });
+		enforce_fs(_metadata, access_fs_16, NULL);
 
 		cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, cli_fd);
@@ -8169,11 +7773,7 @@ TEST_F(audit_layout1, mount)
 {
 	struct audit_records records;
 
-	drop_access_rights(_metadata,
-			   &(struct landlock_ruleset_attr){
-				   .handled_access_fs =
-					   LANDLOCK_ACCESS_FS_EXECUTE,
-			   });
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_EXECUTE, NULL);
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
-- 
2.53.0

