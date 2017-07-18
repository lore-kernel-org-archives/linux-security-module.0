From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Jul 2017 15:25:28 -0700
Subject: [PATCH v3 07/15] commoncap: Move cap_elevated calculation into
	bprm_set_creds
In-Reply-To: <1500416736-49829-1-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
Message-ID: <1500416736-49829-8-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Instead of a separate function, open-code the cap_elevated test, which
lets us entirely remove bprm->cap_effective (to use the local "effective"
variable instead), and more accurately examine euid/egid changes via the
existing local "is_setid".

Cc: Serge Hallyn <serge@hallyn.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/binfmts.h |  3 ---
 security/commoncap.c    | 52 ++++++++++---------------------------------------
 2 files changed, 10 insertions(+), 45 deletions(-)

diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index a82f5edf23f9..b2c1563091e5 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -31,9 +31,6 @@ struct linux_binprm {
 		 * binfmt_script/misc).
 		 */
 		called_set_creds:1,
-		cap_effective:1,/* true if has elevated effective capabilities,
-				 * false if not; except for init which inherits
-				 * its parent's caps anyway */
 		/*
 		 * True if most recent call to the commoncaps bprm_set_creds
 		 * hook (due to multiple prepare_binprm() calls from the
diff --git a/security/commoncap.c b/security/commoncap.c
index abb6050c8083..d8e26fb9781d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -285,15 +285,6 @@ int cap_capset(struct cred *new,
 	return 0;
 }
 
-/*
- * Clear proposed capability sets for execve().
- */
-static inline void bprm_clear_caps(struct linux_binprm *bprm)
-{
-	cap_clear(bprm->cred->cap_permitted);
-	bprm->cap_effective = false;
-}
-
 /**
  * cap_inode_need_killpriv - Determine if inode change affects privileges
  * @dentry: The inode/dentry in being changed with change marked ATTR_KILL_PRIV
@@ -443,7 +434,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
 	int rc = 0;
 	struct cpu_vfs_cap_data vcaps;
 
-	bprm_clear_caps(bprm);
+	cap_clear(bprm->cred->cap_permitted);
 
 	if (!file_caps_enabled)
 		return 0;
@@ -476,13 +467,11 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
 
 out:
 	if (rc)
-		bprm_clear_caps(bprm);
+		cap_clear(bprm->cred->cap_permitted);
 
 	return rc;
 }
 
-static int is_secureexec(struct linux_binprm *bprm);
-
 /**
  * cap_bprm_set_creds - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
@@ -587,8 +576,6 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	if (WARN_ON(!cap_ambient_invariant_ok(new)))
 		return -EPERM;
 
-	bprm->cap_effective = effective;
-
 	/*
 	 * Audit candidate if current->cap_effective is set
 	 *
@@ -617,35 +604,16 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 		return -EPERM;
 
 	/* Check for privilege-elevated exec. */
-	bprm->cap_elevated = is_secureexec(bprm);
-
-	return 0;
-}
-
-/**
- * is_secureexec - Determine whether a secure execution is required
- * @bprm: The execution parameters
- *
- * Determine whether a secure execution is required, return 1 if it is, and 0
- * if it is not.
- *
- * The credentials have been committed by this point, and so are no longer
- * available through @bprm->cred.
- */
-static int is_secureexec(struct linux_binprm *bprm)
-{
-	const struct cred *cred = bprm->cred;
-	kuid_t root_uid = make_kuid(cred->user_ns, 0);
-
-	if (!uid_eq(cred->uid, root_uid)) {
-		if (bprm->cap_effective)
-			return 1;
-		if (!cap_issubset(cred->cap_permitted, cred->cap_ambient))
-			return 1;
+	bprm->cap_elevated = 0;
+	if (is_setid) {
+		bprm->cap_elevated = 1;
+	} else if (!uid_eq(new->uid, root_uid)) {
+		if (effective ||
+		    !cap_issubset(new->cap_permitted, new->cap_ambient))
+			bprm->cap_elevated = 1;
 	}
 
-	return (!uid_eq(cred->euid, cred->uid) ||
-		!gid_eq(cred->egid, cred->gid));
+	return 0;
 }
 
 /**
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
