From: keescook@chromium.org (Kees Cook)
Date: Mon, 31 Jul 2017 16:51:29 -0700
Subject: [PATCH v4 11/15] exec: Use secureexec for clearing pdeath_signal
In-Reply-To: <1501545093-56634-1-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
Message-ID: <1501545093-56634-12-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Like dumpability, clearing pdeath_signal happens both in setup_new_exec()
and later in commit_creds(). The test in setup_new_exec() is different
from all other privilege comparisons, though: it is checking the new cred
(bprm) uid vs the old cred (current) euid. This appears to be a bug,
introduced by commit a6f76f23d297 ("CRED: Make execve() take advantage of
copy-on-write credentials"):

-       if (bprm->e_uid != current_euid() ||
-           bprm->e_gid != current_egid()) {
-               set_dumpable(current->mm, suid_dumpable);
+       if (bprm->cred->uid != current_euid() ||
+           bprm->cred->gid != current_egid()) {

It was bprm euid vs current euid (and egids), but the effective got
dropped. Nothing in the exec flow changes bprm->cred->uid (nor gid).
The call traces are:

	prepare_bprm_creds()
	    prepare_exec_creds()
	        prepare_creds()
	            memcpy(new_creds, old_creds, ...)
	            security_prepare_creds() (unimplemented by commoncap)
	...
	prepare_binprm()
	    bprm_fill_uid()
	        resets euid/egid to current euid/egid
	        sets euid/egid on bprm based on set*id file bits
	    security_bprm_set_creds()
		cap_bprm_set_creds()
		        handle all caps-based manipulations

so this test is effectively a test of current_uid() vs current_euid(),
which is wrong, just like the prior dumpability tests were wrong.

The commit log says "Clear pdeath_signal and set dumpable on
certain circumstances that may not be covered by commit_creds()." This
may be meaning the earlier old euid vs new euid (and egid) test that
got changed.

Luckily, as with dumpability, this is all masked by commit_creds()
which performs old/new euid and egid tests and clears pdeath_signal.

And again, like dumpability, we should include LSM secureexec logic for
pdeath_signal clearing. For example, Smack goes out of its way to clear
pdeath_signal when it finds a secureexec condition.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 fs/exec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index f9997ea6414e..708a72f93320 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1348,8 +1348,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 */
 	current->mm->task_size = TASK_SIZE;
 
-	if (!uid_eq(bprm->cred->uid, current_euid()) ||
-	    !gid_eq(bprm->cred->gid, current_egid())) {
+	if (bprm->secureexec) {
 		current->pdeath_signal = 0;
 	} else {
 		if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
