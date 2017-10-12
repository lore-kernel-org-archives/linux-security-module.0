From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 11 Oct 2017 20:57:11 -0400
Subject: [PATCH GHAK16 V5 07/10] capabilities: remove a layer of conditional
	logic
In-Reply-To: <cover.1507769413.git.rgb@redhat.com>
References: <cover.1507769413.git.rgb@redhat.com>
Message-ID: <ac9b6d4ce36cfd3faeb20165c193d4795ea5bddc.1507769413.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Remove a layer of conditional logic to make the use of conditions
easier to read and analyse.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Kees Cook <keescook@chromium.org>
Okay-ished-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index d7f0cbd..eac70e2 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -781,13 +781,12 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
 {
 	bool ret = false;
 
-	if (__cap_grew(effective, ambient, cred)) {
-		if (!__cap_full(effective, cred) ||
-		    !__is_eff(root, cred) || !__is_real(root, cred) ||
-		    !root_privileged()) {
-			ret = true;
-		}
-	}
+	if (__cap_grew(effective, ambient, cred) &&
+	    (!__cap_full(effective, cred) ||
+	     !__is_eff(root, cred) ||
+	     !__is_real(root, cred) ||
+	     !root_privileged()))
+		ret = true;
 	return ret;
 }
 
@@ -880,13 +879,11 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 
 	/* Check for privilege-elevated exec. */
 	bprm->cap_elevated = 0;
-	if (is_setid) {
+	if (is_setid ||
+	    (!__is_real(root_uid, new) &&
+	     (effective ||
+	      __cap_grew(permitted, ambient, new))))
 		bprm->cap_elevated = 1;
-	} else if (!__is_real(root_uid, new)) {
-		if (effective ||
-		    __cap_grew(permitted, ambient, new))
-			bprm->cap_elevated = 1;
-	}
 
 	return 0;
 }
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
