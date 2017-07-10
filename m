From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Jul 2017 00:57:31 -0700
Subject: [PATCH v2 8/8] exec: Use sane stack rlimit under secureexec
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
Message-ID: <1499673451-66160-9-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

For a secureexec, before memory layout selection has happened, reset the
stack rlimit to something sane to avoid the caller having control over
the resulting layouts.

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
index e0186db02f90..1e3463854a16 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1343,6 +1343,16 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 		/* Make sure parent cannot signal privileged process. */
 		current->pdeath_signal = 0;
+
+		/*
+		 * For secureexec, reset the stack limit to sane default to
+		 * avoid bad behavior from the prior rlimits. This has to
+		 * happen before arch_pick_mmap_layout(), which examines
+		 * RLIMIT_STACK, but after the point of no return to avoid
+		 * needing to clean up the change on failure.
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
