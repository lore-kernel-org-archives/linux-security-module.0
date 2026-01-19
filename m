Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61EA2F25F4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854932; cv=none; b=qg91Bx83yJTVmPd+m8mX/vh2GQ8CHwy3W05vFjLWhRonAxiMuelOdtXS7rb/N32q4ibW08vVNyOsS6wDmTfqk3sWnsRpeHpiPRps/WsBVN844udq4LzW5rS1xCKUx7NS7O5Ry8L0kU31WFM1LSNb7Cn4Gsf86+J2sLCbp1BFY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854932; c=relaxed/simple;
	bh=8JAIHYQyBp0tCI8dg7+G5HojAN9jv6Iw9q4Pqn8ckSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtoifDgdtCNTpF1GXKvsHXFNtQX1wnBBxfEzmdbrlZTD3cSBvBN/huFMyoWsq/P+1xVpNwH5otR+f+ubOQ5xUs2JGErV5717+PnSPM5vTD04FCAOc18Ms7Lkq9nbuKKdaNHzItHCpzC+RoA5UBgRARB0OupQUNzL56pw9/0FKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsyzbRCo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsyzbRCo"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b876bf5277dso865413766b.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 12:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854929; x=1769459729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sodVLmhC3puDKa3MkHxwvZr+w3PQuQ/7OVpcZcGL1qw=;
        b=WsyzbRCoD6HR2wIx8YQE//Vi9vgBtlOOee7ybZhcNiC3tU/DDhPp/ikzQlhvL1Idnz
         iQrzpXJ9wIH3GVtnyDbcIizHNur+NamXorgsnpnbk4G7AtAVvKUwCEd7n0+cLfFrVcEq
         kTEyAVMfdQcSMEXxWQ+jXq9GmeQl0WO3lnMysmuJ1cYnAM4t4T12SkA1VUlf7hX+PRnC
         +PxjGScSUbz+K0Nuc86GLvtG6r3CXbbERwEtu6kz6C0NZks0CNkKwkOHXDJVUpmKcgPj
         kYsdz0+FPyf4I+A7E2+drUQTqYm4XRuUSG0UGGucgAWleNxIL0KNnB1pcAMvbxdfvqbq
         XIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854929; x=1769459729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sodVLmhC3puDKa3MkHxwvZr+w3PQuQ/7OVpcZcGL1qw=;
        b=bpwKL+eVqGLZU3n4ln3ShxCWcotsmh+t0Nd6Dh4E3oa2D9wGejRBho75VJlWSWjvbH
         YO7on95xe6kzxnU2RBEsNBMYSzacdRmojVBufV3z6sK9vaFF5EIxUZXi4RmmpciKaMWn
         skVf5QGSHf1H1OW08BJX37p+i2lFVWDzHfgnTj8KJ/jdRtUkg2shq3ByxTXJ92Vyu1EI
         Z2WwnR0/VJKTv8KAfhGIuwwvWTx4qQQOUtA1vC78FijfdlQ0tRwMVkGyNjlhU/cgI98N
         USYDeFiypEXqUUX7ZYExNaxMS8gcsY3H+y/vPYY9nlpvySX3/I8Pe3iEkZ3Fo47gsoCZ
         DVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFdNDcms5vs19jQq8bzDsK4b8XuAsHkXCy4YlYJCSzZnIWdcVcNQOOO7lMhvQbftPZrhuAq5DwnSVqDDhVZOO//XcRCD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq825WTbccwXvG7bRP2GbQDm0/0EkyInRaQTmrAy5HpBsYTNxj
	UvdCUnF9wxBz/gHQyOVFZx412Ul2FQJXfa2rizN9rBAvWkf1YLR0Sa6r
X-Gm-Gg: AY/fxX7Brz4Zi1P/r/dK9ZT3rrhYJMdOVFmSabT+Ed2AwaKWEHr9BfNDAorChQ4AoHx
	RKos+1as1jA/LodE2GyJRvKdB5VhWQR/Ag4EDy/Qt5xwhDGyEwvV3CuCOYs9Vdq2wBaaaaMiim/
	89Gb0VGjbPM37rzcVQkg56Hxn2ToGI1T3XIe2hNzOTow098P9kjcYcEkD+a8tcu1oVbCKaNqKtf
	xmE2oQuv7sp8u2gl/561+0nGJe5iuAHC2Zk5xZOyevryPYXmNaxIUlf3ZDUVRLSOAK4iC+15No2
	zRUaVovemWo+mbLMgSCK5VTi250leG+Qry2QZxPwTgc+2CAo/hb8H6S079dtyZw3QdvOYpSrrmA
	gI1Hmm6LtIr28DP7QacyyWra9qEAm7ZzRDv34v5zt2vRjwpDFrCRTCv/ucAtZQ/cUsQQSkoNUuO
	4RdnNzrkQCAIpxE50vbuIFGsory1SN1HCwMQKA
X-Received: by 2002:a17:907:3fa1:b0:b87:2882:bf7e with SMTP id a640c23a62f3a-b879388e29cmr1264783666b.11.1768854929135;
        Mon, 19 Jan 2026 12:35:29 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fbb38sm1175716266b.52.2026.01.19.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:35:28 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>
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
Subject: [PATCH v3 2/5] landlock: Control pathname UNIX domain socket resolution by path
Date: Mon, 19 Jan 2026 21:34:55 +0100
Message-ID: <20260119203457.97676-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203457.97676-2-gnoack3000@gmail.com>
References: <20260119203457.97676-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
  controls the look up operations for named UNIX domain sockets.  The
  resolution happens during connect() and sendmsg() (depending on
  socket type).
* Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
  LSM hook.  Make policy decisions based on the new access rights
* Increment the Landlock ABI version.
* Minor test adaptions to keep the tests working.

In case of a denial, connect() and sendmsg() return EACCES, which is
the same error as it is returned if the user does not have the write
bit in the traditional Unix file system permissions of that file.

Cc: Justin Suess <utilityemal77@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Suggested-by: Jann Horn <jannh@google.com>
Link: https://github.com/landlock-lsm/linux/issues/36
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h                |  5 +++++
 security/landlock/access.h                   |  2 +-
 security/landlock/audit.c                    |  1 +
 security/landlock/fs.c                       | 18 +++++++++++++++++-
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  5 +++--
 8 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 75fd7f5e6cc3..1d9917fc16d2 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -233,6 +233,10 @@ struct landlock_net_port_attr {
  *
  *   This access right is available since the fifth version of the Landlock
  *   ABI.
+ * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX: Look up pathname UNIX domain sockets
+ *   (:manpage:`unix(7)`).  On UNIX domain sockets, this restricts both calls to
+ *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` with an
+ *   explicit recipient address.
  *
  * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
  * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
@@ -318,6 +322,7 @@ struct landlock_net_port_attr {
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX			(1ULL << 16)
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
index e899995f1fd5..3e754d2fb0e1 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -37,6 +37,7 @@ static const char *const fs_access_strings[] = {
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
 	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
+	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] = "fs.resolve_unix",
 };
 
 static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 8205673c8b1c..e69f2f809f02 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -9,6 +9,7 @@
  * Copyright © 2023-2024 Google LLC
  */
 
+#include "linux/net.h"
 #include <asm/ioctls.h>
 #include <kunit/test.h>
 #include <linux/atomic.h>
@@ -314,7 +315,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 /* clang-format on */
 
 /*
@@ -1588,6 +1590,19 @@ static int hook_path_truncate(const struct path *const path)
 	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
+static int hook_unix_find(const struct path *const path, int type, int flags)
+{
+	/* Lookup for the purpose of saving coredumps is OK. */
+	if (flags & SOCK_COREDUMP)
+		return 0;
+
+	/* Only stream, dgram and seqpacket sockets are restricted. */
+	if (type != SOCK_STREAM && type != SOCK_DGRAM && type != SOCK_SEQPACKET)
+		return 0;
+
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_RESOLVE_UNIX);
+}
+
 /* File hooks */
 
 /**
@@ -1872,6 +1887,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
 	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
+	LSM_HOOK_INIT(unix_find, hook_unix_find),
 
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 65b5ff051674..a07302e6bbcb 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -19,7 +19,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX
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
index 968a91c927a4..b318627e7561 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -575,9 +575,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
-	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
-- 
2.52.0

