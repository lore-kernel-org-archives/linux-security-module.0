From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 11 Oct 2017 20:57:10 -0400
Subject: [PATCH GHAK16 V5 06/10] capabilities: move audit log decision to
	function
In-Reply-To: <cover.1507769413.git.rgb@redhat.com>
References: <cover.1507769413.git.rgb@redhat.com>
Message-ID: <9d2c4b37a1c7e6d9c58aff48037a0058cd2eff01.1507769413.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Move the audit log decision logic to its own function to isolate the
complexity in one place.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Kees Cook <keescook@chromium.org>
Okay-ished-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 421f743..d7f0cbd 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -765,6 +765,32 @@ static inline bool __is_setuid(struct cred *new, const struct cred *old)
 static inline bool __is_setgid(struct cred *new, const struct cred *old)
 { return !gid_eq(new->egid, old->gid); }
 
+/*
+ * Audit candidate if current->cap_effective is set
+ *
+ * We do not bother to audit if 3 things are true:
+ *   1) cap_effective has all caps
+ *   2) we are root
+ *   3) root is supposed to have all caps (SECURE_NOROOT)
+ * Since this is just a normal root execing a process.
+ *
+ * Number 1 above might fail if you don't have a full bset, but I think
+ * that is interesting information to audit.
+ */
+static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
+{
+	bool ret = false;
+
+	if (__cap_grew(effective, ambient, cred)) {
+		if (!__cap_full(effective, cred) ||
+		    !__is_eff(root, cred) || !__is_real(root, cred) ||
+		    !root_privileged()) {
+			ret = true;
+		}
+	}
+	return ret;
+}
+
 /**
  * cap_bprm_set_creds - Set up the proposed credentials for execve().
  * @bprm: The execution parameters, including the proposed creds
@@ -841,26 +867,10 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	if (WARN_ON(!cap_ambient_invariant_ok(new)))
 		return -EPERM;
 
-	/*
-	 * Audit candidate if current->cap_effective is set
-	 *
-	 * We do not bother to audit if 3 things are true:
-	 *   1) cap_effective has all caps
-	 *   2) we are root
-	 *   3) root is supposed to have all caps (SECURE_NOROOT)
-	 * Since this is just a normal root execing a process.
-	 *
-	 * Number 1 above might fail if you don't have a full bset, but I think
-	 * that is interesting information to audit.
-	 */
-	if (__cap_grew(effective, ambient, new)) {
-		if (!__cap_full(effective, new) ||
-		    !__is_eff(root_uid, new) || !__is_real(root_uid, new) ||
-		    !root_privileged()) {
-			ret = audit_log_bprm_fcaps(bprm, new, old);
-			if (ret < 0)
-				return ret;
-		}
+	if (nonroot_raised_pE(new, root_uid)) {
+		ret = audit_log_bprm_fcaps(bprm, new, old);
+		if (ret < 0)
+			return ret;
 	}
 
 	new->securebits &= ~issecure_mask(SECURE_KEEP_CAPS);
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
