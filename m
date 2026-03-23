Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688D3C062C
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285102; cv=none; b=kDxXjSPtypiMppNr0QmziK4DJj9zQoOybS2whPyMiLjXq4JZ60TVvFIGthTj33Ht7gT6Yr8qVVTLCqP7hdvzkI9JqPOof4yCQEWArqNS+VDkDFkH8u0L341cM9QHBNMT+ep0hdp9IzQF+VZPHcEzcuoyyzbIF7A3/yG3KYD/lmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285102; c=relaxed/simple;
	bh=VnKb47iJWoCqztP6k2fyeS5+mmhQNA8KUZPiw6hYxHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+CmG517VTs9pmssfI+C3yknjQLJ9EU/dSVwUgcwVS/uxF7+zk7j7cEiN/FGQtplC5sxcaua2EWY280ngLKc8BhJlitiMYpdKTPlp3qPMwhaft+ZKIea/OpK77Pat71JyxRm01MBtnCyHoH1kHGKdLp7MvkNBsEpCzJ3C14uzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYIAF5vv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYIAF5vv"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b7481f9d3so862475f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774285099; x=1774889899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPQJrt55aef6C108749YnlMS+3dITTGe5TAUePuRZLM=;
        b=LYIAF5vvrUagVt/LXTVIbFdJdbe8CAFQjDDZmJwjlDf1Oxagp786fvIrnLuzCIs8H6
         V9N+5R8Adj8e7iKRotn8IY3gV6FbUA09w+p4XMJpim0/TU/xDx10RymPC8+BwD4ORdqg
         ZNZGdz8QsmqQnNv0+LOOfYxkpNXlbSrNn92J2GE6KwDkfDyhSYmyVuU+xZhAI4aCV3nn
         g/BAO9aguW/ZasQPqwznYZCcsHY2ahF8II5xfpm9jAIWJS7hhDSajMoF+ZTzUzizRJSQ
         taMcZsexUkcN6uTL41EKhJmtjnQoZFxHVm2qgc1kUpjbR5FpBXBgTa7CkybNxv/fmA63
         yq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285099; x=1774889899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rPQJrt55aef6C108749YnlMS+3dITTGe5TAUePuRZLM=;
        b=ZPCevvelxpmFd5o9bf9tkOXxL5CSO8jS/q7ZKh+qJY3OJklWU7w9JSUTmZWa6Xq8qG
         6r5dil7rF/l/mRi8XYO1Y83Km3y5Ksr8/V/CnfxbwnXraEoJpw0UfLeGn9XV8I5LDNFt
         bpRc5cuyR3iHlIyksAGxQdoxwc/C6lulqaZadQvlyo657X7X8LX1oME/sSR0JYwvI/gX
         CCJeX8zwuGs8hSbOf8AXrzYOjjXw62EZYaN7veTt6cNaXSFSFdMLpEQ+KaArnC9WrCAC
         uYWVg/Vnf01YFnkT9K9PuCXbt7muVe77EgcyAfhQHOh8FFrOjYHXqecjZ/uuNA2MlW/b
         P1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUax0yZeRZOSQFfZwfjOCU+a9spv6XFnfRPCdtzmN+8Svs4Ad5ZsnQMi2YG+9fQw8ZyZEEwaRSs9LAOxxOnvzn1Ge1TaTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLzoI70iy2MDjIiX1IWOVDgxh4h/V+c0rgj89KKySjr6MZSFc
	Jritfsftp7i69SUEikVqbdd3Taezna4n7kej70R6GSWlbgLPuZHKX8Gk
X-Gm-Gg: ATEYQzzHYmEe0tuKEnNOWyDuBt5kUnQPlbKNwzCzLizAY6Ftz4+nX5ZImWSpDBu/gIb
	JwGPTgC0On4TdZPms1pej6f+5ewdKaxVqRNYkkEMWY7vZ46hVnZOxf9w6KfX757Bqij2mkxvYLL
	cxUo9vfsGU7JbyK900iqfl6mtmqjXPhXilvmX11gC1vtHrtizt2JfZa2rXF4IWalUd4pa4Nsvw4
	KkD9tIaNlrWEUqr+Ap5f12+zsWnpBTb+rAg7WTGhLLe+F712bJ7F3/CgJNZA+rCMt43Bc30alV+
	2hOt1/VYgi0dhwsN5/uLj95FHyKQNJChf5pxXWjNTnaVloqlPZDWYcbeVz+M8jRZWo9SyUmlHwf
	NKA87EuzfKqGB1XtY4SH0htDNe+q4GxRVEFAqRuQhT1Vr6osD9p3c4j1tQgYGFyrTdUHvjWE4IQ
	C4XrROMvFD8niw2991bgLLLhefUAFjOC38RZrDIY5BcKbHk8LnlzykT3u+N1w=
X-Received: by 2002:a05:6000:2512:b0:43b:3bed:f34 with SMTP id ffacd0b85a97d-43b64277eb2mr20266297f8f.30.1774285098999;
        Mon, 23 Mar 2026 09:58:18 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd0dcsm29993644f8f.11.2026.03.23.09.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:18 -0700 (PDT)
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
Subject: [PATCH v7 06/11] selftests/landlock: Replace access_fs_16 with ACCESS_ALL in fs_test
Date: Mon, 23 Mar 2026 17:56:48 +0100
Message-ID: <20260323165654.193957-7-gnoack3000@gmail.com>
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

The access_fs_16 variable was originally intended to stay frozen at 16
access rights so that audit tests would not need updating when new
access rights are added.  Now that we have 17 access rights, the name
is confusing.

Replace all uses of access_fs_16 with ACCESS_ALL and delete the
variable.

Suggested-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 54 +++++++---------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index b318627e7561..9fdd3b8f7b11 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -7161,26 +7161,6 @@ TEST_F(audit_layout1, execute_make)
  * only the blocked ones are logged.
  */
 
-/* clang-format off */
-static const __u64 access_fs_16 =
-	LANDLOCK_ACCESS_FS_EXECUTE |
-	LANDLOCK_ACCESS_FS_WRITE_FILE |
-	LANDLOCK_ACCESS_FS_READ_FILE |
-	LANDLOCK_ACCESS_FS_READ_DIR |
-	LANDLOCK_ACCESS_FS_REMOVE_DIR |
-	LANDLOCK_ACCESS_FS_REMOVE_FILE |
-	LANDLOCK_ACCESS_FS_MAKE_CHAR |
-	LANDLOCK_ACCESS_FS_MAKE_DIR |
-	LANDLOCK_ACCESS_FS_MAKE_REG |
-	LANDLOCK_ACCESS_FS_MAKE_SOCK |
-	LANDLOCK_ACCESS_FS_MAKE_FIFO |
-	LANDLOCK_ACCESS_FS_MAKE_BLOCK |
-	LANDLOCK_ACCESS_FS_MAKE_SYM |
-	LANDLOCK_ACCESS_FS_REFER |
-	LANDLOCK_ACCESS_FS_TRUNCATE |
-	LANDLOCK_ACCESS_FS_IOCTL_DEV;
-/* clang-format on */
-
 TEST_F(audit_layout1, execute_read)
 {
 	struct audit_records records;
@@ -7190,7 +7170,7 @@ TEST_F(audit_layout1, execute_read)
 	test_check_exec(_metadata, 0, file1_s1d1);
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	/*
@@ -7214,7 +7194,7 @@ TEST_F(audit_layout1, write_file)
 	struct audit_records records;
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
@@ -7231,7 +7211,7 @@ TEST_F(audit_layout1, read_file)
 	struct audit_records records;
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
@@ -7248,7 +7228,7 @@ TEST_F(audit_layout1, read_dir)
 	struct audit_records records;
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_DIRECTORY));
@@ -7268,7 +7248,7 @@ TEST_F(audit_layout1, remove_dir)
 	EXPECT_EQ(0, unlink(file2_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, rmdir(dir_s1d3));
@@ -7291,7 +7271,7 @@ TEST_F(audit_layout1, remove_file)
 	struct audit_records records;
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, unlink(file1_s1d3));
@@ -7311,7 +7291,7 @@ TEST_F(audit_layout1, make_char)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, 0));
@@ -7331,7 +7311,7 @@ TEST_F(audit_layout1, make_dir)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, mkdir(file1_s1d3, 0755));
@@ -7351,7 +7331,7 @@ TEST_F(audit_layout1, make_reg)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
@@ -7371,7 +7351,7 @@ TEST_F(audit_layout1, make_sock)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
@@ -7391,7 +7371,7 @@ TEST_F(audit_layout1, make_fifo)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
@@ -7411,7 +7391,7 @@ TEST_F(audit_layout1, make_block)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
@@ -7431,7 +7411,7 @@ TEST_F(audit_layout1, make_sym)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, symlink("target", file1_s1d3));
@@ -7501,7 +7481,7 @@ TEST_F(audit_layout1, refer_rename)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(EACCES, test_rename(file1_s1d2, file1_s2d3));
@@ -7523,7 +7503,7 @@ TEST_F(audit_layout1, refer_exchange)
 	EXPECT_EQ(0, unlink(file1_s1d3));
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	/*
@@ -7586,7 +7566,7 @@ TEST_F(audit_layout1, truncate)
 	struct audit_records records;
 
 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
-					      .handled_access_fs = access_fs_16,
+					      .handled_access_fs = ACCESS_ALL,
 				      });
 
 	EXPECT_EQ(-1, truncate(file1_s1d3, 0));
@@ -7607,7 +7587,7 @@ TEST_F(audit_layout1, ioctl_dev)
 	drop_access_rights(_metadata,
 			   &(struct landlock_ruleset_attr){
 				   .handled_access_fs =
-					   access_fs_16 &
+					   ACCESS_ALL &
 					   ~LANDLOCK_ACCESS_FS_READ_FILE,
 			   });
 
-- 
2.53.0

