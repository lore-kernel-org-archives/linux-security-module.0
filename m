From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 11 Oct 2017 20:57:09 -0400
Subject: [PATCH GHAK16 V5 05/10] capabilities: use intuitive names for id
	changes
In-Reply-To: <cover.1507769413.git.rgb@redhat.com>
References: <cover.1507769413.git.rgb@redhat.com>
Message-ID: <b4f35f618c9c937ae3bea4f3e1677f521115e874.1507769413.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Introduce a number of inlines to make the use of the negation of
uid_eq() easier to read and analyse.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Kees Cook <keescook@chromium.org>
Okay-ished-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 9b8a6e7..421f743 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -697,6 +697,15 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
 
 static inline bool root_privileged(void) { return !issecure(SECURE_NOROOT); }
 
+static inline bool __is_real(kuid_t uid, struct cred *cred)
+{ return uid_eq(cred->uid, uid); }
+
+static inline bool __is_eff(kuid_t uid, struct cred *cred)
+{ return uid_eq(cred->euid, uid); }
+
+static inline bool __is_suid(kuid_t uid, struct cred *cred)
+{ return !__is_real(uid, cred) && __is_eff(uid, cred); }
+
 /*
  * handle_privileged_root - Handle case of privileged root
  * @bprm: The execution parameters, including the proposed creds
@@ -722,7 +731,7 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
 	 * for a setuid root binary run by a non-root user.  Do set it
 	 * for a root user just to cause least surprise to an admin.
 	 */
-	if (has_fcap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
+	if (has_fcap && __is_suid(root_uid, new)) {
 		warn_setuid_and_fcaps_mixed(bprm->filename);
 		return;
 	}
@@ -731,7 +740,7 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
 	 * executables under compatibility mode, we override the
 	 * capability sets for the file.
 	 */
-	if (uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid)) {
+	if (__is_eff(root_uid, new) || __is_real(root_uid, new)) {
 		/* pP' = (cap_bset & ~0) | (pI & ~0) */
 		new->cap_permitted = cap_combine(old->cap_bset,
 						 old->cap_inheritable);
@@ -739,7 +748,7 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
 	/*
 	 * If only the real uid is 0, we do not set the effective bit.
 	 */
-	if (uid_eq(new->euid, root_uid))
+	if (__is_eff(root_uid, new))
 		*effective = true;
 }
 
@@ -749,6 +758,13 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
 	!cap_issubset(cred->cap_##target, cred->cap_##source)
 #define __cap_full(field, cred) \
 	cap_issubset(CAP_FULL_SET, cred->cap_##field)
+
+static inline bool __is_setuid(struct cred *new, const struct cred *old)
+{ return !uid_eq(new->euid, old->uid); }
+
+static inline bool __is_setgid(struct cred *new, const struct cred *old)
+{ return !gid_eq(new->egid, old->gid); }
+
 /**
  * cap_bprm_set_creds - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
@@ -785,7 +801,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	 *
 	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
 	 */
-	is_setid = !uid_eq(new->euid, old->uid) || !gid_eq(new->egid, old->gid);
+	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
 
 	if ((is_setid || __cap_gained(permitted, new, old)) &&
 	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
@@ -839,7 +855,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	 */
 	if (__cap_grew(effective, ambient, new)) {
 		if (!__cap_full(effective, new) ||
-		    !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
+		    !__is_eff(root_uid, new) || !__is_real(root_uid, new) ||
 		    !root_privileged()) {
 			ret = audit_log_bprm_fcaps(bprm, new, old);
 			if (ret < 0)
@@ -856,7 +872,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	bprm->cap_elevated = 0;
 	if (is_setid) {
 		bprm->cap_elevated = 1;
-	} else if (!uid_eq(new->uid, root_uid)) {
+	} else if (!__is_real(root_uid, new)) {
 		if (effective ||
 		    __cap_grew(permitted, ambient, new))
 			bprm->cap_elevated = 1;
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
