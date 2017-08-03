From: keescook@chromium.org (Kees Cook)
Date: Wed,  2 Aug 2017 20:19:13 -0700
Subject: [PATCH 4/4] selftests/seccomp: Test thread vs process killing
In-Reply-To: <1501730353-46840-1-git-send-email-keescook@chromium.org>
References: <1501730353-46840-1-git-send-email-keescook@chromium.org>
Message-ID: <1501730353-46840-5-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

SECCOMP_RET_KILL is supposed to kill the current thread (and userspace
depends on this), so test for this, distinct from killing the entire
process. This also tests killing the entire process with the new
SECCOMP_FILTER_FLAG_KILL_PROCESS flag. (This also moves a bunch of
defines up earlier in the file to use them earlier.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 182 ++++++++++++++++++++------
 1 file changed, 141 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index ee78a53da5d1..68b9faf23ca6 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -87,6 +87,51 @@ struct seccomp_data {
 };
 #endif
 
+#ifndef __NR_seccomp
+# if defined(__i386__)
+#  define __NR_seccomp 354
+# elif defined(__x86_64__)
+#  define __NR_seccomp 317
+# elif defined(__arm__)
+#  define __NR_seccomp 383
+# elif defined(__aarch64__)
+#  define __NR_seccomp 277
+# elif defined(__hppa__)
+#  define __NR_seccomp 338
+# elif defined(__powerpc__)
+#  define __NR_seccomp 358
+# elif defined(__s390__)
+#  define __NR_seccomp 348
+# else
+#  warning "seccomp syscall number unknown for this architecture"
+#  define __NR_seccomp 0xffff
+# endif
+#endif
+
+#ifndef SECCOMP_SET_MODE_STRICT
+#define SECCOMP_SET_MODE_STRICT 0
+#endif
+
+#ifndef SECCOMP_SET_MODE_FILTER
+#define SECCOMP_SET_MODE_FILTER 1
+#endif
+
+#ifndef SECCOMP_FILTER_FLAG_TSYNC
+#define SECCOMP_FILTER_FLAG_TSYNC 1
+#endif
+
+#ifndef SECCOMP_FILTER_FLAG_KILL_PROCESS
+#define SECCOMP_FILTER_FLAG_KILL_PROCESS 2
+#endif
+
+#ifndef seccomp
+int seccomp(unsigned int op, unsigned int flags, void *args)
+{
+	errno = 0;
+	return syscall(__NR_seccomp, op, flags, args);
+}
+#endif
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
 #elif __BYTE_ORDER == __BIG_ENDIAN
@@ -520,6 +565,102 @@ TEST_SIGNAL(KILL_one_arg_six, SIGSYS)
 	close(fd);
 }
 
+/* This is a thread task to die via seccomp filter violation. */
+void *kill_thread(void *data)
+{
+	bool die = (bool)data;
+
+	if (die) {
+		prctl(PR_GET_SECCOMP, 0, 0, 0, 0);
+		return (void *)SIBLING_EXIT_FAILURE;
+	}
+
+	return (void *)SIBLING_EXIT_UNKILLED;
+}
+
+/* Prepare a thread that will kill itself or both of us. */
+void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
+{
+	pthread_t thread;
+	void *status;
+	unsigned int flags;
+	/* Kill only when calling __NR_prctl. */
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	flags = kill_process ? SECCOMP_FILTER_FLAG_KILL_PROCESS : 0;
+	ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog)) {
+		if (kill_process)
+			TH_LOG("Kernel does not support SECCOMP_FILTER_FLAG_KILL_PROCESS");
+		else
+			TH_LOG("Kernel does not support seccomp syscall");
+	}
+
+	/* Start a thread that will exit immediately. */
+	ASSERT_EQ(0, pthread_create(&thread, NULL, kill_thread, (void *)false));
+	ASSERT_EQ(0, pthread_join(thread, &status));
+	ASSERT_EQ(SIBLING_EXIT_UNKILLED, (unsigned long)status);
+
+	/* Start a thread that will die immediately. */
+	ASSERT_EQ(0, pthread_create(&thread, NULL, kill_thread, (void *)true));
+	ASSERT_EQ(0, pthread_join(thread, &status));
+	ASSERT_NE(SIBLING_EXIT_FAILURE, (unsigned long)status);
+
+	/* Only the thread died. Let parent know this thread didn't die. */
+	exit(42);
+}
+
+TEST(KILL_thread)
+{
+	int status;
+	pid_t child_pid;
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (child_pid == 0) {
+		kill_thread_or_group(_metadata, false);
+		_exit(38);
+	}
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+
+	/* If only the thread was killed, we'll see exit 42. */
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(42, WEXITSTATUS(status));
+}
+
+TEST(KILL_process)
+{
+	int status;
+	pid_t child_pid;
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (child_pid == 0) {
+		kill_thread_or_group(_metadata, true);
+		_exit(38);
+	}
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+
+	/* If the entire process was killed, we'll see SIGSYS. */
+	ASSERT_EQ(1, WIFSIGNALED(status));
+	ASSERT_EQ(SIGSYS, WTERMSIG(status));
+}
+
 /* TODO(wad) add 64-bit versus 32-bit arg tests. */
 TEST(arg_out_of_range)
 {
@@ -1675,47 +1816,6 @@ TEST_F_SIGNAL(TRACE_syscall, kill_after_ptrace, SIGSYS)
 	EXPECT_NE(self->mypid, syscall(__NR_getpid));
 }
 
-#ifndef __NR_seccomp
-# if defined(__i386__)
-#  define __NR_seccomp 354
-# elif defined(__x86_64__)
-#  define __NR_seccomp 317
-# elif defined(__arm__)
-#  define __NR_seccomp 383
-# elif defined(__aarch64__)
-#  define __NR_seccomp 277
-# elif defined(__hppa__)
-#  define __NR_seccomp 338
-# elif defined(__powerpc__)
-#  define __NR_seccomp 358
-# elif defined(__s390__)
-#  define __NR_seccomp 348
-# else
-#  warning "seccomp syscall number unknown for this architecture"
-#  define __NR_seccomp 0xffff
-# endif
-#endif
-
-#ifndef SECCOMP_SET_MODE_STRICT
-#define SECCOMP_SET_MODE_STRICT 0
-#endif
-
-#ifndef SECCOMP_SET_MODE_FILTER
-#define SECCOMP_SET_MODE_FILTER 1
-#endif
-
-#ifndef SECCOMP_FILTER_FLAG_TSYNC
-#define SECCOMP_FILTER_FLAG_TSYNC 1
-#endif
-
-#ifndef seccomp
-int seccomp(unsigned int op, unsigned int flags, void *args)
-{
-	errno = 0;
-	return syscall(__NR_seccomp, op, flags, args);
-}
-#endif
-
 TEST(seccomp_syscall)
 {
 	struct sock_filter filter[] = {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
