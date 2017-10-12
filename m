From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 11 Oct 2017 20:57:12 -0400
Subject: [PATCH GHAK16 V5 08/10] capabilities: invert logic for clarity
In-Reply-To: <cover.1507769413.git.rgb@redhat.com>
References: <cover.1507769413.git.rgb@redhat.com>
Message-ID: <f06e74e9a38b83ec273196bce727295b828c5870.1507769413.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The way the logic was presented, it was awkward to read and verify.
Invert the logic using DeMorgan's Law to be more easily able to read and
understand.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
Acked-by: Kees Cook <keescook@chromium.org>
Okay-ished-by: Paul Moore <paul@paul-moore.com>
---
 security/commoncap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index eac70e2..0bd94d3 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -782,10 +782,10 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
 	bool ret = false;
 
 	if (__cap_grew(effective, ambient, cred) &&
-	    (!__cap_full(effective, cred) ||
-	     !__is_eff(root, cred) ||
-	     !__is_real(root, cred) ||
-	     !root_privileged()))
+	    !(__cap_full(effective, cred) &&
+	      __is_eff(root, cred) &&
+	      __is_real(root, cred) &&
+	      root_privileged()))
 		ret = true;
 	return ret;
 }
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
