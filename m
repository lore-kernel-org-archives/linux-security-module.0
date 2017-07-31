From: keescook@chromium.org (Kees Cook)
Date: Mon, 31 Jul 2017 16:51:28 -0700
Subject: [PATCH v4 10/15] exec: Use secureexec for setting dumpability
In-Reply-To: <1501545093-56634-1-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
Message-ID: <1501545093-56634-11-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The examination of "current" to decide dumpability is wrong. This was a
check of and euid/uid (or egid/gid) mismatch in the existing process,
not the newly created one. This appears to stretch back into even the
"history.git" tree. Luckily, dumpability is later set in commit_creds().
In earlier kernel versions before creds existed, similar checks also
existed late in the exec flow, covering up the mistake as far back as I
could find.

Note that because the commit_creds() check examines differences of euid,
uid, egid, gid, and capabilities between the old and new creds, it would
look like the setup_new_exec() dumpability test could be entirely removed.
However, the secureexec test may cover a different set of tests (specific
to the LSMs) than what commit_creds() checks for. So, fix this test to
use secureexec (the removed euid tests are redundant to the commoncap
secureexec checks now).

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index f0e8d25eba9f..f9997ea6414e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1333,7 +1333,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
-	if (uid_eq(current_euid(), current_uid()) && gid_eq(current_egid(), current_gid()))
+	if (!bprm->secureexec)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 	else
 		set_dumpable(current->mm, suid_dumpable);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
