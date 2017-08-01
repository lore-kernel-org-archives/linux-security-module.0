From: keescook@chromium.org (Kees Cook)
Date: Tue,  1 Aug 2017 12:16:24 -0700
Subject: [PATCH v5 01/15] exec: Rename bprm->cred_prepared to called_set_creds
In-Reply-To: <1501614998-62619-1-git-send-email-keescook@chromium.org>
References: <1501614998-62619-1-git-send-email-keescook@chromium.org>
Message-ID: <1501614998-62619-2-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The cred_prepared bprm flag has a misleading name. It has nothing to do
with the bprm_prepare_cred hook, and actually tracks if bprm_set_creds has
been called. Rename this flag and improve its comment.

Cc: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Casey Schaufler <casey@schaufler-ca.com>
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
index a1e6860b6f46..604a176df0c2 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -890,7 +890,7 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 	 * as we're past the point of no return and are dealing with shared
 	 * libraries.
 	 */
-	bprm.cred_prepared = 1;
+	bprm.called_set_creds = 1;
 
 	res = prepare_binprm(&bprm);
 
diff --git a/fs/exec.c b/fs/exec.c
index 62175cbcc801..a0fff86269e4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1548,7 +1548,7 @@ int prepare_binprm(struct linux_binprm *bprm)
 	retval = security_bprm_set_creds(bprm);
 	if (retval)
 		return retval;
-	bprm->cred_prepared = 1;
+	bprm->called_set_creds = 1;
 
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return kernel_read(bprm->file, 0, bprm->buf, BINPRM_BUF_SIZE);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 3ae9013eeaaa..9023e1d2d5cd 100644
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
index d0594446ae3f..67ec52cfc523 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -758,7 +758,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		file_inode(bprm->file)->i_mode
 	};
 
-	if (bprm->cred_prepared)
+	if (bprm->called_set_creds)
 		return 0;
 
 	ctx = cred_ctx(bprm->cred);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 33fd061305c4..1db40195d178 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2356,7 +2356,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 	/* SELinux context only depends on initial program or script and not
 	 * the script interpreter */
-	if (bprm->cred_prepared)
+	if (bprm->called_set_creds)
 		return 0;
 
 	old_tsec = current_security();
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 463af86812c7..db8e16ec223b 100644
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
