From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Jul 2017 00:57:26 -0700
Subject: [PATCH v2 3/8] exec: Use secureexec for setting dumpability
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
Message-ID: <1499673451-66160-4-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The examination of "current" to decide dumpability is wrong. This was a
check of and euid/uid (or egid/gid) mismatch in the existing process,
not the newly created one. This appears to stretch back into even the
"history.git" tree. Luckily, dumpability is later set in commit_creds().
In earlier kernel versions before creds existed, similar checks also
existed late in the exec flow, covering up the mistake as far back as I
could find.

The commit_creds() check examines differences of euid, uid, egid, gid,
and capabilities between the old and new creds. It would look like
the setup_new_exec() dumpability test could be entirely removed, but
strictly speaking, the secureexec test covers a different set of tests
than what commit_creds() checks for. So, fix this test to use secureexec,
which includes the same logical check (euid != uid || egid != gid),
but checks bprm->cred, not current->cred.

One would wonder if we need a security_commit_creds() LSM hook and to
move the existing checks in commit_creds() into commoncaps.c, which
would allow expanding the logic to all LSMs. Currently this doesn't
seem needed, though.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index b92e37fb53aa..3e519d4f0bd3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1346,7 +1346,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 
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
