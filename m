From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Jul 2017 00:57:30 -0700
Subject: [PATCH v2 7/8] exec: Consolidate pdeath_signal clearing
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
Message-ID: <1499673451-66160-8-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Instead of an additional secureexec check for pdeath_signal, just move it
up into the initial secureexec test. Neither perf nor arch code touches
pdeath_signal, so the relocation shouldn't change anything.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index eeb8323977d1..e0186db02f90 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1340,6 +1340,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 	if (security_bprm_secureexec(bprm)) {
 		/* Record for AT_SECURE. */
 		bprm->secureexec = 1;
+
+		/* Make sure parent cannot signal privileged process. */
+		current->pdeath_signal = 0;
 	}
 
 	arch_pick_mmap_layout(current->mm);
@@ -1363,10 +1366,6 @@ void setup_new_exec(struct linux_binprm * bprm)
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
