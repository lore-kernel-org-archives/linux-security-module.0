From: keescook@chromium.org (Kees Cook)
Date: Mon, 14 Aug 2017 13:52:20 -0700
Subject: [PATCH] selftests/seccomp: Add tests for basic ptrace actions
Message-ID: <20170814205220.GA60267@beast>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This adds tests for using only ptrace to perform syscall changes, just
to validate matching behavior between seccomp events and ptrace events.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'd like this to go through the seccomp tree, since it's part of a number
of other improvements. If I can get an Ack, that would be great. :) Thanks!
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 41 ++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 73f5ea6778ce..e61b963f011b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1262,6 +1262,13 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # error "Do not know how to find your architecture's registers and syscalls"
 #endif
 
+/* When the syscall return can't be changed, stub out the tests for it. */
+#ifdef SYSCALL_NUM_RET_SHARE_REG
+# define EXPECT_SYSCALL_RETURN(val, action)	EXPECT_EQ(-1, action)
+#else
+# define EXPECT_SYSCALL_RETURN(val, action)	EXPECT_EQ(val, action)
+#endif
+
 /* Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
  * architectures without HAVE_ARCH_TRACEHOOK (e.g. User-mode Linux).
  */
@@ -1357,7 +1364,7 @@ void change_syscall(struct __test_metadata *_metadata,
 #ifdef SYSCALL_NUM_RET_SHARE_REG
 		TH_LOG("Can't modify syscall return on this architecture");
 #else
-		regs.SYSCALL_RET = 1;
+		regs.SYSCALL_RET = EPERM;
 #endif
 
 #ifdef HAVE_GETREGS
@@ -1426,6 +1433,8 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 
 	if (nr == __NR_getpid)
 		change_syscall(_metadata, tracee, __NR_getppid);
+	if (nr == __NR_open)
+		change_syscall(_metadata, tracee, -1);
 }
 
 FIXTURE_DATA(TRACE_syscall) {
@@ -1480,6 +1489,28 @@ FIXTURE_TEARDOWN(TRACE_syscall)
 		free(self->prog.filter);
 }
 
+TEST_F(TRACE_syscall, ptrace_syscall_redirected)
+{
+	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
+	teardown_trace_fixture(_metadata, self->tracer);
+	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
+					   true);
+
+	/* Tracer will redirect getpid to getppid. */
+	EXPECT_NE(self->mypid, syscall(__NR_getpid));
+}
+
+TEST_F(TRACE_syscall, ptrace_syscall_dropped)
+{
+	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
+	teardown_trace_fixture(_metadata, self->tracer);
+	self->tracer = setup_trace_fixture(_metadata, tracer_ptrace, NULL,
+					   true);
+
+	/* Tracer should skip the open syscall, resulting in EPERM. */
+	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_open));
+}
+
 TEST_F(TRACE_syscall, syscall_allowed)
 {
 	long ret;
@@ -1520,13 +1551,8 @@ TEST_F(TRACE_syscall, syscall_dropped)
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
 	ASSERT_EQ(0, ret);
 
-#ifdef SYSCALL_NUM_RET_SHARE_REG
-	/* gettid has been skipped */
-	EXPECT_EQ(-1, syscall(__NR_gettid));
-#else
 	/* gettid has been skipped and an altered return value stored. */
-	EXPECT_EQ(1, syscall(__NR_gettid));
-#endif
+	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_gettid));
 	EXPECT_NE(self->mytid, syscall(__NR_gettid));
 }
 
@@ -1557,6 +1583,7 @@ TEST_F(TRACE_syscall, skip_after_RET_TRACE)
 	ASSERT_EQ(0, ret);
 
 	/* Tracer will redirect getpid to getppid, and we should see EPERM. */
+	errno = 0;
 	EXPECT_EQ(-1, syscall(__NR_getpid));
 	EXPECT_EQ(EPERM, errno);
 }
-- 
2.7.4


-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
