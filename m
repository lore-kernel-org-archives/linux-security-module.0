From: keescook@chromium.org (Kees Cook)
Date: Mon, 31 Jul 2017 16:51:23 -0700
Subject: [PATCH v4 05/15] selinux: Refactor to remove bprm_secureexec hook
In-Reply-To: <1501545093-56634-1-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
Message-ID: <1501545093-56634-6-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The SELinux bprm_secureexec hook can be merged with the bprm_set_creds
hook since it's dealing with the same information, and all of the details
are finalized during the first call to the bprm_set_creds hook via
prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
via bprm->called_set_creds).

Here, the test can just happen at the end of the bprm_set_creds hook,
and the bprm_secureexec hook can be dropped.

Cc: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Paul Moore <paul@paul-moore.com>
Tested-by: Paul Moore <paul@paul-moore.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 security/selinux/hooks.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5d4051541518..edbc1c76964e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2414,30 +2414,17 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 		/* Clear any possibly unsafe personality bits on exec: */
 		bprm->per_clear |= PER_CLEAR_ON_SETID;
-	}
-
-	return 0;
-}
-
-static int selinux_bprm_secureexec(struct linux_binprm *bprm)
-{
-	const struct task_security_struct *tsec = current_security();
-	u32 sid, osid;
-	int atsecure = 0;
-
-	sid = tsec->sid;
-	osid = tsec->osid;
 
-	if (osid != sid) {
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
 		   the two SIDs, i.e. ahp returns 0. */
-		atsecure = avc_has_perm(osid, sid,
-					SECCLASS_PROCESS,
-					PROCESS__NOATSECURE, NULL);
+		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
+				  SECCLASS_PROCESS, PROCESS__NOATSECURE,
+				  NULL);
+		bprm->secureexec |= !!rc;
 	}
 
-	return !!atsecure;
+	return 0;
 }
 
 static int match_file(const void *p, struct file *file, unsigned fd)
@@ -6152,7 +6139,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_set_creds, selinux_bprm_set_creds),
 	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
-	LSM_HOOK_INIT(bprm_secureexec, selinux_bprm_secureexec),
 
 	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
