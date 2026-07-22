Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2135203A
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723412; cv=none; b=eY7+mhYrhY8IzuEBbt+dixtiyBgCYlfQ7FRnocQRsRtLh5+czFdHzeXQK8InZv/0r45QlthoquDaUqwdNN39znMjFvE7lxUp0zfJKkmF/fsHtwwCbvP9qpERQhpWbNyavY3OhUcVKOlBX7X49JfxpuOCux5HSXTzYqqHyy2DT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723412; c=relaxed/simple;
	bh=YR2dh10ivQfLZOGXOR0YDRUBJQfvgY5D+ot0FwvSBHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+HHadAHjnaQHF/hDIeqONt6Mfk8x2FaaiTh6C/IH6kUouBWdUvx7d4xXaFcz8lVQp8Aasxehamo2VBPCmMbmZ3g49S/erTTyJKP+eUaIJnfyikz7x+KE/I/G8r0++T6BxzMLJWplcqRsFreEQBtDr0EDwkX4Bl9MsA4vXId1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LvMoaC6F; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LvMoaC6F"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69ea0595598so4271390a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784723408; x=1785328208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pCH9TsY6JjijtowAyR28vJoTPq1XXv7UbsDDuJ5wjzE=;
        b=LvMoaC6FYktPJKtCVMEod50E1DExWVG/Alx7avZfHuSmArPvQfr9zQ2BvVu9OPi3Tq
         Tjs0u2Mfk5yhTSG5gWtAD0rZpSvtVsxMElAJK7fhSe9WUe8/WK77ithC4X8A8+ffCEp3
         CdHMl0WxXLA6t9SKI8mJFvrSCp8cbya3aDR/x/LAHkxcK0sIYHMUHzB+qi04tSIXP/J9
         j1a2eSVs3SMUeREoLeieh0h54GQgFGoLq30NUJ6b2PVOGb1ie1P4THkeXiOC5a7Gzlso
         4bVlrVRuePWffottrIiwUIDTMJovFxzZIykAlzkaF62oLrFkDko9U3wzSlH6Z4W+6K+4
         G/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723408; x=1785328208;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pCH9TsY6JjijtowAyR28vJoTPq1XXv7UbsDDuJ5wjzE=;
        b=l/f6JUCeQgkOG+eHuJekUWgqPiv08dfdBwgb7SESz2Bc7cqLuwu4ucRi2Gvr3OtIqd
         CxQxyaqALOysNoO1fgx7g+J4XLR3dmFFZ5rOCHpf/p5jjcxSHPJP17It0VZJG7cANLX7
         F6+DXdu/+jXe0zxEopi0czyGrra9YpP3GQ1Y30qZg/7/sRCry1jwLlSTM35/Pvsz5Gd5
         rsTGpJc4u5bMF95pKB8XAlUcEyHZzjE3C6S5T9cbu4MvgdVzv+dyYaG+dXhrP/TO2KQ+
         5QcOUJlR6Y0EAeX4KJoNEPU9kjm1505FGRDhLBip34EH7tVoZXUBJ3UfpveIXudSFuZN
         bN3g==
X-Forwarded-Encrypted: i=1; AHgh+Roj2o7SgRlEXn3yt8/EGlV/vlDM5R0vXIoVrMtnY374JT4ltAV6RM+OKyv4YrmvZ3037aYPyLvt7vRwjYOEkEK7Sj51zo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgjuphvIWp/YMqeOAFQc/Wx52dcAES05VIPE+jcbHhrQIVF6T
	WvTnqz7/3JDP4RfcrBB0yLFXhaTJPOutDkOIKLFQAIsKeRmDsfTsoIykRzEzFBR48oc=
X-Gm-Gg: AR+sD10nzhNGfrdwecPm7cVaf8Xioa7dppAi3XydyOB3n5DBf7fXoMThEtWA8gswaZo
	XFPxYeiZP3YerEpiF86T6/IL7Kgt+2cLV66vU59221quIIzvXrvNJU8EeX2BZ+ND2X4yOAeLUr3
	V2DvQqhcbGJuxFkX1+nuDcmHIHeh/6jQmXgDp1rHhJH/1BaZWog8AlBcgl3Y5nYgfLVJARFSMk3
	syjcuVOSSJOyGYhooUM8l45QT6mo+isXE1r0iEDrOpi1ybWaOEoMj2vJLSO4s4YsUdpBvKEre6H
	nx3eVU4l4H99kXMYQGHsNC5I9hHo+N7XTuQGDp2DgnfiZZgxLJJ9rEX6WDgoQ8u8jWPCXFgUGyA
	VzN4tiX7Rd4w82AOGlcbBL2bHNAKkDo4KUZKKlkFrqc0DI1hamulF4xv5JHBpS8Y=
X-Received: by 2002:a05:6402:4590:b0:69c:2ffe:114a with SMTP id 4fb4d7f45d1cf-69e65327a22mr7487794a12.39.1784723407932;
        Wed, 22 Jul 2026 05:30:07 -0700 (PDT)
Received: from DW927H4LGF ([2a09:bac6:37e6:1e5a::306:2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34f1b867sm835007a12.14.2026.07.22.05.30.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 05:30:06 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: paul@paul-moore.com,
	jmorris@namei.or,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	landlock@lists.linux.dev,
	oxana@cloudflare.com,
	webprosto@gmail.com
Subject: [PATCH 4/6] selftests/landlock: Test POSIX message queue scoping
Date: Wed, 22 Jul 2026 13:29:40 +0100
Message-ID: <20260722122952.42149-5-oxana@cloudflare.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722122952.42149-1-oxana@cloudflare.com>
References: <20260722122952.42149-1-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for LANDLOCK_SCOPE_POSIX_MSG_QUEUE.

Verify that opening a queue created outside the current scoped domain is
denied, and that opening a queue created within the same domain remains
allowed.

Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
---
 .../landlock/scoped_posix_msg_queue_test.c    | 223 ++++++++++++++++++
 .../testing/selftests/landlock/scoped_test.c  |   2 +-
 2 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c

diff --git a/tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c b/tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c
new file mode 100644
index 000000000000..602ba5c7a83d
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_posix_msg_queue_test.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - POSIX message queue scoping
+ *
+ * Copyright © 2024-2026 Microsoft Corporation
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/landlock.h>
+#include <mqueue.h>
+#include <stddef.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "common.h"
+#include "scoped_common.h"
+
+static void set_mq_name(char *const name, const size_t size)
+{
+	snprintf(name, size, "/selftests-landlock-mq-tid%d", sys_gettid());
+}
+
+FIXTURE(scoped_domains)
+{
+	char mq_name[NAME_MAX];
+};
+
+#include "scoped_base_variants.h"
+
+FIXTURE_SETUP(scoped_domains)
+{
+	drop_caps(_metadata);
+
+	set_mq_name(self->mq_name, sizeof(self->mq_name));
+	/* Removes a possibly stale queue from a previous run. */
+	mq_unlink(self->mq_name);
+}
+
+FIXTURE_TEARDOWN(scoped_domains)
+{
+}
+
+/*
+ * The parent creates the message queue, then the child tries
+ * to open it, with scoped domain(s) or no domain at all.
+ */
+TEST_F(scoped_domains, open_parent_queue)
+{
+	pid_t child;
+	int status;
+	int pipe_parent[2], pipe_child[2];
+	char buf;
+	mqd_t mq;
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	if (variant->domain_both)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		mqd_t mq_child;
+
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+
+		if (variant->domain_child)
+			create_scoped_domain(_metadata,
+					     LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+		/* Waits for the parent to create the queue. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+
+		mq_child = mq_open(self->mq_name, O_RDWR);
+		if (!variant->domain_child) {
+			EXPECT_LE(0, mq_child);
+			if (mq_child >= 0)
+				EXPECT_EQ(0, mq_close(mq_child));
+		} else {
+			EXPECT_EQ(-1, mq_child);
+			EXPECT_EQ(EPERM, errno);
+		}
+
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_child[1]));
+
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	mq = mq_open(self->mq_name, O_CREAT | O_RDWR, 0600, NULL);
+	ASSERT_LE(0, mq);
+
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(0, mq_close(mq));
+	EXPECT_EQ(0, mq_unlink(self->mq_name));
+
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * The child creates the message queue, then the parent tries
+ * to open it, with scoped domain(s) or no domain at all.
+ */
+TEST_F(scoped_domains, open_child_queue)
+{
+	pid_t child;
+	bool can_open_child_queue;
+	int status;
+	int pipe_parent[2], pipe_child[2];
+	char buf;
+	mqd_t mq;
+
+	can_open_child_queue = !variant->domain_parent;
+
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+
+	if (variant->domain_both)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		mqd_t mq_child;
+
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+
+		if (variant->domain_child)
+			create_scoped_domain(_metadata,
+					     LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+		/* Waits for the parent to be in a domain, if any. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+
+		mq_child = mq_open(self->mq_name, O_CREAT | O_RDWR, 0600, NULL);
+		ASSERT_LE(0, mq_child);
+
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
+		EXPECT_EQ(0, mq_close(mq_child));
+		EXPECT_EQ(0, mq_unlink(self->mq_name));
+		_exit(_metadata->exit_code);
+		return;
+	}
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	EXPECT_EQ(0, close(pipe_child[1]));
+
+	if (variant->domain_parent)
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	/* Signals that the parent is in a domain, if any. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	/* Waits for the child to create the queue. */
+	ASSERT_EQ(1, read(pipe_child[0], &buf, 1));
+
+	mq = mq_open(self->mq_name, O_RDWR);
+	if (can_open_child_queue) {
+		EXPECT_LE(0, mq);
+		if (mq >= 0)
+			EXPECT_EQ(0, mq_close(mq));
+	} else {
+		EXPECT_EQ(-1, mq);
+		EXPECT_EQ(EPERM, errno);
+	}
+
+	/* Signals to the child that the open attempt is done. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != EXIT_SUCCESS)
+		_metadata->exit_code = KSFT_FAIL;
+}
+
+/*
+ * A process must always be able to open a queue it created within its own
+ * domain, whatever the enforced scope is.
+ */
+TEST(create_and_open_same_domain)
+{
+	char mq_name[NAME_MAX];
+	mqd_t mq_create, mq_open_again;
+
+	drop_caps(_metadata);
+	set_mq_name(mq_name, sizeof(mq_name));
+	mq_unlink(mq_name);
+
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_POSIX_MSG_QUEUE);
+
+	mq_create = mq_open(mq_name, O_CREAT | O_RDWR, 0600, NULL);
+	ASSERT_LE(0, mq_create);
+
+	mq_open_again = mq_open(mq_name, O_RDWR);
+	EXPECT_LE(0, mq_open_again);
+	if (mq_open_again >= 0)
+		EXPECT_EQ(0, mq_close(mq_open_again));
+
+	EXPECT_EQ(0, mq_close(mq_create));
+	EXPECT_EQ(0, mq_unlink(mq_name));
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
index b90f76ed0d9c..c530baa50948 100644
--- a/tools/testing/selftests/landlock/scoped_test.c
+++ b/tools/testing/selftests/landlock/scoped_test.c
@@ -12,7 +12,7 @@
 
 #include "common.h"
 
-#define ACCESS_LAST LANDLOCK_SCOPE_SIGNAL
+#define ACCESS_LAST LANDLOCK_SCOPE_POSIX_MSG_QUEUE
 
 TEST(ruleset_with_unknown_scope)
 {
-- 
2.50.1 (Apple Git-155)

