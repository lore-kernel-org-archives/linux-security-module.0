From: keescook@chromium.org (Kees Cook)
Date: Mon, 31 Jul 2017 16:51:19 -0700
Subject: [PATCH v4 01/15] exec: Rename bprm->cred_prepared to called_set_creds
In-Reply-To: <1501545093-56634-1-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
Message-ID: <1501545093-56634-2-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The cred_prepared bprm flag has a misleading name. It has nothing to do
with the bprm_prepare_cred hook, and actually tracks if bprm_set_creds has
been called. Rename this flag and improve its comment.

Cc: David Howells <dhowells@redhat.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <james.l.morris@oracle.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: John Johansen <john.johansen@canonical.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 fs/binfmt_flat.c           | 2 +-
 fs/exec.c                  | 2 +-
 include/linux/binfmts.h    | 8 ++++++--
 security/apparmor/domain.c | 2 +-
 security/selinux/hooks.c   | 2 +-
 security/smack/smack_lsm.c | 2 +-
 security/tomoyo/tomoyo.c   | 2 +-
 7 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 2edcefc0a294..a722530cc468 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -885,7 +885,7 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 	 * as we're past the point of no return and are dealing with shared
 	 * libraries.
 	 */
-	bprm.cred_prepared = 1;
+	bprm.called_set_creds = 1;
 
 	res = prepare_binprm(&bprm);
 
diff --git a/fs/exec.c b/fs/exec.c
index 72934df68471..cedae1620d2f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1527,7 +1527,7 @@ int prepare_binprm(struct linux_binprm *bprm)
 	retval = security_bprm_set_creds(bprm);
 	if (retval)
 		return retval;
-	bprm->cred_prepared = 1;
+	bprm->called_set_creds = 1;
 
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, 0, bprm->buf, BINPRM_BUF_SIZE);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 05488da3aee9..3cd98e8bc9dc 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -25,8 +25,12 @@ struct linux_binprm {
 	struct mm_struct *mm;
 	unsigned long p; /* current top of mem */
 	unsigned int
-		cred_prepared:1,/* true if creds already prepared (multiple
-				 * preps happen for interpreters) */
+		/*
+		 * True after the bprm_set_creds hook has been called once
+		 * (multiple calls can be made via prepare_binprm() for
+		 * binfmt_script/misc).
+		 */
+		called_set_creds:1,
 		cap_effective:1;/* true if has elevated effective capabilities,
 				 * false if not; except for init which inherits
 				 * its parent's caps anyway */
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 001e133a3c8c..878407e023e3 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -350,7 +350,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 	const char *name = NULL, *info = NULL;
 	int error = 0;
 
-	if (bprm->cred_prepared)
+	if (bprm->called_set_creds)
 		return 0;
 
 	ctx = cred_ctx(bprm->cred);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e67a526d1f30..5d4051541518 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2328,7 +2328,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
-	if (bprm->cred_prepared)
+	if (bprm->called_set_creds)
 		return 0;
 
 	old_tsec = current_security();
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 658f5d8c7e76..7d4b2e221124 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -917,7 +917,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	struct superblock_smack *sbsp;
 	int rc;
 
-	if (bprm->cred_prepared)
+	if (bprm->called_set_creds)
 		return 0;
 
 	isp = inode->i_security;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 130b4fa4f65f..d25b705360e0 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -76,7 +76,7 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 	 * Do only if this function is called for the first time of an execve
 	 * operation.
 	 */
-	if (bprm->cred_prepared)
+	if (bprm->called_set_creds)
 		return 0;
 #ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
 	/*
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
