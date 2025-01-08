Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0E204F9D
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351074; cv=none; b=AJIgUINQZ4MWQgMyHRRqUMl7SOwRJnrDnbYsYBVYorcaRdV3Ka+7fjF9XzOfZJTm8r/s8faE9MB6w+Ojj6t3XoLXzzaM6eJ872oaTC2U7BUzsApxROGe5VXxOklrsm4bylJYu+w0dOCQyXKknv5TcTW6lAgMFI94XI9JD/gyPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351074; c=relaxed/simple;
	bh=rRI8LbrBzwR4fcqUqJs4Ps+5BiqPPIchEI6A5hDhvaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rk2x7dVtqxiimNJDMZXWumTjTFNsX41vhx0ERIhi4rbAog8tZzqGbY2eNhVRdIcyKrP2xkNMDTgXdsEb59WmhdByBQD1lbeDzYhgvXx0qDClmkLhrwg3Nfn+vFcTdJ04UKmL0B1YPhKY2+Ovudq4V2QkqcJ3c0jcFGiMZfwylu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UPj50DYz; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UPj50DYz"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfk637nzCmL;
	Wed,  8 Jan 2025 16:44:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351070;
	bh=VLMZtzr5LWcOJwkntjfxNmwyBvU1kjIGz9Bzgk8Ku5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPj50DYzQ6ArLkY5rGrskIcWN11x8usKFPRjOqd096YaC565e+jZxhVLV5JZHQPu1
	 AU+uJK5XjuCMGo5bjIdnbW01yzRoa+omnjc+sRgxat4G0B4MCReHF1p+i0vKHYQqG7
	 ucold4Vn05shnAz4PseNKaQ1i5pOl1qQEo9JuYBs=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfj6sb5ztDK;
	Wed,  8 Jan 2025 16:44:29 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 29/30] selftests/landlock: Test audit rule with AUDIT_EXE_LANDLOCK_DOM
Date: Wed,  8 Jan 2025 16:43:37 +0100
Message-ID: <20250108154338.1129069-30-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add audit_rule.exe_landlock_domain tests to filter Landlock denials
according to the binary that created the sandbox.

The wait-pipe.c test program is updated to sandbox itself and send a
(denied) signal to its parent.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-30-mic@digikod.net
---

Changes since v3:
- New patch.
---
 tools/testing/selftests/landlock/audit.h      |   1 +
 tools/testing/selftests/landlock/audit_test.c | 153 ++++++++++++++++++
 tools/testing/selftests/landlock/wait-pipe.c  |  30 +++-
 3 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 37979a62478c..fba96123776c 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -140,6 +140,7 @@ static int audit_filter_exe(const int audit_fd,
 
 	switch (filter->record_type) {
 	case AUDIT_EXE:
+	case AUDIT_EXE_LANDLOCK_DENY:
 		break;
 	default:
 		return -EINVAL;
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index d5330e843395..921f316ddbf8 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -7,7 +7,9 @@
 
 #define _GNU_SOURCE
 #include <errno.h>
+#include <limits.h>
 #include <linux/landlock.h>
+#include <stdlib.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/types.h>
@@ -33,6 +35,22 @@ static int matches_log_umount(struct __test_metadata *const _metadata,
 				  REGEX_LANDLOCK_PREFIX " blockers=.*");
 }
 
+static int matches_log_signal(struct __test_metadata *const _metadata,
+			      int audit_fd, const pid_t opid)
+{
+	static const char log_template[] = REGEX_LANDLOCK_PREFIX
+		" blockers=scope.signal opid=%d ocomm=\"audit_test\"$";
+	char log_match[sizeof(log_template) + 10];
+	int log_match_len;
+
+	log_match_len =
+		snprintf(log_match, sizeof(log_match), log_template, opid);
+	if (log_match_len > sizeof(log_match))
+		return -E2BIG;
+
+	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DENY, log_match);
+}
+
 FIXTURE(audit)
 {
 	struct audit_filter audit_filter;
@@ -155,4 +173,139 @@ TEST_F(audit, fs_deny)
 		_metadata->exit_code = KSFT_FAIL;
 }
 
+FIXTURE(audit_rule)
+{
+	struct audit_filter audit_filter_main, audit_filter_test;
+	int audit_fd;
+};
+
+FIXTURE_VARIANT(audit_rule)
+{
+	const bool with_exe_landlock_deny_child;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_rule, exe_landlock_deny_child) {
+	/* clang-format on */
+	.with_exe_landlock_deny_child = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(audit_rule, exe_landlock_deny_parent) {
+	/* clang-format on */
+	.with_exe_landlock_deny_child = false,
+};
+
+FIXTURE_SETUP(audit_rule)
+{
+	const char *path = NULL;
+
+	disable_caps(_metadata);
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+
+	if (variant->with_exe_landlock_deny_child)
+		/* Filter on the sandboxer instead of the current exe. */
+		path = bin_wait_pipe;
+
+	self->audit_fd = audit_init();
+	EXPECT_LE(0, self->audit_fd)
+	{
+		const char *error_msg;
+
+		/* kill "$(auditctl -s | sed -ne 's/^pid \([0-9]\+\)$/\1/p')" */
+		if (self->audit_fd == -EEXIST)
+			error_msg = "socket already in use (e.g. auditd)";
+		else
+			error_msg = strerror(-self->audit_fd);
+		TH_LOG("Failed to initialize audit: %s", error_msg);
+	}
+
+	/* Applies main filter for the test task. */
+	EXPECT_EQ(0, audit_init_filter_exe(AUDIT_EXE, &self->audit_filter_main,
+					   bin_wait_pipe));
+	EXPECT_EQ(0, audit_filter_exe(self->audit_fd, &self->audit_filter_main,
+				      AUDIT_ADD_RULE, AUDIT_FILTER_EXCLUDE));
+
+	/* Applies test filter for the test task or the current task. */
+	EXPECT_EQ(0, audit_init_filter_exe(AUDIT_EXE_LANDLOCK_DENY,
+					   &self->audit_filter_test, path));
+	EXPECT_EQ(0, audit_filter_exe(self->audit_fd, &self->audit_filter_test,
+				      AUDIT_ADD_RULE, AUDIT_FILTER_EXCLUDE));
+
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+}
+
+FIXTURE_TEARDOWN(audit_rule)
+{
+	set_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, audit_filter_exe(self->audit_fd, &self->audit_filter_main,
+				      AUDIT_DEL_RULE, AUDIT_FILTER_EXCLUDE));
+	EXPECT_EQ(0, audit_filter_exe(self->audit_fd, &self->audit_filter_test,
+				      AUDIT_DEL_RULE, AUDIT_FILTER_EXCLUDE));
+	clear_cap(_metadata, CAP_AUDIT_CONTROL);
+	EXPECT_EQ(0, close(self->audit_fd));
+}
+
+TEST_F(audit_rule, exe_landlock_deny)
+{
+	struct audit_records records;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+	pid_t child;
+	int status;
+
+	ASSERT_EQ(0, pipe2(pipe_child, 0));
+	ASSERT_EQ(0, pipe2(pipe_parent, 0));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char pipe_child_str[12], pipe_parent_str[12];
+		char *const argv[] = { (char *)bin_wait_pipe, pipe_child_str,
+				       pipe_parent_str, NULL };
+
+		/* Passes the pipe FDs to the executed binary. */
+		EXPECT_EQ(0, close(pipe_child[0]));
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		snprintf(pipe_child_str, sizeof(pipe_child_str), "%d",
+			 pipe_child[1]);
+		snprintf(pipe_parent_str, sizeof(pipe_parent_str), "%d",
+			 pipe_parent[0]);
+
+		ASSERT_EQ(0, execve(argv[0], argv, NULL))
+		{
+			TH_LOG("Failed to execute \"%s\": %s", argv[0],
+			       strerror(errno));
+		};
+		_exit(1);
+		return;
+	}
+
+	EXPECT_EQ(0, close(pipe_child[1]));
+	EXPECT_EQ(0, close(pipe_parent[0]));
+
+	/* Waits for the child. */
+	EXPECT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+
+	/* Tests that there was no denial until now. */
+	audit_count_records(self->audit_fd, &records);
+	EXPECT_EQ(0, records.deny);
+
+	/* Signals the child to terminate. */
+	EXPECT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	/* Tests that the audit record only matches the child. */
+	if (variant->with_exe_landlock_deny_child) {
+		EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd,
+						getpid()));
+	} else {
+		audit_count_records(self->audit_fd, &records);
+		EXPECT_EQ(0, records.deny);
+	}
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(0, WEXITSTATUS(status));
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/wait-pipe.c b/tools/testing/selftests/landlock/wait-pipe.c
index 0dbcd260a0fa..153f8ca93ac6 100644
--- a/tools/testing/selftests/landlock/wait-pipe.c
+++ b/tools/testing/selftests/landlock/wait-pipe.c
@@ -2,20 +2,31 @@
 /*
  * Write in a pipe and wait.
  *
- * Used by layout1.umount_sandboxer from fs_test.c
+ * Used by layout1.umount_sandboxer from fs_test.c and
+ * audit_rule.exe_landlock_deny from audit_test.c
  *
  * Copyright © 2024-2025 Microsoft Corporation
  */
 
 #define _GNU_SOURCE
+#include <linux/landlock.h>
+#include <linux/prctl.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/prctl.h>
 #include <unistd.h>
 
+#include "wrappers.h"
+
 int main(int argc, char *argv[])
 {
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.scoped = LANDLOCK_SCOPE_SIGNAL,
+	};
 	int pipe_child, pipe_parent;
 	char buf;
+	int ruleset_fd;
 
 	/* The first argument must be the file descriptor number of a pipe. */
 	if (argc != 3) {
@@ -26,6 +37,20 @@ int main(int argc, char *argv[])
 	pipe_child = atoi(argv[1]);
 	pipe_parent = atoi(argv[2]);
 
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	if (ruleset_fd < 0) {
+		perror("Failed to create a ruleset");
+		return 1;
+	}
+
+	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	if (landlock_restrict_self(ruleset_fd, 0)) {
+		perror("Failed to restrict self");
+		return 1;
+	}
+	close(ruleset_fd);
+
 	/* Signals that we are waiting. */
 	if (write(pipe_child, ".", 1) != 1) {
 		perror("Failed to write to first argument");
@@ -38,5 +63,8 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	/* Tries to send a signal. */
+	kill(getppid(), 0);
+
 	return 0;
 }
-- 
2.47.1

