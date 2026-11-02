Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630856;
	b=u5QsdUzZIn7Se0sO71TwGKRbGeHdanBWgexCC6el4+dlWFuomS0aw8nry/Ynf3aWyQFW
	 WDfQh6QS9bV+3s0doC/oE0Qs+imKo9cfxHzUGt1l3f4VWy8lymtXx2q1ONDud3002nIVh
	 ib0hLrwQcqZiqpMdyHVYtmrAzMUi8Y8YHuWSmkdb0oT4b05Je0IvSeX0Q+UtAkTPmYRdR
	 S77cgQab2L4LGbZBv2d1MaxIihC5XOLFRO9ZFhs0JpSEy+uJ7w4DHFT7kqN9i16+7SRRX
	 U2NRl45EQXgW0O3RFCF9/swr/2dxM05lSgHJITBdL15y1UUs3N4pGz5h10/RglDGeJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AAHuS3hfhCxtXIIZ0jwHiKwyzjzaw8v+z2uwDWG8rMQ=;
	b=2SPZzLNDeUCGIQ5SEgd0/bauoCren1QG81LBGNddXDv9MkPRXqXGtuyEw8ljf/zExARM
	 NF7J+dD+7EvsHo30biaWkRv+RvS7XvBeB80RsxFBaAifsEEet3/0bf++cipQTAHCkT+va
	 BPcyDb0Bp/dLFjJWu/u7lOi0LIgY+kyv76jCgnG3x6PFDYYjniP8szfAMZu+wBLwb0kUf
	 +s4ThvzAf/3LFYN5pPtD/ZghXV5IKQ8nUTVswtMZ+BuUaPa3uBcMw3yuhlSZyN/Fmm7kr
	 YQuAl0lsnFO9xIalnWz/h1acLLB0X573/0OD/dZ4m+G5AsEPxO9j/JiB6c/ZmwDKUyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hB9yD1X7;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30C6083601
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA30C6083601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hB9yD1X7
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so23908265e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2026 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630854; x=1794235654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAHuS3hfhCxtXIIZ0jwHiKwyzjzaw8v+z2uwDWG8rMQ=;
        b=hB9yD1X7FRSHG1Y7OvIBsAB2Z4rnFdHfnyZLFrWJt2NfF8iCqn1sUOJwqPYm1dReXj
         7KofwGofmlaVQf0Tk1umpCSFSpZutxsPP6ZoOdJW7zdaKIrL1bCvdRk5y1gEG/FWspnv
         mS0ZkLnUfdRNI9odnJ/ldu2dKWFWF/edBb3twRFI7CsDtnMhZY85CpSwOWCNzUwafmdg
         ZVB8s0+YgiNeIaRirKkp8hiDUNKLoxf2oTUbZCKDOdmnSbh+aHpA20V0ZKsxl3wvR7rg
         tmZB0s4McxoIgBjzNPWIVTr2RvysnC5QrqlIhZHHXWhTaR84GHopDcakr/v77NpJ9RWz
         XFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630854; x=1794235654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AAHuS3hfhCxtXIIZ0jwHiKwyzjzaw8v+z2uwDWG8rMQ=;
        b=fbkr86cSR8NaJDtv/GS3cAREq4eVZbA3mE0GJoR9ThlggBf7yA4DUUYevgbYdcZVEa
         2D2wUPzhEiJ5G/tCRNt8CfvJ4lxZIcZ6Bp2RLkuFK4zPOJ74NyBPeAYOnBz5mkWfKGLK
         pGeFKEoCSV1oOCFNNxzE9RvmOnalnN9/dFzjMvZKo0Mms/0+/MeSQAuTS5dWgHdz2cfn
         2iYgjY0lPZX6phY3ZE6/XPJdw2weCcEYxzxs7pPWf40Uk87RPLzJ7JJncJg4boKEJs5z
         pnw0FVpPUpj097752+ZPxhgjJ8m1rMVgsTOOY5xwgbtTnOwxWAQn/mtXJDRQFJuIUcLL
         Z72g==
X-Gm-Message-State: AFq9FYJd2HIR8V7M3zQet2iMpABOBlNEDratS1S+RiJkYn+/YYGsmBkl
	m6d+e/PYe/NUJU+UjAtCztaAQrgQSYnTCStOEj3qdrk1xx5xKvxGH2vH
X-Gm-Gg: AYBFou2w8QOSekfWGaydYYA0yuKyRzV7qGZ77/b5Ss6EejFtXR+bD7n1uIE4S8HI1xA
	rUWRbj5STh57fPMacTVXABnfNbfe2aZZvHcKjrVNG830Qd4Ih0r1G2g3uHK3Bh3ims3nIwQkgs0
	S6jjdV0EUG5kTApngHF+EGhQ0j9hvdR3dw9RmC6STyifQYDab0aMdM/XdULKdo8tkr3r9SxMVRI
	yBVhuU5cePtr0CAQybiMUqwLmGUO/3lmwke3dnFndL+IiVvDJGbadp4VIrIlLaxj+ou7o3l+Tw7
	DMmdsqFoU7eTyVufofzOBXZRzRm/T+H69b3KW0W8yClrE07KGU0XZT0eeFXEFJMgIy691ujdcb4
	EoTA9AcZvmOUb1AqBVhvZ8run8c0y8G9+01ymqNBcPZImeLk15EmbYq7mzWqDGF6f+OS6s46IbO
	fxkRTxv26qLl860UkjWunLfovOOsEzPxL9PGPPqpPUtbMBUbg3OurVa8MEPIO7FsQ/H8JTif+x0
	pXjWxxj9y3aZjK78cCbYcsRUU12qCTdWEDSYCng4K0R+/mtqKfRVkqxo25LnFUzvJDB/TDSLPt7
	fSJQpe7V1l+Gc6fFOz/sqyW4LxbesgTkfqMWEzTCiw==
X-Received: by 2002:a05:600c:6087:b0:49f:f099:6fb1 with SMTP id 5b1f17b1804b1-4ac17753befmr232386105e9.15.1793630854017;
        Mon, 02 Nov 2026 06:47:34 -0800 (PST)
Received: from penguin-ubuntu.lan ([2a00:23c6:6410:5d01:8464:9a6f:2d42:8827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe7700c3bsm254289965e9.0.2026.11.02.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:47:33 -0800 (PST)
From: Oxana Kharitonova <webprosto@gmail.com>
To: mic@digikod.net,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	gnoack@google.com,
	utilityemal77@gmail.com
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	webprosto@gmail.com,
	landlock@lists.linux.dev
Subject: [PATCH v2 2/4] Landlock: Enforce MAKE_REG for POSIX message queue creation
Date: Mon,  2 Nov 2026 14:45:58 +0000
Message-ID: <20261102144708.920232-3-webprosto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102144708.920232-1-webprosto@gmail.com>
References: <20261102144708.920232-1-webprosto@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

POSIX message queues are represented by files in the mqueue filesystem.
Landlock's existing READ_FILE and WRITE_FILE restrictions can deny
mq_open() through hook_file_open(). However, these checks occur after
queue creation, so mq_open() with O_CREAT may create a queue before
access is denied, leaving the queue behind despite the failed call.

Add an inode_create hook to enforce LANDLOCK_ACCESS_FS_MAKE_REG before
queue creation. Use the mqueue mount associated with the current IPC
namespace to construct the parent path. Opening an existing queue does
not require MAKE_REG.

Add selftests covering denied creation without leaving a queue behind,
explicitly allowed creation, opening existing queues when MAKE_REG is
denied, and existing read/write restrictions. Enable POSIX message queues
in the selftest configuration and link the tests with librt.

Document the creation and opening checks, including that a queue may
still remain if creation is allowed but the subsequent open is denied.

Signed-off-by: Oxana Kharitonova <webprosto@gmail.com>
---
 Documentation/userspace-api/landlock.rst      |  24 ++
 include/uapi/linux/landlock.h                 |   1 +
 security/landlock/fs.c                        |  31 +++
 security/landlock/fs.h                        |   6 +
 tools/testing/selftests/landlock/Makefile     |   4 +-
 tools/testing/selftests/landlock/config       |   1 +
 .../selftests/landlock/posix_mqueue_test.c    | 233 ++++++++++++++++++
 7 files changed, 298 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/posix_mqueue_test.c

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 3d45b956b640..1fb91884cb8a 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -458,6 +458,30 @@ OverlayFS layer will not restrict the resulted merged hierarchy, and vice versa.
 Landlock users should then only think about file hierarchies they want to allow
 access to, regardless of the underlying filesystem.
 
+POSIX message queues
+--------------------
+
+POSIX message queues are represented by regular files in the mqueue
+filesystem.  Opening a queue with :manpage:`mq_open(3)` is subject to
+``LANDLOCK_ACCESS_FS_READ_FILE`` and ``LANDLOCK_ACCESS_FS_WRITE_FILE``,
+according to the requested access mode, when these rights are handled by an
+enforced ruleset.  These checks also apply to opening queue files through a
+mounted mqueue filesystem with :manpage:`open(2)`.
+
+Creating a new queue with :manpage:`mq_open(3)` and ``O_CREAT`` is checked
+separately.  When an enforced ruleset handles
+``LANDLOCK_ACCESS_FS_MAKE_REG``, creation is denied unless an applicable
+filesystem rule allows this right on the queue's parent directory.  Such a
+rule can refer to the root of the mqueue filesystem for the calling process's
+IPC namespace, commonly mounted at ``/dev/mqueue``.  Opening an existing queue,
+including with ``O_CREAT``, does not require this right.
+
+The creation check occurs before the file-open check.  If creation is allowed
+but the subsequent read or write access check denies the open, the newly
+created queue remains even though :manpage:`mq_open(3)` fails.  In particular,
+handling only ``LANDLOCK_ACCESS_FS_READ_FILE`` or
+``LANDLOCK_ACCESS_FS_WRITE_FILE`` does not prevent queue creation.
+
 Inheritance
 -----------
 
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 24510e5d8479..04a18824c700 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -450,6 +450,7 @@ struct landlock_capability_attr {
  *   device.
  * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
  * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular file.
+ *   This also controls POSIX message queue creation with mq_open(3).
  *   This also guards the creation of whiteout objects as used in OverlayFS.
  * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX domain
  *   socket.
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 2ab67bcad198..d5dcb19d5eb1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -29,6 +29,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/net.h>
+#include <linux/nsproxy.h>
 #include <linux/path.h>
 #include <linux/pid.h>
 #include <linux/rcupdate.h>
@@ -1676,6 +1677,35 @@ static int hook_path_truncate(const struct path *const path)
 	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
+/*
+ * Unlike regular file creation, mq_open(2) calls vfs_mkobj() directly and
+ * therefore does not trigger the path_mknod hook.  Use the mqueuefs mount
+ * associated with the current IPC namespace to recover the parent path.
+ */
+static int hook_inode_create(struct inode *const dir,
+			     struct dentry *const dentry, const umode_t)
+{
+	struct ipc_namespace *ipc_ns;
+	struct vfsmount *mnt;
+	struct path parent;
+
+	if (!landlock_is_posix_mqueue_fs(dir))
+		return 0;
+
+	if (!current->nsproxy)
+		return 0;
+	ipc_ns = current->nsproxy->ipc_ns;
+	if (!ipc_ns)
+		return 0;
+	mnt = ipc_ns->mq_mnt;
+	if (WARN_ON_ONCE(!mnt || mnt->mnt_sb != dir->i_sb))
+		return 0;
+
+	parent.mnt = mnt;
+	parent.dentry = dentry->d_parent;
+	return current_check_access_path(&parent, LANDLOCK_ACCESS_FS_MAKE_REG);
+}
+
 /**
  * unmask_scoped_access - Remove access right bits in @masks in all layers
  *                        where @client and @server have the same domain
@@ -2084,6 +2114,7 @@ static void hook_file_free_security(struct file *file)
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
+	LSM_HOOK_INIT(inode_create, hook_inode_create),
 
 	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
 	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 50b3ddb8ac1c..05e36ef1acf7 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -14,6 +14,7 @@
 #include <linux/cleanup.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/ipc_namespace.h>
 #include <linux/rcupdate.h>
 
 #include "access.h"
@@ -144,6 +145,11 @@ landlock_inode(const struct inode *const inode)
 	return inode->i_security + landlock_blob_sizes.lbs_inode;
 }
 
+static inline bool landlock_is_posix_mqueue_fs(const struct inode *const inode)
+{
+	return inode->i_sb->s_magic == MQUEUE_MAGIC;
+}
+
 static inline struct landlock_superblock_security *
 landlock_superblock(const struct super_block *const superblock)
 {
diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index fc43225d319a..80da63f4251d 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -18,11 +18,11 @@ TEST_GEN_PROGS_EXTENDED := \
 	wait-pipe-sandbox
 
 # Short targets:
-$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
+$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread -lrt
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
 
 include ../lib.mk
 
 # Targets with $(OUTPUT)/ prefix:
-$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
+$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread -lrt
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 5568d7a4b2d7..7761916db48b 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -14,6 +14,7 @@ CONFIG_NET=y
 CONFIG_NET_NS=y
 CONFIG_OVERLAY_FS=y
 CONFIG_PID_NS=y
+CONFIG_POSIX_MQUEUE=y
 CONFIG_PROC_FS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_LANDLOCK=y
diff --git a/tools/testing/selftests/landlock/posix_mqueue_test.c b/tools/testing/selftests/landlock/posix_mqueue_test.c
new file mode 100644
index 000000000000..9a8b56e2dbda
--- /dev/null
+++ b/tools/testing/selftests/landlock/posix_mqueue_test.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Landlock tests - POSIX message queue filesystem access */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/landlock.h>
+#include <mqueue.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "common.h"
+
+static void set_mq_name(char *const name, const size_t size)
+{
+	snprintf(name, size, "/selftests-landlock-mq-tid%d", sys_gettid());
+}
+
+/* Denied creation must not leave a queue behind. */
+TEST(posix_mqueue_make_reg)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_REG,
+	};
+	char name[64];
+	int fd;
+
+	drop_caps(_metadata);
+	ASSERT_LT(0, snprintf(name, sizeof(name), "landlock-%d", getpid()));
+
+	/* Check that POSIX message queues are supported by the running kernel. */
+	fd = syscall(__NR_mq_open, name, O_CREAT | O_EXCL | O_RDONLY, 0600,
+		     NULL);
+	if (fd < 0 && errno == ENOSYS)
+		SKIP(return, "POSIX message queues are not supported");
+	ASSERT_LE(0, fd);
+	ASSERT_EQ(0, close(fd));
+	ASSERT_EQ(0, syscall(__NR_mq_unlink, name));
+
+	drop_access_rights(_metadata, &ruleset_attr);
+
+	EXPECT_EQ(-1, syscall(__NR_mq_open, name, O_CREAT | O_EXCL | O_RDONLY,
+			      0600, NULL));
+	EXPECT_EQ(EACCES, errno);
+
+	/* A denied mq_open() must not leave the message queue behind. */
+	EXPECT_EQ(-1, syscall(__NR_mq_unlink, name));
+	EXPECT_EQ(ENOENT, errno);
+}
+
+/*
+ * A process restricted by LANDLOCK_ACCESS_FS_MAKE_REG must still be able to
+ * create a POSIX message queue when this access right is explicitly allowed
+ * on the mqueue filesystem mounted at /dev/mqueue.
+ */
+TEST(posix_mqueue_make_reg_allowed)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_REG,
+	};
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_MAKE_REG,
+	};
+	char mq_name[NAME_MAX], mq_path[PATH_MAX];
+	int ruleset_fd;
+	int check_fd;
+	mqd_t mq;
+
+	drop_caps(_metadata);
+	set_mq_name(mq_name, sizeof(mq_name));
+	ASSERT_LT(0,
+		  snprintf(mq_path, sizeof(mq_path), "/dev/mqueue%s", mq_name));
+	mq_unlink(mq_name);
+
+	/* Makes sure the current IPC namespace is visible through this path. */
+	mq = mq_open(mq_name, O_CREAT | O_EXCL | O_RDONLY, 0600, NULL);
+	if (mq < 0 && errno == ENOSYS)
+		SKIP(return, "POSIX message queues are not supported");
+	ASSERT_LE(0, mq);
+	check_fd = open(mq_path, O_PATH | O_CLOEXEC);
+	if (check_fd < 0) {
+		EXPECT_EQ(0, mq_close(mq));
+		EXPECT_EQ(0, mq_unlink(mq_name));
+		SKIP(return,
+			   "/dev/mqueue is not mounted for this IPC namespace");
+	}
+	EXPECT_EQ(0, close(check_fd));
+	EXPECT_EQ(0, mq_close(mq));
+	EXPECT_EQ(0, mq_unlink(mq_name));
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	path_beneath.parent_fd = open("/dev/mqueue", O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &path_beneath, 0));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	mq = mq_open(mq_name, O_CREAT | O_EXCL | O_RDONLY, 0600, NULL);
+	ASSERT_LE(0, mq);
+	EXPECT_EQ(0, mq_close(mq));
+	EXPECT_EQ(0, mq_unlink(mq_name));
+}
+
+/*
+ * LANDLOCK_ACCESS_FS_MAKE_REG controls the creation of POSIX message queues,
+ * but must not prevent opening a queue that already exists.
+ */
+TEST(posix_mqueue_make_reg_existing)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_REG,
+	};
+	char existing_name[NAME_MAX], new_name[NAME_MAX];
+	mqd_t existing_mq, reopened_mq;
+
+	drop_caps(_metadata);
+	ASSERT_LT(0, snprintf(existing_name, sizeof(existing_name),
+			      "/selftests-landlock-mq-existing-tid%d",
+			      sys_gettid()));
+	ASSERT_LT(0,
+		  snprintf(new_name, sizeof(new_name),
+			   "/selftests-landlock-mq-new-tid%d", sys_gettid()));
+	mq_unlink(existing_name);
+	mq_unlink(new_name);
+
+	existing_mq =
+		mq_open(existing_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+	if (existing_mq < 0 && errno == ENOSYS)
+		SKIP(return, "POSIX message queues are not supported");
+	ASSERT_LE(0, existing_mq);
+
+	drop_access_rights(_metadata, &ruleset_attr);
+
+	reopened_mq = mq_open(existing_name, O_RDWR);
+	ASSERT_LE(0, reopened_mq);
+	EXPECT_EQ(0, mq_close(reopened_mq));
+
+	EXPECT_EQ(-1, mq_open(new_name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL));
+	EXPECT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, mq_close(existing_mq));
+	EXPECT_EQ(0, mq_unlink(existing_name));
+	EXPECT_EQ(-1, mq_unlink(new_name));
+	EXPECT_EQ(ENOENT, errno);
+}
+
+/* Filesystem rules must continue to restrict queue opens. */
+TEST(posix_mqueue_path_access)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE |
+				     LANDLOCK_ACCESS_FS_WRITE_FILE,
+	};
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	const int modes[] = { O_RDONLY, O_WRONLY, O_RDWR };
+	char name[NAME_MAX], path[PATH_MAX];
+	struct stat queue_stat, path_stat;
+	int ruleset_fd, fd;
+	mqd_t mq;
+
+	drop_caps(_metadata);
+	set_mq_name(name, sizeof(name));
+	ASSERT_LT(0, snprintf(path, sizeof(path), "/dev/mqueue%s", name));
+	mq_unlink(name);
+	mq = mq_open(name, O_CREAT | O_EXCL | O_RDWR, 0600, NULL);
+	if (mq < 0 && errno == ENOSYS)
+		SKIP(return, "POSIX message queues are not supported");
+	ASSERT_LE(0, mq);
+	ASSERT_EQ(0, fstat(mq, &queue_stat));
+	if (stat(path, &path_stat) || queue_stat.st_dev != path_stat.st_dev ||
+	    queue_stat.st_ino != path_stat.st_ino) {
+		EXPECT_EQ(0, mq_close(mq));
+		EXPECT_EQ(0, mq_unlink(name));
+		SKIP(return, "/dev/mqueue does not expose this IPC namespace");
+	}
+
+	/* Establish that ordinary permissions allow every tested open mode. */
+	for (size_t i = 0; i < ARRAY_SIZE(modes); i++) {
+		fd = open(path, modes[i] | O_CLOEXEC);
+		ASSERT_LE(0, fd);
+		EXPECT_EQ(0, close(fd));
+		fd = mq_open(name, modes[i]);
+		ASSERT_LE(0, fd);
+		EXPECT_EQ(0, mq_close(fd));
+	}
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	path_beneath.parent_fd = open("/dev/mqueue", O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &path_beneath, 0));
+	EXPECT_EQ(0, close(path_beneath.parent_fd));
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Allow reads through /dev/mqueue, but deny writes through both APIs. */
+	for (size_t i = 0; i < ARRAY_SIZE(modes); i++) {
+		fd = open(path, modes[i] | O_CLOEXEC);
+		if (modes[i] == O_RDONLY) {
+			EXPECT_LE(0, fd);
+		} else {
+			EXPECT_EQ(-1, fd);
+			EXPECT_EQ(EACCES, errno);
+		}
+		if (fd >= 0)
+			EXPECT_EQ(0, close(fd));
+
+		fd = mq_open(name, modes[i]);
+		if (modes[i] == O_RDONLY) {
+			EXPECT_LE(0, fd);
+		} else {
+			EXPECT_EQ(-1, fd);
+			EXPECT_EQ(EACCES, errno);
+		}
+		if (fd >= 0)
+			EXPECT_EQ(0, mq_close(fd));
+	}
+
+	EXPECT_EQ(0, mq_close(mq));
+	EXPECT_EQ(0, mq_unlink(name));
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0

