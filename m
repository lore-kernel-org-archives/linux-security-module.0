From: keescook@chromium.org (Kees Cook)
Date: Mon, 31 Jul 2017 16:51:30 -0700
Subject: [PATCH v4 12/15] smack: Remove redundant pdeath_signal clearing
In-Reply-To: <1501545093-56634-1-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
Message-ID: <1501545093-56634-13-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This removes the redundant pdeath_signal clearing in Smack: the check in
smack_bprm_committing_creds() matches the check in smack_bprm_set_creds()
(which used to be in the now-removed smack_bprm_securexec() hook) and
since secureexec is now being checked for clearing pdeath_signal, this
is redundant to the common exec code.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 security/smack/smack_lsm.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4f1967be3d20..4e33c650b224 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -957,20 +957,6 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	return 0;
 }
 
-/**
- * smack_bprm_committing_creds - Prepare to install the new credentials
- * from bprm.
- *
- * @bprm: binprm for exec
- */
-static void smack_bprm_committing_creds(struct linux_binprm *bprm)
-{
-	struct task_smack *bsp = bprm->cred->security;
-
-	if (bsp->smk_task != bsp->smk_forked)
-		current->pdeath_signal = 0;
-}
-
 /*
  * Inode hooks
  */
@@ -4633,7 +4619,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_parse_opts_str, smack_parse_opts_str),
 
 	LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),
-	LSM_HOOK_INIT(bprm_committing_creds, smack_bprm_committing_creds),
 
 	LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
 	LSM_HOOK_INIT(inode_free_security, smack_inode_free_security),
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
