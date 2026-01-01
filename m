Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74971DA0E1
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767274876; cv=none; b=br5AyXFungqo9bcp0bl15Q0WJCx+HoAyVsmnIRahXJ+R+GDYnYbjpD2TIfYZ89EFMT82IaVPFo7OlkyyQNlCEUG8ymNtCYDC/u25ZOiwD5S5pnuiHahglPqUwkJJWMM7GzSHMftToh7HIMFRMLxt+RPDfGATcsuVNx8IGWM6ClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767274876; c=relaxed/simple;
	bh=yKp4DboYE+uOHvpTtSBtav2vXfFY31Gny8YRYuGZufs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZX23sadeIq/VIeclSfxW3F3+V4EfmzAef8ax2JwxN/tqkdfQF1tsOZ7mhFqeqKumrhFxSd1bi8VxBKkJScwyH5rkRS9Uwu4V/3zHa8xjfPGdypkt8hLSourCIjmhIEpEiDi8I0glxDfg2DBvxS11yeBZtUJaYkn7uTNlHnE6MsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO7xlTvS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO7xlTvS"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so14047360a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767274873; x=1767879673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+dI5hnnBFW+huUknxN6+rXhcFTPXb90P4HnoNOkJhk=;
        b=DO7xlTvSgcC1FObEUsM5O/ShT4DO/j9XYzWi/D2W5YWsTQjY9N+wsXL2rcB3B7ZkSm
         YK46hdO++5sLRgozE0tUJoQOc9T7d/XGqH5IaORjS1boCmfWcvyNeWED5PjSfex5e/Gh
         7NQhzWDsuzH2UrUrZMlfw3nB6CgY1ZEqFlFTu9iGvX9RAYnpFTf+1kok3bVN+tkVrj5I
         bqWLaTImCHP3WI8E4EMUcuRI9MDCyhWdQ8ZbZ8MpHnI/3w+w9e5C9WU9QIPkLqXpONgq
         TcjjfNKzeG0JbjlFLKpaf8+ZlhiL1TjhNbvdrmNoe+Gq52Mv+C3RhMncaBl85K++0Uak
         ORPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767274873; x=1767879673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+dI5hnnBFW+huUknxN6+rXhcFTPXb90P4HnoNOkJhk=;
        b=XPRTLMzmC1bZR/flGnCGWXTkuXj3k4g3KqbRQNGqu7eNyAiu3P6yVkTKRoV8LL/B1a
         FjcxHCPvrFlEzPN1OaFGfaLOxPHigQiTot7mO8d2viLHVhtZ6LHEp1GqqeJnAswwo8XP
         BbeyrIedd93OWRU2XPahq45wyJJG7RpEbSkS74+NRwhhbVzQJ3SY1PnsDvZWq3fJvEg1
         WzV9ymuD+gUZ/N7wSCJEy7ZzjmYs0NA53LzkhlKuTNFruKLGJNRfKVq5P/6UNMaZyeEl
         l7PrjQkeHgs/++MAGhupLI2QfyWmM24jJEqvDY02BCmW11g0V5PdmJU4yazbL3akUkQP
         Ez1A==
X-Gm-Message-State: AOJu0Yyssir629qiQljrkx5loi50d9L6Wt9KyqnJqWdwpWW2S+vu9AiI
	gDj0NK5XvpNueOV2Fab1Nt2ZgeHNUEIKNEf/Bg0MKxvaJzpYm2YN5kvx
X-Gm-Gg: AY/fxX4lI761FpqPOg/jYzDVqHFfDoa2HEvbRghJa/jPoemuCKgkG3nmBqC3Qh7pP/t
	2U2bSBUaD7guzcXgBeGBLbKLp/HZcINbKqfnRCxeUrG9Tf+FjUynG1qEq4yG4LWO0V7YUwM0LT/
	1HOU126R9euECSa8TYRMkwEhxeSQDKvYxnEjyp7eCJ6CXAmokR/mgIvvwAGn/5XmzF28ceVG1Z4
	l5LWazXrIQBrVtZAF0pain7WIaMq773pKZu1wx8qqE5tnZTR3ot9mw4N41oaOnyvSbT5+MBWYQk
	XCavKRB5XxsZefX49aXAIrXlbbhcXMMtyojyb2lvgqu3S0DVZ+BQCXVu7r7OPTE2IIF+OW8Q9N/
	2XsWXoeZhQQxQ5sVjLS0kSNRrhFKshVN7wiIH3NCeIGmAH1R3D/NIWn9aCbcjNpN/1rkQ7oAcPS
	tckUnb8exBwVfpgLdAcl7rW6tsWJZm16B3VdxT
X-Google-Smtp-Source: AGHT+IGvfU2tDT5sjFRjMKz/s72gQAVf5zGTywQfGaZUw39Njs/dDEJ3Y359LrWSxVtAsANsKqKFoA==
X-Received: by 2002:a17:907:7e85:b0:b7f:eb45:f572 with SMTP id a640c23a62f3a-b80371e9f7amr3917489266b.55.1767274872818;
        Thu, 01 Jan 2026 05:41:12 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f4ef1fsm4337275866b.64.2026.01.01.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:41:12 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [RFC PATCH 2/5] landlock: Control connections to pathname UNIX sockets by path
Date: Thu,  1 Jan 2026 14:40:59 +0100
Message-ID: <20260101134102.25938-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260101134102.25938-1-gnoack3000@gmail.com>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Add the LANDLOCK_ACCESS_FS_CONNECT_UNIX right.
* Hook into the path lookup in unix_find_bsd() in af_unix.c,
  using a LSM hook.  Decide based on the new access right.
* Increment the Landlock ABI version.
* Minor test adaptions to keep the tests working.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Suggested-by: Jann Horn <jannh@google.com>
Link: https://github.com/landlock-lsm/linux/issues/36
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h                | 3 +++
 security/landlock/access.h                   | 2 +-
 security/landlock/audit.c                    | 1 +
 security/landlock/fs.c                       | 9 ++++++++-
 security/landlock/limits.h                   | 2 +-
 security/landlock/syscalls.c                 | 2 +-
 tools/testing/selftests/landlock/base_test.c | 2 +-
 tools/testing/selftests/landlock/fs_test.c   | 5 +++--
 8 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f030adc462ee7..189a6e3bbac05 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -216,6 +216,8 @@ struct landlock_net_port_attr {
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
  *   ``O_TRUNC``.  This access right is available since the third version of the
  *   Landlock ABI.
+ * - %LANDLOCK_ACCESS_FS_CONNECT_UNIX: Connect to named :manpage:`unix(7)`
+ *    socket files.
  *
  * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
  * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
@@ -321,6 +323,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_CONNECT_UNIX			(1ULL << 16)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/access.h b/security/landlock/access.h
index 7961c6630a2d7..c7784922be3ca 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -34,7 +34,7 @@
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 /* clang-format on */
 
-typedef u16 access_mask_t;
+typedef u32 access_mask_t;
 
 /* Makes sure all filesystem access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index e899995f1fd59..1a937cbdca7af 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -37,6 +37,7 @@ static const char *const fs_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_CONNECT_UNIX)] = "fs.connect_unix",
 };
 
 static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 8205673c8b1c4..e8cecbd7f2490 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -314,7 +314,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_CONNECT_UNIX)
 /* clang-format on */
 
 /*
@@ -1588,6 +1589,11 @@ static int hook_path_truncate(const struct path *const path)
 	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
+static int hook_unix_path_connect(const struct path *const path)
+{
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_CONNECT_UNIX);
+}
+
 /* File hooks */
 
 /**
@@ -1872,6 +1878,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
 	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
+	LSM_HOOK_INIT(unix_path_connect, hook_unix_path_connect),
 
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 65b5ff0516747..5928d538d8115 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -19,7 +19,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_CONNECT_UNIX
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0116e9f93ffe3..66fd196be85a8 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -161,7 +161,7 @@ static const struct file_operations ruleset_fops = {
  * Documentation/userspace-api/landlock.rst should be updated to reflect the
  * UAPI change.
  */
-const int landlock_abi_version = 7;
+const int landlock_abi_version = 8;
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 7b69002239d7e..f4b1a275d8d96 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(7, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 16503f2e6a481..74e975c5e9847 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -575,9 +575,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_CONNECT_UNIX)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_CONNECT_UNIX
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
-- 
2.52.0

