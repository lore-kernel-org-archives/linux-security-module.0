Received: from cvsmtppost18.nm.naver.com (cvsmtppost18.nm.naver.com [114.111.35.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45D365A19
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791023677; cv=none; b=UhU/PxxBR3fAXKg/GDaU0+elGAfWqwct6InWczXXsMXKWRBc6dQBPcB89zivpzvMQnDuSOcYtqNoEP+Jnhjo0a6utFqmmJEZh40WPbxVdacTMHCIlG/gH1pJqKnv4v7fG46RP1cl7tG593xA1q9pY7MrBeSBidRjWdE8foDkfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791023677; c=relaxed/simple;
	bh=xeUVj+JguwyFpIm/e7gV9dOobYdgKn3rQ2yopGM28pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9PCRfnasZd8pxnT1rj1nlysNLFZvDhcWLCjXguBtPCeRabTXnBnEpN8grMgObL64HWl+ngtxI9WCzMoxgu+m4kPQv2h8BkKSpENezKVEGL4pHpYxLsPIDvB15haTak8ri5fJl7jyn7QC89VljyrltVSkeSWu37gZmyKjaBMDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=OZ5yfCZ4; arc=none smtp.client-ip=114.111.35.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="OZ5yfCZ4"
Received: from cvsendbo008.nm ([10.112.24.37])
  by cvsmtppost18.nm.naver.com with ESMTP id WiZUOxtmTduuVY68FZ3AiQ
  for <linux-security-module@vger.kernel.org>;
  Sat, 03 Oct 2026 10:34:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791023673; bh=xeUVj+JguwyFpIm/e7gV9dOobYdgKn3rQ2yopGM28pw=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=OZ5yfCZ4HFVrbdWG46WTj/mr5Lh3RA1+j7aWu4crsnBhbytZW4zFYJzmKjgcoTq+x
	 nCmAYlZ+ikfiO110jcpsjdCW8lkahFBoCsaubMMtgGoM0xOhDGkaGHNJMT6dlg4tJ5
	 puGGmcIgip1SGUPaCtVqEs5b8QSgDEYdR7HMfbfsyrBKR49xqWusP+BdltHXbpnqfx
	 aKHV3I2wAovfeREi8yuE49TBQSFt2uKcxEb5cWmyj8F5QmhSYZktOlCCfPmPcuUXu1
	 2maS+sN2IfNimBZ3MoMlaE4LRzmTXqxP4ZLL9RlrNCvZXkpyaRQJZ07QEuWWEdVBwK
	 mK6GvpFvvYkTA==
X-Session-ID: v66onAbzQBej-BFg7G2i+w
X-Works-Send-Opt: O9RwpzGdjHmdKHFOMr39Ko3YKHmwKBmwFAbrFxKrKqEmjJkaBd9YKBmm
X-Works-Smtp-Source: AZKlaxglFqJZ+HmZFqUw+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp007.nm.naver.com with ESMTP id v66onAbzQBej-BFg7G2i+w
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 03 Oct 2026 10:34:32 -0000
From: tjdqudcks0424@naver.com
To: Micah Morton <mortonm@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Cc: James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Thomas Cedeno <thomascedeno@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [PATCH 2/2] selftests/safesetid: test GID policy with mismatched real IDs
Date: Sat,  3 Oct 2026 19:34:16 +0900
Message-ID: <899af06e29dd599246082096e27edd51eda1fb27.1791023194.git.tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791023194.git.tjdqudcks0424@naver.com>
References: <cover.1791023194.git.tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sung Byeongchan <tjdqudcks0424@naver.com>

The existing test uses equal numeric UID and GID values, so it cannot
distinguish which real ID SafeSetID uses as the source of a GID policy
lookup.

Add isolated child-process cases with real UID 1000, real GID 2000 and a
2000:2001 GID policy.  Verify that 2001 is allowed and 2002 is rejected
for both setresgid() and setgroups().  Each child retains only CAP_SETGID
in its permitted and effective sets, and pidfd polling bounds every case
without timing the transition.

On an affected kernel, the forbidden transitions survive and make the
test fail.  With the fix, SafeSetID terminates those children and the test
passes.

Assisted-by: OpenAI Codex
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/safesetid/Makefile    |   4 +-
 .../safesetid/safesetid-gid-policy-test.c     | 252 ++++++++++++++++++
 .../safesetid/safesetid-gid-policy-test.sh    |  11 +
 4 files changed, 266 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/safesetid/safesetid-gid-policy-test.c
 create mode 100755 tools/testing/selftests/safesetid/safesetid-gid-policy-test.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 7235a92ff879b..68b355ad33e0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24266,6 +24266,7 @@ M:	Micah Morton <mortonm@chromium.org>
 S:	Supported
 F:	Documentation/admin-guide/LSM/SafeSetID.rst
 F:	security/safesetid/
+F:	tools/testing/selftests/safesetid/
 
 SAMSUNG AUDIO (ASoC) DRIVERS
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
index e815bbf2d0f4a..1a4a6630858c0 100644
--- a/tools/testing/selftests/safesetid/Makefile
+++ b/tools/testing/selftests/safesetid/Makefile
@@ -3,7 +3,7 @@
 CFLAGS = -Wall -O2
 LDLIBS = -lcap
 
-TEST_PROGS := safesetid-test.sh
-TEST_GEN_FILES := safesetid-test
+TEST_PROGS := safesetid-test.sh safesetid-gid-policy-test.sh
+TEST_GEN_FILES := safesetid-test safesetid-gid-policy-test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/safesetid/safesetid-gid-policy-test.c b/tools/testing/selftests/safesetid/safesetid-gid-policy-test.c
new file mode 100644
index 0000000000000..873d65627c494
--- /dev/null
+++ b/tools/testing/selftests/safesetid/safesetid-gid-policy-test.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <grp.h>
+#include <linux/capability.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/capability.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#define TEST_UID 1000
+#define POLICY_GID 2000
+#define ALLOWED_GID 2001
+#define FORBIDDEN_GID 2002
+
+#define GID_POLICY_FILE \
+	"/sys/kernel/security/safesetid/gid_allowlist_policy"
+#define GID_POLICY "2000:2001\n"
+
+enum test_operation {
+	OP_SETRESGID,
+	OP_SETGROUPS,
+};
+
+static int install_policy(void)
+{
+	FILE *policy;
+	int ret = 0;
+
+	policy = fopen(GID_POLICY_FILE, "w");
+	if (!policy) {
+		perror("fopen gid policy");
+		return -1;
+	}
+	if (fputs(GID_POLICY, policy) == EOF) {
+		perror("write gid policy");
+		ret = -1;
+	}
+	if (fclose(policy)) {
+		perror("close gid policy");
+		ret = -1;
+	}
+	return ret;
+}
+
+static int retain_only_setgid(void)
+{
+	cap_value_t cap = CAP_SETGID;
+	cap_t caps;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps) {
+		perror("cap_get_proc");
+		return -1;
+	}
+	if (cap_clear(caps) ||
+	    cap_set_flag(caps, CAP_PERMITTED, 1, &cap, CAP_SET) ||
+	    cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, CAP_SET) ||
+	    cap_set_proc(caps)) {
+		perror("retain CAP_SETGID");
+		goto out;
+	}
+	ret = 0;
+out:
+	cap_free(caps);
+	return ret;
+}
+
+static int check_child_credentials(void)
+{
+	struct __user_cap_header_struct header = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3] = {};
+	uint64_t effective, permitted, inheritable;
+	uid_t ruid, euid, suid;
+	gid_t rgid, egid, sgid;
+	gid_t groups[2];
+	uint64_t expected = 1ULL << CAP_SETGID;
+	int i, ngroups;
+
+	if (getresuid(&ruid, &euid, &suid) ||
+	    getresgid(&rgid, &egid, &sgid)) {
+		perror("getresuid/getresgid");
+		return -1;
+	}
+	if (ruid != TEST_UID || euid != TEST_UID || suid != TEST_UID ||
+	    rgid != POLICY_GID || egid != POLICY_GID || sgid != POLICY_GID) {
+		fprintf(stderr, "unexpected child IDs\n");
+		return -1;
+	}
+
+	ngroups = getgroups(2, groups);
+	if (ngroups != 1 || groups[0] != POLICY_GID) {
+		fprintf(stderr, "unexpected initial supplementary groups\n");
+		return -1;
+	}
+	if (syscall(SYS_capget, &header, data)) {
+		perror("capget");
+		return -1;
+	}
+	effective = data[0].effective | ((uint64_t)data[1].effective << 32);
+	permitted = data[0].permitted | ((uint64_t)data[1].permitted << 32);
+	inheritable = data[0].inheritable | ((uint64_t)data[1].inheritable << 32);
+	if (effective != expected || permitted != expected || inheritable) {
+		fprintf(stderr, "child does not hold only CAP_SETGID\n");
+		return -1;
+	}
+	for (i = 0; i <= CAP_LAST_CAP; i++) {
+		if (prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET, i, 0, 0) != 0) {
+			fprintf(stderr, "unexpected ambient capability %d\n", i);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static int prepare_child(void)
+{
+	gid_t groups[] = { POLICY_GID };
+
+	if (setgroups(1, groups)) {
+		perror("initial setgroups");
+		return -1;
+	}
+	if (setresgid(POLICY_GID, POLICY_GID, POLICY_GID)) {
+		perror("setresgid policy source");
+		return -1;
+	}
+	if (prctl(PR_SET_KEEPCAPS, 1L)) {
+		perror("PR_SET_KEEPCAPS");
+		return -1;
+	}
+	if (setresuid(TEST_UID, TEST_UID, TEST_UID)) {
+		perror("setresuid test user");
+		return -1;
+	}
+	if (retain_only_setgid())
+		return -1;
+	return check_child_credentials();
+}
+
+static void run_child(enum test_operation operation, gid_t target)
+{
+	gid_t groups[] = { target };
+	int ret;
+
+	if (prepare_child())
+		_exit(2);
+
+	if (operation == OP_SETRESGID)
+		ret = setresgid(target, target, target);
+	else
+		ret = setgroups(1, groups);
+
+	if (ret) {
+		fprintf(stderr, "%s(%u) returned %s\n",
+			operation == OP_SETRESGID ? "setresgid" : "setgroups",
+			target, strerror(errno));
+		_exit(3);
+	}
+	_exit(0);
+}
+
+static int run_case(const char *name, enum test_operation operation,
+		    gid_t target, bool expect_kill)
+{
+	struct pollfd pollfd = {};
+	int status;
+	int pidfd;
+	pid_t child;
+
+	child = fork();
+	if (child < 0) {
+		perror("fork");
+		return -1;
+	}
+	if (!child)
+		run_child(operation, target);
+
+	pidfd = syscall(SYS_pidfd_open, child, 0);
+	if (pidfd < 0) {
+		perror("pidfd_open");
+		kill(child, SIGKILL);
+		waitpid(child, &status, 0);
+		return -1;
+	}
+	pollfd.fd = pidfd;
+	pollfd.events = POLLIN;
+	if (poll(&pollfd, 1, 5000) != 1) {
+		kill(child, SIGKILL);
+		waitpid(child, &status, 0);
+		close(pidfd);
+		fprintf(stderr, "not ok - %s (timeout)\n", name);
+		return -1;
+	}
+	close(pidfd);
+	if (waitpid(child, &status, 0) < 0) {
+		perror("waitpid");
+		return -1;
+	}
+
+	if (expect_kill) {
+		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
+			printf("ok - %s\n", name);
+			return 0;
+		}
+		fprintf(stderr, "not ok - %s (forbidden transition survived)\n",
+			name);
+		return -1;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		printf("ok - %s\n", name);
+		return 0;
+	}
+	fprintf(stderr, "not ok - %s (allowed transition failed)\n", name);
+	return -1;
+}
+
+int main(void)
+{
+	int failures = 0;
+
+	if (getuid()) {
+		fprintf(stderr, "must be run as root\n");
+		return 4;
+	}
+	if (install_policy())
+		return 1;
+
+	failures += run_case("allowed GID transition", OP_SETRESGID,
+			     ALLOWED_GID, false) != 0;
+	failures += run_case("forbidden GID transition", OP_SETRESGID,
+			     FORBIDDEN_GID, true) != 0;
+	failures += run_case("allowed supplementary group", OP_SETGROUPS,
+			     ALLOWED_GID, false) != 0;
+	failures += run_case("forbidden supplementary group", OP_SETGROUPS,
+			     FORBIDDEN_GID, true) != 0;
+
+	return failures ? 1 : 0;
+}
diff --git a/tools/testing/selftests/safesetid/safesetid-gid-policy-test.sh b/tools/testing/selftests/safesetid/safesetid-gid-policy-test.sh
new file mode 100755
index 0000000000000..7318ad3403121
--- /dev/null
+++ b/tools/testing/selftests/safesetid/safesetid-gid-policy-test.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ksft_skip=4
+
+if [ "$(id -u)" -ne 0 ]; then
+	echo "safesetid-gid-policy-test: must be run as root" >&2
+	exit "$ksft_skip"
+fi
+
+exec ./safesetid-gid-policy-test
-- 
2.43.0

