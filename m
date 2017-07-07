From: keescook@chromium.org (Kees Cook)
Date: Fri,  7 Jul 2017 12:57:00 -0700
Subject: [PATCH 2/2] exec: Use sane stack rlimit for setuid exec
In-Reply-To: <1499457420-83038-1-git-send-email-keescook@chromium.org>
References: <1499457420-83038-1-git-send-email-keescook@chromium.org>
Message-ID: <1499457420-83038-3-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Before memory layout selection and credentials having been updated,
reset stack rlimit to something sane for setuid execs to avoid having
the caller having control over memory layouts.

$ ulimit -s
8192
$ ulimit -s unlimited
$ /bin/sh -c 'ulimit -s'
unlimited
$ sudo /bin/sh -c 'ulimit -s'
8192

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 1e8d647d8e7c..2b072cf79f6d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1335,6 +1335,16 @@ void setup_new_exec(struct linux_binprm * bprm)
 	if (security_bprm_secureexec(bprm)) {
 		/* Record for AT_SECURE. */
 		bprm->secureexec = 1;
+
+		/*
+		 * If this is a setuid execution, reset the stack limit to
+		 * sane default to avoid bad behavior from the prior rlimits.
+		 * This has to happen before arch_pick_mmap_layout(), which
+		 * examines RLIMIT_STACK, but after the point of not return
+		 * to avoid cleaning up the change on failure.
+		 */
+		if (current->signal->rlim[RLIMIT_STACK].rlim_cur > _STK_LIM)
+			current->signal->rlim[RLIMIT_STACK].rlim_cur = _STK_LIM;
 	}
 
 	arch_pick_mmap_layout(current->mm);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
