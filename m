Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611596;
	b=yChl27orv5PTTCwzffq2LXbxoYwmdfM55FbvT769sBpxzcCzVGv8kZRFoliLipbZdDEf
	 ZpomwdN6KIBoGzhLvqU7AQknsO9t3JIk62kPtHhVaY5Y5QHj7e0GbQnXx0GvsUfJXP48y
	 knTxpx555sgZmqKejjENiaRu5c3usw/gkCPZzI/coANB/37I4LmihvasV/MeocTGj1901
	 mNWoBmoK7f1Vu4aY+8zFkeslpq9WI63HLZRIqL/88vvHDC/jVIgl9ee1yGi5aeW/VaYnb
	 UmRzfTfL6eXOeoLm/cenQEHHUY/Lju3oAsefehQY5LOlrdQcQUKlrMISxLpvirjPLgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611596;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/mt+7nuVQGrYozknf2XUwcFfXbuBs5LtNKRc7KPnnio=;
	b=YwCgQvB1uVGq3BqGbhVwsATFIzFtDbglTn+W9hGOOXEjEKcJwNpsA2emlNC+Tt6PQdeb
	 3PD/P3PiBcbR8ei9JqOLJ1SgFevpCg/hXT+nFNV1fcdxN5gk8BfmkXxpjgtvetNBpCwP9
	 3zGwjbNq5haeEtj8RFKqvv3maFWtquIDd5faVkLpLNYYkLCx6zyhUOimvs0oYZG2SMrR6
	 IUSmT2NMAYRytGJEZu5y9ae/nmSD9RFxPRddMPsTsbPug4OkFJHNHkK8ARZvQbTr2hcry
	 JFJEtQcUQKHTYhpRy/G79h1dQYfLNU+BbuIHu9Bivwxhe+Gx9Oi1eWV2AgbFN/1WJeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A6606A337;
	Wed, 25 Nov 2026 12:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 456A6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 179dd762e8d011f19a56ed5b684f684d-20261125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cdc74b46-94c7-4a7a-908b-a04eea103f17,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.19,REQID:cdc74b46-94c7-4a7a-908b-a04eea103f17,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:7db8b62,CLOUDID:a0bc9538acb8d741b6838ddb03c106d5,BulkI
	D:261125205949SDLJMHN3,BulkQuantity:0,SF:17|19|66|78|81|82|101|102|127|153
	|850|865|898|915,TC:nil,Content:0|15|50|99|300|350,EDM:-3,IP:-2,URL:99|1,F
	ile:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
	,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 179dd762e8d011f19a56ed5b684f684d-20261125
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 865892915; Wed, 25 Nov 2026 20:59:47 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 1/2] selftests/yama: add ptrace_scope selftests
Date: Wed, 25 Nov 2026 07:59:43 -0500
Message-ID: <20261125125944.1768182-2-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125125944.1768182-1-maguicai@kylinos.cn>
References: <20261125125944.1768182-1-maguicai@kylinos.cn>
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

Yama has no selftest coverage.  Add a selftests/yama
directory covering the ptrace_scope sysctl and its attach rules.

Test the sysctl access rules (EACCES for unprivileged writers, EPERM
for UID 0 without CAP_SYS_PTRACE, EINVAL for out-of-range values).
The PTRACE_ATTACH and PTRACE_TRACEME matrix for scopes 0, 1 and 2
covers parent to child, child to parent, unprivileged siblings, a
CAP_SYS_PTRACE holder tracing a non-descendant, and children asking
an unprivileged or CAP_SYS_PTRACE parent to trace them.

Scope 3 denies every attach and is irreversible until reboot, so it
is only tested when already active or when YAMA_TEST_NO_ATTACH=1
opts in.

Every forked helper reports readiness once its credentials are in
place, and the parent waits for that before any ptrace attempt, so
no result depends on child scheduling.  Privileged cases are skipped
when the capability set does not allow them, so the tests also run
in restricted environments.

Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/yama/.gitignore       |   2 +
 tools/testing/selftests/yama/Makefile         |  11 +
 tools/testing/selftests/yama/common.h         | 233 +++++++++
 tools/testing/selftests/yama/config           |   4 +
 .../selftests/yama/ptrace_scope_test.c        | 452 ++++++++++++++++++
 7 files changed, 704 insertions(+)
 create mode 100644 tools/testing/selftests/yama/.gitignore
 create mode 100644 tools/testing/selftests/yama/Makefile
 create mode 100644 tools/testing/selftests/yama/common.h
 create mode 100644 tools/testing/selftests/yama/config
 create mode 100644 tools/testing/selftests/yama/ptrace_scope_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d738990161bd..aacab71a5400 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30887,6 +30887,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/admin-guide/LSM/Yama.rst
 F:	security/yama/
+F:	tools/testing/selftests/yama/
 
 YAML NETLINK (YNL)
 M:	Donald Hunter <donald.hunter@gmail.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 07c3719f8b04..1f83d2ddd2eb 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -150,6 +150,7 @@ TARGETS += mm
 TARGETS += vfio
 TARGETS += x86
 TARGETS += x86/bugs
+TARGETS += yama
 TARGETS += zram
 #Please keep the TARGETS list alphabetically sorted
 # Run "make quicktest=1 run_tests" or
diff --git a/tools/testing/selftests/yama/.gitignore b/tools/testing/selftests/yama/.gitignore
new file mode 100644
index 000000000000..6ffe677a8695
--- /dev/null
+++ b/tools/testing/selftests/yama/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+ptrace_scope_test
diff --git a/tools/testing/selftests/yama/Makefile b/tools/testing/selftests/yama/Makefile
new file mode 100644
index 000000000000..f0dd1ed89d20
--- /dev/null
+++ b/tools/testing/selftests/yama/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# First run: make -C ../../../.. headers_install
+
+CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
+
+LOCAL_HDRS += common.h
+
+TEST_GEN_PROGS := ptrace_scope_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/yama/common.h b/tools/testing/selftests/yama/common.h
new file mode 100644
index 000000000000..80d2b9427d25
--- /dev/null
+++ b/tools/testing/selftests/yama/common.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Shared helpers for the Yama selftests.
+ */
+#ifndef YAMA_COMMON_H
+#define YAMA_COMMON_H
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/capability.h>
+#include <linux/prctl.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/ptrace.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#define YAMA_SYSCTL_PATH "/proc/sys/kernel/yama/ptrace_scope"
+#define UNPRIV_UID 65534
+
+/* Matches the enum in security/yama/yama_lsm.c. */
+enum yama_scope {
+	YAMA_SCOPE_DISABLED = 0,
+	YAMA_SCOPE_RELATIONAL,
+	YAMA_SCOPE_CAPABILITY,
+	YAMA_SCOPE_NO_ATTACH,
+};
+
+/* ---- ptrace_scope sysctl ---- */
+
+static inline int read_ptrace_scope(int *scope)
+{
+	char buf[16];
+	char *end;
+	long val;
+	ssize_t n;
+	int fd;
+	int rc;
+
+	fd = open(YAMA_SYSCTL_PATH, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	n = read(fd, buf, sizeof(buf) - 1);
+	rc = n < 0 ? -errno : 0;
+	close(fd);
+	if (rc)
+		return rc;
+	buf[n] = '\0';
+
+	errno = 0;
+	val = strtol(buf, &end, 10);
+	if (errno || end == buf || (*end != '\n' && *end != '\0'))
+		return -EINVAL;
+	*scope = (int)val;
+	return 0;
+}
+
+static inline int write_ptrace_scope_str(const char *str)
+{
+	size_t len = strlen(str);
+	ssize_t n;
+	int fd;
+	int rc;
+
+	fd = open(YAMA_SYSCTL_PATH, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+	n = write(fd, str, len);
+	rc = n < 0 ? -errno : (n == (ssize_t)len ? 0 : -EIO);
+	close(fd);
+	return rc;
+}
+
+static inline int write_ptrace_scope(int scope)
+{
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "%d\n", scope);
+	return write_ptrace_scope_str(buf);
+}
+
+/* ---- capabilities ---- */
+
+/* Check the effective capability mask of the current task. */
+static inline bool has_cap(int cap)
+{
+	struct __user_cap_header_struct hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3] = {};
+
+	if (syscall(__NR_capget, &hdr, data) < 0)
+		return false;
+	return data[CAP_TO_INDEX(cap)].effective & CAP_TO_MASK(cap);
+}
+
+static inline bool has_cap_sys_ptrace(void)
+{
+	return has_cap(CAP_SYS_PTRACE);
+}
+
+/*
+ * Test children drop to UNPRIV_UID, which a UID 0 task can only do
+ * with CAP_SETUID and CAP_SETGID (containers often run UID 0 with a
+ * reduced capability set).
+ */
+static inline bool can_drop_unpriv(void)
+{
+	return geteuid() != 0 ||
+	       (has_cap(CAP_SETUID) && has_cap(CAP_SETGID));
+}
+
+/* The CAP_SYS_PTRACE cases need the capability and droppable children. */
+static inline bool can_test_cap_ptrace(void)
+{
+	return geteuid() == 0 && has_cap_sys_ptrace() && can_drop_unpriv();
+}
+
+/* ---- credentials ---- */
+
+static inline int set_caps_mask(uint32_t mask)
+{
+	struct __user_cap_header_struct hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3] = {};
+
+	data[0].effective = mask;
+	data[0].permitted = mask;
+	if (syscall(__NR_capset, &hdr, data) < 0)
+		return -errno;
+	return 0;
+}
+
+/*
+ * Dropping UIDs clears the dumpable flag, which would make the DAC
+ * checks in ptrace_may_access() fail before Yama runs, so restore it
+ * afterwards.
+ */
+static inline int drop_unpriv(void)
+{
+	if (geteuid() == 0 &&
+	    (setresgid(UNPRIV_UID, UNPRIV_UID, UNPRIV_UID) < 0 ||
+	     setresuid(UNPRIV_UID, UNPRIV_UID, UNPRIV_UID) < 0))
+		return -errno;
+	if (set_caps_mask(0) < 0)
+		return -errno;
+	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0) < 0)
+		return -errno;
+	return 0;
+}
+
+/* ---- process helpers ---- */
+
+/* Pipe I/O with EINTR retry; return a negative errno on failure. */
+static inline int read_full(int fd, void *buf, size_t len)
+{
+	uint8_t *p = buf;
+
+	while (len) {
+		ssize_t n = read(fd, p, len);
+
+		if (n < 0) {
+			if (errno == EINTR)
+				continue;
+			return -errno;
+		}
+		if (!n)
+			return -EIO;
+		p += n;
+		len -= n;
+	}
+	return 0;
+}
+
+static inline int write_full(int fd, const void *buf, size_t len)
+{
+	const uint8_t *p = buf;
+
+	while (len) {
+		ssize_t n = write(fd, p, len);
+
+		if (n < 0) {
+			if (errno == EINTR)
+				continue;
+			return -errno;
+		}
+		if (!n)
+			return -EIO;
+		p += n;
+		len -= n;
+	}
+	return 0;
+}
+
+/* Wait for a child and return its exit status as a negative errno. */
+static inline int wait_result(pid_t pid)
+{
+	int status;
+
+	while (waitpid(pid, &status, 0) < 0) {
+		if (errno != EINTR)
+			return -errno;
+	}
+	if (!WIFEXITED(status))
+		return -EFAULT;
+	return -WEXITSTATUS(status);
+}
+
+static inline int try_attach(pid_t target)
+{
+	int status;
+
+	if (ptrace(PTRACE_ATTACH, target, NULL, NULL) < 0)
+		return -errno;
+	while (waitpid(target, &status, 0) < 0) {
+		if (errno != EINTR) {
+			ptrace(PTRACE_DETACH, target, NULL, NULL);
+			return -errno;
+		}
+	}
+	if (ptrace(PTRACE_DETACH, target, NULL, NULL) < 0)
+		return -errno;
+	return 0;
+}
+
+#endif /* YAMA_COMMON_H */
diff --git a/tools/testing/selftests/yama/config b/tools/testing/selftests/yama/config
new file mode 100644
index 000000000000..aa19bccbfcaf
--- /dev/null
+++ b/tools/testing/selftests/yama/config
@@ -0,0 +1,4 @@
+CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SECURITY=y
+CONFIG_SECURITY_YAMA=y
diff --git a/tools/testing/selftests/yama/ptrace_scope_test.c b/tools/testing/selftests/yama/ptrace_scope_test.c
new file mode 100644
index 000000000000..0abfd21c246f
--- /dev/null
+++ b/tools/testing/selftests/yama/ptrace_scope_test.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ptrace_scope selftests for the Yama LSM.
+ *
+ * Every forked helper reports readiness once its credentials are in
+ * place, and the parent waits for that before any ptrace attempt, so
+ * no result depends on child scheduling.
+ */
+#include "kselftest_harness.h"
+#include "common.h"
+
+/* Credential setups for forked children. */
+enum {
+	CRED_UNPRIV,		/* unprivileged UID, no capabilities */
+	CRED_UID0_NOCAP,	/* UID 0, no capabilities */
+	CRED_CAP_PTRACE,	/* unprivileged UID, CAP_SYS_PTRACE */
+};
+
+/* Keep CAP_SYS_PTRACE across the drop to an unprivileged UID. */
+static int drop_unpriv_keep_ptrace(void)
+{
+	if (geteuid() != 0)
+		return -EPERM;
+	if (prctl(PR_SET_KEEPCAPS, 1L, 0, 0, 0) < 0 ||
+	    setresgid(UNPRIV_UID, UNPRIV_UID, UNPRIV_UID) < 0 ||
+	    setresuid(UNPRIV_UID, UNPRIV_UID, UNPRIV_UID) < 0)
+		return -errno;
+	if (set_caps_mask(1U << CAP_SYS_PTRACE) < 0)
+		return -errno;
+	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0) < 0)
+		return -errno;
+	return 0;
+}
+
+static int setup_cred(int cred)
+{
+	switch (cred) {
+	case CRED_UID0_NOCAP:
+		return set_caps_mask(0);
+	case CRED_CAP_PTRACE:
+		return drop_unpriv_keep_ptrace();
+	default:
+		return drop_unpriv();
+	}
+}
+
+static int attach_fn(void *arg)
+{
+	return try_attach(*(pid_t *)arg);
+}
+
+/*
+ * Fork a short-lived child that sets up @cred, reports readiness, then
+ * waits for a release byte on *go before running fn(arg) (or exiting
+ * immediately when fn is NULL).  The child exits with the negative
+ * errno result of fn().
+ */
+static pid_t fork_helper(int cred, int (*fn)(void *), void *arg, int *go)
+{
+	char b;
+	int ready[2], release[2];
+	pid_t pid;
+	int rc;
+
+	if (pipe(ready) < 0)
+		return -errno;
+	if (pipe(release) < 0) {
+		rc = -errno;
+		close(ready[0]);
+		close(ready[1]);
+		return rc;
+	}
+	pid = fork();
+	if (pid < 0) {
+		rc = -errno;
+		close(ready[0]);
+		close(ready[1]);
+		close(release[0]);
+		close(release[1]);
+		return rc;
+	}
+	if (pid == 0) {
+		close(ready[0]);
+		close(release[1]);
+		rc = setup_cred(cred);
+		if (rc < 0)
+			_exit(-rc);
+		if (write_full(ready[1], "1", 1) < 0)
+			_exit(EIO);
+		if (read_full(release[0], &b, 1) < 0)
+			_exit(EIO);
+		close(release[0]);
+		close(ready[1]);
+		rc = fn ? fn(arg) : 0;
+		_exit(rc < 0 ? -rc : 0);
+	}
+	close(ready[1]);
+	close(release[0]);
+	rc = read_full(ready[0], &b, 1);
+	close(ready[0]);
+	if (rc < 0) {
+		/* The child died before reporting readiness. */
+		close(release[1]);
+		rc = wait_result(pid);
+		return rc < 0 ? rc : -ECHILD;
+	}
+	*go = release[1];
+	return pid;
+}
+
+/* Release a fork_helper() child and return its result. */
+static int release_helper(int go, pid_t pid)
+{
+	int rc;
+
+	rc = write_full(go, "1", 1);
+	close(go);
+	if (rc < 0)
+		return rc;
+	return wait_result(pid);
+}
+
+/*
+ * Fork a child that sets up @cred, runs fn(arg) immediately and exits
+ * with the negative errno result of fn().
+ */
+static int child_run(int (*fn)(void *), void *arg, int cred)
+{
+	pid_t pid = fork();
+	int rc;
+
+	if (pid < 0)
+		return -errno;
+	if (pid == 0) {
+		rc = setup_cred(cred);
+		if (rc < 0)
+			_exit(-rc);
+		rc = fn(arg);
+		_exit(rc < 0 ? -rc : 0);
+	}
+	return wait_result(pid);
+}
+
+/* ---- scenarios ---- */
+
+static int parent_attach_fn(void *arg)
+{
+	pid_t target;
+	int go;
+	int rc;
+
+	(void)arg;
+	target = fork_helper(CRED_UNPRIV, NULL, NULL, &go);
+	if (target < 0)
+		return target;
+	rc = try_attach(target);
+	release_helper(go, target);
+	return rc;
+}
+
+/* The child attempts to attach its own parent (this process). */
+static int child_attach_fn(void *arg)
+{
+	pid_t self = getpid();
+	pid_t tracer;
+	int go;
+
+	(void)arg;
+	tracer = fork_helper(CRED_UNPRIV, attach_fn, &self, &go);
+	if (tracer < 0)
+		return tracer;
+	return release_helper(go, tracer);
+}
+
+/* One child of this process attaches another one: they are siblings. */
+static int sibling_fn(void *arg)
+{
+	pid_t target;
+	pid_t tracer;
+	int tgo, go;
+	int rc;
+
+	(void)arg;
+	target = fork_helper(CRED_UNPRIV, NULL, NULL, &tgo);
+	if (target < 0)
+		return target;
+	tracer = fork_helper(CRED_UNPRIV, attach_fn, &target, &go);
+	if (tracer < 0) {
+		release_helper(tgo, target);
+		return tracer;
+	}
+	rc = release_helper(go, tracer);
+	release_helper(tgo, target);
+	return rc;
+}
+
+/*
+ * The child asks its real parent (this process) to trace it; the
+ * parent's credentials decide the outcome.  Called through child_run()
+ * with CRED_UNPRIV for an unprivileged parent or CRED_CAP_PTRACE for
+ * a parent that only holds CAP_SYS_PTRACE.
+ */
+static int traceme_fn(void *arg)
+{
+	pid_t child;
+	int rc;
+
+	(void)arg;
+	child = fork();
+	if (child < 0)
+		return -errno;
+	if (child == 0) {
+		rc = drop_unpriv();
+		if (rc < 0)
+			_exit(-rc);
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) < 0)
+			_exit(errno);
+		_exit(0);
+	}
+	return wait_result(child);
+}
+
+static int write_scope_fn(void *arg)
+{
+	(void)arg;
+	return write_ptrace_scope(YAMA_SCOPE_RELATIONAL);
+}
+
+/*
+ * A CAP_SYS_PTRACE holder attaches a target that is not its descendant:
+ * the target and the holder are both children of the root caller, so
+ * they are siblings.
+ */
+static int cap_sibling_attach(void)
+{
+	pid_t target;
+	pid_t holder;
+	int tgo, hgo;
+	int rc;
+
+	target = fork_helper(CRED_UNPRIV, NULL, NULL, &tgo);
+	if (target < 0)
+		return target;
+	holder = fork_helper(CRED_CAP_PTRACE, attach_fn, &target, &hgo);
+	if (holder < 0) {
+		release_helper(tgo, target);
+		return holder;
+	}
+	rc = release_helper(hgo, holder);
+	release_helper(tgo, target);
+	return rc;
+}
+
+/* ---- sysctl ---- */
+
+TEST(sysctl_permissions_and_bounds)
+{
+	int orig_scope = -1, cur_scope = -1;
+	int rc;
+
+	rc = read_ptrace_scope(&orig_scope);
+	if (rc == -ENOENT)
+		SKIP(return, "Yama is not active");
+	ASSERT_EQ(0, rc);
+	EXPECT_GE(orig_scope, YAMA_SCOPE_DISABLED);
+	EXPECT_LE(orig_scope, YAMA_SCOPE_NO_ATTACH);
+
+	if (geteuid() != 0) {
+		/* The sysctl is 0644: unprivileged writers get EACCES. */
+		EXPECT_EQ(-EACCES, write_ptrace_scope(orig_scope));
+	} else if (!has_cap_sys_ptrace()) {
+		/* UID 0 without CAP_SYS_PTRACE: the handler returns EPERM. */
+		EXPECT_EQ(-EPERM, write_ptrace_scope_str("1\n"));
+	} else if (!can_drop_unpriv()) {
+		SKIP(return, "cannot drop privileges for test children");
+	} else {
+		/* Unprivileged writer: EACCES from the 0644 file mode. */
+		EXPECT_EQ(-EACCES,
+			  child_run(write_scope_fn, NULL, CRED_UNPRIV));
+		/* UID 0 without CAP_SYS_PTRACE: yama_dointvec_minmax(). */
+		EXPECT_EQ(-EPERM,
+			  child_run(write_scope_fn, NULL, CRED_UID0_NOCAP));
+
+		/* Out-of-range values are rejected and change nothing. */
+		EXPECT_EQ(-EINVAL, write_ptrace_scope_str("-1\n"));
+		EXPECT_EQ(-EINVAL, write_ptrace_scope_str("4\n"));
+		ASSERT_EQ(0, read_ptrace_scope(&cur_scope));
+		EXPECT_EQ(orig_scope, cur_scope);
+	}
+}
+
+/* ---- scope matrix ---- */
+
+FIXTURE(yama_scope) {
+	int orig_scope;
+	bool restore;
+	const char *skip;
+};
+
+FIXTURE_VARIANT(yama_scope) {
+	int scope;
+	int expect_parent_attach;
+	int expect_child_attach;
+	int expect_sibling_attach;
+	int expect_traceme;
+	int expect_cap_attach;
+	int expect_cap_traceme;
+};
+
+FIXTURE_VARIANT_ADD(yama_scope, disabled) {
+	.scope = YAMA_SCOPE_DISABLED,
+	.expect_parent_attach = 0,
+	.expect_child_attach = 0,
+	.expect_sibling_attach = 0,
+	.expect_traceme = 0,
+	.expect_cap_attach = 0,
+	.expect_cap_traceme = 0,
+};
+
+FIXTURE_VARIANT_ADD(yama_scope, relational) {
+	.scope = YAMA_SCOPE_RELATIONAL,
+	.expect_parent_attach = 0,
+	.expect_child_attach = -EPERM,
+	.expect_sibling_attach = -EPERM,
+	.expect_traceme = 0,
+	.expect_cap_attach = 0,
+	.expect_cap_traceme = 0,
+};
+
+FIXTURE_VARIANT_ADD(yama_scope, capability) {
+	.scope = YAMA_SCOPE_CAPABILITY,
+	.expect_parent_attach = -EPERM,
+	.expect_child_attach = -EPERM,
+	.expect_sibling_attach = -EPERM,
+	.expect_traceme = -EPERM,
+	.expect_cap_attach = 0,
+	.expect_cap_traceme = 0,
+};
+
+FIXTURE_SETUP(yama_scope)
+{
+	int rc;
+
+	self->skip = NULL;
+	self->restore = false;
+
+	rc = read_ptrace_scope(&self->orig_scope);
+	if (rc == -ENOENT) {
+		self->skip = "Yama is not active";
+		return;
+	}
+	ASSERT_EQ(0, rc);
+
+	if (!can_drop_unpriv()) {
+		self->skip = "cannot drop privileges for test children";
+		return;
+	}
+
+	if (self->orig_scope == variant->scope)
+		return;
+	if (self->orig_scope == YAMA_SCOPE_NO_ATTACH) {
+		self->skip = "ptrace_scope is locked at 3";
+		return;
+	}
+
+	rc = write_ptrace_scope(variant->scope);
+	if (rc == -EACCES || rc == -EPERM) {
+		self->skip = "need CAP_SYS_PTRACE to change ptrace_scope";
+		return;
+	}
+	ASSERT_EQ(0, rc);
+	self->restore = true;
+}
+
+FIXTURE_TEARDOWN(yama_scope)
+{
+	if (self->restore)
+		EXPECT_EQ(0, write_ptrace_scope(self->orig_scope));
+}
+
+TEST_F(yama_scope, attach_matrix)
+{
+	if (self->skip)
+		SKIP(return, "%s", self->skip);
+
+	/* Unprivileged parent attaching its child. */
+	EXPECT_EQ(variant->expect_parent_attach,
+		  child_run(parent_attach_fn, NULL, CRED_UNPRIV));
+	/* Unprivileged child attaching its parent. */
+	EXPECT_EQ(variant->expect_child_attach,
+		  child_run(child_attach_fn, NULL, CRED_UNPRIV));
+	/* Unprivileged siblings attaching each other. */
+	EXPECT_EQ(variant->expect_sibling_attach,
+		  child_run(sibling_fn, NULL, CRED_UNPRIV));
+	/* Child asking its unprivileged parent to trace it. */
+	EXPECT_EQ(variant->expect_traceme,
+		  child_run(traceme_fn, NULL, CRED_UNPRIV));
+
+	if (can_test_cap_ptrace()) {
+		/* CAP_SYS_PTRACE holder attaching a non-descendant. */
+		EXPECT_EQ(variant->expect_cap_attach,
+			  cap_sibling_attach());
+		/* Child asking a CAP_SYS_PTRACE parent to trace it. */
+		EXPECT_EQ(variant->expect_cap_traceme,
+			  child_run(traceme_fn, NULL, CRED_CAP_PTRACE));
+	}
+}
+
+/* ---- scope 3: no attach, irreversible until reboot ---- */
+
+TEST(scope3_no_attach)
+{
+	int scope = -1;
+	int rc;
+
+	rc = read_ptrace_scope(&scope);
+	if (rc == -ENOENT)
+		SKIP(return, "Yama is not active");
+	ASSERT_EQ(0, rc);
+	if (!can_drop_unpriv())
+		SKIP(return, "cannot drop privileges for test children");
+
+	if (scope != YAMA_SCOPE_NO_ATTACH) {
+		const char *opt_in = getenv("YAMA_TEST_NO_ATTACH");
+
+		if (!opt_in || strcmp(opt_in, "1"))
+			SKIP(return,
+			     "ptrace_scope=3 is irreversible; set YAMA_TEST_NO_ATTACH=1 to test it");
+		rc = write_ptrace_scope(YAMA_SCOPE_NO_ATTACH);
+		if (rc == -EACCES || rc == -EPERM)
+			SKIP(return, "need CAP_SYS_PTRACE to set ptrace_scope=3");
+		ASSERT_EQ(0, rc);
+	}
+
+	/* Once at 3 the sysctl locks: writes below the maximum fail. */
+	if (geteuid() == 0 && has_cap_sys_ptrace())
+		EXPECT_EQ(-EINVAL, write_ptrace_scope(YAMA_SCOPE_DISABLED));
+	ASSERT_EQ(0, read_ptrace_scope(&scope));
+	EXPECT_EQ(YAMA_SCOPE_NO_ATTACH, scope);
+
+	/* Every attach and TRACEME is denied, whoever attempts it. */
+	EXPECT_EQ(-EPERM, child_run(parent_attach_fn, NULL, CRED_UNPRIV));
+	EXPECT_EQ(-EPERM, child_run(child_attach_fn, NULL, CRED_UNPRIV));
+	EXPECT_EQ(-EPERM, child_run(sibling_fn, NULL, CRED_UNPRIV));
+	EXPECT_EQ(-EPERM, child_run(traceme_fn, NULL, CRED_UNPRIV));
+	if (can_test_cap_ptrace()) {
+		EXPECT_EQ(-EPERM, cap_sibling_attach());
+		EXPECT_EQ(-EPERM, child_run(traceme_fn, NULL, CRED_CAP_PTRACE));
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.47.3

