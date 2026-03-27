Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3DE351C38
	for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630165; cv=none; b=ZJkxHIhRsLzHOHXXGgk/wj0aWLITh8TlA7w/ulSbrWfBYeZqqPJKixZ3EtQOljEuDWpILUo6mDqiLooi7690qpG30mei3IRF/YgjEfp2i2Pg8FCoEuhXZtiOm03iQD4QRe+efz0uQnOG6OKbIxUOOk54uOULJKgJ8w7Kc/pgQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630165; c=relaxed/simple;
	bh=VnKb47iJWoCqztP6k2fyeS5+mmhQNA8KUZPiw6hYxHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLxaCiIrT9J2lN+FVAJCmFXqeOxDSH7l1iD9R7+YEUHw67ny1WniOi2RagNSO9F6oY49FOvsLgqiZmjdg2dd7/ZNyocmfbUBD0T6HDA/d1n70njzNGed+4qANpuL6CwQZRoFi+wxSpHvI/kTt9Focn73GaA1CNT+Z3zB8ipJO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/By31N7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/By31N7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so27675125e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 27 Mar 2026 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630163; x=1775234963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPQJrt55aef6C108749YnlMS+3dITTGe5TAUePuRZLM=;
        b=q/By31N7UGlHTZ1meZhc6VmOfHfMK9hSwRrBvfDSCjCwcA9tzgT12Go/Ub4bBdk5bc
         zsKEwNemet6OvJJJE0n3bvCCdhpokV3xIwFEeWJ4B5xT2W1cYVWMkv9m++dmS7Fh7fXo
         Y+BX3PHQCvXKk30kFEobRpWpMljPOd2UdL1cYKAjtJWUOWGCCD2JC0zvO8Mbc8GNBOjJ
         RyA3BrE1anobGCLYqBACWI6+aCnNNMk2um12UqWmY+1kw0sU8xun6+JrIMGl7ppQwS5v
         VlOnjwajFB/kfHmi1qUFt9d1dTxQ2nOt47tnydHEf3M9rpJyU65EeWBqOWSLX8bo49Ce
         089w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630163; x=1775234963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rPQJrt55aef6C108749YnlMS+3dITTGe5TAUePuRZLM=;
        b=moPTgERQD8BuexDjEGTAiWU8UZ74/gnLbgEptj1+sSjijAyBDFbB6VVT3f6d/KE20E
         x7QnALl/wDFhmXag4eOJKA1oFAw2NP3qYZbFXFD63AB1eFh0LBlaZunzr4cb7gV0wjk2
         ZFcKTKjstiKzEk9+HABz0w2rJ24HZG/kE/T6ax1vghmeizI1elbiWih9KgnmNmnwNd0x
         nFnALoEpjsG38g+TLH75ESyyhTPLaycT0gVoWoC1YphtIccMNEWZ/SxaAV4eIqm1NQFe
         XRdrVk2DCZ7MVoHaP4R6A6xULKMkh2xZtRU63wDk3EWtIc9qXQOd3G84SE9zAyWmoZrB
         nMMw==
X-Forwarded-Encrypted: i=1; AJvYcCXA/NsuOrJDvPVwJ8GUKaYnxsgXoIc648NOKG8rVzQf63hFvDcCXAr3P4yL/KSAKI+GyNwdTJhhQLL9/JsK6PGNYJJRf8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxNxWqLC3emJFBiN3HSpQ5r4x2eipOhoQ2A+RUMTGyMf9jD9m
	uU8K1JAPlpbJwKD8n34ayxZxUslSb4wDW9k7y5DS9sW4d2qxPzsXb/N/
X-Gm-Gg: ATEYQzyaPX3IKj2sVdXoi1/iKvc//rAI5IkOT69xNRrh8ji6bL6471zX2KG3hD1ulZC
	qwbHqvSdwozq8hXif03yL52T8rNor0z1Kb/K2kULH/k3IrWRqQmUDTTX5MY/JvS7AGHXfFL0ZJs
	xszOvJx04UsF6H3uiuvSqGLrrM5Inf7iC3zG063lXyE6O8IAPLjR+sZxnb3T0UBj2QM5J36VXJt
	Gcllajn4o1MDY0Wxo9GKvswLoWrxjNKQkCO5WrZdZA4IzvTmUPyWBEGuCNvqo2S3CjdstqESbJj
	5mbP7Qjs0srVHb07hAg2LTksVczisWIRvuPr5rzob+x/pZ8jN3hkQwOSfZVrs2MfzOLK/zZ1I+3
	WYSHUId2Uks+oycxceq6BiIKci4AhkCTM/iUYPzLY+iqfaEuldXdioQT1wzVpjdNlOMSJ0wIfm5
	fsW1yIC3mAioV6QdjrUe2b+86uftITk9G4VnG3d8FtkotdWujy
X-Received: by 2002:a05:600c:a407:b0:485:4526:ee06 with SMTP id 5b1f17b1804b1-48727e8bd95mr46347795e9.11.1774630162589;
        Fri, 27 Mar 2026 09:49:22 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2c8sm15132075f8f.20.2026.03.27.09.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:49:22 -0700 (PDT)
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
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>
Subject: [PATCH v8 07/12] selftests/landlock: Replace access_fs_16 with ACCESS_ALL in fs_test
Date: Fri, 27 Mar 2026 17:48:32 +0100
Message-ID: <20260327164838.38231-8-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327164838.38231-1-gnoack3000@gmail.com>
References: <20260327164838.38231-1-gnoack3000@gmail.com>
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

