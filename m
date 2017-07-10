From: keescook@chromium.org (Kees Cook)
Date: Mon, 10 Jul 2017 00:57:28 -0700
Subject: [PATCH v2 5/8] smack: Remove redundant pdeath_signal clearing
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
Message-ID: <1499673451-66160-6-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This removes the redundant pdeath_signal clearing in Smack: the check in
smack_bprm_committing_creds() matches the check in smack_bprm_secureexec(),
and since secureexec is now being checked for clearing pdeath_signal, this
is redundant to the common exec code.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/smack/smack_lsm.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 13cf9e66d5fe..4b10b782aecc 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -954,20 +954,6 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 }
 
 /**
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
-/**
  * smack_bprm_secureexec - Return the decision to use secureexec.
  * @bprm: binprm for exec
  *
@@ -4645,7 +4631,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_parse_opts_str, smack_parse_opts_str),
 
 	LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),
-	LSM_HOOK_INIT(bprm_committing_creds, smack_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_secureexec, smack_bprm_secureexec),
 
 	LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
