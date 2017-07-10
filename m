From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Jul 2017 00:57:29 -0700
Subject: [PATCH v2 6/8] exec: Consolidate dumpability logic
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
Message-ID: <1499673451-66160-7-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Since it's already valid to set dumpability in the early part of
setup_new_exec(), we can consolidate the logic into a single place.
The BINPRM_FLAGS_ENFORCE_NONDUMP is set during would_dump() calls
before setup_new_exec(), so its test is safe to move as well.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d7bda5b60e7b..eeb8323977d1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1346,10 +1346,12 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
-	if (!bprm->secureexec)
-		set_dumpable(current->mm, SUID_DUMP_USER);
-	else
+	/* Figure out dumpability. */
+	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
+	    bprm->secureexec)
 		set_dumpable(current->mm, suid_dumpable);
+	else
+		set_dumpable(current->mm, SUID_DUMP_USER);
 
 	arch_setup_new_exec();
 	perf_event_exec();
@@ -1363,9 +1365,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	if (bprm->secureexec) {
 		current->pdeath_signal = 0;
-	} else {
-		if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP)
-			set_dumpable(current->mm, suid_dumpable);
 	}
 
 	/* An exec changes our domain. We are no longer part of the thread
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
