From: keescook@chromium.org (Kees Cook)
Date: Mon, 31 Jul 2017 16:51:32 -0700
Subject: [PATCH v4 14/15] exec: Use sane stack rlimit under secureexec
In-Reply-To: <1501545093-56634-1-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
Message-ID: <1501545093-56634-15-git-send-email-keescook@chromium.org>
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

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 fs/exec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 3ae8a40c587b..cddd2a2cbc1f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1329,6 +1329,18 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 */
 	bprm->secureexec |= bprm->cap_elevated;
 
+	if (bprm->secureexec) {
+		/*
+		 * For secureexec, reset the stack limit to sane default to
+		 * avoid bad behavior from the prior rlimits. This has to
+		 * happen before arch_pick_mmap_layout(), which examines
+		 * RLIMIT_STACK, but after the point of no return to avoid
+		 * needing to clean up the change on failure.
+		 */
+		if (current->signal->rlim[RLIMIT_STACK].rlim_cur > _STK_LIM)
+			current->signal->rlim[RLIMIT_STACK].rlim_cur = _STK_LIM;
+	}
+
 	arch_pick_mmap_layout(current->mm);
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
