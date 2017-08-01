From: keescook@chromium.org (Kees Cook)
Date: Tue,  1 Aug 2017 12:16:25 -0700
Subject: [PATCH v5 02/15] exec: Correct comments about "point of no return"
In-Reply-To: <1501614998-62619-1-git-send-email-keescook@chromium.org>
References: <1501614998-62619-1-git-send-email-keescook@chromium.org>
Message-ID: <1501614998-62619-3-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In commit 221af7f87b97 ("Split 'flush_old_exec' into two functions"),
the comment about the point of no return should have stayed in
flush_old_exec() since it refers to "bprm->mm = NULL;" line, but prior
changes in commits c89681ed7d0e ("remove steal_locks()"), and
fd8328be874f ("sanitize handling of shared descriptor tables in failing
execve()") made it look like it meant the current->sas_ss_sp line instead.

The comment was referring to the fact that once bprm->mm is NULL, all
failures from a binfmt load_binary hook (e.g. load_elf_binary), will
get SEGV raised against current. Move this comment and expand the
explanation a bit, putting it above the assignment this time, and add
details about the true nature of "point of no return" being the call
to flush_old_exec() itself.

This also removes an erroneous commet about when credentials are being
installed. That has its own dedicated function, install_exec_creds(),
which carries a similar (and correct) comment, so remove the bogus comment
where installation is not actually happening.

Cc: David Howells <dhowells@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 fs/exec.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a0fff86269e4..26b98072be50 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1259,6 +1259,12 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 	perf_event_comm(tsk, exec);
 }
 
+/*
+ * Calling this is the point of no return. None of the failures will be
+ * seen by userspace since either the process is already taking a fatal
+ * signal (via de_thread() or coredump), or will have SEGV raised
+ * (after exec_mmap()) by search_binary_handlers (see below).
+ */
 int flush_old_exec(struct linux_binprm * bprm)
 {
 	int retval;
@@ -1286,7 +1292,13 @@ int flush_old_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
-	bprm->mm = NULL;		/* We're using it now */
+	/*
+	 * After clearing bprm->mm (to mark that current is using the
+	 * prepared mm now), we have nothing left of the original
+	 * process. If anything from here on returns an error, the check
+	 * in search_binary_handler() will SEGV current.
+	 */
+	bprm->mm = NULL;
 
 	set_fs(USER_DS);
 	current->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
@@ -1333,7 +1345,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 {
 	arch_pick_mmap_layout(current->mm);
 
-	/* This is the point of no return */
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
 	if (uid_eq(current_euid(), current_uid()) && gid_eq(current_egid(), current_gid()))
@@ -1351,7 +1362,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 */
 	current->mm->task_size = TASK_SIZE;
 
-	/* install the new credentials */
 	if (!uid_eq(bprm->cred->uid, current_euid()) ||
 	    !gid_eq(bprm->cred->gid, current_egid())) {
 		current->pdeath_signal = 0;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
