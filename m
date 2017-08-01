From: keescook@chromium.org (Kees Cook)
Date: Tue,  1 Aug 2017 12:16:30 -0700
Subject: [PATCH v5 07/15] commoncap: Refactor to remove bprm_secureexec hook
In-Reply-To: <1501614998-62619-1-git-send-email-keescook@chromium.org>
References: <1501614998-62619-1-git-send-email-keescook@chromium.org>
Message-ID: <1501614998-62619-8-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The commoncap implementation of the bprm_secureexec hook is the only LSM
that depends on the final call to its bprm_set_creds hook (since it may
be called for multiple files, it ignores bprm->called_set_creds). As a
result, it cannot safely _clear_ bprm->secureexec since other LSMs may
have set it.  Instead, remove the bprm_secureexec hook by introducing a
new flag to bprm specific to commoncap: cap_elevated. This is similar to
cap_effective, but that is used for a specific subset of elevated
privileges, and exists solely to track state from bprm_set_creds to
bprm_secureexec. As such, it will be removed in the next patch.

Here, set the new bprm->cap_elevated flag when setuid/setgid has happened
from bprm_fill_uid() or fscapabilities have been prepared. This temporarily
moves the bprm_secureexec hook to a static inline. The helper will be
removed in the next patch; this makes the step easier to review and bisect,
since this does not introduce any changes to inputs nor outputs to the
"elevated privileges" calculation.

The new flag is merged with the bprm->secureexec flag in setup_new_exec()
since this marks the end of any further prepare_binprm() calls.

Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 fs/exec.c                |  7 +++++++
 include/linux/binfmts.h  |  7 +++++++
 include/linux/security.h |  3 +--
 security/commoncap.c     | 12 ++++++++----
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 0f361115c88f..1536bc4502cc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1345,6 +1345,13 @@ void setup_new_exec(struct linux_binprm * bprm)
 {
 	bprm->secureexec |= security_bprm_secureexec(bprm);
 
+	/*
+	 * Once here, prepare_binrpm() will not be called any more, so
+	 * the final state of setuid/setgid/fscaps can be merged into the
+	 * secureexec flag.
+	 */
+	bprm->secureexec |= bprm->cap_elevated;
+
 	arch_pick_mmap_layout(current->mm);
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 16838ba7ee75..213c61fa3780 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -35,6 +35,13 @@ struct linux_binprm {
 				 * false if not; except for init which inherits
 				 * its parent's caps anyway */
 		/*
+		 * True if most recent call to the commoncaps bprm_set_creds
+		 * hook (due to multiple prepare_binprm() calls from the
+		 * binfmt_script/misc handlers) resulted in elevated
+		 * privileges.
+		 */
+		cap_elevated:1,
+		/*
 		 * Set by bprm_set_creds hook to indicate a privilege-gaining
 		 * exec has happened. Used to sanitize execution environment
 		 * and to set AT_SECURE auxv for glibc.
diff --git a/include/linux/security.h b/include/linux/security.h
index b6ea1dc9cc9d..f89832ccdf55 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,7 +85,6 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 		      const kernel_cap_t *inheritable,
 		      const kernel_cap_t *permitted);
 extern int cap_bprm_set_creds(struct linux_binprm *bprm);
-extern int cap_bprm_secureexec(struct linux_binprm *bprm);
 extern int cap_inode_setxattr(struct dentry *dentry, const char *name,
 			      const void *value, size_t size, int flags);
 extern int cap_inode_removexattr(struct dentry *dentry, const char *name);
@@ -543,7 +542,7 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
 
 static inline int security_bprm_secureexec(struct linux_binprm *bprm)
 {
-	return cap_bprm_secureexec(bprm);
+	return 0;
 }
 
 static inline int security_sb_alloc(struct super_block *sb)
diff --git a/security/commoncap.c b/security/commoncap.c
index 7abebd782d5e..abb6050c8083 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -481,6 +481,8 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
 	return rc;
 }
 
+static int is_secureexec(struct linux_binprm *bprm);
+
 /**
  * cap_bprm_set_creds - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
@@ -614,11 +616,14 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	if (WARN_ON(!cap_ambient_invariant_ok(new)))
 		return -EPERM;
 
+	/* Check for privilege-elevated exec. */
+	bprm->cap_elevated = is_secureexec(bprm);
+
 	return 0;
 }
 
 /**
- * cap_bprm_secureexec - Determine whether a secure execution is required
+ * is_secureexec - Determine whether a secure execution is required
  * @bprm: The execution parameters
  *
  * Determine whether a secure execution is required, return 1 if it is, and 0
@@ -627,9 +632,9 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
  * The credentials have been committed by this point, and so are no longer
  * available through @bprm->cred.
  */
-int cap_bprm_secureexec(struct linux_binprm *bprm)
+static int is_secureexec(struct linux_binprm *bprm)
 {
-	const struct cred *cred = current_cred();
+	const struct cred *cred = bprm->cred;
 	kuid_t root_uid = make_kuid(cred->user_ns, 0);
 
 	if (!uid_eq(cred->uid, root_uid)) {
@@ -1079,7 +1084,6 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capget, cap_capget),
 	LSM_HOOK_INIT(capset, cap_capset),
 	LSM_HOOK_INIT(bprm_set_creds, cap_bprm_set_creds),
-	LSM_HOOK_INIT(bprm_secureexec, cap_bprm_secureexec),
 	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
 	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
 	LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
