From: rgb@redhat.com (Richard Guy Briggs)
Date: Tue,  5 Sep 2017 02:46:08 -0400
Subject: [PATCH V4 08/10] capabilities: invert logic for clarity
In-Reply-To: <cover.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
Message-ID: <a5a0cb250461fe22fdb1ef250aaf35ecdbcbf1d4.1504591358.git.rgb@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The way the logic was presented, it was awkward to read and verify.
Invert the logic using DeMorgan's Law to be more easily able to read and
understand.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: James Morris <james.l.morris@oracle.com>
---
 security/commoncap.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index cf95d73..7e8041d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -544,10 +544,10 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
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
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
