Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDD3E3D80
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740376; cv=none; b=llQ8tcxm5y0LbUaRwFCGMDL6ZdQc+ga5AgnyaJlqZMAKfScdZOVoByk27UC6gcz2cPjhOTJs0mm02mdWyBYMW6Q2aeYQ+JJE21Vq9I2H4Qez4LwrUo88B/COqH/EUJKZbJ+PXFBdC5ieKrEuxu7k6TtD5imdFFTRYGQLMu5AaYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740376; c=relaxed/simple;
	bh=Nzcl76LPqtdmiu1uhEY/1CH/m+a+KXtU6LZyG7EmKG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9LOWtDNVvd2X3KCeq2pw4Dw9eFVp68SeO/sZSXlWsZQaOpalCRwGMep55+j2JDD0NHE86dxWbBbZz2aS4K22x/zPY05+aB5BM037q+lmGyyPozt7FVfrEwkjHrOmVubUjggHq0rSI3vz8IjgcLoCOuBH/HYMNg7xtQ/Kxkuu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PYY3AI2x; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PYY3AI2x"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h51614JjTzstv;
	Wed, 22 Jul 2026 19:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740361;
	bh=6GH1a1oldPQULnyKRH+ZAHz4CCgdKRWltljWgSRzKTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYY3AI2xW4TaswbY3T0TR4JcydAMAiMN27+/G7CAR6mwOG1fWwQY+NojgiyDrYaUl
	 yJtS+4Rd+qA766BdiJcmwSSAtHSbIRQPsjnD9zSRB1QfPjmS89dEm+9KSmSFjB2tcF
	 /JtBaar2JjqbBvsbJ26RmuPDeFjwdo37MbXpVgIk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h51604hH9zZDn;
	Wed, 22 Jul 2026 19:12:40 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
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
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 19/20] selftests/landlock: Add landlock_enforce_domain trace tests
Date: Wed, 22 Jul 2026 19:11:51 +0200
Message-ID: <20260722171159.2776765-20-mic@digikod.net>
In-Reply-To: <20260722171159.2776765-1-mic@digikod.net>
References: <20260722171159.2776765-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add trace tests for the landlock_enforce_domain event in trace_test.c,
asserting field counts after the syscall returns rather than line
ordering across per-CPU buffers.  They cover single-threaded and TSYNC
enforcement (complete and process_wide set), a multi-threaded non-TSYNC
process (process_wide clear), the single-threaded non-leader edge case,
the flags-only path that creates no domain, and a thread-sync abort that
emits create_domain and free_domain but no enforce_domain.

landlock_enforce_domain is added to the fixture enable path and every
disable list so its zero-events assertions cannot be tripped by a stray
enforcement event.

Test coverage for security/landlock is 91.6% of 2552 lines according to
LLVM 22.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/trace.h      |   9 +
 tools/testing/selftests/landlock/trace_test.c | 522 ++++++++++++++++++
 2 files changed, 531 insertions(+)

diff --git a/tools/testing/selftests/landlock/trace.h b/tools/testing/selftests/landlock/trace.h
index e03c689ef398..9e901823ddaf 100644
--- a/tools/testing/selftests/landlock/trace.h
+++ b/tools/testing/selftests/landlock/trace.h
@@ -25,6 +25,8 @@
 	TRACEFS_LANDLOCK_DIR "/landlock_create_ruleset/enable"
 #define TRACEFS_CREATE_DOMAIN_ENABLE \
 	TRACEFS_LANDLOCK_DIR "/landlock_create_domain/enable"
+#define TRACEFS_ENFORCE_DOMAIN_ENABLE \
+	TRACEFS_LANDLOCK_DIR "/landlock_enforce_domain/enable"
 #define TRACEFS_ADD_RULE_FS_ENABLE \
 	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_fs/enable"
 #define TRACEFS_ADD_RULE_NET_ENABLE \
@@ -108,6 +110,13 @@
 	"parent=[0-9a-f]\\+ "      \
 	"ruleset=[0-9a-f]\\+\\.[0-9]\\+$"
 
+#define REGEX_ENFORCE_DOMAIN(task)  \
+	TRACE_PREFIX(task)          \
+	"landlock_enforce_domain: " \
+	"domain=[0-9a-f]\\+ "       \
+	"complete=[01] "            \
+	"process_wide=[01]$"
+
 #define REGEX_CHECK_RULE_FS(task)  \
 	TRACE_PREFIX(task)         \
 	"landlock_check_rule_fs: " \
diff --git a/tools/testing/selftests/landlock/trace_test.c b/tools/testing/selftests/landlock/trace_test.c
index a141f22ad98f..e2415b98868d 100644
--- a/tools/testing/selftests/landlock/trace_test.c
+++ b/tools/testing/selftests/landlock/trace_test.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
+#include <pthread.h>
 #include <sched.h>
 #include <stdio.h>
 #include <string.h>
@@ -47,6 +48,7 @@ FIXTURE_SETUP(trace)
 
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CREATE_DOMAIN_ENABLE, true));
+	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ENFORCE_DOMAIN_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_NET_ENABLE, true));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, true));
@@ -69,6 +71,7 @@ FIXTURE_TEARDOWN(trace)
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, false);
 	tracefs_enable_event(TRACEFS_CREATE_DOMAIN_ENABLE, false);
+	tracefs_enable_event(TRACEFS_ENFORCE_DOMAIN_ENABLE, false);
 	tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, false);
 	tracefs_enable_event(TRACEFS_ADD_RULE_NET_ENABLE, false);
 	tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, false);
@@ -98,6 +101,8 @@ TEST_F(trace, no_trace_when_disabled)
 	ASSERT_EQ(0,
 		  tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, false));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CREATE_DOMAIN_ENABLE, false));
+	ASSERT_EQ(0,
+		  tracefs_enable_event(TRACEFS_ENFORCE_DOMAIN_ENABLE, false));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_FS_ENABLE, false));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_NET_ENABLE, false));
 	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CHECK_RULE_FS_ENABLE, false));
@@ -1069,6 +1074,523 @@ TEST_F(trace, free_ruleset_on_close)
 	free(buf);
 }
 
+/*
+ * Counts landlock_enforce_domain lines, filtered by @domain (NULL matches any),
+ * @complete and @process_wide (a negative value matches any).  Builds the
+ * anchored regex dynamically so a single helper covers every field assertion.
+ */
+static int count_enforce_matches(const char *buf, const char *domain,
+				 int complete, int process_wide)
+{
+	char pattern[512], dom[80], comp[8], pw[8];
+
+	if (domain)
+		snprintf(dom, sizeof(dom), "%s", domain);
+	else
+		snprintf(dom, sizeof(dom), "[0-9a-f]\\+");
+	if (complete < 0)
+		snprintf(comp, sizeof(comp), "[01]");
+	else
+		snprintf(comp, sizeof(comp), "%d", complete);
+	if (process_wide < 0)
+		snprintf(pw, sizeof(pw), "[01]");
+	else
+		snprintf(pw, sizeof(pw), "%d", process_wide);
+
+	snprintf(pattern, sizeof(pattern),
+		 TRACE_PREFIX(TRACE_TASK) "landlock_enforce_domain: "
+					  "domain=%s "
+					  "complete=%s process_wide=%s$",
+		 dom, comp, pw);
+	return tracefs_count_matches(buf, pattern);
+}
+
+/* Idle sibling: waits on the barrier so it is a live thread, then sleeps. */
+static void *enforce_idle(void *arg)
+{
+	pthread_barrier_t *barrier = arg;
+
+	pthread_barrier_wait(barrier);
+	while (true)
+		sleep(1);
+	return NULL;
+}
+
+/*
+ * Child body: spawns @nthreads idle siblings (barrier-synchronized so they are
+ * live when the syscall runs), then enforces a domain with @flags.  Returns 0
+ * on success; the process exits afterwards, reaping the siblings.
+ */
+static int child_enforce(int nthreads, __u32 flags)
+{
+	pthread_t threads[8];
+	pthread_barrier_t barrier;
+	int ruleset_fd, i;
+
+	if (nthreads > 0) {
+		if (pthread_barrier_init(&barrier, NULL, nthreads + 1))
+			return 1;
+		for (i = 0; i < nthreads; i++)
+			if (pthread_create(&threads[i], NULL, enforce_idle,
+					   &barrier))
+				return 1;
+		pthread_barrier_wait(&barrier);
+	}
+
+	ruleset_fd = build_enforce_ruleset();
+	if (ruleset_fd < 0)
+		return 1;
+
+	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	if (landlock_restrict_self(ruleset_fd, flags))
+		return 1;
+	close(ruleset_fd);
+	return 0;
+}
+
+/* Reads the group's live thread count from /proc/self/status (get_nr_threads). */
+static int read_thread_count(void)
+{
+	char line[128];
+	FILE *f;
+	int n = -1;
+
+	f = fopen("/proc/self/status", "re");
+	if (!f)
+		return -1;
+	while (fgets(line, sizeof(line), f))
+		if (sscanf(line, "Threads: %d", &n) == 1)
+			break;
+	fclose(f);
+	return n;
+}
+
+/* Exit code the non-leader child uses to signal "could not go single-threaded". */
+#define ENFORCE_SKIP_EXIT 2
+
+/*
+ * Runs in a spawned thread after the group leader called pthread_exit().  Waits
+ * until it is the only live thread (get_nr_threads() == 1 despite not being the
+ * leader), then enforces a domain.
+ */
+static void *enforce_nonleader(void *arg)
+{
+	int ruleset_fd, i;
+
+	for (i = 0; i < 200; i++) {
+		if (read_thread_count() == 1)
+			break;
+		usleep(10000);
+	}
+	if (read_thread_count() != 1)
+		_exit(ENFORCE_SKIP_EXIT);
+
+	ruleset_fd = build_enforce_ruleset();
+	if (ruleset_fd < 0)
+		_exit(1);
+	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	if (landlock_restrict_self(ruleset_fd, 0))
+		_exit(1);
+	_exit(0);
+}
+
+/*
+ * Verifies the single-threaded non-TSYNC case: one create_domain and exactly
+ * one enforce_domain, with complete=1 (the operation concludes) and
+ * process_wide=1 (get_nr_threads() == 1), sharing the created domain ID.
+ */
+TEST_F(trace, enforce_single)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+	char domain[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+	if (pid == 0)
+		_exit(child_enforce(0, 0));
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(1,
+		  tracefs_count_matches(buf, REGEX_CREATE_DOMAIN(TRACE_TASK)));
+	EXPECT_EQ(1, count_enforce_matches(buf, NULL, -1, -1))
+	{
+		TH_LOG("Expected 1 enforce_domain event\n%s", buf);
+	}
+	EXPECT_EQ(1, count_enforce_matches(buf, NULL, 1, 1));
+
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
+					   "domain", domain, sizeof(domain)));
+	EXPECT_EQ(1, count_enforce_matches(buf, domain, 1, 1));
+
+	free(buf);
+}
+
+/*
+ * Verifies that TSYNC on a single-threaded process still concludes: one
+ * enforce_domain with complete=1 and process_wide=1.
+ */
+TEST_F(trace, enforce_tsync_single)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+	if (pid == 0)
+		_exit(child_enforce(0, LANDLOCK_RESTRICT_SELF_TSYNC));
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(1,
+		  tracefs_count_matches(buf, REGEX_CREATE_DOMAIN(TRACE_TASK)));
+	EXPECT_EQ(1, count_enforce_matches(buf, NULL, -1, -1));
+	EXPECT_EQ(1, count_enforce_matches(buf, NULL, 1, 1));
+
+	free(buf);
+}
+
+/*
+ * Verifies TSYNC across a multi-threaded process: one create_domain and
+ * exactly N+1 enforce_domain events (caller plus N siblings), of which exactly
+ * one is complete=1, all are process_wide=1, and all carry the same domain ID.
+ * These are order-independent field counts, evaluated after the syscall
+ * returns (the caller has waited on all siblings by then).
+ */
+TEST_F(trace, enforce_tsync_multithread)
+{
+	const int nsiblings = 3;
+	pid_t pid;
+	int status;
+	char *buf;
+	char domain[64];
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+	if (pid == 0)
+		_exit(child_enforce(nsiblings, LANDLOCK_RESTRICT_SELF_TSYNC));
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(1,
+		  tracefs_count_matches(buf, REGEX_CREATE_DOMAIN(TRACE_TASK)));
+	EXPECT_EQ(nsiblings + 1, count_enforce_matches(buf, NULL, -1, -1))
+	{
+		TH_LOG("Expected %d enforce_domain events\n%s", nsiblings + 1,
+		       buf);
+	}
+	EXPECT_EQ(1, count_enforce_matches(buf, NULL, 1, -1));
+	EXPECT_EQ(nsiblings, count_enforce_matches(buf, NULL, 0, -1));
+	EXPECT_EQ(nsiblings + 1, count_enforce_matches(buf, NULL, -1, 1));
+
+	ASSERT_EQ(0, tracefs_extract_field(buf, REGEX_CREATE_DOMAIN(TRACE_TASK),
+					   "domain", domain, sizeof(domain)));
+	EXPECT_EQ(nsiblings + 1, count_enforce_matches(buf, domain, -1, -1));
+
+	free(buf);
+}
+
+/*
+ * Verifies the disambiguation case: a non-TSYNC restrict_self on a
+ * multi-threaded process enforces only the caller, so the single enforce_domain
+ * has process_wide=0 (the siblings stay unconfined).
+ */
+TEST_F(trace, enforce_multithread_non_tsync)
+{
+	const int nsiblings = 3;
+	pid_t pid;
+	int status;
+	char *buf;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+	if (pid == 0)
+		_exit(child_enforce(nsiblings, 0));
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(1,
+		  tracefs_count_matches(buf, REGEX_CREATE_DOMAIN(TRACE_TASK)));
+	EXPECT_EQ(1, count_enforce_matches(buf, NULL, -1, -1));
+	EXPECT_EQ(1, count_enforce_matches(buf, NULL, 1, 0))
+	{
+		TH_LOG("Expected process_wide=0 enforce_domain event\n%s", buf);
+	}
+
+	free(buf);
+}
+
+/*
+ * Verifies that a single-threaded caller that is not the group leader (the
+ * leader called pthread_exit()) still reports process_wide=1, the case
+ * get_nr_threads() handles and the leader-relative thread_group_empty() would
+ * not.  SKIPs if the group cannot be reduced to one live thread.
+ */
+TEST_F(trace, enforce_single_non_leader)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+	if (pid == 0) {
+		pthread_t worker;
+
+		if (pthread_create(&worker, NULL, enforce_nonleader, NULL))
+			_exit(1);
+		/* Leader leaves; the worker becomes the only live thread. */
+		pthread_exit(NULL);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) == ENFORCE_SKIP_EXIT)
+		SKIP(return, "could not reduce group to a single thread");
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	buf = tracefs_read_buf();
+	ASSERT_NE(NULL, buf);
+
+	EXPECT_EQ(1,
+		  tracefs_count_matches(buf, REGEX_CREATE_DOMAIN(TRACE_TASK)));
+	EXPECT_EQ(1, count_enforce_matches(buf, NULL, 1, 1))
+	{
+		TH_LOG("Expected process_wide=1 for non-leader caller\n%s",
+		       buf);
+	}
+
+	free(buf);
+}
+
+/*
+ * Verifies the flags-only path (ruleset_fd == -1) creates no domain and emits
+ * neither create_domain nor enforce_domain, with and without TSYNC.
+ */
+TEST_F(trace, enforce_flags_only)
+{
+	pid_t pid;
+	int status;
+	char *buf;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+	if (pid == 0) {
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (landlock_restrict_self(
+			    -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF))
+			_exit(1);
+		if (landlock_restrict_self(
+			    -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+					LANDLOCK_RESTRICT_SELF_TSYNC))
+			_exit(1);
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
+	EXPECT_EQ(0,
+		  tracefs_count_matches(buf, REGEX_CREATE_DOMAIN(TRACE_TASK)));
+	EXPECT_EQ(0, count_enforce_matches(buf, NULL, -1, -1))
+	{
+		TH_LOG("No enforce_domain expected on flags-only path\n%s",
+		       buf);
+	}
+
+	free(buf);
+}
+
+static void enforce_nop_handler(int sig)
+{
+}
+
+struct abort_signaler_data {
+	pthread_t target;
+	volatile bool stop;
+};
+
+/* Hammers the target thread with SIGUSR1 to interrupt the TSYNC prepare wait. */
+static void *abort_signaler(void *arg)
+{
+	struct abort_signaler_data *data = arg;
+
+	while (!data->stop)
+		pthread_kill(data->target, SIGUSR1);
+	return NULL;
+}
+
+/*
+ * Child body for the abort test: with idle siblings and a signaler interrupting
+ * it, repeatedly enforces under TSYNC.  An interrupted attempt aborts its
+ * just-created domain (create_domain + free_domain, zero enforce_domain) while
+ * -ERESTARTNOINTR transparently restarts the syscall, so a successful retry may
+ * add its own full lifecycle.
+ */
+static int child_abort(int nsiblings, int attempts)
+{
+	pthread_t threads[16];
+	pthread_t signaler;
+	pthread_barrier_t barrier;
+	struct abort_signaler_data data = {};
+	struct sigaction sa = {};
+	int i;
+
+	sa.sa_handler = enforce_nop_handler;
+	if (sigaction(SIGUSR1, &sa, NULL))
+		return 1;
+
+	if (pthread_barrier_init(&barrier, NULL, nsiblings + 1))
+		return 1;
+	for (i = 0; i < nsiblings; i++)
+		if (pthread_create(&threads[i], NULL, enforce_idle, &barrier))
+			return 1;
+	pthread_barrier_wait(&barrier);
+
+	data.target = pthread_self();
+	if (pthread_create(&signaler, NULL, abort_signaler, &data))
+		return 1;
+
+	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	for (i = 0; i < attempts; i++) {
+		int ruleset_fd = build_enforce_ruleset();
+
+		if (ruleset_fd < 0)
+			break;
+		/* Ignore the result: an abort returns an error, that is fine. */
+		landlock_restrict_self(ruleset_fd,
+				       LANDLOCK_RESTRICT_SELF_TSYNC);
+		close(ruleset_fd);
+	}
+
+	data.stop = true;
+	pthread_join(signaler, NULL);
+	return 0;
+}
+
+/*
+ * Verifies the abort contract: a domain aborted by a thread-sync failure emits
+ * create_domain and free_domain but zero enforce_domain.  The signal race is
+ * probabilistic and -ERESTARTNOINTR may add a successful retry's lifecycle, so
+ * events are grouped by domain ID and the test SKIPs if no abort occurred.
+ */
+TEST_F(trace, enforce_abort)
+{
+	pid_t pid;
+	int status, retry;
+	char *buf = NULL;
+	const char *cursor;
+	char domain[64];
+	bool abort_found = false;
+
+	ASSERT_EQ(0, tracefs_clear_buf());
+
+	/* free_domain fires from a kworker, so widen the filter first. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	tracefs_clear_pid_filter();
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	pid = fork();
+	ASSERT_LE(0, pid);
+	if (pid == 0)
+		_exit(child_abort(8, 8));
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* Poll for the asynchronous free_domain events. */
+	for (retry = 0; retry < 10; retry++) {
+		usleep(100000);
+		set_cap(_metadata, CAP_SYS_ADMIN);
+		free(buf);
+		buf = tracefs_read_trace();
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+		ASSERT_NE(NULL, buf);
+	}
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, tracefs_set_pid_filter(getpid()));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/*
+	 * Walk every create_domain and look for one whose domain ID has zero
+	 * enforce_domain events but a matching free_domain: that is an aborted
+	 * domain (created, never enforced, freed).
+	 */
+	cursor = buf;
+	while (tracefs_extract_field(cursor, REGEX_CREATE_DOMAIN(TRACE_TASK),
+				     "domain", domain, sizeof(domain)) == 0) {
+		const char *cd, *nl;
+		char free_pattern[256];
+
+		if (count_enforce_matches(buf, domain, -1, -1) == 0) {
+			snprintf(
+				free_pattern, sizeof(free_pattern),
+				TRACE_PREFIX(
+					KWORKER_TASK) "landlock_free_domain: "
+						      "domain=%s denials=[0-9]\\+$",
+				domain);
+			if (tracefs_count_matches(buf, free_pattern) >= 1)
+				abort_found = true;
+		}
+
+		cd = strstr(cursor, "landlock_create_domain:");
+		if (!cd)
+			break;
+		nl = strchr(cd, '\n');
+		if (!nl)
+			break;
+		cursor = nl + 1;
+	}
+
+	if (!abort_found) {
+		free(buf);
+		SKIP(return, "signal race did not produce a thread-sync abort");
+	}
+
+	free(buf);
+}
+
 /*
  * The following tests are intentionally elided because the underlying kernel
  * mechanisms are already validated by audit tests:
-- 
2.54.0

