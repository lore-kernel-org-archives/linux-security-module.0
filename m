From: rgb@redhat.com (Richard Guy Briggs)
Date: Tue,  5 Sep 2017 02:46:10 -0400
Subject: [PATCH V4 10/10] capabilities: audit log other surprising conditions
In-Reply-To: <cover.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
Message-ID: <f83b60bd7b011bd663d1ccdbad73608327af00e9.1504591358.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The existing condition tested for process effective capabilities set by
file attributes but intended to ignore the change if the result was
unsurprisingly an effective full set in the case root is special with a
setuid root executable file and we are root.

Stated again:
- When you execute a setuid root application, it is no surprise and
  expected that it got all capabilities, so we do not want capabilities
  recorded.
        if (pE_grew && !(pE_fullset && (eff_root || real_root) && root_priveleged) )

Now make sure we cover other cases:
- If something prevented a setuid root app getting all capabilities and
  it wound up with one capability only, then it is a surprise and should
  be logged.  When it is a setuid root file, we only want capabilities
  when the process does not get full capabilities..
        root_priveleged && setuid_root && !pE_fullset

- Similarly if a non-setuid program does pick up capabilities due to
  file system based capabilities, then we want to know what capabilities
  were picked up.  When it has file system based capabilities we want
  the capabilities.
        !is_setuid && (has_fcap && pP_gained)

- If it is a non-setuid file and it gets ambient capabilities, we want
  the capabilities.
        !is_setuid && pA_gained

- These last two are combined into one due to the common first parameter.

Related: https://github.com/linux-audit/audit-kernel/issues/16

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
---
 security/commoncap.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 759f3fa..afebfd3 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -528,7 +528,7 @@ static inline bool __is_setgid(struct cred *new, const struct cred *old)
 { return !gid_eq(new->egid, old->gid); }
 
 /*
- * Audit candidate if current->cap_effective is set
+ * 1) Audit candidate if current->cap_effective is set
  *
  * We do not bother to audit if 3 things are true:
  *   1) cap_effective has all caps
@@ -538,16 +538,31 @@ static inline bool __is_setgid(struct cred *new, const struct cred *old)
  *
  * Number 1 above might fail if you don't have a full bset, but I think
  * that is interesting information to audit.
+ *
+ * A number of other conditions require logging:
+ * 2) something prevented setuid root getting all caps
+ * 3) non-setuid root gets fcaps
+ * 4) non-setuid root gets ambient
  */
-static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
+static inline bool nonroot_raised_pE(struct cred *new, const struct cred *old,
+				     kuid_t root, bool has_fcap)
 {
 	bool ret = false;
 
-	if (__cap_grew(effective, ambient, cred) &&
-	    !(__cap_full(effective, cred) &&
-	      (__is_eff(root, cred) || __is_real(root, cred)) &&
-	      root_privileged()))
+	if ((__cap_grew(effective, ambient, new) &&
+	     !(__cap_full(effective, new) &&
+	       (__is_eff(root, new) || __is_real(root, new)) &&
+	       root_privileged())) ||
+	    (root_privileged() &&
+	     __is_suid(root, new) &&
+	     !__cap_full(effective, new)) ||
+	    (!__is_setuid(new, old) &&
+	     ((has_fcap &&
+	       __cap_gained(permitted, new, old)) ||
+	      __cap_gained(ambient, new, old))))
+
 		ret = true;
+
 	return ret;
 }
 
@@ -628,7 +643,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	if (WARN_ON(!cap_ambient_invariant_ok(new)))
 		return -EPERM;
 
-	if (nonroot_raised_pE(new, root_uid)) {
+	if (nonroot_raised_pE(new, old, root_uid, has_fcap)) {
 		ret = audit_log_bprm_fcaps(bprm, new, old);
 		if (ret < 0)
 			return ret;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
