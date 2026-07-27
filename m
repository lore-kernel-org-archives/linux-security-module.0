Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83DB3ED109
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193732; cv=none; b=NmUDs+0omzExEWkslmqF+lt8R2vaB5aM5xZv4GKzHLUd6lWYMjhCx2st3qAlGCUbVNjdiSknrt2zq1AiHR+R+H7XbHMbYc8iSQAYgxS2VVOmIXLoQkjhdpNilzWy4u5TPj38b5y2Z0OvYqIAa0xwXKuJuVEo/2OtSHPJ2UXJ6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193732; c=relaxed/simple;
	bh=kCiXNdgH77wQYZu6b4KVIwv3eFmTLTCCq+mLw7HjKIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tONDI1rWA+cLPx4thCZkUzw5iLBXPWj0GtAeR6mRobd1doK7RK39X1uxFcwA0xedzMnGfv2FWE20yHwWiv4BGVDKpCKVR5nEXIsVwTY3dL1k87f3R6DZrUu14mrgSeAe65aYuHTN4Zp3zCYhx1rLmo02TjoYUvtswWo7AMA9frQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy73tIl2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy73tIl2"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8111c0c7561so30984967b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785193728; x=1785798528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9C4SWOs1WBQLQtm2p9OO9AdTM755l1mYDQTVGolQq0=;
        b=Zy73tIl2jeiPdpK0QbgRHBVaZQRVRvQnaj9C5OXYTfTyFWNgOaJyyUuj291X+Vej3W
         S60+DcuhXuTw54Qjtiyi3Vr9JrSwY+adLqUM2ieyOfW9KskYlC0OSdhacVLNooj0Dk0J
         SPPnf0Na5jGwqgc2wrsa8dHZiNL17jDVfgviRjIfnRT6ewuoxxWmiiSNg83LYTqvZ8mq
         hxS3QBtHgSe0qIhVBQapqQCO9s45s7qaeLQZPB9MhtI6o7mB9G+ZgG9nyhiPaZC3eb6A
         b/Ovo3IlPrHsrXKg9CV/cwXzj39ZmYesErrTHZnFsHuvb6DZ+WBDLqQyxbtv2KzqlRVI
         1qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785193728; x=1785798528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+9C4SWOs1WBQLQtm2p9OO9AdTM755l1mYDQTVGolQq0=;
        b=oUlFzNsdwniz1VRdvpy9vwEW6dI+i3Zi7Oj6cFC34qoBcj50HLg4jxHojtD117l3f5
         2/evGtnINRUtA4HxCM1oa+ApYP/u3xdLbYfjC8JMw9raHHe5z6c9Y83GyohQBdY2fJ9c
         bj84MtAmJbmMFbW7mtVHg4cAYD5CHpgNehVV9Wm5ITV/vbl9os/GZF7f4dCjLYmpxtVE
         vfr82c1C3xLswce2o005No9fHWM0PlYuxjs7MOfp3S88u6KtpjFhCahw7a8xOGUuP1o6
         Lx/qiApp++Om9Q2wmQ8Fi8SCSvz2h5IpmAjPnilK+bbj24N6pxH2Hqn3YjOXSxdAQXAE
         ezTw==
X-Forwarded-Encrypted: i=1; AHgh+RpGMgf5NIq5PWFLx3b1LG+QSR1uN+418MI7MMhHRNKvfsWaWpLn30SyDHCke2tSeGcGFU4RtPpn7JE0kneJ3tghb5gDxsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMbmWk2g+tjChRrPo6/QbFttO9TzJczyFJbO4ba7fxxKdtFL5J
	j14aimho0onViuDV91g4MjQ0VshBKr7QBQDT9uf511ASVlF5MO3gfs/S
X-Gm-Gg: AR+sD11IIfz6jGK07KUWQWKeFa8pHGqyjkvpf9sgmp0nad2aS4Srf9OHaA9V6YDLNd5
	xtZWYpNhUuQmPqLieb7pQwgwwCYwrZ1wHRVcKMNX7sWK0odF6LuL1FbNgJ5lZvtPykXAOZeTqpU
	7AKaB4CTFl76f3+6JFXz/jlGRlYyYRMhpLgRE3YOUX+9G29MnKtjgNsSrBShIHkJzYXL124XcvC
	f0ptvQKe2LFMBECuyRR2dFKXl5zdSsFODEkH9lEbq75IKKpJ/sqH0f+TmHtj4Wo2cSaSbMAUqIw
	j1ckGTvGcUQiJsm62YaXN/AIb8JLZ2nArXpApYYmoAvH756ntATJEGWJPotsfm0dpRPtFpcJymL
	7UyF7E/8kr/AqWPXat2mu44uzJo+CrvL+kJlKZBXm6G+PiyXFk+k8ghLBPr9HkibPfmSqstnYvn
	WDydnjqSwy5OLrssDv8NXOQ9Kt56HmW0BNRl9x
X-Received: by 2002:a05:690c:3389:b0:81e:f5ac:e40 with SMTP id 00721157ae682-81f93966a5dmr7107347b3.20.1785193728403;
        Mon, 27 Jul 2026 16:08:48 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:732e:7f3e:f365:cf9a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65931411sm38644837b3.44.2026.07.27.16.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:08:47 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 4/6] selftests/landlock: Test LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Date: Mon, 27 Jul 2026 19:08:31 -0400
Message-ID: <20260727230833.138165-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727230833.138165-1-utilityemal77@gmail.com>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for SysV message queue scoped right.

Use the existing scoped domain harness for msgget, and another fixture
for testing msgsnd, msgrcv and msgctl.

Pass the msqid around for coverage of non-msgget syscalls, since calling
msgget while already restricted would fail and prevent testing the
operation under test.

Denials are checked against -EACCES rather than -EPERM: msgget,
msgsnd, msgrcv and msgctl(IPC_STAT) all reach the Landlock scope
check via ipcperms(), whose callers map every non-zero return into
-EACCES before propagating it to user space.

Track the created msqid in the fixture and remove it from
FIXTURE_TEARDOWN_PARENT() so that queues are reclaimed even when a
failed assertion aborts a test, and so that the removal is never
subject to the scoping under test.

Also add CONFIG_SYSVIPC to the selftest config fragment since the new
test requires SysV IPC support.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/config       |   1 +
 .../landlock/scoped_sysv_msg_queue_test.c     | 265 ++++++++++++++++++
 2 files changed, 266 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c

diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 8fe9b461b1fd..8acb03464df4 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -15,5 +15,6 @@ CONFIG_SECURITY=y
 CONFIG_SECURITY_LANDLOCK=y
 CONFIG_SHMEM=y
 CONFIG_SYSFS=y
+CONFIG_SYSVIPC=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_XATTR=y
diff --git a/tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c b/tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
new file mode 100644
index 000000000000..91a560c957e6
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - SysV Message Queue Scoping
+ *
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "common.h"
+#include "scoped_common.h"
+
+/*
+ * Removes the message queue identified by @msqid, ignoring any error since
+ * the caller might no longer have permission to operate on it (for example,
+ * after entering a scoped domain).
+ */
+static void cleanup_msg_queue(int msqid)
+{
+	if (msqid >= 0)
+		msgctl(msqid, IPC_RMID, NULL);
+}
+
+FIXTURE(scoped_domains)
+{
+	int msqid;
+};
+
+#include "scoped_base_variants.h"
+
+FIXTURE_SETUP(scoped_domains)
+{
+	self->msqid = -1;
+	drop_caps(_metadata);
+}
+
+/*
+ * The queue is removed by the (never sandboxed) test harness parent, which
+ * also runs when an assertion aborts the test after the queue got created.
+ */
+FIXTURE_TEARDOWN_PARENT(scoped_domains)
+{
+	cleanup_msg_queue(self->msqid);
+}
+
+/*
+ * Parent creates a SysV message queue, then the child tries to associate
+ * with it via msgget(2).  When the child is in a domain that scopes message
+ * queues and the parent is not in that same scope, the association must be
+ * denied with -EACCES (msgget runs the scope check via ipcperms(), which
+ * masks every denial as -EACCES).
+ */
+TEST_F(scoped_domains, check_access_msg_queue)
+{
+	pid_t child;
+	int status;
+	int pipe_parent[2], pipe_child[2];
+	char buf;
+	key_t key;
+	bool can_associate;
+
+	/*
+	 * The child can associate with the parent's queue unless the child
+	 * is in a scoped domain that does not include the parent (i.e. the
+	 * parent is outside the child's domain).
+	 */
+	can_associate = !variant->domain_child;
+
+	/*
+	 * Picks a per-test key derived from PID to avoid collisions.  Stale
+	 * queues from a previous run are unlikely but handled by removing
+	 * any matching entry before applying any scope.
+	 */
+	key = (key_t)(getpid() & 0x7fffffff);
+	cleanup_msg_queue(msgget(key, 0));
+
+	if (variant->domain_both)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SYSV_MSG_QUEUE);
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int ret;
+
+		EXPECT_EQ(0, close(pipe_child[0]));
+		EXPECT_EQ(0, close(pipe_parent[1]));
+
+		if (variant->domain_child)
+			create_scoped_domain(_metadata,
+					     LANDLOCK_SCOPE_SYSV_MSG_QUEUE);
+
+		/* Signals readiness to the parent. */
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		EXPECT_EQ(0, close(pipe_child[1]));
+
+		/* Waits for the parent to have created the queue. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+		EXPECT_EQ(0, close(pipe_parent[0]));
+
+		ret = msgget(key, 0);
+		if (can_associate) {
+			ASSERT_LE(0, ret);
+		} else {
+			ASSERT_EQ(-1, ret);
+			/*
+			 * msgget uses ipcperms(), which masks every LSM
+			 * denial as -EACCES regardless of the value the
+			 * LSM hook returns.
+			 */
+			ASSERT_EQ(EACCES, errno);
+		}
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_child[1]));
+	EXPECT_EQ(0, close(pipe_parent[0]));
+
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SYSV_MSG_QUEUE);
+
+	/* Waits for the child to be ready. */
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+	EXPECT_EQ(0, close(pipe_child[0]));
+
+	self->msqid = msgget(key, IPC_CREAT | IPC_EXCL | 0600);
+	ASSERT_LE(0, self->msqid);
+
+	/* Releases the child. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * The msg_queue_associate hook (exercised by msgget(2)) is covered by the
+ * scoped_domains fixture above.  The remaining hooks all funnel through the
+ * same scope check, so it suffices to verify that each operation is denied
+ * when the child is scoped relative to the queue's creator.
+ *
+ * To attribute a denial to the operation under test (and not to a preceding
+ * msgget(2) call), the parent creates the queue and the child inherits the
+ * msqid across fork(2), bypassing msg_queue_associate.
+ */
+enum msg_op {
+	MSG_OP_SND,
+	MSG_OP_RCV,
+	MSG_OP_CTL,
+};
+
+FIXTURE(scoping_msg_ops)
+{
+	int msqid;
+};
+
+FIXTURE_VARIANT(scoping_msg_ops)
+{
+	enum msg_op op;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(scoping_msg_ops, msgsnd) {
+	/* clang-format on */
+	.op = MSG_OP_SND,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(scoping_msg_ops, msgrcv) {
+	/* clang-format on */
+	.op = MSG_OP_RCV,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(scoping_msg_ops, msgctl) {
+	/* clang-format on */
+	.op = MSG_OP_CTL,
+};
+
+FIXTURE_SETUP(scoping_msg_ops)
+{
+	self->msqid = -1;
+	drop_caps(_metadata);
+}
+
+/* See the scoped_domains teardown comment. */
+FIXTURE_TEARDOWN_PARENT(scoping_msg_ops)
+{
+	cleanup_msg_queue(self->msqid);
+}
+
+TEST_F(scoping_msg_ops, deny_op)
+{
+	struct msgbuf {
+		long mtype;
+		char mtext[1];
+	} msg = { .mtype = 1 };
+	struct msqid_ds ds;
+	pid_t child;
+	int status;
+	int ret = 0;
+
+	/*
+	 * The child inherits the msqid across fork(2), so no key is needed:
+	 * IPC_PRIVATE always creates a new queue and cannot collide with
+	 * queues left over by other processes.
+	 */
+	self->msqid = msgget(IPC_PRIVATE, 0600);
+	ASSERT_LE(0, self->msqid);
+
+	/* Preloads a message so msgrcv(2) would otherwise succeed. */
+	ASSERT_EQ(0, msgsnd(self->msqid, &msg, sizeof(msg.mtext), 0));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SYSV_MSG_QUEUE);
+
+		switch (variant->op) {
+		case MSG_OP_SND:
+			ret = msgsnd(self->msqid, &msg, sizeof(msg.mtext), 0);
+			break;
+		case MSG_OP_RCV:
+			ret = msgrcv(self->msqid, &msg, sizeof(msg.mtext), 0,
+				     IPC_NOWAIT);
+			break;
+		case MSG_OP_CTL:
+			ret = msgctl(self->msqid, IPC_STAT, &ds);
+			break;
+		}
+		ASSERT_EQ(-1, ret);
+		/*
+		 * msgsnd, msgrcv and msgctl(IPC_STAT) all reach the
+		 * Landlock scope check via ipcperms(), whose callers map
+		 * any non-zero return into -EACCES before propagating it
+		 * to user space.
+		 */
+		ASSERT_EQ(EACCES, errno);
+
+		_exit(_metadata->exit_code);
+		return;
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+TEST_HARNESS_MAIN
-- 
2.54.0

