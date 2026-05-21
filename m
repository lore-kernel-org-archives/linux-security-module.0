Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110583806A1
	for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379626; cv=none; b=MpDjz3+GxmB9hJx9nqpEoB9Bf/Uk5xsnOf8zRfsEMMlcaZcIaIEnYAXlVkWzSSkNIW63hOvJX54DJwo8yXWoPHajuxiYJEiBVej6KjxJYp/zA14M8x3b+OfOHWcB+MSHbfC3ASgZJ6sZ7MCRcB9QEsLsyQpg5bhJ90ULrEbc7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379626; c=relaxed/simple;
	bh=whrwT3HhWF0Ebe/bAs4ZKqpJW/GfCpqxzvntHp4HO+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNwViCmYI+BkG8Vy5Fp7ipcT13fyAaA0U3fmi5ZQN1bO4Qzpl36+AAgovw9+IL3dnyzZrjoOlbwG17+qMVLR6n0DSYJNk5mL42j/7NtePHIfya8WZdvfxJYa8PMti2dDGtkom/RJeRfnehkKH78TwJtq45VRilw5Pk95F3gsHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBXAuup6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBXAuup6"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7cb345cb5bfso50251627b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2026 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779379624; x=1779984424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQfsrKNUiX8+vgtzK0jnEN51Eri0U4Ru/qmwjetQ71E=;
        b=YBXAuup6v5fNGljXMX+rRysABmTztyuF95wWu+B7H0k8Y/p+WGjvEG5q5e/z+bEFNy
         mN7wVx/YAZBqghidpqFd1vc5b67YRamILDLQV5QwuzPTsit2UNJlDPimkDxxIzFpjn/G
         Ao+PtbY/BNeMLF8LXIgK+WKFCRY/O/TQMtZOUiubfq9Gc5OUqA46KSKSy2rOHwB/l+jb
         7FXVg5JC+a752dpi8K0CrN2KYmXdXFjQfyyOKAcsxcSkdYWBdggEvgbX8dDerZ2jTJpF
         ziD97tbZWyqwjKZ6vvX7QrDx9d22tXmR90JHAaS4AQ+/Nkd2Nv3LC0qpvRM8oq9RTZX7
         F6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779379624; x=1779984424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQfsrKNUiX8+vgtzK0jnEN51Eri0U4Ru/qmwjetQ71E=;
        b=VvyZhS0v0DJ4OtREj2iTaeVegYSeEQJX3OROWbOE8siJM4wkRt2XBOI+X9/8A6GOSg
         G9uBFyjQ8dv8ldOjeTka5V+kRv54agLy79HfGfO3f4VGP6fC5jwJAZdHEkBycbDvHuvK
         EM/0Tq7kizfGO1WRCN2DwUV7nzhXfFxsEXei/QS6hcpm45B7de56G8JE6KQjc4DwoYUe
         9Kur7/1hPUsf8qFmpN1LOTeJszPlb153BR0JSH2RMbR/22UJBEOJfhsaVi6CLIiHcWj0
         ZgMA82QhafbogeHr5sl0Vb/mvaCH/bZDNx9kvteengLUanAw0bIeoR1S+0ALmRgIRks1
         ssiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Ldh8kW3anZvJxFVkJUaGS/m1t808sL7Cj/LvluH6dBWAmivxo+u/uxqKGErrn+ZtrGpurjpctA70O3/xv7tU2P1XXGoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymIIYHOjdLnghrM5rlpo48CR4jlzc/0IN5IjSJBZ3L8SpcCWJM
	+lYLgnacgAjwyreHjex7tI3lpV+dj5kXM6x7jpxglb3/p5f30p+fCEWz
X-Gm-Gg: Acq92OFF9SArpi7py03yzYyvYFy8SiAf1XRHVLPIwnws5/YJJbj0UsgAN13MN8/GA+X
	0aEy5/ug8XWFgnYRnMAsvfQYRTkX9nV8uJPUz2gJEJmzVRCSE4BIItSJ5wy1fcF3x2gCc04jiTh
	TnHvSWqGybHR0NZaefbOgQMGvaVUawPeaxEp5mSnLo0E5aiYSEpemWbimMrRHi6OzWoas+8E6RR
	5NWSq75QLPWfnOvpEm83tCEs7uX8h/klxtVrvGP2BbMzQE2vpwfsqRL2P+1iZ/Aop9KDwTOflnS
	/1A5rmdGU8QKCGZ7WD/iBo5iPuCUeosnaeAHfkyrcHr+rZbbEwuU7BhutT8vOOu8QuPPBz9yuct
	xb+S0kumBnj4IuLNHbTBSsnw+jL+K0Lh/EMHxHEp8b186nXKkMXPCvHjwgC8v2DtycKI2fYDdSg
	Jf1uAAw9a10VHX+5c9GTpO8aFpvIu8NqT0HLCkVNYjy+7D01mA4jughgR9RDOVoCQ/yb8F+5U=
X-Received: by 2002:a05:690c:c245:b0:7bd:73f3:7a59 with SMTP id 00721157ae682-7d20cb38001mr37733757b3.27.1779379624129;
        Thu, 21 May 2026 09:07:04 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:c2cf:2e92:9a48:97a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2c7abad87sm4657587b3.2.2026.05.21.09.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:07:03 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH 4/6] selftests/landlock: Test LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Date: Thu, 21 May 2026 12:06:38 -0400
Message-ID: <20260521160640.1716746-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521160640.1716746-1-utilityemal77@gmail.com>
References: <20260521160640.1716746-1-utilityemal77@gmail.com>
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

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../landlock/scoped_sysv_msg_queue_test.c     | 256 ++++++++++++++++++
 1 file changed, 256 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c

diff --git a/tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c b/tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
new file mode 100644
index 000000000000..41f99803b593
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
@@ -0,0 +1,256 @@
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
+/* clang-format off */
+FIXTURE(scoped_domains) {};
+/* clang-format on */
+
+#include "scoped_base_variants.h"
+
+FIXTURE_SETUP(scoped_domains)
+{
+	drop_caps(_metadata);
+}
+
+FIXTURE_TEARDOWN(scoped_domains)
+{
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
+	int msqid = -1;
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
+	msqid = msgget(key, IPC_CREAT | IPC_EXCL | 0600);
+	ASSERT_LE(0, msqid);
+
+	/* Releases the child. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	EXPECT_EQ(0, close(pipe_parent[1]));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	cleanup_msg_queue(msqid);
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
+/* clang-format off */
+FIXTURE(scoping_msg_ops) {};
+/* clang-format on */
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
+	drop_caps(_metadata);
+}
+
+FIXTURE_TEARDOWN(scoping_msg_ops)
+{
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
+	int msqid, ret = 0;
+	key_t key;
+
+	key = (key_t)(getpid() & 0x7fffffff);
+	cleanup_msg_queue(msgget(key, 0));
+
+	msqid = msgget(key, IPC_CREAT | IPC_EXCL | 0600);
+	ASSERT_LE(0, msqid);
+
+	/* Preloads a message so msgrcv(2) would otherwise succeed. */
+	ASSERT_EQ(0, msgsnd(msqid, &msg, sizeof(msg.mtext), 0));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SYSV_MSG_QUEUE);
+
+		switch (variant->op) {
+		case MSG_OP_SND:
+			ret = msgsnd(msqid, &msg, sizeof(msg.mtext), 0);
+			break;
+		case MSG_OP_RCV:
+			ret = msgrcv(msqid, &msg, sizeof(msg.mtext), 0,
+				     IPC_NOWAIT);
+			break;
+		case MSG_OP_CTL:
+			ret = msgctl(msqid, IPC_STAT, &ds);
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
+	cleanup_msg_queue(msqid);
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+TEST_HARNESS_MAIN
-- 
2.53.0

