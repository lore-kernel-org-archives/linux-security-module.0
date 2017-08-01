From: keescook@chromium.org (Kees Cook)
Date: Tue,  1 Aug 2017 12:16:27 -0700
Subject: [PATCH v5 04/15] apparmor: Refactor to remove bprm_secureexec hook
In-Reply-To: <1501614998-62619-1-git-send-email-keescook@chromium.org>
References: <1501614998-62619-1-git-send-email-keescook@chromium.org>
Message-ID: <1501614998-62619-5-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The AppArmor bprm_secureexec hook can be merged with the bprm_set_creds
hook since it's dealing with the same information, and all of the details
are finalized during the first call to the bprm_set_creds hook via
prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
via bprm->called_set_creds).

Here, all the comments describe how secureexec is actually calculated
during bprm_set_creds, so this actually does it, drops the bprm flag that
was being used internally by AppArmor, and drops the bprm_secureexec hook.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 security/apparmor/domain.c         | 19 +------------------
 security/apparmor/include/domain.h |  1 -
 security/apparmor/include/file.h   |  3 ---
 security/apparmor/lsm.c            |  1 -
 4 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 67ec52cfc523..17a601c67b62 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -807,7 +807,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 			aa_label_printk(new, GFP_ATOMIC);
 			dbg_printk("\n");
 		}
-		bprm->unsafe |= AA_SECURE_X_NEEDED;
+		bprm->secureexec = 1;
 	}
 
 	if (label->proxy != new->proxy) {
@@ -843,23 +843,6 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 	goto done;
 }
 
-/**
- * apparmor_bprm_secureexec - determine if secureexec is needed
- * @bprm: binprm for exec  (NOT NULL)
- *
- * Returns: %1 if secureexec is needed else %0
- */
-int apparmor_bprm_secureexec(struct linux_binprm *bprm)
-{
-	/* the decision to use secure exec is computed in set_creds
-	 * and stored in bprm->unsafe.
-	 */
-	if (bprm->unsafe & AA_SECURE_X_NEEDED)
-		return 1;
-
-	return 0;
-}
-
 /*
  * Functions for self directed profile change
  */
diff --git a/security/apparmor/include/domain.h b/security/apparmor/include/domain.h
index bab5810b6e9a..24c5976d6143 100644
--- a/security/apparmor/include/domain.h
+++ b/security/apparmor/include/domain.h
@@ -30,7 +30,6 @@ struct aa_domain {
 #define AA_CHANGE_STACK 8
 
 int apparmor_bprm_set_creds(struct linux_binprm *bprm);
-int apparmor_bprm_secureexec(struct linux_binprm *bprm);
 
 void aa_free_domain_entries(struct aa_domain *domain);
 int aa_change_hat(const char *hats[], int count, u64 token, int flags);
diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 001e40073ff9..4c2c8ac8842f 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -101,9 +101,6 @@ static inline struct aa_label *aa_get_file_label(struct aa_file_ctx *ctx)
 #define AA_X_INHERIT		0x4000
 #define AA_X_UNCONFINED		0x8000
 
-/* AA_SECURE_X_NEEDED - is passed in the bprm->unsafe field */
-#define AA_SECURE_X_NEEDED	0x8000
-
 /* need to make conditional which ones are being set */
 struct path_cond {
 	kuid_t uid;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 867bcd154c7e..7a82c0f61452 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -694,7 +694,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_set_creds, apparmor_bprm_set_creds),
 	LSM_HOOK_INIT(bprm_committing_creds, apparmor_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, apparmor_bprm_committed_creds),
-	LSM_HOOK_INIT(bprm_secureexec, apparmor_bprm_secureexec),
 
 	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
