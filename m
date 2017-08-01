From: keescook@chromium.org (Kees Cook)
Date: Tue,  1 Aug 2017 12:16:29 -0700
Subject: [PATCH v5 06/15] smack: Refactor to remove bprm_secureexec hook
In-Reply-To: <1501614998-62619-1-git-send-email-keescook@chromium.org>
References: <1501614998-62619-1-git-send-email-keescook@chromium.org>
Message-ID: <1501614998-62619-7-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The Smack bprm_secureexec hook can be merged with the bprm_set_creds
hook since it's dealing with the same information, and all of the details
are finalized during the first call to the bprm_set_creds hook via
prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
via bprm->called_set_creds).

Here, the test can just happen at the end of the bprm_set_creds hook,
and the bprm_secureexec hook can be dropped.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index db8e16ec223b..791d028207b9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -950,6 +950,10 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	bsp->smk_task = isp->smk_task;
 	bprm->per_clear |= PER_CLEAR_ON_SETID;
 
+	/* Decide if this is a secure exec. */
+	if (bsp->smk_task != bsp->smk_forked)
+		bprm->secureexec = 1;
+
 	return 0;
 }
 
@@ -967,22 +971,6 @@ static void smack_bprm_committing_creds(struct linux_binprm *bprm)
 		current->pdeath_signal = 0;
 }
 
-/**
- * smack_bprm_secureexec - Return the decision to use secureexec.
- * @bprm: binprm for exec
- *
- * Returns 0 on success.
- */
-static int smack_bprm_secureexec(struct linux_binprm *bprm)
-{
-	struct task_smack *tsp = current_security();
-
-	if (tsp->smk_task != tsp->smk_forked)
-		return 1;
-
-	return 0;
-}
-
 /*
  * Inode hooks
  */
@@ -4646,7 +4634,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),
 	LSM_HOOK_INIT(bprm_committing_creds, smack_bprm_committing_creds),
-	LSM_HOOK_INIT(bprm_secureexec, smack_bprm_secureexec),
 
 	LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
 	LSM_HOOK_INIT(inode_free_security, smack_inode_free_security),
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
