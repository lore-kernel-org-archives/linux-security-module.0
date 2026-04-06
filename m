Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF9381B0C
	for <linux-security-module@vger.kernel.org>; Mon,  6 Apr 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486273; cv=none; b=XdO3pMhspPj3kYet1Kd3vhb8iRv4ALSJDbODYCKY8LDIBnU9V3QsIapv5kogyEvaxC6SRG1qAWTykFvLjmTVB3hcNCO92O/aj0ifKLz3zNmmDMofWM/cIiuflex7881A5ci+Gp5r1JUYt3lJ12ja7mGTh6+ky19vu5UUyaYrm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486273; c=relaxed/simple;
	bh=3WnWjGxYjlF24q4xn9P+3gP+4KOW7GXRj9gwS/cvLm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0/LBoGyPSneAteFbmary4yMjlT84S1Dby5zgx965+/oO5glJlP8A6VGyf3YuDP7Hjcq1ghOCGgdOR1+/phJ4hfpFwp2be2sIz7mIGS3dHKgxRM+6higssIn8KSFB3eWWzW06qdImPEZMB4joDyVR1dm6qmXyJl3OpTv00k0t1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RTvhhMBK; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RTvhhMBK"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqBkb3bmkzWbw;
	Mon,  6 Apr 2026 16:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775486263;
	bh=WLe9eShLgNZ2pLa1h/bSEvitEy+z+ip1jg6elbYRUAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTvhhMBKwy9I/0tC/rNnb8G17g6SvCuWGzstAgWvcKjD8UoRX4OjCAmW/9UNTrTvc
	 zNFYTCU3aDY2SB7Tcbcr4SMe2FR5oiZhLj1zC7y4sBRQd4Lcu40ZR5ApNd3r6QqkHT
	 3IMyQfHJEhPIFQJ6F77W3XNt1dS+WhcJ9ZcBIFFw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqBkZ5hynzFy6;
	Mon,  6 Apr 2026 16:37:42 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 14/17] selftests/landlock: Add filesystem tracepoint tests
Date: Mon,  6 Apr 2026 16:37:12 +0200
Message-ID: <20260406143717.1815792-15-mic@digikod.net>
In-Reply-To: <20260406143717.1815792-1-mic@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add filesystem-specific trace tests in a dedicated test file, following
the same pattern as audit tests which live alongside the functional
tests for each subsystem.

Tests in trace_fs_test.c verify that:
- landlock_add_rule_fs events fire with correct path and fields,
- landlock_check_rule_fs events fire when rules match during pathwalk
  and do not fire for unhandled access types,
- landlock_deny_access_fs events fire on denied accesses,
- nested domains produce both check_rule and deny_access events,
- no trace events fire without a Landlock sandbox (unsandboxed
  baseline).

Add trace_layout1 fixture tests in fs_test.c for field verification
(check_rule_fs_fields) and multi-rule pathwalk
(check_rule_fs_multiple_rules) that reuse the layout1 filesystem
hierarchy.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
- New patch.
---
 tools/testing/selftests/landlock/fs_test.c    | 218 ++++++++++
 .../selftests/landlock/trace_fs_test.c        | 390 ++++++++++++++++++
 2 files changed, 608 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/trace_fs_test.c

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cdb47fc1fc0a..8f1ab43a07a0 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -44,6 +44,9 @@
 
 #include "audit.h"
 #include "common.h"
+#include "trace.h"
+
+#define TRACE_TASK "fs_test"
 
 #ifndef renameat2
 int renameat2(int olddirfd, const char *oldpath, int newdirfd,
@@ -7764,4 +7767,219 @@ TEST_F(audit_layout1, mount)
 	EXPECT_EQ(1, records.domain);
 }
 
+/* clang-format off */
+FIXTURE(trace_layout1) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_layout1)
+{
+	struct stat st;
+
+	/*
+	 * Check tracefs availability before creating the layout, following the
+	 * layout3_fs pattern: skip before any layout creation to avoid leaving
+	 * stale TMP_DIR on skip.
+	 */
+	if (stat(TRACEFS_LANDLOCK_DIR, &st)) {
+		self->tracefs_ok = 0;
+		SKIP(return, "tracefs not available");
+	}
+	self->tracefs_ok = 1;
+
+	/* Isolate tracefs state (PID filter, event enables). */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, unshare(CLONE_NEWNS));
+	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	prepare_layout(_metadata);
+	create_layout1(_metadata);
+
+	set_cap(_metadata, CAP_DAC_OVERRIDE);
+	ASSERT_EQ(0, tracefs_fixture_setup());
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	ASSERT_EQ(0, tracefs_set_pid_filter(getpid()));
+	clear_cap(_metadata, CAP_DAC_OVERRIDE);
+}
+
+FIXTURE_TEARDOWN_PARENT(trace_layout1)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_DAC_OVERRIDE);
+	tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, false);
+	tracefs_clear_pid_filter();
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_DAC_OVERRIDE);
+
+	remove_layout1(_metadata);
+	cleanup_layout(_metadata);
+}
+
+/*
+ * Verifies that check_rule_fs events include correct field values: domain, dev,
+ * ino, request, and allowed.  All values are verified against stat() of the
+ * rule path on a deterministic tmpfs layout.
+ */
+TEST_F(trace_layout1, check_rule_fs_fields)
+{
+	struct stat dir_stat;
+	char expected_dev[32];
+	char expected_ino[32];
+	char expected_req[32];
+	char *buf;
+	char field[64];
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	ASSERT_EQ(0, stat(dir_s1d1, &dir_stat));
+	snprintf(expected_dev, sizeof(expected_dev), "%u:%u",
+		 major(dir_stat.st_dev), minor(dir_stat.st_dev));
+	snprintf(expected_ino, sizeof(expected_ino), "%lu", dir_stat.st_ino);
+	snprintf(expected_req, sizeof(expected_req), "0x%x",
+		 (unsigned int)LANDLOCK_ACCESS_FS_READ_DIR);
+
+	set_cap(_metadata, CAP_DAC_OVERRIDE);
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_DAC_OVERRIDE);
+
+	sandbox_child_fs_access(_metadata, dir_s1d1,
+				LANDLOCK_ACCESS_FS_READ_DIR,
+				LANDLOCK_ACCESS_FS_READ_DIR, dir_s1d1);
+
+	set_cap(_metadata, CAP_DAC_OVERRIDE);
+	buf = tracefs_read_trace();
+	clear_cap(_metadata, CAP_DAC_OVERRIDE);
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(1,
+		  tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK)))
+	{
+		TH_LOG("Expected 1 check_rule_fs event\n%s", buf);
+	}
+
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
+					   "dev", field, sizeof(field)));
+	EXPECT_STREQ(expected_dev, field)
+	{
+		TH_LOG("Expected dev=%s, got %s", expected_dev, field);
+	}
+
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
+					   "ino", field, sizeof(field)));
+	EXPECT_STREQ(expected_ino, field)
+	{
+		TH_LOG("Expected ino=%s, got %s", expected_ino, field);
+	}
+
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
+					   "request", field, sizeof(field)));
+	EXPECT_STREQ(expected_req, field)
+	{
+		TH_LOG("Expected request=%s, got %s", expected_req, field);
+	}
+
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
+					   "allowed", field, sizeof(field)));
+	EXPECT_EQ('{', field[0])
+	{
+		TH_LOG("Expected allowed={...}, got %s", field);
+	}
+
+	free(buf);
+}
+
+/*
+ * Verifies check_rule_fs behavior with multiple rules.  With rules at s1d1 and
+ * s1d2 (a child of s1d1), accessing s1d2 produces only 1 event because the
+ * pathwalk short-circuits after the first rule fully unmasks the single layer.
+ */
+TEST_F(trace_layout1, check_rule_fs_multiple_rules)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+	int count;
+
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+
+	set_cap(_metadata, CAP_DAC_OVERRIDE);
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_DAC_OVERRIDE);
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		struct landlock_path_beneath_attr path_beneath = {
+			.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		int ruleset_fd, fd;
+
+		ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		path_beneath.parent_fd =
+			open(dir_s1d1, O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0)
+			_exit(1);
+		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				      &path_beneath, 0))
+			_exit(1);
+		close(path_beneath.parent_fd);
+
+		path_beneath.parent_fd =
+			open(dir_s1d2, O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0)
+			_exit(1);
+		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				      &path_beneath, 0))
+			_exit(1);
+		close(path_beneath.parent_fd);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, 0))
+			_exit(1);
+		close(ruleset_fd);
+
+		fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (fd >= 0)
+			close(fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	set_cap(_metadata, CAP_DAC_OVERRIDE);
+	buf = tracefs_read_trace();
+	clear_cap(_metadata, CAP_DAC_OVERRIDE);
+	ASSERT_NE(NULL, buf);
+
+	/*
+	 * Only 1 check_rule_fs event: the rule on dir_s1d2 fully unmasked the
+	 * single layer, so the pathwalk short-circuits before reaching the
+	 * dir_s1d1 rule.
+	 */
+	count = tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
+	EXPECT_EQ(1, count)
+	{
+		TH_LOG("Expected 1 check_rule_fs event, got %d\n%s", count,
+		       buf);
+	}
+
+	free(buf);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/trace_fs_test.c b/tools/testing/selftests/landlock/trace_fs_test.c
new file mode 100644
index 000000000000..60ed63aea049
--- /dev/null
+++ b/tools/testing/selftests/landlock/trace_fs_test.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Filesystem tracepoints
+ *
+ * Copyright © 2026 Cloudflare
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "common.h"
+#include "trace.h"
+
+#define TRACE_TASK "trace_fs_test"
+
+/* clang-format off */
+FIXTURE(trace_fs) {
+	/* clang-format on */
+	int tracefs_ok;
+};
+
+FIXTURE_SETUP(trace_fs)
+{
+	int ret;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, unshare(CLONE_NEWNS));
+	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
+
+	ret = tracefs_fixture_setup();
+	if (ret) {
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+		self->tracefs_ok = 0;
+		SKIP(return, "tracefs not available");
+	}
+	self->tracefs_ok = 1;
+
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_DENY_ACCESS_FS_ENABLE, true));
+	ASSERT_EQ(0, tracefs_clear());
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(trace_fs)
+{
+	if (!self->tracefs_ok)
+		return;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, false);
+	tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, false);
+	tracefs_enable_event(TRACEFS_DENY_ACCESS_FS_ENABLE, false);
+	tracefs_fixture_teardown();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+/*
+ * Baseline: verifies that without Landlock, the operation succeeds and no
+ * check_rule or deny_access trace events fire.
+ */
+TEST_F(trace_fs, unsandboxed)
+{
+	char *buf;
+	int count, status, fd;
+	pid_t pid;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		/*
+		 * No sandbox: verify that a normal FS access does not produce
+		 * Landlock trace events.
+		 */
+		fd = open("/usr", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (fd >= 0)
+			close(fd);
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
+	EXPECT_EQ(0, count);
+	count = tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK));
+	EXPECT_EQ(0, count);
+
+	free(buf);
+}
+
+/*
+ * Verifies that adding a filesystem rule emits a landlock_add_rule_fs trace
+ * event with the expected path and field values: ruleset ID is non-zero,
+ * access_rights is non-zero, and path matches.
+ */
+TEST_F(trace_fs, add_rule_fs)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE |
+				     LANDLOCK_ACCESS_FS_WRITE_FILE |
+				     LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	char *buf, field_buf[64];
+	int ruleset_fd, count;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	path_beneath.parent_fd = open("/usr", O_PATH | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &path_beneath, 0));
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_ADD_RULE_FS(TRACE_TASK));
+	EXPECT_EQ(1, count)
+	{
+		TH_LOG("Expected 1 add_rule_fs event, got %d\n%s", count, buf);
+	}
+
+	/* Ruleset ID should be non-zero. */
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_ADD_RULE_FS(TRACE_TASK),
+					   "ruleset", field_buf,
+					   sizeof(field_buf)));
+	EXPECT_STRNE("0", field_buf);
+
+	/* Access rights should be non-zero. */
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_ADD_RULE_FS(TRACE_TASK),
+					   "access_rights", field_buf,
+					   sizeof(field_buf)));
+	EXPECT_STRNE("0x0", field_buf);
+
+	/* Path should be /usr. */
+	ASSERT_EQ(0,
+		  tracefs_extract_field(buf, REGEX_ADD_RULE_FS(TRACE_TASK),
+					"path", field_buf, sizeof(field_buf)));
+	EXPECT_STREQ("/usr", field_buf);
+
+	free(buf);
+}
+
+/*
+ * Verifies that an allowed access emits check_rule events (rule matched during
+ * pathwalk) but does NOT emit deny_access events (no denial).
+ */
+TEST_F(trace_fs, allowed_access)
+{
+	char *buf, field_buf[64];
+	int count;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	/* Rule allows READ_DIR for /usr, access /usr which is allowed. */
+	sandbox_child_fs_access(_metadata, "/usr", LANDLOCK_ACCESS_FS_READ_DIR,
+				LANDLOCK_ACCESS_FS_READ_DIR, "/usr");
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
+	EXPECT_LE(1, count);
+
+	/* Single-layer allowed array: {0x<mask>}. */
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
+					   "allowed", field_buf,
+					   sizeof(field_buf)));
+	EXPECT_EQ('{', field_buf[0]);
+
+	count = tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK));
+	EXPECT_EQ(0, count);
+
+	free(buf);
+}
+
+/*
+ * Verifies that accessing a path whose access type is not in the handled set
+ * does not emit landlock_check_rule events.  The ruleset handles READ_FILE,
+ * but the directory open checks READ_DIR which is unhandled; Landlock has no
+ * opinion and no rule evaluation occurs.
+ */
+TEST_F(trace_fs, check_rule_unhandled)
+{
+	char *buf;
+	int count;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	/* Handles READ_FILE only; READ_DIR is unhandled. */
+	sandbox_child_fs_access(_metadata, "/usr", LANDLOCK_ACCESS_FS_READ_FILE,
+				LANDLOCK_ACCESS_FS_READ_FILE, "/tmp");
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	/* No check_rule events because READ_DIR is not in the handled set. */
+	count = tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
+	EXPECT_EQ(0, count);
+
+	free(buf);
+}
+
+/*
+ * Verifies that nested domains (child sandboxed under a parent domain) emit
+ * check_rule events from both layers and produce a deny_access event when the
+ * inner domain's rule does not cover the access.
+ */
+TEST_F(trace_fs, check_rule_nested)
+{
+	char *buf, field_buf[64], *comma;
+	size_t first_len, second_len;
+	int count_rule, count_access, status;
+	pid_t pid;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+
+	if (pid == 0) {
+		struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		struct landlock_path_beneath_attr path_beneath = {
+			.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
+		};
+		int ruleset_fd, fd;
+
+		/* First layer: allow /usr. */
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		path_beneath.parent_fd =
+			open("/usr", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+
+		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				      &path_beneath, 0)) {
+			close(path_beneath.parent_fd);
+			close(ruleset_fd);
+			_exit(1);
+		}
+		close(path_beneath.parent_fd);
+
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(ruleset_fd, 0)) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+		close(ruleset_fd);
+
+		/* Second layer: also allow /usr. */
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		if (ruleset_fd < 0)
+			_exit(1);
+
+		path_beneath.parent_fd =
+			open("/usr", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (path_beneath.parent_fd < 0) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+
+		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				      &path_beneath, 0)) {
+			close(path_beneath.parent_fd);
+			close(ruleset_fd);
+			_exit(1);
+		}
+		close(path_beneath.parent_fd);
+
+		if (landlock_restrict_self(ruleset_fd, 0)) {
+			close(ruleset_fd);
+			_exit(1);
+		}
+		close(ruleset_fd);
+
+		/* Access /usr which is allowed by both layers. */
+		fd = open("/usr", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (fd >= 0)
+			close(fd);
+
+		/* Access /tmp which has no rule in either layer. */
+		fd = open("/tmp", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (fd >= 0)
+			close(fd);
+
+		_exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count_rule =
+		tracefs_count_matches(buf, REGEX_CHECK_RULE_FS(TRACE_TASK));
+	EXPECT_LE(1, count_rule);
+
+	/*
+	 * Both layers have the same rule, so the allowed array must
+	 * have two identical entries: {0x<mask>,0x<mask>}.
+	 */
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CHECK_RULE_FS(TRACE_TASK),
+					   "allowed", field_buf,
+					   sizeof(field_buf)));
+	comma = strchr(field_buf, ',');
+	EXPECT_NE(0, !!comma);
+	if (comma) {
+		/*
+		 * Verify both entries are identical: compare the
+		 * substring before the comma with the substring after
+		 * it (stripping the braces).
+		 */
+		first_len = comma - field_buf - 1;
+		second_len = strlen(comma + 1) - 1;
+		EXPECT_EQ(first_len, second_len);
+		EXPECT_EQ(0, strncmp(field_buf + 1, comma + 1, first_len));
+	}
+
+	count_access =
+		tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK));
+	EXPECT_LE(1, count_access);
+
+	free(buf);
+}
+
+/*
+ * Verifies that a denied FS access emits a landlock_deny_access_fs trace event
+ * with the blocked access and path.
+ */
+TEST_F(trace_fs, deny_access_fs_denied)
+{
+	char *buf;
+	int count;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	/*
+	 * Rule allows READ_DIR for /usr, but access /tmp which has no rule.
+	 * READ_DIR access to /tmp is denied by absence and should emit a
+	 * deny_access_fs event.
+	 */
+	sandbox_child_fs_access(_metadata, "/usr", LANDLOCK_ACCESS_FS_READ_DIR,
+				LANDLOCK_ACCESS_FS_READ_DIR, "/tmp");
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	count = tracefs_count_matches(buf, REGEX_DENY_ACCESS_FS(TRACE_TASK));
+	EXPECT_LE(1, count);
+
+	free(buf);
+}
+
+TEST_HARNESS_MAIN
-- 
2.53.0

