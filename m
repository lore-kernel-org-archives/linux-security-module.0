Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611595;
	b=sQh6iEhhLWvGORlArIR/LxR39dmD5zQBz5IrMKEmQ1L2tjqhCFZUYEhCyirK4g3kCJu/
	 pMJh+Zn/jBlpOF2zPzJILvklod25+qSgRsi4K4XJ9RYsNm4dCMHJgXq3lKTpxaYddIs9K
	 FyKtvdYwuOEgcq+z2S/gobfg3tticgmON7BunEts58M15QDqtpnAh2f1Mrtv9Bb5Ef3aQ
	 nacDEo4An5ApVj+IIbz6XrnIpoer1RKK2OyvmEPAipbiCkEk832o64Pa9lc/OG4mjW/u5
	 AAxISRZeM9285Pb310OydkFKu1Id9DlO1v7FPgPo6IF9g+c/99/Y0cfiHzjbPdWSb7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611595;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iQLA7m0p7fuy7g5tN1jo0NMIaMNq9XGQzKz/k2rcmWg=;
	b=v008FujJPSQCNO/FLq+vIPQeY9Zhu2GpWu2/Kf7HLNhlvV2X+LBUVPXaLtyLNdCgaZ09
	 IU56kmoIjR1i9fZnTjIN5NrHPLOfY0V2PH7VXY/9r2tpRt681LVLz8jTg6j/JSPQrKWkg
	 ZE6YZz2xsyTTOGVmvRBxGM6fugrNE6sesA5z3NBFq/PMnXuKM60fX3QQ5HMoq17/527ud
	 bi/iFPmnAM1Cjj4TBhE6CxxVasaInvfhcH0hNB2y0fdmVD24Ee483RfTxeYz030IYWV1r
	 9wZ1nz2VrKg0ZhTYyACjPJAFq9EQJVtruVfVMsTZA2+hjTJ/YlJl+xrgzRbxnGKzvYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A8606A333;
	Wed, 25 Nov 2026 12:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E14A8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 17b705dee8d011f19a56ed5b684f684d-20261125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4f40ca6b-83da-4bbc-aa07-6c996719c534,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:4f40ca6b-83da-4bbc-aa07-6c996719c534,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:6e7157813b9eb3c8ac7b5eb95ca8f054,BulkI
	D:2611252059497AJLTO1D,BulkQuantity:0,SF:17|19|66|78|81|82|101|102|127|153
	|850|865|898|915,TC:nil,Content:0|15|50|99|300|350,EDM:-3,IP:-2,URL:0,File
	:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DK
	R:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17b705dee8d011f19a56ed5b684f684d-20261125
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2123431898; Wed, 25 Nov 2026 20:59:47 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 2/2] selftests/yama: add PR_SET_PTRACER tests
Date: Wed, 25 Nov 2026 07:59:44 -0500
Message-ID: <20261125125944.1768182-3-maguicai@kylinos.cn>
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

Add a second test program covering the PR_SET_PTRACER exception list
of Yama.

The lifecycle test checks that a reaped PID is rejected with EINVAL,
that a granted tracer and its descendants may attach while unrelated
processes may not, that granting another tracer revokes the first one
while it is still alive, that PR_SET_PTRACER(0) revokes the current
grant, and that PR_SET_PTRACER_ANY admits every process.  A second
test runs the same prctl() calls from a non-leader thread to verify
that the exception is recorded with process granularity.

Tracers stay alive across the assertions, so each grant, replacement
and clear is observed on the task it applies to.  Workers report
readiness once their credentials are in place, and each child closes
the pipes of the workers spawned before it, so no result depends on
scheduling and teardown never deadlocks on inherited pipe ends.

Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
---
 tools/testing/selftests/yama/.gitignore     |   1 +
 tools/testing/selftests/yama/Makefile       |   4 +-
 tools/testing/selftests/yama/ptracer_test.c | 403 ++++++++++++++++++++
 3 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/yama/ptracer_test.c

diff --git a/tools/testing/selftests/yama/.gitignore b/tools/testing/selftests/yama/.gitignore
index 6ffe677a8695..4270fbb194a3 100644
--- a/tools/testing/selftests/yama/.gitignore
+++ b/tools/testing/selftests/yama/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 ptrace_scope_test
+ptracer_test
diff --git a/tools/testing/selftests/yama/Makefile b/tools/testing/selftests/yama/Makefile
index f0dd1ed89d20..dffecfbefd7a 100644
--- a/tools/testing/selftests/yama/Makefile
+++ b/tools/testing/selftests/yama/Makefile
@@ -6,6 +6,8 @@ CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
 
 LOCAL_HDRS += common.h
 
-TEST_GEN_PROGS := ptrace_scope_test
+TEST_GEN_PROGS := ptrace_scope_test ptracer_test
 
 include ../lib.mk
+
+$(OUTPUT)/ptracer_test: LDLIBS += -lpthread
diff --git a/tools/testing/selftests/yama/ptracer_test.c b/tools/testing/selftests/yama/ptracer_test.c
new file mode 100644
index 000000000000..25638c9629c4
--- /dev/null
+++ b/tools/testing/selftests/yama/ptracer_test.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PR_SET_PTRACER selftests for the Yama LSM.
+ *
+ * The tracee and the tracer workers are unprivileged children of the
+ * test process, so every attach attempt has to pass Yama's relation
+ * checks instead of the descendant rule.  Tracers stay alive across
+ * the assertions, so each grant, replacement and clear is observed on
+ * the task it applies to.  Every worker reports readiness before the
+ * first command, and commands queue in the pipes, so no result depends
+ * on child scheduling.
+ */
+#include <pthread.h>
+
+#include "kselftest_harness.h"
+#include "common.h"
+
+/* Tracee commands: apply PR_SET_PTRACER with @arg, directly or from a
+ * non-leader thread.
+ */
+enum {
+	TRACEE_PTRACER = 1,
+	TRACEE_PTRACER_THREAD,
+};
+
+/* Tracer commands: attach the tracee directly or through a forked
+ * child, i.e. as a descendant of the tracer.
+ */
+enum {
+	TRACER_ATTACH = 1,
+	TRACER_ATTACH_VIA_CHILD,
+};
+
+struct worker {
+	pid_t pid;
+	int go;		/* parent to worker: one command at a time */
+	int res;	/* worker to parent: one int result per command */
+};
+
+/* Attach as a descendant of the caller: a child of this process. */
+static int attach_via_child(pid_t target)
+{
+	pid_t child;
+	int rc;
+
+	child = fork();
+	if (child < 0)
+		return -errno;
+	if (child == 0) {
+		rc = try_attach(target);
+		_exit(rc < 0 ? -rc : 0);
+	}
+	return wait_result(child);
+}
+
+/* ---- tracee worker ---- */
+
+struct prctl_thread_arg {
+	unsigned long arg2;
+	int rc;
+};
+
+static void *ptracer_prctl_thread(void *data)
+{
+	struct prctl_thread_arg *a = data;
+
+	if (prctl(PR_SET_PTRACER, a->arg2, 0, 0, 0) < 0)
+		a->rc = -errno;
+	else
+		a->rc = 0;
+	return NULL;
+}
+
+/*
+ * Run PR_SET_PTRACER on a non-leader thread: the exception must be
+ * recorded for the whole thread group.
+ */
+static int prctl_ptracer_thread(unsigned long arg2)
+{
+	struct prctl_thread_arg a = {
+		.arg2 = arg2,
+		.rc = -EIO,
+	};
+	pthread_t th;
+	int rc;
+
+	/* pthread_create() returns the error number, it does not set errno. */
+	rc = pthread_create(&th, NULL, ptracer_prctl_thread, &a);
+	if (rc)
+		return -rc;
+	pthread_join(th, NULL);
+	return a.rc;
+}
+
+/* The tracee: apply PR_SET_PTRACER on request. */
+static void tracee_loop(int go, int res, pid_t target)
+{
+	unsigned long arg;
+	uint8_t cmd;
+	int rc;
+
+	(void)target;
+	for (;;) {
+		if (read_full(go, &cmd, sizeof(cmd)) < 0 ||
+		    read_full(go, &arg, sizeof(arg)) < 0)
+			return;
+		if (cmd == TRACEE_PTRACER)
+			rc = prctl(PR_SET_PTRACER, arg, 0, 0, 0) < 0 ?
+				-errno : 0;
+		else if (cmd == TRACEE_PTRACER_THREAD)
+			rc = prctl_ptracer_thread(arg);
+		else
+			return;
+		if (write_full(res, &rc, sizeof(rc)) < 0)
+			return;
+	}
+}
+
+/* ---- tracer worker ---- */
+
+/* The tracer: attach the tracee on request. */
+static void tracer_loop(int go, int res, pid_t target)
+{
+	unsigned long arg;
+	uint8_t cmd;
+	int rc;
+
+	for (;;) {
+		if (read_full(go, &cmd, sizeof(cmd)) < 0 ||
+		    read_full(go, &arg, sizeof(arg)) < 0)
+			return;
+		rc = cmd == TRACER_ATTACH_VIA_CHILD ?
+			attach_via_child(target) : try_attach(target);
+		if (write_full(res, &rc, sizeof(rc)) < 0)
+			return;
+	}
+}
+
+/* ---- worker spawn and control ---- */
+
+#define MAX_WORKERS 4
+
+/* All workers spawned by one test. */
+struct worker_set {
+	struct worker w[MAX_WORKERS];
+	int n;
+};
+
+/*
+ * Fork a worker that drops to unprivileged credentials and serves
+ * commands until its go pipe closes.  The child closes the pipes of
+ * previously spawned workers, which would otherwise keep each other's
+ * write ends open and never see EOF.  The worker reports readiness
+ * once its credentials are in place, so a setup failure is reported
+ * here and not as a later command failure.
+ */
+static pid_t fork_worker(struct worker_set *s, pid_t target,
+			 void (*loop)(int, int, pid_t))
+{
+	struct worker *w = &s->w[s->n];
+	int go[2], res[2];
+	pid_t pid;
+	char b;
+	int rc;
+	int i;
+
+	if (s->n >= MAX_WORKERS)
+		return -E2BIG;
+	if (pipe(go) < 0)
+		return -errno;
+	if (pipe(res) < 0) {
+		rc = -errno;
+		close(go[0]);
+		close(go[1]);
+		return rc;
+	}
+	pid = fork();
+	if (pid < 0) {
+		rc = -errno;
+		close(go[0]);
+		close(go[1]);
+		close(res[0]);
+		close(res[1]);
+		return rc;
+	}
+	if (pid == 0) {
+		close(go[1]);
+		close(res[0]);
+		for (i = 0; i < s->n; i++) {
+			close(s->w[i].go);
+			close(s->w[i].res);
+		}
+		rc = drop_unpriv();
+		if (rc < 0)
+			_exit(-rc);
+		if (write_full(res[1], "1", 1) < 0)
+			_exit(EIO);
+		loop(go[0], res[1], target);
+		_exit(0);
+	}
+	close(go[0]);
+	close(res[1]);
+	w->pid = pid;
+	w->go = go[1];
+	w->res = res[0];
+	s->n++;
+
+	rc = read_full(w->res, &b, 1);
+	if (rc < 0) {
+		/* The worker died before reporting readiness. */
+		close(w->go);
+		close(w->res);
+		s->n--;
+		rc = wait_result(pid);
+		return rc < 0 ? rc : -ECHILD;
+	}
+	return pid;
+}
+
+static pid_t fork_tracee(struct worker_set *s)
+{
+	return fork_worker(s, 0, tracee_loop);
+}
+
+static pid_t fork_tracer(struct worker_set *s, pid_t target)
+{
+	return fork_worker(s, target, tracer_loop);
+}
+
+/* Send one command and return the worker's int result. */
+static int worker_cmd(struct worker *w, uint8_t cmd, unsigned long arg)
+{
+	int rc;
+	int res;
+
+	rc = write_full(w->go, &cmd, sizeof(cmd));
+	if (!rc)
+		rc = write_full(w->go, &arg, sizeof(arg));
+	if (rc)
+		return rc;
+	if (read_full(w->res, &res, sizeof(res)) < 0)
+		return -EIO;
+	return res;
+}
+
+/* PR_SET_PTRACER(@arg2) on the tracee, directly or from a thread. */
+static int tracee_prctl(struct worker *w, unsigned long arg2, bool thread)
+{
+	return worker_cmd(w, thread ? TRACEE_PTRACER_THREAD : TRACEE_PTRACER,
+			  arg2);
+}
+
+/* Attach the tracee from the tracer, or from a descendant of it. */
+static int tracer_attach(struct worker *w, bool via_child)
+{
+	return worker_cmd(w, via_child ? TRACER_ATTACH_VIA_CHILD :
+			TRACER_ATTACH, 0);
+}
+
+/* Close every command pipe, then reap all workers. */
+static void workers_stop(struct worker_set *s)
+{
+	int i;
+
+	for (i = 0; i < s->n; i++) {
+		close(s->w[i].go);
+		close(s->w[i].res);
+	}
+	for (i = 0; i < s->n; i++)
+		wait_result(s->w[i].pid);
+}
+
+/* ---- tests ---- */
+
+FIXTURE(yama_relational) {
+	int orig_scope;
+	bool restore;
+	const char *skip;
+};
+
+FIXTURE_SETUP(yama_relational)
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
+	if (self->orig_scope == YAMA_SCOPE_RELATIONAL)
+		return;
+	if (self->orig_scope == YAMA_SCOPE_NO_ATTACH) {
+		self->skip = "ptrace_scope is locked at 3";
+		return;
+	}
+
+	rc = write_ptrace_scope(YAMA_SCOPE_RELATIONAL);
+	if (rc == -EACCES || rc == -EPERM) {
+		self->skip = "need CAP_SYS_PTRACE to set ptrace_scope=1";
+		return;
+	}
+	ASSERT_EQ(0, rc);
+	self->restore = true;
+}
+
+FIXTURE_TEARDOWN(yama_relational)
+{
+	if (self->restore)
+		EXPECT_EQ(0, write_ptrace_scope(self->orig_scope));
+}
+
+TEST_F(yama_relational, pr_set_ptracer_lifecycle)
+{
+	struct worker_set s = {};
+	struct worker *tracee = &s.w[0];
+	struct worker *t1 = &s.w[1];
+	struct worker *t2 = &s.w[2];
+	struct worker *t3 = &s.w[3];
+	pid_t dead;
+
+	if (self->skip)
+		SKIP(return, "%s", self->skip);
+
+	/* Spawn every worker first, so no later fork can recycle @dead. */
+	ASSERT_GE(fork_tracee(&s), 0);
+	ASSERT_GE(fork_tracer(&s, tracee->pid), 0);
+	ASSERT_GE(fork_tracer(&s, tracee->pid), 0);
+	ASSERT_GE(fork_tracer(&s, tracee->pid), 0);
+
+	/* A reaped PID is rejected. */
+	dead = fork();
+	ASSERT_GE(dead, 0);
+	if (dead == 0)
+		_exit(0);
+	ASSERT_EQ(0, wait_result(dead));
+	EXPECT_EQ(-EINVAL, tracee_prctl(tracee, dead, false));
+
+	/* A granted tracer and its descendants may attach, others not. */
+	EXPECT_EQ(0, tracee_prctl(tracee, t1->pid, false));
+	EXPECT_EQ(0, tracer_attach(t1, false));
+	EXPECT_EQ(0, tracer_attach(t1, true));
+	EXPECT_EQ(-EPERM, tracer_attach(t3, false));
+
+	/* Granting another tracer revokes the first one, which is alive. */
+	EXPECT_EQ(0, tracee_prctl(tracee, t2->pid, false));
+	EXPECT_EQ(-EPERM, tracer_attach(t1, false));
+	EXPECT_EQ(0, tracer_attach(t2, false));
+
+	/* Clearing removes the exception. */
+	EXPECT_EQ(0, tracee_prctl(tracee, 0, false));
+	EXPECT_EQ(-EPERM, tracer_attach(t2, false));
+
+	/* PR_SET_PTRACER_ANY admits any process. */
+	EXPECT_EQ(0, tracee_prctl(tracee, PR_SET_PTRACER_ANY, false));
+	EXPECT_EQ(0, tracer_attach(t1, false));
+	EXPECT_EQ(0, tracer_attach(t3, false));
+
+	workers_stop(&s);
+}
+
+TEST_F(yama_relational, pr_set_ptracer_non_leader_thread)
+{
+	struct worker_set s = {};
+	struct worker *tracee = &s.w[0];
+	struct worker *t1 = &s.w[1];
+	struct worker *t3 = &s.w[2];
+
+	if (self->skip)
+		SKIP(return, "%s", self->skip);
+
+	ASSERT_GE(fork_tracee(&s), 0);
+	ASSERT_GE(fork_tracer(&s, tracee->pid), 0);
+	ASSERT_GE(fork_tracer(&s, tracee->pid), 0);
+
+	/* Without a grant the tracer cannot attach. */
+	EXPECT_EQ(-EPERM, tracer_attach(t1, false));
+
+	/* A non-leader thread grants the exception process-wide. */
+	EXPECT_EQ(0, tracee_prctl(tracee, t1->pid, true));
+	EXPECT_EQ(0, tracer_attach(t1, false));
+
+	/* Clearing from a non-leader thread revokes it again. */
+	EXPECT_EQ(0, tracee_prctl(tracee, 0, true));
+	EXPECT_EQ(-EPERM, tracer_attach(t1, false));
+
+	/* ANY from a non-leader thread admits any process. */
+	EXPECT_EQ(0, tracee_prctl(tracee, PR_SET_PTRACER_ANY, true));
+	EXPECT_EQ(0, tracer_attach(t3, false));
+
+	workers_stop(&s);
+}
+
+TEST_HARNESS_MAIN
-- 
2.47.3

