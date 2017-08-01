From: keescook@chromium.org (Kees Cook)
Date: Tue,  1 Aug 2017 12:16:38 -0700
Subject: [PATCH v5 15/15] exec: Consolidate pdeath_signal clearing
In-Reply-To: <1501614998-62619-1-git-send-email-keescook@chromium.org>
References: <1501614998-62619-1-git-send-email-keescook@chromium.org>
Message-ID: <1501614998-62619-16-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Instead of an additional secureexec check for pdeath_signal, just move it
up into the initial secureexec test. Neither perf nor arch code touches
pdeath_signal, so the relocation shouldn't change anything.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 fs/exec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3235cbd85efa..01a9fb9d8ac3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1351,6 +1351,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 	bprm->secureexec |= bprm->cap_elevated;
 
 	if (bprm->secureexec) {
+		/* Make sure parent cannot signal privileged process. */
+		current->pdeath_signal = 0;
+
 		/*
 		 * For secureexec, reset the stack limit to sane default to
 		 * avoid bad behavior from the prior rlimits. This has to
@@ -1383,10 +1386,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 */
 	current->mm->task_size = TASK_SIZE;
 
-	if (bprm->secureexec) {
-		current->pdeath_signal = 0;
-	}
-
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
 	current->self_exec_id++;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
