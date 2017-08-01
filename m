From: keescook@chromium.org (Kees Cook)
Date: Tue,  1 Aug 2017 12:16:32 -0700
Subject: [PATCH v5 09/15] LSM: drop bprm_secureexec hook
In-Reply-To: <1501614998-62619-1-git-send-email-keescook@chromium.org>
References: <1501614998-62619-1-git-send-email-keescook@chromium.org>
Message-ID: <1501614998-62619-10-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This removes the bprm_secureexec hook since the logic has been folded into
the bprm_set_creds hook for all LSMs now.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 fs/exec.c                 |  2 --
 include/linux/lsm_hooks.h | 14 +++++---------
 include/linux/security.h  |  6 ------
 security/security.c       |  5 -----
 4 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1536bc4502cc..eca0cb550a06 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1343,8 +1343,6 @@ EXPORT_SYMBOL(would_dump);
 
 void setup_new_exec(struct linux_binprm * bprm)
 {
-	bprm->secureexec |= security_bprm_secureexec(bprm);
-
 	/*
 	 * Once here, prepare_binrpm() will not be called any more, so
 	 * the final state of setuid/setgid/fscaps can be merged into the
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3a90febadbe2..d1c7bef25691 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -43,7 +43,11 @@
  *	interpreters.  The hook can tell whether it has already been called by
  *	checking to see if @bprm->security is non-NULL.  If so, then the hook
  *	may decide either to retain the security information saved earlier or
- *	to replace it.
+ *	to replace it.  The hook must set @bprm->secureexec to 1 if a "secure
+ *	exec" has happened as a result of this hook call.  The flag is used to
+ *	indicate the need for a sanitized execution environment, and is also
+ *	passed in the ELF auxiliary table on the initial stack to indicate
+ *	whether libc should enable secure mode.
  *	@bprm contains the linux_binprm structure.
  *	Return 0 if the hook is successful and permission is granted.
  * @bprm_check_security:
@@ -71,12 +75,6 @@
  *	linux_binprm structure.  This hook is a good place to perform state
  *	changes on the process such as clearing out non-inheritable signal
  *	state.  This is called immediately after commit_creds().
- * @bprm_secureexec:
- *	Return a boolean value (0 or 1) indicating whether a "secure exec"
- *	is required.  The flag is passed in the auxiliary table
- *	on the initial stack to the ELF interpreter to indicate whether libc
- *	should enable secure mode.
- *	@bprm contains the linux_binprm structure.
  *
  * Security hooks for filesystem operations.
  *
@@ -1388,7 +1386,6 @@ union security_list_options {
 
 	int (*bprm_set_creds)(struct linux_binprm *bprm);
 	int (*bprm_check_security)(struct linux_binprm *bprm);
-	int (*bprm_secureexec)(struct linux_binprm *bprm);
 	void (*bprm_committing_creds)(struct linux_binprm *bprm);
 	void (*bprm_committed_creds)(struct linux_binprm *bprm);
 
@@ -1710,7 +1707,6 @@ struct security_hook_heads {
 	struct list_head vm_enough_memory;
 	struct list_head bprm_set_creds;
 	struct list_head bprm_check_security;
-	struct list_head bprm_secureexec;
 	struct list_head bprm_committing_creds;
 	struct list_head bprm_committed_creds;
 	struct list_head sb_alloc_security;
diff --git a/include/linux/security.h b/include/linux/security.h
index f89832ccdf55..974bb9b0996c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -231,7 +231,6 @@ int security_bprm_set_creds(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
-int security_bprm_secureexec(struct linux_binprm *bprm);
 int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, char *copy);
@@ -540,11 +539,6 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
 }
 
-static inline int security_bprm_secureexec(struct linux_binprm *bprm)
-{
-	return 0;
-}
-
 static inline int security_sb_alloc(struct super_block *sb)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 30132378d103..afc34f46c6c5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -351,11 +351,6 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
-int security_bprm_secureexec(struct linux_binprm *bprm)
-{
-	return call_int_hook(bprm_secureexec, 0, bprm);
-}
-
 int security_sb_alloc(struct super_block *sb)
 {
 	return call_int_hook(sb_alloc_security, 0, sb);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
