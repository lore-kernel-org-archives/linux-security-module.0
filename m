From: keescook@chromium.org (Kees Cook)
Date: Fri,  7 Jul 2017 12:56:59 -0700
Subject: [PATCH 1/2] exec: Move security_bprm_secureexec() earlier
In-Reply-To: <1499457420-83038-1-git-send-email-keescook@chromium.org>
References: <1499457420-83038-1-git-send-email-keescook@chromium.org>
Message-ID: <1499457420-83038-2-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

There are several places where exec needs to know if a privilege-gain
has happened. Right now it only checks uid/euid differences, though
capabilities could have been elevated too. This moves the secureexec
check ahead of committing credentials, and retains the value for later
examination. A resulting redundant case of clearing pdeath_signal is
also removed from Smack, and commoncap is updated to examine bprm->cred
instead of current->cred.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c            |  2 +-
 fs/binfmt_elf_fdpic.c      |  2 +-
 fs/exec.c                  | 15 ++++++++++-----
 include/linux/binfmts.h    |  3 ++-
 include/linux/lsm_hooks.h  |  3 ++-
 security/commoncap.c       |  4 +---
 security/smack/smack_lsm.c | 15 ---------------
 7 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5075fd5c62c8..7f6ec4dac13d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -254,7 +254,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
 	NEW_AUX_ENT(AT_GID, from_kgid_munged(cred->user_ns, cred->gid));
 	NEW_AUX_ENT(AT_EGID, from_kgid_munged(cred->user_ns, cred->egid));
- 	NEW_AUX_ENT(AT_SECURE, security_bprm_secureexec(bprm));
+	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
 	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
 #ifdef ELF_HWCAP2
 	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index cf93a4fad012..5aa9199dfb13 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -650,7 +650,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
 	NEW_AUX_ENT(AT_GID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->gid));
 	NEW_AUX_ENT(AT_EGID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->egid));
-	NEW_AUX_ENT(AT_SECURE,	security_bprm_secureexec(bprm));
+	NEW_AUX_ENT(AT_SECURE,	bprm->secureexec);
 	NEW_AUX_ENT(AT_EXECFN,	bprm->exec);
 
 #ifdef ARCH_DLINFO
diff --git a/fs/exec.c b/fs/exec.c
index ddca2cf15f71..1e8d647d8e7c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1330,12 +1330,18 @@ EXPORT_SYMBOL(would_dump);
 
 void setup_new_exec(struct linux_binprm * bprm)
 {
+	/* This is the point of no return */
+
+	if (security_bprm_secureexec(bprm)) {
+		/* Record for AT_SECURE. */
+		bprm->secureexec = 1;
+	}
+
 	arch_pick_mmap_layout(current->mm);
 
-	/* This is the point of no return */
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
-	if (uid_eq(current_euid(), current_uid()) && gid_eq(current_egid(), current_gid()))
+	if (!bprm->secureexec)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 	else
 		set_dumpable(current->mm, suid_dumpable);
@@ -1350,9 +1356,8 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 */
 	current->mm->task_size = TASK_SIZE;
 
-	/* install the new credentials */
-	if (!uid_eq(bprm->cred->uid, current_euid()) ||
-	    !gid_eq(bprm->cred->gid, current_egid())) {
+	/* prepare to install the new credentials */
+	if (bprm->secureexec) {
 		current->pdeath_signal = 0;
 	} else {
 		if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 05488da3aee9..1afaa303cad0 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -27,9 +27,10 @@ struct linux_binprm {
 	unsigned int
 		cred_prepared:1,/* true if creds already prepared (multiple
 				 * preps happen for interpreters) */
-		cap_effective:1;/* true if has elevated effective capabilities,
+		cap_effective:1,/* true if has elevated effective capabilities,
 				 * false if not; except for init which inherits
 				 * its parent's caps anyway */
+		secureexec:1;	/* true when gaining privileges */
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 080f34e66017..d1bd24fb4a33 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -72,7 +72,8 @@
  *	Return a boolean value (0 or 1) indicating whether a "secure exec"
  *	is required.  The flag is passed in the auxiliary table
  *	on the initial stack to the ELF interpreter to indicate whether libc
- *	should enable secure mode.
+ *	should enable secure mode. Called before bprm_committing_creds(),
+ *	so pending credentials are in @bprm->cred.
  *	@bprm contains the linux_binprm structure.
  *
  * Security hooks for filesystem operations.
diff --git a/security/commoncap.c b/security/commoncap.c
index 7abebd782d5e..482d3aac2fc6 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -624,12 +624,10 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
  * Determine whether a secure execution is required, return 1 if it is, and 0
  * if it is not.
  *
- * The credentials have been committed by this point, and so are no longer
- * available through @bprm->cred.
  */
 int cap_bprm_secureexec(struct linux_binprm *bprm)
 {
-	const struct cred *cred = current_cred();
+	const struct cred *cred = bprm->cred;
 	kuid_t root_uid = make_kuid(cred->user_ns, 0);
 
 	if (!uid_eq(cred->uid, root_uid)) {
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 658f5d8c7e76..0c89afcb24c4 100644
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
