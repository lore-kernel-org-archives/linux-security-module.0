Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74C21D00A
	for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768055685; cv=none; b=qI15kfI3aMHgF7mrCvU+2nmubolz2izwS5wNpxsn2PWslvOq6FK0xz60ktkgfFvrSKwXkUIIZ8DV/l8FoUSMHBihkKdEJ2qBm4YSiQbai2rwQiJUWPHAX7r4h97o6uzz/nlhGntfuJS91z0xUTpoOwWqwfaXl18APEgn4jB7yxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768055685; c=relaxed/simple;
	bh=oNSb0zC5sqyR0q/9lbFdI7MxcVsG4LeE1H6/5inqeNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avDwX42vFPPw2vwHWhWli61rwdHawW5Mab+SNS1Xxz/43lZkA3bxHMQarpcqSdionDKLgdOpQNjmJWnayYYdLEqgQJxODdr7SUmz8jTR05FowM8Ju7s9JhneQaFngFJOZCz6khRPBxifXid/pnbFv/T/ykNuHrq52hK2KjuHfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttwd4wRv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttwd4wRv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79ea617f55so1032665766b.3
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 06:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768055682; x=1768660482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gwgu6qTSZ0SELqPMiilTIPAfh66C0Y3AhOI7fzuJIjk=;
        b=Ttwd4wRvQs51zio1jvm3UySIQNy2ljLnwbp8goeevcKZsyyNBQRjJf6RaYGupWom2X
         Yp0RW3A/fno+OwcsyViFvohhfTDVWigDJxr6nenofnbLTgSyNJN8XSe9csjudXkEzRH/
         OY+/BXhz3rFKT0u+6unrVEre5213KR/FbMURDVxSjmq2gsGi2+2SWc/7MyxfZPM2CEt9
         tUkEAsS90qLQgZLNINK32Eu5GPJAyR3wNhuZw0mGVCaqmI0kTE7UTZ7vbCF9ZWPW4AUj
         HqEAHWh/7bUtOEX81PWG+I6KAi+SQqxi4l6BP4le6blc+uasD72/gRjBmm12SH5ALz76
         ydbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768055682; x=1768660482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gwgu6qTSZ0SELqPMiilTIPAfh66C0Y3AhOI7fzuJIjk=;
        b=LGgjsLS8Q96oPrZbz/4V368mhJb7BPu+8bWOdAy7qvZXnP5WFDh86GbQF73J1FmRDt
         vZ0+jxP7S4eClnLt2+56Lx8C0IsVO+x0+B4ogS/Wv0pe9lKFXxT2OEYnPgCgWxN1vTH0
         Xyy3sY/vPzbfOygms0pWVFMk/xpjDZ0s0pr8MgnvIUerS+b//Rqia58upAY/d7Gt5oID
         l/n/JF1wzRnqWSDF9tEHwSiqF7asvCwjRKhb1gxQn1r7FptafLiOpeiJ+G0JfaY6Flf7
         GaPCaM+IlNHzqlJUUxkTzTsPVSDmn5FQUE9iQ0daaxpfXxbVKWKj6OaKuPneaQz5tviw
         9YyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrLkNrJE8JKWDOfIF2DcpUaWZIHG4+yQgPZApsDTxqhPdpCBnho7h7lNS4mgpEmJvaIZGVTYD6jeSoRPyyCfN/pdY3M2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9w9uyCNkt29w6fzUb3BLawBA0XlHtEfn9aN9B3F8UvFGOB9B
	MFMf6Arg37KGSPHEbOmdm+TdqDaKa7N9pba2mnWZ3NvXhkSEEFKSxALs
X-Gm-Gg: AY/fxX5wBnh7acvDBQ/cxRQeBXnIxkS0kYCjd83kI1Gk2IN3x4cVfUXNpPccqW/lJRp
	Q+9rk7jH4Owx921+b5QboUun//cCDwgz9/73qMFEXr5EbVQlnCLDT7T7hsyaGYJ2aKAW9ZOEdZF
	EEleqlXA/YCbS/2ocnk5FmdtlE1kfKADQPMj7EM/MqOt2OcLDZI1Qxn50THCfa6RQkBsQYp34dY
	yOIyKYqje9+eAK6Os5GdDGwuGggN0PdFKpjy53lHO38cN+zEBDAyOurO5a6l+wV77ceMr/TAYDv
	HGPhbgHreRIt3YpPlA7DnQNXIKedHwPzq8aTcAXZ71tHbV3OT9BANn7a1Stc2nWvAsEVPIwUp7L
	mFwEI/DbCMqGuJ4+JUSougMPPK8PnUutgc2PcwrANamIUYC8pkX36/KsBnLwvemza/at8Dhqrx8
	sqWSx9G/lPxao9VlzGi17NFO5p+tV3zdbaCAz3
X-Google-Smtp-Source: AGHT+IFFTTaO0wL3PLBTN8GiOmEsw7+zifSCUKnJh2Cex7OnMB3bhLsHTpOg+UwkJ0Kvt5qdccjvlQ==
X-Received: by 2002:a17:907:1b0f:b0:b6d:9bab:a7ba with SMTP id a640c23a62f3a-b8445179d97mr1309090266b.42.1768055681693;
        Sat, 10 Jan 2026 06:34:41 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4048sm13249063a12.2.2026.01.10.06.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:34:41 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Tahera Fahimi" <fahimitahera@gmail.com>
Subject: [PATCH v2 2/5] landlock: Control pathname UNIX domain socket resolution by path
Date: Sat, 10 Jan 2026 15:32:59 +0100
Message-ID: <20260110143300.71048-6-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110143300.71048-2-gnoack3000@gmail.com>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Add new access rights which control the look up operations for named
  UNIX domain sockets.  The resolution happens during connect() and
  sendmsg() (depending on socket type).
  * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM
  * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM
  * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
* Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
  LSM hook.  Make policy decisions based on the new access rights
* Increment the Landlock ABI version.
* Minor test adaptions to keep the tests working.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Suggested-by: Jann Horn <jannh@google.com>
Link: https://github.com/landlock-lsm/linux/issues/36
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h                | 10 ++++++
 security/landlock/access.h                   |  2 +-
 security/landlock/audit.c                    |  6 ++++
 security/landlock/fs.c                       | 34 +++++++++++++++++++-
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  7 ++--
 8 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f030adc462ee..455edc241c12 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -216,6 +216,13 @@ struct landlock_net_port_attr {
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
  *   ``O_TRUNC``.  This access right is available since the third version of the
  *   Landlock ABI.
+ * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM: Connect to named
+ *   :manpage:`unix(7)` ``SOCK_STREAM`` sockets.
+ * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM: Send messages to named
+ *   :manpage:`unix(7)` ``SOCK_DGRAM`` sockets or connect to them using
+ *   :manpage:`connect(2)`.
+ * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET: Connect to named
+ *   :manpage:`unix(7)` ``SOCK_SEQPACKET`` sockets.
  *
  * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
  * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
@@ -321,6 +328,9 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM		(1ULL << 16)
+#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM		(1ULL << 17)
+#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET	(1ULL << 18)
 /* clang-format on */
 
 /**
diff --git a/security/landlock/access.h b/security/landlock/access.h
index 7961c6630a2d..c7784922be3c 100644
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
index e899995f1fd5..0645304e0375 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -37,6 +37,12 @@ static const char *const fs_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM)] =
+		"fs.resolve_unix_stream",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM)] =
+		"fs.resolve_unix_dgram",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)] =
+		"fs.resolve_unix_seqpacket",
 };
 
 static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 8205673c8b1c..94f5fc7ee9fd 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -9,6 +9,7 @@
  * Copyright © 2023-2024 Google LLC
  */
 
+#include "linux/net.h"
 #include <asm/ioctls.h>
 #include <kunit/test.h>
 #include <linux/atomic.h>
@@ -314,7 +315,10 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)
 /* clang-format on */
 
 /*
@@ -1588,6 +1592,33 @@ static int hook_path_truncate(const struct path *const path)
 	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
+static int hook_unix_path_connect(const struct path *const path, int type,
+				  int flags)
+{
+	access_mask_t access_request = 0;
+
+	/* Lookup for the purpose of saving coredumps is OK. */
+	if (flags & SOCK_COREDUMP)
+		return 0;
+
+	switch (type) {
+	case SOCK_STREAM:
+		access_request = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM;
+		break;
+	case SOCK_DGRAM:
+		access_request = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM;
+		break;
+	case SOCK_SEQPACKET:
+		access_request = LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET;
+		break;
+	}
+
+	if (!access_request)
+		return 0;
+
+	return current_check_access_path(path, access_request);
+}
+
 /* File hooks */
 
 /**
@@ -1872,6 +1903,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
 	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
+	LSM_HOOK_INIT(unix_path_connect, hook_unix_path_connect),
 
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 65b5ff051674..1f6f864afec2 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -19,7 +19,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0116e9f93ffe..66fd196be85a 100644
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
index 7b69002239d7..f4b1a275d8d9 100644
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
index 968a91c927a4..0cbde65e032a 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -575,9 +575,12 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
-- 
2.52.0

