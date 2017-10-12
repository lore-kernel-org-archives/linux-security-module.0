From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 11 Oct 2017 20:57:07 -0400
Subject: [PATCH GHAK16 V5 03/10] capabilities: rename has_cap to has_fcap
In-Reply-To: <cover.1507769413.git.rgb@redhat.com>
References: <cover.1507769413.git.rgb@redhat.com>
Message-ID: <3522a9998eb48c7197e801b0d65552cc9f2c6097.1507769413.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Rename has_cap to has_fcap to clarify it applies to file capabilities
since the entire source file is about capabilities.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Kees Cook <keescook@chromium.org>
Okay-ished-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 4c9af6e..13661d3 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -536,7 +536,7 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
 static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
 					  struct linux_binprm *bprm,
 					  bool *effective,
-					  bool *has_cap)
+					  bool *has_fcap)
 {
 	struct cred *new = bprm->cred;
 	unsigned i;
@@ -546,7 +546,7 @@ static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
 		*effective = true;
 
 	if (caps->magic_etc & VFS_CAP_REVISION_MASK)
-		*has_cap = true;
+		*has_fcap = true;
 
 	CAP_FOR_EACH_U32(i) {
 		__u32 permitted = caps->permitted.cap[i];
@@ -652,7 +652,7 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
  * its xattrs and, if present, apply them to the proposed credentials being
  * constructed by execve().
  */
-static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_cap)
+static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_fcap)
 {
 	int rc = 0;
 	struct cpu_vfs_cap_data vcaps;
@@ -683,7 +683,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
 		goto out;
 	}
 
-	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_cap);
+	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_fcap);
 	if (rc == -EINVAL)
 		printk(KERN_NOTICE "%s: cap_from_disk returned %d for %s\n",
 		       __func__, rc, bprm->filename);
@@ -707,7 +707,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
  * set UID root and nothing is changed.  If we are root, cap_permitted is
  * updated.  If we have become set UID root, the effective bit is set.
  */
-static void handle_privileged_root(struct linux_binprm *bprm, bool has_cap,
+static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
 				   bool *effective, kuid_t root_uid)
 {
 	const struct cred *old = current_cred();
@@ -720,7 +720,7 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_cap,
 	 * for a setuid root binary run by a non-root user.  Do set it
 	 * for a root user just to cause least surprise to an admin.
 	 */
-	if (has_cap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
+	if (has_fcap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
 		warn_setuid_and_fcaps_mixed(bprm->filename);
 		return;
 	}
@@ -759,20 +759,20 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 {
 	const struct cred *old = current_cred();
 	struct cred *new = bprm->cred;
-	bool effective = false, has_cap = false, is_setid;
+	bool effective = false, has_fcap = false, is_setid;
 	int ret;
 	kuid_t root_uid;
 
 	if (WARN_ON(!cap_ambient_invariant_ok(old)))
 		return -EPERM;
 
-	ret = get_file_caps(bprm, &effective, &has_cap);
+	ret = get_file_caps(bprm, &effective, &has_fcap);
 	if (ret < 0)
 		return ret;
 
 	root_uid = make_kuid(new->user_ns, 0);
 
-	handle_privileged_root(bprm, has_cap, &effective, root_uid);
+	handle_privileged_root(bprm, has_fcap, &effective, root_uid);
 
 	/* if we have fs caps, clear dangerous personality flags */
 	if (__cap_gained(permitted, new, old))
@@ -802,7 +802,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	new->sgid = new->fsgid = new->egid;
 
 	/* File caps or setid cancels ambient. */
-	if (has_cap || is_setid)
+	if (has_fcap || is_setid)
 		cap_clear(new->cap_ambient);
 
 	/*
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
