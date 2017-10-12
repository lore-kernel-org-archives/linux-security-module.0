From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 11 Oct 2017 20:57:05 -0400
Subject: [PATCH GHAK16 V5 01/10] capabilities: factor out cap_bprm_set_creds
	privileged root
In-Reply-To: <cover.1507769413.git.rgb@redhat.com>
References: <cover.1507769413.git.rgb@redhat.com>
Message-ID: <97466101ce23bdecf0e3564bb5d3d0263935f8c8.1507769413.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Factor out the case of privileged root from the function
cap_bprm_set_creds() to make the latter easier to read and analyse.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Kees Cook <keescook@chromium.org>
Okay-ished-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c | 76 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index c25e0d2..be9bca5 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -695,6 +695,52 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
 	return rc;
 }
 
+/*
+ * handle_privileged_root - Handle case of privileged root
+ * @bprm: The execution parameters, including the proposed creds
+ * @has_fcap: Are any file capabilities set?
+ * @effective: Do we have effective root privilege?
+ * @root_uid: This namespace' root UID WRT initial USER namespace
+ *
+ * Handle the case where root is privileged and hasn't been neutered by
+ * SECURE_NOROOT.  If file capabilities are set, they won't be combined with
+ * set UID root and nothing is changed.  If we are root, cap_permitted is
+ * updated.  If we have become set UID root, the effective bit is set.
+ */
+static void handle_privileged_root(struct linux_binprm *bprm, bool has_cap,
+				   bool *effective, kuid_t root_uid)
+{
+	const struct cred *old = current_cred();
+	struct cred *new = bprm->cred;
+
+	if (issecure(SECURE_NOROOT))
+		return;
+	/*
+	 * If the legacy file capability is set, then don't set privs
+	 * for a setuid root binary run by a non-root user.  Do set it
+	 * for a root user just to cause least surprise to an admin.
+	 */
+	if (has_cap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
+		warn_setuid_and_fcaps_mixed(bprm->filename);
+		return;
+	}
+	/*
+	 * To support inheritance of root-permissions and suid-root
+	 * executables under compatibility mode, we override the
+	 * capability sets for the file.
+	 */
+	if (uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid)) {
+		/* pP' = (cap_bset & ~0) | (pI & ~0) */
+		new->cap_permitted = cap_combine(old->cap_bset,
+						 old->cap_inheritable);
+	}
+	/*
+	 * If only the real uid is 0, we do not set the effective bit.
+	 */
+	if (uid_eq(new->euid, root_uid))
+		*effective = true;
+}
+
 /**
  * cap_bprm_set_creds - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
@@ -707,46 +753,20 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 {
 	const struct cred *old = current_cred();
 	struct cred *new = bprm->cred;
-	bool effective, has_cap = false, is_setid;
+	bool effective = false, has_cap = false, is_setid;
 	int ret;
 	kuid_t root_uid;
 
 	if (WARN_ON(!cap_ambient_invariant_ok(old)))
 		return -EPERM;
 
-	effective = false;
 	ret = get_file_caps(bprm, &effective, &has_cap);
 	if (ret < 0)
 		return ret;
 
 	root_uid = make_kuid(new->user_ns, 0);
 
-	if (!issecure(SECURE_NOROOT)) {
-		/*
-		 * If the legacy file capability is set, then don't set privs
-		 * for a setuid root binary run by a non-root user.  Do set it
-		 * for a root user just to cause least surprise to an admin.
-		 */
-		if (has_cap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
-			warn_setuid_and_fcaps_mixed(bprm->filename);
-			goto skip;
-		}
-		/*
-		 * To support inheritance of root-permissions and suid-root
-		 * executables under compatibility mode, we override the
-		 * capability sets for the file.
-		 *
-		 * If only the real uid is 0, we do not set the effective bit.
-		 */
-		if (uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid)) {
-			/* pP' = (cap_bset & ~0) | (pI & ~0) */
-			new->cap_permitted = cap_combine(old->cap_bset,
-							 old->cap_inheritable);
-		}
-		if (uid_eq(new->euid, root_uid))
-			effective = true;
-	}
-skip:
+	handle_privileged_root(bprm, has_cap, &effective, root_uid);
 
 	/* if we have fs caps, clear dangerous personality flags */
 	if (!cap_issubset(new->cap_permitted, old->cap_permitted))
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
