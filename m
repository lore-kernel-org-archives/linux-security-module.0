Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5A503BC5
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188456; cv=none; b=IISXlSTOf0R7LeZmXFrbzqOT1X6dg02TwyBlaXHtbajFUJkRbc7cJ5+Rv1JP6nm2qKi7IekykYM14GwvcyAXPvCz03AX5BHEh7upxD/dHGXXNjpPMbLKjO+8FhA1W6zToG+zYzUQMB4GeqK1fmPmep68igix6P7kl7NRtr0Qg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188456; c=relaxed/simple;
	bh=K8bob/0alFROS+/jtb/M2iJVIOfkWpfvlsD9YGEeofQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPfgrOTKxANcqVqqPnSljd0KL+cXzlAmxXMPEJuZcsNPnbv8eAV4elo2Fix6giwDia82Xrq/mvYlfzZRSDHrV6aOk4kjJnQage41bUzv2QwbsvSapMinNs0CCtJv43wgB7sq3dvqQcWtHvoh+OCs3/JRVmAdX6qXgicoIQvsYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9gmwejv; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9gmwejv"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-861f30636f9so23368817b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188451; x=1788793251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2QDe4ORKgIW9X7wqWVheNUlHrEl6DClMeGSUdm41tlw=;
        b=H9gmwejvzsKDmUCvpwmKwiHAc7WIRB1yYzH++qRpgMEKLlHNzMHoR8xbx0g7Zw8iiS
         6tDLX/U3gkKP99GzNnNR3LdMZSpbH8IwSxzxvS0BIct+e+n2xfuX3VGXoMs55JxZ8a2E
         UtjaPq28nrcrtuC2xUdWe+xfr6PWjQGiDUwkzSZTMjSAI6975NKqTIvjTaXtuG856laO
         slNcMoWn6KDd4Pp6N4fJ/cNQFw6/StnqPtrt5TKPETdJDjIusEeZPajgYFgOjmsLV/jX
         CJtxSlOqRM3T4w1vXCFUYoqP1JXTCbEyZOqVuHGhKpv0E0kWdIWDMh3CTeDxvc8VCD4P
         dorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188451; x=1788793251;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2QDe4ORKgIW9X7wqWVheNUlHrEl6DClMeGSUdm41tlw=;
        b=N73WnzAmZ5Nd3rLNgblvqroF3dkA4zBc6aV5zCPPMb1bf1JnLlXR1MPJZxDVuHaKYx
         7O6HUfS3da16Ndxm+Ch9OFA4eqXa3Wsi0UeUMMCdURkZBgC+Htm5eIkKDUgPzuOvdD8K
         BNdkpJiDg+fkySsjhS7yeeRu8ynmCBb3UuyB3k7LPtqJhjJvbEqt9nhSsslpaYKAUgOw
         w2iEYdXMEi7hyLcWQ/FJIAzuFOvfghfk9RpAz0tF4b8hN1eP5r/zGq6bCMejWBxVue3H
         MFq7M9oqzjJNUPuw1tHNiDgKTidDxZ5hUZJ5Itrh448HCmiA1DeryDjFxjCGxXXtJfcr
         RUjQ==
X-Forwarded-Encrypted: i=1; AKwUvByMcxmRkvhTaAQ57cwovQ2xizxXumunj6UGr3dojSKx5mo2EwEGMNh+KSyibZv908+IDgcAhS95HNUHqthTFzj1WL0/uhA=@vger.kernel.org
X-Gm-Message-State: AFuF++kDbnqHmSnnyO/m9+FPF3jeRBVpXC+meN8D+yrMTiZaAprui8Xg
	mkLAcKkJnR046LOzMa35c71hD2CBfo7A4yYxeO4aPRxNXtJO/2pb58Nl
X-Gm-Gg: AYBFou2qYKWnNoCnudxfqPXiUF5XW+aEhIMtaGDmSMsBQhVTNdX9mSarsXsXsQPIPMu
	DCIp3slWrfdh6qSPfs1jSxfFYIEvbWS9x3U+HSpBll2QGY9zXh/NBtrtkB+SoNm2A/qLvuhc2Al
	mxErgTRWWg/4QcOttQXAAoEwSeJrGtrSLm4or7+UViRH6WEwpV8/5XlHF4qSQKTBxEwrJXswCcb
	sf2KJbaNANcz1TZr9EsIjU/rOf4jJBypRzLvowiToiXavTSpWFmzBJBk4XK0nrGkhdxx3ctIi3y
	F+GjPN+tSkISBHBph3fsqShTR8sGI3kJ9ECUPLGZwSyYSJLX+m/FFenX5KycgPv/XMRRvCrOV34
	a3BJjBVrLsJKb/Jer/zKQ+ZIFuDBBbVm4fXblyRbvwTM3BcMS3F0mUj6ibs+ga8xfs91LIPln2+
	OKpqmPLZOayeDzH1SoAud1Fwcuj+Lu5vm/ICv9q6LSpdpglsgo6BwKtc6iGNxcFozSXJZxATC6a
	OO717JkdnuEkAkT1zwCRTo=
X-Received: by 2002:a05:690c:c3b7:b0:868:505e:b97a with SMTP id 00721157ae682-868505ed0ccmr9531957b3.10.1788188450680;
        Mon, 31 Aug 2026 08:00:50 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f6fc:b424:b1bb:6ff0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e58666e15sm53903827b3.0.2026.08.31.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:50 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 14/15] selftests/bpf: Test the LSM policy object kfuncs with Landlock
Date: Mon, 31 Aug 2026 10:58:56 -0400
Message-ID: <20260831145858.3869191-15-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831145858.3869191-1-utilityemal77@gmail.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Exercise the policy object kfuncs against an LSM actually providing
policy objects, complementing the LSM-independent tests of the
verifier-side and from_fd contracts.

The programs mirror the intended usage: a syscall program acquires a
Landlock ruleset with bpf_lsm_policy_from_fd() and parks it in a map
kptr field; an LSM program on bprm_creds_for_exec() loads the field
under bpf_rcu_read_lock(), takes its own reference with
bpf_lsm_policy_acquire(), and applies the ruleset with
bpf_lsm_policy_apply_bprm().  The prog_tests runner checks that:

- a monitored execution starts confined (a handled-but-not-allowed
  write fails) while an unmonitored one is untouched,
- two concurrent monitored executions are both restricted from the
  one shared map slot,
- the landlock_restrict_self(2) log flags are accepted while
  LANDLOCK_RESTRICT_SELF_TSYNC is rejected with -EINVAL and leaves
  the execution unrestricted,
- LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS makes the executed program
  start with no_new_privs set, while an execution without it stays
  non-nnp,
- a second apply call on the same execution replaces the staged
  restriction rather than failing,
- an execution failing past the bprm hook (ENOEXEC) discards the
  staged restriction and leaves the caller unconfined,
- the object's identity is BTF-readable off the trusted kptr: the
  LSM-private type tag is nonzero, and the lsmid is LSM_ID_LANDLOCK
  with the fd alone having routed the translation,
- the bprm application emits a single landlock_enforce_domain event,
  observed by a tp_btf program: complete == 1, process_wide == 1, and
  no_new_privs reporting the post-flag state.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/config.x86_64     |   2 +-
 .../bpf/prog_tests/lsm_policy_landlock.c      | 522 ++++++++++++++++++
 .../selftests/bpf/progs/lsm_policy_landlock.c | 142 +++++
 4 files changed, 666 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_landlock.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index ea7044f30adc..2fa734497461 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -120,6 +120,7 @@ CONFIG_SAMPLES=y
 CONFIG_SAMPLE_LIVEPATCH=m
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
+CONFIG_SECURITY_LANDLOCK=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TEST_BPF=m
 CONFIG_UDMABUF=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 42ad817b00ae..13ca4906b67f 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -126,7 +126,7 @@ CONFIG_LEGACY_VSYSCALL_NONE=y
 CONFIG_LOG_BUF_SHIFT=21
 CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
 CONFIG_LOGO=y
-CONFIG_LSM="selinux,bpf,integrity"
+CONFIG_LSM="landlock,selinux,bpf,integrity"
 CONFIG_MAC_PARTITION=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_MCORE2=y
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c b/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
new file mode 100644
index 000000000000..9270b39f5e3a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <test_progs.h>
+#include <errno.h>
+#include <linux/landlock.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "lsm_policy_landlock.skel.h"
+
+/* Fallbacks for old system headers. */
+#ifndef LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
+#define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON (1U << 1)
+#endif
+#ifndef LANDLOCK_RESTRICT_SELF_TSYNC
+#define LANDLOCK_RESTRICT_SELF_TSYNC (1U << 3)
+#endif
+#ifndef LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
+#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS (1U << 4)
+#endif
+#ifndef LSM_ID_LANDLOCK
+#define LSM_ID_LANDLOCK 110 /* uapi/linux/lsm.h */
+#endif
+
+struct policy_test_env {
+	struct lsm_policy_landlock *skel;
+	char tmp_path[64];
+	int tmp_fd;
+	int ruleset_fd;
+};
+
+static int create_ruleset(void)
+{
+	const struct landlock_ruleset_attr attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	};
+
+	return syscall(__NR_landlock_create_ruleset, &attr, sizeof(attr), 0);
+}
+
+static void reset_prog_state(struct lsm_policy_landlock *skel)
+{
+	skel->bss->called = false;
+	skel->bss->no_policy = false;
+	skel->bss->restrict_err = -1;
+	skel->bss->restrict2_err = -1;
+	skel->bss->restrict_ok_count = 0;
+	skel->bss->kfunc_flags = 0;
+	skel->bss->double_call = false;
+	skel->bss->monitored_pid = 0;
+	skel->bss->monitored_pid2 = 0;
+	skel->bss->enforce_domain_id = 0;
+	skel->bss->enforce_count = 0;
+	skel->bss->enforce_complete = false;
+	skel->bss->enforce_process_wide = false;
+	skel->bss->enforce_no_new_privs = false;
+}
+
+/*
+ * Runs the syscall program that acquires the ruleset from
+ * @ruleset_fd, in the runner's fd table, and parks it in the map kptr
+ * slot for the LSM program.
+ */
+static int load_ruleset_into_map(struct lsm_policy_landlock *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.load_policy),
+				     &opts);
+	if (!ASSERT_OK(err, "load_policy_run"))
+		return -1;
+	if (!ASSERT_OK(opts.retval, "load_policy_retval"))
+		return -1;
+	/* Landlock's type tag, read off the trusted kptr, is never 0. */
+	ASSERT_NEQ(skel->bss->policy_type, 0, "policy_type_nonzero");
+	/* The fd, not a kfunc argument, routed the call to Landlock. */
+	ASSERT_EQ(skel->bss->policy_lsmid, LSM_ID_LANDLOCK, "policy_lsmid");
+	return 0;
+}
+
+/*
+ * Creates the target tmp file and the ruleset, loads and attaches the
+ * skeleton, and parks the ruleset in the map.  Returns 0 on success;
+ * on failure (or skip), the caller must still run teardown_env().
+ */
+static int setup_env(struct policy_test_env *env)
+{
+	env->skel = NULL;
+	env->ruleset_fd = -1;
+	strcpy(env->tmp_path, "/tmp/lsm_policy_landlock_XXXXXX");
+	env->tmp_fd = mkstemp(env->tmp_path);
+	if (!ASSERT_GE(env->tmp_fd, 0, "mkstemp"))
+		return -1;
+
+	env->ruleset_fd = create_ruleset();
+	if (env->ruleset_fd < 0) {
+		if (errno == EOPNOTSUPP || errno == ENOSYS)
+			test__skip();
+		else
+			ASSERT_GE(env->ruleset_fd, 0,
+				  "landlock_create_ruleset");
+		return -1;
+	}
+
+	env->skel = lsm_policy_landlock__open_and_load();
+	if (!ASSERT_OK_PTR(env->skel, "skel_open_and_load"))
+		return -1;
+	env->skel->bss->ruleset_fd = env->ruleset_fd;
+	reset_prog_state(env->skel);
+
+	if (!ASSERT_OK(lsm_policy_landlock__attach(env->skel),
+		       "skel_attach"))
+		return -1;
+
+	return load_ruleset_into_map(env->skel);
+}
+
+static void teardown_env(struct policy_test_env *env)
+{
+	lsm_policy_landlock__destroy(env->skel);
+	if (env->ruleset_fd >= 0)
+		close(env->ruleset_fd);
+	if (env->tmp_fd >= 0)
+		close(env->tmp_fd);
+	unlink(env->tmp_path);
+}
+
+/*
+ * Forks a child that blocks on a pipe, then execs @path with @argv.
+ * Returns the child's pid, or -1 on error.  @release_fd receives the
+ * pipe's write end: release_exec_child() lets the child exec, after
+ * its pid has been published to the BPF program.
+ */
+static pid_t spawn_exec_child(const char *path, char *const argv[],
+			      int *release_fd)
+{
+	int pipe_fds[2];
+	char buf = 0;
+	pid_t pid;
+
+	if (!ASSERT_OK(pipe(pipe_fds), "pipe"))
+		return -1;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork")) {
+		close(pipe_fds[0]);
+		close(pipe_fds[1]);
+		return -1;
+	}
+	if (pid == 0) {
+		close(pipe_fds[1]);
+		read(pipe_fds[0], &buf, 1);
+		close(pipe_fds[0]);
+		execv(path, argv);
+		exit(127);
+	}
+	close(pipe_fds[0]);
+	*release_fd = pipe_fds[1];
+	return pid;
+}
+
+static void release_exec_child(int release_fd)
+{
+	char buf = 0;
+
+	write(release_fd, &buf, 1);
+	close(release_fd);
+}
+
+/* Returns the child's exit status, or -1 on error. */
+static int wait_exec_child(pid_t pid)
+{
+	int status;
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
+		return -1;
+	if (!ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		return -1;
+	return WEXITSTATUS(status);
+}
+
+static int run_exec_child(struct lsm_policy_landlock *skel,
+			  bool monitored, const char *shell_cmd)
+{
+	char *argv[] = { "sh", "-c", (char *)shell_cmd, NULL };
+	int release_fd;
+	pid_t pid;
+
+	pid = spawn_exec_child("/bin/sh", argv, &release_fd);
+	if (pid < 0)
+		return -1;
+	skel->bss->monitored_pid = monitored ? pid : 0;
+	release_exec_child(release_fd);
+	return wait_exec_child(pid);
+}
+
+/*
+ * Exit codes: 4 = unexpected write outcome, 0 = everything as
+ * expected.
+ */
+static void format_child_cmd(char *cmd, size_t len, bool expect_write_ok,
+			     const char *tmp_path)
+{
+	if (expect_write_ok)
+		snprintf(cmd, len, "echo x > %s || exit 4; exit 0", tmp_path);
+	else
+		snprintf(cmd, len,
+			 "if echo x > %s 2>/dev/null; then exit 4; fi; exit 0",
+			 tmp_path);
+}
+
+static void test_restrict_binprm(void)
+{
+	struct policy_test_env env;
+	struct lsm_policy_landlock *skel;
+	char cmd[256];
+	int ret;
+
+	if (setup_env(&env))
+		goto out;
+	skel = env.skel;
+
+	/* Control: an unmonitored execution may write to the tmp file. */
+	reset_prog_state(skel);
+	format_child_cmd(cmd, sizeof(cmd), true, env.tmp_path);
+	ret = run_exec_child(skel, false, cmd);
+	if (!ASSERT_EQ(ret, 0, "control_child_exit"))
+		goto out;
+	ASSERT_FALSE(skel->bss->called, "control_not_monitored");
+
+	/*
+	 * A monitored execution starts landlocked: the ruleset handles
+	 * LANDLOCK_ACCESS_FS_WRITE_FILE without any rule, so the write
+	 * must fail.
+	 */
+	reset_prog_state(skel);
+	format_child_cmd(cmd, sizeof(cmd), false, env.tmp_path);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "restricted_child_exit"))
+		goto out;
+	ASSERT_TRUE(skel->bss->called, "lsm_prog_called");
+	ASSERT_FALSE(skel->bss->no_policy, "ruleset_in_map");
+	ASSERT_EQ(skel->bss->restrict_err, 0, "restrict_binprm");
+
+	/* The audit log flags of landlock_restrict_self(2) apply too. */
+	reset_prog_state(skel);
+	skel->bss->kfunc_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+	format_child_cmd(cmd, sizeof(cmd), false, env.tmp_path);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "log_flags_child_exit"))
+		goto out;
+	ASSERT_EQ(skel->bss->restrict_err, 0, "log_flags_restrict_binprm");
+
+	/*
+	 * LANDLOCK_RESTRICT_SELF_TSYNC targets the calling threads, not
+	 * an execution: the kfunc must reject it and the execution must
+	 * stay unrestricted.
+	 */
+	reset_prog_state(skel);
+	skel->bss->kfunc_flags = LANDLOCK_RESTRICT_SELF_TSYNC;
+	format_child_cmd(cmd, sizeof(cmd), true, env.tmp_path);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "tsync_child_exit"))
+		goto out;
+	ASSERT_TRUE(skel->bss->called, "tsync_prog_called");
+	ASSERT_EQ(skel->bss->restrict_err, -EINVAL, "tsync_rejected");
+
+	/*
+	 * A second call on the same execution replaces the staged
+	 * domain (and releases the first one): the result is a single
+	 * restriction, not an error.
+	 */
+	reset_prog_state(skel);
+	skel->bss->double_call = true;
+	format_child_cmd(cmd, sizeof(cmd), false, env.tmp_path);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "double_child_exit"))
+		goto out;
+	ASSERT_EQ(skel->bss->restrict_err, 0, "double_restrict_first");
+	ASSERT_EQ(skel->bss->restrict2_err, 0, "double_restrict_second");
+out:
+	teardown_env(&env);
+}
+
+/*
+ * Two monitored executions, released together, must both be
+ * restricted from the one shared map kptr slot.
+ */
+static void test_restrict_binprm_concurrent(void)
+{
+	struct policy_test_env env;
+	char *argv[4];
+	int release_fds[2] = { -1, -1 };
+	pid_t pids[2] = { -1, -1 };
+	char cmd[256];
+	int i;
+
+	if (setup_env(&env))
+		goto out;
+
+	format_child_cmd(cmd, sizeof(cmd), false, env.tmp_path);
+	argv[0] = "sh";
+	argv[1] = "-c";
+	argv[2] = cmd;
+	argv[3] = NULL;
+
+	for (i = 0; i < 2; i++) {
+		pids[i] = spawn_exec_child("/bin/sh", argv, &release_fds[i]);
+		if (pids[i] < 0)
+			goto out_kill;
+	}
+
+	env.skel->bss->monitored_pid = pids[0];
+	env.skel->bss->monitored_pid2 = pids[1];
+
+	/* Releases both children only once both pids are published. */
+	for (i = 0; i < 2; i++) {
+		release_exec_child(release_fds[i]);
+		release_fds[i] = -1;
+	}
+
+	for (i = 0; i < 2; i++) {
+		ASSERT_EQ(wait_exec_child(pids[i]), 0,
+			  "concurrent_child_exit");
+		pids[i] = -1;
+	}
+
+	ASSERT_FALSE(env.skel->bss->no_policy, "ruleset_in_map");
+	ASSERT_EQ(env.skel->bss->restrict_ok_count, 2,
+		  "both_execs_restricted");
+
+out_kill:
+	for (i = 0; i < 2; i++) {
+		if (pids[i] > 0) {
+			kill(pids[i], SIGKILL);
+			waitpid(pids[i], NULL, 0);
+		}
+		if (release_fds[i] >= 0)
+			close(release_fds[i]);
+	}
+out:
+	teardown_env(&env);
+}
+
+/*
+ * Checks that a staged restriction is discarded, and the staged
+ * domain released, when the execution fails after the bprm hook: the
+ * calling task must not end up landlocked.
+ */
+static void test_restrict_binprm_discard(void)
+{
+	struct policy_test_env env;
+	char garbage_path[] = "/tmp/lsm_policy_garbage_XXXXXX";
+	int garbage_fd, pipe_fds[2];
+	char buf = 0;
+	pid_t pid;
+
+	if (setup_env(&env))
+		goto out;
+
+	/*
+	 * An executable file that no binfmt handler accepts: the exec
+	 * fails with ENOEXEC after bprm_creds_for_exec() has run.
+	 */
+	garbage_fd = mkstemp(garbage_path);
+	if (!ASSERT_GE(garbage_fd, 0, "mkstemp_garbage"))
+		goto out;
+	if (!ASSERT_EQ(write(garbage_fd, "junk\n", 5), 5, "write_garbage") ||
+	    !ASSERT_OK(fchmod(garbage_fd, 0700), "chmod_garbage")) {
+		close(garbage_fd);
+		goto out_unlink;
+	}
+	close(garbage_fd);
+
+	if (!ASSERT_OK(pipe(pipe_fds), "pipe"))
+		goto out_unlink;
+
+	/*
+	 * Cannot use spawn_exec_child(): the same process must test its
+	 * write access after the failed exec.
+	 */
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out_unlink;
+	if (pid == 0) {
+		char *argv[] = { "garbage", NULL };
+		int fd;
+
+		close(pipe_fds[1]);
+		read(pipe_fds[0], &buf, 1);
+		close(pipe_fds[0]);
+		execv(garbage_path, argv);
+		/*
+		 * The failed execution must leave no trace: no
+		 * Landlock domain, i.e. writing must still work
+		 * (exit 6).
+		 */
+		fd = open(env.tmp_path, O_WRONLY | O_TRUNC);
+		if (fd < 0)
+			exit(6);
+		close(fd);
+		exit(0);
+	}
+	close(pipe_fds[0]);
+	env.skel->bss->monitored_pid = pid;
+	release_exec_child(pipe_fds[1]);
+
+	ASSERT_EQ(wait_exec_child(pid), 0, "discard_child_exit");
+	ASSERT_TRUE(env.skel->bss->called, "lsm_prog_called");
+	ASSERT_EQ(env.skel->bss->restrict_err, 0, "restrict_binprm");
+out_unlink:
+	unlink(garbage_path);
+out:
+	teardown_env(&env);
+}
+
+/*
+ * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS makes the executed program start
+ * with no_new_privs set; without it, a non-nnp parent's execution
+ * stays non-nnp.  Child exit code 5: unexpected NoNewPrivs value.
+ */
+static void test_restrict_binprm_nnp(void)
+{
+	static const char nnp_cmd[] =
+		"grep -q '^NoNewPrivs:[[:space:]]*%d' /proc/self/status || exit 5";
+	struct policy_test_env env;
+	struct lsm_policy_landlock *skel;
+	char cmd[sizeof(nnp_cmd)];
+	int ret;
+
+	if (setup_env(&env))
+		goto out;
+	skel = env.skel;
+
+	if (!ASSERT_OK(prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0),
+		       "runner_not_nnp"))
+		goto out;
+
+	reset_prog_state(skel);
+	snprintf(cmd, sizeof(cmd), nnp_cmd, 0);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "no_flag_child_exit"))
+		goto out;
+	ASSERT_EQ(skel->bss->restrict_err, 0, "no_flag_restrict_binprm");
+
+	reset_prog_state(skel);
+	skel->bss->kfunc_flags = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
+	snprintf(cmd, sizeof(cmd), nnp_cmd, 1);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "nnp_flag_child_exit"))
+		goto out;
+	ASSERT_EQ(skel->bss->restrict_err, 0, "nnp_flag_restrict_binprm");
+out:
+	teardown_env(&env);
+}
+
+/*
+ * The bprm application emits landlock_enforce_domain, observed here by
+ * a tp_btf program: the single event concludes the operation
+ * (complete == 1), covers the whole post-de_thread() process
+ * (process_wide == 1), and reports the post-flag no_new_privs state.
+ */
+static void test_restrict_binprm_trace(void)
+{
+	struct policy_test_env env;
+	struct lsm_policy_landlock *skel;
+	char cmd[256];
+	int ret;
+
+	if (setup_env(&env))
+		goto out;
+	skel = env.skel;
+
+	if (!ASSERT_OK(prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0),
+		       "runner_not_nnp"))
+		goto out;
+
+	reset_prog_state(skel);
+	format_child_cmd(cmd, sizeof(cmd), false, env.tmp_path);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "trace_child_exit"))
+		goto out;
+	ASSERT_EQ(skel->bss->restrict_err, 0, "restrict_binprm");
+	ASSERT_EQ(skel->bss->enforce_count, 1, "one_enforce_event");
+	ASSERT_TRUE(skel->bss->enforce_complete, "enforce_complete");
+	ASSERT_TRUE(skel->bss->enforce_process_wide, "enforce_process_wide");
+	ASSERT_NEQ(skel->bss->enforce_domain_id, 0, "enforce_domain_id");
+	ASSERT_FALSE(skel->bss->enforce_no_new_privs, "enforce_nnp_off");
+
+	reset_prog_state(skel);
+	skel->bss->kfunc_flags = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
+	format_child_cmd(cmd, sizeof(cmd), false, env.tmp_path);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "trace_nnp_child_exit"))
+		goto out;
+	ASSERT_EQ(skel->bss->enforce_count, 1, "one_enforce_event_nnp");
+	ASSERT_TRUE(skel->bss->enforce_no_new_privs, "enforce_nnp_on");
+out:
+	teardown_env(&env);
+}
+
+void test_lsm_policy_landlock(void)
+{
+	if (test__start_subtest("restrict_binprm"))
+		test_restrict_binprm();
+	if (test__start_subtest("restrict_binprm_concurrent"))
+		test_restrict_binprm_concurrent();
+	if (test__start_subtest("restrict_binprm_discard"))
+		test_restrict_binprm_discard();
+	if (test__start_subtest("restrict_binprm_nnp"))
+		test_restrict_binprm_nnp();
+	if (test__start_subtest("restrict_binprm_trace"))
+		test_restrict_binprm_trace();
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_policy_landlock.c b/tools/testing/selftests/bpf/progs/lsm_policy_landlock.c
new file mode 100644
index 000000000000..231b24b87dd4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_policy_landlock.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern struct lsm_policy_object *
+bpf_lsm_policy_acquire(struct lsm_policy_object *object) __ksym;
+extern int bpf_lsm_policy_apply_bprm(struct lsm_policy_object *object,
+				     struct linux_binprm *bprm,
+				     u32 flags) __ksym;
+extern struct lsm_policy_object *
+bpf_lsm_policy_from_fd(int fd, u32 flags) __ksym;
+extern void bpf_lsm_policy_release(struct lsm_policy_object *object) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+struct policy_slot {
+	struct lsm_policy_object __kptr *object;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct policy_slot);
+} policy_map SEC(".maps");
+
+int monitored_pid;
+int monitored_pid2;
+int ruleset_fd;
+u32 kfunc_flags;
+bool double_call;
+u32 policy_type;
+u64 policy_lsmid;
+bool no_policy;
+int restrict_err;
+int restrict2_err;
+int restrict_ok_count;
+bool called;
+u64 enforce_domain_id;
+int enforce_count;
+bool enforce_complete;
+bool enforce_process_wide;
+bool enforce_no_new_privs;
+
+/*
+ * Runs in the test runner's context through BPF_PROG_RUN, where
+ * @ruleset_fd is meaningful.
+ */
+SEC("syscall")
+int load_policy(void *ctx)
+{
+	struct lsm_policy_object *object, *old;
+	struct policy_slot *slot;
+	int key = 0;
+
+	slot = bpf_map_lookup_elem(&policy_map, &key);
+	if (!slot)
+		return 1;
+
+	object = bpf_lsm_policy_from_fd(ruleset_fd, 0);
+	if (!object)
+		return 2;
+
+	/*
+	 * The object's identity is BTF-readable off the trusted kptr: a
+	 * program that expects a policy of one specific LSM can check
+	 * the lsmid the fd resolved to.
+	 */
+	policy_type = object->type;
+	policy_lsmid = object->lsmid;
+
+	old = bpf_kptr_xchg(&slot->object, object);
+	if (old)
+		bpf_lsm_policy_release(old);
+	return 0;
+}
+
+SEC("lsm.s/bprm_creds_for_exec")
+int BPF_PROG(restrict_exec, struct linux_binprm *bprm)
+{
+	struct lsm_policy_object *object;
+	struct policy_slot *slot;
+	int pid = bpf_get_current_pid_tgid() >> 32;
+	int key = 0;
+
+	if (pid != monitored_pid && pid != monitored_pid2)
+		return 0;
+
+	called = true;
+
+	slot = bpf_map_lookup_elem(&policy_map, &key);
+	if (!slot)
+		return 0;
+
+	/*
+	 * RCU load + acquire instead of bpf_kptr_xchg(): the slot is
+	 * never emptied, so concurrent executions can share it.
+	 */
+	bpf_rcu_read_lock();
+	object = slot->object;
+	if (object)
+		object = bpf_lsm_policy_acquire(object);
+	bpf_rcu_read_unlock();
+
+	if (!object) {
+		no_policy = true;
+		return 0;
+	}
+
+	restrict_err = bpf_lsm_policy_apply_bprm(object, bprm, kfunc_flags);
+	if (!restrict_err)
+		__sync_fetch_and_add(&restrict_ok_count, 1);
+	if (double_call)
+		/* Replaces the domain staged by the first call. */
+		restrict2_err = bpf_lsm_policy_apply_bprm(object, bprm,
+							  kfunc_flags);
+
+	bpf_lsm_policy_release(object);
+	return 0;
+}
+
+SEC("tp_btf/landlock_enforce_domain")
+int BPF_PROG(on_enforce_domain, struct landlock_domain *domain, bool complete,
+	     bool process_wide, bool no_new_privs)
+{
+	int pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != monitored_pid && pid != monitored_pid2)
+		return 0;
+
+	__sync_fetch_and_add(&enforce_count, 1);
+	enforce_domain_id = domain->hierarchy->id;
+	enforce_complete = complete;
+	enforce_process_wide = process_wide;
+	enforce_no_new_privs = no_new_privs;
+	return 0;
+}
-- 
2.55.0

