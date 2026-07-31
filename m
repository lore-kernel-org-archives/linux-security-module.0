Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889F32B138
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464498; cv=none; b=HBfA2yucUpBqTKJ2ZuZBzEkOeraypFYTT1ERgGItSWELvLcBVF6/9uFbkHiol4/bfJrcK4bUMxMlXdpQmG2PBKXLFi7/Weew7upxrUxQVVFo1N0RO0EjbUjI1t9aHsfAPq3mJ560PbSKmGL649p84/Wy1SOXROzOyT1oC63K8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464498; c=relaxed/simple;
	bh=79WDRkozdtPmwEzHohevZNQHC9JEcAYV/9wC5vE8rxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlIt6IXctl2Csrp+yjeJRDtYxnEDYYM2mVD1CfQfQhipxUv0rymr1AGi51PkRN92xAis4ARRyguJ14aPxnpUOJZ6c9QxDpSFfvWdlrz0ViC5UsbfZ1Um6+XNm8DRW19m91Tw8v7glP9SKiNiyz+qBRp6ObvLpdXioS0pBRDWVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WupicYBQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WupicYBQ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81ed2a00f12so7252197b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464489; x=1786069289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gwkoVULYCNdZKy6/P+qRyiCnYdc6+SQZGzQ9Pl5KsVU=;
        b=WupicYBQR+MFEssGq+5oDBuybXWThbZGLiMqb8xJsbxlvzlWoyYAsFj+WsgV7pArDJ
         L1YLlSEmO4503spnE6luy395kkPhjlN0IyNCjecQHlZmjBMmLH7sh4XhrRblABaAJHJ7
         qUcbjy/x0VFE6DrwSOlpMVIKxp0FZKK+5eu+pm0NYD8I1XqPkeiknZ96O4DM0E1xJ618
         sRF9sbjufcJirNGlk9ioCHtpzoWc0wVUveg1nfJgaplnTEJiKOdhvDT0kYIk1x4TcjBl
         2MFAi+7zqHIPxLC3J5VvoMWjltaQ9MaYIEWs5M3tx1QU19as80grBjX4hnt5eaxRKBkY
         yw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464489; x=1786069289;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gwkoVULYCNdZKy6/P+qRyiCnYdc6+SQZGzQ9Pl5KsVU=;
        b=EkptqYuo3X75l5klSFLqBw5bktyvwKE1EHeQM4U87cKMsMJSXXMrSCf8Jtfpp7y8rA
         gEc7VB3Ofm3SKpKWM4qEQjvmI9QAbv1eHn34nxGUdYdyGhBLZuw5/MRCy+SKtMxknN0F
         jZChzacXaNEg/a8kUOetIYZ2X6hWc1B6+jQMMjf24YM2FvjXqX+KOGl/9AasNDfhCQ9y
         IWbg2f7qZMyDMQS88lwTnhlNxSTANlmSm/tc+li6R/E5t7STblIjs/d81PbYkpB4T8cz
         6ZzLUArvGiD7d/d746yEcpsvk+8B85brxQvd07gPlL31Jazq/DV7Z5G06XlMuR508/Dy
         i/tQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUaPq6TP0V28egoPqvU/9bNkshpsd7cARbyNFrguVUCQjnI1QRI5rY8Ec0KZNIUukIXUdHFBVtUBnv341PcuMvw9s4HtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUaHV9R5DCUJoTNaEAeZPkcJz3G66MekixQqoKCgwkzz8EJOw
	2IVefvHiAj8wTYFUaiXqco1Dr4zs9Cdwu+ey74wWPkAXqN/qAFRwi2LB
X-Gm-Gg: AR+sD101c/VjG7ck7CfMpXOKBiVSoll1IKuwgMuvdwj5wrgYPvuxNdwBpBrPmsTPGxT
	WEYzTbtBpkHV5FqArxURTcU6PqqqtA7TE+l3orTjT8ijwzw6qAArOSezHJhzklSPFzX5ayrEDu+
	xhnOEbZXDi/21lnsCsArVvLryMBndHrWDAXWUTfGgJNYZRs4x70maaH0Q4wFi5VP6Es+LGLd+UU
	fzB91yURNGXm/xcZxKxMziiS7UYWWgKDV3vKVUJAQKSXKKOH471pkY5ffJ27UH2c836LapLj3Gs
	qJKnVtXmUgcV1ykus32H7i00qybDyIuQ0fk+YPVJEEbmKOrD99VAg9E7CjlnYOopgqYMbOe5tor
	LgRes0GS4xpR0dxtCiRuRROkCbzi1H1DcSu3sxrgsBOKudfYhue4cgO6nWYkxG5gCLgJ9wYgCye
	/mrtIim5jTloEg9ojSP9Gf7eECTaAL+qkiV5yhJo1YdCDyDceZ/WHRY7KtaqglBw7tNPHro3Zpg
	0dcNIzdI8CJ/0L0deSPHA==
X-Received: by 2002:a05:690c:64c1:b0:7ff:1399:9317 with SMTP id 00721157ae682-81fcb970fbbmr616447b3.11.1785464489235;
        Thu, 30 Jul 2026 19:21:29 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:28 -0700 (PDT)
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
Subject: [PATCH bpf-next 11/13] selftests/bpf: Add tests for the Landlock policy kfuncs
Date: Thu, 30 Jul 2026 22:20:44 -0400
Message-ID: <20260731022047.189137-12-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Exercise the LSM policy kfuncs end to end and cover the verifier-time
restrictions enforced by the BPF-side kfunc filter.

The success flow mirrors the intended deployment: a syscall program,
run by the test runner through BPF_PROG_RUN, acquires the ruleset
created by the runner from its fd (resolved in the runner's own fd
table) and parks it in a map kptr slot; a program attached to the
sleepable bprm_creds_for_exec() hook takes it from the map, enforces
it on the monitored execution with bpf_landlock_restrict_binprm()
with flags configured per scenario, and puts it back for the next
execution.  The runner creates a real Landlock ruleset handling
LANDLOCK_ACCESS_FS_WRITE_FILE without any rule and checks that:

- a monitored child ends up landlocked (writing to a tmp file fails
  while a control execution succeeds);
- the audit log flags are accepted;
- LANDLOCK_RESTRICT_SELF_TSYNC is rejected with -EINVAL and leaves
  the execution unrestricted;
- a second bpf_landlock_restrict_binprm() call on the same execution
  replaces the previously staged domain instead of failing or
  stacking;
- a staged restriction is discarded when the execution fails after
  the bprm hook: the child execs an ENOEXEC file with a restriction
  staged, and after the failed execve(2) verifies that it is not
  landlocked;
- a negative fd resolved through the acquire kfunc returns NULL.

The failure programs check that verification rejects:
- a tracing program calling the kfuncs (LSM and syscall programs
  only),
- an LSM program calling the acquire kfunc (syscall programs only,
  where the ruleset fd is meaningful),
- a syscall program calling the enforcement kfunc (sleepable bprm
  LSM hooks only),
- an LSM program on a hook other than the sleepable bprm hooks,
- a non-sleepable LSM program on an allowed hook,
- a program leaking the acquired ruleset reference.

The test needs CONFIG_SECURITY_LANDLOCK and the landlock LSM enabled
in the test kernel; the runner skips if the Landlock syscalls are
unavailable.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/config.x86_64     |   2 +-
 .../bpf/prog_tests/lsm_policy_kfuncs.c        | 329 ++++++++++++++++++
 .../bpf/progs/lsm_policy_kfuncs_failure.c     | 100 ++++++
 .../bpf/progs/lsm_policy_kfuncs_success.c     | 107 ++++++
 5 files changed, 538 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_success.c

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
index 523e0d29bbd4..2c4d857f69f5 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -125,7 +125,7 @@ CONFIG_LEGACY_VSYSCALL_NONE=y
 CONFIG_LOG_BUF_SHIFT=21
 CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
 CONFIG_LOGO=y
-CONFIG_LSM="selinux,bpf,integrity"
+CONFIG_LSM="landlock,selinux,bpf,integrity"
 CONFIG_MAC_PARTITION=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_MCORE2=y
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
new file mode 100644
index 000000000000..c91929f98e88
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <test_progs.h>
+#include <errno.h>
+#include <linux/landlock.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "lsm_policy_kfuncs_success.skel.h"
+#include "lsm_policy_kfuncs_failure.skel.h"
+
+/* Fallbacks for old system headers. */
+#ifndef LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON
+#define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON (1U << 1)
+#endif
+#ifndef LANDLOCK_RESTRICT_SELF_TSYNC
+#define LANDLOCK_RESTRICT_SELF_TSYNC (1U << 3)
+#endif
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
+static void reset_prog_state(struct lsm_policy_kfuncs_success *skel)
+{
+	skel->bss->called = false;
+	skel->bss->no_ruleset = false;
+	skel->bss->restrict_err = -1;
+	skel->bss->restrict2_err = -1;
+	skel->bss->kfunc_flags = 0;
+	skel->bss->double_call = false;
+}
+
+/*
+ * Runs the syscall program that acquires the ruleset from
+ * @ruleset_fd, in the runner's fd table, and parks it in the map kptr
+ * slot for the LSM program.
+ */
+static int load_ruleset_into_map(struct lsm_policy_kfuncs_success *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.load_ruleset),
+				     &opts);
+	if (!ASSERT_OK(err, "load_ruleset_run"))
+		return -1;
+	if (!ASSERT_OK(opts.retval, "load_ruleset_retval"))
+		return -1;
+	ASSERT_TRUE(skel->bss->got_null_for_bad_fd, "bad_fd_null");
+	return 0;
+}
+
+/*
+ * Forks a child that execs "sh -c '<shell_cmd>'".  The monitored pid
+ * is only known, and can only be published to the BPF program, once
+ * the child exists: the child waits on a pipe until the parent has
+ * updated it.  Returns the child's exit status, or -1 on error.
+ */
+static int run_exec_child(struct lsm_policy_kfuncs_success *skel,
+			  bool monitored, const char *shell_cmd)
+{
+	int pipe_fds[2], status;
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
+		char *argv[] = { "sh", "-c", (char *)shell_cmd, NULL };
+
+		close(pipe_fds[1]);
+		read(pipe_fds[0], &buf, 1);
+		close(pipe_fds[0]);
+		execv("/bin/sh", argv);
+		exit(127);
+	}
+	close(pipe_fds[0]);
+	skel->bss->monitored_pid = monitored ? pid : 0;
+	write(pipe_fds[1], &buf, 1);
+	close(pipe_fds[1]);
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
+		return -1;
+	if (!ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		return -1;
+	return WEXITSTATUS(status);
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
+	struct lsm_policy_kfuncs_success *skel = NULL;
+	char tmp_path[] = "/tmp/lsm_policy_kfuncs_XXXXXX";
+	char cmd[256];
+	int ruleset_fd, tmp_fd, ret;
+
+	tmp_fd = mkstemp(tmp_path);
+	if (!ASSERT_GE(tmp_fd, 0, "mkstemp"))
+		return;
+	close(tmp_fd);
+
+	ruleset_fd = create_ruleset();
+	if (ruleset_fd < 0) {
+		if (errno == EOPNOTSUPP || errno == ENOSYS)
+			test__skip();
+		else
+			ASSERT_GE(ruleset_fd, 0, "landlock_create_ruleset");
+		goto out_unlink;
+	}
+
+	skel = lsm_policy_kfuncs_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+	skel->bss->ruleset_fd = ruleset_fd;
+
+	if (!ASSERT_OK(lsm_policy_kfuncs_success__attach(skel), "skel_attach"))
+		goto out;
+
+	if (load_ruleset_into_map(skel))
+		goto out;
+
+	/* Control: an unmonitored execution may write to the tmp file. */
+	reset_prog_state(skel);
+	format_child_cmd(cmd, sizeof(cmd), true, tmp_path);
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
+	format_child_cmd(cmd, sizeof(cmd), false, tmp_path);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "restricted_child_exit"))
+		goto out;
+	ASSERT_TRUE(skel->bss->called, "lsm_prog_called");
+	ASSERT_FALSE(skel->bss->no_ruleset, "ruleset_in_map");
+	ASSERT_EQ(skel->bss->restrict_err, 0, "restrict_binprm");
+
+	/* The audit log flags of landlock_restrict_self(2) apply too. */
+	reset_prog_state(skel);
+	skel->bss->kfunc_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
+	format_child_cmd(cmd, sizeof(cmd), false, tmp_path);
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
+	format_child_cmd(cmd, sizeof(cmd), true, tmp_path);
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
+	format_child_cmd(cmd, sizeof(cmd), false, tmp_path);
+	ret = run_exec_child(skel, true, cmd);
+	if (!ASSERT_EQ(ret, 0, "double_child_exit"))
+		goto out;
+	ASSERT_EQ(skel->bss->restrict_err, 0, "double_restrict_first");
+	ASSERT_EQ(skel->bss->restrict2_err, 0, "double_restrict_second");
+out:
+	lsm_policy_kfuncs_success__destroy(skel);
+	close(ruleset_fd);
+out_unlink:
+	unlink(tmp_path);
+}
+
+/*
+ * Checks that a staged restriction is discarded, and the staged
+ * domain released, when the execution fails after the bprm hook: the
+ * calling task must not end up landlocked.
+ */
+static void test_restrict_binprm_discard(void)
+{
+	struct lsm_policy_kfuncs_success *skel = NULL;
+	char tmp_path[] = "/tmp/lsm_policy_kfuncs_XXXXXX";
+	char garbage_path[] = "/tmp/lsm_policy_garbage_XXXXXX";
+	int ruleset_fd = -1, tmp_fd, garbage_fd, pipe_fds[2], status;
+	char buf = 0;
+	pid_t pid;
+
+	tmp_fd = mkstemp(tmp_path);
+	if (!ASSERT_GE(tmp_fd, 0, "mkstemp"))
+		return;
+	close(tmp_fd);
+
+	/*
+	 * An executable file that no binfmt handler accepts: the exec
+	 * fails with ENOEXEC after bprm_creds_for_exec() has run.
+	 */
+	garbage_fd = mkstemp(garbage_path);
+	if (!ASSERT_GE(garbage_fd, 0, "mkstemp_garbage"))
+		goto out_unlink;
+	if (!ASSERT_EQ(write(garbage_fd, "junk\n", 5), 5, "write_garbage")) {
+		close(garbage_fd);
+		goto out_unlink;
+	}
+	if (!ASSERT_OK(fchmod(garbage_fd, 0700), "chmod_garbage")) {
+		close(garbage_fd);
+		goto out_unlink;
+	}
+	close(garbage_fd);
+
+	ruleset_fd = create_ruleset();
+	if (ruleset_fd < 0) {
+		if (errno == EOPNOTSUPP || errno == ENOSYS)
+			test__skip();
+		else
+			ASSERT_GE(ruleset_fd, 0, "landlock_create_ruleset");
+		goto out_unlink;
+	}
+
+	skel = lsm_policy_kfuncs_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+	skel->bss->ruleset_fd = ruleset_fd;
+	reset_prog_state(skel);
+
+	if (!ASSERT_OK(lsm_policy_kfuncs_success__attach(skel), "skel_attach"))
+		goto out;
+
+	if (load_ruleset_into_map(skel))
+		goto out;
+
+	if (!ASSERT_OK(pipe(pipe_fds), "pipe"))
+		goto out;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
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
+		fd = open(tmp_path, O_WRONLY | O_TRUNC);
+		if (fd < 0)
+			exit(6);
+		close(fd);
+		exit(0);
+	}
+	close(pipe_fds[0]);
+	skel->bss->monitored_pid = pid;
+	write(pipe_fds[1], &buf, 1);
+	close(pipe_fds[1]);
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
+		goto out;
+	if (!ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		goto out;
+	ASSERT_EQ(WEXITSTATUS(status), 0, "discard_child_exit");
+	ASSERT_TRUE(skel->bss->called, "lsm_prog_called");
+	ASSERT_EQ(skel->bss->restrict_err, 0, "restrict_binprm");
+out:
+	lsm_policy_kfuncs_success__destroy(skel);
+	if (ruleset_fd >= 0)
+		close(ruleset_fd);
+out_unlink:
+	unlink(garbage_path);
+	unlink(tmp_path);
+}
+
+void test_lsm_policy_kfuncs(void)
+{
+	if (test__start_subtest("restrict_binprm"))
+		test_restrict_binprm();
+	if (test__start_subtest("restrict_binprm_discard"))
+		test_restrict_binprm_discard();
+	RUN_TESTS(lsm_policy_kfuncs_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
new file mode 100644
index 000000000000..0335db547040
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct bpf_landlock_ruleset;
+
+extern struct bpf_landlock_ruleset *
+bpf_landlock_get_ruleset_from_fd(int fd) __ksym;
+extern void
+bpf_landlock_put_ruleset(struct bpf_landlock_ruleset *ruleset) __ksym;
+extern int bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+					struct bpf_landlock_ruleset *ruleset,
+					u32 flags) __ksym;
+
+/*
+ * The LSM policy kfuncs are limited to LSM and syscall programs by
+ * the BPF-side kfunc filter: a tracing program calling one must fail
+ * verification.
+ */
+SEC("tp_btf/task_newtask")
+__failure __msg("calling kernel function bpf_landlock_get_ruleset_from_fd is not allowed")
+int BPF_PROG(tracing_prog, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_landlock_ruleset *ruleset;
+
+	ruleset = bpf_landlock_get_ruleset_from_fd(-1);
+	if (ruleset)
+		bpf_landlock_put_ruleset(ruleset);
+	return 0;
+}
+
+/*
+ * A ruleset fd is only meaningful in the fd table of the task that
+ * set the ruleset up: the acquire kfunc is exclusive to syscall
+ * programs and must be rejected in an LSM program, even on an
+ * allowed hook.
+ */
+SEC("lsm.s/bprm_creds_for_exec")
+__failure __msg("calling kernel function bpf_landlock_get_ruleset_from_fd is not allowed")
+int BPF_PROG(lsm_get, struct linux_binprm *bprm)
+{
+	struct bpf_landlock_ruleset *ruleset;
+
+	ruleset = bpf_landlock_get_ruleset_from_fd(-1);
+	if (ruleset)
+		bpf_landlock_put_ruleset(ruleset);
+	return 0;
+}
+
+/*
+ * Enforcement needs an execution to restrict: the enforcement kfunc
+ * is exclusive to the sleepable bprm LSM hooks and must be rejected
+ * in a syscall program.
+ */
+SEC("syscall")
+__failure __msg("calling kernel function bpf_landlock_restrict_binprm is not allowed")
+int syscall_restrict(void *ctx)
+{
+	return bpf_landlock_restrict_binprm(NULL, NULL, 0);
+}
+
+/*
+ * Any LSM attach point other than the sleepable bprm hooks must be
+ * rejected.
+ */
+SEC("lsm.s/file_open")
+__failure __msg("calling kernel function bpf_landlock_put_ruleset is not allowed")
+int BPF_PROG(wrong_hook, struct file *file)
+{
+	bpf_landlock_put_ruleset(NULL);
+	return 0;
+}
+
+/*
+ * The kfuncs may sleep: a non-sleepable program on an allowed hook
+ * must be rejected.
+ */
+SEC("lsm/bprm_creds_for_exec")
+__failure
+__msg("program must be sleepable to call sleepable kfunc bpf_landlock_put_ruleset")
+int BPF_PROG(nonsleepable_prog, struct linux_binprm *bprm)
+{
+	bpf_landlock_put_ruleset(NULL);
+	return 0;
+}
+
+/* An acquired ruleset reference must be released before returning. */
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int leak_ruleset(void *ctx)
+{
+	bpf_landlock_get_ruleset_from_fd(-1);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_success.c b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_success.c
new file mode 100644
index 000000000000..2107206ae144
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_success.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct bpf_landlock_ruleset;
+
+extern struct bpf_landlock_ruleset *
+bpf_landlock_get_ruleset_from_fd(int fd) __ksym;
+extern void
+bpf_landlock_put_ruleset(struct bpf_landlock_ruleset *ruleset) __ksym;
+extern int bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+					struct bpf_landlock_ruleset *ruleset,
+					u32 flags) __ksym;
+
+struct ruleset_slot {
+	struct bpf_landlock_ruleset __kptr *ruleset;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct ruleset_slot);
+} ruleset_map SEC(".maps");
+
+int monitored_pid;
+int ruleset_fd;
+u32 kfunc_flags;
+bool double_call;
+bool got_null_for_bad_fd;
+bool no_ruleset;
+int restrict_err;
+int restrict2_err;
+bool called;
+
+/*
+ * Runs in the test runner's context through BPF_PROG_RUN:
+ * @ruleset_fd is resolved in the runner's fd table and the acquired
+ * ruleset is handed to the LSM program through the map kptr slot.
+ */
+SEC("syscall")
+int load_ruleset(void *ctx)
+{
+	struct bpf_landlock_ruleset *ruleset, *old;
+	struct ruleset_slot *slot;
+	int key = 0;
+
+	slot = bpf_map_lookup_elem(&ruleset_map, &key);
+	if (!slot)
+		return 1;
+
+	/* A fd that is not a Landlock ruleset must resolve to NULL. */
+	ruleset = bpf_landlock_get_ruleset_from_fd(-1);
+	if (!ruleset)
+		got_null_for_bad_fd = true;
+	else
+		bpf_landlock_put_ruleset(ruleset);
+
+	ruleset = bpf_landlock_get_ruleset_from_fd(ruleset_fd);
+	if (!ruleset)
+		return 2;
+
+	old = bpf_kptr_xchg(&slot->ruleset, ruleset);
+	if (old)
+		bpf_landlock_put_ruleset(old);
+	return 0;
+}
+
+SEC("lsm.s/bprm_creds_for_exec")
+int BPF_PROG(restrict_exec, struct linux_binprm *bprm)
+{
+	struct bpf_landlock_ruleset *ruleset, *old;
+	struct ruleset_slot *slot;
+	int key = 0;
+
+	if (monitored_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	called = true;
+
+	slot = bpf_map_lookup_elem(&ruleset_map, &key);
+	if (!slot)
+		return 0;
+
+	ruleset = bpf_kptr_xchg(&slot->ruleset, NULL);
+	if (!ruleset) {
+		no_ruleset = true;
+		return 0;
+	}
+
+	restrict_err = bpf_landlock_restrict_binprm(bprm, ruleset, kfunc_flags);
+	if (double_call)
+		/* Replaces the domain staged by the first call. */
+		restrict2_err = bpf_landlock_restrict_binprm(bprm, ruleset,
+							     kfunc_flags);
+
+	/* Keep the ruleset for the next monitored execution. */
+	old = bpf_kptr_xchg(&slot->ruleset, ruleset);
+	if (old)
+		bpf_landlock_put_ruleset(old);
+	return 0;
+}
-- 
2.54.0

